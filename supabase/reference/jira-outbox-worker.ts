import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "npm:@supabase/supabase-js@2";

type OutboxRow = {
  id: string;
  event_type: "approved_report" | "management_action" | "escalated_risk" | "project_update";
  aggregate_type: string;
  aggregate_id: string;
  payload: Record<string, unknown>;
  attempts: number;
  jira_issue_key: string | null;
};

const jsonHeaders = { "content-type": "application/json; charset=utf-8" };

function required(name: string): string {
  const value = Deno.env.get(name);
  if (!value) throw new Error(`Missing required secret: ${name}`);
  return value;
}

function timingSafeEqual(left: string, right: string): boolean {
  const a = new TextEncoder().encode(left);
  const b = new TextEncoder().encode(right);
  if (a.length !== b.length) return false;
  let difference = 0;
  for (let index = 0; index < a.length; index += 1) difference |= a[index] ^ b[index];
  return difference === 0;
}

function compact(values: Array<string | null | undefined>): string[] {
  return values.map((value) => String(value || "").trim()).filter(Boolean);
}

function slugLabel(value: unknown): string {
  return String(value || "department")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "")
    .slice(0, 80);
}

function textNode(text: string) {
  return { type: "text", text };
}

function paragraph(text: string) {
  return { type: "paragraph", content: [textNode(text)] };
}

function heading(text: string, level = 2) {
  return { type: "heading", attrs: { level }, content: [textNode(text)] };
}

function adfFromSections(title: string, sections: Array<[string, unknown]>) {
  const content: Array<Record<string, unknown>> = [heading(title, 1)];
  for (const [label, raw] of sections) {
    const value = String(raw || "").trim();
    if (!value) continue;
    content.push(heading(label, 2));
    for (const block of value.split(/\n\s*\n/)) content.push(paragraph(block.trim()));
  }
  content.push(paragraph("Source: AMFCC Unified Operations Platform. Detailed operational records remain in Supabase."));
  return { type: "doc", version: 1, content };
}

function metricsText(payload: Record<string, unknown>): string {
  const metrics = Array.isArray(payload.metrics) ? payload.metrics as Array<Record<string, unknown>> : [];
  return metrics.map((metric) => {
    const name = String(metric.name || "Metric");
    const unit = String(metric.unit || "").trim();
    const target = metric.target ?? "not set";
    const actual = metric.actual ?? "not set";
    const status = String(metric.status || "not set");
    return `${name}: target ${target}${unit ? ` ${unit}` : ""}; actual ${actual}${unit ? ` ${unit}` : ""}; ${status}`;
  }).join("\n");
}

function reportFields(payload: Record<string, unknown>, projectKey: string) {
  const reportType = String(payload.report_type || "weekly").toLowerCase();
  const department = String(payload.department_name || "Department");
  const periodStart = String(payload.period_start || "");
  const periodEnd = String(payload.period_end || "");
  const reportDate = String(payload.report_date || periodEnd || "");
  const metrics = metricsText(payload);
  const labels = compact([
    "amfcc-operations",
    "operations-update-submission",
    "approved-report",
    `${reportType}-report`,
    `department-${slugLabel(payload.department_slug || department)}`,
  ]);
  const submissionOption = reportType === "daily" ? "10155" : reportType === "monthly" ? "10044" : "10039";
  const fields: Record<string, unknown> = {
    project: { key: projectKey },
    issuetype: { name: "Task" },
    summary: `[${reportType.toUpperCase()} REPORT] ${department} | ${periodStart} to ${periodEnd}`.slice(0, 255),
    description: adfFromSections(`${department} ${reportType} report`, [
      ["Period", `${periodStart} to ${periodEnd}`],
      ["Summary", payload.summary],
      ["Work completed", payload.work_completed],
      ["Work still open", payload.work_open],
      ["Challenges", payload.challenges],
      ["Action required", payload.action_required],
      ["Risks", payload.risks],
      ["Support required", payload.support_required],
      ["Stock and equipment", payload.stock_equipment],
      ["Next period plan", payload.next_period_plan],
      ["KPI summary", metrics],
    ]),
    labels,
    customfield_10110: { id: "10020" },
    customfield_10113: { id: submissionOption },
    customfield_10232: reportDate || null,
    customfield_10253: `${periodStart} to ${periodEnd}`,
    customfield_10230: metrics || null,
    customfield_10228: compact([
      String(payload.challenges || ""),
      String(payload.action_required || ""),
      String(payload.support_required || ""),
    ]).join("\n\n") || null,
    customfield_10229: String(payload.stock_equipment || "").trim() || null,
  };
  if (payload.jira_operations_option_id) {
    fields.customfield_10111 = { id: String(payload.jira_operations_option_id) };
  }
  return fields;
}

