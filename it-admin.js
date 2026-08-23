(function () {
  "use strict";

  var state = { client: null, session: null, data: null, modeStatus: null, toastTimer: null, pinTarget: null };
  function el(id) { return document.getElementById(id); }
  function all(selector, root) { return Array.prototype.slice.call((root || document).querySelectorAll(selector)); }
  function esc(value) { return String(value == null ? "" : value).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#039;"); }
  function title(value) { return String(value || "").replace(/_/g," ").replace(/\b\w/g,function (m) { return m.toUpperCase(); }); }
  function formatWhen(value) { if (!value) return "Not yet"; var d = new Date(value); return isNaN(d.getTime()) ? String(value) : d.toLocaleString(); }
  function datetimeLocal(value) { if (!value) return ""; var d = new Date(value); if (isNaN(d.getTime())) return ""; var off = d.getTimezoneOffset(); return new Date(d.getTime() - off * 60000).toISOString().slice(0,16); }
  function actorName() { return String(el("actor-name").value || "").trim(); }
  function requireActor() { var name = actorName(); if (!name) { el("actor-name").focus(); throw new Error("Enter your name before making a change."); } localStorage.setItem("amfcc_it_actor",name); return name; }

  function toast(message, error) {
    clearTimeout(state.toastTimer); var box = el("toast"); box.textContent = message; box.classList.toggle("error",!!error); box.hidden = false;
    state.toastTimer = setTimeout(function () { box.hidden = true; }, error ? 6500 : 3600);
  }
  function busy(form, active, label) {
    var button = form.querySelector("button[type=submit]"); if (!button) return;
    if (active) { button.dataset.label = button.textContent; button.textContent = label || "Saving..."; button.disabled = true; }
    else { button.textContent = button.dataset.label || button.textContent; button.disabled = false; }
  }
  async function rpc(name, args) {
    el("connection-state").textContent = "Working"; el("connection-state").className = "status-pill neutral";
    var result = await state.client.rpc(name,args || {});
    if (result.error) throw result.error;
    if (result.data && ["unauthorized","locked"].indexOf(result.data.status) >= 0 && name !== "system_control_login") {
      signOut(false); throw new Error(result.data.message || "Your session has ended.");
    }
    el("connection-state").textContent = "Connected"; el("connection-state").className = "status-pill green";
    return result.data;
  }
  function saveSession(session) { state.session = session; sessionStorage.setItem("amfcc_it_admin_session",JSON.stringify(session)); }
  function restoreSession() { try { var raw = sessionStorage.getItem("amfcc_it_admin_session"); if (!raw) return false; state.session = JSON.parse(raw); return !!state.session.session_token; } catch (e) { sessionStorage.removeItem("amfcc_it_admin_session"); return false; } }
  function showLogin() { el("login-screen").hidden = false; el("app-shell").hidden = true; el("login-pin").value = ""; }
  function showApp() { el("login-screen").hidden = true; el("app-shell").hidden = false; }
  async function signOut(server) { if (server !== false && state.session) { try { await rpc("system_control_logout",{p_session_token:state.session.session_token}); } catch (e) {} } state.session = null; state.data = null; sessionStorage.removeItem("amfcc_it_admin_session"); showLogin(); }

  function switchView(view) {
    all(".view").forEach(function (node) { node.classList.toggle("active",node.id === "view-" + view); });
    all("#main-nav button").forEach(function (node) { node.classList.toggle("active",node.dataset.view === view); });
  }
  function modeCopy(baseMode, conference) {
    var baseLabel = baseMode === "holiday" ? "Holiday Mode" : "School Term Mode";
    if (conference) return {
      label:baseLabel + " + Conference Mode",
      message:"The " + baseLabel + " calendar and gate-pass rules remain active. Conference Mode removes meal deadlines and manual-work sessions, and every open or new task is an Emergency with Critical priority."
    };
    if (baseMode === "holiday") return { label:baseLabel, message:"Manual work uses Morning and Afternoon slots. Existing Holiday Mode gate-pass rules remain active. Normal meal deadlines apply." };
    return { label:baseLabel, message:"Standard meal deadlines, gate-pass rules, and the regular manual-work session timetable apply." };
  }
  function renderMode() {
    var status = state.modeStatus || {}, mode = status.base_mode || status.mode || state.data.mode || "normal";
    var conference = !!status.conference_mode, copy = modeCopy(mode,conference), pill = el("mode-pill");
    pill.textContent = copy.label; pill.className = "mode-pill " + (conference ? "conference" : mode);
    var radio = document.querySelector('input[name="operating-mode"][value="' + mode + '"]'); if (radio) radio.checked = true;
    el("conference-mode").checked = conference;
    el("mode-impact").innerHTML = "<strong>Current effect:</strong> " + esc(copy.message);
    el("current-rules").className = "panel rule-panel " + (conference ? "conference" : mode);
    el("current-rules").innerHTML = '<p class="eyebrow">' + esc(copy.label) + '</p><h3>' + esc(copy.message) + '</h3><div class="rule-list">' +
      '<div class="rule-item"><strong>Meals</strong><span>' + (conference ? "No check-in deadline" : "Scheduled deadlines") + '</span></div>' +
      '<div class="rule-item"><strong>Manual work</strong><span>' + (conference ? "No sessions" : mode === "holiday" ? "Morning and Afternoon" : "Regular timetable") + '</span></div>' +
      '<div class="rule-item"><strong>Tasks</strong><span>' + (conference ? "All Emergency" : "Normal task types") + '</span></div></div>';
  }
  function renderSummary() {
    var roles = state.data.role_credentials || [], departments = state.data.departments || [];
    var configuredRoles = roles.filter(function (r) { return r.pin_configured; }).length;
    var configuredDepartments = departments.filter(function (d) { return d.pin_configured; }).length;
    var locked = roles.filter(function (r) { return r.locked_until && new Date(r.locked_until) > new Date(); }).length;
    var status = state.modeStatus || {}, base = status.base_mode || state.data.mode || "normal";
    var cards = [[modeCopy(base,!!status.conference_mode).label,"Operating modes"],[configuredRoles + " / " + roles.length,"Role PINs ready"],[configuredDepartments + " / " + departments.length,"Department PINs ready"],[locked,"Temporarily locked roles"]];
    el("summary-cards").innerHTML = cards.map(function (c) { return '<article class="summary-card"><strong>' + esc(c[0]) + '</strong><span>' + esc(c[1]) + '</span></article>'; }).join("");
    el("access-readiness").innerHTML = roles.map(function (r) { return '<div class="list-row"><span>' + esc(r.role_label) + '</span><strong>' + (r.pin_configured ? "Ready" : "Not set") + '</strong></div>'; }).join("") || "No role credentials loaded.";
  }
  function renderSettings() {
    var s = state.data.settings || {};
    el("pilot-mode").checked = !!s.gate_pass_pilot_mode;
    el("pilot-start").value = datetimeLocal(s.gate_pass_pilot_started_at);
    el("pilot-end").value = datetimeLocal(s.gate_pass_pilot_ends_at);
    el("result-seconds").value = s.gate_terminal_result_seconds == null ? 3 : s.gate_terminal_result_seconds;
    el("school-timezone").value = s.school_timezone || "Africa/Harare";
  }
  function credentialCard(item, type) {
    var key = type === "role" ? item.role_key : item.id, label = type === "role" ? item.role_label : item.name;
    var ready = item.pin_configured, changed = type === "role" ? item.pin_changed_at : item.pin_changed_at;
    return '<article class="credential-card" data-search="' + esc(String(label).toLowerCase()) + '"><div><h4>' + esc(label) + '</h4><small class="muted">' + esc(type === "role" ? title(item.role_key) : item.slug) + '</small></div><div class="credential-meta"><span class="mini-pill ' + (ready ? "ready" : "pending") + '">' + (ready ? "PIN ready" : "PIN not set") + '</span>' + (item.must_change_pin ? '<span class="mini-pill pending">Change required</span>' : '') + '</div><small class="muted">Last changed: ' + esc(formatWhen(changed)) + '</small><button class="button secondary open-pin" data-target-type="' + type + '" data-target-key="' + esc(key) + '" data-target-label="' + esc(label) + '" type="button">' + (ready ? "Change PIN" : "Set PIN") + '</button></article>';
  }
  function renderCredentials() {
    el("role-credentials").innerHTML = (state.data.role_credentials || []).map(function (r) { return credentialCard(r,"role"); }).join("");
    el("department-credentials").innerHTML = (state.data.departments || []).map(function (d) { return credentialCard(d,"department"); }).join("");
    var lib = (state.data.role_credentials || []).find(function (r) { return r.role_key === "library_staff"; });
    el("library-pin-status").innerHTML = lib && lib.pin_configured ? '<strong>Library Staff access is ready.</strong> Last changed ' + esc(formatWhen(lib.pin_changed_at)) + '.' : '<strong>Library Staff access is disabled.</strong> Set its first PIN before handing over the site.';
    all(".open-pin").forEach(function (button) { button.onclick = function () { openPin(button.dataset.targetType,button.dataset.targetKey,button.dataset.targetLabel); }; });
  }
  function renderAudit() {
    var rows = state.data.audit || [];
    el("audit-rows").innerHTML = rows.length ? rows.map(function (row) {
      var details = row.details || {}, detail = details.actor_name || details.target_label || details.to || details.value;
      if (typeof detail === "object") detail = JSON.stringify(detail);
      return '<tr><td>' + esc(formatWhen(row.created_at)) + '</td><td>' + esc(title(row.entity_type)) + '</td><td>' + esc(title(row.action)) + '</td><td>' + esc(title(row.actor_role)) + '</td><td>' + esc(detail || "Recorded") + '</td></tr>';
    }).join("") : '<tr><td colspan="5">No settings or access changes have been recorded yet.</td></tr>';
  }
  function renderAll() { renderMode(); renderSummary(); renderSettings(); renderCredentials(); renderAudit(); el("change-pin-banner").hidden = !state.data.must_change_pin; }
  async function loadData(message) {
    var results = await Promise.all([
      rpc("system_control_bootstrap",{p_session_token:state.session.session_token}),
      rpc("system_mode_status")
    ]);
    var data = results[0];
    if (data.status !== "success") throw new Error(data.message || "Could not load IT Administration.");
    state.data = data; state.modeStatus = results[1]; renderAll(); if (message) toast(message);
  }
  function openPin(type,key,label) { state.pinTarget = {type:type,key:key,label:label}; el("pin-target-type").value = type; el("pin-target-key").value = key; el("pin-modal-title").textContent = "Change " + label + " PIN"; el("pin-target-description").textContent = "Set the shared four-digit PIN for " + label + "."; el("new-pin").value = ""; el("confirm-pin").value = ""; el("pin-modal").hidden = false; setTimeout(function () { el("new-pin").focus(); },40); }

  function bind() {
    el("login-form").addEventListener("submit",async function (event) {
      event.preventDefault(); busy(event.currentTarget,true,"Opening..."); el("login-message").hidden = true;
      try {
        var result = await rpc("system_control_login",{p_role:"it_admin",p_pin:el("login-pin").value.trim()});
        if (result.status !== "success") throw new Error(result.message || "Incorrect PIN.");
        saveSession(result); showApp(); await loadData(false); toast("IT Administration opened.");
      } catch (error) { el("login-message").textContent = error.message || "Login failed."; el("login-message").className = "form-message error"; el("login-message").hidden = false; }
      finally { busy(event.currentTarget,false); }
    });
    el("logout-button").addEventListener("click",function () { signOut(true); });
    el("refresh-button").addEventListener("click",function () { loadData("System controls refreshed.").catch(function (e) { toast(e.message,true); }); });
    all("#main-nav button,.jump-view").forEach(function (button) { button.addEventListener("click",function () { switchView(button.dataset.view); }); });
    el("mode-form").addEventListener("submit",async function (event) {
      event.preventDefault(); var selected = document.querySelector('input[name="operating-mode"]:checked');
      if (!selected) return toast("Choose School Term or Holiday Mode.",true);
      var conference = el("conference-mode").checked, copy = modeCopy(selected.value,conference);
      if (!window.confirm("Apply " + copy.label + " across every connected site?")) return;
      busy(event.currentTarget,true,"Applying modes...");
      try {
        var actor = requireActor();
        var result = await rpc("system_control_set_mode",{p_session_token:state.session.session_token,p_mode:selected.value,p_actor_name:actor});
        if (result.status !== "success") throw new Error(result.message);
        result = await rpc("system_control_set_conference",{p_session_token:state.session.session_token,p_enabled:conference,p_actor_name:actor});
        if (result.status !== "success") throw new Error(result.message);
        await loadData(false); toast(copy.label + " is now active.");
      }
      catch (error) { toast(error.message || "Mode could not be changed.",true); } finally { busy(event.currentTarget,false); }
    });
    el("settings-form").addEventListener("submit",async function (event) {
      event.preventDefault(); busy(event.currentTarget,true,"Saving...");
      try {
        var actor = requireActor(), settings = [
          ["gate_pass_pilot_mode",el("pilot-mode").checked],
          ["gate_pass_pilot_started_at",el("pilot-start").value ? new Date(el("pilot-start").value).toISOString() : null],
          ["gate_pass_pilot_ends_at",el("pilot-end").value ? new Date(el("pilot-end").value).toISOString() : null],
          ["gate_terminal_result_seconds",Number(el("result-seconds").value)],
          ["school_timezone",el("school-timezone").value.trim()]
        ];
        for (var i=0;i<settings.length;i++) { var result = await rpc("system_control_update_setting",{p_session_token:state.session.session_token,p_setting_key:settings[i][0],p_setting_value:settings[i][1],p_actor_name:actor}); if (result.status !== "success") throw new Error(result.message); }
        await loadData(false); toast("System settings saved.");
      } catch (error) { toast(error.message || "Settings could not be saved.",true); } finally { busy(event.currentTarget,false); }
    });
    el("department-search").addEventListener("input",function () { var q = this.value.trim().toLowerCase(); all("#department-credentials .credential-card").forEach(function (card) { card.hidden = q && card.dataset.search.indexOf(q) < 0; }); });
    el("close-pin-modal").addEventListener("click",function () { el("pin-modal").hidden = true; });
    el("pin-modal").addEventListener("click",function (event) { if (event.target === el("pin-modal")) el("pin-modal").hidden = true; });
    el("pin-form").addEventListener("submit",async function (event) {
      event.preventDefault(); var pin = el("new-pin").value.trim(), confirm = el("confirm-pin").value.trim();
      if (!/^\d{4}$/.test(pin)) return toast("Enter exactly four digits.",true); if (pin !== confirm) return toast("The PIN confirmation does not match.",true);
      if (!window.confirm("Change the PIN for " + state.pinTarget.label + " now?")) return;
      busy(event.currentTarget,true,"Changing PIN...");
      try { var result = await rpc("system_control_set_pin",{p_session_token:state.session.session_token,p_target_type:state.pinTarget.type,p_target_key:state.pinTarget.key,p_new_pin:pin,p_actor_name:requireActor()}); if (result.status !== "success") throw new Error(result.message); el("pin-modal").hidden = true; await loadData(false); toast(result.target_label + " PIN changed."); }
      catch (error) { toast(error.message || "PIN could not be changed.",true); } finally { busy(event.currentTarget,false); }
    });
  }

  document.addEventListener("DOMContentLoaded",async function () {
    state.client = window.amfccDb; el("actor-name").value = localStorage.getItem("amfcc_it_actor") || ""; bind();
    if (restoreSession()) { showApp(); try { await loadData(false); } catch (error) { signOut(false); toast(error.message || "Sign in again.",true); } }
    else showLogin();
  });
})();
