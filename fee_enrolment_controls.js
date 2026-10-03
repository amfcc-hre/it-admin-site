(function() {
'use strict';

var GREEN='#2e7d32',GREEN_L='#4caf50',GREEN_BG='#e8f5e9',BD='#c8e6c9',W='#fff',BLK='#212121',GRY='#757575',LGRY='#f5f5f5',RED='#d32f2f',ORG='#f57c00';

function esc(s){return s==null?'':String(s).replace(/&/g,'&amp;').replace(/'/g,'&#39;').replace(/"/g,'&quot;').replace(/`/g,'&#96;')}

function mkEl(tag){return document.createElement(tag)}
function setAttr(el,a,v){el.setAttribute(a,v)}
function fmtUsd(n){return '$'+(Number(n)||0).toFixed(2)}

function injectCss(){
if(document.getElementById('amfcc-fee-css'))return;
var s=mkEl('style');s.id='amfcc-fee-css';
s.textContent='.amfcc-fp{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif;max-width:1200px;margin:20px auto;padding:0 16px;}.amfcc-fp h2{color:'+GREEN+';border-bottom:2px solid '+GREEN+';padding-bottom:8px;margin:0 0 12px;font-size:20px;}.amfcc-fp .amfcc-helptxt{font-size:13px;color:'+GRY+';margin:0 0 12px;padding:8px;background:'+GREEN_BG+';border:1px solid '+BD+';border-radius:4px;}.amfcc-fp .amfcc-tb{width:100%;border-collapse:collapse;margin-top:12px;font-size:14px;}.amfcc-fp .amfcc-tb th,.amfcc-fp .amfcc-tb td{border:1px solid '+BD+';padding:8px;text-align:left;vertical-align:middle;}.amfcc-fp .amfcc-tb thead{background:'+GREEN_BG+';}.amfcc-fp .amfcc-tb th{color:'+BLK+';font-weight:600;font-size:13px;}.amfcc-fp .amfcc-tb td{text-align:center;}.amfcc-fp .amfcc-tb td:first-child{text-align:center;}.amfcc-fp .amfcc-tb td:nth-child(2){text-align:left;}.amfcc-fp .amfcc-tb td:nth-child(6){text-align:left;}.amfcc-fp .amfcc-tb td:nth-child(7){text-align:left;}.amfcc-fp .amfcc-btngroup{display:flex;gap:8px;margin:12px 0;flex-wrap:wrap;align-items:center;}.amfcc-fp button{padding:6px 12px;border:none;border-radius:4px;cursor:pointer;font-size:13px;font-weight:600;}.amfcc-fp .btn-g{background:'+GREEN+';color:'+W+';}.amfcc-fp .btn-g:hover{background:'+GREEN_L+';}.amfcc-fp .btn-g:disabled{background:'+GRY+';cursor:not-allowed;}.amfcc-fp .btn-s{background:'+LGRY+';color:'+BLK+';}.amfcc-fp .badge{display:inline-block;padding:2px 8px;border-radius:12px;font-size:11px;font-weight:700;color:'+W+';}.amfcc-fp .badge-paid{background:#2e7d32;}.amfcc-fp .badge-arrears{background:#f57c00;}.amfcc-fp .badge-notr{background:#757575;}.amfcc-fp .msg{padding:8px;border-radius:4px;margin:8px 0;font-size:13px;}.amfcc-fp .msg-s{background:'+GREEN_BG+';color:'+GREEN+';border:1px solid '+BD+';}.amfcc-fp .msg-e{background:#ffebee;color:'+RED+';border:1px solid #ef9a9a;}.amfcc-fp .modal-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,.5);display:flex;align-items:center;justify-content:center;z-index:1000;}.amfcc-fp .modal-box{background:'+W+';border-radius:8px;padding:24px;max-width:600px;width:90%;max-height:80vh;overflow-y:auto;box-shadow:0 4px 20px rgba(0,0,0,.25);}.amfcc-fp .modal-box h3{color:'+GREEN+';margin:0 0 16px;font-size:18px;border-bottom:1px solid '+BD+';padding-bottom:8px;}.amfcc-fp .modal-box table{width:100%;font-size:13px;}.amfcc-fp .modal-box td{padding:4px 8px;border-bottom:1px solid #eee;vertical-align:top;}.amfcc-fp .modal-box td:first-child{font-weight:600;width:160px;color:'+GRY+';}.amfcc-fp .modal-close{float:right;background:none;border:none;font-size:20px;cursor:pointer;color:'+GRY+';padding:0 4px;}.amfcc-fp .modal-close:hover{color:'+BLK+';}.amfcc-fp .chk-cell{width:40px;text-align:center;}.amfcc-fp .fee-btn{background:none;border:1px solid '+GREEN+';color:'+GREEN+';padding:3px 10px;border-radius:4px;cursor:pointer;font-size:12px;}.amfcc-fp .fee-btn:hover{background:'+GREEN_BG+';}.amfcc-fp input[type=checkbox]{width:16px;height:16px;cursor:pointer;}@media(max-width:768px){.amfcc-fp .amfcc-tb{display:block;overflow-x:auto;}.amfcc-fp .amfcc-btngroup{flex-direction:column;align-items:stretch;}}';
document.head.appendChild(s);
}

var feeData=[],searchQ='',panel=null;

function init(){
document.addEventListener('DOMContentLoaded',function(){
if(document.getElementById('amfcc-fee-panel'))return;
injectCss();
var vb=document.querySelector('button[data-view="enrolment"]'),rb=document.getElementById('refresh-button');
var observer=new MutationObserver(function(){
if(document.getElementById('view-enrolment')){
createPanel();observer.disconnect();return;
}
});
observer.observe(document.body,{childList:true,subtree:true});
if(document.getElementById('view-enrolment')){createPanel();observer.disconnect();}
if(vb)vb.addEventListener('click',function(){setTimeout(createPanel,300);});
if(rb)rb.addEventListener('click',function(){if(document.getElementById('view-enrolment')){setTimeout(refreshData,300);}});
});
}

function createPanel(){
if(document.getElementById('amfcc-fee-panel'))return;
var ve=document.getElementById('view-enrolment');
if(!ve)return;
injectCss();
panel=document.createElement('div');
panel.id='amfcc-fee-panel';panel.className='amfcc-fp';

var h2=mkEl('h2');h2.textContent='Fee information and notices';panel.appendChild(h2);

var ht=mkEl('p');ht.className='amfcc-helptxt';ht.textContent='Notices are manual only. Paid students cannot be sent notices. Recipient email comes from the student\'s registration form.';panel.appendChild(ht);

var tb=document.createElement('table');tb.className='amfcc-tb';
var thead=mkEl('thead'),tbody=mkEl('tbody');
var tr=mkEl('tr');
var th=mkEl('th');th.className='chk-cell';
var sac=mkEl('input');sac.type='checkbox';sac.id='sa-chk';
sac.addEventListener('change',function(){toggleSelectAll();});
th.appendChild(sac);tr.appendChild(th);
['Student','Registration','Balance','Fee information','Email','Notice'].forEach(function(t){
var th2=mkEl('th');th2.textContent=t;tr.appendChild(th2);
});
thead.appendChild(tr);tb.appendChild(thead);tb.appendChild(tbody);panel.appendChild(tb);

var bg=document.createElement('div');bg.className='amfcc-btngroup';
var rb2=mkEl('button');rb2.className='btn-g';rb2.textContent='Refresh fees';
rb2.addEventListener('click',refreshData);bg.appendChild(rb2);
var ssb=mkEl('button');ssb.className='btn-g';ssb.textContent='Send selected notices';ssb.id='ssb-btn';ssb.disabled=true;
ssb.addEventListener('click',sendSelected);bg.appendChild(ssb);

var si=mkEl('input');si.type='text';si.placeholder='Search students...';si.style.cssText='padding:6px 10px;border:1px solid '+BD+';border-radius:4px;font-size:13px;width:250px;';
si.addEventListener('input',function(){searchQ=si.value.toLowerCase();render();});
bg.appendChild(si);panel.appendChild(bg);

ve.insertBefore(panel,ve.firstChild);
}

async function refreshData(){
if(!document.getElementById('view-enrolment'))return;
try{
var raw=sessionStorage.getItem('amfcc_it_admin_session');
if(!raw){showMsg('No session found.');return;}
var session=JSON.parse(raw);
var result=await window.amfccDb.rpc('registration_admin_fee_dashboard',{p_session_token:session.session_token,p_term_id:null});
if(result.error||!result.data||result.data.status!=='success'){showMsg('Error: '+(result.error||result.data?.message||'Unknown'));return;}
feeData=result.data.registrations||[];
render();
}catch(e){showMsg('Error: '+e.message);}
}

function showMsg(m,ok){
var prev=document.getElementById('fee-msg');
if(prev)prev.remove();
var d=mkEl('div');d.id='fee-msg';d.className='msg '+(ok?'msg-s':'msg-e');d.textContent=m;
var btns=panel.querySelector('.amfcc-btngroup');
btns.parentNode.insertBefore(d,btns.nextSibling);
}

function render(){
if(!panel)return;
var tbody=panel.querySelector('tbody');
if(!tbody)return;tbody.innerHTML='';
var filtered=feeData.filter(function(r){
return !searchQ||r.student_name.toLowerCase().indexOf(searchQ)!==-1||String(r.registration_number).toLowerCase().indexOf(searchQ)!==-1||(r.student_email||'').toLowerCase().indexOf(searchQ)!==-1;
});
var enabledCount=0;
filtered.forEach(function(r){
if(r.send_eligible)enabledCount++;
var tr=mkEl('tr');
var tc=mkEl('td');tc.className='chk-cell';
var cb=mkEl('input');cb.type='checkbox';cb.dataset.id=r.registration_id;
if(!r.send_eligible)cb.disabled=true;
cb.addEventListener('change',function(){updateSSBtn();});
tc.appendChild(cb);tr.appendChild(tc);

var tn=mkEl('td');
var snSpan=mkEl('span');snSpan.textContent=r.student_name||'';
var badge=mkEl('button');badge.disabled=true;
if(r.fee_status==='paid'){badge.className='badge badge-paid';badge.textContent='PAID';}
else if(r.fee_status==='arrears'){badge.className='badge badge-arrears';badge.textContent='ARREARS';}
else{badge.className='badge badge-notr';badge.textContent='NOT RECORDED';}
tn.appendChild(snSpan);tn.appendChild(badge);tr.appendChild(tn);

var rn=mkEl('td');rn.textContent=r.registration_number||'';tr.appendChild(rn);

var bn=mkEl('td');bn.textContent=fmtUsd(r.outstanding_balance);tr.appendChild(bn);

var fi=mkEl('td');
var fb=mkEl('button');fb.className='fee-btn';fb.textContent='View';
fb.addEventListener('click',function(){showModal(r);});
fi.appendChild(fb);tr.appendChild(fi);

var em=mkEl('td');em.textContent=r.student_email||'-';tr.appendChild(em);

var nc=mkEl('td');
var nsb=mkEl('button');nsb.className='btn-g';nsb.textContent='Send notice';
if(r.send_eligible){nsb.disabled=false;nsb.addEventListener('click',function(){sendSingle(r);});}
else{nsb.disabled=true;
if(r.fee_status==='paid')nsb.textContent='Fully paid';
else if(!r.student_email)nsb.textContent='No registration email';
else if(!r.notice_text)nsb.textContent='No notice available';
else nsb.textContent='Not eligible';
}
nc.appendChild(nsb);tr.appendChild(nc);
tbody.appendChild(tr);
});
updateSSBtn();
var sac=panel.querySelector('#sa-chk');
if(sac)sac.checked=false;
}

function updateSSBtn(){
var btn=panel.querySelector('#ssb-btn');
if(!btn)return;
var cbs=panel.querySelectorAll('tbody input[type=checkbox]:not(:disabled)');
var has=true;
cbs.forEach(function(cb){if(!cb.checked){has=false;}});
btn.disabled=!has||cbs.length===0;
}

function toggleSelectAll(){
var sac=panel.querySelector('#sa-chk');
var cbs=panel.querySelectorAll('tbody input[type=checkbox]:not(:disabled)');
var allChk=true;
cbs.forEach(function(cb){if(!cb.checked){allChk=false;}});
cbs.forEach(function(cb){cb.checked=allChk;});
updateSSBtn();
}

async function sendSingle(row){
if(!window.confirm('Send notice to '+row.student_name+' ('+row.registration_number+')?'))return;
try{
var raw=sessionStorage.getItem('amfcc_it_admin_session');
var session=JSON.parse(raw);
var an=document.getElementById('actor-name');
var actorName=an?an.value:null;
var result=await window.amfccDb.rpc('registration_admin_send_fee_notices',{p_session_token:session.session_token,p_registration_ids:[row.registration_id],p_actor_name:actorName});
if(result.error||result.data.status!=='success'){showMsg('Error: '+(result.error||result.data.message),false);return;}
if(result.data.queued>0){
try{await window.amfccDb.functions.invoke('pass-email-worker',{body:{action:'drain'}});}catch(e){}
}
showMsg('Notice sent for '+row.student_name,true);
refreshData();
}catch(e){showMsg('Error: '+e.message,false);}
}

async function sendSelected(){
var cbs=panel.querySelectorAll('tbody input[type=checkbox]:checked');
if(cbs.length===0){showMsg('No rows selected.');return;}
var ids=[];cbs.forEach(function(cb){ids.push(cb.dataset.id);});
if(!window.confirm('Send notices to '+ids.length+' student(s)?'))return;
try{
var raw=sessionStorage.getItem('amfcc_it_admin_session');
var session=JSON.parse(raw);
var an=document.getElementById('actor-name');
var actorName=an?an.value:null;
var result=await window.amfccDb.rpc('registration_admin_send_fee_notices',{p_session_token:session.session_token,p_registration_ids:ids,p_actor_name:actorName});
if(result.error||result.data.status!=='success'){showMsg('Error: '+(result.error||result.data.message),false);return;}
if(result.data.queued>0){
try{await window.amfccDb.functions.invoke('pass-email-worker',{body:{action:'drain'}});}catch(e){}
}
showMsg('Notices queued for '+result.data.queued+' student(s).',true);
refreshData();
}catch(e){showMsg('Error: '+e.message,false);}
}

function showModal(row){
var ov=mkEl('div');ov.className='modal-overlay';
var bx=mkEl('div');bx.className='modal-box';
var cl=mkEl('button');cl.className='modal-close';cl.textContent='\u00d7';
cl.addEventListener('click',function(){ov.remove();});
bx.appendChild(cl);
var h3=mkEl('h3');h3.textContent='Fee Information';bx.appendChild(h3);
var tbl=mkEl('table');
var fields=[
['Student',row.student_name],['Registration',row.registration_number],
['Status',row.fee_status==='paid'?'PAID':row.fee_status==='arrears'?'ARREARS':'NOT RECORDED'],
['Outstanding Balance',fmtUsd(row.outstanding_balance)],['Registration Email',row.student_email||'-'],
['Notice Text',row.notice_text||'-'],['Last Queued',row.notice_last_queued_at||'-'],
['Last Sent',row.notice_last_sent_at||'-'],['Last Recipient',row.notice_last_recipient||'-'],
['Delivery Status',row.notice_last_delivery_status||'-'],['Last Error',row.notice_last_error||'-']
];
fields.forEach(function(f){
var r2=mkEl('tr');var td1=mkEl('td');td1.textContent=f[0];var td2=mkEl('td');td2.textContent=f[1]||'';
r2.appendChild(td1);r2.appendChild(td2);tbl.appendChild(r2);
});
bx.appendChild(tbl);
var ob=mkEl('button');ob.className='btn-s';ob.textContent='Close';ob.addEventListener('click',function(){ov.remove();});
bx.appendChild(ob);ov.appendChild(bx);document.body.appendChild(ov);
ov.addEventListener('click',function(e){if(e.target===ov)ov.remove();});
}

init();
})();