function actionFields(payload: Record<string, unknown>, projectKey: string) {
  const priority = String(payload.priority || "medium").toLowerCase();
  const priorityName = priority === "critical" ? "Highest" : priority === "high" ? "High" : priority === "low" ? "Low" : "Medium";
  const department = String(payload.department_name || "Institution-wide");
  const fields: Record<string, unknown> = {
    project: { key: projectKey },
    issuetype: { name: "Task" },
    summary: `[ACTION] ${String(payload.summary || "Management follow-up")}`.slice(0, 255),
    description: adfFromSections("Management action", [
      ["Department", department],
      ["Action", payload.summary],
      ["Details", payload.description],
      ["Owner", payload.owner_name],
      ["Due date", payload.due_date],
    ]),
    labels: compact([
      "amfcc-operations",
      "management-action",
      "action-required",
      `priority-${priority}`,
      `department-${slugLabel(payload.department_slug || department)}`,
    ]),
    priority: { name: priorityName },
    duedate: payload.due_date || null,
    customfield_10110: { id: "10020" },
  };
  if (payload.jira_operations_option_id) {
    fields.customfield_10111 = { id: String(payload.jira_operations_option_id) };
  }
  return fields;
}

function jiraFields(row: OutboxRow, projectKey: string) {
  if (row.event_type === "approved_report") return reportFields(row.payload, projectKey);
  return actionFields(row.payload, projectKey);
}

async function jiraRequest(
  baseUrl: string,
  auth: string,
  row: OutboxRow,
  projectKey: string,
  existingKey: string | null,
) {
  const fields = jiraFields(row, projectKey);
  const path = existingKey ? `/rest/api/3/issue/${encodeURIComponent(existingKey)}` : "/rest/api/3/issue";
  const response = await fetch(`${baseUrl.replace(/\/$/, "")}${path}`, {
    method: existingKey ? "PUT" : "POST",
    headers: {
      authorization: `Basic ${auth}`,
      accept: "application/json",
      "content-type": "application/json",
    },
    body: JSON.stringify({ fields }),
  });
  const bodyText = await response.text();
  if (!response.ok) {
    throw new Error(`Jira ${response.status}: ${bodyText.slice(0, 500)}`);
  }
  if (existingKey) return { key: existingKey };
  const body = bodyText ? JSON.parse(bodyText) : {};
  if (!body.key) throw new Error("Jira created an issue without returning its key.");
  return { key: String(body.key) };
}

