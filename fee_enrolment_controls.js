(function() {
  'use strict';

  var AMFCC_GREEN = '#2e7d32';
  var AMFCC_GREEN_LIGHT = '#4caf50';
  var AMFCC_GREEN_BG = '#e8f5e9';
  var BORDER_COLOR = '#c8e6c9';
  var WHITE = '#ffffff';
  var BLACK = '#212121';
  var GRAY = '#757575';
  var LIGHT_GRAY = '#f5f5f5';
  var DANGER_RED = '#d32f2f';
  var WARNING_ORANGE = '#f57c00';
  var TEXT_SUCCESS = '#2e7d32';
  var TEXT_ERROR = '#c62828';

  function escapeHtml(str) {
    if (typeof str !== 'string') return str;
    return str
      .replace(/&/g, '&amp;')
      .replace(/'/g, '&#39;')
      .replace(/"/g, '&quot;')
      .replace(/=/g, '&#61;')
      .replace(/'/g, '&#39;')
      .replace(/`/g, '&#96;')
      .replace(/%20/g, ' ');
  }

  var feeData = [];
  var lastDeliveryStatuses = {};

  function injectCss() {
    var style = document.createElement('style');
    style.textContent = '' +
      '.amfcc-fee-panel { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; max-width: 1200px; margin: 20px auto; padding: 0 16px; }' +
      '.amfcc-fee-panel h2 { color: ' + AMFCC_GREEN + '; border-bottom: 2px solid ' + AMFCC_GREEN + '; padding-bottom: 8px; margin: 0 0 16px 0; font-size: 20px; }' +
      '.amfcc-fee-toolbar { display: flex; flex-wrap: wrap; gap: 8px; align-items: center; margin-bottom: 12px; }' +
      '.amfcc-fee-toolbar input[type="text"] { padding: 6px 10px; border: 1px solid ' + BORDER_COLOR + '; border-radius: 4px; font-size: 14px; min-width: 200px; }' +
      '.amfcc-fee-toolbar input[type="text"]:focus { outline: 2px solid ' + AMFCC_GREEN + '; border-color: ' + AMFCC_GREEN + '; }' +
      '.amfcc-fee-toolbar button { padding: 6px 12px; border: 1px solid ' + AMFCC_GREEN + '; background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; border-radius: 4px; cursor: pointer; font-size: 14px; }' +
      '.amfcc-fee-toolbar button:hover { background: ' + AMFCC_GREEN_LIGHT + '; }' +
      '.amfcc-fee-toolbar button:disabled { background: ' + GRAY + '; border-color: ' + GRAY + '; cursor: not-allowed; }' +
      '.amfcc-fee-toolbar .spacer { flex: 1 1 100%; }' +
      '.amfcc-fee-table-wrap { overflow-x: auto; border: 1px solid ' + BORDER_COLOR + '; border-radius: 4px; }' +
      '.amfcc-fee-table { width: 100%; border-collapse: collapse; font-size: 14px; }' +
      '.amfcc-fee-table th { background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; padding: 8px 10px; text-align: left; white-space: nowrap; }' +
      '.amfcc-fee-table td { padding: 8px 10px; border-bottom: 1px solid ' + BORDER_COLOR + '; vertical-align: middle; }' +
      '.amfcc-fee-table tr:hover { background: ' + AMFCC_GREEN_BG + '; }' +
      '.amfcc-fee-table tr.paid-row { background: ' + AMFCC_GREEN_BG + '; }' +
      '.amfcc-fee-table tr.paid-row td:first-child input[type="checkbox"] { display: none; }' +
      '.amfcc-fee-badge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: bold; text-transform: uppercase; border: none; cursor: default; }' +
      '.amfcc-badge-paid { background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; }' +
      '.amfcc-badge-arrears { background: ' + WARNING_ORANGE + '; color: ' + WHITE + '; }' +
      '.amfcc-badge-not-recorded { background: ' + GRAY + '; color: ' + WHITE + '; }' +
      '.amfcc-fee-table input[type="checkbox"] { cursor: pointer; width: 16px; height: 16px; }' +
      '.amfcc-fee-table input[type="checkbox"]:disabled { cursor: not-allowed; opacity: 0.5; }' +
      '.amfcc-notice-btn { padding: 3px 8px; border: 1px solid ' + AMFCC_GREEN + '; background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; border-radius: 4px; cursor: pointer; font-size: 12px; }' +
      '.amfcc-notice-btn:disabled { background: ' + GRAY + '; border-color: ' + GRAY + '; cursor: not-allowed; }' +
      '.amfcc-fee-info-btn { padding: 3px 8px; border: 1px solid ' + AMFCC_GREEN + '; background: transparent; color: ' + AMFCC_GREEN + '; border-radius: 4px; cursor: pointer; font-size: 12px; }' +
      '.amfcc-fee-info-btn:hover { background: ' + AMFCC_GREEN_BG + '; }' +
      '.amfcc-modal-overlay { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 10000; }' +
      '.amfcc-modal-box { background: ' + WHITE + '; border-radius: 8px; padding: 24px; max-width: 500px; width: 90%; max-height: 80vh; overflow-y: auto; box-shadow: 0 4px 20px rgba(0,0,0,0.3); }' +
      '.amfcc-modal-box h3 { color: ' + AMFCC_GREEN + '; margin: 0 0 16px 0; }' +
      '.amfcc-modal-box .amfcc-modal-row { margin-bottom: 8px; font-size: 14px; }' +
      '.amfcc-modal-box .amfcc-modal-label { font-weight: bold; color: ' + GRAY + '; }' +
      '.amfcc-modal-box .amfcc-modal-close { margin-top: 16px; padding: 6px 16px; border: 1px solid ' + AMFCC_GREEN + '; background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; border-radius: 4px; cursor: pointer; }' +
      '.amfcc-fee-feedback { padding: 8px 12px; border-radius: 4px; margin: 8px 0; font-size: 14px; display: none; }' +
      '.amfcc-fee-feedback.success { display: block; background: ' + AMFCC_GREEN_BG + '; color: ' + TEXT_SUCCESS + '; border: 1px solid ' + AMFCC_GREEN + '; }' +
      '.amfcc-fee-feedback.error { display: block; background: #ffebee; color: ' + TEXT_ERROR + '; border: 1px solid ' + DANGER_RED + '; }' +
      '@media (max-width: 768px) {' +
      '.amfcc-fee-toolbar { flex-direction: column; align-items: stretch; }' +
      '.amfcc-fee-table { font-size: 12px; }' +
      '.amfcc-fee-table th, .amfcc-fee-table td { padding: 6px 8px; }' +
      '.amfcc-fee-panel { padding: 0 8px; }' +
      '}' +
      '';
    document.head.appendChild(style);
  }

  function openModal(htmlContent) {
    var overlay = document.createElement('div');
    overlay.className = 'amfcc-modal-overlay';
    overlay.innerHTML =
      '  .amfcc-modal-box h3 { color: ' + AMFCC_GREEN + '; margin: 0 0 16px 0; }' +
      '  .amfcc-modal-box .amfcc-modal-row { margin-bottom: 8px; font-size: 14px; }' +
      '  .amfcc-modal-box .amfcc-modal-label { font-weight: bold; color: ' + GRAY + '; }' +
      '  .amfcc-modal-box .amfcc-modal-close { margin-top: 16px; padding: 6px 16px; border: 1px solid ' + AMFCC_GREEN + '; background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; border-radius: 4px; cursor: pointer; }' +
      '';
    overlay.setAttribute('data-no-validate', 'true');
    var box = document.createElement('div');
    box.className = 'amfcc-modal-box';
    box.innerHTML =
      '    .amfcc-modal-box h3 { color: ' + AMFCC_GREEN + '; margin: 0 0 16px 0; }' +
      '    .amfcc-modal-box .amfcc-modal-row { margin-bottom: 8px; font-size: 14px; }' +
      '    .amfcc-modal-box .amfcc-modal-label { font-weight: bold; color: ' + GRAY + '; }' +
      '    .amfcc-modal-box .amfcc-modal-close { margin-top: 16px; padding: 6px 16px; border: 1px solid ' + AMFCC_GREEN + '; background: ' + AMFCC_GREEN + '; color: ' + WHITE + '; border-radius: 4px; cursor: pointer; }' +
      '';
    box.innerHTML =
      '    h3 style="color:' + AMFCC_GREEN + ';margin:0 0 16px 0">Fee Information' +
      '    ' + htmlContent + '' +
      '    button onclick="this.closest(\'.amfcc-modal-overlay\').remove()" style="margin-top:16px;padding:6px 16px;border:1px solid ' + AMFCC_GREEN + ';background:' + AMFCC_GREEN + ';color:' + WHITE + ';border-radius:4px;cursor:pointer">Close' +
      '';
    overlay.innerHTML = '';
    overlay.appendChild(box);
    overlay.addEventListener('click', function(e) {
      if (e.target === overlay) overlay.remove();
    });
    document.body.appendChild(overlay);
  }

  function buildModalRow(label, value) {
    return '    div style="margin-bottom:8px"' +
      '      strong style="font-weight:bold;color:' + GRAY + '">' + escapeHtml(label) + ': ' +
      '      span>' + escapeHtml(value) + '' +
      '    /div';
  }

  function renderTable(data) {
    var tableWrap = document.createElement('div');
    tableWrap.className = 'amfcc-fee-table-wrap';

    var table = document.createElement('table');
    table.className = 'amfcc-fee-table';

    var thead = document.createElement('thead');
    thead.innerHTML = '' +
      '    tr' +
      '      th' +
      '        input type="checkbox" id="amfcc-select-all" onchange="toggleAll(this)"' +
      '      /th' +
      '      th>Student/th' +
      '      th>Registration/th' +
      '      th>Balance/th' +
      '      th>Fee information/th' +
      '      th>Email/th' +
      '      th>Notice/th' +
      '    /tr';
    table.appendChild(thead);

    var tbody = document.createElement('tbody');

    for (var i = 0; i data[i]) {
      var row = data[i];
      var tr = document.createElement('tr');
      if (row.status === 'Paid') {
        tr.className = 'paid-row';
      }

      var canSend = row.send_eligible === true && row.status !== 'Paid';
      var canCheck = row.status !== 'Paid' && row.send_eligible === true;

      var badgeClass = 'amfcc-badge-not-recorded';
      var badgeText = 'NOT RECORDED';
      if (row.status === 'Paid') {
        badgeClass = 'amfcc-badge-paid';
        badgeText = 'PAID';
      } else if (row.status === 'Arrears') {
        badgeClass = 'amfcc-badge-arrears';
        badgeText = 'ARREARS';
      }

      var emailDisplay = row.email || 'No registration email';
      var noticeDisplay = row.notice_text || 'No notice available';
      var isNoEmail = !row.email;
      var isNoNotice = !row.notice_text;

      var statusDesc = row.status || 'NOT RECORDED';
      var balanceDisplay = 'USD ' + (row.balance !== null && row.balance !== undefined ? parseFloat(row.balance).toFixed(2) : '0.00');

      var lastDeliver = lastDeliveryStatuses[row.id] || { status: 'N/A', time: 'N/A' };

      var noticeHtml = '';
      if (isNoEmail || isNoNotice) {
        noticeHtml = '    span style="color:' + GRAY + ';font-size:12px"' +
          (isNoEmail ? '  em>No registration email / No notice available/em' +
          : (isNoNotice ? '  em>No notice available/em' + '')) +
          '    /span';
      } else {
        noticeHtml = '    button class="amfcc-notice-btn" data-reg-id="' + escapeHtml(row.id) + '" ' +
          (canSend ? 'onclick="sendNoticeSingle(this)"' : 'disabled') + '>' +
          '  Send' +
          '    /button';
      }

      var infoHtml = '    button class="amfcc-fee-info-btn" data-reg-id="' + escapeHtml(row.id) + '" ' +
        'onclick="showFeeInfo(this)"' + '>Info' +
        '    /button';

      var checkHtml = '    input type="checkbox" data-reg-id="' + escapeHtml(row.id) + '" ' +
        'data-student="' + escapeHtml(row.student) + '" ' +
        (canCheck ? '' : 'disabled') +
        '/';

      tr.innerHTML = '' +
        '      td>' + checkHtml + '    /td' +
        '      td>span>' + escapeHtml(row.student) + '' +
        '        button class="amfcc-fee-badge ' + badgeClass + '" disabled>' +
        '          ' + badgeText + '' +
        '        /button' +
        '      /span' +
        '    /td' +
        '      td>' + escapeHtml(row.registration) + '    /td' +
        '      td style="white-space:nowrap">' + balanceDisplay + '    /td' +
        '      td>' + infoHtml + '    /td' +
        '      td>' + escapeHtml(emailDisplay) + '    /td' +
        '      td>' + noticeHtml + '    /td' +
        '    /tr';
      tbody.appendChild(tr);
    }

    table.appendChild(tbody);
    tableWrap.appendChild(table);
    return tableWrap;
  }

  function showFeeInfo(btn) {
    var regId = btn.getAttribute('data-reg-id');
    var row = feeData.find(function(r) { return String(r.id) === String(regId); });
    if (!row) return;

    var status = row.status || 'NOT RECORDED';
    var balance = 'USD ' + (row.balance !== null && row.balance !== undefined ? parseFloat(row.balance).toFixed(2) : '0.00');
    var email = row.email || 'No registration email';
    var notice = row.notice_text || 'No notice available';
    var lastDel = lastDeliveryStatuses[row.id] || {};

    var modalContent = '' +
      '    div class="amfcc-modal-row">' +
      '      span class="amfcc-modal-label">Status: ' + escapeHtml(status) + '' +
      '    /div' +
      '    div class="amfcc-modal-row">' +
      '      span class="amfcc-modal-label">USD Balance: ' + escapeHtml(balance) + '' +
      '    /div' +
      '    div class="amfcc-modal-row">' +
      '      span class="amfcc-modal-label">Registration Email: ' + escapeHtml(email) + '' +
      '    /div' +
      '    div class="amfcc-modal-row">' +
      '      span class="amfcc-modal-label">Notice Text: ' + escapeHtml(notice) + '' +
      '    /div' +
      '    div class="amfcc-modal-row">' +
      '      span class="amfcc-modal-label">Last Delivery: ' +
      '      span>' +
      '        ' + escapeHtml(lastDel.status || 'N/A') + ' ' +
      '        (' + escapeHtml(lastDel.time || 'N/A') + ')' +
      '      /span' +
      '    /div' +
      '    div class="amfcc-modal-row" style="color:' + GRAY + ';font-style:italic;margin-top:8px">' +
      '      Note: This panel never sends notices automatically.' +
      '    /div';

    openModal(modalContent);
  }

  function toggleAll(cb) {
    var checkboxes = document.querySelectorAll('.amfcc-fee-table tbody input[type="checkbox"]:not([disabled])');
    checkboxes.forEach(function(ch) {
      ch.checked = cb.checked;
    });
  }

  function getSelectedIds() {
    var checked = document.querySelectorAll('.amfcc-fee-table tbody input[type="checkbox"]:checked');
    var ids = [];
    checked.forEach(function(ch) {
      ids.push(ch.getAttribute('data-reg-id'));
    });
    return ids;
  }

  function getActorName() {
    var actorEl = document.getElementById('actor-name');
    return actorEl ? actorEl.value || '' : '';
  }

  function showFeedback(msg, type) {
    var existing = document.querySelector('.amfcc-fee-feedback');
    if (existing) existing.remove();

    var fb = document.createElement('div');
    fb.className = 'amfcc-fee-feedback ' + type;
    fb.textContent = msg;

    var panel = document.querySelector('.amfcc-fee-panel');
    if (panel) {
      panel.insertBefore(fb, panel.querySelector('.amfcc-fee-table-wrap'));
    }
  }

  function confirmAction(msg, callback) {
    if (confirm(msg)) {
      callback();
    }
  }

  function sendNoticeSingle(btn) {
    var regId = btn.getAttribute('data-reg-id');
    var ids = [regId];
    var actorName = getActorName();

    confirmAction('Send notice for this registration?', function() {
      doSendNotices(ids, actorName);
    });
  }

  function sendBulkNotices() {
    var ids = getSelectedIds();
    if (ids.length === 0) {
      showFeedback('No notices selected.', 'error');
      return;
    }
    var actorName = getActorName();

    confirmAction('Send notices for ' + ids.length + ' selected registration(s)?', function() {
      doSendNotices(ids, actorName);
    });
  }

  function doSendNotices(ids, actorName) {
    if (typeof window.amfccDb === 'undefined' || typeof window.registration_admin_send_fee_notices !== 'function') {
      showFeedback('Fee notice API not available.', 'error');
      return;
    }

    var sessionToken = null;
    try {
      sessionToken = sessionStorage.getItem('amfcc_it_admin_session');
    } catch(e) {}

    window.registration_admin_send_fee_notices({
      p_session_token: sessionToken,
      p_registration_ids: ids,
      p_actor_name: actorName
    }, function(result) {
      if (result && result.queued > 0) {
        showFeedback('Successfully queued ' + result.queued + ' notice(s) for delivery.', 'success');
        if (typeof window.pass_email_worker !== 'undefined') {
          window.pass_email_worker({ action: 'drain' });
        }
        refreshFees();
      } else if (result && result.error) {
        showFeedback('Error: ' + escapeHtml(result.error), 'error');
      } else {
        showFeedback('Notice(s) sent.', 'success');
        refreshFees();
      }
    });
  }

  function refreshFees() {
    if (typeof window.registration_admin_fee_dashboard !== 'function') {
      showFeedback('Fee dashboard API not available.', 'error');
      return;
    }

    var sessionToken = null;
    try {
      sessionToken = sessionStorage.getItem('amfcc_it_admin_session');
    } catch(e) {}

    window.registration_admin_fee_dashboard({
      p_session_token: sessionToken,
      p_term_id: null
    }, function(result) {
      if (result && result.data && result.data.length > 0) {
        feeData = result.data;
        if (result.deliveries) {
          lastDeliveryStatuses = result.deliveries;
        }
        if (feeTableWrap.parentNode) {
          feeTableWrap.parentNode.replaceChild(buildPanelContent(feeData), feeTableWrap);
        }
        showFeedback('Fee registrations refreshed.', 'success');
      } else {
        showFeedback('No fee registrations found.', 'error');
      }
    });
  }

  var feeTableWrap = null;

  function buildPanelContent(data) {
    var panelContent = document.createElement('div');

    var toolbar = document.createElement('div');
    toolbar.className = 'amfcc-fee-toolbar';

    var searchInput = document.createElement('input');
    searchInput.type = 'text';
    searchInput.placeholder = 'Search students...';
    searchInput.id = 'amfcc-fee-search';
    searchInput.addEventListener('input', function() {
      filterTable(searchInput.value);
    });

    var selectAllBtn = document.createElement('button');
    selectAllBtn.textContent = 'Select all';
    selectAllBtn.addEventListener('click', function() {
      var cb = document.getElementById('amfcc-select-all');
      if (cb) cb.checked = true;
      toggleAll(cb);
    });

    var sendNoticesBtn = document.createElement('button');
    sendNoticesBtn.textContent = 'Send selected notices';
    sendNoticesBtn.addEventListener('click', sendBulkNotices);

    var refreshBtn = document.createElement('button');
    refreshBtn.textContent = 'Refresh fees';
    refreshBtn.addEventListener('click', refreshFees);

    toolbar.appendChild(searchInput);
    toolbar.appendChild(selectAllBtn);
    toolbar.appendChild(sendNoticesBtn);
    toolbar.appendChild(refreshBtn);

    panelContent.appendChild(toolbar);

    feeTableWrap = renderTable(data);
    panelContent.appendChild(feeTableWrap);

    return panelContent;
  }

  function filterTable(term) {
    var rows = document.querySelectorAll('.amfcc-fee-table tbody tr');
    term = term.toLowerCase();
    rows.forEach(function(row) {
      var text = row.textContent.toLowerCase();
      row.style.display = text.indexOf(term) !== -1 ? '' : 'none';
    });
  }

  function createPanel(data) {
    var existingPanel = document.querySelector('.amfcc-fee-panel');
    if (existingPanel) {
      existingPanel.remove();
    }

    var panel = document.createElement('div');
    panel.className = 'amfcc-fee-panel';

    var title = document.createElement('h2');
    title.textContent = 'Fee information and notices';
    panel.appendChild(title);

    var content = buildPanelContent(data);
    panel.appendChild(content);

    var viewEnrolment = document.getElementById('view-enrolment');
    if (viewEnrolment) {
      viewEnrolment.appendChild(panel);
    }
  }

  injectCss();

  function init() {
    var viewEl = document.getElementById('view-enrolment');
    if (viewEl) {
      var sessionToken = null;
      try {
        sessionToken = sessionStorage.getItem('amfcc_it_admin_session');
      } catch(e) {}

      if (typeof window.registration_admin_fee_dashboard === 'function') {
        window.registration_admin_fee_dashboard({
          p_session_token: sessionToken,
          p_term_id: null
        }, function(result) {
          if (result && result.data && result.data.length > 0) {
            feeData = result.data;
            if (result.deliveries) {
              lastDeliveryStatuses = result.deliveries;
            }
            createPanel(feeData);
          }
        });
      }
    }
  }

  var viewEl = document.getElementById('view-enrolment');
  if (viewEl) {
    init();
  } else {
    var checkTimer = setInterval(function() {
      var el = document.getElementById('view-enrolment');
      if (el) {
        clearInterval(checkTimer);
        init();
      }
    }, 500);

    if (typeof MutationObserver !== 'undefined') {
      var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(m) {
          if (m.addedNodes.length) {
            for (var i = 0; i m.addedNodes.length; i++) {
              var node = m.addedNodes[i];
              if (node.nodeType === 1 && node.id === 'view-enrolment') {
                observer.disconnect();
                clearInterval(checkTimer);
                init();
                break;
              }
            }
          }
        });
      });
      observer.observe(document.body, { childList: true, subtree: true });
    }
  }

  var navBtn = document.querySelector('[href*="term-enrolment"], a:contains("Term enrolment")');
  if (typeof window.amfccNav === 'function') {
    var origNav = window.amfccNav;
    window.amfccNav = function() {
      origNav.apply(this, arguments);
      setTimeout(function() {
        var el = document.getElementById('view-enrolment');
        if (el && feeData.length === 0) {
          init();
        }
      }, 300);
    };
  }

  var reloadBtn = document.getElementById('reload-term');
  if (reloadBtn) {
    reloadBtn.addEventListener('click', function() {
      setTimeout(function() {
        var el = document.getElementById('view-enrolment');
        if (el) init();
      }, 300);
    });
  }

})();
