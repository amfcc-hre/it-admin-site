
const BASE = "https://raw.githubusercontent.com/amfcc-hre/department-operations/45b104b903fd41c8790bc6c2ce000c19b4224f37/";
const FN = "/functions/v1/amfcc-ops-recovery";

function contentType(path: string) {
  if (path.endsWith(".html")) return "text/html; charset=utf-8";
  if (path.endsWith(".js")) return "application/javascript; charset=utf-8";
  if (path.endsWith(".css")) return "text/css; charset=utf-8";
  if (path.endsWith(".json") || path.endsWith(".webmanifest")) return "application/json; charset=utf-8";
  if (path.endsWith(".svg")) return "image/svg+xml";
  if (path.endsWith(".png")) return "image/png";
  return "application/octet-stream";
}

Deno.serve(async (req) => {
  try {
    const url = new URL(req.url);
    let path = url.pathname;
    const marker = FN + "/";
    const markerNoSlash = FN;
    if (path === markerNoSlash) {
      return Response.redirect(url.origin + marker, 302);
    }
    const idx = path.indexOf(marker);
    if (idx >= 0) path = path.slice(idx + marker.length);
    else path = "";
    if (!path || path === "/") path = "index.html";
    path = path.replace(/^\/+/, "");

    if (path.includes("..")) return new Response("Invalid path", { status: 400 });

    const upstream = await fetch(BASE + path, { cache: "no-store" });
    if (!upstream.ok) {
      return new Response("Not found", { status: upstream.status });
    }

    const headers = new Headers();
    headers.set("content-type", upstream.headers.get("content-type") || contentType(path));
    headers.set("cache-control", "no-store, max-age=0");
    headers.set("x-amfcc-recovery-source", "45b104b903fd41c8790bc6c2ce000c19b4224f37");

    if (/\.(png|jpg|jpeg|gif|webp|ico)$/i.test(path)) {
      return new Response(await upstream.arrayBuffer(), { status: 200, headers });
    }

    let text = await upstream.text();

    if (path === "index.html") {
      text = text.replace(
        "<head>",
        '<head><base href="' + marker + '">'
      );
    }

    if (path === "enrolment_tracking.js") {
      text = text.replaceAll("&lt;", "<").replaceAll("&gt;", ">");
      text = text.replace(
        "Track every student through the term registration workflow. This view is read-only.",
        "Track and manage every student through the term registration workflow."
      );
    }

    return new Response(text, { status: 200, headers });
  } catch (error) {
    return new Response("Recovery portal error: " + (error instanceof Error ? error.message : String(error)), {
      status: 500,
      headers: { "content-type": "text/plain; charset=utf-8", "cache-control": "no-store" }
    });
  }
});