Deno.serve(async (request: Request) => {
  if (request.method !== "POST") {
    return new Response(JSON.stringify({ error: "POST required" }), { status: 405, headers: jsonHeaders });
  }

  try {
    const workerToken = required("JIRA_WORKER_TOKEN");
    const providedWorkerToken = request.headers.get("x-worker-token") || "";
    if (!timingSafeEqual(providedWorkerToken, workerToken)) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), { status: 401, headers: jsonHeaders });
    }

    const supabaseUrl = required("SUPABASE_URL");
    const supabaseSecret = Deno.env.get("SUPABASE_SECRET_KEY") || required("SUPABASE_SERVICE_ROLE_KEY");
    const jiraBaseUrl = required("JIRA_BASE_URL");
    const jiraEmail = required("JIRA_USER_EMAIL");
    const jiraToken = required("JIRA_API_TOKEN");
    const projectKey = Deno.env.get("JIRA_PROJECT_KEY") || "AH";
    const jiraAuth = btoa(`${jiraEmail}:${jiraToken}`);
    const supabase = createClient(supabaseUrl, supabaseSecret, {
      auth: { persistSession: false, autoRefreshToken: false },
    });

    const now = new Date().toISOString();
    const { data: candidates, error: loadError } = await supabase
      .from("ops_jira_outbox")
      .select("id,event_type,aggregate_type,aggregate_id,payload,attempts,jira_issue_key")
      .in("status", ["pending", "failed"])
      .lte("available_at", now)
      .order("created_at", { ascending: true })
      .limit(10);
    if (loadError) throw loadError;

    const result = { processed: 0, sent: 0, failed: 0, skipped: 0 };
    for (const candidate of (candidates || []) as OutboxRow[]) {
      const { data: claimed, error: claimError } = await supabase
        .from("ops_jira_outbox")
        .update({ status: "processing", locked_at: new Date().toISOString(), attempts: candidate.attempts + 1 })
        .eq("id", candidate.id)
        .in("status", ["pending", "failed"])
        .select("id")
        .maybeSingle();
      if (claimError || !claimed) {
        result.skipped += 1;
        continue;
      }
      result.processed += 1;

      try {
        const { data: link } = await supabase
          .from("ops_jira_links")
          .select("jira_issue_key")
          .eq("aggregate_type", candidate.aggregate_type)
          .eq("aggregate_id", candidate.aggregate_id)
          .maybeSingle();
        const existingKey = candidate.jira_issue_key || link?.jira_issue_key || null;
        const jira = await jiraRequest(jiraBaseUrl, jiraAuth, candidate, projectKey, existingKey);
        const jiraUrl = `${jiraBaseUrl.replace(/\/$/, "")}/browse/${jira.key}`;

        await supabase.from("ops_jira_links").upsert({
          aggregate_type: candidate.aggregate_type,
          aggregate_id: candidate.aggregate_id,
          jira_issue_key: jira.key,
          jira_issue_url: jiraUrl,
          synced_at: new Date().toISOString(),
        }, { onConflict: "aggregate_type,aggregate_id" });

        if (candidate.aggregate_type === "report") {
          await supabase.from("ops_reports").update({ jira_issue_key: jira.key, jira_issue_url: jiraUrl }).eq("id", candidate.aggregate_id);
        } else if (candidate.aggregate_type === "management_action") {
          await supabase.from("ops_management_actions").update({ jira_issue_key: jira.key, jira_issue_url: jiraUrl }).eq("id", candidate.aggregate_id);
        }

        await supabase.from("ops_jira_outbox").update({
          status: "sent",
          jira_issue_key: jira.key,
          jira_issue_url: jiraUrl,
          sent_at: new Date().toISOString(),
          last_error: null,
          locked_at: null,
        }).eq("id", candidate.id);
        result.sent += 1;
      } catch (error) {
        const attempts = candidate.attempts + 1;
        const delaySeconds = Math.min(21600, 60 * (2 ** Math.min(attempts, 8)));
        await supabase.from("ops_jira_outbox").update({
          status: "failed",
          last_error: error instanceof Error ? error.message.slice(0, 1000) : "Unknown Jira error",
          available_at: new Date(Date.now() + delaySeconds * 1000).toISOString(),
          locked_at: null,
        }).eq("id", candidate.id);
        result.failed += 1;
      }
    }

    return new Response(JSON.stringify(result), { status: 200, headers: jsonHeaders });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unexpected worker error";
    return new Response(JSON.stringify({ error: message }), { status: 500, headers: jsonHeaders });
  }
});

