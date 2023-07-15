const su=function(){const e=document.createElement("link").relList;if(e&&e.supports&&e.supports("modulepreload"))return;for(const r of document.querySelectorAll('link[rel="modulepreload"]'))n(r);new MutationObserver(r=>{for(const s of r)if(s.type==="childList")for(const a of s.addedNodes)a.tagName==="LINK"&&a.rel==="modulepreload"&&n(a)}).observe(document,{childList:!0,subtree:!0});function t(r){const s={};return r.integrity&&(s.integrity=r.integrity),r.referrerpolicy&&(s.referrerPolicy=r.referrerpolicy),r.crossorigin==="use-credentials"?s.credentials="include":r.crossorigin==="anonymous"?s.credentials="omit":s.credentials="same-origin",s}function n(r){if(r.ep)return;r.ep=!0;const s=t(r);fetch(r.href,s)}};su();function ge(){}const gc=i=>i;function au(i,e){for(const t in e)i[t]=e[t];return i}function bc(i){return i()}function Aa(){return Object.create(null)}function wt(i){i.forEach(bc)}function _a(i){return typeof i=="function"}function qe(i,e){return i!=i?e==e:i!==e||i&&typeof i=="object"||typeof i=="function"}function ou(i){return Object.keys(i).length===0}function lu(i,...e){if(i==null)return ge;const t=i.subscribe(...e);return t.unsubscribe?()=>t.unsubscribe():t}function ft(i,e,t){i.$$.on_destroy.push(lu(e,t))}function ns(i){return i??""}function cu(i,e,t){return i.set(t),e}const vc=typeof window<"u";let yc=vc?()=>window.performance.now():()=>Date.now(),ga=vc?i=>requestAnimationFrame(i):ge;const ki=new Set;function wc(i){ki.forEach(e=>{e.c(i)||(ki.delete(e),e.f())}),ki.size!==0&&ga(wc)}function xc(i){let e;return ki.size===0&&ga(wc),{promise:new Promise(t=>{ki.add(e={c:i,f:t})}),abort(){ki.delete(e)}}}function S(i,e){i.appendChild(e)}function Mc(i){if(!i)return document;const e=i.getRootNode?i.getRootNode():i.ownerDocument;return e&&e.host?e:i.ownerDocument}function uu(i){const e=N("style");return fu(Mc(i),e),e.sheet}function fu(i,e){S(i.head||i,e)}function O(i,e,t){i.insertBefore(e,t||null)}function F(i){i.parentNode.removeChild(i)}function Vt(i,e){for(let t=0;t<i.length;t+=1)i[t]&&i[t].d(e)}function N(i){return document.createElement(i)}function Ii(i){return document.createElementNS("http://www.w3.org/2000/svg",i)}function Z(i){return document.createTextNode(i)}function Y(){return Z(" ")}function Zt(){return Z("")}function Oe(i,e,t,n){return i.addEventListener(e,t,n),()=>i.removeEventListener(e,t,n)}function L(i,e,t){t==null?i.removeAttribute(e):i.getAttribute(e)!==t&&i.setAttribute(e,t)}function Sc(i){return i===""?null:+i}function du(i){return Array.from(i.childNodes)}function de(i,e){e=""+e,i.wholeText!==e&&(i.data=e)}function kt(i,e){i.value=e??""}function Bn(i,e,t,n){t===null?i.style.removeProperty(e):i.style.setProperty(e,t,n?"important":"")}function Da(i,e){for(let t=0;t<i.options.length;t+=1){const n=i.options[t];if(n.__value===e){n.selected=!0;return}}i.selectedIndex=-1}function hu(i){const e=i.querySelector(":checked")||i.options[0];return e&&e.__value}function Cc(i,e,{bubbles:t=!1,cancelable:n=!1}={}){const r=document.createEvent("CustomEvent");return r.initCustomEvent(i,t,n,e),r}const is=new Map;let rs=0;function pu(i){let e=5381,t=i.length;for(;t--;)e=(e<<5)-e^i.charCodeAt(t);return e>>>0}function mu(i,e){const t={stylesheet:uu(e),rules:{}};return is.set(i,t),t}function ra(i,e,t,n,r,s,a,o=0){const l=16.666/n;let c=`{
`;for(let _=0;_<=1;_+=l){const g=e+(t-e)*s(_);c+=_*100+`%{${a(g,1-g)}}
`}const u=c+`100% {${a(t,1-t)}}
}`,f=`__svelte_${pu(u)}_${o}`,d=Mc(i),{stylesheet:p,rules:m}=is.get(d)||mu(d,i);m[f]||(m[f]=!0,p.insertRule(`@keyframes ${f} ${u}`,p.cssRules.length));const h=i.style.animation||"";return i.style.animation=`${h?`${h}, `:""}${f} ${n}ms linear ${r}ms 1 both`,rs+=1,f}function Tc(i,e){const t=(i.style.animation||"").split(", "),n=t.filter(e?s=>s.indexOf(e)<0:s=>s.indexOf("__svelte")===-1),r=t.length-n.length;r&&(i.style.animation=n.join(", "),rs-=r,rs||_u())}function _u(){ga(()=>{rs||(is.forEach(i=>{const{stylesheet:e}=i;let t=e.cssRules.length;for(;t--;)e.deleteRule(t);i.rules={}}),is.clear())})}function yr(i,e,t,n){if(!e)return ge;const r=i.getBoundingClientRect();if(e.left===r.left&&e.right===r.right&&e.top===r.top&&e.bottom===r.bottom)return ge;const{delay:s=0,duration:a=300,easing:o=gc,start:l=yc()+s,end:c=l+a,tick:u=ge,css:f}=t(i,{from:e,to:r},n);let d=!0,p=!1,m;function h(){f&&(m=ra(i,0,1,a,s,o,f)),s||(p=!0)}function _(){f&&Tc(i,m),d=!1}return xc(g=>{if(!p&&g>=l&&(p=!0),p&&g>=c&&(u(1,0),_()),!d)return!1;if(p){const v=g-l,b=0+1*o(v/a);u(b,1-b)}return!0}),h(),u(0,1),_}function wr(i){const e=getComputedStyle(i);if(e.position!=="absolute"&&e.position!=="fixed"){const{width:t,height:n}=e,r=i.getBoundingClientRect();i.style.position="absolute",i.style.width=t,i.style.height=n,gu(i,r)}}function gu(i,e){const t=i.getBoundingClientRect();if(e.left!==t.left||e.top!==t.top){const n=getComputedStyle(i),r=n.transform==="none"?"":n.transform;i.style.transform=`${r} translate(${e.left-t.left}px, ${e.top-t.top}px)`}}let pr;function ur(i){pr=i}function ba(){if(!pr)throw new Error("Function called outside component initialization");return pr}function at(i){ba().$$.on_mount.push(i)}function bu(i){ba().$$.on_destroy.push(i)}function ln(){const i=ba();return(e,t,{cancelable:n=!1}={})=>{const r=i.$$.callbacks[e];if(r){const s=Cc(e,t,{cancelable:n});return r.slice().forEach(a=>{a.call(i,s)}),!s.defaultPrevented}return!0}}const rr=[],Ra=[],Qr=[],ka=[],vu=Promise.resolve();let sa=!1;function yu(){sa||(sa=!0,vu.then(Ec))}function fi(i){Qr.push(i)}const Ms=new Set;let Er=0;function Ec(){const i=pr;do{for(;Er<rr.length;){const e=rr[Er];Er++,ur(e),wu(e.$$)}for(ur(null),rr.length=0,Er=0;Ra.length;)Ra.pop()();for(let e=0;e<Qr.length;e+=1){const t=Qr[e];Ms.has(t)||(Ms.add(t),t())}Qr.length=0}while(rr.length);for(;ka.length;)ka.pop()();sa=!1,Ms.clear(),ur(i)}function wu(i){if(i.fragment!==null){i.update(),wt(i.before_update);const e=i.dirty;i.dirty=[-1],i.fragment&&i.fragment.p(i.ctx,e),i.after_update.forEach(fi)}}let Yi;function xu(){return Yi||(Yi=Promise.resolve(),Yi.then(()=>{Yi=null})),Yi}function Ss(i,e,t){i.dispatchEvent(Cc(`${e?"intro":"outro"}${t}`))}const $r=new Set;let Nn;function Ve(){Nn={r:0,c:[],p:Nn}}function Ge(){Nn.r||wt(Nn.c),Nn=Nn.p}function k(i,e){i&&i.i&&($r.delete(i),i.i(e))}function I(i,e,t,n){if(i&&i.o){if($r.has(i))return;$r.add(i),Nn.c.push(()=>{$r.delete(i),n&&(t&&i.d(1),n())}),i.o(e)}else n&&n()}const Mu={duration:0};function ss(i,e,t,n){let r=e(i,t),s=n?0:1,a=null,o=null,l=null;function c(){l&&Tc(i,l)}function u(d,p){const m=d.b-s;return p*=Math.abs(m),{a:s,b:d.b,d:m,duration:p,start:d.start,end:d.start+p,group:d.group}}function f(d){const{delay:p=0,duration:m=300,easing:h=gc,tick:_=ge,css:g}=r||Mu,v={start:yc()+p,b:d};d||(v.group=Nn,Nn.r+=1),a||o?o=v:(g&&(c(),l=ra(i,s,d,m,p,h,g)),d&&_(0,1),a=u(v,m),fi(()=>Ss(i,d,"start")),xc(b=>{if(o&&b>o.start&&(a=u(o,m),o=null,Ss(i,a.b,"start"),g&&(c(),l=ra(i,s,a.b,a.duration,0,h,r.css))),a){if(b>=a.end)_(s=a.b,1-s),Ss(i,a.b,"end"),o||(a.b?c():--a.group.r||wt(a.group.c)),a=null;else if(b>=a.start){const y=b-a.start;s=a.a+a.d*h(y/a.duration),_(s,1-s)}}return!!(a||o)}))}return{run(d){_a(r)?xu().then(()=>{r=r(),f(d)}):f(d)},end(){c(),a=o=null}}}function Su(i,e){i.d(1),e.delete(i.key)}function Cu(i,e){I(i,1,1,()=>{e.delete(i.key)})}function Tu(i,e){i.f(),Su(i,e)}function ds(i,e){i.f(),Cu(i,e)}function xr(i,e,t,n,r,s,a,o,l,c,u,f){let d=i.length,p=s.length,m=d;const h={};for(;m--;)h[i[m].key]=m;const _=[],g=new Map,v=new Map;for(m=p;m--;){const M=f(r,s,m),E=t(M);let x=a.get(E);x?n&&x.p(M,e):(x=c(E,M),x.c()),g.set(E,_[m]=x),E in h&&v.set(E,Math.abs(m-h[E]))}const b=new Set,y=new Set;function w(M){k(M,1),M.m(o,u),a.set(M.key,M),u=M.first,p--}for(;d&&p;){const M=_[p-1],E=i[d-1],x=M.key,C=E.key;M===E?(u=M.first,d--,p--):g.has(C)?!a.has(x)||b.has(x)?w(M):y.has(C)?d--:v.get(x)>v.get(C)?(y.add(x),w(M)):(b.add(C),d--):(l(E,a),d--)}for(;d--;){const M=i[d];g.has(M.key)||l(M,a)}for(;p;)w(_[p-1]);return _}function Eu(i,e){const t={},n={},r={$$scope:1};let s=i.length;for(;s--;){const a=i[s],o=e[s];if(o){for(const l in a)l in o||(n[l]=1);for(const l in o)r[l]||(t[l]=o[l],r[l]=1);i[s]=o}else for(const l in a)r[l]=1}for(const a in n)a in t||(t[a]=void 0);return t}function Lu(i){return typeof i=="object"&&i!==null?i:{}}function Q(i){i&&i.c()}function K(i,e,t,n){const{fragment:r,on_mount:s,on_destroy:a,after_update:o}=i.$$;r&&r.m(e,t),n||fi(()=>{const l=s.map(bc).filter(_a);a?a.push(...l):wt(l),i.$$.on_mount=[]}),o.forEach(fi)}function J(i,e){const t=i.$$;t.fragment!==null&&(wt(t.on_destroy),t.fragment&&t.fragment.d(e),t.on_destroy=t.fragment=null,t.ctx=[])}function Pu(i,e){i.$$.dirty[0]===-1&&(rr.push(i),yu(),i.$$.dirty.fill(0)),i.$$.dirty[e/31|0]|=1<<e%31}function Ye(i,e,t,n,r,s,a,o=[-1]){const l=pr;ur(i);const c=i.$$={fragment:null,ctx:null,props:s,update:ge,not_equal:r,bound:Aa(),on_mount:[],on_destroy:[],on_disconnect:[],before_update:[],after_update:[],context:new Map(e.context||(l?l.$$.context:[])),callbacks:Aa(),dirty:o,skip_bound:!1,root:e.target||l.$$.root};a&&a(c.root);let u=!1;if(c.ctx=t?t(i,e.props||{},(f,d,...p)=>{const m=p.length?p[0]:d;return c.ctx&&r(c.ctx[f],c.ctx[f]=m)&&(!c.skip_bound&&c.bound[f]&&c.bound[f](m),u&&Pu(i,f)),d}):[],c.update(),u=!0,wt(c.before_update),c.fragment=n?n(c.ctx):!1,e.target){if(e.hydrate){const f=du(e.target);c.fragment&&c.fragment.l(f),f.forEach(F)}else c.fragment&&c.fragment.c();e.intro&&k(i.$$.fragment),K(i,e.target,e.anchor,e.customElement),Ec()}ur(l)}class Ze{$destroy(){J(this,1),this.$destroy=ge}$on(e,t){const n=this.$$.callbacks[e]||(this.$$.callbacks[e]=[]);return n.push(t),()=>{const r=n.indexOf(t);r!==-1&&n.splice(r,1)}}$set(e){this.$$set&&!ou(e)&&(this.$$.skip_bound=!0,this.$$set(e),this.$$.skip_bound=!1)}}const _i=[];function Ia(i,e){return{subscribe:Fn(i,e).subscribe}}function Fn(i,e=ge){let t;const n=new Set;function r(o){if(qe(i,o)&&(i=o,t)){const l=!_i.length;for(const c of n)c[1](),_i.push(c,i);if(l){for(let c=0;c<_i.length;c+=2)_i[c][0](_i[c+1]);_i.length=0}}}function s(o){r(o(i))}function a(o,l=ge){const c=[o,l];return n.add(c),n.size===1&&(t=e(r)||ge),o(i),()=>{n.delete(c),n.size===0&&(t(),t=null)}}return{set:r,update:s,subscribe:a}}async function Ne(i,e={}){const t={method:"post",headers:{"Content-Type":"application/json; charset=UTF-8"},body:JSON.stringify(e)},n="snipe-menu";try{return await(await fetch(`https://${n}/${i}`,t)).json()}catch{}}const Au=()=>{const i={showReport:Fn(!1),reportData:Fn({})};return{...i,...{closeReportForm(t=null){i.showReport.set(!1),Ne("closeReport",t)},showReportForm(t){i.showReport.set(!0),i.reportData.set(t)}}}},mr=Au(),Du=await fetch("config.json").then(i=>i.json()).catch(i=>console.log(i)),Ru=await fetch(`locales/${Du.lang}.json`).then(i=>i.json()).catch(i=>console.log(i)),ku=()=>{new Date().getFullYear();const i={show:Fn(!1),data:Fn({}),locales:Ia(Ru),isDev:Ia(!1)},e={closeForm(t=null){i.show.set(!1),Ne("closeMenu",t)},showForm(t){i.show.set(!0),i.data.set(t)},handleKeyUp(t){t.key=="Escape"&&(e.closeForm(),mr.closeReportForm())}};return{...i,...e}},vt=ku(),Iu=()=>{const i={unreadReport:Fn(!1)};return{...i,...{showUnreadReport(){i.unreadReport.set(!0)},hideUnreadReport(t=null){i.unreadReport.set(!1)}}}},aa=Iu(),Nu=()=>{const i={showObject:Fn(!1),gizmoData:Fn({}),gizmoCamData:Fn({})};return{...i,...{closeGizmoObject(t=null){i.showObject.set(!1)},showGizmoObject(t){t.handle&&i.showObject.set(!0),i.gizmoData.set(t)},getCamCoords(t){i.gizmoCamData.set(t)}}}},fr=Nu();function zu(i){const e=document.createElement("textarea");e.value=i,document.body.appendChild(e),e.select(),document.execCommand("copy"),document.body.removeChild(e)}function Fu(){function i(e){switch(e.data.action){case"openMenu":vt.showForm(e.data.data);break;case"forceClose":vt.closeForm();break;case"copytoclipboard":zu(e.data.data);break;case"openUserReportMenu":mr.showReportForm(e.data.data);break;case"forceCloseUserReportMenu":mr.closeReportForm();break;case"showUnreadReport":aa.showUnreadReport();break;case"hideUnreadReport":aa.hideUnreadReport();break;case"showGizmoObject":fr.showGizmoObject(e.data.data);break;case"hideGizmoObject":fr.closeGizmoObject();break;case"gizmo-cam-cords":fr.getCamCoords(e.data.data);break}}at(()=>window.addEventListener("message",i)),bu(()=>window.removeEventListener("message",i))}const Lr=parseFloat;function as(i,e=";"){let t;if(Array.isArray(i))t=i.filter(n=>n);else{t=[];for(const n in i)i[n]&&t.push(`${n}:${i[n]}`)}return t.join(e)}function Ou(i,e,t,n){let r,s;const a="1em";let o,l,c,u="-.125em";const f="visible";return n&&(c="center",s="1.25em"),t&&(r=t),e&&(e=="lg"?(l="1.33333em",o=".75em",u="-.225em"):e=="xs"?l=".75em":e=="sm"?l=".875em":l=e.replace("x","em")),as([as({float:r,width:s,height:a,"line-height":o,"font-size":l,"text-align":c,"vertical-align":u,"transform-origin":"center",overflow:f}),i])}function Uu(i,e,t,n,r,s=1,a="",o=""){let l=1,c=1;return r&&(r=="horizontal"?l=-1:r=="vertical"?c=-1:l=c=-1),as([`translate(${Lr(e)*s}${a},${Lr(t)*s}${a})`,`scale(${l*Lr(i)},${c*Lr(i)})`,n&&`rotate(${n}${o})`]," ")}function Na(i){let e,t,n,r,s,a,o;function l(f,d){return typeof f[7][4]=="string"?Vu:Bu}let c=l(i),u=c(i);return{c(){e=Ii("svg"),t=Ii("g"),n=Ii("g"),u.c(),L(n,"transform",i[10]),L(t,"transform",r=`translate(${i[7][0]/2} ${i[7][1]/2})`),L(t,"transform-origin",s=`${i[7][0]/4} 0`),L(e,"id",i[0]),L(e,"class",a=ns(i[8])+" svelte-1cj2gr0"),L(e,"style",i[9]),L(e,"viewBox",o=`0 0 ${i[7][0]} ${i[7][1]}`),L(e,"aria-hidden","true"),L(e,"role","img"),L(e,"xmlns","http://www.w3.org/2000/svg")},m(f,d){O(f,e,d),S(e,t),S(t,n),u.m(n,null)},p(f,d){c===(c=l(f))&&u?u.p(f,d):(u.d(1),u=c(f),u&&(u.c(),u.m(n,null))),d&1024&&L(n,"transform",f[10]),d&128&&r!==(r=`translate(${f[7][0]/2} ${f[7][1]/2})`)&&L(t,"transform",r),d&128&&s!==(s=`${f[7][0]/4} 0`)&&L(t,"transform-origin",s),d&1&&L(e,"id",f[0]),d&256&&a!==(a=ns(f[8])+" svelte-1cj2gr0")&&L(e,"class",a),d&512&&L(e,"style",f[9]),d&128&&o!==(o=`0 0 ${f[7][0]} ${f[7][1]}`)&&L(e,"viewBox",o)},d(f){f&&F(e),u.d()}}}function Bu(i){let e,t,n,r,s,a,o,l,c,u;return{c(){e=Ii("path"),a=Ii("path"),L(e,"d",t=i[7][4][0]),L(e,"fill",n=i[3]||i[1]||"currentColor"),L(e,"fill-opacity",r=i[6]!=!1?i[4]:i[5]),L(e,"transform",s=`translate(${i[7][0]/-2} ${i[7][1]/-2})`),L(a,"d",o=i[7][4][1]),L(a,"fill",l=i[2]||i[1]||"currentColor"),L(a,"fill-opacity",c=i[6]!=!1?i[5]:i[4]),L(a,"transform",u=`translate(${i[7][0]/-2} ${i[7][1]/-2})`)},m(f,d){O(f,e,d),O(f,a,d)},p(f,d){d&128&&t!==(t=f[7][4][0])&&L(e,"d",t),d&10&&n!==(n=f[3]||f[1]||"currentColor")&&L(e,"fill",n),d&112&&r!==(r=f[6]!=!1?f[4]:f[5])&&L(e,"fill-opacity",r),d&128&&s!==(s=`translate(${f[7][0]/-2} ${f[7][1]/-2})`)&&L(e,"transform",s),d&128&&o!==(o=f[7][4][1])&&L(a,"d",o),d&6&&l!==(l=f[2]||f[1]||"currentColor")&&L(a,"fill",l),d&112&&c!==(c=f[6]!=!1?f[5]:f[4])&&L(a,"fill-opacity",c),d&128&&u!==(u=`translate(${f[7][0]/-2} ${f[7][1]/-2})`)&&L(a,"transform",u)},d(f){f&&F(e),f&&F(a)}}}function Vu(i){let e,t,n,r;return{c(){e=Ii("path"),L(e,"d",t=i[7][4]),L(e,"fill",n=i[1]||i[2]||"currentColor"),L(e,"transform",r=`translate(${i[7][0]/-2} ${i[7][1]/-2})`)},m(s,a){O(s,e,a)},p(s,a){a&128&&t!==(t=s[7][4])&&L(e,"d",t),a&6&&n!==(n=s[1]||s[2]||"currentColor")&&L(e,"fill",n),a&128&&r!==(r=`translate(${s[7][0]/-2} ${s[7][1]/-2})`)&&L(e,"transform",r)},d(s){s&&F(e)}}}function Gu(i){let e,t=i[7][4]&&Na(i);return{c(){t&&t.c(),e=Zt()},m(n,r){t&&t.m(n,r),O(n,e,r)},p(n,[r]){n[7][4]?t?t.p(n,r):(t=Na(n),t.c(),t.m(e.parentNode,e)):t&&(t.d(1),t=null)},i:ge,o:ge,d(n){t&&t.d(n),n&&F(e)}}}function Hu(i,e,t){let{class:n=""}=e,{id:r=""}=e,{style:s=""}=e,{icon:a}=e,{size:o=""}=e,{color:l=""}=e,{fw:c=!1}=e,{pull:u=""}=e,{scale:f=1}=e,{translateX:d=0}=e,{translateY:p=0}=e,{rotate:m=""}=e,{flip:h=!1}=e,{spin:_=!1}=e,{pulse:g=!1}=e,{primaryColor:v=""}=e,{secondaryColor:b=""}=e,{primaryOpacity:y=1}=e,{secondaryOpacity:w=.4}=e,{swapOpacity:M=!1}=e,E,x,C,A;return i.$$set=D=>{"class"in D&&t(11,n=D.class),"id"in D&&t(0,r=D.id),"style"in D&&t(12,s=D.style),"icon"in D&&t(13,a=D.icon),"size"in D&&t(14,o=D.size),"color"in D&&t(1,l=D.color),"fw"in D&&t(15,c=D.fw),"pull"in D&&t(16,u=D.pull),"scale"in D&&t(17,f=D.scale),"translateX"in D&&t(18,d=D.translateX),"translateY"in D&&t(19,p=D.translateY),"rotate"in D&&t(20,m=D.rotate),"flip"in D&&t(21,h=D.flip),"spin"in D&&t(22,_=D.spin),"pulse"in D&&t(23,g=D.pulse),"primaryColor"in D&&t(2,v=D.primaryColor),"secondaryColor"in D&&t(3,b=D.secondaryColor),"primaryOpacity"in D&&t(4,y=D.primaryOpacity),"secondaryOpacity"in D&&t(5,w=D.secondaryOpacity),"swapOpacity"in D&&t(6,M=D.swapOpacity)},i.$$.update=()=>{i.$$.dirty&8192&&t(7,E=a&&a.icon||[0,0,"",[],""]),i.$$.dirty&12584960&&t(8,x=as([n,"svelte-fa",_&&"spin",g&&"pulse"]," ")),i.$$.dirty&118784&&t(9,C=Ou(s,o,u,c)),i.$$.dirty&4063232&&t(10,A=Uu(f,d,p,m,h,512))},[r,l,v,b,y,w,M,E,x,C,A,n,s,a,o,c,u,f,d,p,m,h,_,g]}class It extends Ze{constructor(e){super(),Ye(this,e,Hu,Gu,qe,{class:11,id:0,style:12,icon:13,size:14,color:1,fw:15,pull:16,scale:17,translateX:18,translateY:19,rotate:20,flip:21,spin:22,pulse:23,primaryColor:2,secondaryColor:3,primaryOpacity:4,secondaryOpacity:5,swapOpacity:6})}}function Lc(i){const e=i-1;return e*e*e+1}function Mr(i,{from:e,to:t},n={}){const r=getComputedStyle(i),s=r.transform==="none"?"":r.transform,[a,o]=r.transformOrigin.split(" ").map(parseFloat),l=e.left+e.width*a/t.width-(t.left+a),c=e.top+e.height*o/t.height-(t.top+o),{delay:u=0,duration:f=p=>Math.sqrt(p)*120,easing:d=Lc}=n;return{delay:u,duration:_a(f)?f(Math.sqrt(l*l+c*c)):f,easing:d,css:(p,m)=>{const h=m*l,_=m*c,g=p+m*e.width/t.width,v=p+m*e.height/t.height;return`transform: ${s} translate(${h}px, ${_}px) scale(${g}, ${v});`}}}/*!
 * Font Awesome Free 6.1.2 by @fontawesome - https://fontawesome.com
 * License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License)
 * Copyright 2022 Fonticons, Inc.
 */var Wu={prefix:"fas",iconName:"arrow-right-to-bracket",icon:[512,512,["sign-in"],"f090","M416 32h-64c-17.67 0-32 14.33-32 32s14.33 32 32 32h64c17.67 0 32 14.33 32 32v256c0 17.67-14.33 32-32 32h-64c-17.67 0-32 14.33-32 32s14.33 32 32 32h64c53.02 0 96-42.98 96-96V128C512 74.98 469 32 416 32zM342.6 233.4l-128-128c-12.51-12.51-32.76-12.49-45.25 0c-12.5 12.5-12.5 32.75 0 45.25L242.8 224H32C14.31 224 0 238.3 0 256s14.31 32 32 32h210.8l-73.38 73.38c-12.5 12.5-12.5 32.75 0 45.25s32.75 12.5 45.25 0l128-128C355.1 266.1 355.1 245.9 342.6 233.4z"]},Xu={prefix:"fas",iconName:"arrow-rotate-right",icon:[512,512,[8635,"arrow-right-rotate","arrow-rotate-forward","redo"],"f01e","M496 48V192c0 17.69-14.31 32-32 32H320c-17.69 0-32-14.31-32-32s14.31-32 32-32h63.39c-29.97-39.7-77.25-63.78-127.6-63.78C167.7 96.22 96 167.9 96 256s71.69 159.8 159.8 159.8c34.88 0 68.03-11.03 95.88-31.94c14.22-10.53 34.22-7.75 44.81 6.375c10.59 14.16 7.75 34.22-6.375 44.81c-39.03 29.28-85.36 44.86-134.2 44.86C132.5 479.9 32 379.4 32 256s100.5-223.9 223.9-223.9c69.15 0 134 32.47 176.1 86.12V48c0-17.69 14.31-32 32-32S496 30.31 496 48z"]},ju=Xu,qu={prefix:"fas",iconName:"arrows-rotate",icon:[512,512,[128472,"refresh","sync"],"f021","M464 16c-17.67 0-32 14.31-32 32v74.09C392.1 66.52 327.4 32 256 32C161.5 32 78.59 92.34 49.58 182.2c-5.438 16.81 3.797 34.88 20.61 40.28c16.89 5.5 34.88-3.812 40.3-20.59C130.9 138.5 189.4 96 256 96c50.5 0 96.26 24.55 124.4 64H336c-17.67 0-32 14.31-32 32s14.33 32 32 32h128c17.67 0 32-14.31 32-32V48C496 30.31 481.7 16 464 16zM441.8 289.6c-16.92-5.438-34.88 3.812-40.3 20.59C381.1 373.5 322.6 416 256 416c-50.5 0-96.25-24.55-124.4-64H176c17.67 0 32-14.31 32-32s-14.33-32-32-32h-128c-17.67 0-32 14.31-32 32v144c0 17.69 14.33 32 32 32s32-14.31 32-32v-74.09C119.9 445.5 184.6 480 255.1 480c94.45 0 177.4-60.34 206.4-150.2C467.9 313 458.6 294.1 441.8 289.6z"]},Yu=qu,Zu={prefix:"fas",iconName:"bug",icon:[512,512,[],"f188","M352 96V99.56C352 115.3 339.3 128 323.6 128H188.4C172.7 128 159.1 115.3 159.1 99.56V96C159.1 42.98 202.1 0 255.1 0C309 0 352 42.98 352 96zM41.37 105.4C53.87 92.88 74.13 92.88 86.63 105.4L150.6 169.4C151.3 170 151.9 170.7 152.5 171.4C166.8 164.1 182.9 160 199.1 160H312C329.1 160 345.2 164.1 359.5 171.4C360.1 170.7 360.7 170 361.4 169.4L425.4 105.4C437.9 92.88 458.1 92.88 470.6 105.4C483.1 117.9 483.1 138.1 470.6 150.6L406.6 214.6C405.1 215.3 405.3 215.9 404.6 216.5C410.7 228.5 414.6 241.9 415.7 256H480C497.7 256 512 270.3 512 288C512 305.7 497.7 320 480 320H416C416 344.6 410.5 367.8 400.6 388.6C402.7 389.9 404.8 391.5 406.6 393.4L470.6 457.4C483.1 469.9 483.1 490.1 470.6 502.6C458.1 515.1 437.9 515.1 425.4 502.6L362.3 439.6C337.8 461.4 306.5 475.8 272 479.2V240C272 231.2 264.8 224 255.1 224C247.2 224 239.1 231.2 239.1 240V479.2C205.5 475.8 174.2 461.4 149.7 439.6L86.63 502.6C74.13 515.1 53.87 515.1 41.37 502.6C28.88 490.1 28.88 469.9 41.37 457.4L105.4 393.4C107.2 391.5 109.3 389.9 111.4 388.6C101.5 367.8 96 344.6 96 320H32C14.33 320 0 305.7 0 288C0 270.3 14.33 256 32 256H96.3C97.38 241.9 101.3 228.5 107.4 216.5C106.7 215.9 106 215.3 105.4 214.6L41.37 150.6C28.88 138.1 28.88 117.9 41.37 105.4H41.37z"]},_r={prefix:"fas",iconName:"chevron-down",icon:[448,512,[],"f078","M224 416c-8.188 0-16.38-3.125-22.62-9.375l-192-192c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0L224 338.8l169.4-169.4c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25l-192 192C240.4 412.9 232.2 416 224 416z"]},za={prefix:"fas",iconName:"chevron-left",icon:[320,512,[9001],"f053","M224 480c-8.188 0-16.38-3.125-22.62-9.375l-192-192c-12.5-12.5-12.5-32.75 0-45.25l192-192c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25L77.25 256l169.4 169.4c12.5 12.5 12.5 32.75 0 45.25C240.4 476.9 232.2 480 224 480z"]},Fa={prefix:"fas",iconName:"chevron-right",icon:[320,512,[9002],"f054","M96 480c-8.188 0-16.38-3.125-22.62-9.375c-12.5-12.5-12.5-32.75 0-45.25L242.8 256L73.38 86.63c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0l192 192c12.5 12.5 12.5 32.75 0 45.25l-192 192C112.4 476.9 104.2 480 96 480z"]},os={prefix:"fas",iconName:"chevron-up",icon:[448,512,[],"f077","M416 352c-8.188 0-16.38-3.125-22.62-9.375L224 173.3l-169.4 169.4c-12.5 12.5-32.75 12.5-45.25 0s-12.5-32.75 0-45.25l192-192c12.5-12.5 32.75-12.5 45.25 0l192 192c12.5 12.5 12.5 32.75 0 45.25C432.4 348.9 424.2 352 416 352z"]},Ku={prefix:"fas",iconName:"circle-xmark",icon:[512,512,[61532,"times-circle","xmark-circle"],"f057","M0 256C0 114.6 114.6 0 256 0C397.4 0 512 114.6 512 256C512 397.4 397.4 512 256 512C114.6 512 0 397.4 0 256zM175 208.1L222.1 255.1L175 303C165.7 312.4 165.7 327.6 175 336.1C184.4 346.3 199.6 346.3 208.1 336.1L255.1 289.9L303 336.1C312.4 346.3 327.6 346.3 336.1 336.1C346.3 327.6 346.3 312.4 336.1 303L289.9 255.1L336.1 208.1C346.3 199.6 346.3 184.4 336.1 175C327.6 165.7 312.4 165.7 303 175L255.1 222.1L208.1 175C199.6 165.7 184.4 165.7 175 175C165.7 184.4 165.7 199.6 175 208.1V208.1z"]},Ju=Ku,Qu={prefix:"fas",iconName:"comment-dots",icon:[512,512,[62075,128172,"commenting"],"f4ad","M256 31.1c-141.4 0-255.1 93.12-255.1 208c0 49.62 21.35 94.98 56.97 130.7c-12.5 50.37-54.27 95.27-54.77 95.77c-2.25 2.25-2.875 5.734-1.5 8.734c1.249 3 4.021 4.766 7.271 4.766c66.25 0 115.1-31.76 140.6-51.39c32.63 12.25 69.02 19.39 107.4 19.39c141.4 0 255.1-93.13 255.1-207.1S397.4 31.1 256 31.1zM127.1 271.1c-17.75 0-32-14.25-32-31.1s14.25-32 32-32s32 14.25 32 32S145.7 271.1 127.1 271.1zM256 271.1c-17.75 0-31.1-14.25-31.1-31.1s14.25-32 31.1-32s31.1 14.25 31.1 32S273.8 271.1 256 271.1zM383.1 271.1c-17.75 0-32-14.25-32-31.1s14.25-32 32-32s32 14.25 32 32S401.7 271.1 383.1 271.1z"]},$u={prefix:"fas",iconName:"cubes",icon:[576,512,[],"f1b3","M172.1 40.16L268.1 3.76C280.9-1.089 295.1-1.089 307.9 3.76L403.9 40.16C425.6 48.41 440 69.25 440 92.52V204.7C441.3 205.1 442.6 205.5 443.9 205.1L539.9 242.4C561.6 250.6 576 271.5 576 294.7V413.9C576 436.1 562.9 456.2 542.5 465.1L446.5 507.3C432.2 513.7 415.8 513.7 401.5 507.3L288 457.5L174.5 507.3C160.2 513.7 143.8 513.7 129.5 507.3L33.46 465.1C13.13 456.2 0 436.1 0 413.9V294.7C0 271.5 14.39 250.6 36.15 242.4L132.1 205.1C133.4 205.5 134.7 205.1 136 204.7V92.52C136 69.25 150.4 48.41 172.1 40.16V40.16zM290.8 48.64C289 47.95 286.1 47.95 285.2 48.64L206.8 78.35L287.1 109.5L369.2 78.35L290.8 48.64zM392 210.6V121L309.6 152.6V241.8L392 210.6zM154.8 250.9C153 250.2 150.1 250.2 149.2 250.9L70.81 280.6L152 311.7L233.2 280.6L154.8 250.9zM173.6 455.3L256 419.1V323.2L173.6 354.8V455.3zM342.8 280.6L424 311.7L505.2 280.6L426.8 250.9C425 250.2 422.1 250.2 421.2 250.9L342.8 280.6zM528 413.9V323.2L445.6 354.8V455.3L523.2 421.2C526.1 419.9 528 417.1 528 413.9V413.9z"]},ef={prefix:"fas",iconName:"file-contract",icon:[384,512,[],"f56c","M256 0v128h128L256 0zM224 128L224 0H48C21.49 0 0 21.49 0 48v416C0 490.5 21.49 512 48 512h288c26.51 0 48-21.49 48-48V160h-127.1C238.3 160 224 145.7 224 128zM64 72C64 67.63 67.63 64 72 64h80C156.4 64 160 67.63 160 72v16C160 92.38 156.4 96 152 96h-80C67.63 96 64 92.38 64 88V72zM64 136C64 131.6 67.63 128 72 128h80C156.4 128 160 131.6 160 136v16C160 156.4 156.4 160 152 160h-80C67.63 160 64 156.4 64 152V136zM304 384c8.875 0 16 7.125 16 16S312.9 416 304 416h-47.25c-16.38 0-31.25-9.125-38.63-23.88c-2.875-5.875-8-6.5-10.12-6.5s-7.25 .625-10 6.125l-7.75 15.38C187.6 412.6 181.1 416 176 416H174.9c-6.5-.5-12-4.75-14-11L144 354.6L133.4 386.5C127.5 404.1 111 416 92.38 416H80C71.13 416 64 408.9 64 400S71.13 384 80 384h12.38c4.875 0 9.125-3.125 10.62-7.625l18.25-54.63C124.5 311.9 133.6 305.3 144 305.3s19.5 6.625 22.75 16.5l13.88 41.63c19.75-16.25 54.13-9.75 66 14.12c2 4 6 6.5 10.12 6.5H304z"]},tf={prefix:"fas",iconName:"gear",icon:[512,512,[9881,"cog"],"f013","M495.9 166.6C499.2 175.2 496.4 184.9 489.6 191.2L446.3 230.6C447.4 238.9 448 247.4 448 256C448 264.6 447.4 273.1 446.3 281.4L489.6 320.8C496.4 327.1 499.2 336.8 495.9 345.4C491.5 357.3 486.2 368.8 480.2 379.7L475.5 387.8C468.9 398.8 461.5 409.2 453.4 419.1C447.4 426.2 437.7 428.7 428.9 425.9L373.2 408.1C359.8 418.4 344.1 427 329.2 433.6L316.7 490.7C314.7 499.7 307.7 506.1 298.5 508.5C284.7 510.8 270.5 512 255.1 512C241.5 512 227.3 510.8 213.5 508.5C204.3 506.1 197.3 499.7 195.3 490.7L182.8 433.6C167 427 152.2 418.4 138.8 408.1L83.14 425.9C74.3 428.7 64.55 426.2 58.63 419.1C50.52 409.2 43.12 398.8 36.52 387.8L31.84 379.7C25.77 368.8 20.49 357.3 16.06 345.4C12.82 336.8 15.55 327.1 22.41 320.8L65.67 281.4C64.57 273.1 64 264.6 64 256C64 247.4 64.57 238.9 65.67 230.6L22.41 191.2C15.55 184.9 12.82 175.3 16.06 166.6C20.49 154.7 25.78 143.2 31.84 132.3L36.51 124.2C43.12 113.2 50.52 102.8 58.63 92.95C64.55 85.8 74.3 83.32 83.14 86.14L138.8 103.9C152.2 93.56 167 84.96 182.8 78.43L195.3 21.33C197.3 12.25 204.3 5.04 213.5 3.51C227.3 1.201 241.5 0 256 0C270.5 0 284.7 1.201 298.5 3.51C307.7 5.04 314.7 12.25 316.7 21.33L329.2 78.43C344.1 84.96 359.8 93.56 373.2 103.9L428.9 86.14C437.7 83.32 447.4 85.8 453.4 92.95C461.5 102.8 468.9 113.2 475.5 124.2L480.2 132.3C486.2 143.2 491.5 154.7 495.9 166.6V166.6zM256 336C300.2 336 336 300.2 336 255.1C336 211.8 300.2 175.1 256 175.1C211.8 175.1 176 211.8 176 255.1C176 300.2 211.8 336 256 336z"]},nf=tf,rf={prefix:"fas",iconName:"message",icon:[512,512,["comment-alt"],"f27a","M511.1 63.1v287.1c0 35.25-28.75 63.1-64 63.1h-144l-124.9 93.68c-7.875 5.75-19.12 .0497-19.12-9.7v-83.98h-96c-35.25 0-64-28.75-64-63.1V63.1c0-35.25 28.75-63.1 64-63.1h384C483.2 0 511.1 28.75 511.1 63.1z"]},sf={prefix:"fas",iconName:"palette",icon:[512,512,[127912],"f53f","M512 255.1C512 256.9 511.1 257.8 511.1 258.7C511.6 295.2 478.4 319.1 441.9 319.1H344C317.5 319.1 296 341.5 296 368C296 371.4 296.4 374.7 297 377.9C299.2 388.1 303.5 397.1 307.9 407.8C313.9 421.6 320 435.3 320 449.8C320 481.7 298.4 510.5 266.6 511.8C263.1 511.9 259.5 512 256 512C114.6 512 0 397.4 0 256C0 114.6 114.6 0 256 0C397.4 0 512 114.6 512 256V255.1zM96 255.1C78.33 255.1 64 270.3 64 287.1C64 305.7 78.33 319.1 96 319.1C113.7 319.1 128 305.7 128 287.1C128 270.3 113.7 255.1 96 255.1zM128 191.1C145.7 191.1 160 177.7 160 159.1C160 142.3 145.7 127.1 128 127.1C110.3 127.1 96 142.3 96 159.1C96 177.7 110.3 191.1 128 191.1zM256 63.1C238.3 63.1 224 78.33 224 95.1C224 113.7 238.3 127.1 256 127.1C273.7 127.1 288 113.7 288 95.1C288 78.33 273.7 63.1 256 63.1zM384 191.1C401.7 191.1 416 177.7 416 159.1C416 142.3 401.7 127.1 384 127.1C366.3 127.1 352 142.3 352 159.1C352 177.7 366.3 191.1 384 191.1z"]},af={prefix:"fas",iconName:"paper-plane",icon:[512,512,[61913],"f1d8","M511.6 36.86l-64 415.1c-1.5 9.734-7.375 18.22-15.97 23.05c-4.844 2.719-10.27 4.097-15.68 4.097c-4.188 0-8.319-.8154-12.29-2.472l-122.6-51.1l-50.86 76.29C226.3 508.5 219.8 512 212.8 512C201.3 512 192 502.7 192 491.2v-96.18c0-7.115 2.372-14.03 6.742-19.64L416 96l-293.7 264.3L19.69 317.5C8.438 312.8 .8125 302.2 .0625 289.1s5.469-23.72 16.06-29.77l448-255.1c10.69-6.109 23.88-5.547 34 1.406S513.5 24.72 511.6 36.86z"]},of={prefix:"fas",iconName:"people-group",icon:[640,512,[],"e533","M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"]},lf={prefix:"fas",iconName:"people-pulling",icon:[576,512,[],"e535","M32 48C32 21.49 53.49 0 80 0C106.5 0 128 21.49 128 48C128 74.51 106.5 96 80 96C53.49 96 32 74.51 32 48V48zM118.3 128C130.1 128 143.5 130.5 155.2 135.4L289.3 191.2C302.6 171.1 320.1 156.6 342.7 146.9L353.7 142C374.5 132.8 396.1 128 419.7 128C464.3 128 504.5 154.8 521.6 195.9L536.1 232.7L558.3 243.4C574.1 251.3 580.5 270.5 572.6 286.3C564.7 302.1 545.5 308.5 529.7 300.6L503 287.3C492.7 282.1 484.6 273.4 480.2 262.8L470.6 239.8L451.3 305.3L500.8 359.4C506.2 365.3 510.1 372.4 512 380.2L535 472.2C539.3 489.4 528.9 506.8 511.8 511C494.6 515.3 477.2 504.9 472.1 487.8L450.9 399.6L380.3 322.5C365.5 306.4 359.1 283.9 365.6 262.8L382.5 199.3C381.6 199.7 380.6 200.1 379.7 200.5L368.7 205.4C353.4 212.2 341.4 224.6 335.2 240.1L333.7 243.9C328.6 256.7 316.1 264.4 303 263.1C299.2 263.9 295.4 263.1 291.7 261.5L173.3 212.2L231.2 473.1C235.1 490.3 224.2 507.4 206.9 511.2C189.7 515.1 172.6 504.2 168.8 486.9L138.8 352H123.1L143.6 474.7C146.5 492.2 134.7 508.7 117.3 511.6C99.83 514.5 83.34 502.7 80.44 485.3L56.35 340.8C50.48 347.6 41.75 352 32 352C14.33 352 0 337.7 0 319.1V191.1C0 156.7 28.65 127.1 64 127.1L118.3 128zM416 48C416 21.49 437.5 0 464 0C490.5 0 512 21.49 512 48C512 74.51 490.5 96 464 96C437.5 96 416 74.51 416 48V48zM356.7 344.2L397.4 388.6L382.9 424.8C380.5 430.9 376.9 436.4 372.3 440.9L310.6 502.6C298.1 515.1 277.9 515.1 265.4 502.6C252.9 490.1 252.9 469.9 265.4 457.4L324.7 398L349.7 335.6C351.8 338.6 354.2 341.4 356.7 344.2H356.7z"]},cf={prefix:"fas",iconName:"person-walking",icon:[320,512,[128694,"walking"],"f554","M256 48C256 74.51 234.5 96 208 96C181.5 96 160 74.51 160 48C160 21.49 181.5 0 208 0C234.5 0 256 21.49 256 48zM126.5 199.3C125.6 199.7 124.6 200.1 123.7 200.5L112.7 205.4C97.41 212.2 85.42 224.6 79.22 240.1L77.71 243.9C71.15 260.3 52.53 268.3 36.12 261.7C19.71 255.1 11.73 236.5 18.29 220.1L19.8 216.3C32.19 185.4 56.18 160.5 86.66 146.9L97.66 142C118.5 132.8 140.1 128 163.7 128C208.3 128 248.5 154.8 265.6 195.9L280.1 232.7L302.3 243.4C318.1 251.3 324.5 270.5 316.6 286.3C308.7 302.1 289.5 308.5 273.7 300.6L247 287.3C236.7 282.1 228.6 273.4 224.2 262.8L214.6 239.8L195.3 305.3L244.8 359.4C250.2 365.3 254.1 372.4 256 380.2L279 472.2C283.3 489.4 272.9 506.8 255.8 511C238.6 515.3 221.2 504.9 216.1 487.8L194.9 399.6L124.3 322.5C109.5 306.4 103.1 283.9 109.6 262.8L126.5 199.3zM68.73 398L93.69 335.6C95.84 338.6 98.16 341.4 100.7 344.2L141.4 388.6L126.9 424.8C124.5 430.9 120.9 436.4 116.3 440.9L54.63 502.6C42.13 515.1 21.87 515.1 9.372 502.6C-3.124 490.1-3.124 469.9 9.372 457.4L68.73 398z"]},uf={prefix:"fas",iconName:"play",icon:[384,512,[9654],"f04b","M361 215C375.3 223.8 384 239.3 384 256C384 272.7 375.3 288.2 361 296.1L73.03 472.1C58.21 482 39.66 482.4 24.52 473.9C9.377 465.4 0 449.4 0 432V80C0 62.64 9.377 46.63 24.52 38.13C39.66 29.64 58.21 29.99 73.03 39.04L361 215z"]},ff={prefix:"fas",iconName:"share",icon:[512,512,["arrow-turn-right","mail-forward"],"f064","M503.7 226.2l-176 151.1c-15.38 13.3-39.69 2.545-39.69-18.16V272.1C132.9 274.3 66.06 312.8 111.4 457.8c5.031 16.09-14.41 28.56-28.06 18.62C39.59 444.6 0 383.8 0 322.3c0-152.2 127.4-184.4 288-186.3V56.02c0-20.67 24.28-31.46 39.69-18.16l176 151.1C514.8 199.4 514.8 216.6 503.7 226.2z"]},df={prefix:"fas",iconName:"star",icon:[576,512,[61446,11088],"f005","M381.2 150.3L524.9 171.5C536.8 173.2 546.8 181.6 550.6 193.1C554.4 204.7 551.3 217.3 542.7 225.9L438.5 328.1L463.1 474.7C465.1 486.7 460.2 498.9 450.2 506C440.3 513.1 427.2 514 416.5 508.3L288.1 439.8L159.8 508.3C149 514 135.9 513.1 126 506C116.1 498.9 111.1 486.7 113.2 474.7L137.8 328.1L33.58 225.9C24.97 217.3 21.91 204.7 25.69 193.1C29.46 181.6 39.43 173.2 51.42 171.5L195 150.3L259.4 17.97C264.7 6.954 275.9-.0391 288.1-.0391C300.4-.0391 311.6 6.954 316.9 17.97L381.2 150.3z"]},hf={prefix:"fas",iconName:"stop",icon:[384,512,[9209],"f04d","M384 128v255.1c0 35.35-28.65 64-64 64H64c-35.35 0-64-28.65-64-64V128c0-35.35 28.65-64 64-64H320C355.3 64 384 92.65 384 128z"]},pf={prefix:"fas",iconName:"terminal",icon:[576,512,[],"f120","M9.372 86.63C-3.124 74.13-3.124 53.87 9.372 41.37C21.87 28.88 42.13 28.88 54.63 41.37L246.6 233.4C259.1 245.9 259.1 266.1 246.6 278.6L54.63 470.6C42.13 483.1 21.87 483.1 9.372 470.6C-3.124 458.1-3.124 437.9 9.372 425.4L178.7 256L9.372 86.63zM544 416C561.7 416 576 430.3 576 448C576 465.7 561.7 480 544 480H256C238.3 480 224 465.7 224 448C224 430.3 238.3 416 256 416H544z"]},mf={prefix:"fas",iconName:"video",icon:[576,512,["video-camera"],"f03d","M384 112v288c0 26.51-21.49 48-48 48h-288c-26.51 0-48-21.49-48-48v-288c0-26.51 21.49-48 48-48h288C362.5 64 384 85.49 384 112zM576 127.5v256.9c0 25.5-29.17 40.39-50.39 25.79L416 334.7V177.3l109.6-75.56C546.9 87.13 576 102.1 576 127.5z"]},Pc={prefix:"fas",iconName:"x",icon:[384,512,[120],"58","M376.6 427.5c11.31 13.58 9.484 33.75-4.094 45.06c-5.984 4.984-13.25 7.422-20.47 7.422c-9.172 0-18.27-3.922-24.59-11.52L192 305.1l-135.4 162.5c-6.328 7.594-15.42 11.52-24.59 11.52c-7.219 0-14.48-2.438-20.47-7.422c-13.58-11.31-15.41-31.48-4.094-45.06l142.9-171.5L7.422 84.5C-3.891 70.92-2.063 50.75 11.52 39.44c13.56-11.34 33.73-9.516 45.06 4.094L192 206l135.4-162.5c11.3-13.58 31.48-15.42 45.06-4.094c13.58 11.31 15.41 31.48 4.094 45.06l-142.9 171.5L376.6 427.5z"]};function ls(i,{delay:e=0,duration:t=400,easing:n=Lc}={}){const r=getComputedStyle(i),s=+r.opacity,a=parseFloat(r.height),o=parseFloat(r.paddingTop),l=parseFloat(r.paddingBottom),c=parseFloat(r.marginTop),u=parseFloat(r.marginBottom),f=parseFloat(r.borderTopWidth),d=parseFloat(r.borderBottomWidth);return{delay:e,duration:t,easing:n,css:p=>`overflow: hidden;opacity: ${Math.min(p*20,1)*s};height: ${p*a}px;padding-top: ${p*o}px;padding-bottom: ${p*l}px;margin-top: ${p*c}px;margin-bottom: ${p*u}px;border-top-width: ${p*f}px;border-bottom-width: ${p*d}px;`}}/*!
 * Font Awesome Free 6.1.2 by @fontawesome - https://fontawesome.com
 * License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License)
 * Copyright 2022 Fonticons, Inc.
 */var _f={prefix:"far",iconName:"star",icon:[576,512,[61446,11088],"f005","M287.9 0C297.1 0 305.5 5.25 309.5 13.52L378.1 154.8L531.4 177.5C540.4 178.8 547.8 185.1 550.7 193.7C553.5 202.4 551.2 211.9 544.8 218.2L433.6 328.4L459.9 483.9C461.4 492.9 457.7 502.1 450.2 507.4C442.8 512.7 432.1 513.4 424.9 509.1L287.9 435.9L150.1 509.1C142.9 513.4 133.1 512.7 125.6 507.4C118.2 502.1 114.5 492.9 115.1 483.9L142.2 328.4L31.11 218.2C24.65 211.9 22.36 202.4 25.2 193.7C28.03 185.1 35.5 178.8 44.49 177.5L197.7 154.8L266.3 13.52C270.4 5.249 278.7 0 287.9 0L287.9 0zM287.9 78.95L235.4 187.2C231.9 194.3 225.1 199.3 217.3 200.5L98.98 217.9L184.9 303C190.4 308.5 192.9 316.4 191.6 324.1L171.4 443.7L276.6 387.5C283.7 383.7 292.2 383.7 299.2 387.5L404.4 443.7L384.2 324.1C382.9 316.4 385.5 308.5 391 303L476.9 217.9L358.6 200.5C350.7 199.3 343.9 194.3 340.5 187.2L287.9 78.95z"]};function gf(i){let e,t,n;return{c(){e=N("div"),t=N("span"),L(t,"class",n=ns(i[0]?"loader":"small-loader")+" svelte-s46sr9"),L(t,"style",""),L(e,"id","loader-id"),L(e,"class","loader-wrapper svelte-s46sr9")},m(r,s){O(r,e,s),S(e,t)},p(r,[s]){s&1&&n!==(n=ns(r[0]?"loader":"small-loader")+" svelte-s46sr9")&&L(t,"class",n)},i:ge,o:ge,d(r){r&&F(e)}}}function bf(i,e,t){let{marginLeft:n="40%",marginRight:r="",marginTop:s="50%",isBig:a=!1}=e;return at(()=>{const o=document.getElementById("loader-id");n!==""&&(o.style.marginLeft=n),r!==""&&(o.style.marginRight=r),s!==""&&(o.style.marginTop=s)}),i.$$set=o=>{"marginLeft"in o&&t(1,n=o.marginLeft),"marginRight"in o&&t(2,r=o.marginRight),"marginTop"in o&&t(3,s=o.marginTop),"isBig"in o&&t(0,a=o.isBig)},[a,n,r,s]}class dt extends Ze{constructor(e){super(),Ye(this,e,bf,gf,qe,{marginLeft:1,marginRight:2,marginTop:3,isBig:0})}}function Oa(i,e,t){const n=i.slice();return n[14]=e[t],n}function Ua(i){let e,t=i[5],n=[];for(let r=0;r<t.length;r+=1)n[r]=Ba(Oa(i,t,r));return{c(){e=N("div");for(let r=0;r<n.length;r+=1)n[r].c();L(e,"class","dropdown-menu")},m(r,s){O(r,e,s);for(let a=0;a<n.length;a+=1)n[a].m(e,null)},p(r,s){if(s&288){t=r[5];let a;for(a=0;a<t.length;a+=1){const o=Oa(r,t,a);n[a]?n[a].p(o,s):(n[a]=Ba(o),n[a].c(),n[a].m(e,null))}for(;a<n.length;a+=1)n[a].d(1);n.length=t.length}},d(r){r&&F(e),Vt(n,r)}}}function Ba(i){let e,t,n=i[14].id+"",r,s,a=i[14].name+"",o,l,c;function u(){return i[12](i[14])}return{c(){e=N("p"),t=Z("("),r=Z(n),s=Z(") "),o=Z(a)},m(f,d){O(f,e,d),S(e,t),S(e,r),S(e,s),S(e,o),l||(c=Oe(e,"click",u),l=!0)},p(f,d){i=f,d&32&&n!==(n=i[14].id+"")&&de(r,n),d&32&&a!==(a=i[14].name+"")&&de(o,a)},d(f){f&&F(e),l=!1,c()}}}function vf(i){let e,t,n,r,s,a,o,l,c,u,f,d,p,m,h;f=new It({props:{icon:_r,class:"txt-xs dropdown-chevron"}});let _=i[4]&&Ua(i);return{c(){e=N("div"),t=N("p"),n=Z(i[0]),r=Z(":"),s=Y(),a=N("div"),o=N("div"),l=N("input"),c=Y(),u=N("div"),Q(f.$$.fragment),d=Y(),_&&_.c(),L(t,"class","block txt-sm panel-labels"),L(l,"id",i[1]),L(l,"type","text"),L(l,"class","panel-inputs txt-sm p-2"),L(l,"placeholder",i[2]),L(o,"class","relative"),L(a,"class","dropdown")},m(g,v){O(g,e,v),S(e,t),S(t,n),S(t,r),S(e,s),S(e,a),S(a,o),S(o,l),kt(l,i[3]),S(o,c),S(o,u),K(f,u,null),S(a,d),_&&_.m(a,null),p=!0,m||(h=[Oe(l,"input",i[11]),Oe(l,"click",i[6]),Oe(l,"keyup",i[7]),Oe(u,"click",i[6])],m=!0)},p(g,[v]){(!p||v&1)&&de(n,g[0]),(!p||v&2)&&L(l,"id",g[1]),(!p||v&4)&&L(l,"placeholder",g[2]),v&8&&l.value!==g[3]&&kt(l,g[3]),g[4]?_?_.p(g,v):(_=Ua(g),_.c(),_.m(a,null)):_&&(_.d(1),_=null)},i(g){p||(k(f.$$.fragment,g),p=!0)},o(g){I(f.$$.fragment,g),p=!1},d(g){g&&F(e),J(f),_&&_.d(),m=!1,wt(h)}}}function yf(i,e,t){const n=ln();let{ddLabel:r,dropdownList:s,ddId:a,placeholder:o="",selectedValue:l}=e,c="",u=!1,f=[];at(()=>{t(5,f=s)});function d(){u?(document.getElementById(a).style.borderBottomLeftRadius="0.2vw",document.getElementById(a).style.borderBottomRightRadius="0.2vw"):(document.getElementById(a).style.borderBottomLeftRadius="0",document.getElementById(a).style.borderBottomRightRadius="0"),t(4,u=!u)}function p(){t(4,u=!0),t(5,f=s.filter(g=>{let v=g.name.toLocaleLowerCase(),b=g.id.toString().toLocaleLowerCase();if(v.includes(c.toLocaleLowerCase())||b.includes(c.toLocaleLowerCase()))return g}))}function m(g){t(3,c=g.name),document.getElementById(a).style.borderBottomLeftRadius="0.2vw",document.getElementById(a).style.borderBottomRightRadius="0.2vw",t(4,u=!1),n("searchable-dd-selected-value",g)}function h(){c=this.value,t(3,c)}const _=g=>m(g);return i.$$set=g=>{"ddLabel"in g&&t(0,r=g.ddLabel),"dropdownList"in g&&t(9,s=g.dropdownList),"ddId"in g&&t(1,a=g.ddId),"placeholder"in g&&t(2,o=g.placeholder),"selectedValue"in g&&t(10,l=g.selectedValue)},[r,a,o,c,u,f,d,p,m,s,l,h,_]}class bn extends Ze{constructor(e){super(),Ye(this,e,yf,vf,qe,{ddLabel:0,dropdownList:9,ddId:1,placeholder:2,selectedValue:10})}}function wf(i){let e,t,n,r,s,a,o,l;return{c(){e=N("p"),t=Z(i[2]),n=Z(":"),r=Y(),s=N("input"),L(e,"class","block txt-sm panel-labels"),L(s,"id",i[3]),L(s,"type","text"),L(s,"placeholder",i[1]),L(s,"style","width=auto;"),L(s,"class",a="panel-inputs "+i[4])},m(c,u){O(c,e,u),S(e,t),S(e,n),O(c,r,u),O(c,s,u),kt(s,i[0]),o||(l=[Oe(s,"input",i[7]),Oe(s,"keyup",i[5])],o=!0)},p(c,[u]){u&4&&de(t,c[2]),u&8&&L(s,"id",c[3]),u&2&&L(s,"placeholder",c[1]),u&16&&a!==(a="panel-inputs "+c[4])&&L(s,"class",a),u&1&&s.value!==c[0]&&kt(s,c[0])},i:ge,o:ge,d(c){c&&F(e),c&&F(r),c&&F(s),o=!1,wt(l)}}}function xf(i,e,t){let{placeholder:n="",label:r="",inputId:s,inputValue:a="",className:o="block",width:l="90%"}=e;const c=ln();at(()=>{const d=document.getElementById(s);d.style.width=l});function u(){c("input-value-update",a)}function f(){a=this.value,t(0,a)}return i.$$set=d=>{"placeholder"in d&&t(1,n=d.placeholder),"label"in d&&t(2,r=d.label),"inputId"in d&&t(3,s=d.inputId),"inputValue"in d&&t(0,a=d.inputValue),"className"in d&&t(4,o=d.className),"width"in d&&t(6,l=d.width)},[a,n,r,s,o,u,l,f]}class Tn extends Ze{constructor(e){super(),Ye(this,e,xf,wf,qe,{placeholder:1,label:2,inputId:3,inputValue:0,className:4,width:6})}}function Mf(i){let e,t,n,r;return{c(){e=N("button"),t=Z(i[0]),L(e,"id",i[3]),L(e,"class",i[1]),e.disabled=i[2]},m(s,a){O(s,e,a),S(e,t),n||(r=Oe(e,"click",i[4]),n=!0)},p(s,[a]){a&1&&de(t,s[0]),a&8&&L(e,"id",s[3]),a&2&&L(e,"class",s[1]),a&4&&(e.disabled=s[2])},i:ge,o:ge,d(s){s&&F(e),n=!1,r()}}}function Sf(i,e,t){const n=ln();let{buttonLabel:r,className:s="block panel-btns txt-xs",btnDisabled:a=!0,btnId:o}=e;function l(){n("button-clicked")}return i.$$set=c=>{"buttonLabel"in c&&t(0,r=c.buttonLabel),"className"in c&&t(1,s=c.className),"btnDisabled"in c&&t(2,a=c.btnDisabled),"btnId"in c&&t(3,o=c.btnId)},[r,s,a,o,l]}class gt extends Ze{constructor(e){super(),Ye(this,e,Sf,Mf,qe,{buttonLabel:0,className:1,btnDisabled:2,btnId:3})}}function Cf(i){let e,t,n,r,s,a,o;return{c(){e=N("div"),t=N("input"),n=Y(),r=N("p"),s=Z(i[1]),L(t,"type","checkbox"),L(t,"class","cursor-pointer"),L(t,"id",i[2]),L(t,"name",i[2]),L(r,"class","inline-block txt-sm panel-labels pleft-1 ptop-1"),L(e,"class","checkboxes")},m(l,c){O(l,e,c),S(e,t),kt(t,i[0]),S(e,n),S(e,r),S(r,s),a||(o=[Oe(t,"change",i[4]),Oe(t,"click",i[3])],a=!0)},p(l,[c]){c&4&&L(t,"id",l[2]),c&4&&L(t,"name",l[2]),c&1&&kt(t,l[0]),c&2&&de(s,l[1])},i:ge,o:ge,d(l){l&&F(e),a=!1,wt(o)}}}function Tf(i,e,t){const n=ln();let{checkboxValue:r,checkboxLabel:s,checkboxId:a}=e;function o(){t(0,r=!r),n("checkbox-clicked",r)}function l(){r=this.value,t(0,r)}return i.$$set=c=>{"checkboxValue"in c&&t(0,r=c.checkboxValue),"checkboxLabel"in c&&t(1,s=c.checkboxLabel),"checkboxId"in c&&t(2,a=c.checkboxId)},[r,s,a,o,l]}class cs extends Ze{constructor(e){super(),Ye(this,e,Tf,Cf,qe,{checkboxValue:0,checkboxLabel:1,checkboxId:2})}}function Ef(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Lf(i){let e,t,n,r,s,a,o,l,c,u;return e=new bn({props:{ddLabel:i[0].vehicle,dropdownList:i[3],ddId:"spawn-car-dd-input",placeholder:i[0].vehicle,selectedValue:i[4]}}),e.$on("searchable-dd-selected-value",i[13]),n=new Tn({props:{placeholder:i[0].override_placeholder,label:i[0].override,inputId:"spawn-car-override-input",inputValue:i[8]}}),n.$on("input-value-update",i[14]),s=new cs({props:{checkboxValue:i[6],checkboxLabel:i[0].max_mods,checkboxId:i[6]}}),s.$on("checkbox-clicked",i[15]),o=new cs({props:{checkboxValue:i[7],checkboxLabel:i[0].seat_vehicle,checkboxId:i[7]}}),o.$on("checkbox-clicked",i[16]),c=new gt({props:{buttonLabel:i[0].submit,btnDisabled:i[5],btnId:"submit-btn-spawn-car"}}),c.$on("button-clicked",i[12]),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),Q(s.$$.fragment),a=Y(),Q(o.$$.fragment),l=Y(),Q(c.$$.fragment)},m(f,d){K(e,f,d),O(f,t,d),K(n,f,d),O(f,r,d),K(s,f,d),O(f,a,d),K(o,f,d),O(f,l,d),K(c,f,d),u=!0},p(f,d){const p={};d&1&&(p.ddLabel=f[0].vehicle),d&8&&(p.dropdownList=f[3]),d&1&&(p.placeholder=f[0].vehicle),d&16&&(p.selectedValue=f[4]),e.$set(p);const m={};d&1&&(m.placeholder=f[0].override_placeholder),d&1&&(m.label=f[0].override),d&256&&(m.inputValue=f[8]),n.$set(m);const h={};d&64&&(h.checkboxValue=f[6]),d&1&&(h.checkboxLabel=f[0].max_mods),d&64&&(h.checkboxId=f[6]),s.$set(h);const _={};d&128&&(_.checkboxValue=f[7]),d&1&&(_.checkboxLabel=f[0].seat_vehicle),d&128&&(_.checkboxId=f[7]),o.$set(_);const g={};d&1&&(g.buttonLabel=f[0].submit),d&32&&(g.btnDisabled=f[5]),c.$set(g)},i(f){u||(k(e.$$.fragment,f),k(n.$$.fragment,f),k(s.$$.fragment,f),k(o.$$.fragment,f),k(c.$$.fragment,f),u=!0)},o(f){I(e.$$.fragment,f),I(n.$$.fragment,f),I(s.$$.fragment,f),I(o.$$.fragment,f),I(c.$$.fragment,f),u=!1},d(f){J(e,f),f&&F(t),J(n,f),f&&F(r),J(s,f),f&&F(a),J(o,f),f&&F(l),J(c,f)}}}function Pf(i){let e,t,n,r;const s=[Lf,Ef],a=[];function o(l,c){return!l[1]&&!l[2]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Af(i,e,t){let n,{localeConsts:r}=e,{isDev:s}=vt;ft(i,s,w=>t(18,n=w));let a=!1,o=!1,l=[],c="",u=!0,f=!1,d=!1,p="";at(async()=>{t(2,o=!0),n?t(3,l=[{id:1,name:"Sakshi"},{id:2,name:"Pushkar"},{id:3,name:"Monu"},{id:4,name:"Chinu"},{id:5,name:"Vaishnavi"},{id:6,name:"Anvi"},{id:7,name:"Lalla"}]):t(3,l=await Ne("getAllVehicles")),t(2,o=!1)});function m(w){t(4,c=w.detail),c!==""&&t(5,u=!1)}function h(){p.trim(),p.trim()!==""?t(5,u=!1):t(5,u=!0)}async function _(){t(1,a=!0),await Ne("spawncardata",{selectedPlayer:c,override:p,maxMods:f,seatValue:d}),t(5,u=!0),t(4,c=""),t(6,f=!1),t(7,d=!1),t(8,p=""),t(1,a=!1)}const g=w=>m(w),v=w=>{t(8,p=w.detail),h()},b=w=>t(6,f=w.detail),y=w=>t(7,d=w.detail);return i.$$set=w=>{"localeConsts"in w&&t(0,r=w.localeConsts)},[r,a,o,l,c,u,f,d,p,s,m,h,_,g,v,b,y]}class Df extends Ze{constructor(e){super(),Ye(this,e,Af,Pf,qe,{localeConsts:0})}}function Rf(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function kf(i){let e,t,n,r;return e=new Tn({props:{placeholder:i[6],label:i[5],inputId:"announce-input",inputValue:i[1]}}),e.$on("input-value-update",i[10]),n=new gt({props:{buttonLabel:i[0].submit,btnDisabled:i[2],btnId:"submit-btn-announce"}}),n.$on("button-clicked",i[8]),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment)},m(s,a){K(e,s,a),O(s,t,a),K(n,s,a),r=!0},p(s,a){const o={};a&64&&(o.placeholder=s[6]),a&32&&(o.label=s[5]),a&2&&(o.inputValue=s[1]),e.$set(o);const l={};a&1&&(l.buttonLabel=s[0].submit),a&4&&(l.btnDisabled=s[2]),n.$set(l)},i(s){r||(k(e.$$.fragment,s),k(n.$$.fragment,s),r=!0)},o(s){I(e.$$.fragment,s),I(n.$$.fragment,s),r=!1},d(s){J(e,s),s&&F(t),J(n,s)}}}function If(i){let e,t,n,r;const s=[kf,Rf],a=[];function o(l,c){return!l[3]&&!l[4]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Nf(i,e,t){let{title:n,localeConsts:r}=e,s="",a=!0,o=!1,l=!1,c="",u="",f="";at(async()=>{t(4,l=!0),m(),t(4,l=!1)});function d(){t(2,a=s.trim()==="")}async function p(){t(3,o=!0);let _={};if(n===r.search_by_citizen_id){const v=parseInt(s);if(isNaN(v)){t(3,o=!1),t(1,s="");return}_={citizenId:v}}else _={announcement:s};const g=await Ne(c,_);r.search_by_citizen_id,t(3,o=!1),t(1,s="")}function m(){n===r.Announce?(t(1,s=""),c="announce",t(5,u=r.announce),t(6,f=r.announce_placeholder)):n===r.search_by_citizen_id&&(t(1,s=""),c="searchCitizenId",t(5,u=r.citizen_id_label),t(6,f=r.search_placeholder))}const h=_=>{t(1,s=_.detail),d()};return i.$$set=_=>{"title"in _&&t(9,n=_.title),"localeConsts"in _&&t(0,r=_.localeConsts)},[r,s,a,o,l,u,f,d,p,n,h]}class zf extends Ze{constructor(e){super(),Ye(this,e,Nf,If,qe,{title:9,localeConsts:0})}}function Ff(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Of(i){let e,t,n,r,s,a;e=new Tn({props:{placeholder:"10.00,10.00,10.00",label:i[0].coordinates_label,inputId:"teleport-coords-input",inputValue:i[1]}}),e.$on("input-value-update",i[7]),n=new gt({props:{buttonLabel:i[0].submit,btnDisabled:i[2],btnId:"submit-btn-teleport-coords"}}),n.$on("button-clicked",i[6]);let o=i[4]!==""&&Va(i);return{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),o&&o.c(),s=Zt()},m(l,c){K(e,l,c),O(l,t,c),K(n,l,c),O(l,r,c),o&&o.m(l,c),O(l,s,c),a=!0},p(l,c){const u={};c&1&&(u.label=l[0].coordinates_label),c&2&&(u.inputValue=l[1]),e.$set(u);const f={};c&1&&(f.buttonLabel=l[0].submit),c&4&&(f.btnDisabled=l[2]),n.$set(f),l[4]!==""?o?o.p(l,c):(o=Va(l),o.c(),o.m(s.parentNode,s)):o&&(o.d(1),o=null)},i(l){a||(k(e.$$.fragment,l),k(n.$$.fragment,l),a=!0)},o(l){I(e.$$.fragment,l),I(n.$$.fragment,l),a=!1},d(l){J(e,l),l&&F(t),J(n,l),l&&F(r),o&&o.d(l),l&&F(s)}}}function Va(i){let e,t;return{c(){e=N("p"),t=Z(i[4]),L(e,"class","input-error")},m(n,r){O(n,e,r),S(e,t)},p(n,r){r&16&&de(t,n[4])},d(n){n&&F(e)}}}function Uf(i){let e,t,n,r;const s=[Of,Ff],a=[];function o(l,c){return l[3]?1:0}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Bf(i,e,t){let{localeConsts:n}=e,r="",s=!0,a=!1,o="";function l(){t(2,s=r.trim()===""||r.includes(" "))}async function c(){t(3,a=!0);const f=r.split(",");if(f.length!==3)return t(4,o=n.enter_coords_error_msg),t(3,a=!1),o;for(let p=0;p<f.length;p++)if(f[p].split(".").length!==2)return t(4,o=n.coords_decimal_error_msg),t(3,a=!1),o;const d={xcoord:f[0],ycoord:f[1],zcoord:f[2]};await Ne("teleportcoords",d),t(3,a=!1),t(1,r=""),t(4,o="")}const u=f=>{t(1,r=f.detail),l()};return i.$$set=f=>{"localeConsts"in f&&t(0,n=f.localeConsts)},[n,r,s,a,o,l,c,u]}class Vf extends Ze{constructor(e){super(),Ye(this,e,Bf,Uf,qe,{localeConsts:0})}}function Gf(i){let e,t,n,r,s,a,o,l;return{c(){e=N("p"),t=Z(i[2]),n=Z(":"),r=Y(),s=N("input"),L(e,"class","block txt-sm panel-labels"),L(s,"id",i[3]),L(s,"type","number"),L(s,"placeholder",i[1]),L(s,"style","width=auto;"),L(s,"class",a="panel-inputs "+i[4])},m(c,u){O(c,e,u),S(e,t),S(e,n),O(c,r,u),O(c,s,u),kt(s,i[0]),o||(l=[Oe(s,"input",i[10]),Oe(s,"keyup",i[5])],o=!0)},p(c,[u]){u&4&&de(t,c[2]),u&8&&L(s,"id",c[3]),u&2&&L(s,"placeholder",c[1]),u&16&&a!==(a="panel-inputs "+c[4])&&L(s,"class",a),u&1&&Sc(s.value)!==c[0]&&kt(s,c[0])},i:ge,o:ge,d(c){c&&F(e),c&&F(r),c&&F(s),o=!1,wt(l)}}}function Hf(i,e,t){let{placeholder:n="",label:r="",inputId:s,inputValue:a,className:o="block",width:l="90%",pattern:c="",step:u="",min:f=""}=e;const d=ln();at(()=>{const h=document.getElementById(s);h.style.width=l,c.trim()!==""&&h.setAttribute("pattern",c),u.trim()!==""&&h.setAttribute("step",u),f.trim()!==""&&h.setAttribute("min",u)});function p(){d("input-value-update",a)}function m(){a=Sc(this.value),t(0,a)}return i.$$set=h=>{"placeholder"in h&&t(1,n=h.placeholder),"label"in h&&t(2,r=h.label),"inputId"in h&&t(3,s=h.inputId),"inputValue"in h&&t(0,a=h.inputValue),"className"in h&&t(4,o=h.className),"width"in h&&t(6,l=h.width),"pattern"in h&&t(7,c=h.pattern),"step"in h&&t(8,u=h.step),"min"in h&&t(9,f=h.min)},[a,n,r,s,o,p,l,c,u,f,m]}class Oi extends Ze{constructor(e){super(),Ye(this,e,Hf,Gf,qe,{placeholder:1,label:2,inputId:3,inputValue:0,className:4,width:6,pattern:7,step:8,min:9})}}function Wf(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Xf(i){let e,t,n,r,s,a,o,l;return e=new bn({props:{ddLabel:i[0].player,dropdownList:i[3],ddId:"give-money-player-dd-input",placeholder:i[0].player_placeholder,selectedValue:i[4]}}),e.$on("searchable-dd-selected-value",i[19]),n=new bn({props:{ddLabel:i[9],dropdownList:i[6],ddId:"give-money-item-dd-input",placeholder:i[0].search_placeholder,selectedValue:i[7]}}),n.$on("searchable-dd-selected-value",i[20]),s=new Oi({props:{label:i[0].amount,inputId:"give-money-input",inputValue:i[11],className:"small-panel-inputs txt-sm p-1",width:"40%",step:"1",min:"1"}}),s.$on("input-value-update",i[21]),o=new gt({props:{buttonLabel:i[10],btnDisabled:i[5]||i[8]||i[12],btnId:"submit-btn-give-money"}}),o.$on("button-clicked",i[17]),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),Q(s.$$.fragment),a=Y(),Q(o.$$.fragment)},m(c,u){K(e,c,u),O(c,t,u),K(n,c,u),O(c,r,u),K(s,c,u),O(c,a,u),K(o,c,u),l=!0},p(c,u){const f={};u&1&&(f.ddLabel=c[0].player),u&8&&(f.dropdownList=c[3]),u&1&&(f.placeholder=c[0].player_placeholder),u&16&&(f.selectedValue=c[4]),e.$set(f);const d={};u&512&&(d.ddLabel=c[9]),u&64&&(d.dropdownList=c[6]),u&1&&(d.placeholder=c[0].search_placeholder),u&128&&(d.selectedValue=c[7]),n.$set(d);const p={};u&1&&(p.label=c[0].amount),u&2048&&(p.inputValue=c[11]),s.$set(p);const m={};u&1024&&(m.buttonLabel=c[10]),u&4384&&(m.btnDisabled=c[5]||c[8]||c[12]),o.$set(m)},i(c){l||(k(e.$$.fragment,c),k(n.$$.fragment,c),k(s.$$.fragment,c),k(o.$$.fragment,c),l=!0)},o(c){I(e.$$.fragment,c),I(n.$$.fragment,c),I(s.$$.fragment,c),I(o.$$.fragment,c),l=!1},d(c){J(e,c),c&&F(t),J(n,c),c&&F(r),J(s,c),c&&F(a),J(o,c)}}}function jf(i){let e,t,n,r;const s=[Xf,Wf],a=[];function o(l,c){return!l[1]&&!l[2]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function qf(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,A=>t(22,n=A));let o=!1,l=!1,c=[],u="",f=!0,d=[],p="",m=!0,h="",_="",g,v=!0;at(async()=>{t(2,l=!0),n?t(3,c=[{id:1,name:"Sakshi"},{id:2,name:"Pushkar"},{id:3,name:"Monu"},{id:4,name:"Chinu"},{id:5,name:"Vaishnavi"},{id:6,name:"Anvi"},{id:7,name:"Lalla"}]):t(3,c=await Ne("getPlayerList")),r==s.Give_Item?(t(6,d=await Ne("getAllItems")),t(9,h=s.itemLabel),t(10,_=s.give_item_btn)):(t(6,d=[{id:"cash",name:"Cash"},{id:"bank",name:"Bank"}]),t(9,h=s.money_type),t(10,_=s.give_money_btn)),t(2,l=!1)});function b(A){t(4,u=A.detail),u!==""&&t(5,f=!1)}function y(A){t(7,p=A.detail),p!==""&&t(8,m=!1)}function w(){t(12,v=!Number.isInteger(g)||g<=0)}async function M(){t(1,o=!0);const A={selectedPlayer:u,selectedItem:p,amount:g};r==s.Give_Item?await Ne("giveitem",A):(await Ne("giveMoney",A),t(5,f=!0),t(8,m=!0),t(4,u=""),t(7,p=""),t(11,g="")),t(1,o=!1)}const E=A=>b(A),x=A=>y(A),C=A=>{t(11,g=A.detail),w()};return i.$$set=A=>{"title"in A&&t(18,r=A.title),"localeConsts"in A&&t(0,s=A.localeConsts)},[s,o,l,c,u,f,d,p,m,h,_,g,v,a,b,y,w,M,r,E,x,C]}class Yf extends Ze{constructor(e){super(),Ye(this,e,qf,jf,qe,{title:18,localeConsts:0})}}function Zf(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Kf(i){let e,t,n,r,s,a;e=new Tn({props:{placeholder:i[0].max_8_chars,label:i[0].plate_number,inputId:"change-plate-input",inputValue:i[1]}}),e.$on("input-value-update",i[7]),n=new gt({props:{buttonLabel:i[0].submit,btnDisabled:i[2],btnId:"submit-btn-change-plate"}}),n.$on("button-clicked",i[6]);let o=i[4]!==""&&Ga(i);return{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),o&&o.c(),s=Zt()},m(l,c){K(e,l,c),O(l,t,c),K(n,l,c),O(l,r,c),o&&o.m(l,c),O(l,s,c),a=!0},p(l,c){const u={};c&1&&(u.placeholder=l[0].max_8_chars),c&1&&(u.label=l[0].plate_number),c&2&&(u.inputValue=l[1]),e.$set(u);const f={};c&1&&(f.buttonLabel=l[0].submit),c&4&&(f.btnDisabled=l[2]),n.$set(f),l[4]!==""?o?o.p(l,c):(o=Ga(l),o.c(),o.m(s.parentNode,s)):o&&(o.d(1),o=null)},i(l){a||(k(e.$$.fragment,l),k(n.$$.fragment,l),a=!0)},o(l){I(e.$$.fragment,l),I(n.$$.fragment,l),a=!1},d(l){J(e,l),l&&F(t),J(n,l),l&&F(r),o&&o.d(l),l&&F(s)}}}function Ga(i){let e,t;return{c(){e=N("p"),t=Z(i[4]),L(e,"class","input-error")},m(n,r){O(n,e,r),S(e,t)},p(n,r){r&16&&de(t,n[4])},d(n){n&&F(e)}}}function Jf(i){let e,t,n,r;const s=[Kf,Zf],a=[];function o(l,c){return l[3]?1:0}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Qf(i,e,t){let{localeConsts:n}=e,r="",s=!0,a=!1,o="";function l(){r.trim().length>8?t(4,o=n.plate_less_than_8):/^[A-Za-z0-9]*$/.test(r)?t(4,o=""):t(4,o=n.plate_no_spl_chars),t(2,s=r.trim()===""||o!=="")}async function c(){t(3,a=!0),await Ne("changePlate",{plateNumber:r}),t(3,a=!1),t(1,r="")}const u=f=>{t(1,r=f.detail),l()};return i.$$set=f=>{"localeConsts"in f&&t(0,n=f.localeConsts)},[n,r,s,a,o,l,c,u]}class $f extends Ze{constructor(e){super(),Ye(this,e,Qf,Jf,qe,{localeConsts:0})}}function ed(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function td(i){let e,t,n,r;return e=new Tn({props:{placeholder:i[0].object_placeholder,label:i[0].object_label,inputId:"spawn-object-input",inputValue:i[1]}}),e.$on("input-value-update",i[6]),n=new gt({props:{buttonLabel:i[0].submit,btnDisabled:i[2],btnId:"submit-btn-spawn-objects"}}),n.$on("button-clicked",i[5]),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment)},m(s,a){K(e,s,a),O(s,t,a),K(n,s,a),r=!0},p(s,a){const o={};a&1&&(o.placeholder=s[0].object_placeholder),a&1&&(o.label=s[0].object_label),a&2&&(o.inputValue=s[1]),e.$set(o);const l={};a&1&&(l.buttonLabel=s[0].submit),a&4&&(l.btnDisabled=s[2]),n.$set(l)},i(s){r||(k(e.$$.fragment,s),k(n.$$.fragment,s),r=!0)},o(s){I(e.$$.fragment,s),I(n.$$.fragment,s),r=!1},d(s){J(e,s),s&&F(t),J(n,s)}}}function nd(i){let e,t,n,r;const s=[td,ed],a=[];function o(l,c){return l[3]?1:0}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function id(i,e,t){let{localeConsts:n}=e,r="",s=!0,a=!1;function o(){t(2,s=r.trim()===""||r.includes(" "))}async function l(){t(3,a=!0),await Ne("spawnObject",{objectName:r}),t(3,a=!1),t(1,r="")}const c=u=>{t(1,r=u.detail),o()};return i.$$set=u=>{"localeConsts"in u&&t(0,n=u.localeConsts)},[n,r,s,a,o,l,c]}class rd extends Ze{constructor(e){super(),Ye(this,e,id,nd,qe,{localeConsts:0})}}function sd(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function ad(i){let e,t,n,r,s,a,o,l,c,u,f,d,p;return e=new bn({props:{ddLabel:i[9],dropdownList:i[2],ddId:"create-stashes-dd-input",placeholder:i[0].search_placeholder,selectedValue:i[5]}}),e.$on("searchable-dd-selected-value",i[16]),r=new Oi({props:{label:i[0].size,inputId:"create-stashes-size-input",inputValue:i[6],className:"small-panel-inputs txt-sm p-1",width:"40%",pattern:"^[-/d]/d*$",step:"1"}}),r.$on("input-value-update",i[17]),o=new Oi({props:{label:i[0].slots,inputId:"create-stashes-slots-input",inputValue:i[7],className:"small-panel-inputs txt-sm p-1",width:"40%",pattern:"^[-/d]/d*$",step:"1"}}),o.$on("input-value-update",i[18]),u=new Tn({props:{placeholder:"prop_container_03mb",label:i[0].prop_override,inputId:"prop-container-input",inputValue:i[10]}}),u.$on("input-value-update",i[19]),d=new gt({props:{buttonLabel:i[8],btnDisabled:i[4],btnId:"submit-btn-create-stashes"}}),d.$on("button-clicked",i[13]),{c(){Q(e.$$.fragment),t=Y(),n=N("div"),Q(r.$$.fragment),s=Y(),a=N("div"),Q(o.$$.fragment),l=Y(),c=N("div"),Q(u.$$.fragment),f=Y(),Q(d.$$.fragment),L(n,"class","mtop-1"),L(a,"class","mtop-1 mbot-3"),L(c,"class","mtop-1")},m(m,h){K(e,m,h),O(m,t,h),O(m,n,h),K(r,n,null),O(m,s,h),O(m,a,h),K(o,a,null),O(m,l,h),O(m,c,h),K(u,c,null),O(m,f,h),K(d,m,h),p=!0},p(m,h){const _={};h&512&&(_.ddLabel=m[9]),h&4&&(_.dropdownList=m[2]),h&1&&(_.placeholder=m[0].search_placeholder),h&32&&(_.selectedValue=m[5]),e.$set(_);const g={};h&1&&(g.label=m[0].size),h&64&&(g.inputValue=m[6]),r.$set(g);const v={};h&1&&(v.label=m[0].slots),h&128&&(v.inputValue=m[7]),o.$set(v);const b={};h&1&&(b.label=m[0].prop_override),h&1024&&(b.inputValue=m[10]),u.$set(b);const y={};h&256&&(y.buttonLabel=m[8]),h&16&&(y.btnDisabled=m[4]),d.$set(y)},i(m){p||(k(e.$$.fragment,m),k(r.$$.fragment,m),k(o.$$.fragment,m),k(u.$$.fragment,m),k(d.$$.fragment,m),p=!0)},o(m){I(e.$$.fragment,m),I(r.$$.fragment,m),I(o.$$.fragment,m),I(u.$$.fragment,m),I(d.$$.fragment,m),p=!1},d(m){J(e,m),m&&F(t),m&&F(n),J(r),m&&F(s),m&&F(a),J(o),m&&F(l),m&&F(c),J(u),m&&F(f),J(d,m)}}}function od(i){let e,t,n,r;const s=[ad,sd],a=[];function o(l,c){return!l[1]&&!l[3]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function ld(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,D=>t(22,n=D));let o=!1,l=[],c=!1,u=!0,f="",d,p,m="",h="",_=s.submit,g=s.label,v="";at(async()=>{t(3,c=!0),b(),n?t(2,l=[{id:1,name:"Job1"},{id:2,name:"Job2"},{id:3,name:"Job3"},{id:4,name:"Job4"},{id:5,name:"Job5"},{id:6,name:"Job6"},{id:7,name:"Job7"}]):t(2,l=await Ne(h)),t(3,c=!1)});function b(){r===s.Create_Job_Stashes?(m="setJobStash",t(9,g=s.jobLabel),h="getindividualjobs",t(8,_=s.create_job_stash_btn)):r===s.Create_Gang_Stashes&&(m="setGangStash",t(9,g=s.gangLabel),h="getIndividualGangs",t(8,_=s.create_gang_stash_btn))}function y(D){t(5,f=D.detail),M()}async function w(){t(1,o=!0),await Ne(m,{selectedValue:f,size:d,slot:p,prop_override:v}),t(4,u=!0),t(5,f=""),t(6,d=0),t(7,p=0),t(10,v=""),t(1,o=!1)}function M(){t(4,u=f===""||!Number.isInteger(p)||!Number.isInteger(d))}const E=D=>y(D),x=D=>{t(6,d=D.detail),M()},C=D=>{t(7,p=D.detail),M()},A=D=>{t(10,v=D.detail)};return i.$$set=D=>{"title"in D&&t(15,r=D.title),"localeConsts"in D&&t(0,s=D.localeConsts)},[s,o,l,c,u,f,d,p,_,g,v,a,y,w,M,r,E,x,C,A]}class cd extends Ze{constructor(e){super(),Ye(this,e,ld,od,qe,{title:15,localeConsts:0})}}function ud(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function fd(i){let e,t,n,r;const s=[hd,dd],a=[];function o(l,c){return l[2]?1:0}return e=o(i),t=a[e]=s[e](i),{c(){t.c(),n=Zt()},m(l,c){a[e].m(l,c),O(l,n,c),r=!0},p(l,c){let u=e;e=o(l),e===u?a[e].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),t=a[e],t?t.p(l,c):(t=a[e]=s[e](l),t.c()),k(t,1),t.m(n.parentNode,n))},i(l){r||(k(t),r=!0)},o(l){I(t),r=!1},d(l){a[e].d(l),l&&F(n)}}}function dd(i){let e,t,n,r,s,a,o=i[1].citizen_id_label+"",l,c,u=i[3].citizenId+"",f,d,p,m,h=i[1].name_label+"",_,g,v=i[3].name+"",b,y,w,M,E=i[1].job_label+"",x,C,A=i[3].job+"",D,G,U,z,X=i[1].gang_label+"",ae,le,$=i[3].gang+"",ne,ue,be,q,ce=i[1].cash_bank_label+"",he,W,Se=i[3].cashBalance+"",we,Ee,Ce=i[3].bankBalance+"",Fe,ze,oe,ye;return n=new It({props:{icon:Pc,class:"txt-2xs"}}),{c(){e=N("div"),t=N("div"),Q(n.$$.fragment),r=Y(),s=N("p"),a=N("span"),l=Z(o),c=Z(": "),f=Z(u),d=Y(),p=N("p"),m=N("span"),_=Z(h),g=Z(": "),b=Z(v),y=Y(),w=N("p"),M=N("span"),x=Z(E),C=Z(": "),D=Z(A),G=Y(),U=N("p"),z=N("span"),ae=Z(X),le=Z(": "),ne=Z($),ue=Y(),be=N("p"),q=N("span"),he=Z(ce),W=Z(": "),we=Z(Se),Ee=Z(" / "),Fe=Z(Ce),L(t,"class","svelte-99a6q2"),L(a,"class","svelte-99a6q2"),L(s,"class","svelte-99a6q2"),L(m,"class","svelte-99a6q2"),L(p,"class","svelte-99a6q2"),L(M,"class","svelte-99a6q2"),L(w,"class","svelte-99a6q2"),L(z,"class","svelte-99a6q2"),L(U,"class","svelte-99a6q2"),L(q,"class","svelte-99a6q2"),L(be,"class","svelte-99a6q2"),L(e,"class","player-info svelte-99a6q2")},m(Le,Xe){O(Le,e,Xe),S(e,t),K(n,t,null),S(e,r),S(e,s),S(s,a),S(a,l),S(a,c),S(s,f),S(e,d),S(e,p),S(p,m),S(m,_),S(m,g),S(p,b),S(e,y),S(e,w),S(w,M),S(M,x),S(M,C),S(w,D),S(e,G),S(e,U),S(U,z),S(z,ae),S(z,le),S(U,ne),S(e,ue),S(e,be),S(be,q),S(q,he),S(q,W),S(be,we),S(be,Ee),S(be,Fe),ze=!0,oe||(ye=Oe(t,"click",i[14]),oe=!0)},p(Le,Xe){(!ze||Xe&2)&&o!==(o=Le[1].citizen_id_label+"")&&de(l,o),(!ze||Xe&8)&&u!==(u=Le[3].citizenId+"")&&de(f,u),(!ze||Xe&2)&&h!==(h=Le[1].name_label+"")&&de(_,h),(!ze||Xe&8)&&v!==(v=Le[3].name+"")&&de(b,v),(!ze||Xe&2)&&E!==(E=Le[1].job_label+"")&&de(x,E),(!ze||Xe&8)&&A!==(A=Le[3].job+"")&&de(D,A),(!ze||Xe&2)&&X!==(X=Le[1].gang_label+"")&&de(ae,X),(!ze||Xe&8)&&$!==($=Le[3].gang+"")&&de(ne,$),(!ze||Xe&2)&&ce!==(ce=Le[1].cash_bank_label+"")&&de(he,ce),(!ze||Xe&8)&&Se!==(Se=Le[3].cashBalance+"")&&de(we,Se),(!ze||Xe&8)&&Ce!==(Ce=Le[3].bankBalance+"")&&de(Fe,Ce)},i(Le){ze||(k(n.$$.fragment,Le),ze=!0)},o(Le){I(n.$$.fragment,Le),ze=!1},d(Le){Le&&F(e),J(n),oe=!1,ye()}}}function hd(i){let e,t,n,r,s,a,o,l;e=new bn({props:{ddLabel:i[10],dropdownList:i[5],ddId:"player-dd-input",placeholder:i[1].search,selectedValue:i[7]}}),e.$on("searchable-dd-selected-value",i[17]),n=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[9],btnDisabled:i[8],btnId:"submit-btn-player-list-dd-main"}}),n.$on("button-clicked",i[13]);const c=[md,pd],u=[];function f(d,p){return d[0]===d[1].Bring_Player?0:d[0]===d[1].Show_Props?1:-1}return~(s=f(i))&&(a=u[s]=c[s](i)),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),a&&a.c(),o=Zt()},m(d,p){K(e,d,p),O(d,t,p),K(n,d,p),O(d,r,p),~s&&u[s].m(d,p),O(d,o,p),l=!0},p(d,p){const m={};p&1024&&(m.ddLabel=d[10]),p&32&&(m.dropdownList=d[5]),p&2&&(m.placeholder=d[1].search),p&128&&(m.selectedValue=d[7]),e.$set(m);const h={};p&512&&(h.buttonLabel=d[9]),p&256&&(h.btnDisabled=d[8]),n.$set(h);let _=s;s=f(d),s===_?~s&&u[s].p(d,p):(a&&(Ve(),I(u[_],1,1,()=>{u[_]=null}),Ge()),~s?(a=u[s],a?a.p(d,p):(a=u[s]=c[s](d),a.c()),k(a,1),a.m(o.parentNode,o)):a=null)},i(d){l||(k(e.$$.fragment,d),k(n.$$.fragment,d),k(a),l=!0)},o(d){I(e.$$.fragment,d),I(n.$$.fragment,d),I(a),l=!1},d(d){J(e,d),d&&F(t),J(n,d),d&&F(r),~s&&u[s].d(d),d&&F(o)}}}function pd(i){let e,t;return e=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[1].teleport_btn,btnDisabled:i[8],btnId:"submit-btn-player-list-dd-teleport"}}),e.$on("button-clicked",i[16]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&2&&(s.buttonLabel=n[1].teleport_btn),r&256&&(s.btnDisabled=n[8]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function md(i){let e,t;return e=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[1].send_back_btn,btnDisabled:i[8],btnId:"submit-btn-player-list-dd-send-back"}}),e.$on("button-clicked",i[15]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&2&&(s.buttonLabel=n[1].send_back_btn),r&256&&(s.btnDisabled=n[8]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function _d(i){let e,t,n,r;const s=[fd,ud],a=[];function o(l,c){return!l[4]&&!l[6]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function gd(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,C=>t(20,n=C));let o=!1,l={citizenId:0,name:"",job:"",gang:"",cashBalance:0,bankBalance:0},c=!1,u=[],f=!1,d="",p=!0,m=s.submit,h="",_=s.player,g="getPlayerList";at(async()=>{t(6,f=!0),v(),n?t(5,u=[{id:1,name:"Sakshi"},{id:2,name:"Pushkar"},{id:3,name:"Monu"},{id:4,name:"Chinu"},{id:5,name:"Vaishnavi"},{id:6,name:"Anvi"},{id:7,name:"Lalla"}]):t(5,u=await Ne(g)),t(6,f=!1)});function v(){r===s.Clothes_Menu?(h="giveclothes",t(9,m=s.submit)):r===s.Freeze_Player?(h="freezeplayer",t(9,m=s.freeze_btn)):r===s.Revive?(h="reviveplayer",t(9,m=s.revive_btn)):r===s.Teleport_to_Player?(h="teleporttoplayer",t(9,m=s.teleport_btn)):r===s.Open_Inventory?(h="openinventory",t(9,m=s.open_btn)):r===s.Player_Info?(h="getplayerinfo",t(9,m=s.get_info_btn)):r===s.Clear_Inventory?(h="clearInventory",t(9,m=s.clear_btn)):r===s.Bring_Player?(h="bringPlayer",t(9,m=s.bring_btn)):r===s.Spectate_Player?(h="spectatePlayer",t(9,m=s.spectate_btn)):r===s.Saved_Locations?(t(10,_=s.locations_label),g="getSavedLocations",h="sendToSavedLocation",t(9,m=s.submit)):r===s.Open_Trunk?(t(10,_=s.plate_number_label),g="getAllOwnedVehicles",h="openTrunk",t(9,m=s.submit)):r===s.Open_Glovebox?(t(10,_=s.plate_number_label),g="getAllOwnedVehicles",h="openGlovebox",t(9,m=s.submit)):r===s.Unban_Player?(t(10,_=s.player_name_label),g="getBannedPlayers",h="unbanPlayer",t(9,m=s.submit)):r==s.Show_Props?(t(10,_=s.prop_name_label),g="getProps",h="deleteProp",t(9,m=s.delete_btn)):r===s.Drunk_Player?(h="drunkPlayer",t(9,m=s.submit)):r===s.Set_Player_on_Fire?(h="firePlayer",t(9,m=s.submit)):r===s.Slap_Player_In_Sky?(h="slapSky",t(9,m=s.submit)):r===s.Send_Player_To_JailBox?(h="sendToJailBox",t(9,m=s.submit)):r===s.Change_Vehicle_State?(t(10,_=s.plate_number_label),g="getAllOutsideVehicles",h="changeVehicleState",t(9,m=s.submit)):r===s.Force_Logout_Player?(h="forceLogout",t(9,m=s.submit)):r===s.Give_Outfits?(h="giveOutfits",t(9,m=s.submit)):r===s.Damage_Player_Vehicle?(h="damagePlayerVehicle",t(9,m=s.submit)):r===s.Heal?(h="healplayer",t(9,m=s.heal_btn)):r===s.Wipe_Player?(g="getAllUniquePlayers",h="wipePlayer",t(9,m=s.wipe_btn)):r===s.Pee_Player?(h="peePlayer",t(9,m=s.submit)):r===s.Poop_Player&&(h="poopPlayer",t(9,m=s.submit))}function b(C){t(7,d=C.detail),d!==""&&t(8,p=!1)}async function y(){t(4,c=!0);const A=await Ne(h,{selectedPlayer:d});t(8,p=!0),t(7,d=""),r===s.Show_Props&&t(5,u=await Ne(g)),t(4,c=!1),r===s.Player_Info&&(t(2,o=!0),t(3,l=A))}function w(){t(2,o=!1),t(3,l={citizenId:0,name:"",job:"",gang:"",cashBalance:0,bankBalance:0})}async function M(){t(4,c=!0),await Ne("sendBackPlayer",{selectedPlayer:d}),t(8,p=!0),t(7,d=""),t(4,c=!1)}async function E(){t(4,c=!0),await Ne("teleportToProp",{selectedPlayer:d}),t(8,p=!1),t(4,c=!1)}const x=C=>b(C);return i.$$set=C=>{"title"in C&&t(0,r=C.title),"localeConsts"in C&&t(1,s=C.localeConsts)},[r,s,o,l,c,u,f,d,p,m,_,a,b,y,w,M,E,x]}class bd extends Ze{constructor(e){super(),Ye(this,e,gd,_d,qe,{title:0,localeConsts:1})}}function vd(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function yd(i){let e,t,n,r,s,a,o,l;e=new bn({props:{ddLabel:i[8],dropdownList:i[3],ddId:"one-dd-input",placeholder:i[1].searchString,selectedValue:i[6]}}),e.$on("searchable-dd-selected-value",i[16]);const c=[xd,wd],u=[];function f(d,p){return d[0]===d[1].Open_Stash?0:1}return r=f(i),s=u[r]=c[r](i),o=new gt({props:{buttonLabel:i[10],btnDisabled:i[5],btnId:"submit-btn-one-ddone-input"}}),o.$on("button-clicked",i[14]),{c(){Q(e.$$.fragment),t=Y(),n=N("div"),s.c(),a=Y(),Q(o.$$.fragment),L(n,"class","mtop-1")},m(d,p){K(e,d,p),O(d,t,p),O(d,n,p),u[r].m(n,null),O(d,a,p),K(o,d,p),l=!0},p(d,p){const m={};p&256&&(m.ddLabel=d[8]),p&8&&(m.dropdownList=d[3]),p&2&&(m.placeholder=d[1].searchString),p&64&&(m.selectedValue=d[6]),e.$set(m);let h=r;r=f(d),r===h?u[r].p(d,p):(Ve(),I(u[h],1,1,()=>{u[h]=null}),Ge(),s=u[r],s?s.p(d,p):(s=u[r]=c[r](d),s.c()),k(s,1),s.m(n,null));const _={};p&1024&&(_.buttonLabel=d[10]),p&32&&(_.btnDisabled=d[5]),o.$set(_)},i(d){l||(k(e.$$.fragment,d),k(s),k(o.$$.fragment,d),l=!0)},o(d){I(e.$$.fragment,d),I(s),I(o.$$.fragment,d),l=!1},d(d){J(e,d),d&&F(t),d&&F(n),u[r].d(),d&&F(a),J(o,d)}}}function wd(i){let e,t;return e=new Tn({props:{placeholder:i[11],label:i[9],inputId:"one-dd-string-input",inputValue:i[7],className:"small-panel-inputs txt-sm p-1"}}),e.$on("input-value-update",i[18]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&2048&&(s.placeholder=n[11]),r&512&&(s.label=n[9]),r&128&&(s.inputValue=n[7]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function xd(i){let e,t;return e=new Tn({props:{placeholder:i[11],label:i[9],inputId:"one-dd-string-input",inputValue:i[7],className:"small-panel-inputs txt-sm p-1"}}),e.$on("input-value-update",i[17]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&2048&&(s.placeholder=n[11]),r&512&&(s.label=n[9]),r&128&&(s.inputValue=n[7]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Md(i){let e,t,n,r;const s=[yd,vd],a=[];function o(l,c){return!l[2]&&!l[4]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Sd(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,A=>t(21,n=A));let o=!1,l=[],c=!1,u=!0,f="",d,p="",m="",h="",_="",g=s.submit,v=s.search_placeholder;at(async()=>{t(4,c=!0),b(),n?t(3,l=[{id:1,name:"Job1"},{id:2,name:"Job2"},{id:3,name:"Job3"},{id:4,name:"Job4"},{id:5,name:"Job5"},{id:6,name:"Job6"},{id:7,name:"Job7"}]):t(3,l=await Ne(_)),t(4,c=!1)});function b(){r===s.Kick?(t(7,d=""),t(8,p=s.player),t(9,m=s.reason),_="getPlayerList",h="kickPlayer",t(10,g=s.kick_btn),t(11,v=s.player_placeholder)):r===s.Warn?(t(7,d=""),t(8,p=s.player),t(9,m=s.reason),_="getPlayerList",h="warnPlayer",t(10,g=s.warn_btn),t(11,v=s.player_placeholder)):r===s.DM_Player?(t(7,d=""),t(8,p=s.player),t(9,m=s.messagePlayerLabel),_="getPlayerList",h="sendDmToPlayer",t(10,g=s.messagePlayerButton),t(11,v=s.player_placeholder)):r===s.Open_Stash&&(t(7,d=""),t(8,p=s.stash_name_label),t(9,m=s.owner_stash_label),_="getStashes",h="openStash",t(10,g=s.submit))}function y(A){t(6,f=A.detail),M()}async function w(){t(2,o=!0),n||await Ne(h,{selectedValue:f,inputValue:d}),t(5,u=!0),t(6,f=""),t(7,d=""),t(2,o=!1)}function M(){r===s.Open_Stash?t(5,u=!1):t(5,u=d.trim()==="")}const E=A=>y(A),x=A=>{t(7,d=A.detail)},C=A=>{t(7,d=A.detail),M()};return i.$$set=A=>{"title"in A&&t(0,r=A.title),"localeConsts"in A&&t(1,s=A.localeConsts)},[r,s,o,l,c,u,f,d,p,m,g,v,a,y,w,M,E,x,C]}class Cd extends Ze{constructor(e){super(),Ye(this,e,Sd,Md,qe,{title:0,localeConsts:1})}}function Td(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Ed(i){let e,t,n,r,s,a,o,l;e=new bn({props:{ddLabel:i[0].player,dropdownList:i[3],ddId:"two-dd-player-dd-input",placeholder:i[0].player_placeholder,selectedValue:i[4]}}),e.$on("searchable-dd-selected-value",i[19]),n=new bn({props:{ddLabel:i[10],dropdownList:i[6],ddId:"two-dd-item-dd-input",placeholder:i[0].search_placeholder,selectedValue:i[7]}}),n.$on("searchable-dd-selected-value",i[20]),s=new gt({props:{buttonLabel:i[9],btnDisabled:i[5]||i[8],btnId:"submit-btn-two-dd-player-main"}}),s.$on("button-clicked",i[16]);let c=i[11]&&Ha(i);return{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),Q(s.$$.fragment),a=Y(),c&&c.c(),o=Zt()},m(u,f){K(e,u,f),O(u,t,f),K(n,u,f),O(u,r,f),K(s,u,f),O(u,a,f),c&&c.m(u,f),O(u,o,f),l=!0},p(u,f){const d={};f&1&&(d.ddLabel=u[0].player),f&8&&(d.dropdownList=u[3]),f&1&&(d.placeholder=u[0].player_placeholder),f&16&&(d.selectedValue=u[4]),e.$set(d);const p={};f&1024&&(p.ddLabel=u[10]),f&64&&(p.dropdownList=u[6]),f&1&&(p.placeholder=u[0].search_placeholder),f&128&&(p.selectedValue=u[7]),n.$set(p);const m={};f&512&&(m.buttonLabel=u[9]),f&288&&(m.btnDisabled=u[5]||u[8]),s.$set(m),u[11]?c?(c.p(u,f),f&2048&&k(c,1)):(c=Ha(u),c.c(),k(c,1),c.m(o.parentNode,o)):c&&(Ve(),I(c,1,1,()=>{c=null}),Ge())},i(u){l||(k(e.$$.fragment,u),k(n.$$.fragment,u),k(s.$$.fragment,u),k(c),l=!0)},o(u){I(e.$$.fragment,u),I(n.$$.fragment,u),I(s.$$.fragment,u),I(c),l=!1},d(u){J(e,u),u&&F(t),J(n,u),u&&F(r),J(s,u),u&&F(a),c&&c.d(u),u&&F(o)}}}function Ha(i){let e,t;return e=new gt({props:{buttonLabel:i[0].revert_btn,btnDisabled:i[12],btnId:"submit-btn-two-dd-player-revert"}}),e.$on("button-clicked",i[17]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&1&&(s.buttonLabel=n[0].revert_btn),r&4096&&(s.btnDisabled=n[12]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Ld(i){let e,t,n,r;const s=[Ed,Td],a=[];function o(l,c){return!l[1]&&!l[2]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Pd(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,G=>t(23,n=G));let o=!1,l=!1,c=[],u="",f=!0,d=[],p="",m=!0,h=s.submit,_="",g="",v="",b=!1,y=!0;at(async()=>{t(2,l=!0),r==s.Change_Ped_Model&&t(11,b=!0),w(),n?t(3,c=[{id:1,name:"Sakshi"},{id:2,name:"Pushkar"},{id:3,name:"Monu"},{id:4,name:"Chinu"},{id:5,name:"Vaishnavi"},{id:6,name:"Anvi"},{id:7,name:"Lalla"}]):t(3,c=await Ne("getPlayerList")),n?t(6,d=[{id:"police",name:"Level",grade:0},{id:2,name:"Item2"},{id:3,name:"Item3"},{id:4,name:"Item4"}]):t(6,d=await Ne(g)),t(2,l=!1)});function w(){r===s.Give_Job?(_="setjob",t(10,v=s.jobLabel),g="getJobs",t(9,h=s.submit)):r===s.Give_Car?(_="givecar",t(10,v=s.vehicle),g="getAllVehicles",t(9,h=s.submit)):r===s.Change_Ped_Model?(_="setPedModel",t(10,v=s.modelLabel),g="getModels",t(9,h=s.submit)):r===s.Give_Gang?(_="setGang",t(10,v=s.gangLabel),g="getGangs",t(9,h=s.submit)):r===s.Play_Sound_On_Player&&(_="playSoundPlayer",t(10,v=s.soundLabel),g="getSounds",t(9,h=s.submit))}function M(G){t(4,u=G.detail),u!==""&&(t(5,f=!1),t(12,y=!1))}function E(G){t(7,p=G.detail),p!==""&&t(8,m=!1)}async function x(){t(1,o=!0),await Ne(_,{selectedPlayer:u,selectedItem:p}),t(5,f=!0),t(8,m=!0),t(12,y=!0),t(4,u=""),t(7,p=""),t(1,o=!1)}async function C(){t(1,o=!0),await Ne("revertClothing",{selectedPlayer:u}),t(5,f=!0),t(8,m=!0),t(12,y=!0),t(4,u=""),t(7,p=""),t(1,o=!1)}const A=G=>M(G),D=G=>E(G);return i.$$set=G=>{"title"in G&&t(18,r=G.title),"localeConsts"in G&&t(0,s=G.localeConsts)},[s,o,l,c,u,f,d,p,m,h,v,b,y,a,M,E,x,C,r,A,D]}class Ad extends Ze{constructor(e){super(),Ye(this,e,Pd,Ld,qe,{title:18,localeConsts:0})}}function Dd(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Rd(i){let e,t,n,r,s,a,o,l,c,u,f,d,p,m,h,_;t=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[0].vector2,btnDisabled:!1,btnId:"submit-btn-vector-2"}}),t.$on("button-clicked",i[4]);let g=i[2]==="getVector2"&&Wa(i);a=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[0].vector3,btnDisabled:!1,btnId:"submit-btn-vector-3"}}),a.$on("button-clicked",i[5]);let v=i[2]==="getVector3"&&Xa(i);u=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[0].vector4,btnDisabled:!1,btnId:"submit-btn-vector-4"}}),u.$on("button-clicked",i[6]);let b=i[2]==="getVector4"&&ja(i);m=new gt({props:{className:"inline-block panel-btns txt-xs",buttonLabel:i[0].copy_json,btnDisabled:!1,btnId:"submit-btn-getJson"}}),m.$on("button-clicked",i[7]);let y=i[2]==="getJson"&&qa(i);return{c(){e=N("div"),Q(t.$$.fragment),n=Y(),g&&g.c(),r=Y(),s=N("div"),Q(a.$$.fragment),o=Y(),v&&v.c(),l=Y(),c=N("div"),Q(u.$$.fragment),f=Y(),b&&b.c(),d=Y(),p=N("div"),Q(m.$$.fragment),h=Y(),y&&y.c(),L(e,"class","btn-panel svelte-fd2v0h"),L(s,"class","btn-panel svelte-fd2v0h"),L(c,"class","btn-panel svelte-fd2v0h"),L(p,"class","btn-panel svelte-fd2v0h")},m(w,M){O(w,e,M),K(t,e,null),S(e,n),g&&g.m(e,null),O(w,r,M),O(w,s,M),K(a,s,null),S(s,o),v&&v.m(s,null),O(w,l,M),O(w,c,M),K(u,c,null),S(c,f),b&&b.m(c,null),O(w,d,M),O(w,p,M),K(m,p,null),S(p,h),y&&y.m(p,null),_=!0},p(w,M){const E={};M&1&&(E.buttonLabel=w[0].vector2),t.$set(E),w[2]==="getVector2"?g?g.p(w,M):(g=Wa(w),g.c(),g.m(e,null)):g&&(g.d(1),g=null);const x={};M&1&&(x.buttonLabel=w[0].vector3),a.$set(x),w[2]==="getVector3"?v?v.p(w,M):(v=Xa(w),v.c(),v.m(s,null)):v&&(v.d(1),v=null);const C={};M&1&&(C.buttonLabel=w[0].vector4),u.$set(C),w[2]==="getVector4"?b?b.p(w,M):(b=ja(w),b.c(),b.m(c,null)):b&&(b.d(1),b=null);const A={};M&1&&(A.buttonLabel=w[0].copy_json),m.$set(A),w[2]==="getJson"?y?y.p(w,M):(y=qa(w),y.c(),y.m(p,null)):y&&(y.d(1),y=null)},i(w){_||(k(t.$$.fragment,w),k(a.$$.fragment,w),k(u.$$.fragment,w),k(m.$$.fragment,w),_=!0)},o(w){I(t.$$.fragment,w),I(a.$$.fragment,w),I(u.$$.fragment,w),I(m.$$.fragment,w),_=!1},d(w){w&&F(e),J(t),g&&g.d(),w&&F(r),w&&F(s),J(a),v&&v.d(),w&&F(l),w&&F(c),J(u),b&&b.d(),w&&F(d),w&&F(p),J(m),y&&y.d()}}}function Wa(i){let e,t=i[0].copy_to_clipboard+"",n;return{c(){e=N("p"),n=Z(t),L(e,"class","inline-block svelte-fd2v0h")},m(r,s){O(r,e,s),S(e,n)},p(r,s){s&1&&t!==(t=r[0].copy_to_clipboard+"")&&de(n,t)},d(r){r&&F(e)}}}function Xa(i){let e,t=i[0].copy_to_clipboard+"",n;return{c(){e=N("p"),n=Z(t),L(e,"class","inline-block svelte-fd2v0h")},m(r,s){O(r,e,s),S(e,n)},p(r,s){s&1&&t!==(t=r[0].copy_to_clipboard+"")&&de(n,t)},d(r){r&&F(e)}}}function ja(i){let e,t=i[0].copy_to_clipboard+"",n;return{c(){e=N("p"),n=Z(t),L(e,"class","inline-block svelte-fd2v0h")},m(r,s){O(r,e,s),S(e,n)},p(r,s){s&1&&t!==(t=r[0].copy_to_clipboard+"")&&de(n,t)},d(r){r&&F(e)}}}function qa(i){let e,t=i[0].copy_to_clipboard+"",n;return{c(){e=N("p"),n=Z(t),L(e,"class","inline-block svelte-fd2v0h")},m(r,s){O(r,e,s),S(e,n)},p(r,s){s&1&&t!==(t=r[0].copy_to_clipboard+"")&&de(n,t)},d(r){r&&F(e)}}}function kd(i){let e,t,n,r;const s=[Rd,Dd],a=[];function o(l,c){return l[1]?1:0}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Id(i,e,t){let{localeConsts:n}=e,r="",s=!1,a="";async function o(d){t(2,a=d),t(1,s=!0),r=await Ne(d);var p=document.createElement("textarea");document.body.appendChild(p),p.value=r,p.select(),document.execCommand("copy"),document.body.removeChild(p),t(1,s=!1)}const l=()=>o("getVector2"),c=()=>o("getVector3"),u=()=>o("getVector4"),f=()=>o("getJson");return i.$$set=d=>{"localeConsts"in d&&t(0,n=d.localeConsts)},[n,s,a,o,l,c,u,f]}class Nd extends Ze{constructor(e){super(),Ye(this,e,Id,kd,qe,{localeConsts:0})}}function Ya(i,e,t){const n=i.slice();return n[7]=e[t],n}function zd(i){let e=i[7][i[1]]+"",t;return{c(){t=Z(e)},m(n,r){O(n,t,r)},p(n,r){r&3&&e!==(e=n[7][n[1]]+"")&&de(t,e)},d(n){n&&F(t)}}}function Fd(i){let e,t=i[7].id+"",n,r,s=i[7][i[1]]+"",a;return{c(){e=Z("("),n=Z(t),r=Z(") "),a=Z(s)},m(o,l){O(o,e,l),O(o,n,l),O(o,r,l),O(o,a,l)},p(o,l){l&1&&t!==(t=o[7].id+"")&&de(n,t),l&3&&s!==(s=o[7][o[1]]+"")&&de(a,s)},d(o){o&&F(e),o&&F(n),o&&F(r),o&&F(a)}}}function Od(i){let e=i[7]+"",t;return{c(){t=Z(e)},m(n,r){O(n,t,r)},p(n,r){r&1&&e!==(e=n[7]+"")&&de(t,e)},d(n){n&&F(t)}}}function Za(i){let e,t,n,r;function s(l,c){return c&1&&(t=null),l[3]?Od:(t==null&&(t=!!l[7].hasOwnProperty("id")),t?Fd:zd)}let a=s(i,-1),o=a(i);return{c(){e=N("option"),o.c(),n=Y(),e.__value=r=i[1]===null?i[7]:i[7][i[1]],e.value=e.__value},m(l,c){O(l,e,c),o.m(e,null),S(e,n)},p(l,c){a===(a=s(l,c))&&o?o.p(l,c):(o.d(1),o=a(l),o&&(o.c(),o.m(e,n))),c&3&&r!==(r=l[1]===null?l[7]:l[7][l[1]])&&(e.__value=r,e.value=e.__value)},d(l){l&&F(e),o.d()}}}function Ud(i){let e,t,n,r,s=i[0],a=[];for(let o=0;o<s.length;o+=1)a[o]=Za(Ya(i,s,o));return{c(){e=N("div"),t=N("select");for(let o=0;o<a.length;o+=1)a[o].c();i[2]===void 0&&fi(()=>i[5].call(t)),L(e,"class","inline-block regular-dropdown")},m(o,l){O(o,e,l),S(e,t);for(let c=0;c<a.length;c+=1)a[c].m(t,null);Da(t,i[2]),n||(r=[Oe(t,"change",i[5]),Oe(t,"change",i[4])],n=!0)},p(o,[l]){if(l&11){s=o[0];let c;for(c=0;c<s.length;c+=1){const u=Ya(o,s,c);a[c]?a[c].p(u,l):(a[c]=Za(u),a[c].c(),a[c].m(t,null))}for(;c<a.length;c+=1)a[c].d(1);a.length=s.length}l&7&&Da(t,o[2])},i:ge,o:ge,d(o){o&&F(e),Vt(a,o),n=!1,wt(r)}}}function Bd(i,e,t){let{dropdownValues:n,selectKey:r=null}=e,s=r==null,a;const o=ln();function l(){o("regular-dropdown-select",a)}function c(){a=hu(this),t(2,a),t(1,r),t(0,n)}return i.$$set=u=>{"dropdownValues"in u&&t(0,n=u.dropdownValues),"selectKey"in u&&t(1,r=u.selectKey)},[n,r,a,s,l,c]}class Ui extends Ze{constructor(e){super(),Ye(this,e,Bd,Ud,qe,{dropdownValues:0,selectKey:1})}}function Vd(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Gd(i){let e,t,n,r,s,a,o,l,c,u,f,d;return e=new bn({props:{ddLabel:i[0].player,dropdownList:i[3],ddId:"ban-player-dd-input",placeholder:i[0].player_placeholder,selectedValue:i[4]}}),e.$on("searchable-dd-selected-value",i[17]),n=new Oi({props:{placeholder:i[0].ban_time,label:i[0].ban_time,inputId:"ban-player-time-input",inputValue:i[8],className:"inline-block",width:"40%"}}),n.$on("input-value-update",i[18]),s=new Ui({props:{dropdownValues:i[12]}}),s.$on("regular-dropdown-select",i[19]),o=new cs({props:{checkboxValue:i[6],checkboxLabel:i[0].permanent,checkboxId:i[6]}}),o.$on("checkbox-clicked",i[20]),c=new Tn({props:{placeholder:i[0].reason_placeholder,label:i[0].reason,inputId:"ban-player-reason-input",inputValue:i[7]}}),c.$on("input-value-update",i[21]),f=new gt({props:{buttonLabel:i[0].ban_btn,btnDisabled:i[5]||i[10],btnId:"submit-btn-ban-player"}}),f.$on("button-clicked",i[15]),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment),r=Y(),Q(s.$$.fragment),a=Y(),Q(o.$$.fragment),l=Y(),Q(c.$$.fragment),u=Y(),Q(f.$$.fragment)},m(p,m){K(e,p,m),O(p,t,m),K(n,p,m),O(p,r,m),K(s,p,m),O(p,a,m),K(o,p,m),O(p,l,m),K(c,p,m),O(p,u,m),K(f,p,m),d=!0},p(p,m){const h={};m&1&&(h.ddLabel=p[0].player),m&8&&(h.dropdownList=p[3]),m&1&&(h.placeholder=p[0].player_placeholder),m&16&&(h.selectedValue=p[4]),e.$set(h);const _={};m&1&&(_.placeholder=p[0].ban_time),m&1&&(_.label=p[0].ban_time),m&256&&(_.inputValue=p[8]),n.$set(_);const g={};m&64&&(g.checkboxValue=p[6]),m&1&&(g.checkboxLabel=p[0].permanent),m&64&&(g.checkboxId=p[6]),o.$set(g);const v={};m&1&&(v.placeholder=p[0].reason_placeholder),m&1&&(v.label=p[0].reason),m&128&&(v.inputValue=p[7]),c.$set(v);const b={};m&1&&(b.buttonLabel=p[0].ban_btn),m&1056&&(b.btnDisabled=p[5]||p[10]),f.$set(b)},i(p){d||(k(e.$$.fragment,p),k(n.$$.fragment,p),k(s.$$.fragment,p),k(o.$$.fragment,p),k(c.$$.fragment,p),k(f.$$.fragment,p),d=!0)},o(p){I(e.$$.fragment,p),I(n.$$.fragment,p),I(s.$$.fragment,p),I(o.$$.fragment,p),I(c.$$.fragment,p),I(f.$$.fragment,p),d=!1},d(p){J(e,p),p&&F(t),J(n,p),p&&F(r),J(s,p),p&&F(a),J(o,p),p&&F(l),J(c,p),p&&F(u),J(f,p)}}}function Hd(i){let e,t,n,r;const s=[Gd,Vd],a=[];function o(l,c){return!l[1]&&!l[2]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Wd(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,U=>t(24,n=U));let o=!1,l=!1,c=[],u="",f=!0,d="",p="",m=!1,h="",_,g=["Minutes","Hours","Weeks","Months","Year"],v="Minutes",b=!0;at(async()=>{t(2,l=!0),y(),n?t(3,c=[{id:1,name:"Sakshi"},{id:2,name:"Pushkar"},{id:3,name:"Monu"},{id:4,name:"Chinu"},{id:5,name:"Vaishnavi"},{id:6,name:"Anvi"},{id:7,name:"Lalla"}]):t(3,c=await Ne(p)),t(2,l=!1)});function y(){r===s.Ban_Player?(p="getPlayerList",d="banPlayer"):r===s.Ban_Offline_Player&&(p="getAllPlayersOffline",d="banOfflinePlayer")}function w(U){t(4,u=U.detail),u!==""&&t(5,f=!1)}function M(){let U=!1;_!==""&&_!==null&&!m&&_!==void 0&&(U=_.toString().split(".").length>1);let z=m?!1:_<=0||!Number.isInteger(_);t(10,b=z||U||h.trim()==="")}async function E(){t(1,o=!0),await Ne(d,{selectedPlayer:u,banTime:_,banOpt:v,isPermanent:m==="true"||m===!0,reason:h}),t(5,f=!0),t(4,u=""),t(6,m=!1),t(8,_=0),t(7,h=""),t(9,v="Minutes"),t(1,o=!1)}const x=U=>w(U),C=U=>{t(8,_=U.detail),M()},A=U=>t(9,v=U.detail),D=U=>{t(6,m=U.detail),M()},G=U=>{t(7,h=U.detail),M()};return i.$$set=U=>{"title"in U&&t(16,r=U.title),"localeConsts"in U&&t(0,s=U.localeConsts)},[s,o,l,c,u,f,m,h,_,v,b,a,g,w,M,E,r,x,C,A,D,G]}class Xd extends Ze{constructor(e){super(),Ye(this,e,Wd,Hd,qe,{title:16,localeConsts:0})}}function jd(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function qd(i){let e,t,n,r;return e=new Oi({props:{placeholder:i[5],label:i[3],inputId:"clear-area-input",inputValue:i[2]}}),e.$on("input-value-update",i[10]),n=new gt({props:{buttonLabel:i[4],btnDisabled:i[0],btnId:"submit-btn-change-area"}}),n.$on("button-clicked",i[7]),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment)},m(s,a){K(e,s,a),O(s,t,a),K(n,s,a),r=!0},p(s,a){const o={};a&32&&(o.placeholder=s[5]),a&8&&(o.label=s[3]),a&4&&(o.inputValue=s[2]),e.$set(o);const l={};a&16&&(l.buttonLabel=s[4]),a&1&&(l.btnDisabled=s[0]),n.$set(l)},i(s){r||(k(e.$$.fragment,s),k(n.$$.fragment,s),r=!0)},o(s){I(e.$$.fragment,s),I(n.$$.fragment,s),r=!1},d(s){J(e,s),s&&F(t),J(n,s)}}}function Yd(i){let e,t,n,r;const s=[qd,jd],a=[];function o(l,c){return l[1]?1:0}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function Zd(i,e,t){let{title:n,localeConsts:r}=e,s=!0,a=!1,o,l="",c="",u=r.submit,f=r.search_placeholder;at(async()=>{d()});function d(){n===r.Clear_Area_Vehicles?(t(2,o=""),r.clear_area,t(3,l=r.radius),c="clearVehicles",t(4,u=r.clear_area),t(5,f=r.enter_radius_placeholder)):n===r.Clear_Area_Peds?(t(2,o=""),r.clear_area,t(3,l=r.radius),c="clearPeds",t(4,u=r.clear_area),t(5,f=r.enter_radius_placeholder)):n===r.Clear_Area_Objects&&(t(2,o=""),r.clear_area,t(3,l=r.radius),c="clearObjects",t(4,u=r.clear_area),t(5,f=r.enter_radius_placeholder))}function p(){t(0,s=o<=0||!Number.isInteger(o))}async function m(){t(1,a=!0),await Ne(c,{radius:o}),t(0,s=!0),t(2,o=""),t(1,a=!1)}const h=_=>{t(2,o=_.detail),p()};return i.$$set=_=>{"title"in _&&t(8,n=_.title),"localeConsts"in _&&t(9,r=_.localeConsts)},[s,a,o,l,u,f,p,m,n,r,h]}class Kd extends Ze{constructor(e){super(),Ye(this,e,Zd,Yd,qe,{title:8,localeConsts:9})}}function Jd(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Qd(i){let e,t,n,r=i[0].current_weather+"",s,a,o,l,c,u;return e=new bn({props:{ddLabel:i[7],dropdownList:i[2],ddId:"player-dd-input",placeholder:i[0].search,selectedValue:i[5]}}),e.$on("searchable-dd-selected-value",i[13]),c=new gt({props:{buttonLabel:i[8],btnDisabled:i[6],btnId:"submit-btn-single-dd"}}),c.$on("button-clicked",i[11]),{c(){Q(e.$$.fragment),t=Y(),n=N("div"),s=Z(r),a=Z(": "),o=Z(i[3]),l=Y(),Q(c.$$.fragment)},m(f,d){K(e,f,d),O(f,t,d),O(f,n,d),S(n,s),S(n,a),S(n,o),O(f,l,d),K(c,f,d),u=!0},p(f,d){const p={};d&128&&(p.ddLabel=f[7]),d&4&&(p.dropdownList=f[2]),d&1&&(p.placeholder=f[0].search),d&32&&(p.selectedValue=f[5]),e.$set(p),(!u||d&1)&&r!==(r=f[0].current_weather+"")&&de(s,r),(!u||d&8)&&de(o,f[3]);const m={};d&256&&(m.buttonLabel=f[8]),d&64&&(m.btnDisabled=f[6]),c.$set(m)},i(f){u||(k(e.$$.fragment,f),k(c.$$.fragment,f),u=!0)},o(f){I(e.$$.fragment,f),I(c.$$.fragment,f),u=!1},d(f){J(e,f),f&&F(t),f&&F(n),f&&F(l),J(c,f)}}}function $d(i){let e,t,n,r;const s=[Qd,Jd],a=[];function o(l,c){return!l[1]&&!l[4]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function eh(i,e,t){let n,{title:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,w=>t(16,n=w));let o=!1,l=[],c="",u=!1,f="",d=!0,p=s.label,m=s.submit,h="",_="";at(async()=>{t(4,u=!0),g(),n?t(2,l=[{id:1,name:"Sakshi"},{id:2,name:"Pushkar"},{id:3,name:"Monu"},{id:4,name:"Chinu"},{id:5,name:"Vaishnavi"},{id:6,name:"Anvi"},{id:7,name:"Lalla"}]):(t(2,l=await Ne(_)),t(3,c=await Ne("getCurrentWeather"))),t(4,u=!1)});function g(){r===s.Change_Weather&&(t(7,p=s.weather_label),_="getWeatherList",h="setWeather",t(8,m=s.weather_btn))}function v(w){t(5,f=w.detail),f!==""&&t(6,d=!1)}async function b(){t(1,o=!0),await Ne(h,{selectedValue:f}),t(5,f=""),t(1,o=!1)}const y=w=>v(w);return i.$$set=w=>{"title"in w&&t(12,r=w.title),"localeConsts"in w&&t(0,s=w.localeConsts)},[s,o,l,c,u,f,d,p,m,a,v,b,r,y]}class th extends Ze{constructor(e){super(),Ye(this,e,eh,$d,qe,{title:12,localeConsts:0})}}function nh(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function ih(i){let e,t=i[0].time_and_period+"",n,r,s,a,o,l,c,u,f;return a=new Ui({props:{dropdownValues:i[4]}}),a.$on("regular-dropdown-select",i[7]),l=new Ui({props:{dropdownValues:i[5]}}),l.$on("regular-dropdown-select",i[8]),u=new gt({props:{buttonLabel:i[0].change_time,btnDisabled:i[2]===""||i[3]==="",btnId:"submit-btn-change-time"}}),u.$on("button-clicked",i[6]),{c(){e=N("p"),n=Z(t),r=Z(":"),s=Y(),Q(a.$$.fragment),o=Y(),Q(l.$$.fragment),c=Y(),Q(u.$$.fragment),L(e,"class","block txt-sm panel-labels")},m(d,p){O(d,e,p),S(e,n),S(e,r),O(d,s,p),K(a,d,p),O(d,o,p),K(l,d,p),O(d,c,p),K(u,d,p),f=!0},p(d,p){(!f||p&1)&&t!==(t=d[0].time_and_period+"")&&de(n,t);const m={};p&1&&(m.buttonLabel=d[0].change_time),p&12&&(m.btnDisabled=d[2]===""||d[3]===""),u.$set(m)},i(d){f||(k(a.$$.fragment,d),k(l.$$.fragment,d),k(u.$$.fragment,d),f=!0)},o(d){I(a.$$.fragment,d),I(l.$$.fragment,d),I(u.$$.fragment,d),f=!1},d(d){d&&F(e),d&&F(s),J(a,d),d&&F(o),J(l,d),d&&F(c),J(u,d)}}}function rh(i){let e,t,n,r;const s=[ih,nh],a=[];function o(l,c){return!l[1]&&!sh?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c()},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}let sh=!1;function ah(i,e,t){let{localeConsts:n}=e,r=!1,s=[1,2,3,4,5,6,7,8,9,10,11,12],a=["AM","PM"],o="",l="AM";async function c(){t(1,r=!0),await Ne("setTime",{selectedTime:o,selectedPeriod:l}),t(2,o=""),t(3,l="AM"),t(1,r=!1)}const u=d=>t(2,o=d.detail),f=d=>t(3,l=d.detail);return i.$$set=d=>{"localeConsts"in d&&t(0,n=d.localeConsts)},[n,r,o,l,s,a,c,u,f]}class oh extends Ze{constructor(e){super(),Ye(this,e,ah,rh,qe,{localeConsts:0})}}function Ka(i,e,t){const n=i.slice();return n[18]=e[t],n[20]=t,n}function lh(i){let e,t,n,r=i[2],s=[];for(let o=0;o<r.length;o+=1)s[o]=Ja(Ka(i,r,o));const a=o=>I(s[o],1,1,()=>{s[o]=null});return t=new gt({props:{buttonLabel:i[1].submit,btnDisabled:i[4],btnId:i[0].keyName+"-submit-btn"}}),t.$on("button-clicked",i[5]),{c(){for(let o=0;o<s.length;o+=1)s[o].c();e=Y(),Q(t.$$.fragment)},m(o,l){for(let c=0;c<s.length;c+=1)s[c].m(o,l);O(o,e,l),K(t,o,l),n=!0},p(o,l){if(l&68){r=o[2];let u;for(u=0;u<r.length;u+=1){const f=Ka(o,r,u);s[u]?(s[u].p(f,l),k(s[u],1)):(s[u]=Ja(f),s[u].c(),k(s[u],1),s[u].m(e.parentNode,e))}for(Ve(),u=r.length;u<s.length;u+=1)a(u);Ge()}const c={};l&2&&(c.buttonLabel=o[1].submit),l&16&&(c.btnDisabled=o[4]),l&1&&(c.btnId=o[0].keyName+"-submit-btn"),t.$set(c)},i(o){if(!n){for(let l=0;l<r.length;l+=1)k(s[l]);k(t.$$.fragment,o),n=!0}},o(o){s=s.filter(Boolean);for(let l=0;l<s.length;l+=1)I(s[l]);I(t.$$.fragment,o),n=!1},d(o){Vt(s,o),o&&F(e),J(t,o)}}}function ch(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function uh(i){let e,t,n;function r(...s){return i[11](i[18],...s)}return t=new bn({props:{ddLabel:i[18].label,dropdownList:i[18].fetchedData,ddId:i[18].type+"-"+i[20],placeholder:i[18].placeholder,selectedValue:i[18].selectedValue}}),t.$on("searchable-dd-selected-value",r),{c(){e=N("div"),Q(t.$$.fragment),L(e,"class","svelte-1wiqead")},m(s,a){O(s,e,a),K(t,e,null),n=!0},p(s,a){i=s;const o={};a&4&&(o.ddLabel=i[18].label),a&4&&(o.dropdownList=i[18].fetchedData),a&4&&(o.ddId=i[18].type+"-"+i[20]),a&4&&(o.placeholder=i[18].placeholder),a&4&&(o.selectedValue=i[18].selectedValue),t.$set(o)},i(s){n||(k(t.$$.fragment,s),n=!0)},o(s){I(t.$$.fragment,s),n=!1},d(s){s&&F(e),J(t)}}}function fh(i){let e,t,n;function r(...s){return i[10](i[18],...s)}return t=new cs({props:{checkboxValue:i[18].selectedValue,checkboxLabel:i[18].label,checkboxId:i[18].type+"-"+i[20]}}),t.$on("checkbox-clicked",r),{c(){e=N("div"),Q(t.$$.fragment),L(e,"class","svelte-1wiqead")},m(s,a){O(s,e,a),K(t,e,null),n=!0},p(s,a){i=s;const o={};a&4&&(o.checkboxValue=i[18].selectedValue),a&4&&(o.checkboxLabel=i[18].label),a&4&&(o.checkboxId=i[18].type+"-"+i[20]),t.$set(o)},i(s){n||(k(t.$$.fragment,s),n=!0)},o(s){I(t.$$.fragment,s),n=!1},d(s){s&&F(e),J(t)}}}function dh(i){let e,t,n=i[18].label+"",r,s,a,o,l;function c(...u){return i[9](i[18],...u)}return o=new Ui({props:{dropdownValues:i[18].fetchedData}}),o.$on("regular-dropdown-select",c),{c(){e=N("div"),t=N("p"),r=Z(n),s=Z(":"),a=Y(),Q(o.$$.fragment),L(t,"class","block txt-sm panel-labels"),L(e,"class","svelte-1wiqead")},m(u,f){O(u,e,f),S(e,t),S(t,r),S(t,s),S(e,a),K(o,e,null),l=!0},p(u,f){i=u,(!l||f&4)&&n!==(n=i[18].label+"")&&de(r,n);const d={};f&4&&(d.dropdownValues=i[18].fetchedData),o.$set(d)},i(u){l||(k(o.$$.fragment,u),l=!0)},o(u){I(o.$$.fragment,u),l=!1},d(u){u&&F(e),J(o)}}}function hh(i){let e,t,n;function r(...s){return i[8](i[18],...s)}return t=new Oi({props:{placeholder:i[18].placeholder,label:i[18].label,inputId:i[18].type+"-"+i[20],inputValue:i[18].selectedValue}}),t.$on("input-value-update",r),{c(){e=N("div"),Q(t.$$.fragment),L(e,"class","svelte-1wiqead")},m(s,a){O(s,e,a),K(t,e,null),n=!0},p(s,a){i=s;const o={};a&4&&(o.placeholder=i[18].placeholder),a&4&&(o.label=i[18].label),a&4&&(o.inputId=i[18].type+"-"+i[20]),a&4&&(o.inputValue=i[18].selectedValue),t.$set(o)},i(s){n||(k(t.$$.fragment,s),n=!0)},o(s){I(t.$$.fragment,s),n=!1},d(s){s&&F(e),J(t)}}}function ph(i){let e,t,n;function r(...s){return i[7](i[18],...s)}return t=new Tn({props:{placeholder:i[18].placeholder,label:i[18].label,inputId:i[18].type+"-"+i[20],inputValue:i[18].selectedValue}}),t.$on("input-value-update",r),{c(){e=N("div"),Q(t.$$.fragment),L(e,"class","svelte-1wiqead")},m(s,a){O(s,e,a),K(t,e,null),n=!0},p(s,a){i=s;const o={};a&4&&(o.placeholder=i[18].placeholder),a&4&&(o.label=i[18].label),a&4&&(o.inputId=i[18].type+"-"+i[20]),a&4&&(o.inputValue=i[18].selectedValue),t.$set(o)},i(s){n||(k(t.$$.fragment,s),n=!0)},o(s){I(t.$$.fragment,s),n=!1},d(s){s&&F(e),J(t)}}}function Ja(i){let e,t,n,r;const s=[ph,hh,dh,fh,uh],a=[];function o(l,c){return l[18].type==="string-input"?0:l[18].type==="number-input"?1:l[18].type==="regular-dropdown"?2:l[18].type==="checkbox-input"?3:l[18].type==="searchable-dropdown"?4:-1}return~(e=o(i))&&(t=a[e]=s[e](i)),{c(){t&&t.c(),n=Zt()},m(l,c){~e&&a[e].m(l,c),O(l,n,c),r=!0},p(l,c){let u=e;e=o(l),e===u?~e&&a[e].p(l,c):(t&&(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge()),~e?(t=a[e],t?t.p(l,c):(t=a[e]=s[e](l),t.c()),k(t,1),t.m(n.parentNode,n)):t=null)},i(l){r||(k(t),r=!0)},o(l){I(t),r=!1},d(l){~e&&a[e].d(l),l&&F(n)}}}function mh(i){let e,t,n,r;const s=[ch,lh],a=[];function o(l,c){return l[3]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c(),L(e,"class","custom-panel-page svelte-1wiqead")},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function _h(i,e,t){let{panelData:n,localeConsts:r}=e,s="",a=[],o=[],l={},c=!1,u=!0;at(()=>{t(3,c=!0),s=n.cb,t(2,a=n.components),f(),o=a.filter(y=>y.fillCompulsory),d()});function f(){let y=[];l=a.reduce((M,E)=>(E.fetchDataUrl&&E.fetchDataUrl.trim()!==""&&!l.hasOwnProperty(E.fetchDataUrl)&&(M[E.fetchDataUrl]=null),M),{}),Object.keys(l).map(M=>{y.push(new Promise(async(E,x)=>{const C=await Ne(M);l[M]=C,E(l)}))}),Promise.all(y).then(M=>{a.map(E=>{E.fetchDataUrl&&l.hasOwnProperty(E.fetchDataUrl.trim())&&(E.fetchedData=l[E.fetchDataUrl.trim()]),E.selectedValue=E.type==="regular-dropdown"?E.fetchedData[0]:E.type==="checkbox-input"?!1:null}),t(3,c=!1)})}function d(){const y=w=>w.selectedValue!==null&&(typeof w.selectedValue=="string"?w.selectedValue.trim()!=="":!0);t(4,u=!o.every(y))}async function p(){t(3,c=!0);let y={};a.map(M=>{y[M.keyName]=M.selectedValue}),await Ne(s,y);let w=a.map(M=>(M.selectedValue=M.type==="regular-dropdown"?M.fetchedData[0]:M.type==="checkbox-input"?!1:null,M));t(2,a=w),d(),t(3,c=!1)}function m(y,w){w.selectedValue=y.detail,d()}const h=(y,w)=>m(w,y),_=(y,w)=>m(w,y),g=(y,w)=>m(w,y),v=(y,w)=>m(w,y),b=(y,w)=>m(w,y);return i.$$set=y=>{"panelData"in y&&t(0,n=y.panelData),"localeConsts"in y&&t(1,r=y.localeConsts)},[n,r,a,c,u,p,m,h,_,g,v,b]}class gh extends Ze{constructor(e){super(),Ye(this,e,_h,mh,qe,{panelData:0,localeConsts:1})}}function bh(i){let e,t;return e=new It({props:{icon:_f,class:"txt-xs"}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function vh(i){let e,t;return e=new It({props:{icon:df,class:"txt-xs",color:"gold"}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Qa(i){let e,t,n;return t=new It({props:{icon:i[3]?os:_r,class:"txt-xs"}}),{c(){e=N("div"),Q(t.$$.fragment),L(e,"class","chevron-sign")},m(r,s){O(r,e,s),K(t,e,null),n=!0},p(r,s){const a={};s&8&&(a.icon=r[3]?os:_r),t.$set(a)},i(r){n||(k(t.$$.fragment,r),n=!0)},o(r){I(t.$$.fragment,r),n=!1},d(r){r&&F(e),J(t)}}}function $a(i){let e,t,n,r;const s=[i[5]];var a=i[4];function o(l){let c={};for(let u=0;u<s.length;u+=1)c=au(c,s[u]);return{props:c}}return a&&(t=new a(o())),{c(){e=N("div"),t&&Q(t.$$.fragment),L(e,"class","open-panels")},m(l,c){O(l,e,c),t&&K(t,e,null),r=!0},p(l,c){const u=c&32?Eu(s,[Lu(l[5])]):{};if(a!==(a=l[4])){if(t){Ve();const f=t;I(f.$$.fragment,1,0,()=>{J(f,1)}),Ge()}a?(t=new a(o()),Q(t.$$.fragment),k(t.$$.fragment,1),K(t,e,null)):t=null}else a&&t.$set(u)},i(l){r||(t&&k(t.$$.fragment,l),fi(()=>{n||(n=ss(e,ls,{duration:400},!0)),n.run(1)}),r=!0)},o(l){t&&I(t.$$.fragment,l),n||(n=ss(e,ls,{duration:400},!1)),n.run(0),r=!1},d(l){l&&F(e),t&&J(t),l&&n&&n.end()}}}function yh(i){let e,t,n,r,s,a,o,l,c=i[0].title+"",u,f,d,p,m,h,_;const g=[vh,bh],v=[];function b(M,E){return M[0].isStarred==="1"?0:1}r=b(i),s=v[r]=g[r](i);let y=i[0].hasPanel&&Qa(i),w=i[2]&&$a(i);return{c(){e=N("div"),t=N("div"),n=N("div"),s.c(),a=Y(),o=N("div"),l=N("p"),u=Z(c),f=Y(),y&&y.c(),p=Y(),w&&w.c(),L(n,"class","cursor-pointer row-col-panel"),L(l,"class","txt-sm font-medium title"),L(o,"class","panel-title-chevron"),L(t,"id","main-panel"),L(t,"class",d="closed-panel "+i[1])},m(M,E){O(M,e,E),S(e,t),S(t,n),v[r].m(n,null),S(t,a),S(t,o),S(o,l),S(l,u),S(o,f),y&&y.m(o,null),S(e,p),w&&w.m(e,null),m=!0,h||(_=[Oe(n,"click",i[7]),Oe(o,"click",i[8])],h=!0)},p(M,[E]){let x=r;r=b(M),r===x?v[r].p(M,E):(Ve(),I(v[x],1,1,()=>{v[x]=null}),Ge(),s=v[r],s?s.p(M,E):(s=v[r]=g[r](M),s.c()),k(s,1),s.m(n,null)),(!m||E&1)&&c!==(c=M[0].title+"")&&de(u,c),M[0].hasPanel?y?(y.p(M,E),E&1&&k(y,1)):(y=Qa(M),y.c(),k(y,1),y.m(o,null)):y&&(Ve(),I(y,1,1,()=>{y=null}),Ge()),(!m||E&2&&d!==(d="closed-panel "+M[1]))&&L(t,"class",d),M[2]?w?(w.p(M,E),E&4&&k(w,1)):(w=$a(M),w.c(),k(w,1),w.m(e,null)):w&&(Ve(),I(w,1,1,()=>{w=null}),Ge())},i(M){m||(k(s),k(y),k(w),m=!0)},o(M){I(s),I(y),I(w),m=!1},d(M){M&&F(e),v[r].d(),y&&y.d(),w&&w.d(),h=!1,wt(_)}}}function wh(i,e,t){let n,{panelData:r,bgColor:s}=e,a=!1,o=!1,l,{locales:c}=vt;ft(i,c,_=>t(9,n=_));let u=n,f=[{component:bd,titles:[u.Clothes_Menu,u.Player_Info,u.Revive,u.Teleport_to_Player,u.Open_Inventory,u.Freeze_Player,u.Clear_Inventory,u.Bring_Player,u.Spectate_Player,u.Saved_Locations,u.Open_Trunk,u.Open_Glovebox,u.Unban_Player,u.Show_Props,u.Drunk_Player,u.Set_Player_on_Fire,u.Slap_Player_In_Sky,u.Send_Player_To_JailBox,u.Change_Vehicle_State,u.Force_Logout_Player,u.Give_Outfits,u.Damage_Player_Vehicle,u.Heal,u.Wipe_Player,u.Pee_Player,u.Poop_Player]},{component:Cd,titles:[u.Open_Stash,u.Kick,u.Warn,u.DM_Player]},{component:Ad,titles:[u.Give_Car,u.Give_Job,u.Give_Gang,u.Change_Ped_Model,u.Play_Sound_On_Player]},{component:Kd,titles:[u.Clear_Area_Vehicles,u.Clear_Area_Peds,u.Clear_Area_Objects]},{component:Yf,titles:[u.Give_Item,u.Give_Money]},{component:cd,titles:[u.Create_Job_Stashes,u.Create_Gang_Stashes]},{component:zf,titles:[u.Announce,u.search_by_citizen_id]},{component:Xd,titles:[u.Ban_Offline_Player,u.Ban_Player]},{component:Df,titles:[u.Spawn_Car]},{component:Vf,titles:[u.Teleport_Coords]},{component:$f,titles:[u.Change_Plate]},{component:rd,titles:[u.Spawn_Objects]},{component:Nd,titles:[u.Copy_Coordinates]},{component:th,titles:[u.Change_Weather]},{component:oh,titles:[u.Change_Time]},{component:gh,custom:!0}],d={};at(()=>{r.tabName==="custom"?t(5,d={panelData:r,localeConsts:u}):t(5,d={title:r.title,localeConsts:u})});const p=ln();function m(){t(0,r.isStarred=r.isStarred==="1"?"0":"1",r),localStorage.setItem(r.title,r.isStarred),p("star",{panelData:r})}function h(){r.hasPanel?(f.filter(_=>{(r.tabName==="custom"&&_.hasOwnProperty("custom")&&_.custom||_.hasOwnProperty("titles")&&_.titles.includes(r.title))&&t(4,l=_.component)}),t(3,o=!o),t(2,a=!a)):p("panelClicked",{panelData:r})}return i.$$set=_=>{"panelData"in _&&t(0,r=_.panelData),"bgColor"in _&&t(1,s=_.bgColor)},[r,s,a,o,l,d,c,m,h]}class xh extends Ze{constructor(e){super(),Ye(this,e,wh,yh,qe,{panelData:0,bgColor:1})}}function Mh(i){let e,t,n=i[0].choose_theme_label+"",r,s,a,o,l,c,u=i[0].save_btn+"",f,d,p,m;return o=new Ui({props:{dropdownValues:i[2]}}),o.$on("regular-dropdown-select",i[4]),{c(){e=N("div"),t=N("p"),r=Z(n),s=Z(":"),a=Y(),Q(o.$$.fragment),l=Y(),c=N("button"),f=Z(u),L(t,"class","heading svelte-y55mif"),L(c,"class","block change-theme-btn txt-sm"),L(e,"class","main-body svelte-y55mif")},m(h,_){O(h,e,_),S(e,t),S(t,r),S(t,s),S(e,a),K(o,e,null),S(e,l),S(e,c),S(c,f),d=!0,p||(m=Oe(c,"click",i[3]),p=!0)},p(h,[_]){(!d||_&1)&&n!==(n=h[0].choose_theme_label+"")&&de(r,n),(!d||_&1)&&u!==(u=h[0].save_btn+"")&&de(f,u)},i(h){d||(k(o.$$.fragment,h),d=!0)},o(h){I(o.$$.fragment,h),d=!1},d(h){h&&F(e),J(o),p=!1,m()}}}function Sh(i,e,t){let{localeConsts:n}=e,r=["Original","Dark","Project Sloth by Stone","QBCore by Stone","Surge by rust1co","VLT by Ryder","Vice By NRP","Svein By NRP","Notorious By NRP","NP theme by Jakobe"],s="";const a=ln();at(()=>{t(1,s=localStorage.getItem("theme-chosen")?localStorage.getItem("theme-chosen"):r[0]),o()});function o(){localStorage.setItem("theme-chosen",s),a("theme-changed")}const l=c=>t(1,s=c.detail);return i.$$set=c=>{"localeConsts"in c&&t(0,n=c.localeConsts)},[n,s,r,o,l]}class Ch extends Ze{constructor(e){super(),Ye(this,e,Sh,Mh,qe,{localeConsts:0})}}const Th=()=>{const i={filterAndSort(e,t,n,r,s,a){let o=i.filterArray(e,t,n);return r==="alpha"?i.alphabeticalSort(o,s):i.numericSort(o,s,a)},filterArray(e,t,n){return e.filter(r=>{if(r[t].toLocaleLowerCase().includes(n.toLocaleLowerCase()))return r})},toggleToolTip(e){const t=document.getElementById(e);t.style.visibility=t.style.visibility==="visible"?"hidden":"visible"},alphabeticalSort(e,t){return e.sort((n,r)=>n[t].localeCompare(r[t]))},numericSort(e,t,n){return n==="asc"?e.sort((r,s)=>r[t]-s[t]):e.sort((r,s)=>s[t]-r[t])},booleanSort(e,t,n){return n==="asc"?e.sort((r,s)=>Number(s[t])-Number(r[t])):e.sort((r,s)=>Number(r[t])-Number(s[t]))},upperCaseFirstLetter(e){return e.charAt(0).toUpperCase()+e.slice(1)},changeTimeBasedOnTimeZone(e,t){return e.map(n=>{var r=new Date(n[t]*1e3);let s=Intl.DateTimeFormat().resolvedOptions().timeZone,a=r.toLocaleString("en-US",{timeZone:s});return n.formattedTime=a,n})},copyToClipboard(e){const t=document.createElement("textarea");t.value=e,document.body.appendChild(t),t.select(),document.execCommand("copy"),document.body.removeChild(t)}};return{...i}},it=Th();function eo(i,e,t){const n=i.slice();return n[17]=e[t],n}function to(i,e,t){const n=i.slice();return n[20]=e[t],n}function no(i){let e,t=[],n=new Map,r,s=i[0];const a=o=>o[20];for(let o=0;o<s.length;o+=1){let l=to(i,s,o),c=a(l);n.set(c,t[o]=io(c,l))}return{c(){e=N("div");for(let o=0;o<t.length;o+=1)t[o].c();L(e,"class","selected-tabs svelte-1jca6p2")},m(o,l){O(o,e,l);for(let c=0;c<t.length;c+=1)t[c].m(e,null);r=!0},p(o,l){if(l&513){s=o[0],Ve();for(let c=0;c<t.length;c+=1)t[c].r();t=xr(t,l,a,1,o,s,n,e,ds,io,null,to);for(let c=0;c<t.length;c+=1)t[c].a();Ge()}},i(o){if(!r){for(let l=0;l<s.length;l+=1)k(t[l]);r=!0}},o(o){for(let l=0;l<t.length;l+=1)I(t[l]);r=!1},d(o){o&&F(e);for(let l=0;l<t.length;l+=1)t[l].d()}}}function io(i,e){let t,n=e[20]+"",r,s,a,o,l,c=ge,u,f,d;o=new It({props:{icon:Pc,class:"txt-2xs hover:text-gray"}});function p(){return e[12](e[20])}return{key:i,first:null,c(){t=N("div"),r=Z(n),s=Y(),a=N("div"),Q(o.$$.fragment),L(a,"class","admin-settings-chip-cross"),L(t,"class","txt-sm admin-settings-chip"),this.first=t},m(m,h){O(m,t,h),S(t,r),S(t,s),S(t,a),K(o,a,null),u=!0,f||(d=Oe(a,"click",p),f=!0)},p(m,h){e=m,(!u||h&1)&&n!==(n=e[20]+"")&&de(r,n)},r(){l=t.getBoundingClientRect()},f(){wr(t),c()},a(){c(),c=yr(t,l,Mr,{duration:1200})},i(m){u||(k(o.$$.fragment,m),u=!0)},o(m){I(o.$$.fragment,m),u=!1},d(m){m&&F(t),J(o),f=!1,d()}}}function Eh(i){let e,t,n,r,s,a=i[2].save_btn+"",o,l,c;return{c(){e=N("input"),t=Y(),n=N("div"),r=N("div"),s=N("button"),o=Z(a),L(e,"type","text"),L(e,"class","inline-block"),L(s,"class","admin-settings-save-btn txt-sm"),L(r,"class","admin-settings-save"),L(n,"class","inline-block float-right")},m(u,f){O(u,e,f),kt(e,i[4]),O(u,t,f),O(u,n,f),S(n,r),S(r,s),S(s,o),l||(c=[Oe(e,"input",i[13]),Oe(e,"keyup",i[8]),Oe(s,"click",i[10])],l=!0)},p(u,f){f&16&&e.value!==u[4]&&kt(e,u[4]),f&4&&a!==(a=u[2].save_btn+"")&&de(o,a)},d(u){u&&F(e),u&&F(t),u&&F(n),l=!1,wt(c)}}}function Lh(i){let e,t=i[2].search_panels_placeholder+"",n;return{c(){e=N("p"),n=Z(t),L(e,"class","txt-sm")},m(r,s){O(r,e,s),S(e,n)},p(r,s){s&4&&t!==(t=r[2].search_panels_placeholder+"")&&de(n,t)},d(r){r&&F(e)}}}function ro(i){let e,t=[],n=new Map,r=i[5];const s=a=>a[17];for(let a=0;a<r.length;a+=1){let o=eo(i,r,a),l=s(o);n.set(l,t[a]=so(l,o))}return{c(){e=N("div");for(let a=0;a<t.length;a+=1)t[a].c();L(e,"id","dropdownmenu"),L(e,"class","admin-settings-show-drop-down")},m(a,o){O(a,e,o);for(let l=0;l<t.length;l+=1)t[l].m(e,null)},p(a,o){if(o&160){r=a[5];for(let l=0;l<t.length;l+=1)t[l].r();t=xr(t,o,s,1,a,r,n,e,Tu,so,null,eo);for(let l=0;l<t.length;l+=1)t[l].a()}},d(a){a&&F(e);for(let o=0;o<t.length;o+=1)t[o].d()}}}function so(i,e){let t,n=e[17].title+"",r,s,a=ge,o,l;function c(){return e[14](e[17])}return{key:i,first:null,c(){t=N("p"),r=Z(n),this.first=t},m(u,f){O(u,t,f),S(t,r),o||(l=Oe(t,"click",c),o=!0)},p(u,f){e=u,f&32&&n!==(n=e[17].title+"")&&de(r,n)},r(){s=t.getBoundingClientRect()},f(){wr(t),a()},a(){a(),a=yr(t,s,Mr,{duration:500})},d(u){u&&F(t),o=!1,l()}}}function Ph(i){let e,t,n=i[2].choose_options_for_role_access_text+"",r,s,a,o,l,c,u,f,d,p,m,h,_=i[0].length>0&&no(i);function g(w,M){return w[0].length===0&&!w[3]?Lh:Eh}let v=g(i),b=v(i),y=i[3]&&ro(i);return{c(){e=N("div"),t=N("div"),r=Z(n),s=Y(),a=Z(i[1]),o=Z(":"),l=Y(),_&&_.c(),c=Y(),u=N("div"),b.c(),d=Y(),y&&y.c(),L(t,"class","txt-md heading svelte-1jca6p2"),L(u,"class",f="admin-settings-search-bar "+(i[0].length===0&&!i[3]?"mtop-2":"")),L(u,"id","search"),L(e,"class","main-body svelte-1jca6p2")},m(w,M){O(w,e,M),S(e,t),S(t,r),S(t,s),S(t,a),S(t,o),S(e,l),_&&_.m(e,null),S(e,c),S(e,u),b.m(u,null),S(e,d),y&&y.m(e,null),p=!0,m||(h=Oe(u,"click",i[6]),m=!0)},p(w,[M]){(!p||M&4)&&n!==(n=w[2].choose_options_for_role_access_text+"")&&de(r,n),(!p||M&2)&&de(a,w[1]),w[0].length>0?_?(_.p(w,M),M&1&&k(_,1)):(_=no(w),_.c(),k(_,1),_.m(e,c)):_&&(Ve(),I(_,1,1,()=>{_=null}),Ge()),v===(v=g(w))&&b?b.p(w,M):(b.d(1),b=v(w),b&&(b.c(),b.m(u,null))),(!p||M&9&&f!==(f="admin-settings-search-bar "+(w[0].length===0&&!w[3]?"mtop-2":"")))&&L(u,"class",f),w[3]?y?y.p(w,M):(y=ro(w),y.c(),y.m(e,null)):y&&(y.d(1),y=null)},i(w){p||(k(_),p=!0)},o(w){I(_),p=!1},d(w){w&&F(e),_&&_.d(),b.d(),y&&y.d(),m=!1,h()}}}function Ah(i,e,t){let{dropdownMenu:n}=e,{selectedValues:r=[]}=e,{role:s,localeConsts:a}=e,o=!1,l="",c=[];at(()=>{t(5,c=u()),t(5,c=it.alphabeticalSort(c,"title"))});function u(){return t(5,c=n.filter(b=>{if(!r.includes(b.title))return b})),c}function f(){t(3,o=!0),t(5,c=u()),t(5,c=it.alphabeticalSort(c,"title"))}function d(b){r.push(b.title),t(0,r),t(5,c=u()),p()}function p(){u();let b=c.filter(y=>{if(y.title.toLocaleLowerCase().includes(l.toLocaleLowerCase()))return y});t(5,c=it.alphabeticalSort(b,"title"))}function m(b){const y=r.indexOf(b);r.splice(y,1),t(0,r),p()}async function h(){await Ne("saveModeratorCommands",{role:s,selectedValues:r})}const _=b=>m(b);function g(){l=this.value,t(4,l)}const v=b=>d(b);return i.$$set=b=>{"dropdownMenu"in b&&t(11,n=b.dropdownMenu),"selectedValues"in b&&t(0,r=b.selectedValues),"role"in b&&t(1,s=b.role),"localeConsts"in b&&t(2,a=b.localeConsts)},[r,s,a,o,l,c,f,d,p,m,h,n,_,g,v]}class Dh extends Ze{constructor(e){super(),Ye(this,e,Ah,Ph,qe,{dropdownMenu:11,selectedValues:0,role:1,localeConsts:2})}}function Rh(i){let e,t,n,r,s,a;e=new Ui({props:{dropdownValues:i[2]}}),e.$on("regular-dropdown-select",i[9]);const o=[Nh,Ih],l=[];function c(u,f){return u[6]?0:1}return n=c(i),r=l[n]=o[n](i),{c(){Q(e.$$.fragment),t=Y(),r.c(),s=Zt()},m(u,f){K(e,u,f),O(u,t,f),l[n].m(u,f),O(u,s,f),a=!0},p(u,f){const d={};f&4&&(d.dropdownValues=u[2]),e.$set(d);let p=n;n=c(u),n===p?l[n].p(u,f):(Ve(),I(l[p],1,1,()=>{l[p]=null}),Ge(),r=l[n],r?r.p(u,f):(r=l[n]=o[n](u),r.c()),k(r,1),r.m(s.parentNode,s))},i(u){a||(k(e.$$.fragment,u),k(r),a=!0)},o(u){I(e.$$.fragment,u),I(r),a=!1},d(u){J(e,u),u&&F(t),l[n].d(u),u&&F(s)}}}function kh(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Ih(i){let e,t;return e=new Dh({props:{dropdownMenu:i[0],selectedValues:i[4],role:i[3],localeConsts:i[1]}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&1&&(s.dropdownMenu=n[0]),r&16&&(s.selectedValues=n[4]),r&8&&(s.role=n[3]),r&2&&(s.localeConsts=n[1]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Nh(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function zh(i){let e,t,n=i[1].choose_role_for_panel_visibility+"",r,s,a,o,l,c;const u=[kh,Rh],f=[];function d(p,m){return p[5]?0:1}return o=d(i),l=f[o]=u[o](i),{c(){e=N("div"),t=N("p"),r=Z(n),s=Z(":"),a=Y(),l.c(),L(t,"class","heading svelte-18n19w0"),L(e,"class","main-body svelte-18n19w0")},m(p,m){O(p,e,m),S(e,t),S(t,r),S(t,s),S(e,a),f[o].m(e,null),c=!0},p(p,[m]){(!c||m&2)&&n!==(n=p[1].choose_role_for_panel_visibility+"")&&de(r,n);let h=o;o=d(p),o===h?f[o].p(p,m):(Ve(),I(f[h],1,1,()=>{f[h]=null}),Ge(),l=f[o],l?l.p(p,m):(l=f[o]=u[o](p),l.c()),k(l,1),l.m(e,null))},i(p){c||(k(l),c=!0)},o(p){I(l),c=!1},d(p){p&&F(e),f[o].d()}}}function Fh(i,e,t){let n,{panels:r,localeConsts:s}=e,{isDev:a}=vt;ft(i,a,m=>t(10,n=m));let o=[],l="",c=[],u=!1,f=!1;at(async()=>{t(5,u=!0),n?t(2,o=["Moderator","Admin"]):t(2,o=await Ne("getAllRoles")),t(5,u=!1),r.push({title:s.side_panel_player_list})});async function d(m){t(6,f=!0),t(3,l=m.detail);const h={role:l};let _=[];n?_=["Admin Car","Announce"]:_=await Ne("getRoleWisePanels",h),t(4,c=_),t(6,f=!1)}const p=m=>d(m);return i.$$set=m=>{"panels"in m&&t(0,r=m.panels),"localeConsts"in m&&t(1,s=m.localeConsts)},[r,s,o,l,c,u,f,a,d,p]}class Oh extends Ze{constructor(e){super(),Ye(this,e,Fh,zh,qe,{panels:0,localeConsts:1})}}const Uh=()=>({...{canSendMessage(e,t){return e.key==="Enter"&&t!==""},scrollToTop(e,t){setTimeout(()=>{let n=document.getElementById(e);n.scrollTop=n.scrollHeight},t)}}}),On=Uh();function ao(i,e,t){const n=i.slice();return n[11]=e[t],n}function Bh(i){let e,t,n,r,s,a,o,l,c,u,f=i[1],d=[];for(let p=0;p<f.length;p+=1)d[p]=oo(ao(i,f,p));return o=new It({props:{icon:ff}}),{c(){e=N("div");for(let p=0;p<d.length;p+=1)d[p].c();t=Y(),n=N("div"),r=N("textarea"),s=Y(),a=N("div"),Q(o.$$.fragment),L(e,"id","chat-display"),L(e,"class","display-chats svelte-6tspht"),L(r,"class","send-message-input"),L(a,"class","send-msg-icon"),L(n,"class","sending-message-wrapper")},m(p,m){O(p,e,m);for(let h=0;h<d.length;h+=1)d[h].m(e,null);O(p,t,m),O(p,n,m),S(n,r),kt(r,i[3]),S(n,s),S(n,a),K(o,a,null),l=!0,c||(u=[Oe(r,"input",i[9]),Oe(a,"click",i[6]),Oe(n,"keypress",i[8])],c=!0)},p(p,m){if(m&6){f=p[1];let h;for(h=0;h<f.length;h+=1){const _=ao(p,f,h);d[h]?d[h].p(_,m):(d[h]=oo(_),d[h].c(),d[h].m(e,null))}for(;h<d.length;h+=1)d[h].d(1);d.length=f.length}m&8&&kt(r,p[3])},i(p){l||(k(o.$$.fragment,p),l=!0)},o(p){I(o.$$.fragment,p),l=!1},d(p){p&&F(e),Vt(d,p),p&&F(t),p&&F(n),J(o),c=!1,wt(u)}}}function Vh(i){let e,t;return e=new dt({props:{isBig:!0}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function oo(i){let e,t=i[11].msg+"",n,r,s,a,o=i[11].name+"",l,c;return{c(){e=N("div"),n=Z(t),s=Y(),a=N("small"),l=Z(o),L(e,"class",r="chat-panel "+(i[2]===i[11].name?"adjust-border-self even-pane-panel-bg":"adjust-border-others")+" svelte-6tspht"),L(a,"class",c="txt-2xs "+(i[2]===i[11].name?"adjust-border-self":"adjust-border-others")+" svelte-6tspht")},m(u,f){O(u,e,f),S(e,n),O(u,s,f),O(u,a,f),S(a,l)},p(u,f){f&2&&t!==(t=u[11].msg+"")&&de(n,t),f&6&&r!==(r="chat-panel "+(u[2]===u[11].name?"adjust-border-self even-pane-panel-bg":"adjust-border-others")+" svelte-6tspht")&&L(e,"class",r),f&2&&o!==(o=u[11].name+"")&&de(l,o),f&6&&c!==(c="txt-2xs "+(u[2]===u[11].name?"adjust-border-self":"adjust-border-others")+" svelte-6tspht")&&L(a,"class",c)},d(u){u&&F(e),u&&F(s),u&&F(a)}}}function Gh(i){let e,t,n,r,s=i[0].admin_menu_chat_heading+"",a,o,l,c,u,f,d,p,m,h;c=new It({props:{icon:Yu,class:"txt-sm"}});const _=[Vh,Bh],g=[];function v(b,y){return b[4]?0:1}return f=v(i),d=g[f]=_[f](i),{c(){e=N("div"),t=N("div"),n=N("div"),r=N("p"),a=Z(s),o=Y(),l=N("div"),Q(c.$$.fragment),u=Y(),d.c(),L(n,"class","heading"),L(l,"class","refresh"),L(t,"class","chat-header"),L(e,"class","main-body svelte-6tspht")},m(b,y){O(b,e,y),S(e,t),S(t,n),S(n,r),S(r,a),S(t,o),S(t,l),K(c,l,null),S(e,u),g[f].m(e,null),p=!0,m||(h=Oe(l,"click",i[7]),m=!0)},p(b,[y]){(!p||y&1)&&s!==(s=b[0].admin_menu_chat_heading+"")&&de(a,s);let w=f;f=v(b),f===w?g[f].p(b,y):(Ve(),I(g[w],1,1,()=>{g[w]=null}),Ge(),d=g[f],d?d.p(b,y):(d=g[f]=_[f](b),d.c()),k(d,1),d.m(e,null))},i(b){p||(k(c.$$.fragment,b),k(d),p=!0)},o(b){I(c.$$.fragment,b),I(d),p=!1},d(b){b&&F(e),J(c),g[f].d(),m=!1,h()}}}function Hh(i,e,t){let n,{localeConsts:r}=e,{isDev:s}=vt;ft(i,s,m=>t(10,n=m));let a=[],o="",l="",c=!1;at(async()=>{t(4,c=!0);let m={};n?m={chats:[{id:1,name:"name1#1234",msg:"Hey whatsup",time:1670784600},{id:2,name:"Sakshi",msg:"hello",time:1670784600},{id:3,name:"Pushkar",msg:"hi",time:1670784600},{id:4,name:"Sakshi",msg:"hi, im good. what is this nonsense",time:1670784600},{id:5,name:"Monu",msg:"well",time:1670784600},{id:6,name:"Pushkar",msg:"how are you",time:1670784600},{id:7,name:"Monu",msg:"where are you whereare you?? where are you ewwwrweffsdfdsgskhgskjfjksfksfkjsdgkdskjdsnvkjsndjvkngsjkfnjsknvkjnskj",time:1670784600},{id:8,name:"Sakshi",msg:"sad",time:1670784600}],currUserName:"Sakshi"}:m=await Ne("getAdminChats"),t(1,a=it.numericSort(m.chats,"id","asc")),t(2,o=m.currUserName),t(4,c=!1)});async function u(){if(t(4,c=!0),l!==""){const m={userName:o,message:l};let h={};n?h={chats:[{id:1,name:"name1#1234",msg:"Hey whatsup",time:1670784600},{id:2,name:"Sakshi",msg:"hello",time:1670784600},{id:3,name:"Pushkar",msg:"hi",time:1670784600},{id:4,name:"Sakshi",msg:"hi, im good. what is this nonsense",time:1670784600},{id:5,name:"Monu",msg:"well",time:1670784600},{id:6,name:"Pushkar",msg:"how are you",time:1670784600},{id:7,name:"Monu",msg:"where are you whereare you?? where are you ewwwrweffsdfdsgskhgskjfjksfksfkjsdgkdskjdsnvkjsndjvkngsjkfnjsknvkjnskj",time:1670784600},{id:8,name:"Sakshi",msg:"sad",time:1670784600}],currUserName:"Sakshi"}:h=await Ne("adminMessageSent",m),t(1,a=it.numericSort(h.chats,"id","asc"))}t(3,l=""),t(4,c=!1),On.scrollToTop("chat-display",100)}async function f(){t(4,c=!0);let m={};n?m={chats:[{id:1,name:"name1#1234",msg:"Hey whatsup",time:1670784600},{id:2,name:"Sakshi",msg:"hello",time:1670784600},{id:3,name:"Pushkar",msg:"hi",time:1670784600},{id:4,name:"Sakshi",msg:"hi, im good. what is this nonsense",time:1670784600},{id:5,name:"Monu",msg:"well",time:1670784600},{id:6,name:"Pushkar",msg:"how are you",time:1670784600},{id:7,name:"Monu",msg:"where are you whereare you?? where are you ewwwrweffsdfdsgskhgskjfjksfksfkjsdgkdskjdsnvkjsndjvkngsjkfnjsknvkjnskj",time:1670784600},{id:8,name:"Sakshi",msg:"sad",time:1670784600}],currUserName:"Sakshi"}:m=await Ne("refreshChats"),t(1,a=it.numericSort(m.chats,"id","asc")),t(4,c=!1),On.scrollToTop("chat-display",100)}function d(m){On.canSendMessage(m,l)&&u()}function p(){l=this.value,t(3,l)}return i.$$set=m=>{"localeConsts"in m&&t(0,r=m.localeConsts)},[r,a,o,l,c,s,u,f,d,p]}class Wh extends Ze{constructor(e){super(),Ye(this,e,Hh,Gh,qe,{localeConsts:0})}}function lo(i){let e,t,n,r,s,a,o,l=i[1].report_confirm_label+"",c,u,f,d=i[1].report_cancel_label+"",p,m,h;return{c(){e=N("div"),t=N("p"),n=Z(i[0]),r=Z("?"),s=Y(),a=N("div"),o=N("button"),c=Z(l),u=Y(),f=N("button"),p=Z(d),L(t,"class","txt-md"),L(o,"class","small-modal-btns txt-md confirm-btn"),L(f,"class","small-modal-btns txt-md cancel-btn"),L(a,"class","block"),L(e,"class","modal-body small-modal-body")},m(_,g){O(_,e,g),S(e,t),S(t,n),S(t,r),S(e,s),S(e,a),S(a,o),S(o,c),S(a,u),S(a,f),S(f,p),m||(h=[Oe(o,"click",i[4]),Oe(f,"click",i[3])],m=!0)},p(_,g){g&1&&de(n,_[0]),g&2&&l!==(l=_[1].report_confirm_label+"")&&de(c,l),g&2&&d!==(d=_[1].report_cancel_label+"")&&de(p,d)},d(_){_&&F(e),m=!1,wt(h)}}}function co(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Xh(i){let e,t,n,r,s,a=!i[2]&&lo(i),o=i[2]&&co();return{c(){e=N("div"),t=N("div"),n=N("div"),a&&a.c(),r=Y(),o&&o.c(),L(n,"class","modal-content small-modal-content"),L(t,"class","modal-dialog small-modal-dialog"),L(e,"class","modal small-modal"),L(e,"tabindex","-1"),L(e,"aria-hidden","true")},m(l,c){O(l,e,c),S(e,t),S(t,n),a&&a.m(n,null),S(n,r),o&&o.m(n,null),s=!0},p(l,[c]){l[2]?a&&(a.d(1),a=null):a?a.p(l,c):(a=lo(l),a.c(),a.m(n,r)),l[2]?o?c&4&&k(o,1):(o=co(),o.c(),k(o,1),o.m(n,null)):o&&(Ve(),I(o,1,1,()=>{o=null}),Ge())},i(l){s||(k(o),s=!0)},o(l){I(o),s=!1},d(l){l&&F(e),a&&a.d(),o&&o.d()}}}function jh(i,e,t){const n=ln();let{whatToDelete:r="selected data"}=e,{localeConsts:s}=e,a=!1;function o(){n("closeModal")}function l(){t(2,a=!0),n("confirmModalAction"),t(2,a=!1)}return i.$$set=c=>{"whatToDelete"in c&&t(0,r=c.whatToDelete),"localeConsts"in c&&t(1,s=c.localeConsts)},[r,s,a,o,l]}class qh extends Ze{constructor(e){super(),Ye(this,e,jh,Xh,qe,{whatToDelete:0,localeConsts:1})}}function uo(i,e,t){const n=i.slice();return n[24]=e[t],n}function fo(i,e,t){const n=i.slice();return n[27]=e[t],n}function Yh(i){let e,t,n,r=i[0].id+"",s,a,o=i[0].name+"",l,c,u,f,d,p,m,h,_,g,v,b,y,w=i[15],M=[];for(let D=0;D<w.length;D+=1)M[D]=ho(fo(i,w,D));const E=D=>I(M[D],1,1,()=>{M[D]=null});p=new It({props:{icon:Ju}});const x=[Jh,Kh],C=[];function A(D,G){return D[2]?0:1}return h=A(i),_=C[h]=x[h](i),{c(){e=N("div"),t=N("div"),n=Z("("),s=Z(r),a=Z(") "),l=Z(o),c=Y(),u=N("div");for(let D=0;D<M.length;D+=1)M[D].c();f=Y(),d=N("div"),Q(p.$$.fragment),m=Y(),_.c(),g=Zt(),L(t,"class","txt-sm"),L(d,"class","close-icon txt-sm"),L(u,"class","report-children-icons"),L(e,"class","report-info")},m(D,G){O(D,e,G),S(e,t),S(t,n),S(t,s),S(t,a),S(t,l),S(e,c),S(e,u);for(let U=0;U<M.length;U+=1)M[U].m(u,null);S(u,f),S(u,d),K(p,d,null),O(D,m,G),C[h].m(D,G),O(D,g,G),v=!0,b||(y=Oe(d,"click",i[9]),b=!0)},p(D,G){if((!v||G&1)&&r!==(r=D[0].id+"")&&de(s,r),(!v||G&1)&&o!==(o=D[0].name+"")&&de(l,o),G&33794){w=D[15];let z;for(z=0;z<w.length;z+=1){const X=fo(D,w,z);M[z]?(M[z].p(X,G),k(M[z],1)):(M[z]=ho(X),M[z].c(),k(M[z],1),M[z].m(u,f))}for(Ve(),z=w.length;z<M.length;z+=1)E(z);Ge()}let U=h;h=A(D),h===U?C[h].p(D,G):(Ve(),I(C[U],1,1,()=>{C[U]=null}),Ge(),_=C[h],_?_.p(D,G):(_=C[h]=x[h](D),_.c()),k(_,1),_.m(g.parentNode,g))},i(D){if(!v){for(let G=0;G<w.length;G+=1)k(M[G]);k(p.$$.fragment,D),k(_),v=!0}},o(D){M=M.filter(Boolean);for(let G=0;G<M.length;G+=1)I(M[G]);I(p.$$.fragment,D),I(_),v=!1},d(D){D&&F(e),Vt(M,D),J(p),D&&F(m),C[h].d(D),D&&F(g),b=!1,y()}}}function Zh(i){let e,t;return e=new qh({props:{whatToDelete:i[7],localeConsts:i[1]}}),e.$on("closeModal",i[16]),e.$on("confirmModalAction",i[11]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&128&&(s.whatToDelete=n[7]),r&2&&(s.localeConsts=n[1]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function ho(i){let e,t,n,r,s=i[1][i[27].localConstKey]+"",a,o,l,c;t=new It({props:{icon:i[27].icon}});function u(){return i[17](i[27])}function f(){return i[18](i[27])}function d(){return i[19](i[27])}return{c(){e=N("div"),Q(t.$$.fragment),n=Y(),r=N("span"),a=Z(s),L(r,"id",i[27].id),L(r,"class","tool-tip-text-top-report"),L(e,"class","close-icon txt-sm")},m(p,m){O(p,e,m),K(t,e,null),S(e,n),S(e,r),S(r,a),o=!0,l||(c=[Oe(e,"click",u),Oe(e,"mouseenter",f),Oe(e,"mouseleave",d)],l=!0)},p(p,m){i=p,(!o||m&2)&&s!==(s=i[1][i[27].localConstKey]+"")&&de(a,s)},i(p){o||(k(t.$$.fragment,p),o=!0)},o(p){I(t.$$.fragment,p),o=!1},d(p){p&&F(e),J(t),l=!1,wt(c)}}}function Kh(i){let e,t,n,r,s,a,o,l=i[1].close_btn+"",c,u,f,d=i[1].send_btn+"",p,m,h,_,g=i[3],v=[];for(let b=0;b<g.length;b+=1)v[b]=po(uo(i,g,b));return{c(){e=N("div");for(let b=0;b<v.length;b+=1)v[b].c();t=Y(),n=N("div"),r=N("textarea"),s=Y(),a=N("div"),o=N("button"),c=Z(l),u=Y(),f=N("button"),p=Z(d),L(e,"id","chat-display"),L(e,"class","report-display-message-wrapper svelte-15b8wcv"),L(r,"class","report-send-message-input"),L(o,"class","txt-xs report-admin-btns-close"),L(f,"class",m="txt-xs report-admin-btns-send "+(i[5].trim()===""?"disable-icon":"report-admin-btns-send-enabled")+" svelte-15b8wcv"),L(a,"class","report-admin-btns"),L(n,"class","report-send-message-wrapper")},m(b,y){O(b,e,y);for(let w=0;w<v.length;w+=1)v[w].m(e,null);O(b,t,y),O(b,n,y),S(n,r),kt(r,i[5]),S(n,s),S(n,a),S(a,o),S(o,c),S(a,u),S(a,f),S(f,p),h||(_=[Oe(r,"input",i[20]),Oe(o,"click",i[12]),Oe(f,"click",i[21]),Oe(n,"keypress",i[14])],h=!0)},p(b,y){if(y&24){g=b[3];let w;for(w=0;w<g.length;w+=1){const M=uo(b,g,w);v[w]?v[w].p(M,y):(v[w]=po(M),v[w].c(),v[w].m(e,null))}for(;w<v.length;w+=1)v[w].d(1);v.length=g.length}y&32&&kt(r,b[5]),y&2&&l!==(l=b[1].close_btn+"")&&de(c,l),y&2&&d!==(d=b[1].send_btn+"")&&de(p,d),y&32&&m!==(m="txt-xs report-admin-btns-send "+(b[5].trim()===""?"disable-icon":"report-admin-btns-send-enabled")+" svelte-15b8wcv")&&L(f,"class",m)},i:ge,o:ge,d(b){b&&F(e),Vt(v,b),b&&F(t),b&&F(n),h=!1,wt(_)}}}function Jh(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function po(i){let e,t,n=i[24].message+"",r,s,a,o,l=(i[4]===i[24].sender?"You":i[24].sender)+"",c,u,f=i[24].formattedTime+"",d,p,m;return{c(){e=N("div"),t=N("div"),r=Z(n),a=Y(),o=N("small"),c=Z(l),u=Z(", "),d=Z(f),m=Y(),L(t,"class",s="report-chat-panel "+(i[4]===i[24].sender?"adjust-border-self even-pane-panel-bg":"adjust-border-others")+" svelte-15b8wcv"),L(o,"class",p="sender-info-display "+(i[4]===i[24].sender?"adjust-border-self":"adjust-border-others")+" svelte-15b8wcv"),L(e,"class","report-chat-body svelte-15b8wcv")},m(h,_){O(h,e,_),S(e,t),S(t,r),S(e,a),S(e,o),S(o,c),S(o,u),S(o,d),S(e,m)},p(h,_){_&8&&n!==(n=h[24].message+"")&&de(r,n),_&24&&s!==(s="report-chat-panel "+(h[4]===h[24].sender?"adjust-border-self even-pane-panel-bg":"adjust-border-others")+" svelte-15b8wcv")&&L(t,"class",s),_&24&&l!==(l=(h[4]===h[24].sender?"You":h[24].sender)+"")&&de(c,l),_&8&&f!==(f=h[24].formattedTime+"")&&de(d,f),_&24&&p!==(p="sender-info-display "+(h[4]===h[24].sender?"adjust-border-self":"adjust-border-others")+" svelte-15b8wcv")&&L(o,"class",p)},d(h){h&&F(e)}}}function Qh(i){let e,t,n,r;const s=[Zh,Yh],a=[];function o(l,c){return l[6]?0:1}return t=o(i),n=a[t]=s[t](i),{c(){e=N("div"),n.c(),L(e,"class","main-body svelte-15b8wcv")},m(l,c){O(l,e,c),a[t].m(e,null),r=!0},p(l,[c]){let u=t;t=o(l),t===u?a[t].p(l,c):(Ve(),I(a[u],1,1,()=>{a[u]=null}),Ge(),n=a[t],n?n.p(l,c):(n=a[t]=s[t](l),n.c()),k(n,1),n.m(e,null))},i(l){r||(k(n),r=!0)},o(l){I(n),r=!1},d(l){l&&F(e),a[t].d()}}}function $h(i,e,t){let n;const r=ln();let{selectedPlayer:s,localeConsts:a}=e,{isDev:o}=vt;ft(i,o,D=>t(22,n=D));let l=!1,c=[],u="",f="",d=!1,p="";at(async()=>{t(2,l=!0);const D={playerId:s.name};let G={};n?G={currentUser:"Monu",chats:[{sender:"sakshi#1234",message:"Hey whatsup",time:1670784600},{sender:"sakshi#1234",message:"hello",time:1670784600},{sender:"Pushkar",message:"hi",time:1670784600},{sender:"sakshi#1234",message:"hi, im good. what is this nonsense",time:1670784600},{sender:"Monu",message:"well",time:1670784600},{sender:"Pushkar",message:"how are you",time:1670784600},{sender:"Monu",message:"where are you whereare you?? where are you ewwwrweffsdfdsgskhgskjfjksfksfkjsdgkdskjdsnvkjsndjvkngsjkfnjsknvkjnskj",time:1670784600},{sender:"sakshi#1234",message:"sad",time:1670784600},{sender:"sakshi#1234",message:"Hey whatsup",time:1670784600},{sender:"sakshi#1234",message:"hello",time:1670784600},{sender:"Pushkar",message:"hi",time:1670784600},{sender:"sakshi#1234",message:"hi, im good. what is this nonsense",time:1670784600},{sender:"Monu",message:"well",time:1670784600},{sender:"Pushkar",message:"how are you",time:1670784600}]}:G=await Ne("getPlayerChats",D),t(3,c=G.chats),t(4,u=G.currentUser),t(3,c=it.changeTimeBasedOnTimeZone(c,"time")),t(2,l=!1),On.scrollToTop("chat-display",100)});function m(){r("closePage")}function h(D){const G={playerId:s.id};let U="";D=="teleport"?U="teleportToPlayerReport":D=="spectate"?U="spectatePlayerReport":D=="bring"?U="bringPlayerReport":D=="sendback"&&(U="sendBackReport"),Ne(U,G)}async function _(){const D={playerId:s.id,playerName:s.name};await Ne("closeTicket",D),r("closePage")}function g(){t(6,d=!0),t(7,p=a.delete_modal_message+" "+s.name)}async function v(){if(t(2,l=!0),f!==""){const D={sender:u,message:f,playerId:s.name},G=await Ne("sendMessageFromAdmin",D);t(3,c=G.chats),t(3,c=it.changeTimeBasedOnTimeZone(c,"time"))}t(5,f=""),t(7,p=""),t(2,l=!1),On.scrollToTop("chat-display",100)}function b(D){On.canSendMessage(D,f)&&v()}let y=[{id:"spectate-id",actionValue:"spectate",icon:mf,localConstKey:"spectate_tooltip"},{id:"bring-id",actionValue:"bring",icon:lf,localConstKey:"bring_tooltip"},{id:"send-back-id",actionValue:"sendback",icon:af,localConstKey:"send_back_tooltip"},{id:"teleport-id",actionValue:"teleport",icon:cf,localConstKey:"teleport_tooltip"}];const w=()=>t(6,d=!1),M=D=>h(D.actionValue),E=D=>it.toggleToolTip(D.id),x=D=>it.toggleToolTip(D.id);function C(){f=this.value,t(5,f)}const A=()=>v();return i.$$set=D=>{"selectedPlayer"in D&&t(0,s=D.selectedPlayer),"localeConsts"in D&&t(1,a=D.localeConsts)},[s,a,l,c,u,f,d,p,o,m,h,_,g,v,b,y,w,M,E,x,C,A]}class ep extends Ze{constructor(e){super(),Ye(this,e,$h,Qh,qe,{selectedPlayer:0,localeConsts:1})}}function tp(i){let e,t,n,r;return{c(){e=N("div"),t=N("input"),L(t,"placeholder",i[0]),L(e,"class","search-bar txt-xs")},m(s,a){O(s,e,a),S(e,t),kt(t,i[1]),n||(r=[Oe(t,"keyup",i[2]),Oe(t,"input",i[3])],n=!0)},p(s,[a]){a&1&&L(t,"placeholder",s[0]),a&2&&t.value!==s[1]&&kt(t,s[1])},i:ge,o:ge,d(s){s&&F(e),n=!1,wt(r)}}}function np(i,e,t){let{placeholder:n}=e;const r=ln();let s="";function a(){r("search-value-update",s)}function o(){s=this.value,t(1,s)}return i.$$set=l=>{"placeholder"in l&&t(0,n=l.placeholder)},[n,s,a,o]}class hs extends Ze{constructor(e){super(),Ye(this,e,np,tp,qe,{placeholder:0})}}function mo(i,e,t){const n=i.slice();return n[14]=e[t],n}function ip(i){let e,t,n,r;e=new hs({props:{placeholder:i[0].search_placeholder}}),e.$on("search-value-update",i[9]);let s=i[3],a=[];for(let o=0;o<s.length;o+=1)a[o]=_o(mo(i,s,o));return{c(){Q(e.$$.fragment),t=Y();for(let o=0;o<a.length;o+=1)a[o].c();n=Zt()},m(o,l){K(e,o,l),O(o,t,l);for(let c=0;c<a.length;c+=1)a[c].m(o,l);O(o,n,l),r=!0},p(o,l){const c={};if(l&1&&(c.placeholder=o[0].search_placeholder),e.$set(c),l&89){s=o[3];let u;for(u=0;u<s.length;u+=1){const f=mo(o,s,u);a[u]?a[u].p(f,l):(a[u]=_o(f),a[u].c(),a[u].m(n.parentNode,n))}for(;u<a.length;u+=1)a[u].d(1);a.length=s.length}},i(o){r||(k(e.$$.fragment,o),r=!0)},o(o){I(e.$$.fragment,o),r=!1},d(o){J(e,o),o&&F(t),Vt(a,o),o&&F(n)}}}function rp(i){let e,t;return e=new ep({props:{selectedPlayer:i[4],localeConsts:i[0]}}),e.$on("closePage",i[8]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r&16&&(s.selectedPlayer=n[4]),r&1&&(s.localeConsts=n[0]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function sp(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function _o(i){let e,t,n=i[14].id+"",r,s,a=i[14].name+"",o,l,c,u=i[0].last_updated+"",f,d,p=i[6](i[14].time)+"",m,h,_,g;function v(){return i[10](i[14])}return{c(){e=N("div"),t=Z("("),r=Z(n),s=Z(") "),o=Z(a),l=Y(),c=N("div"),f=Z(u),d=Y(),m=Z(p),h=Y(),L(c,"class","report-time-wrapper"),L(e,"class","reports-wrapper txt-md")},m(b,y){O(b,e,y),S(e,t),S(e,r),S(e,s),S(e,o),S(e,l),S(e,c),S(c,f),S(c,d),S(c,m),S(e,h),_||(g=Oe(e,"click",v),_=!0)},p(b,y){i=b,y&8&&n!==(n=i[14].id+"")&&de(r,n),y&8&&a!==(a=i[14].name+"")&&de(o,a),y&1&&u!==(u=i[0].last_updated+"")&&de(f,u),y&8&&p!==(p=i[6](i[14].time)+"")&&de(m,p)},d(b){b&&F(e),_=!1,g()}}}function ap(i){let e,t,n,r,s=i[0].reports_heading+"",a,o,l,c,u,f;const d=[sp,rp,ip],p=[];function m(h,_){return h[1]?0:h[4]!==""?1:2}return c=m(i),u=p[c]=d[c](i),{c(){e=N("div"),t=N("div"),n=N("div"),r=N("p"),a=Z(s),o=Y(),l=N("div"),u.c(),L(n,"class","heading"),L(t,"class","chat-header"),L(l,"class","report-body svelte-1wsh5b6"),L(e,"class","main-body svelte-1wsh5b6")},m(h,_){O(h,e,_),S(e,t),S(t,n),S(n,r),S(r,a),S(e,o),S(e,l),p[c].m(l,null),f=!0},p(h,[_]){(!f||_&1)&&s!==(s=h[0].reports_heading+"")&&de(a,s);let g=c;c=m(h),c===g?p[c].p(h,_):(Ve(),I(p[g],1,1,()=>{p[g]=null}),Ge(),u=p[c],u?u.p(h,_):(u=p[c]=d[c](h),u.c()),k(u,1),u.m(l,null))},i(h){f||(k(u),f=!0)},o(h){I(u),f=!1},d(h){h&&F(e),p[c].d()}}}function op(i,e,t){let n,{localeConsts:r}=e,{isDev:s}=vt;ft(i,s,g=>t(13,n=g));let a=!1,o=[],l="",c=[],u="",f="";at(async()=>{t(1,a=!0);let g={};n?g={players:[{id:1,name:"sakshi#1234",time:1670784600}],currentUser:"pushkar@3445"}:g=await Ne("getAllUserNameWithReports"),o=g.players,t(3,c=it.numericSort(o,"time","desc")),t(1,a=!1)});function d(g){var v=new Date(g*1e3);let b=Intl.DateTimeFormat().resolvedOptions().timeZone;return f=v.toLocaleString("en-US",{timeZone:b}),f}function p(){t(3,c=it.filterAndSort(o,"name",l,"alpha","name"))}async function m(){t(1,a=!0);let g={};n?g={playerIds:[{id:1,name:"sakshi#1234"},"pushkar@3445"]}:g=await Ne("getAllUserNameWithReports"),o=g.players,t(3,c=it.numericSort(o,"time","desc")),t(1,a=!1),t(4,u="")}const h=g=>{t(2,l=g.detail),p()},_=g=>{t(4,u=g)};return i.$$set=g=>{"localeConsts"in g&&t(0,r=g.localeConsts)},[r,a,l,c,u,s,d,p,m,h,_]}class lp extends Ze{constructor(e){super(),Ye(this,e,op,ap,qe,{localeConsts:0})}}function go(i,e,t){const n=i.slice();return n[11]=e[t],n}function bo(i,e,t){const n=i.slice();return n[14]=e[t],n}function cp(i){let e,t=i[1].formattedTime+"",n;return{c(){e=N("p"),n=Z(t)},m(r,s){O(r,e,s),S(e,n)},p(r,s){s&2&&t!==(t=r[1].formattedTime+"")&&de(n,t)},i:ge,o:ge,d(r){r&&F(e)}}}function up(i){let e,t,n;return t=new It({props:{icon:i[5]?os:_r,class:"txt-xs"}}),{c(){e=N("div"),Q(t.$$.fragment),L(e,"class","chevron-sign")},m(r,s){O(r,e,s),K(t,e,null),n=!0},p(r,s){const a={};s&32&&(a.icon=r[5]?os:_r),t.$set(a)},i(r){n||(k(t.$$.fragment,r),n=!0)},o(r){I(t.$$.fragment,r),n=!1},d(r){r&&F(e),J(t)}}}function vo(i){let e,t,n,r,s,a,o,l=i[0].citizen_id_label+"",c,u,f=i[1].info.citizenId+"",d,p,m,h,_=i[0].name_label+"",g,v,b=i[1].info.name+"",y,w,M,E,x=i[0].job_label+"",C,A,D=i[1].info.job+"",G,U,z,X,ae=i[0].gang_label+"",le,$,ne=i[1].info.gang+"",ue,be,q,ce,he=i[0].cash_bank_label+"",W,Se,we=i[1].info.cashBalance+"",Ee,Ce,Fe=i[1].info.bankBalance+"",ze,oe,ye,Le,Xe=i[0].radio_channel_label+"",ot,Pt,lt=i[1].info.radio+"",ct,en,Ft,R,T=i[0].phone_number_label+"",te,me,pe=i[1].info.phone+"",xe,Be,Me,re,Pe,Re=i[1].licenses,ke=[];for(let _e=0;_e<Re.length;_e+=1)ke[_e]=yo(bo(i,Re,_e));let Ue=i[6],Ae=[];for(let _e=0;_e<Ue.length;_e+=1)Ae[_e]=xo(go(i,Ue,_e));return{c(){e=N("div"),t=N("div"),n=N("div");for(let _e=0;_e<ke.length;_e+=1)ke[_e].c();r=Y(),s=N("div"),a=N("p"),o=N("span"),c=Z(l),u=Z(": "),d=Z(f),p=Y(),m=N("p"),h=N("span"),g=Z(_),v=Z(": "),y=Z(b),w=Y(),M=N("p"),E=N("span"),C=Z(x),A=Z(": "),G=Z(D),U=Y(),z=N("p"),X=N("span"),le=Z(ae),$=Z(": "),ue=Z(ne),be=Y(),q=N("p"),ce=N("span"),W=Z(he),Se=Z(": "),Ee=Z(we),Ce=Z(" / "),ze=Z(Fe),oe=Y(),ye=N("p"),Le=N("span"),ot=Z(Xe),Pt=Z(": "),ct=Z(lt),en=Y(),Ft=N("p"),R=N("span"),te=Z(T),me=Z(": "),xe=Z(pe),Be=Y(),Me=N("div");for(let _e=0;_e<Ae.length;_e+=1)Ae[_e].c();L(s,"class","player-info"),L(n,"class","values"),L(t,"class","open-panel-row"),L(Me,"class","open-panel-row open-panel-row-buttons"),L(e,"class","player-panel-open-panels")},m(_e,je){O(_e,e,je),S(e,t),S(t,n);for(let He=0;He<ke.length;He+=1)ke[He].m(n,null);S(n,r),S(n,s),S(s,a),S(a,o),S(o,c),S(o,u),S(a,d),S(s,p),S(s,m),S(m,h),S(h,g),S(h,v),S(m,y),S(s,w),S(s,M),S(M,E),S(E,C),S(E,A),S(M,G),S(s,U),S(s,z),S(z,X),S(X,le),S(X,$),S(z,ue),S(s,be),S(s,q),S(q,ce),S(ce,W),S(ce,Se),S(q,Ee),S(q,Ce),S(q,ze),S(s,oe),S(s,ye),S(ye,Le),S(Le,ot),S(Le,Pt),S(ye,ct),S(s,en),S(s,Ft),S(Ft,R),S(R,te),S(R,me),S(Ft,xe),S(e,Be),S(e,Me);for(let He=0;He<Ae.length;He+=1)Ae[He].m(Me,null);Pe=!0},p(_e,je){if(je&2){Re=_e[1].licenses;let He;for(He=0;He<Re.length;He+=1){const V=bo(_e,Re,He);ke[He]?ke[He].p(V,je):(ke[He]=yo(V),ke[He].c(),ke[He].m(n,r))}for(;He<ke.length;He+=1)ke[He].d(1);ke.length=Re.length}if((!Pe||je&1)&&l!==(l=_e[0].citizen_id_label+"")&&de(c,l),(!Pe||je&2)&&f!==(f=_e[1].info.citizenId+"")&&de(d,f),(!Pe||je&1)&&_!==(_=_e[0].name_label+"")&&de(g,_),(!Pe||je&2)&&b!==(b=_e[1].info.name+"")&&de(y,b),(!Pe||je&1)&&x!==(x=_e[0].job_label+"")&&de(C,x),(!Pe||je&2)&&D!==(D=_e[1].info.job+"")&&de(G,D),(!Pe||je&1)&&ae!==(ae=_e[0].gang_label+"")&&de(le,ae),(!Pe||je&2)&&ne!==(ne=_e[1].info.gang+"")&&de(ue,ne),(!Pe||je&1)&&he!==(he=_e[0].cash_bank_label+"")&&de(W,he),(!Pe||je&2)&&we!==(we=_e[1].info.cashBalance+"")&&de(Ee,we),(!Pe||je&2)&&Fe!==(Fe=_e[1].info.bankBalance+"")&&de(ze,Fe),(!Pe||je&1)&&Xe!==(Xe=_e[0].radio_channel_label+"")&&de(ot,Xe),(!Pe||je&2)&&lt!==(lt=_e[1].info.radio+"")&&de(ct,lt),(!Pe||je&1)&&T!==(T=_e[0].phone_number_label+"")&&de(te,T),(!Pe||je&2)&&pe!==(pe=_e[1].info.phone+"")&&de(xe,pe),je&337){Ue=_e[6];let He;for(He=0;He<Ue.length;He+=1){const V=go(_e,Ue,He);Ae[He]?Ae[He].p(V,je):(Ae[He]=xo(V),Ae[He].c(),Ae[He].m(Me,null))}for(;He<Ae.length;He+=1)Ae[He].d(1);Ae.length=Ue.length}},i(_e){Pe||(fi(()=>{re||(re=ss(e,ls,{duration:400},!0)),re.run(1)}),Pe=!0)},o(_e){re||(re=ss(e,ls,{duration:400},!1)),re.run(0),Pe=!1},d(_e){_e&&F(e),Vt(ke,_e),Vt(Ae,_e),_e&&re&&re.end()}}}function yo(i){let e,t=i[14]+"",n,r,s;function a(){return i[9](i[14])}return{c(){e=N("p"),n=Z(t),L(e,"class","value")},m(o,l){O(o,e,l),S(e,n),r||(s=Oe(e,"click",a),r=!0)},p(o,l){i=o,l&2&&t!==(t=i[14]+"")&&de(n,t)},d(o){o&&F(e),r=!1,s()}}}function wo(i){let e,t=i[0][i[11].buttonName+"_btn"]+"",n,r,s;function a(){return i[10](i[11])}return{c(){e=N("button"),n=Z(t)},m(o,l){O(o,e,l),S(e,n),r||(s=Oe(e,"click",a),r=!0)},p(o,l){i=o,l&1&&t!==(t=i[0][i[11].buttonName+"_btn"]+"")&&de(n,t)},d(o){o&&F(e),r=!1,s()}}}function xo(i){let e=i[4].includes(i[11].panel),t,n=e&&wo(i);return{c(){n&&n.c(),t=Zt()},m(r,s){n&&n.m(r,s),O(r,t,s)},p(r,s){s&16&&(e=r[4].includes(r[11].panel)),e?n?n.p(r,s):(n=wo(r),n.c(),n.m(t.parentNode,t)):n&&(n.d(1),n=null)},d(r){n&&n.d(r),r&&F(t)}}}function fp(i){let e,t,n,r,s,a=i[1].id+"",o,l,c=i[1].name+"",u,f,d,p,m,h,_,g,v;const b=[up,cp],y=[];function w(E,x){return E[3]?0:1}d=w(i),p=y[d]=b[d](i);let M=i[5]&&vo(i);return{c(){e=N("div"),t=N("div"),n=N("div"),r=N("p"),s=Z("("),o=Z(a),l=Z(") "),u=Z(c),f=Y(),p.c(),h=Y(),M&&M.c(),L(r,"class","txt-sm font-medium title"),L(n,"class","player-panel-width panel-title-chevron"),L(t,"id","main-panel"),L(t,"class",m="closed-panel "+i[2])},m(E,x){O(E,e,x),S(e,t),S(t,n),S(n,r),S(r,s),S(r,o),S(r,l),S(r,u),S(n,f),y[d].m(n,null),S(e,h),M&&M.m(e,null),_=!0,g||(v=Oe(t,"click",i[7]),g=!0)},p(E,[x]){(!_||x&2)&&a!==(a=E[1].id+"")&&de(o,a),(!_||x&2)&&c!==(c=E[1].name+"")&&de(u,c);let C=d;d=w(E),d===C?y[d].p(E,x):(Ve(),I(y[C],1,1,()=>{y[C]=null}),Ge(),p=y[d],p?p.p(E,x):(p=y[d]=b[d](E),p.c()),k(p,1),p.m(n,null)),(!_||x&4&&m!==(m="closed-panel "+E[2]))&&L(t,"class",m),E[5]?M?(M.p(E,x),x&32&&k(M,1)):(M=vo(E),M.c(),k(M,1),M.m(e,null)):M&&(Ve(),I(M,1,1,()=>{M=null}),Ge())},i(E){_||(k(p),k(M),_=!0)},o(E){I(p),I(M),_=!1},d(E){E&&F(e),y[d].d(),M&&M.d(),g=!1,v()}}}function dp(i,e,t){let{localeConsts:n,panelData:r,bgColor:s,canOpenPanel:a=!1}=e,{showingPanels:o}=e,l=!1,c=[{buttonName:"teleport",panel:n.Teleport_to_Player},{buttonName:"bring",panel:n.Bring_Player},{buttonName:"spectate",panel:n.Spectate_Player},{buttonName:"freeze",panel:n.Freeze_Player},{buttonName:"send_back",panel:n.Bring_Player}];function u(){a&&t(5,l=!l)}async function f(m){const h={playerId:r.id,action:m};await Ne("playerListActions",h)}const d=m=>it.copyToClipboard(m),p=m=>f(m.buttonName);return i.$$set=m=>{"localeConsts"in m&&t(0,n=m.localeConsts),"panelData"in m&&t(1,r=m.panelData),"bgColor"in m&&t(2,s=m.bgColor),"canOpenPanel"in m&&t(3,a=m.canOpenPanel),"showingPanels"in m&&t(4,o=m.showingPanels)},[n,r,s,a,o,l,c,u,f,d,p]}class hp extends Ze{constructor(e){super(),Ye(this,e,dp,fp,qe,{localeConsts:0,panelData:1,bgColor:2,canOpenPanel:3,showingPanels:4})}}function Mo(i,e,t){const n=i.slice();return n[14]=e[t],n[16]=t,n}function So(i,e,t){const n=i.slice();return n[17]=e[t],n}function pp(i){let e,t,n,r,s,a,o=[],l=new Map,c,u=i[8],f=[];for(let m=0;m<u.length;m+=1)f[m]=Co(So(i,u,m));n=new hs({props:{placeholder:i[0].player_placeholder}}),n.$on("search-value-update",i[12]);let d=i[5];const p=m=>m[14].id;for(let m=0;m<d.length;m+=1){let h=Mo(i,d,m),_=p(h);l.set(_,o[m]=To(_,h))}return{c(){e=N("div");for(let m=0;m<f.length;m+=1)f[m].c();t=Y(),Q(n.$$.fragment),r=Y(),s=N("div"),a=N("div");for(let m=0;m<o.length;m+=1)o[m].c();L(e,"class","players-horizontal-tab"),L(a,"class","nav-body"),L(s,"class","item-rows")},m(m,h){O(m,e,h);for(let _=0;_<f.length;_+=1)f[_].m(e,null);O(m,t,h),K(n,m,h),O(m,r,h),O(m,s,h),S(s,a);for(let _=0;_<o.length;_+=1)o[_].m(a,null);c=!0},p(m,h){if(h&1349){u=m[8];let g;for(g=0;g<u.length;g+=1){const v=So(m,u,g);f[g]?f[g].p(v,h):(f[g]=Co(v),f[g].c(),f[g].m(e,null))}for(;g<f.length;g+=1)f[g].d(1);f.length=u.length}const _={};if(h&1&&(_.placeholder=m[0].player_placeholder),n.$set(_),h&39){d=m[5],Ve();for(let g=0;g<o.length;g+=1)o[g].r();o=xr(o,h,p,1,m,d,l,a,ds,To,null,Mo);for(let g=0;g<o.length;g+=1)o[g].a();Ge()}},i(m){if(!c){k(n.$$.fragment,m);for(let h=0;h<d.length;h+=1)k(o[h]);c=!0}},o(m){I(n.$$.fragment,m);for(let h=0;h<o.length;h+=1)I(o[h]);c=!1},d(m){m&&F(e),Vt(f,m),m&&F(t),J(n,m),m&&F(r),m&&F(s);for(let h=0;h<o.length;h+=1)o[h].d()}}}function mp(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function _p(i){let e,t=i[6].online.length+"",n,r;return{c(){e=Z("("),n=Z(t),r=Z(")")},m(s,a){O(s,e,a),O(s,n,a),O(s,r,a)},p(s,a){a&64&&t!==(t=s[6].online.length+"")&&de(n,t)},d(s){s&&F(e),s&&F(n),s&&F(r)}}}function Co(i){let e,t=it.upperCaseFirstLetter(i[0][i[17]+"_tab_name"])+"",n,r,s,a,o,l,c=i[17]==="online"&&_p(i);function u(){return i[11](i[17])}return{c(){e=N("button"),n=Z(t),r=Y(),c&&c.c(),s=Y(),L(e,"id",i[17]),L(e,"class",a="tablinks "+(i[2]===i[17]?"active-horizontal-tab-link":""))},m(f,d){O(f,e,d),S(e,n),S(e,r),c&&c.m(e,null),S(e,s),o||(l=Oe(e,"click",u),o=!0)},p(f,d){i=f,d&1&&t!==(t=it.upperCaseFirstLetter(i[0][i[17]+"_tab_name"])+"")&&de(n,t),i[17]==="online"&&c.p(i,d),d&4&&a!==(a="tablinks "+(i[2]===i[17]?"active-horizontal-tab-link":""))&&L(e,"class",a)},d(f){f&&F(e),c&&c.d(),o=!1,l()}}}function To(i,e){let t,n,r,s,a=ge,o;return n=new hp({props:{localeConsts:e[0],showingPanels:e[1],panelData:e[14],bgColor:e[14].isAdmin?"admin-player-resource-bg":"even-pane-panel-bg",canOpenPanel:e[2]==="online"}}),{key:i,first:null,c(){t=N("div"),Q(n.$$.fragment),r=Y(),this.first=t},m(l,c){O(l,t,c),K(n,t,null),S(t,r),o=!0},p(l,c){e=l;const u={};c&1&&(u.localeConsts=e[0]),c&2&&(u.showingPanels=e[1]),c&32&&(u.panelData=e[14]),c&32&&(u.bgColor=e[14].isAdmin?"admin-player-resource-bg":"even-pane-panel-bg"),c&4&&(u.canOpenPanel=e[2]==="online"),n.$set(u)},r(){s=t.getBoundingClientRect()},f(){wr(t),a()},a(){a(),a=yr(t,s,Mr,{duration:400})},i(l){o||(k(n.$$.fragment,l),o=!0)},o(l){I(n.$$.fragment,l),o=!1},d(l){l&&F(t),J(n)}}}function gp(i){let e,t,n=i[0].players_page_heading+"",r,s,a,o,l,c;const u=[mp,pp],f=[];function d(p,m){return p[3]?0:1}return o=d(i),l=f[o]=u[o](i),{c(){e=N("div"),t=N("div"),r=Z(n),s=Y(),a=N("div"),l.c(),L(t,"class","heading"),L(a,"class","body-wrapper"),L(e,"class","main-body")},m(p,m){O(p,e,m),S(e,t),S(t,r),S(e,s),S(e,a),f[o].m(a,null),c=!0},p(p,[m]){(!c||m&1)&&n!==(n=p[0].players_page_heading+"")&&de(r,n);let h=o;o=d(p),o===h?f[o].p(p,m):(Ve(),I(f[h],1,1,()=>{f[h]=null}),Ge(),l=f[o],l?l.p(p,m):(l=f[o]=u[o](p),l.c()),k(l,1),l.m(a,null))},i(p){c||(k(l),c=!0)},o(p){I(l),c=!1},d(p){p&&F(e),f[o].d()}}}function bp(i,e,t){let n,{localeConsts:r}=e,{showingPanels:s}=e,{isDev:a}=vt;ft(i,a,g=>t(13,n=g));let o="online",l=["online","offline"],c=!1,u="",f=[],d={online:[],offline:[]};at(async()=>{t(3,c=!0);let g={};n?g={onlinePlayers:[{id:2,name:"Sakshi",licenses:["Driving","Cooking"]},{id:1,name:"Pushkar",licenses:["Driving","Chutyap"]}],offlinePlayers:[{id:3,name:"Shruti",timeOfDisconnect:1670784600},{id:4,name:"Vaishnavi",timeOfDisconnect:1670784600}]}:g=await Ne("getPlayerDataForList"),t(6,d.online=g.onlinePlayers,d),t(6,d.offline=it.changeTimeBasedOnTimeZone(g.offlinePlayers,"timeOfDisconnect"),d),p(),t(3,c=!1)});function p(){t(5,f=it.filterAndSort(d[o],"name",u,"num","id","asc"))}function m(g){t(2,o=g),p()}const h=g=>m(g),_=g=>{t(4,u=g.detail),p()};return i.$$set=g=>{"localeConsts"in g&&t(0,r=g.localeConsts),"showingPanels"in g&&t(1,s=g.showingPanels)},[r,s,o,c,u,f,d,a,l,p,m,h,_]}class vp extends Ze{constructor(e){super(),Ye(this,e,bp,gp,qe,{localeConsts:0,showingPanels:1})}}function yp(i){let e,t,n,r,s,a,o,l;return t=new It({props:{icon:hf,class:"txt-xs stop"}}),s=new It({props:{icon:ju,class:"txt-xs replay"}}),{c(){e=N("div"),Q(t.$$.fragment),n=Y(),r=N("div"),Q(s.$$.fragment)},m(c,u){O(c,e,u),K(t,e,null),O(c,n,u),O(c,r,u),K(s,r,null),a=!0,o||(l=[Oe(e,"click",i[4]),Oe(r,"click",i[5])],o=!0)},p:ge,i(c){a||(k(t.$$.fragment,c),k(s.$$.fragment,c),a=!0)},o(c){I(t.$$.fragment,c),I(s.$$.fragment,c),a=!1},d(c){c&&F(e),J(t),c&&F(n),c&&F(r),J(s),o=!1,wt(l)}}}function wp(i){let e,t,n,r,s;return t=new It({props:{icon:uf,class:"txt-xs start"}}),{c(){e=N("div"),Q(t.$$.fragment)},m(a,o){O(a,e,o),K(t,e,null),n=!0,r||(s=Oe(e,"click",i[3]),r=!0)},p:ge,i(a){n||(k(t.$$.fragment,a),n=!0)},o(a){I(t.$$.fragment,a),n=!1},d(a){a&&F(e),J(t),r=!1,s()}}}function xp(i){let e,t,n,r,s,a=i[0].name+"",o,l,c,u,f,d,p;const m=[wp,yp],h=[];function _(g,v){return g[0].state===0?0:1}return u=_(i),f=h[u]=m[u](i),{c(){e=N("div"),t=N("div"),n=N("div"),r=N("div"),s=N("p"),o=Z(a),l=Y(),c=N("div"),f.c(),L(s,"class","txt-sm font-medium title"),L(r,"class","resource-name"),L(c,"class","resource_button_icons"),L(n,"class","player-panel-width panel-title-chevron"),L(t,"id","main-panel"),L(t,"class",d="closed-panel "+i[1])},m(g,v){O(g,e,v),S(e,t),S(t,n),S(n,r),S(r,s),S(s,o),S(n,l),S(n,c),h[u].m(c,null),p=!0},p(g,[v]){(!p||v&1)&&a!==(a=g[0].name+"")&&de(o,a);let b=u;u=_(g),u===b?h[u].p(g,v):(Ve(),I(h[b],1,1,()=>{h[b]=null}),Ge(),f=h[u],f?f.p(g,v):(f=h[u]=m[u](g),f.c()),k(f,1),f.m(c,null)),(!p||v&2&&d!==(d="closed-panel "+g[1]))&&L(t,"class",d)},i(g){p||(k(f),p=!0)},o(g){I(f),p=!1},d(g){g&&F(e),h[u].d()}}}function Mp(i,e,t){const n=ln();let{panelData:r,bgColor:s}=e;function a(u){n("perform-resource-action",{panelData:r,action:u})}const o=()=>a("start"),l=()=>a("stop"),c=()=>a("restart");return i.$$set=u=>{"panelData"in u&&t(0,r=u.panelData),"bgColor"in u&&t(1,s=u.bgColor)},[r,s,a,o,l,c]}class Sp extends Ze{constructor(e){super(),Ye(this,e,Mp,xp,qe,{panelData:0,bgColor:1})}}function Eo(i,e,t){const n=i.slice();return n[15]=e[t],n[17]=t,n}function Lo(i,e,t){const n=i.slice();return n[18]=e[t],n}function Cp(i){let e,t,n,r,s,a,o=[],l=new Map,c,u=i[6],f=[];for(let m=0;m<u.length;m+=1)f[m]=Po(Lo(i,u,m));n=new hs({props:{placeholder:i[0].resources_search_placeholder}}),n.$on("search-value-update",i[11]);let d=i[3];const p=m=>m[15].id;for(let m=0;m<d.length;m+=1){let h=Eo(i,d,m),_=p(h);l.set(_,o[m]=Ao(_,h))}return{c(){e=N("div");for(let m=0;m<f.length;m+=1)f[m].c();t=Y(),Q(n.$$.fragment),r=Y(),s=N("div"),a=N("div");for(let m=0;m<o.length;m+=1)o[m].c();L(e,"class","players-horizontal-tab"),L(a,"class","nav-body"),L(s,"class","item-rows")},m(m,h){O(m,e,h);for(let _=0;_<f.length;_+=1)f[_].m(e,null);O(m,t,h),K(n,m,h),O(m,r,h),O(m,s,h),S(s,a);for(let _=0;_<o.length;_+=1)o[_].m(a,null);c=!0},p(m,h){if(h&209){u=m[6];let g;for(g=0;g<u.length;g+=1){const v=Lo(m,u,g);f[g]?f[g].p(v,h):(f[g]=Po(v),f[g].c(),f[g].m(e,null))}for(;g<f.length;g+=1)f[g].d(1);f.length=u.length}const _={};if(h&1&&(_.placeholder=m[0].resources_search_placeholder),n.$set(_),h&520){d=m[3],Ve();for(let g=0;g<o.length;g+=1)o[g].r();o=xr(o,h,p,1,m,d,l,a,ds,Ao,null,Eo);for(let g=0;g<o.length;g+=1)o[g].a();Ge()}},i(m){if(!c){k(n.$$.fragment,m);for(let h=0;h<d.length;h+=1)k(o[h]);c=!0}},o(m){I(n.$$.fragment,m);for(let h=0;h<o.length;h+=1)I(o[h]);c=!1},d(m){m&&F(e),Vt(f,m),m&&F(t),J(n,m),m&&F(r),m&&F(s);for(let h=0;h<o.length;h+=1)o[h].d()}}}function Tp(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Po(i){let e,t=it.upperCaseFirstLetter(i[0]["resources_"+i[18]+"_tab_name"])+"",n,r,s,a,o;function l(){return i[10](i[18])}return{c(){e=N("button"),n=Z(t),r=Y(),L(e,"id",i[18]),L(e,"class",s="tablinks "+(i[4]===i[18]?"active-horizontal-tab-link":""))},m(c,u){O(c,e,u),S(e,n),S(e,r),a||(o=Oe(e,"click",l),a=!0)},p(c,u){i=c,u&1&&t!==(t=it.upperCaseFirstLetter(i[0]["resources_"+i[18]+"_tab_name"])+"")&&de(n,t),u&16&&s!==(s="tablinks "+(i[4]===i[18]?"active-horizontal-tab-link":""))&&L(e,"class",s)},d(c){c&&F(e),a=!1,o()}}}function Ao(i,e){let t,n,r,s,a=ge,o;return n=new Sp({props:{panelData:e[15],bgColor:"odd-pane-panel"}}),n.$on("perform-resource-action",e[9]),{key:i,first:null,c(){t=N("div"),Q(n.$$.fragment),r=Y(),this.first=t},m(l,c){O(l,t,c),K(n,t,null),S(t,r),o=!0},p(l,c){e=l;const u={};c&8&&(u.panelData=e[15]),n.$set(u)},r(){s=t.getBoundingClientRect()},f(){wr(t),a()},a(){a(),a=yr(t,s,Mr,{duration:400})},i(l){o||(k(n.$$.fragment,l),o=!0)},o(l){I(n.$$.fragment,l),o=!1},d(l){l&&F(t),J(n)}}}function Ep(i){let e,t,n=i[0].resources_page_heading+"",r,s,a,o,l,c;const u=[Tp,Cp],f=[];function d(p,m){return p[1]?0:1}return o=d(i),l=f[o]=u[o](i),{c(){e=N("div"),t=N("div"),r=Z(n),s=Y(),a=N("div"),l.c(),L(t,"class","heading"),L(a,"class","body-wrapper"),L(e,"class","main-body")},m(p,m){O(p,e,m),S(e,t),S(t,r),S(e,s),S(e,a),f[o].m(a,null),c=!0},p(p,[m]){(!c||m&1)&&n!==(n=p[0].resources_page_heading+"")&&de(r,n);let h=o;o=d(p),o===h?f[o].p(p,m):(Ve(),I(f[h],1,1,()=>{f[h]=null}),Ge(),l=f[o],l?l.p(p,m):(l=f[o]=u[o](p),l.c()),k(l,1),l.m(a,null))},i(p){c||(k(l),c=!0)},o(p){I(l),c=!1},d(p){p&&F(e),f[o].d()}}}function Lp(i,e,t){let n,{localeConsts:r}=e,{isDev:s}=vt;ft(i,s,v=>t(13,n=v));let a=!1,o="",l=[],c=["active","inactive"],u="active",f={active:[],inactive:[]};at(async()=>{t(1,a=!0),await d(),t(1,a=!1)});async function d(){let v={};n?v={resources:[{id:1,name:"Resource XYZ",state:0},{id:2,name:"Resource DEF",state:1}]}:v=await Ne("getResourceList"),f.active=v.resources.filter(b=>b.state===1),f.inactive=v.resources.filter(b=>b.state===0),m()}function p(v){t(4,u=v),m()}function m(){t(3,l=it.filterAndSort(f[u],"name",o,"alpha","name"))}async function h(v){let b=v.detail.action,y=v.detail.panelData;t(1,a=!0);const w=b==="start"?"startResource":b==="stop"?"stopResource":"restartResource",M={name:y.name};let E="";n?E="ok":E=await Ne(w,M),E==="ok"&&await d(),t(1,a=!1)}const _=v=>p(v),g=v=>{t(2,o=v.detail),m()};return i.$$set=v=>{"localeConsts"in v&&t(0,r=v.localeConsts)},[r,a,o,l,u,s,c,p,m,h,_,g]}class Pp extends Ze{constructor(e){super(),Ye(this,e,Lp,Ep,qe,{localeConsts:0})}}function Ap(i){let e,t,n,r,s=i[1][i[0].localConstKey]+"",a,o,l,c,u;return t=new It({props:{icon:i[0].icon,class:"txt-md "+i[2]}}),{c(){e=N("div"),Q(t.$$.fragment),n=Y(),r=N("span"),a=Z(s),L(r,"id",o=i[0].id),L(r,"class","tool-tip-text-top"),L(e,"class","inner-icon")},m(f,d){O(f,e,d),K(t,e,null),S(e,n),S(e,r),S(r,a),l=!0,c||(u=[Oe(e,"click",i[4]),Oe(e,"mouseenter",i[5]),Oe(e,"mouseleave",i[6])],c=!0)},p(f,[d]){const p={};d&1&&(p.icon=f[0].icon),d&4&&(p.class="txt-md "+f[2]),t.$set(p),(!l||d&3)&&s!==(s=f[1][f[0].localConstKey]+"")&&de(a,s),(!l||d&1&&o!==(o=f[0].id))&&L(r,"id",o)},i(f){l||(k(t.$$.fragment,f),l=!0)},o(f){I(t.$$.fragment,f),l=!1},d(f){f&&F(e),J(t),c=!1,wt(u)}}}function Dp(i,e,t){const n=ln();let{menuItem:r,localeConsts:s,extraClassNames:a=""}=e;function o(f){n("showSideBarPage",f)}const l=()=>{o(r.showPageKey)},c=()=>it.toggleToolTip(r.id),u=()=>it.toggleToolTip(r.id);return i.$$set=f=>{"menuItem"in f&&t(0,r=f.menuItem),"localeConsts"in f&&t(1,s=f.localeConsts),"extraClassNames"in f&&t(2,a=f.extraClassNames)},[r,s,a,o,l,c,u]}class va extends Ze{constructor(e){super(),Ye(this,e,Dp,Ap,qe,{menuItem:0,localeConsts:1,extraClassNames:2})}}function Do(i,e,t){const n=i.slice();return n[46]=e[t],n[48]=t,n}function Ro(i,e,t){const n=i.slice();return n[49]=e[t],n}function ko(i,e,t){const n=i.slice();return n[52]=e[t],n}function Io(i,e,t){const n=i.slice();return n[55]=e[t],n}function No(i,e,t){const n=i.slice();return n[58]=e[t],n}function Rp(i){let e,t,n,r,s,a,o,l,c=i[27],u=[];for(let g=0;g<c.length;g+=1)u[g]=zo(No(i,c,g));const f=g=>I(u[g],1,1,()=>{u[g]=null});let d=i[7]&&Fo(i),p=i[11]&&Uo(i);const m=[Bp,Up,Op,Fp,zp,Np,Ip],h=[];function _(g,v){return g[9].showGodModeAdminPage?0:g[9].showThemePage?1:g[9].showChat?2:g[9].showReportsPage?3:g[9].showPlayersPage?4:g[9].showResourcesPage?5:!g[9].showGodModeAdminPage&&!g[9].showThemePage&&!g[9].showChat&&!g[9].showPlayersPage&&!g[9].showResourcesPage?6:-1}return~(a=_(i))&&(o=h[a]=m[a](i)),{c(){e=N("div");for(let g=0;g<u.length;g+=1)u[g].c();t=Y(),d&&d.c(),n=Y(),p&&p.c(),r=Y(),s=N("div"),o&&o.c(),L(e,"class","vertical-menu"),L(s,"id","inner_div_id"),L(s,"class","inner bg-dark-900/50")},m(g,v){O(g,e,v);for(let b=0;b<u.length;b+=1)u[b].m(e,null);S(e,t),d&&d.m(e,null),S(e,n),p&&p.m(e,null),O(g,r,v),O(g,s,v),~a&&h[a].m(s,null),l=!0},p(g,v){if(v[0]&168296448){c=g[27];let y;for(y=0;y<c.length;y+=1){const w=No(g,c,y);u[y]?(u[y].p(w,v),k(u[y],1)):(u[y]=zo(w),u[y].c(),k(u[y],1),u[y].m(e,t))}for(Ve(),y=c.length;y<u.length;y+=1)f(y);Ge()}g[7]?d?(d.p(g,v),v[0]&128&&k(d,1)):(d=Fo(g),d.c(),k(d,1),d.m(e,n)):d&&(Ve(),I(d,1,1,()=>{d=null}),Ge()),g[11]?p?(p.p(g,v),v[0]&2048&&k(p,1)):(p=Uo(g),p.c(),k(p,1),p.m(e,null)):p&&(Ve(),I(p,1,1,()=>{p=null}),Ge());let b=a;a=_(g),a===b?~a&&h[a].p(g,v):(o&&(Ve(),I(h[b],1,1,()=>{h[b]=null}),Ge()),~a?(o=h[a],o?o.p(g,v):(o=h[a]=m[a](g),o.c()),k(o,1),o.m(s,null)):o=null)},i(g){if(!l){for(let v=0;v<c.length;v+=1)k(u[v]);k(d),k(p),k(o),l=!0}},o(g){u=u.filter(Boolean);for(let v=0;v<u.length;v+=1)I(u[v]);I(d),I(p),I(o),l=!1},d(g){g&&F(e),Vt(u,g),d&&d.d(),p&&p.d(),g&&F(r),g&&F(s),~a&&h[a].d()}}}function kp(i){let e,t;return e=new dt({props:{marginLeft:"45%"}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function zo(i){let e,t;return e=new va({props:{menuItem:i[58],localeConsts:i[19]}}),e.$on("showSideBarPage",i[31]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Fo(i){let e,t,n=i[28],r=[];for(let a=0;a<n.length;a+=1)r[a]=Oo(Io(i,n,a));const s=a=>I(r[a],1,1,()=>{r[a]=null});return{c(){for(let a=0;a<r.length;a+=1)r[a].c();e=Zt()},m(a,o){for(let l=0;l<r.length;l+=1)r[l].m(a,o);O(a,e,o),t=!0},p(a,o){if(o[0]&302514176){n=a[28];let l;for(l=0;l<n.length;l+=1){const c=Io(a,n,l);r[l]?(r[l].p(c,o),k(r[l],1)):(r[l]=Oo(c),r[l].c(),k(r[l],1),r[l].m(e.parentNode,e))}for(Ve(),l=n.length;l<r.length;l+=1)s(l);Ge()}},i(a){if(!t){for(let o=0;o<n.length;o+=1)k(r[o]);t=!0}},o(a){r=r.filter(Boolean);for(let o=0;o<r.length;o+=1)I(r[o]);t=!1},d(a){Vt(r,a),a&&F(e)}}}function Oo(i){let e,t;return e=new va({props:{menuItem:i[55],localeConsts:i[19]}}),e.$on("showSideBarPage",i[32]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Uo(i){let e,t,n=i[29],r=[];for(let a=0;a<n.length;a+=1)r[a]=Bo(ko(i,n,a));const s=a=>I(r[a],1,1,()=>{r[a]=null});return{c(){for(let a=0;a<r.length;a+=1)r[a].c();e=Zt()},m(a,o){for(let l=0;l<r.length;l+=1)r[l].m(a,o);O(a,e,o),t=!0},p(a,o){if(o[0]&570961920){n=a[29];let l;for(l=0;l<n.length;l+=1){const c=ko(a,n,l);r[l]?(r[l].p(c,o),k(r[l],1)):(r[l]=Bo(c),r[l].c(),k(r[l],1),r[l].m(e.parentNode,e))}for(Ve(),l=n.length;l<r.length;l+=1)s(l);Ge()}},i(a){if(!t){for(let o=0;o<n.length;o+=1)k(r[o]);t=!0}},o(a){r=r.filter(Boolean);for(let o=0;o<r.length;o+=1)I(r[o]);t=!1},d(a){Vt(r,a),a&&F(e)}}}function Bo(i){let e,t;return e=new va({props:{menuItem:i[52],localeConsts:i[19],extraClassNames:i[52].id==="debug-id"&&i[13]||i[52].id==="dev-mode-id"&&i[12]?"clicked-icon":""}}),e.$on("showSideBarPage",i[33]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r[0]&12288&&(s.extraClassNames=n[52].id==="debug-id"&&n[13]||n[52].id==="dev-mode-id"&&n[12]?"clicked-icon":""),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Ip(i){let e,t,n,r,s,a,o=[],l=new Map,c,u=i[30],f=[];for(let m=0;m<u.length;m+=1)f[m]=Vo(Ro(i,u,m));n=new hs({props:{placeholder:i[19].search_placeholder}}),n.$on("search-value-update",i[35]);let d=i[5];const p=m=>m[46].id;for(let m=0;m<d.length;m+=1){let h=Do(i,d,m),_=p(h);l.set(_,o[m]=Go(_,h))}return{c(){e=N("div");for(let m=0;m<f.length;m+=1)f[m].c();t=Y(),Q(n.$$.fragment),r=Y(),s=N("div"),a=N("div");for(let m=0;m<o.length;m+=1)o[m].c();L(e,"class","horizontal-tab"),L(a,"class","nav-body"),L(s,"class","item-rows")},m(m,h){O(m,e,h);for(let _=0;_<f.length;_+=1)f[_].m(e,null);O(m,t,h),K(n,m,h),O(m,r,h),O(m,s,h),S(s,a);for(let _=0;_<o.length;_+=1)o[_].m(a,null);c=!0},p(m,h){if(h[0]&1076363280){u=m[30];let _;for(_=0;_<u.length;_+=1){const g=Ro(m,u,_);f[_]?f[_].p(g,h):(f[_]=Vo(g),f[_].c(),f[_].m(e,null))}for(;_<f.length;_+=1)f[_].d(1);f.length=u.length}if(h[0]&25166880){d=m[5],Ve();for(let _=0;_<o.length;_+=1)o[_].r();o=xr(o,h,p,1,m,d,l,a,ds,Go,null,Do);for(let _=0;_<o.length;_+=1)o[_].a();Ge()}},i(m){if(!c){k(n.$$.fragment,m);for(let h=0;h<d.length;h+=1)k(o[h]);c=!0}},o(m){I(n.$$.fragment,m);for(let h=0;h<o.length;h+=1)I(o[h]);c=!1},d(m){m&&F(e),Vt(f,m),m&&F(t),J(n,m),m&&F(r),m&&F(s);for(let h=0;h<o.length;h+=1)o[h].d()}}}function Np(i){let e,t;return e=new Pp({props:{localeConsts:i[19]}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function zp(i){let e,t;return e=new vp({props:{localeConsts:i[19],showingPanels:i[8]}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r[0]&256&&(s.showingPanels=n[8]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Fp(i){let e,t;return e=new lp({props:{localeConsts:i[19]}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Op(i){let e,t;return e=new Wh({props:{localeConsts:i[19]}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Up(i){let e,t;return e=new Ch({props:{localeConsts:i[19]}}),e.$on("theme-changed",i[26]),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Bp(i){let e,t;return e=new Oh({props:{panels:i[14],localeConsts:i[19]}}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p(n,r){const s={};r[0]&16384&&(s.panels=n[14]),e.$set(s)},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Vo(i){let e,t=it.upperCaseFirstLetter(i[19][i[49]+"_tab"])+"",n,r,s,a;function o(){return i[34](i[49])}return{c(){e=N("button"),n=Z(t),L(e,"id",i[49]),L(e,"class",r="tablinks "+(i[4]===i[49]?"active-horizontal-tab-link":""))},m(l,c){O(l,e,c),S(e,n),s||(a=Oe(e,"click",o),s=!0)},p(l,c){i=l,c[0]&16&&r!==(r="tablinks "+(i[4]===i[49]?"active-horizontal-tab-link":""))&&L(e,"class",r)},d(l){l&&F(e),s=!1,a()}}}function Go(i,e){let t,n,r,s,a=ge,o;return n=new xh({props:{panelData:e[46],bgColor:e[10].includes(e[46].title)?"clicked-pane-non-panel":e[48]%2!==0?"odd-pane-panel":"even-pane-panel-bg"}}),n.$on("star",e[23]),n.$on("panelClicked",e[24]),{key:i,first:null,c(){t=N("div"),Q(n.$$.fragment),r=Y(),this.first=t},m(l,c){O(l,t,c),K(n,t,null),S(t,r),o=!0},p(l,c){e=l;const u={};c[0]&32&&(u.panelData=e[46]),c[0]&1056&&(u.bgColor=e[10].includes(e[46].title)?"clicked-pane-non-panel":e[48]%2!==0?"odd-pane-panel":"even-pane-panel-bg"),n.$set(u)},r(){s=t.getBoundingClientRect()},f(){wr(t),a()},a(){a(),a=yr(t,s,Mr,{duration:400})},i(l){o||(k(n.$$.fragment,l),o=!0)},o(l){I(n.$$.fragment,l),o=!1},d(l){l&&F(t),J(n)}}}function Vp(i){let e,t,n,r,s,a,o,l,c,u;n=new It({props:{icon:i[3]?Fa:za,size:"sm",color:"white",style:"margin-top:0.6vw;margin-left:0.45vw;"}});const f=[kp,Rp],d=[];function p(m,h){return m[2]?0:1}return a=p(i),o=d[a]=f[a](i),{c(){e=N("div"),t=N("div"),Q(n.$$.fragment),r=Y(),s=N("div"),o.c(),L(t,"id","expander"),L(t,"class","inline-block expander bg-gray-400 hover:bg-gray-600"),Bn(t,"margin-left",i[0]-1.5+"vw"),Bn(t,"margin-top",i[1]+"vw"),L(s,"id","menu_base_id"),L(s,"class","inline-block menu-base"),Bn(s,"margin-left",i[0]+"vw"),Bn(s,"margin-top",i[1]+"vw"),L(e,"class","block"),L(e,"data-theme",i[15])},m(m,h){O(m,e,h),S(e,t),K(n,t,null),S(e,r),S(e,s),d[a].m(s,null),l=!0,c||(u=Oe(t,"click",i[20]),c=!0)},p(m,h){const _={};h[0]&8&&(_.icon=m[3]?Fa:za),n.$set(_),(!l||h[0]&1)&&Bn(t,"margin-left",m[0]-1.5+"vw"),(!l||h[0]&2)&&Bn(t,"margin-top",m[1]+"vw");let g=a;a=p(m),a===g?d[a].p(m,h):(Ve(),I(d[g],1,1,()=>{d[g]=null}),Ge(),o=d[a],o?o.p(m,h):(o=d[a]=f[a](m),o.c()),k(o,1),o.m(s,null)),(!l||h[0]&1)&&Bn(s,"margin-left",m[0]+"vw"),(!l||h[0]&2)&&Bn(s,"margin-top",m[1]+"vw"),(!l||h[0]&32768)&&L(e,"data-theme",m[15])},i(m){l||(k(n.$$.fragment,m),k(o),l=!0)},o(m){I(n.$$.fragment,m),I(o),l=!1},d(m){m&&F(e),J(n),d[a].d(),c=!1,u()}}}function Gp(i,e,t){let n,r,s,{left:a=70}=e,{top:o=5}=e,{locales:l,data:c,isDev:u}=vt;ft(i,l,oe=>t(40,s=oe)),ft(i,c,oe=>t(38,n=oe)),ft(i,u,oe=>t(39,r=oe));let f=s,d=!1,p=!1,m="all",h=[],_="",g=!1,v=[],b={showGodModeAdminPage:!1,showThemePage:!1,showChat:!1,showReportsPage:!1,showPlayersPage:!1,showResourcesPage:!1},y=[],w=!0,M=!1,E=!1,x=!1,C=[f.Max_Mod_Vehicle,f.Fix_Vehicle,f.Teleport_Marker,f.Remove_Stress,f.Revive_In_Radius,f.Bennys,f.Admin_Car,f.Refuel_Vehicle,f.Toggle_Duty,f.Give_Keys,f.Revive_All],A=[{id:1,title:f.Revive,hasPanel:!0,tabName:"player"},{id:2,title:f.NoClip,hasPanel:!1,tabName:"utility",cb:"noclip"},{id:3,title:f.Give_Item,hasPanel:!0,tabName:"player"},{id:4,title:f.Spawn_Car,hasPanel:!0,tabName:"utility"},{id:5,title:f.Fix_Vehicle,hasPanel:!1,tabName:"utility",cb:"fixvehicle"},{id:6,title:f.Clothes_Menu,hasPanel:!0,tabName:"player"},{id:7,title:f.Player_Info,hasPanel:!0,tabName:"player"},{id:8,title:f.Announce,hasPanel:!0,tabName:"utility"},{id:9,title:f.God_Mode,hasPanel:!1,tabName:"utility",cb:"godmode"},{id:10,title:f.Kick,hasPanel:!0,tabName:"player"},{id:11,title:f.Super_Jump,hasPanel:!1,tabName:"utility",cb:"superjump"},{id:12,title:f.Remove_Stress,hasPanel:!1,tabName:"utility",cb:"removestress"},{id:13,title:f.Teleport_Coords,hasPanel:!0,tabName:"utility"},{id:14,title:f.Teleport_Marker,hasPanel:!1,tabName:"utility",cb:"teleportmarker"},{id:15,title:f.Teleport_to_Player,hasPanel:!0,tabName:"player"},{id:16,title:f.Invisible,hasPanel:!1,tabName:"utility",cb:"invisible"},{id:17,title:f.Give_Money,hasPanel:!0,tabName:"player"},{id:18,title:f.Give_Car,hasPanel:!0,tabName:"player"},{id:19,title:f.Open_Inventory,hasPanel:!0,tabName:"player"},{id:20,title:f.Freeze_Player,hasPanel:!0,tabName:"player"},{id:21,title:f.Change_Plate,hasPanel:!0,tabName:"utility"},{id:22,title:f.Spawn_Objects,hasPanel:!0,tabName:"utility"},{id:23,title:f.Create_Job_Stashes,hasPanel:!0,tabName:"utility"},{id:24,title:f.Give_Job,hasPanel:!0,tabName:"player"},{id:25,title:f.Copy_Coordinates,hasPanel:!0,tabName:"utility"},{id:26,title:f.Toggle_Blips,hasPanel:!1,tabName:"utility",cb:"toggleBlips"},{id:27,title:f.Ban_Player,hasPanel:!0,tabName:"player"},{id:28,title:f.Show_Coordinates,hasPanel:!1,tabName:"utility",cb:"showCoords"},{id:29,title:f.Clear_Inventory,hasPanel:!0,tabName:"player"},{id:30,title:f.Bring_Player,hasPanel:!0,tabName:"player"},{id:31,title:f.Clear_Area_Vehicles,hasPanel:!0,tabName:"utility"},{id:32,title:f.Change_Weather,hasPanel:!0,tabName:"utility"},{id:33,title:f.Change_Time,hasPanel:!0,tabName:"utility"},{id:34,title:f.Create_Gang_Stashes,hasPanel:!0,tabName:"utility"},{id:35,title:f.Spectate_Player,hasPanel:!0,tabName:"player"},{id:36,title:f.Saved_Locations,hasPanel:!0,tabName:"utility"},{id:37,title:f.Revive_In_Radius,hasPanel:!1,tabName:"utility",cb:"reviveRadius"},{id:38,title:f.Show_Props,hasPanel:!0,tabName:"utility"},{id:39,title:f.Toggle_Names,hasPanel:!1,tabName:"utility",cb:"toggleNames"},{id:40,title:f.Bennys,hasPanel:!1,tabName:"utility",cb:"toggleBennys"},{id:41,title:f.Admin_Car,hasPanel:!1,tabName:"utility",cb:"addAdminCar"},{id:42,title:f.Refuel_Vehicle,hasPanel:!1,tabName:"utility",cb:"refuelVehicle"},{id:43,title:f.Toggle_Duty,hasPanel:!1,tabName:"player",cb:"toggleDuty"},{id:44,title:f.Open_Stash,hasPanel:!0,tabName:"player"},{id:45,title:f.Open_Trunk,hasPanel:!0,tabName:"player"},{id:46,title:f.Open_Glovebox,hasPanel:!0,tabName:"player"},{id:47,title:f.Unban_Player,hasPanel:!0,tabName:"player"},{id:48,title:f.Change_Ped_Model,hasPanel:!0,tabName:"player"},{id:49,title:f.Ban_Offline_Player,hasPanel:!0,tabName:"player"},{id:50,title:f.Warn,hasPanel:!0,tabName:"player"},{id:51,title:f.Give_Gang,hasPanel:!0,tabName:"player"},{id:52,title:f.Drunk_Player,hasPanel:!0,tabName:"troll"},{id:53,title:f.Set_Player_on_Fire,hasPanel:!0,tabName:"troll"},{id:54,title:f.Play_Sound_On_Player,hasPanel:!0,tabName:"troll"},{id:55,title:f.Slap_Player_In_Sky,hasPanel:!0,tabName:"troll"},{id:56,title:f.Send_Player_To_JailBox,hasPanel:!0,tabName:"troll"},{id:57,title:f.Give_Keys,hasPanel:!1,tabName:"utility",cb:"givekeys"},{id:58,title:f.Infinite_Ammo,hasPanel:!1,tabName:"utility",cb:"infiniteAmmo"},{id:59,title:f.Change_Vehicle_State,hasPanel:!0,tabName:"utility"},{id:60,title:f.Force_Logout_Player,hasPanel:!0,tabName:"utility"},{id:61,title:f.Give_Outfits,hasPanel:!0,tabName:"player"},{id:62,title:f.DM_Player,hasPanel:!0,tabName:"utility"},{id:63,title:f.Damage_Player_Vehicle,hasPanel:!0,tabName:"troll"},{id:64,title:f.NoClip_2,hasPanel:!1,tabName:"utility",cb:"noclip2"},{id:65,title:f.Admin_Tag,hasPanel:!1,tabName:"utility",cb:"admintag"},{id:66,title:f.Toggle_Minimap,hasPanel:!1,tabName:"utility",cb:"toggleminimap"},{id:67,title:f.Revive_All,hasPanel:!1,tabName:"player",cb:"reviveall"},{id:68,title:f.Clear_Area_Peds,hasPanel:!0,tabName:"utility"},{id:69,title:f.Clear_Area_Objects,hasPanel:!0,tabName:"utility"},{id:70,title:f.Heal,hasPanel:!0,tabName:"player"},{id:71,title:f.Wipe_Player,hasPanel:!0,tabName:"player"},{id:72,title:f.Max_Mod_Vehicle,hasPanel:!1,tabName:"utility",cb:"maxmodvehicle"},{id:73,title:f.Pee_Player,hasPanel:!0,tabName:"troll"},{id:74,title:f.Poop_Player,hasPanel:!0,tabName:"troll"}],D=localStorage.getItem("theme-chosen")?localStorage.getItem("theme-chosen"):"Original";at(async()=>{t(2,d=!0),t(15,D=localStorage.getItem("theme-chosen")?localStorage.getItem("theme-chosen"):"Original"),r&&cu(c,n={clickedPanels:["NoClip"],userRole:"God",isTerminal:"no",canSeeReports:"yes",isESX:!0,panelsToDisplay:["Announce","Admin Car"],customPanels:[{panelTitle:"Sakshi",submitUrl:"sakshi-submit",components:[{type:"string-input",placeholder:"",fetchDataUrl:"",label:"SakshiLabel",fillCompulsory:!0,keyName:"sakshi"},{type:"number-input",placeholder:"1",fetchDataUrl:"",label:"SakshiNumberLabel",fillCompulsory:!0,keyName:"sakshinumber"},{type:"regular-dropdown",placeholder:"",fetchDataUrl:"somethingfetchurl",label:"SakshiRegDdLabel",fillCompulsory:!0,keyName:"sakshiregdd"},{type:"checkbox-input",placeholder:"",fetchDataUrl:"",label:"SakshicheckboxLabel",fillCompulsory:!1,keyName:"sakshicheckbox"},{type:"searchable-dropdown",placeholder:"",fetchDataUrl:"searchableddfetch",label:"SakshisearchableDdLabel",fillCompulsory:!0,keyName:"sakshisearchdd"}]},{panelTitle:"Pushkar",submitUrl:"pushkar-submit",components:[]}]},n),G(n.customPanels),t(10,y=n.clickedPanels),t(11,w=n.userRole==="God"),n.userRole,t(12,M=n.isTerminal==="yes"),t(13,E=n.isDebug==="yes"),x=n.isESX===!0||n.isESX==="true",w&&(t(7,g=!0),t(8,v=A.map(oe=>oe.title))),U(),w||(t(8,v=n.panelsToDisplay),t(14,A=A.filter(oe=>{if(v.includes(oe.title))return oe})),v.includes(f.side_panel_player_list)&&t(7,g=!0)),t(14,A=A.filter(oe=>{if(oe.title!==f.side_panel_player_list)return oe})),ue(),t(2,d=!1)});function G(oe){let ye=Math.max(...A.map(Xe=>Xe.id)),Le=oe.map((Xe,ot)=>(Xe.components.length===0&&C.push(Xe.panelTitle),{id:ye+ot+1,title:Xe.panelTitle,hasPanel:Xe.components.length>0,tabName:"custom",cb:Xe.submitUrl,components:Xe.components}));t(14,A=A.concat(Le))}function U(){x&&t(14,A=A.filter(oe=>{if(oe.title!==f.Create_Gang_Stashes&&oe.title!==f.Give_Gang)return oe}))}function z(){const oe=document.getElementById("menu_base_id"),ye=document.getElementById("inner_div_id"),Le=document.getElementById("expander"),Xe=100*(innerWidth/2)/innerWidth;if(p)oe.style.width="23vw",oe.style.transitionDuration="0.2s",oe.style.transitionTimingFunction="linear",oe.style.transform="translate(0vw)",ye.style.width="20vw",Le.style.transitionDuration="0.2s",Le.style.transitionTimingFunction="linear",Le.style.transform="translate(0vw)";else{let ot=Xe-parseFloat(oe.style.marginLeft)-20;oe.style.width="40vw",oe.style.transitionDuration="0.2s",oe.style.transitionTimingFunction="linear",oe.style.transform=`translate(${ot}vw)`,ye.style.width="37vw",Le.style.transitionDuration="0.2s",Le.style.transitionTimingFunction="linear",Le.style.transform=`translate(${ot}vw)`}t(3,p=!p)}function X(oe){t(4,m=oe),ue()}function ae(oe){return it.booleanSort(oe,"isStarred","asc")}function le(){let oe=it.filterAndSort(A,"title",_,"alpha","title");t(5,h=ae(oe))}function $(oe){const ye=oe.detail.panelData,Le=h.indexOf(ye);t(5,h[Le]=ye,h);let Xe=h,ot=it.alphabeticalSort(Xe,"title");t(5,h=ae(ot)),ue()}async function ne(oe){const ye=oe.detail.panelData;if(C.includes(ye.title))await Ne(ye.cb);else{let Le=[];y.includes(ye.title)?Le=y.filter(ot=>ot!==ye.title):(Le=y,Le.push(ye.title)),t(10,y=Le),ue();const Xe={panelsClicked:y};await Ne(ye.cb,Xe)}}function ue(){if(m==="all"){A.forEach(ye=>{ye.isStarred=localStorage.getItem(ye.title)?localStorage.getItem(ye.title):"0"});let oe=it.alphabeticalSort(A,"title");t(5,h=ae(oe))}else if(m==="player"){let oe=A.filter(Le=>Le.tabName==="player"),ye=it.alphabeticalSort(oe,"title");t(5,h=ae(ye))}else if(m==="utility"){let oe=A.filter(Le=>Le.tabName==="utility"),ye=it.alphabeticalSort(oe,"title");t(5,h=ae(ye))}else if(m==="troll"){let oe=A.filter(Le=>Le.tabName==="troll"),ye=it.alphabeticalSort(oe,"title");t(5,h=ae(ye))}else if(m==="fav"){let oe=A.filter(Le=>Le.isStarred==="1"||Le.isStarred===1),ye=it.alphabeticalSort(oe,"title");t(5,h=ae(ye))}else if(m==="custom"){let oe=A.filter(Le=>Le.tabName==="custom"),ye=it.alphabeticalSort(oe,"title");t(5,h=ae(ye))}}async function be(oe){oe==="clickTerminal"?(t(12,M=!M),await Ne("toggleDev")):oe==="clickDebug"?(t(13,E=!E),await Ne("toggleDebug")):Object.keys(b).forEach(ye=>{ye===oe?t(9,b[ye]=!b[ye],b):t(9,b[ye]=!1,b)})}function q(){D!==localStorage.getItem("theme-chosen")&&t(15,D=localStorage.getItem("theme-chosen")?localStorage.getItem("theme-chosen"):"Original")}let ce=[{id:"theme-id",showPageKey:"showThemePage",icon:sf,localConstKey:"theme_tooltip"},{id:"chat-id",showPageKey:"showChat",icon:rf,localConstKey:"chat_tooltip"},{id:"reports-id",showPageKey:"showReportsPage",icon:ef,localConstKey:"report_tooltip"}],he=[{id:"players-id",showPageKey:"showPlayersPage",icon:of,localConstKey:"players_tooltip"}],W=[{id:"resources-id",showPageKey:"showResourcesPage",icon:$u,localConstKey:"resources_tooltip"},{id:"dev-mode-id",showPageKey:"clickTerminal",icon:pf,localConstKey:"dev_mode_tooltip"},{id:"debug-id",showPageKey:"clickDebug",icon:Zu,localConstKey:"debug_tooltip"},{id:"settings-id",showPageKey:"showGodModeAdminPage",icon:nf,localConstKey:"settings_tooltip"}],Se=["all","player","utility","troll","fav","custom"];const we=oe=>be(oe.detail),Ee=oe=>be(oe.detail),Ce=oe=>be(oe.detail),Fe=oe=>X(oe),ze=oe=>{t(6,_=oe.detail),le()};return i.$$set=oe=>{"left"in oe&&t(0,a=oe.left),"top"in oe&&t(1,o=oe.top)},[a,o,d,p,m,h,_,g,v,b,y,w,M,E,A,D,l,c,u,f,z,X,le,$,ne,be,q,ce,he,W,Se,we,Ee,Ce,Fe,ze]}class Hp extends Ze{constructor(e){super(),Ye(this,e,Gp,Vp,qe,{left:0,top:1},null,[-1,-1])}}function Ho(i,e,t){const n=i.slice();return n[16]=e[t],n}function Wp(i){let e,t=i[2],n=[];for(let r=0;r<t.length;r+=1)n[r]=Wo(Ho(i,t,r));return{c(){e=N("div");for(let r=0;r<n.length;r+=1)n[r].c();L(e,"id","chat-display"),L(e,"class","user-report-page-body")},m(r,s){O(r,e,s);for(let a=0;a<n.length;a+=1)n[a].m(e,null)},p(r,s){if(s&6){t=r[2];let a;for(a=0;a<t.length;a+=1){const o=Ho(r,t,a);n[a]?n[a].p(o,s):(n[a]=Wo(o),n[a].c(),n[a].m(e,null))}for(;a<n.length;a+=1)n[a].d(1);n.length=t.length}},i:ge,o:ge,d(r){r&&F(e),Vt(n,r)}}}function Xp(i){let e,t;return e=new dt({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},p:ge,i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function Wo(i){let e,t,n=i[16].message+"",r,s,a,o,l=i[1]===i[16].sender?"You":"Admin",c,u,f=i[16].formattedTime+"",d,p,m;return{c(){e=N("div"),t=N("div"),r=Z(n),a=Y(),o=N("small"),c=Z(l),u=Z(", "),d=Z(f),m=Y(),L(t,"class",s="txt-2sm user-report-chat-panel "+(i[1]===i[16].sender?"user-report-adjust-border-self-chat-info user-report-self-chat-panel-bg":"user-report-adjust-border-others-chat-info")),L(o,"class",p="txt-xs user-report-chat-info "+(i[1]===i[16].sender?"user-report-self-chat-info":"user-report-others-chat-info")),L(e,"class","user-report-each-chat")},m(h,_){O(h,e,_),S(e,t),S(t,r),S(e,a),S(e,o),S(o,c),S(o,u),S(o,d),S(e,m)},p(h,_){_&4&&n!==(n=h[16].message+"")&&de(r,n),_&6&&s!==(s="txt-2sm user-report-chat-panel "+(h[1]===h[16].sender?"user-report-adjust-border-self-chat-info user-report-self-chat-panel-bg":"user-report-adjust-border-others-chat-info"))&&L(t,"class",s),_&6&&l!==(l=h[1]===h[16].sender?"You":"Admin")&&de(c,l),_&4&&f!==(f=h[16].formattedTime+"")&&de(d,f),_&6&&p!==(p="txt-xs user-report-chat-info "+(h[1]===h[16].sender?"user-report-self-chat-info":"user-report-others-chat-info"))&&L(o,"class",p)},d(h){h&&F(e)}}}function jp(i){let e,t,n,r,s,a,o,l,c,u,f,d,p,m,h;const _=[Xp,Wp],g=[];function v(b,y){return b[0]?0:1}return r=v(i),s=g[r]=_[r](i),f=new It({props:{icon:Wu}}),{c(){e=N("div"),t=N("div"),t.textContent=`${i[7].reports_heading}`,n=Y(),s.c(),a=Y(),o=N("div"),l=N("textarea"),c=Y(),u=N("div"),Q(f.$$.fragment),L(t,"class","user-report-header"),L(l,"class","user-report-send-message-input txt-sm"),L(u,"class",d="user-report-send-msg-icon "+(i[4]?"user-report-send-msg-icon-disabled":"user-report-send-msg-icon-enabled")),L(o,"class","user-report-send-message-wrapper"),L(e,"class","user-report-base")},m(b,y){O(b,e,y),S(e,t),S(e,n),g[r].m(e,null),S(e,a),S(e,o),S(o,l),kt(l,i[3]),S(o,c),S(o,u),K(f,u,null),p=!0,m||(h=[Oe(l,"input",i[11]),Oe(l,"keydown",i[8]),Oe(u,"click",i[9]),Oe(o,"keypress",i[10])],m=!0)},p(b,[y]){let w=r;r=v(b),r===w?g[r].p(b,y):(Ve(),I(g[w],1,1,()=>{g[w]=null}),Ge(),s=g[r],s?s.p(b,y):(s=g[r]=_[r](b),s.c()),k(s,1),s.m(e,a)),y&8&&kt(l,b[3]),(!p||y&16&&d!==(d="user-report-send-msg-icon "+(b[4]?"user-report-send-msg-icon-disabled":"user-report-send-msg-icon-enabled")))&&L(u,"class",d)},i(b){p||(k(s),k(f.$$.fragment,b),p=!0)},o(b){I(s),I(f.$$.fragment,b),p=!1},d(b){b&&F(e),g[r].d(),J(f),m=!1,wt(h)}}}function qp(i,e,t){let n,r,s=!1,a="",o=[],{reportData:l}=mr;ft(i,l,b=>t(12,n=b));let c="",u=!0,{locales:f,data:d}=vt;ft(i,f,b=>t(13,r=b));let p=r;at(async()=>{t(0,s=!0),t(2,o=n.chats),t(1,a=n.currentUser),m(),On.scrollToTop("chat-display",100),t(0,s=!1)});function m(){o.map(b=>{var y=new Date(b.time*1e3);let w=Intl.DateTimeFormat().resolvedOptions().timeZone,M=y.toLocaleString("en-US",{timeZone:w});return b.formattedTime=M,b})}function h(){t(4,u=c.trim()==="")}async function _(){if(!u){t(0,s=!0);const y=await Ne("sendReportMessage",{currentUser:a,newMessage:c});t(2,o=y.chats),m(),t(3,c=""),On.scrollToTop("chat-display",100),t(4,u=!0),t(0,s=!1)}}function g(b){On.canSendMessage(b,c)&&_()}function v(){c=this.value,t(3,c)}return[s,a,o,c,u,l,f,p,h,_,g,v]}class Yp extends Ze{constructor(e){super(),Ye(this,e,qp,jp,qe,{})}}function Zp(i){let e,t,n,r,s;return r=new It({props:{icon:Qu}}),{c(){e=N("div"),t=N("div"),n=N("div"),Q(r.$$.fragment),L(n,"class","unread-report-header-close svelte-j2h0ts"),L(t,"class","unread-right svelte-j2h0ts")},m(a,o){O(a,e,o),S(e,t),S(t,n),K(r,n,null),s=!0},p:ge,i(a){s||(k(r.$$.fragment,a),s=!0)},o(a){I(r.$$.fragment,a),s=!1},d(a){a&&F(e),J(r)}}}class Kp extends Ze{constructor(e){super(),Ye(this,e,null,Zp,qe,{})}}/**
 * @license
 * Copyright 2010-2023 Three.js Authors
 * SPDX-License-Identifier: MIT
 */const ya="150",Jp=0,Xo=1,Qp=2,Ac=1,$p=2,sr=3,Zn=0,an=1,zn=2,Yn=0,Ni=1,jo=2,qo=3,Yo=4,em=5,Ai=100,tm=101,nm=102,Zo=103,Ko=104,im=200,rm=201,sm=202,am=203,Dc=204,Rc=205,om=206,lm=207,cm=208,um=209,fm=210,dm=0,hm=1,pm=2,oa=3,mm=4,_m=5,gm=6,bm=7,kc=0,vm=1,ym=2,Un=0,wm=1,xm=2,Mm=3,Sm=4,Cm=5,Ic=300,Bi=301,Vi=302,la=303,ca=304,ps=306,ua=1e3,_n=1001,fa=1002,jt=1003,Jo=1004,Cs=1005,fn=1006,Tm=1007,gr=1008,di=1009,Em=1010,Lm=1011,Nc=1012,Pm=1013,li=1014,ci=1015,br=1016,Am=1017,Dm=1018,zi=1020,Rm=1021,gn=1023,km=1024,Im=1025,ui=1026,Gi=1027,Nm=1028,zm=1029,Fm=1030,Om=1031,Um=1033,Ts=33776,Es=33777,Ls=33778,Ps=33779,Qo=35840,$o=35841,el=35842,tl=35843,Bm=36196,nl=37492,il=37496,rl=37808,sl=37809,al=37810,ol=37811,ll=37812,cl=37813,ul=37814,fl=37815,dl=37816,hl=37817,pl=37818,ml=37819,_l=37820,gl=37821,As=36492,Vm=36283,bl=36284,vl=36285,yl=36286,hi=3e3,pt=3001,Gm=3200,Hm=3201,Wm=0,Xm=1,Mn="srgb",vr="srgb-linear",zc="display-p3",Ds=7680,jm=519,wl=35044,xl="300 es",da=1035;class Wi{addEventListener(e,t){this._listeners===void 0&&(this._listeners={});const n=this._listeners;n[e]===void 0&&(n[e]=[]),n[e].indexOf(t)===-1&&n[e].push(t)}hasEventListener(e,t){if(this._listeners===void 0)return!1;const n=this._listeners;return n[e]!==void 0&&n[e].indexOf(t)!==-1}removeEventListener(e,t){if(this._listeners===void 0)return;const r=this._listeners[e];if(r!==void 0){const s=r.indexOf(t);s!==-1&&r.splice(s,1)}}dispatchEvent(e){if(this._listeners===void 0)return;const n=this._listeners[e.type];if(n!==void 0){e.target=this;const r=n.slice(0);for(let s=0,a=r.length;s<a;s++)r[s].call(this,e);e.target=null}}}const Ot=["00","01","02","03","04","05","06","07","08","09","0a","0b","0c","0d","0e","0f","10","11","12","13","14","15","16","17","18","19","1a","1b","1c","1d","1e","1f","20","21","22","23","24","25","26","27","28","29","2a","2b","2c","2d","2e","2f","30","31","32","33","34","35","36","37","38","39","3a","3b","3c","3d","3e","3f","40","41","42","43","44","45","46","47","48","49","4a","4b","4c","4d","4e","4f","50","51","52","53","54","55","56","57","58","59","5a","5b","5c","5d","5e","5f","60","61","62","63","64","65","66","67","68","69","6a","6b","6c","6d","6e","6f","70","71","72","73","74","75","76","77","78","79","7a","7b","7c","7d","7e","7f","80","81","82","83","84","85","86","87","88","89","8a","8b","8c","8d","8e","8f","90","91","92","93","94","95","96","97","98","99","9a","9b","9c","9d","9e","9f","a0","a1","a2","a3","a4","a5","a6","a7","a8","a9","aa","ab","ac","ad","ae","af","b0","b1","b2","b3","b4","b5","b6","b7","b8","b9","ba","bb","bc","bd","be","bf","c0","c1","c2","c3","c4","c5","c6","c7","c8","c9","ca","cb","cc","cd","ce","cf","d0","d1","d2","d3","d4","d5","d6","d7","d8","d9","da","db","dc","dd","de","df","e0","e1","e2","e3","e4","e5","e6","e7","e8","e9","ea","eb","ec","ed","ee","ef","f0","f1","f2","f3","f4","f5","f6","f7","f8","f9","fa","fb","fc","fd","fe","ff"];let Ml=1234567;const dr=Math.PI/180,us=180/Math.PI;function Xi(){const i=Math.random()*4294967295|0,e=Math.random()*4294967295|0,t=Math.random()*4294967295|0,n=Math.random()*4294967295|0;return(Ot[i&255]+Ot[i>>8&255]+Ot[i>>16&255]+Ot[i>>24&255]+"-"+Ot[e&255]+Ot[e>>8&255]+"-"+Ot[e>>16&15|64]+Ot[e>>24&255]+"-"+Ot[t&63|128]+Ot[t>>8&255]+"-"+Ot[t>>16&255]+Ot[t>>24&255]+Ot[n&255]+Ot[n>>8&255]+Ot[n>>16&255]+Ot[n>>24&255]).toLowerCase()}function Qt(i,e,t){return Math.max(e,Math.min(t,i))}function wa(i,e){return(i%e+e)%e}function qm(i,e,t,n,r){return n+(i-e)*(r-n)/(t-e)}function Ym(i,e,t){return i!==e?(t-i)/(e-i):0}function hr(i,e,t){return(1-t)*i+t*e}function Zm(i,e,t,n){return hr(i,e,1-Math.exp(-t*n))}function Km(i,e=1){return e-Math.abs(wa(i,e*2)-e)}function Jm(i,e,t){return i<=e?0:i>=t?1:(i=(i-e)/(t-e),i*i*(3-2*i))}function Qm(i,e,t){return i<=e?0:i>=t?1:(i=(i-e)/(t-e),i*i*i*(i*(i*6-15)+10))}function $m(i,e){return i+Math.floor(Math.random()*(e-i+1))}function e_(i,e){return i+Math.random()*(e-i)}function t_(i){return i*(.5-Math.random())}function n_(i){i!==void 0&&(Ml=i);let e=Ml+=1831565813;return e=Math.imul(e^e>>>15,e|1),e^=e+Math.imul(e^e>>>7,e|61),((e^e>>>14)>>>0)/4294967296}function i_(i){return i*dr}function r_(i){return i*us}function ha(i){return(i&i-1)===0&&i!==0}function s_(i){return Math.pow(2,Math.ceil(Math.log(i)/Math.LN2))}function Fc(i){return Math.pow(2,Math.floor(Math.log(i)/Math.LN2))}function a_(i,e,t,n,r){const s=Math.cos,a=Math.sin,o=s(t/2),l=a(t/2),c=s((e+n)/2),u=a((e+n)/2),f=s((e-n)/2),d=a((e-n)/2),p=s((n-e)/2),m=a((n-e)/2);switch(r){case"XYX":i.set(o*u,l*f,l*d,o*c);break;case"YZY":i.set(l*d,o*u,l*f,o*c);break;case"ZXZ":i.set(l*f,l*d,o*u,o*c);break;case"XZX":i.set(o*u,l*m,l*p,o*c);break;case"YXY":i.set(l*p,o*u,l*m,o*c);break;case"ZYZ":i.set(l*m,l*p,o*u,o*c);break;default:console.warn("THREE.MathUtils: .setQuaternionFromProperEuler() encountered an unknown order: "+r)}}function ar(i,e){switch(e.constructor){case Float32Array:return i;case Uint16Array:return i/65535;case Uint8Array:return i/255;case Int16Array:return Math.max(i/32767,-1);case Int8Array:return Math.max(i/127,-1);default:throw new Error("Invalid component type.")}}function Kt(i,e){switch(e.constructor){case Float32Array:return i;case Uint16Array:return Math.round(i*65535);case Uint8Array:return Math.round(i*255);case Int16Array:return Math.round(i*32767);case Int8Array:return Math.round(i*127);default:throw new Error("Invalid component type.")}}const Ln={DEG2RAD:dr,RAD2DEG:us,generateUUID:Xi,clamp:Qt,euclideanModulo:wa,mapLinear:qm,inverseLerp:Ym,lerp:hr,damp:Zm,pingpong:Km,smoothstep:Jm,smootherstep:Qm,randInt:$m,randFloat:e_,randFloatSpread:t_,seededRandom:n_,degToRad:i_,radToDeg:r_,isPowerOfTwo:ha,ceilPowerOfTwo:s_,floorPowerOfTwo:Fc,setQuaternionFromProperEuler:a_,normalize:Kt,denormalize:ar};class st{constructor(e=0,t=0){st.prototype.isVector2=!0,this.x=e,this.y=t}get width(){return this.x}set width(e){this.x=e}get height(){return this.y}set height(e){this.y=e}set(e,t){return this.x=e,this.y=t,this}setScalar(e){return this.x=e,this.y=e,this}setX(e){return this.x=e,this}setY(e){return this.y=e,this}setComponent(e,t){switch(e){case 0:this.x=t;break;case 1:this.y=t;break;default:throw new Error("index is out of range: "+e)}return this}getComponent(e){switch(e){case 0:return this.x;case 1:return this.y;default:throw new Error("index is out of range: "+e)}}clone(){return new this.constructor(this.x,this.y)}copy(e){return this.x=e.x,this.y=e.y,this}add(e){return this.x+=e.x,this.y+=e.y,this}addScalar(e){return this.x+=e,this.y+=e,this}addVectors(e,t){return this.x=e.x+t.x,this.y=e.y+t.y,this}addScaledVector(e,t){return this.x+=e.x*t,this.y+=e.y*t,this}sub(e){return this.x-=e.x,this.y-=e.y,this}subScalar(e){return this.x-=e,this.y-=e,this}subVectors(e,t){return this.x=e.x-t.x,this.y=e.y-t.y,this}multiply(e){return this.x*=e.x,this.y*=e.y,this}multiplyScalar(e){return this.x*=e,this.y*=e,this}divide(e){return this.x/=e.x,this.y/=e.y,this}divideScalar(e){return this.multiplyScalar(1/e)}applyMatrix3(e){const t=this.x,n=this.y,r=e.elements;return this.x=r[0]*t+r[3]*n+r[6],this.y=r[1]*t+r[4]*n+r[7],this}min(e){return this.x=Math.min(this.x,e.x),this.y=Math.min(this.y,e.y),this}max(e){return this.x=Math.max(this.x,e.x),this.y=Math.max(this.y,e.y),this}clamp(e,t){return this.x=Math.max(e.x,Math.min(t.x,this.x)),this.y=Math.max(e.y,Math.min(t.y,this.y)),this}clampScalar(e,t){return this.x=Math.max(e,Math.min(t,this.x)),this.y=Math.max(e,Math.min(t,this.y)),this}clampLength(e,t){const n=this.length();return this.divideScalar(n||1).multiplyScalar(Math.max(e,Math.min(t,n)))}floor(){return this.x=Math.floor(this.x),this.y=Math.floor(this.y),this}ceil(){return this.x=Math.ceil(this.x),this.y=Math.ceil(this.y),this}round(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this}roundToZero(){return this.x=this.x<0?Math.ceil(this.x):Math.floor(this.x),this.y=this.y<0?Math.ceil(this.y):Math.floor(this.y),this}negate(){return this.x=-this.x,this.y=-this.y,this}dot(e){return this.x*e.x+this.y*e.y}cross(e){return this.x*e.y-this.y*e.x}lengthSq(){return this.x*this.x+this.y*this.y}length(){return Math.sqrt(this.x*this.x+this.y*this.y)}manhattanLength(){return Math.abs(this.x)+Math.abs(this.y)}normalize(){return this.divideScalar(this.length()||1)}angle(){return Math.atan2(-this.y,-this.x)+Math.PI}distanceTo(e){return Math.sqrt(this.distanceToSquared(e))}distanceToSquared(e){const t=this.x-e.x,n=this.y-e.y;return t*t+n*n}manhattanDistanceTo(e){return Math.abs(this.x-e.x)+Math.abs(this.y-e.y)}setLength(e){return this.normalize().multiplyScalar(e)}lerp(e,t){return this.x+=(e.x-this.x)*t,this.y+=(e.y-this.y)*t,this}lerpVectors(e,t,n){return this.x=e.x+(t.x-e.x)*n,this.y=e.y+(t.y-e.y)*n,this}equals(e){return e.x===this.x&&e.y===this.y}fromArray(e,t=0){return this.x=e[t],this.y=e[t+1],this}toArray(e=[],t=0){return e[t]=this.x,e[t+1]=this.y,e}fromBufferAttribute(e,t){return this.x=e.getX(t),this.y=e.getY(t),this}rotateAround(e,t){const n=Math.cos(t),r=Math.sin(t),s=this.x-e.x,a=this.y-e.y;return this.x=s*n-a*r+e.x,this.y=s*r+a*n+e.y,this}random(){return this.x=Math.random(),this.y=Math.random(),this}*[Symbol.iterator](){yield this.x,yield this.y}}class Yt{constructor(){Yt.prototype.isMatrix3=!0,this.elements=[1,0,0,0,1,0,0,0,1]}set(e,t,n,r,s,a,o,l,c){const u=this.elements;return u[0]=e,u[1]=r,u[2]=o,u[3]=t,u[4]=s,u[5]=l,u[6]=n,u[7]=a,u[8]=c,this}identity(){return this.set(1,0,0,0,1,0,0,0,1),this}copy(e){const t=this.elements,n=e.elements;return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t[4]=n[4],t[5]=n[5],t[6]=n[6],t[7]=n[7],t[8]=n[8],this}extractBasis(e,t,n){return e.setFromMatrix3Column(this,0),t.setFromMatrix3Column(this,1),n.setFromMatrix3Column(this,2),this}setFromMatrix4(e){const t=e.elements;return this.set(t[0],t[4],t[8],t[1],t[5],t[9],t[2],t[6],t[10]),this}multiply(e){return this.multiplyMatrices(this,e)}premultiply(e){return this.multiplyMatrices(e,this)}multiplyMatrices(e,t){const n=e.elements,r=t.elements,s=this.elements,a=n[0],o=n[3],l=n[6],c=n[1],u=n[4],f=n[7],d=n[2],p=n[5],m=n[8],h=r[0],_=r[3],g=r[6],v=r[1],b=r[4],y=r[7],w=r[2],M=r[5],E=r[8];return s[0]=a*h+o*v+l*w,s[3]=a*_+o*b+l*M,s[6]=a*g+o*y+l*E,s[1]=c*h+u*v+f*w,s[4]=c*_+u*b+f*M,s[7]=c*g+u*y+f*E,s[2]=d*h+p*v+m*w,s[5]=d*_+p*b+m*M,s[8]=d*g+p*y+m*E,this}multiplyScalar(e){const t=this.elements;return t[0]*=e,t[3]*=e,t[6]*=e,t[1]*=e,t[4]*=e,t[7]*=e,t[2]*=e,t[5]*=e,t[8]*=e,this}determinant(){const e=this.elements,t=e[0],n=e[1],r=e[2],s=e[3],a=e[4],o=e[5],l=e[6],c=e[7],u=e[8];return t*a*u-t*o*c-n*s*u+n*o*l+r*s*c-r*a*l}invert(){const e=this.elements,t=e[0],n=e[1],r=e[2],s=e[3],a=e[4],o=e[5],l=e[6],c=e[7],u=e[8],f=u*a-o*c,d=o*l-u*s,p=c*s-a*l,m=t*f+n*d+r*p;if(m===0)return this.set(0,0,0,0,0,0,0,0,0);const h=1/m;return e[0]=f*h,e[1]=(r*c-u*n)*h,e[2]=(o*n-r*a)*h,e[3]=d*h,e[4]=(u*t-r*l)*h,e[5]=(r*s-o*t)*h,e[6]=p*h,e[7]=(n*l-c*t)*h,e[8]=(a*t-n*s)*h,this}transpose(){let e;const t=this.elements;return e=t[1],t[1]=t[3],t[3]=e,e=t[2],t[2]=t[6],t[6]=e,e=t[5],t[5]=t[7],t[7]=e,this}getNormalMatrix(e){return this.setFromMatrix4(e).invert().transpose()}transposeIntoArray(e){const t=this.elements;return e[0]=t[0],e[1]=t[3],e[2]=t[6],e[3]=t[1],e[4]=t[4],e[5]=t[7],e[6]=t[2],e[7]=t[5],e[8]=t[8],this}setUvTransform(e,t,n,r,s,a,o){const l=Math.cos(s),c=Math.sin(s);return this.set(n*l,n*c,-n*(l*a+c*o)+a+e,-r*c,r*l,-r*(-c*a+l*o)+o+t,0,0,1),this}scale(e,t){return this.premultiply(Rs.makeScale(e,t)),this}rotate(e){return this.premultiply(Rs.makeRotation(-e)),this}translate(e,t){return this.premultiply(Rs.makeTranslation(e,t)),this}makeTranslation(e,t){return this.set(1,0,e,0,1,t,0,0,1),this}makeRotation(e){const t=Math.cos(e),n=Math.sin(e);return this.set(t,-n,0,n,t,0,0,0,1),this}makeScale(e,t){return this.set(e,0,0,0,t,0,0,0,1),this}equals(e){const t=this.elements,n=e.elements;for(let r=0;r<9;r++)if(t[r]!==n[r])return!1;return!0}fromArray(e,t=0){for(let n=0;n<9;n++)this.elements[n]=e[n+t];return this}toArray(e=[],t=0){const n=this.elements;return e[t]=n[0],e[t+1]=n[1],e[t+2]=n[2],e[t+3]=n[3],e[t+4]=n[4],e[t+5]=n[5],e[t+6]=n[6],e[t+7]=n[7],e[t+8]=n[8],e}clone(){return new this.constructor().fromArray(this.elements)}}const Rs=new Yt;function Oc(i){for(let e=i.length-1;e>=0;--e)if(i[e]>=65535)return!0;return!1}function fs(i){return document.createElementNS("http://www.w3.org/1999/xhtml",i)}class qt{constructor(e=0,t=0,n=0,r=1){this.isQuaternion=!0,this._x=e,this._y=t,this._z=n,this._w=r}static slerpFlat(e,t,n,r,s,a,o){let l=n[r+0],c=n[r+1],u=n[r+2],f=n[r+3];const d=s[a+0],p=s[a+1],m=s[a+2],h=s[a+3];if(o===0){e[t+0]=l,e[t+1]=c,e[t+2]=u,e[t+3]=f;return}if(o===1){e[t+0]=d,e[t+1]=p,e[t+2]=m,e[t+3]=h;return}if(f!==h||l!==d||c!==p||u!==m){let _=1-o;const g=l*d+c*p+u*m+f*h,v=g>=0?1:-1,b=1-g*g;if(b>Number.EPSILON){const w=Math.sqrt(b),M=Math.atan2(w,g*v);_=Math.sin(_*M)/w,o=Math.sin(o*M)/w}const y=o*v;if(l=l*_+d*y,c=c*_+p*y,u=u*_+m*y,f=f*_+h*y,_===1-o){const w=1/Math.sqrt(l*l+c*c+u*u+f*f);l*=w,c*=w,u*=w,f*=w}}e[t]=l,e[t+1]=c,e[t+2]=u,e[t+3]=f}static multiplyQuaternionsFlat(e,t,n,r,s,a){const o=n[r],l=n[r+1],c=n[r+2],u=n[r+3],f=s[a],d=s[a+1],p=s[a+2],m=s[a+3];return e[t]=o*m+u*f+l*p-c*d,e[t+1]=l*m+u*d+c*f-o*p,e[t+2]=c*m+u*p+o*d-l*f,e[t+3]=u*m-o*f-l*d-c*p,e}get x(){return this._x}set x(e){this._x=e,this._onChangeCallback()}get y(){return this._y}set y(e){this._y=e,this._onChangeCallback()}get z(){return this._z}set z(e){this._z=e,this._onChangeCallback()}get w(){return this._w}set w(e){this._w=e,this._onChangeCallback()}set(e,t,n,r){return this._x=e,this._y=t,this._z=n,this._w=r,this._onChangeCallback(),this}clone(){return new this.constructor(this._x,this._y,this._z,this._w)}copy(e){return this._x=e.x,this._y=e.y,this._z=e.z,this._w=e.w,this._onChangeCallback(),this}setFromEuler(e,t){const n=e._x,r=e._y,s=e._z,a=e._order,o=Math.cos,l=Math.sin,c=o(n/2),u=o(r/2),f=o(s/2),d=l(n/2),p=l(r/2),m=l(s/2);switch(a){case"XYZ":this._x=d*u*f+c*p*m,this._y=c*p*f-d*u*m,this._z=c*u*m+d*p*f,this._w=c*u*f-d*p*m;break;case"YXZ":this._x=d*u*f+c*p*m,this._y=c*p*f-d*u*m,this._z=c*u*m-d*p*f,this._w=c*u*f+d*p*m;break;case"ZXY":this._x=d*u*f-c*p*m,this._y=c*p*f+d*u*m,this._z=c*u*m+d*p*f,this._w=c*u*f-d*p*m;break;case"ZYX":this._x=d*u*f-c*p*m,this._y=c*p*f+d*u*m,this._z=c*u*m-d*p*f,this._w=c*u*f+d*p*m;break;case"YZX":this._x=d*u*f+c*p*m,this._y=c*p*f+d*u*m,this._z=c*u*m-d*p*f,this._w=c*u*f-d*p*m;break;case"XZY":this._x=d*u*f-c*p*m,this._y=c*p*f-d*u*m,this._z=c*u*m+d*p*f,this._w=c*u*f+d*p*m;break;default:console.warn("THREE.Quaternion: .setFromEuler() encountered an unknown order: "+a)}return t!==!1&&this._onChangeCallback(),this}setFromAxisAngle(e,t){const n=t/2,r=Math.sin(n);return this._x=e.x*r,this._y=e.y*r,this._z=e.z*r,this._w=Math.cos(n),this._onChangeCallback(),this}setFromRotationMatrix(e){const t=e.elements,n=t[0],r=t[4],s=t[8],a=t[1],o=t[5],l=t[9],c=t[2],u=t[6],f=t[10],d=n+o+f;if(d>0){const p=.5/Math.sqrt(d+1);this._w=.25/p,this._x=(u-l)*p,this._y=(s-c)*p,this._z=(a-r)*p}else if(n>o&&n>f){const p=2*Math.sqrt(1+n-o-f);this._w=(u-l)/p,this._x=.25*p,this._y=(r+a)/p,this._z=(s+c)/p}else if(o>f){const p=2*Math.sqrt(1+o-n-f);this._w=(s-c)/p,this._x=(r+a)/p,this._y=.25*p,this._z=(l+u)/p}else{const p=2*Math.sqrt(1+f-n-o);this._w=(a-r)/p,this._x=(s+c)/p,this._y=(l+u)/p,this._z=.25*p}return this._onChangeCallback(),this}setFromUnitVectors(e,t){let n=e.dot(t)+1;return n<Number.EPSILON?(n=0,Math.abs(e.x)>Math.abs(e.z)?(this._x=-e.y,this._y=e.x,this._z=0,this._w=n):(this._x=0,this._y=-e.z,this._z=e.y,this._w=n)):(this._x=e.y*t.z-e.z*t.y,this._y=e.z*t.x-e.x*t.z,this._z=e.x*t.y-e.y*t.x,this._w=n),this.normalize()}angleTo(e){return 2*Math.acos(Math.abs(Qt(this.dot(e),-1,1)))}rotateTowards(e,t){const n=this.angleTo(e);if(n===0)return this;const r=Math.min(1,t/n);return this.slerp(e,r),this}identity(){return this.set(0,0,0,1)}invert(){return this.conjugate()}conjugate(){return this._x*=-1,this._y*=-1,this._z*=-1,this._onChangeCallback(),this}dot(e){return this._x*e._x+this._y*e._y+this._z*e._z+this._w*e._w}lengthSq(){return this._x*this._x+this._y*this._y+this._z*this._z+this._w*this._w}length(){return Math.sqrt(this._x*this._x+this._y*this._y+this._z*this._z+this._w*this._w)}normalize(){let e=this.length();return e===0?(this._x=0,this._y=0,this._z=0,this._w=1):(e=1/e,this._x=this._x*e,this._y=this._y*e,this._z=this._z*e,this._w=this._w*e),this._onChangeCallback(),this}multiply(e){return this.multiplyQuaternions(this,e)}premultiply(e){return this.multiplyQuaternions(e,this)}multiplyQuaternions(e,t){const n=e._x,r=e._y,s=e._z,a=e._w,o=t._x,l=t._y,c=t._z,u=t._w;return this._x=n*u+a*o+r*c-s*l,this._y=r*u+a*l+s*o-n*c,this._z=s*u+a*c+n*l-r*o,this._w=a*u-n*o-r*l-s*c,this._onChangeCallback(),this}slerp(e,t){if(t===0)return this;if(t===1)return this.copy(e);const n=this._x,r=this._y,s=this._z,a=this._w;let o=a*e._w+n*e._x+r*e._y+s*e._z;if(o<0?(this._w=-e._w,this._x=-e._x,this._y=-e._y,this._z=-e._z,o=-o):this.copy(e),o>=1)return this._w=a,this._x=n,this._y=r,this._z=s,this;const l=1-o*o;if(l<=Number.EPSILON){const p=1-t;return this._w=p*a+t*this._w,this._x=p*n+t*this._x,this._y=p*r+t*this._y,this._z=p*s+t*this._z,this.normalize(),this._onChangeCallback(),this}const c=Math.sqrt(l),u=Math.atan2(c,o),f=Math.sin((1-t)*u)/c,d=Math.sin(t*u)/c;return this._w=a*f+this._w*d,this._x=n*f+this._x*d,this._y=r*f+this._y*d,this._z=s*f+this._z*d,this._onChangeCallback(),this}slerpQuaternions(e,t,n){return this.copy(e).slerp(t,n)}random(){const e=Math.random(),t=Math.sqrt(1-e),n=Math.sqrt(e),r=2*Math.PI*Math.random(),s=2*Math.PI*Math.random();return this.set(t*Math.cos(r),n*Math.sin(s),n*Math.cos(s),t*Math.sin(r))}equals(e){return e._x===this._x&&e._y===this._y&&e._z===this._z&&e._w===this._w}fromArray(e,t=0){return this._x=e[t],this._y=e[t+1],this._z=e[t+2],this._w=e[t+3],this._onChangeCallback(),this}toArray(e=[],t=0){return e[t]=this._x,e[t+1]=this._y,e[t+2]=this._z,e[t+3]=this._w,e}fromBufferAttribute(e,t){return this._x=e.getX(t),this._y=e.getY(t),this._z=e.getZ(t),this._w=e.getW(t),this}_onChange(e){return this._onChangeCallback=e,this}_onChangeCallback(){}*[Symbol.iterator](){yield this._x,yield this._y,yield this._z,yield this._w}}class B{constructor(e=0,t=0,n=0){B.prototype.isVector3=!0,this.x=e,this.y=t,this.z=n}set(e,t,n){return n===void 0&&(n=this.z),this.x=e,this.y=t,this.z=n,this}setScalar(e){return this.x=e,this.y=e,this.z=e,this}setX(e){return this.x=e,this}setY(e){return this.y=e,this}setZ(e){return this.z=e,this}setComponent(e,t){switch(e){case 0:this.x=t;break;case 1:this.y=t;break;case 2:this.z=t;break;default:throw new Error("index is out of range: "+e)}return this}getComponent(e){switch(e){case 0:return this.x;case 1:return this.y;case 2:return this.z;default:throw new Error("index is out of range: "+e)}}clone(){return new this.constructor(this.x,this.y,this.z)}copy(e){return this.x=e.x,this.y=e.y,this.z=e.z,this}add(e){return this.x+=e.x,this.y+=e.y,this.z+=e.z,this}addScalar(e){return this.x+=e,this.y+=e,this.z+=e,this}addVectors(e,t){return this.x=e.x+t.x,this.y=e.y+t.y,this.z=e.z+t.z,this}addScaledVector(e,t){return this.x+=e.x*t,this.y+=e.y*t,this.z+=e.z*t,this}sub(e){return this.x-=e.x,this.y-=e.y,this.z-=e.z,this}subScalar(e){return this.x-=e,this.y-=e,this.z-=e,this}subVectors(e,t){return this.x=e.x-t.x,this.y=e.y-t.y,this.z=e.z-t.z,this}multiply(e){return this.x*=e.x,this.y*=e.y,this.z*=e.z,this}multiplyScalar(e){return this.x*=e,this.y*=e,this.z*=e,this}multiplyVectors(e,t){return this.x=e.x*t.x,this.y=e.y*t.y,this.z=e.z*t.z,this}applyEuler(e){return this.applyQuaternion(Sl.setFromEuler(e))}applyAxisAngle(e,t){return this.applyQuaternion(Sl.setFromAxisAngle(e,t))}applyMatrix3(e){const t=this.x,n=this.y,r=this.z,s=e.elements;return this.x=s[0]*t+s[3]*n+s[6]*r,this.y=s[1]*t+s[4]*n+s[7]*r,this.z=s[2]*t+s[5]*n+s[8]*r,this}applyNormalMatrix(e){return this.applyMatrix3(e).normalize()}applyMatrix4(e){const t=this.x,n=this.y,r=this.z,s=e.elements,a=1/(s[3]*t+s[7]*n+s[11]*r+s[15]);return this.x=(s[0]*t+s[4]*n+s[8]*r+s[12])*a,this.y=(s[1]*t+s[5]*n+s[9]*r+s[13])*a,this.z=(s[2]*t+s[6]*n+s[10]*r+s[14])*a,this}applyQuaternion(e){const t=this.x,n=this.y,r=this.z,s=e.x,a=e.y,o=e.z,l=e.w,c=l*t+a*r-o*n,u=l*n+o*t-s*r,f=l*r+s*n-a*t,d=-s*t-a*n-o*r;return this.x=c*l+d*-s+u*-o-f*-a,this.y=u*l+d*-a+f*-s-c*-o,this.z=f*l+d*-o+c*-a-u*-s,this}project(e){return this.applyMatrix4(e.matrixWorldInverse).applyMatrix4(e.projectionMatrix)}unproject(e){return this.applyMatrix4(e.projectionMatrixInverse).applyMatrix4(e.matrixWorld)}transformDirection(e){const t=this.x,n=this.y,r=this.z,s=e.elements;return this.x=s[0]*t+s[4]*n+s[8]*r,this.y=s[1]*t+s[5]*n+s[9]*r,this.z=s[2]*t+s[6]*n+s[10]*r,this.normalize()}divide(e){return this.x/=e.x,this.y/=e.y,this.z/=e.z,this}divideScalar(e){return this.multiplyScalar(1/e)}min(e){return this.x=Math.min(this.x,e.x),this.y=Math.min(this.y,e.y),this.z=Math.min(this.z,e.z),this}max(e){return this.x=Math.max(this.x,e.x),this.y=Math.max(this.y,e.y),this.z=Math.max(this.z,e.z),this}clamp(e,t){return this.x=Math.max(e.x,Math.min(t.x,this.x)),this.y=Math.max(e.y,Math.min(t.y,this.y)),this.z=Math.max(e.z,Math.min(t.z,this.z)),this}clampScalar(e,t){return this.x=Math.max(e,Math.min(t,this.x)),this.y=Math.max(e,Math.min(t,this.y)),this.z=Math.max(e,Math.min(t,this.z)),this}clampLength(e,t){const n=this.length();return this.divideScalar(n||1).multiplyScalar(Math.max(e,Math.min(t,n)))}floor(){return this.x=Math.floor(this.x),this.y=Math.floor(this.y),this.z=Math.floor(this.z),this}ceil(){return this.x=Math.ceil(this.x),this.y=Math.ceil(this.y),this.z=Math.ceil(this.z),this}round(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this.z=Math.round(this.z),this}roundToZero(){return this.x=this.x<0?Math.ceil(this.x):Math.floor(this.x),this.y=this.y<0?Math.ceil(this.y):Math.floor(this.y),this.z=this.z<0?Math.ceil(this.z):Math.floor(this.z),this}negate(){return this.x=-this.x,this.y=-this.y,this.z=-this.z,this}dot(e){return this.x*e.x+this.y*e.y+this.z*e.z}lengthSq(){return this.x*this.x+this.y*this.y+this.z*this.z}length(){return Math.sqrt(this.x*this.x+this.y*this.y+this.z*this.z)}manhattanLength(){return Math.abs(this.x)+Math.abs(this.y)+Math.abs(this.z)}normalize(){return this.divideScalar(this.length()||1)}setLength(e){return this.normalize().multiplyScalar(e)}lerp(e,t){return this.x+=(e.x-this.x)*t,this.y+=(e.y-this.y)*t,this.z+=(e.z-this.z)*t,this}lerpVectors(e,t,n){return this.x=e.x+(t.x-e.x)*n,this.y=e.y+(t.y-e.y)*n,this.z=e.z+(t.z-e.z)*n,this}cross(e){return this.crossVectors(this,e)}crossVectors(e,t){const n=e.x,r=e.y,s=e.z,a=t.x,o=t.y,l=t.z;return this.x=r*l-s*o,this.y=s*a-n*l,this.z=n*o-r*a,this}projectOnVector(e){const t=e.lengthSq();if(t===0)return this.set(0,0,0);const n=e.dot(this)/t;return this.copy(e).multiplyScalar(n)}projectOnPlane(e){return ks.copy(this).projectOnVector(e),this.sub(ks)}reflect(e){return this.sub(ks.copy(e).multiplyScalar(2*this.dot(e)))}angleTo(e){const t=Math.sqrt(this.lengthSq()*e.lengthSq());if(t===0)return Math.PI/2;const n=this.dot(e)/t;return Math.acos(Qt(n,-1,1))}distanceTo(e){return Math.sqrt(this.distanceToSquared(e))}distanceToSquared(e){const t=this.x-e.x,n=this.y-e.y,r=this.z-e.z;return t*t+n*n+r*r}manhattanDistanceTo(e){return Math.abs(this.x-e.x)+Math.abs(this.y-e.y)+Math.abs(this.z-e.z)}setFromSpherical(e){return this.setFromSphericalCoords(e.radius,e.phi,e.theta)}setFromSphericalCoords(e,t,n){const r=Math.sin(t)*e;return this.x=r*Math.sin(n),this.y=Math.cos(t)*e,this.z=r*Math.cos(n),this}setFromCylindrical(e){return this.setFromCylindricalCoords(e.radius,e.theta,e.y)}setFromCylindricalCoords(e,t,n){return this.x=e*Math.sin(t),this.y=n,this.z=e*Math.cos(t),this}setFromMatrixPosition(e){const t=e.elements;return this.x=t[12],this.y=t[13],this.z=t[14],this}setFromMatrixScale(e){const t=this.setFromMatrixColumn(e,0).length(),n=this.setFromMatrixColumn(e,1).length(),r=this.setFromMatrixColumn(e,2).length();return this.x=t,this.y=n,this.z=r,this}setFromMatrixColumn(e,t){return this.fromArray(e.elements,t*4)}setFromMatrix3Column(e,t){return this.fromArray(e.elements,t*3)}setFromEuler(e){return this.x=e._x,this.y=e._y,this.z=e._z,this}equals(e){return e.x===this.x&&e.y===this.y&&e.z===this.z}fromArray(e,t=0){return this.x=e[t],this.y=e[t+1],this.z=e[t+2],this}toArray(e=[],t=0){return e[t]=this.x,e[t+1]=this.y,e[t+2]=this.z,e}fromBufferAttribute(e,t){return this.x=e.getX(t),this.y=e.getY(t),this.z=e.getZ(t),this}random(){return this.x=Math.random(),this.y=Math.random(),this.z=Math.random(),this}randomDirection(){const e=(Math.random()-.5)*2,t=Math.random()*Math.PI*2,n=Math.sqrt(1-e**2);return this.x=n*Math.cos(t),this.y=n*Math.sin(t),this.z=e,this}*[Symbol.iterator](){yield this.x,yield this.y,yield this.z}}const ks=new B,Sl=new qt;function Fi(i){return i<.04045?i*.0773993808:Math.pow(i*.9478672986+.0521327014,2.4)}function Is(i){return i<.0031308?i*12.92:1.055*Math.pow(i,.41666)-.055}const o_=new Yt().fromArray([.8224621,.0331941,.0170827,.177538,.9668058,.0723974,-1e-7,1e-7,.9105199]),l_=new Yt().fromArray([1.2249401,-.0420569,-.0196376,-.2249404,1.0420571,-.0786361,1e-7,0,1.0982735]),qn=new B;function c_(i){return i.convertSRGBToLinear(),qn.set(i.r,i.g,i.b).applyMatrix3(l_),i.setRGB(qn.x,qn.y,qn.z)}function u_(i){return qn.set(i.r,i.g,i.b).applyMatrix3(o_),i.setRGB(qn.x,qn.y,qn.z).convertLinearToSRGB()}const f_={[vr]:i=>i,[Mn]:i=>i.convertSRGBToLinear(),[zc]:c_},d_={[vr]:i=>i,[Mn]:i=>i.convertLinearToSRGB(),[zc]:u_},Wt={enabled:!1,get legacyMode(){return console.warn("THREE.ColorManagement: .legacyMode=false renamed to .enabled=true in r150."),!this.enabled},set legacyMode(i){console.warn("THREE.ColorManagement: .legacyMode=false renamed to .enabled=true in r150."),this.enabled=!i},get workingColorSpace(){return vr},set workingColorSpace(i){console.warn("THREE.ColorManagement: .workingColorSpace is readonly.")},convert:function(i,e,t){if(this.enabled===!1||e===t||!e||!t)return i;const n=f_[e],r=d_[t];if(n===void 0||r===void 0)throw new Error(`Unsupported color space conversion, "${e}" to "${t}".`);return r(n(i))},fromWorkingColorSpace:function(i,e){return this.convert(i,this.workingColorSpace,e)},toWorkingColorSpace:function(i,e){return this.convert(i,e,this.workingColorSpace)}};let gi;class Uc{static getDataURL(e){if(/^data:/i.test(e.src)||typeof HTMLCanvasElement>"u")return e.src;let t;if(e instanceof HTMLCanvasElement)t=e;else{gi===void 0&&(gi=fs("canvas")),gi.width=e.width,gi.height=e.height;const n=gi.getContext("2d");e instanceof ImageData?n.putImageData(e,0,0):n.drawImage(e,0,0,e.width,e.height),t=gi}return t.width>2048||t.height>2048?(console.warn("THREE.ImageUtils.getDataURL: Image converted to jpg for performance reasons",e),t.toDataURL("image/jpeg",.6)):t.toDataURL("image/png")}static sRGBToLinear(e){if(typeof HTMLImageElement<"u"&&e instanceof HTMLImageElement||typeof HTMLCanvasElement<"u"&&e instanceof HTMLCanvasElement||typeof ImageBitmap<"u"&&e instanceof ImageBitmap){const t=fs("canvas");t.width=e.width,t.height=e.height;const n=t.getContext("2d");n.drawImage(e,0,0,e.width,e.height);const r=n.getImageData(0,0,e.width,e.height),s=r.data;for(let a=0;a<s.length;a++)s[a]=Fi(s[a]/255)*255;return n.putImageData(r,0,0),t}else if(e.data){const t=e.data.slice(0);for(let n=0;n<t.length;n++)t instanceof Uint8Array||t instanceof Uint8ClampedArray?t[n]=Math.floor(Fi(t[n]/255)*255):t[n]=Fi(t[n]);return{data:t,width:e.width,height:e.height}}else return console.warn("THREE.ImageUtils.sRGBToLinear(): Unsupported image type. No color space conversion applied."),e}}class Bc{constructor(e=null){this.isSource=!0,this.uuid=Xi(),this.data=e,this.version=0}set needsUpdate(e){e===!0&&this.version++}toJSON(e){const t=e===void 0||typeof e=="string";if(!t&&e.images[this.uuid]!==void 0)return e.images[this.uuid];const n={uuid:this.uuid,url:""},r=this.data;if(r!==null){let s;if(Array.isArray(r)){s=[];for(let a=0,o=r.length;a<o;a++)r[a].isDataTexture?s.push(Ns(r[a].image)):s.push(Ns(r[a]))}else s=Ns(r);n.url=s}return t||(e.images[this.uuid]=n),n}}function Ns(i){return typeof HTMLImageElement<"u"&&i instanceof HTMLImageElement||typeof HTMLCanvasElement<"u"&&i instanceof HTMLCanvasElement||typeof ImageBitmap<"u"&&i instanceof ImageBitmap?Uc.getDataURL(i):i.data?{data:Array.from(i.data),width:i.width,height:i.height,type:i.data.constructor.name}:(console.warn("THREE.Texture: Unable to serialize Texture."),{})}let h_=0;class on extends Wi{constructor(e=on.DEFAULT_IMAGE,t=on.DEFAULT_MAPPING,n=_n,r=_n,s=fn,a=gr,o=gn,l=di,c=on.DEFAULT_ANISOTROPY,u=hi){super(),this.isTexture=!0,Object.defineProperty(this,"id",{value:h_++}),this.uuid=Xi(),this.name="",this.source=new Bc(e),this.mipmaps=[],this.mapping=t,this.wrapS=n,this.wrapT=r,this.magFilter=s,this.minFilter=a,this.anisotropy=c,this.format=o,this.internalFormat=null,this.type=l,this.offset=new st(0,0),this.repeat=new st(1,1),this.center=new st(0,0),this.rotation=0,this.matrixAutoUpdate=!0,this.matrix=new Yt,this.generateMipmaps=!0,this.premultiplyAlpha=!1,this.flipY=!0,this.unpackAlignment=4,this.encoding=u,this.userData={},this.version=0,this.onUpdate=null,this.isRenderTargetTexture=!1,this.needsPMREMUpdate=!1}get image(){return this.source.data}set image(e=null){this.source.data=e}updateMatrix(){this.matrix.setUvTransform(this.offset.x,this.offset.y,this.repeat.x,this.repeat.y,this.rotation,this.center.x,this.center.y)}clone(){return new this.constructor().copy(this)}copy(e){return this.name=e.name,this.source=e.source,this.mipmaps=e.mipmaps.slice(0),this.mapping=e.mapping,this.wrapS=e.wrapS,this.wrapT=e.wrapT,this.magFilter=e.magFilter,this.minFilter=e.minFilter,this.anisotropy=e.anisotropy,this.format=e.format,this.internalFormat=e.internalFormat,this.type=e.type,this.offset.copy(e.offset),this.repeat.copy(e.repeat),this.center.copy(e.center),this.rotation=e.rotation,this.matrixAutoUpdate=e.matrixAutoUpdate,this.matrix.copy(e.matrix),this.generateMipmaps=e.generateMipmaps,this.premultiplyAlpha=e.premultiplyAlpha,this.flipY=e.flipY,this.unpackAlignment=e.unpackAlignment,this.encoding=e.encoding,this.userData=JSON.parse(JSON.stringify(e.userData)),this.needsUpdate=!0,this}toJSON(e){const t=e===void 0||typeof e=="string";if(!t&&e.textures[this.uuid]!==void 0)return e.textures[this.uuid];const n={metadata:{version:4.5,type:"Texture",generator:"Texture.toJSON"},uuid:this.uuid,name:this.name,image:this.source.toJSON(e).uuid,mapping:this.mapping,repeat:[this.repeat.x,this.repeat.y],offset:[this.offset.x,this.offset.y],center:[this.center.x,this.center.y],rotation:this.rotation,wrap:[this.wrapS,this.wrapT],format:this.format,internalFormat:this.internalFormat,type:this.type,encoding:this.encoding,minFilter:this.minFilter,magFilter:this.magFilter,anisotropy:this.anisotropy,flipY:this.flipY,generateMipmaps:this.generateMipmaps,premultiplyAlpha:this.premultiplyAlpha,unpackAlignment:this.unpackAlignment};return Object.keys(this.userData).length>0&&(n.userData=this.userData),t||(e.textures[this.uuid]=n),n}dispose(){this.dispatchEvent({type:"dispose"})}transformUv(e){if(this.mapping!==Ic)return e;if(e.applyMatrix3(this.matrix),e.x<0||e.x>1)switch(this.wrapS){case ua:e.x=e.x-Math.floor(e.x);break;case _n:e.x=e.x<0?0:1;break;case fa:Math.abs(Math.floor(e.x)%2)===1?e.x=Math.ceil(e.x)-e.x:e.x=e.x-Math.floor(e.x);break}if(e.y<0||e.y>1)switch(this.wrapT){case ua:e.y=e.y-Math.floor(e.y);break;case _n:e.y=e.y<0?0:1;break;case fa:Math.abs(Math.floor(e.y)%2)===1?e.y=Math.ceil(e.y)-e.y:e.y=e.y-Math.floor(e.y);break}return this.flipY&&(e.y=1-e.y),e}set needsUpdate(e){e===!0&&(this.version++,this.source.needsUpdate=!0)}}on.DEFAULT_IMAGE=null;on.DEFAULT_MAPPING=Ic;on.DEFAULT_ANISOTROPY=1;class Nt{constructor(e=0,t=0,n=0,r=1){Nt.prototype.isVector4=!0,this.x=e,this.y=t,this.z=n,this.w=r}get width(){return this.z}set width(e){this.z=e}get height(){return this.w}set height(e){this.w=e}set(e,t,n,r){return this.x=e,this.y=t,this.z=n,this.w=r,this}setScalar(e){return this.x=e,this.y=e,this.z=e,this.w=e,this}setX(e){return this.x=e,this}setY(e){return this.y=e,this}setZ(e){return this.z=e,this}setW(e){return this.w=e,this}setComponent(e,t){switch(e){case 0:this.x=t;break;case 1:this.y=t;break;case 2:this.z=t;break;case 3:this.w=t;break;default:throw new Error("index is out of range: "+e)}return this}getComponent(e){switch(e){case 0:return this.x;case 1:return this.y;case 2:return this.z;case 3:return this.w;default:throw new Error("index is out of range: "+e)}}clone(){return new this.constructor(this.x,this.y,this.z,this.w)}copy(e){return this.x=e.x,this.y=e.y,this.z=e.z,this.w=e.w!==void 0?e.w:1,this}add(e){return this.x+=e.x,this.y+=e.y,this.z+=e.z,this.w+=e.w,this}addScalar(e){return this.x+=e,this.y+=e,this.z+=e,this.w+=e,this}addVectors(e,t){return this.x=e.x+t.x,this.y=e.y+t.y,this.z=e.z+t.z,this.w=e.w+t.w,this}addScaledVector(e,t){return this.x+=e.x*t,this.y+=e.y*t,this.z+=e.z*t,this.w+=e.w*t,this}sub(e){return this.x-=e.x,this.y-=e.y,this.z-=e.z,this.w-=e.w,this}subScalar(e){return this.x-=e,this.y-=e,this.z-=e,this.w-=e,this}subVectors(e,t){return this.x=e.x-t.x,this.y=e.y-t.y,this.z=e.z-t.z,this.w=e.w-t.w,this}multiply(e){return this.x*=e.x,this.y*=e.y,this.z*=e.z,this.w*=e.w,this}multiplyScalar(e){return this.x*=e,this.y*=e,this.z*=e,this.w*=e,this}applyMatrix4(e){const t=this.x,n=this.y,r=this.z,s=this.w,a=e.elements;return this.x=a[0]*t+a[4]*n+a[8]*r+a[12]*s,this.y=a[1]*t+a[5]*n+a[9]*r+a[13]*s,this.z=a[2]*t+a[6]*n+a[10]*r+a[14]*s,this.w=a[3]*t+a[7]*n+a[11]*r+a[15]*s,this}divideScalar(e){return this.multiplyScalar(1/e)}setAxisAngleFromQuaternion(e){this.w=2*Math.acos(e.w);const t=Math.sqrt(1-e.w*e.w);return t<1e-4?(this.x=1,this.y=0,this.z=0):(this.x=e.x/t,this.y=e.y/t,this.z=e.z/t),this}setAxisAngleFromRotationMatrix(e){let t,n,r,s;const l=e.elements,c=l[0],u=l[4],f=l[8],d=l[1],p=l[5],m=l[9],h=l[2],_=l[6],g=l[10];if(Math.abs(u-d)<.01&&Math.abs(f-h)<.01&&Math.abs(m-_)<.01){if(Math.abs(u+d)<.1&&Math.abs(f+h)<.1&&Math.abs(m+_)<.1&&Math.abs(c+p+g-3)<.1)return this.set(1,0,0,0),this;t=Math.PI;const b=(c+1)/2,y=(p+1)/2,w=(g+1)/2,M=(u+d)/4,E=(f+h)/4,x=(m+_)/4;return b>y&&b>w?b<.01?(n=0,r=.707106781,s=.707106781):(n=Math.sqrt(b),r=M/n,s=E/n):y>w?y<.01?(n=.707106781,r=0,s=.707106781):(r=Math.sqrt(y),n=M/r,s=x/r):w<.01?(n=.707106781,r=.707106781,s=0):(s=Math.sqrt(w),n=E/s,r=x/s),this.set(n,r,s,t),this}let v=Math.sqrt((_-m)*(_-m)+(f-h)*(f-h)+(d-u)*(d-u));return Math.abs(v)<.001&&(v=1),this.x=(_-m)/v,this.y=(f-h)/v,this.z=(d-u)/v,this.w=Math.acos((c+p+g-1)/2),this}min(e){return this.x=Math.min(this.x,e.x),this.y=Math.min(this.y,e.y),this.z=Math.min(this.z,e.z),this.w=Math.min(this.w,e.w),this}max(e){return this.x=Math.max(this.x,e.x),this.y=Math.max(this.y,e.y),this.z=Math.max(this.z,e.z),this.w=Math.max(this.w,e.w),this}clamp(e,t){return this.x=Math.max(e.x,Math.min(t.x,this.x)),this.y=Math.max(e.y,Math.min(t.y,this.y)),this.z=Math.max(e.z,Math.min(t.z,this.z)),this.w=Math.max(e.w,Math.min(t.w,this.w)),this}clampScalar(e,t){return this.x=Math.max(e,Math.min(t,this.x)),this.y=Math.max(e,Math.min(t,this.y)),this.z=Math.max(e,Math.min(t,this.z)),this.w=Math.max(e,Math.min(t,this.w)),this}clampLength(e,t){const n=this.length();return this.divideScalar(n||1).multiplyScalar(Math.max(e,Math.min(t,n)))}floor(){return this.x=Math.floor(this.x),this.y=Math.floor(this.y),this.z=Math.floor(this.z),this.w=Math.floor(this.w),this}ceil(){return this.x=Math.ceil(this.x),this.y=Math.ceil(this.y),this.z=Math.ceil(this.z),this.w=Math.ceil(this.w),this}round(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this.z=Math.round(this.z),this.w=Math.round(this.w),this}roundToZero(){return this.x=this.x<0?Math.ceil(this.x):Math.floor(this.x),this.y=this.y<0?Math.ceil(this.y):Math.floor(this.y),this.z=this.z<0?Math.ceil(this.z):Math.floor(this.z),this.w=this.w<0?Math.ceil(this.w):Math.floor(this.w),this}negate(){return this.x=-this.x,this.y=-this.y,this.z=-this.z,this.w=-this.w,this}dot(e){return this.x*e.x+this.y*e.y+this.z*e.z+this.w*e.w}lengthSq(){return this.x*this.x+this.y*this.y+this.z*this.z+this.w*this.w}length(){return Math.sqrt(this.x*this.x+this.y*this.y+this.z*this.z+this.w*this.w)}manhattanLength(){return Math.abs(this.x)+Math.abs(this.y)+Math.abs(this.z)+Math.abs(this.w)}normalize(){return this.divideScalar(this.length()||1)}setLength(e){return this.normalize().multiplyScalar(e)}lerp(e,t){return this.x+=(e.x-this.x)*t,this.y+=(e.y-this.y)*t,this.z+=(e.z-this.z)*t,this.w+=(e.w-this.w)*t,this}lerpVectors(e,t,n){return this.x=e.x+(t.x-e.x)*n,this.y=e.y+(t.y-e.y)*n,this.z=e.z+(t.z-e.z)*n,this.w=e.w+(t.w-e.w)*n,this}equals(e){return e.x===this.x&&e.y===this.y&&e.z===this.z&&e.w===this.w}fromArray(e,t=0){return this.x=e[t],this.y=e[t+1],this.z=e[t+2],this.w=e[t+3],this}toArray(e=[],t=0){return e[t]=this.x,e[t+1]=this.y,e[t+2]=this.z,e[t+3]=this.w,e}fromBufferAttribute(e,t){return this.x=e.getX(t),this.y=e.getY(t),this.z=e.getZ(t),this.w=e.getW(t),this}random(){return this.x=Math.random(),this.y=Math.random(),this.z=Math.random(),this.w=Math.random(),this}*[Symbol.iterator](){yield this.x,yield this.y,yield this.z,yield this.w}}class pi extends Wi{constructor(e=1,t=1,n={}){super(),this.isWebGLRenderTarget=!0,this.width=e,this.height=t,this.depth=1,this.scissor=new Nt(0,0,e,t),this.scissorTest=!1,this.viewport=new Nt(0,0,e,t);const r={width:e,height:t,depth:1};this.texture=new on(r,n.mapping,n.wrapS,n.wrapT,n.magFilter,n.minFilter,n.format,n.type,n.anisotropy,n.encoding),this.texture.isRenderTargetTexture=!0,this.texture.flipY=!1,this.texture.generateMipmaps=n.generateMipmaps!==void 0?n.generateMipmaps:!1,this.texture.internalFormat=n.internalFormat!==void 0?n.internalFormat:null,this.texture.minFilter=n.minFilter!==void 0?n.minFilter:fn,this.depthBuffer=n.depthBuffer!==void 0?n.depthBuffer:!0,this.stencilBuffer=n.stencilBuffer!==void 0?n.stencilBuffer:!1,this.depthTexture=n.depthTexture!==void 0?n.depthTexture:null,this.samples=n.samples!==void 0?n.samples:0}setSize(e,t,n=1){(this.width!==e||this.height!==t||this.depth!==n)&&(this.width=e,this.height=t,this.depth=n,this.texture.image.width=e,this.texture.image.height=t,this.texture.image.depth=n,this.dispose()),this.viewport.set(0,0,e,t),this.scissor.set(0,0,e,t)}clone(){return new this.constructor().copy(this)}copy(e){this.width=e.width,this.height=e.height,this.depth=e.depth,this.viewport.copy(e.viewport),this.texture=e.texture.clone(),this.texture.isRenderTargetTexture=!0;const t=Object.assign({},e.texture.image);return this.texture.source=new Bc(t),this.depthBuffer=e.depthBuffer,this.stencilBuffer=e.stencilBuffer,e.depthTexture!==null&&(this.depthTexture=e.depthTexture.clone()),this.samples=e.samples,this}dispose(){this.dispatchEvent({type:"dispose"})}}class Vc extends on{constructor(e=null,t=1,n=1,r=1){super(null),this.isDataArrayTexture=!0,this.image={data:e,width:t,height:n,depth:r},this.magFilter=jt,this.minFilter=jt,this.wrapR=_n,this.generateMipmaps=!1,this.flipY=!1,this.unpackAlignment=1}}class p_ extends on{constructor(e=null,t=1,n=1,r=1){super(null),this.isData3DTexture=!0,this.image={data:e,width:t,height:n,depth:r},this.magFilter=jt,this.minFilter=jt,this.wrapR=_n,this.generateMipmaps=!1,this.flipY=!1,this.unpackAlignment=1}}class Sr{constructor(e=new B(1/0,1/0,1/0),t=new B(-1/0,-1/0,-1/0)){this.isBox3=!0,this.min=e,this.max=t}set(e,t){return this.min.copy(e),this.max.copy(t),this}setFromArray(e){let t=1/0,n=1/0,r=1/0,s=-1/0,a=-1/0,o=-1/0;for(let l=0,c=e.length;l<c;l+=3){const u=e[l],f=e[l+1],d=e[l+2];u<t&&(t=u),f<n&&(n=f),d<r&&(r=d),u>s&&(s=u),f>a&&(a=f),d>o&&(o=d)}return this.min.set(t,n,r),this.max.set(s,a,o),this}setFromBufferAttribute(e){let t=1/0,n=1/0,r=1/0,s=-1/0,a=-1/0,o=-1/0;for(let l=0,c=e.count;l<c;l++){const u=e.getX(l),f=e.getY(l),d=e.getZ(l);u<t&&(t=u),f<n&&(n=f),d<r&&(r=d),u>s&&(s=u),f>a&&(a=f),d>o&&(o=d)}return this.min.set(t,n,r),this.max.set(s,a,o),this}setFromPoints(e){this.makeEmpty();for(let t=0,n=e.length;t<n;t++)this.expandByPoint(e[t]);return this}setFromCenterAndSize(e,t){const n=$n.copy(t).multiplyScalar(.5);return this.min.copy(e).sub(n),this.max.copy(e).add(n),this}setFromObject(e,t=!1){return this.makeEmpty(),this.expandByObject(e,t)}clone(){return new this.constructor().copy(this)}copy(e){return this.min.copy(e.min),this.max.copy(e.max),this}makeEmpty(){return this.min.x=this.min.y=this.min.z=1/0,this.max.x=this.max.y=this.max.z=-1/0,this}isEmpty(){return this.max.x<this.min.x||this.max.y<this.min.y||this.max.z<this.min.z}getCenter(e){return this.isEmpty()?e.set(0,0,0):e.addVectors(this.min,this.max).multiplyScalar(.5)}getSize(e){return this.isEmpty()?e.set(0,0,0):e.subVectors(this.max,this.min)}expandByPoint(e){return this.min.min(e),this.max.max(e),this}expandByVector(e){return this.min.sub(e),this.max.add(e),this}expandByScalar(e){return this.min.addScalar(-e),this.max.addScalar(e),this}expandByObject(e,t=!1){e.updateWorldMatrix(!1,!1);const n=e.geometry;if(n!==void 0)if(t&&n.attributes!=null&&n.attributes.position!==void 0){const s=n.attributes.position;for(let a=0,o=s.count;a<o;a++)$n.fromBufferAttribute(s,a).applyMatrix4(e.matrixWorld),this.expandByPoint($n)}else n.boundingBox===null&&n.computeBoundingBox(),zs.copy(n.boundingBox),zs.applyMatrix4(e.matrixWorld),this.union(zs);const r=e.children;for(let s=0,a=r.length;s<a;s++)this.expandByObject(r[s],t);return this}containsPoint(e){return!(e.x<this.min.x||e.x>this.max.x||e.y<this.min.y||e.y>this.max.y||e.z<this.min.z||e.z>this.max.z)}containsBox(e){return this.min.x<=e.min.x&&e.max.x<=this.max.x&&this.min.y<=e.min.y&&e.max.y<=this.max.y&&this.min.z<=e.min.z&&e.max.z<=this.max.z}getParameter(e,t){return t.set((e.x-this.min.x)/(this.max.x-this.min.x),(e.y-this.min.y)/(this.max.y-this.min.y),(e.z-this.min.z)/(this.max.z-this.min.z))}intersectsBox(e){return!(e.max.x<this.min.x||e.min.x>this.max.x||e.max.y<this.min.y||e.min.y>this.max.y||e.max.z<this.min.z||e.min.z>this.max.z)}intersectsSphere(e){return this.clampPoint(e.center,$n),$n.distanceToSquared(e.center)<=e.radius*e.radius}intersectsPlane(e){let t,n;return e.normal.x>0?(t=e.normal.x*this.min.x,n=e.normal.x*this.max.x):(t=e.normal.x*this.max.x,n=e.normal.x*this.min.x),e.normal.y>0?(t+=e.normal.y*this.min.y,n+=e.normal.y*this.max.y):(t+=e.normal.y*this.max.y,n+=e.normal.y*this.min.y),e.normal.z>0?(t+=e.normal.z*this.min.z,n+=e.normal.z*this.max.z):(t+=e.normal.z*this.max.z,n+=e.normal.z*this.min.z),t<=-e.constant&&n>=-e.constant}intersectsTriangle(e){if(this.isEmpty())return!1;this.getCenter(Zi),Pr.subVectors(this.max,Zi),bi.subVectors(e.a,Zi),vi.subVectors(e.b,Zi),yi.subVectors(e.c,Zi),Vn.subVectors(vi,bi),Gn.subVectors(yi,vi),ei.subVectors(bi,yi);let t=[0,-Vn.z,Vn.y,0,-Gn.z,Gn.y,0,-ei.z,ei.y,Vn.z,0,-Vn.x,Gn.z,0,-Gn.x,ei.z,0,-ei.x,-Vn.y,Vn.x,0,-Gn.y,Gn.x,0,-ei.y,ei.x,0];return!Fs(t,bi,vi,yi,Pr)||(t=[1,0,0,0,1,0,0,0,1],!Fs(t,bi,vi,yi,Pr))?!1:(Ar.crossVectors(Vn,Gn),t=[Ar.x,Ar.y,Ar.z],Fs(t,bi,vi,yi,Pr))}clampPoint(e,t){return t.copy(e).clamp(this.min,this.max)}distanceToPoint(e){return this.clampPoint(e,$n).distanceTo(e)}getBoundingSphere(e){return this.isEmpty()?e.makeEmpty():(this.getCenter(e.center),e.radius=this.getSize($n).length()*.5),e}intersect(e){return this.min.max(e.min),this.max.min(e.max),this.isEmpty()&&this.makeEmpty(),this}union(e){return this.min.min(e.min),this.max.max(e.max),this}applyMatrix4(e){return this.isEmpty()?this:(Pn[0].set(this.min.x,this.min.y,this.min.z).applyMatrix4(e),Pn[1].set(this.min.x,this.min.y,this.max.z).applyMatrix4(e),Pn[2].set(this.min.x,this.max.y,this.min.z).applyMatrix4(e),Pn[3].set(this.min.x,this.max.y,this.max.z).applyMatrix4(e),Pn[4].set(this.max.x,this.min.y,this.min.z).applyMatrix4(e),Pn[5].set(this.max.x,this.min.y,this.max.z).applyMatrix4(e),Pn[6].set(this.max.x,this.max.y,this.min.z).applyMatrix4(e),Pn[7].set(this.max.x,this.max.y,this.max.z).applyMatrix4(e),this.setFromPoints(Pn),this)}translate(e){return this.min.add(e),this.max.add(e),this}equals(e){return e.min.equals(this.min)&&e.max.equals(this.max)}}const Pn=[new B,new B,new B,new B,new B,new B,new B,new B],$n=new B,zs=new Sr,bi=new B,vi=new B,yi=new B,Vn=new B,Gn=new B,ei=new B,Zi=new B,Pr=new B,Ar=new B,ti=new B;function Fs(i,e,t,n,r){for(let s=0,a=i.length-3;s<=a;s+=3){ti.fromArray(i,s);const o=r.x*Math.abs(ti.x)+r.y*Math.abs(ti.y)+r.z*Math.abs(ti.z),l=e.dot(ti),c=t.dot(ti),u=n.dot(ti);if(Math.max(-Math.max(l,c,u),Math.min(l,c,u))>o)return!1}return!0}const m_=new Sr,Ki=new B,Os=new B;class ms{constructor(e=new B,t=-1){this.center=e,this.radius=t}set(e,t){return this.center.copy(e),this.radius=t,this}setFromPoints(e,t){const n=this.center;t!==void 0?n.copy(t):m_.setFromPoints(e).getCenter(n);let r=0;for(let s=0,a=e.length;s<a;s++)r=Math.max(r,n.distanceToSquared(e[s]));return this.radius=Math.sqrt(r),this}copy(e){return this.center.copy(e.center),this.radius=e.radius,this}isEmpty(){return this.radius<0}makeEmpty(){return this.center.set(0,0,0),this.radius=-1,this}containsPoint(e){return e.distanceToSquared(this.center)<=this.radius*this.radius}distanceToPoint(e){return e.distanceTo(this.center)-this.radius}intersectsSphere(e){const t=this.radius+e.radius;return e.center.distanceToSquared(this.center)<=t*t}intersectsBox(e){return e.intersectsSphere(this)}intersectsPlane(e){return Math.abs(e.distanceToPoint(this.center))<=this.radius}clampPoint(e,t){const n=this.center.distanceToSquared(e);return t.copy(e),n>this.radius*this.radius&&(t.sub(this.center).normalize(),t.multiplyScalar(this.radius).add(this.center)),t}getBoundingBox(e){return this.isEmpty()?(e.makeEmpty(),e):(e.set(this.center,this.center),e.expandByScalar(this.radius),e)}applyMatrix4(e){return this.center.applyMatrix4(e),this.radius=this.radius*e.getMaxScaleOnAxis(),this}translate(e){return this.center.add(e),this}expandByPoint(e){if(this.isEmpty())return this.center.copy(e),this.radius=0,this;Ki.subVectors(e,this.center);const t=Ki.lengthSq();if(t>this.radius*this.radius){const n=Math.sqrt(t),r=(n-this.radius)*.5;this.center.addScaledVector(Ki,r/n),this.radius+=r}return this}union(e){return e.isEmpty()?this:this.isEmpty()?(this.copy(e),this):(this.center.equals(e.center)===!0?this.radius=Math.max(this.radius,e.radius):(Os.subVectors(e.center,this.center).setLength(e.radius),this.expandByPoint(Ki.copy(e.center).add(Os)),this.expandByPoint(Ki.copy(e.center).sub(Os))),this)}equals(e){return e.center.equals(this.center)&&e.radius===this.radius}clone(){return new this.constructor().copy(this)}}const An=new B,Us=new B,Dr=new B,Hn=new B,Bs=new B,Rr=new B,Vs=new B;class xa{constructor(e=new B,t=new B(0,0,-1)){this.origin=e,this.direction=t}set(e,t){return this.origin.copy(e),this.direction.copy(t),this}copy(e){return this.origin.copy(e.origin),this.direction.copy(e.direction),this}at(e,t){return t.copy(this.origin).addScaledVector(this.direction,e)}lookAt(e){return this.direction.copy(e).sub(this.origin).normalize(),this}recast(e){return this.origin.copy(this.at(e,An)),this}closestPointToPoint(e,t){t.subVectors(e,this.origin);const n=t.dot(this.direction);return n<0?t.copy(this.origin):t.copy(this.origin).addScaledVector(this.direction,n)}distanceToPoint(e){return Math.sqrt(this.distanceSqToPoint(e))}distanceSqToPoint(e){const t=An.subVectors(e,this.origin).dot(this.direction);return t<0?this.origin.distanceToSquared(e):(An.copy(this.origin).addScaledVector(this.direction,t),An.distanceToSquared(e))}distanceSqToSegment(e,t,n,r){Us.copy(e).add(t).multiplyScalar(.5),Dr.copy(t).sub(e).normalize(),Hn.copy(this.origin).sub(Us);const s=e.distanceTo(t)*.5,a=-this.direction.dot(Dr),o=Hn.dot(this.direction),l=-Hn.dot(Dr),c=Hn.lengthSq(),u=Math.abs(1-a*a);let f,d,p,m;if(u>0)if(f=a*l-o,d=a*o-l,m=s*u,f>=0)if(d>=-m)if(d<=m){const h=1/u;f*=h,d*=h,p=f*(f+a*d+2*o)+d*(a*f+d+2*l)+c}else d=s,f=Math.max(0,-(a*d+o)),p=-f*f+d*(d+2*l)+c;else d=-s,f=Math.max(0,-(a*d+o)),p=-f*f+d*(d+2*l)+c;else d<=-m?(f=Math.max(0,-(-a*s+o)),d=f>0?-s:Math.min(Math.max(-s,-l),s),p=-f*f+d*(d+2*l)+c):d<=m?(f=0,d=Math.min(Math.max(-s,-l),s),p=d*(d+2*l)+c):(f=Math.max(0,-(a*s+o)),d=f>0?s:Math.min(Math.max(-s,-l),s),p=-f*f+d*(d+2*l)+c);else d=a>0?-s:s,f=Math.max(0,-(a*d+o)),p=-f*f+d*(d+2*l)+c;return n&&n.copy(this.origin).addScaledVector(this.direction,f),r&&r.copy(Us).addScaledVector(Dr,d),p}intersectSphere(e,t){An.subVectors(e.center,this.origin);const n=An.dot(this.direction),r=An.dot(An)-n*n,s=e.radius*e.radius;if(r>s)return null;const a=Math.sqrt(s-r),o=n-a,l=n+a;return l<0?null:o<0?this.at(l,t):this.at(o,t)}intersectsSphere(e){return this.distanceSqToPoint(e.center)<=e.radius*e.radius}distanceToPlane(e){const t=e.normal.dot(this.direction);if(t===0)return e.distanceToPoint(this.origin)===0?0:null;const n=-(this.origin.dot(e.normal)+e.constant)/t;return n>=0?n:null}intersectPlane(e,t){const n=this.distanceToPlane(e);return n===null?null:this.at(n,t)}intersectsPlane(e){const t=e.distanceToPoint(this.origin);return t===0||e.normal.dot(this.direction)*t<0}intersectBox(e,t){let n,r,s,a,o,l;const c=1/this.direction.x,u=1/this.direction.y,f=1/this.direction.z,d=this.origin;return c>=0?(n=(e.min.x-d.x)*c,r=(e.max.x-d.x)*c):(n=(e.max.x-d.x)*c,r=(e.min.x-d.x)*c),u>=0?(s=(e.min.y-d.y)*u,a=(e.max.y-d.y)*u):(s=(e.max.y-d.y)*u,a=(e.min.y-d.y)*u),n>a||s>r||((s>n||isNaN(n))&&(n=s),(a<r||isNaN(r))&&(r=a),f>=0?(o=(e.min.z-d.z)*f,l=(e.max.z-d.z)*f):(o=(e.max.z-d.z)*f,l=(e.min.z-d.z)*f),n>l||o>r)||((o>n||n!==n)&&(n=o),(l<r||r!==r)&&(r=l),r<0)?null:this.at(n>=0?n:r,t)}intersectsBox(e){return this.intersectBox(e,An)!==null}intersectTriangle(e,t,n,r,s){Bs.subVectors(t,e),Rr.subVectors(n,e),Vs.crossVectors(Bs,Rr);let a=this.direction.dot(Vs),o;if(a>0){if(r)return null;o=1}else if(a<0)o=-1,a=-a;else return null;Hn.subVectors(this.origin,e);const l=o*this.direction.dot(Rr.crossVectors(Hn,Rr));if(l<0)return null;const c=o*this.direction.dot(Bs.cross(Hn));if(c<0||l+c>a)return null;const u=-o*Hn.dot(Vs);return u<0?null:this.at(u/a,s)}applyMatrix4(e){return this.origin.applyMatrix4(e),this.direction.transformDirection(e),this}equals(e){return e.origin.equals(this.origin)&&e.direction.equals(this.direction)}clone(){return new this.constructor().copy(this)}}class Tt{constructor(){Tt.prototype.isMatrix4=!0,this.elements=[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]}set(e,t,n,r,s,a,o,l,c,u,f,d,p,m,h,_){const g=this.elements;return g[0]=e,g[4]=t,g[8]=n,g[12]=r,g[1]=s,g[5]=a,g[9]=o,g[13]=l,g[2]=c,g[6]=u,g[10]=f,g[14]=d,g[3]=p,g[7]=m,g[11]=h,g[15]=_,this}identity(){return this.set(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1),this}clone(){return new Tt().fromArray(this.elements)}copy(e){const t=this.elements,n=e.elements;return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t[4]=n[4],t[5]=n[5],t[6]=n[6],t[7]=n[7],t[8]=n[8],t[9]=n[9],t[10]=n[10],t[11]=n[11],t[12]=n[12],t[13]=n[13],t[14]=n[14],t[15]=n[15],this}copyPosition(e){const t=this.elements,n=e.elements;return t[12]=n[12],t[13]=n[13],t[14]=n[14],this}setFromMatrix3(e){const t=e.elements;return this.set(t[0],t[3],t[6],0,t[1],t[4],t[7],0,t[2],t[5],t[8],0,0,0,0,1),this}extractBasis(e,t,n){return e.setFromMatrixColumn(this,0),t.setFromMatrixColumn(this,1),n.setFromMatrixColumn(this,2),this}makeBasis(e,t,n){return this.set(e.x,t.x,n.x,0,e.y,t.y,n.y,0,e.z,t.z,n.z,0,0,0,0,1),this}extractRotation(e){const t=this.elements,n=e.elements,r=1/wi.setFromMatrixColumn(e,0).length(),s=1/wi.setFromMatrixColumn(e,1).length(),a=1/wi.setFromMatrixColumn(e,2).length();return t[0]=n[0]*r,t[1]=n[1]*r,t[2]=n[2]*r,t[3]=0,t[4]=n[4]*s,t[5]=n[5]*s,t[6]=n[6]*s,t[7]=0,t[8]=n[8]*a,t[9]=n[9]*a,t[10]=n[10]*a,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,this}makeRotationFromEuler(e){const t=this.elements,n=e.x,r=e.y,s=e.z,a=Math.cos(n),o=Math.sin(n),l=Math.cos(r),c=Math.sin(r),u=Math.cos(s),f=Math.sin(s);if(e.order==="XYZ"){const d=a*u,p=a*f,m=o*u,h=o*f;t[0]=l*u,t[4]=-l*f,t[8]=c,t[1]=p+m*c,t[5]=d-h*c,t[9]=-o*l,t[2]=h-d*c,t[6]=m+p*c,t[10]=a*l}else if(e.order==="YXZ"){const d=l*u,p=l*f,m=c*u,h=c*f;t[0]=d+h*o,t[4]=m*o-p,t[8]=a*c,t[1]=a*f,t[5]=a*u,t[9]=-o,t[2]=p*o-m,t[6]=h+d*o,t[10]=a*l}else if(e.order==="ZXY"){const d=l*u,p=l*f,m=c*u,h=c*f;t[0]=d-h*o,t[4]=-a*f,t[8]=m+p*o,t[1]=p+m*o,t[5]=a*u,t[9]=h-d*o,t[2]=-a*c,t[6]=o,t[10]=a*l}else if(e.order==="ZYX"){const d=a*u,p=a*f,m=o*u,h=o*f;t[0]=l*u,t[4]=m*c-p,t[8]=d*c+h,t[1]=l*f,t[5]=h*c+d,t[9]=p*c-m,t[2]=-c,t[6]=o*l,t[10]=a*l}else if(e.order==="YZX"){const d=a*l,p=a*c,m=o*l,h=o*c;t[0]=l*u,t[4]=h-d*f,t[8]=m*f+p,t[1]=f,t[5]=a*u,t[9]=-o*u,t[2]=-c*u,t[6]=p*f+m,t[10]=d-h*f}else if(e.order==="XZY"){const d=a*l,p=a*c,m=o*l,h=o*c;t[0]=l*u,t[4]=-f,t[8]=c*u,t[1]=d*f+h,t[5]=a*u,t[9]=p*f-m,t[2]=m*f-p,t[6]=o*u,t[10]=h*f+d}return t[3]=0,t[7]=0,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,this}makeRotationFromQuaternion(e){return this.compose(__,e,g_)}lookAt(e,t,n){const r=this.elements;return rn.subVectors(e,t),rn.lengthSq()===0&&(rn.z=1),rn.normalize(),Wn.crossVectors(n,rn),Wn.lengthSq()===0&&(Math.abs(n.z)===1?rn.x+=1e-4:rn.z+=1e-4,rn.normalize(),Wn.crossVectors(n,rn)),Wn.normalize(),kr.crossVectors(rn,Wn),r[0]=Wn.x,r[4]=kr.x,r[8]=rn.x,r[1]=Wn.y,r[5]=kr.y,r[9]=rn.y,r[2]=Wn.z,r[6]=kr.z,r[10]=rn.z,this}multiply(e){return this.multiplyMatrices(this,e)}premultiply(e){return this.multiplyMatrices(e,this)}multiplyMatrices(e,t){const n=e.elements,r=t.elements,s=this.elements,a=n[0],o=n[4],l=n[8],c=n[12],u=n[1],f=n[5],d=n[9],p=n[13],m=n[2],h=n[6],_=n[10],g=n[14],v=n[3],b=n[7],y=n[11],w=n[15],M=r[0],E=r[4],x=r[8],C=r[12],A=r[1],D=r[5],G=r[9],U=r[13],z=r[2],X=r[6],ae=r[10],le=r[14],$=r[3],ne=r[7],ue=r[11],be=r[15];return s[0]=a*M+o*A+l*z+c*$,s[4]=a*E+o*D+l*X+c*ne,s[8]=a*x+o*G+l*ae+c*ue,s[12]=a*C+o*U+l*le+c*be,s[1]=u*M+f*A+d*z+p*$,s[5]=u*E+f*D+d*X+p*ne,s[9]=u*x+f*G+d*ae+p*ue,s[13]=u*C+f*U+d*le+p*be,s[2]=m*M+h*A+_*z+g*$,s[6]=m*E+h*D+_*X+g*ne,s[10]=m*x+h*G+_*ae+g*ue,s[14]=m*C+h*U+_*le+g*be,s[3]=v*M+b*A+y*z+w*$,s[7]=v*E+b*D+y*X+w*ne,s[11]=v*x+b*G+y*ae+w*ue,s[15]=v*C+b*U+y*le+w*be,this}multiplyScalar(e){const t=this.elements;return t[0]*=e,t[4]*=e,t[8]*=e,t[12]*=e,t[1]*=e,t[5]*=e,t[9]*=e,t[13]*=e,t[2]*=e,t[6]*=e,t[10]*=e,t[14]*=e,t[3]*=e,t[7]*=e,t[11]*=e,t[15]*=e,this}determinant(){const e=this.elements,t=e[0],n=e[4],r=e[8],s=e[12],a=e[1],o=e[5],l=e[9],c=e[13],u=e[2],f=e[6],d=e[10],p=e[14],m=e[3],h=e[7],_=e[11],g=e[15];return m*(+s*l*f-r*c*f-s*o*d+n*c*d+r*o*p-n*l*p)+h*(+t*l*p-t*c*d+s*a*d-r*a*p+r*c*u-s*l*u)+_*(+t*c*f-t*o*p-s*a*f+n*a*p+s*o*u-n*c*u)+g*(-r*o*u-t*l*f+t*o*d+r*a*f-n*a*d+n*l*u)}transpose(){const e=this.elements;let t;return t=e[1],e[1]=e[4],e[4]=t,t=e[2],e[2]=e[8],e[8]=t,t=e[6],e[6]=e[9],e[9]=t,t=e[3],e[3]=e[12],e[12]=t,t=e[7],e[7]=e[13],e[13]=t,t=e[11],e[11]=e[14],e[14]=t,this}setPosition(e,t,n){const r=this.elements;return e.isVector3?(r[12]=e.x,r[13]=e.y,r[14]=e.z):(r[12]=e,r[13]=t,r[14]=n),this}invert(){const e=this.elements,t=e[0],n=e[1],r=e[2],s=e[3],a=e[4],o=e[5],l=e[6],c=e[7],u=e[8],f=e[9],d=e[10],p=e[11],m=e[12],h=e[13],_=e[14],g=e[15],v=f*_*c-h*d*c+h*l*p-o*_*p-f*l*g+o*d*g,b=m*d*c-u*_*c-m*l*p+a*_*p+u*l*g-a*d*g,y=u*h*c-m*f*c+m*o*p-a*h*p-u*o*g+a*f*g,w=m*f*l-u*h*l-m*o*d+a*h*d+u*o*_-a*f*_,M=t*v+n*b+r*y+s*w;if(M===0)return this.set(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);const E=1/M;return e[0]=v*E,e[1]=(h*d*s-f*_*s-h*r*p+n*_*p+f*r*g-n*d*g)*E,e[2]=(o*_*s-h*l*s+h*r*c-n*_*c-o*r*g+n*l*g)*E,e[3]=(f*l*s-o*d*s-f*r*c+n*d*c+o*r*p-n*l*p)*E,e[4]=b*E,e[5]=(u*_*s-m*d*s+m*r*p-t*_*p-u*r*g+t*d*g)*E,e[6]=(m*l*s-a*_*s-m*r*c+t*_*c+a*r*g-t*l*g)*E,e[7]=(a*d*s-u*l*s+u*r*c-t*d*c-a*r*p+t*l*p)*E,e[8]=y*E,e[9]=(m*f*s-u*h*s-m*n*p+t*h*p+u*n*g-t*f*g)*E,e[10]=(a*h*s-m*o*s+m*n*c-t*h*c-a*n*g+t*o*g)*E,e[11]=(u*o*s-a*f*s-u*n*c+t*f*c+a*n*p-t*o*p)*E,e[12]=w*E,e[13]=(u*h*r-m*f*r+m*n*d-t*h*d-u*n*_+t*f*_)*E,e[14]=(m*o*r-a*h*r-m*n*l+t*h*l+a*n*_-t*o*_)*E,e[15]=(a*f*r-u*o*r+u*n*l-t*f*l-a*n*d+t*o*d)*E,this}scale(e){const t=this.elements,n=e.x,r=e.y,s=e.z;return t[0]*=n,t[4]*=r,t[8]*=s,t[1]*=n,t[5]*=r,t[9]*=s,t[2]*=n,t[6]*=r,t[10]*=s,t[3]*=n,t[7]*=r,t[11]*=s,this}getMaxScaleOnAxis(){const e=this.elements,t=e[0]*e[0]+e[1]*e[1]+e[2]*e[2],n=e[4]*e[4]+e[5]*e[5]+e[6]*e[6],r=e[8]*e[8]+e[9]*e[9]+e[10]*e[10];return Math.sqrt(Math.max(t,n,r))}makeTranslation(e,t,n){return this.set(1,0,0,e,0,1,0,t,0,0,1,n,0,0,0,1),this}makeRotationX(e){const t=Math.cos(e),n=Math.sin(e);return this.set(1,0,0,0,0,t,-n,0,0,n,t,0,0,0,0,1),this}makeRotationY(e){const t=Math.cos(e),n=Math.sin(e);return this.set(t,0,n,0,0,1,0,0,-n,0,t,0,0,0,0,1),this}makeRotationZ(e){const t=Math.cos(e),n=Math.sin(e);return this.set(t,-n,0,0,n,t,0,0,0,0,1,0,0,0,0,1),this}makeRotationAxis(e,t){const n=Math.cos(t),r=Math.sin(t),s=1-n,a=e.x,o=e.y,l=e.z,c=s*a,u=s*o;return this.set(c*a+n,c*o-r*l,c*l+r*o,0,c*o+r*l,u*o+n,u*l-r*a,0,c*l-r*o,u*l+r*a,s*l*l+n,0,0,0,0,1),this}makeScale(e,t,n){return this.set(e,0,0,0,0,t,0,0,0,0,n,0,0,0,0,1),this}makeShear(e,t,n,r,s,a){return this.set(1,n,s,0,e,1,a,0,t,r,1,0,0,0,0,1),this}compose(e,t,n){const r=this.elements,s=t._x,a=t._y,o=t._z,l=t._w,c=s+s,u=a+a,f=o+o,d=s*c,p=s*u,m=s*f,h=a*u,_=a*f,g=o*f,v=l*c,b=l*u,y=l*f,w=n.x,M=n.y,E=n.z;return r[0]=(1-(h+g))*w,r[1]=(p+y)*w,r[2]=(m-b)*w,r[3]=0,r[4]=(p-y)*M,r[5]=(1-(d+g))*M,r[6]=(_+v)*M,r[7]=0,r[8]=(m+b)*E,r[9]=(_-v)*E,r[10]=(1-(d+h))*E,r[11]=0,r[12]=e.x,r[13]=e.y,r[14]=e.z,r[15]=1,this}decompose(e,t,n){const r=this.elements;let s=wi.set(r[0],r[1],r[2]).length();const a=wi.set(r[4],r[5],r[6]).length(),o=wi.set(r[8],r[9],r[10]).length();this.determinant()<0&&(s=-s),e.x=r[12],e.y=r[13],e.z=r[14],hn.copy(this);const c=1/s,u=1/a,f=1/o;return hn.elements[0]*=c,hn.elements[1]*=c,hn.elements[2]*=c,hn.elements[4]*=u,hn.elements[5]*=u,hn.elements[6]*=u,hn.elements[8]*=f,hn.elements[9]*=f,hn.elements[10]*=f,t.setFromRotationMatrix(hn),n.x=s,n.y=a,n.z=o,this}makePerspective(e,t,n,r,s,a){const o=this.elements,l=2*s/(t-e),c=2*s/(n-r),u=(t+e)/(t-e),f=(n+r)/(n-r),d=-(a+s)/(a-s),p=-2*a*s/(a-s);return o[0]=l,o[4]=0,o[8]=u,o[12]=0,o[1]=0,o[5]=c,o[9]=f,o[13]=0,o[2]=0,o[6]=0,o[10]=d,o[14]=p,o[3]=0,o[7]=0,o[11]=-1,o[15]=0,this}makeOrthographic(e,t,n,r,s,a){const o=this.elements,l=1/(t-e),c=1/(n-r),u=1/(a-s),f=(t+e)*l,d=(n+r)*c,p=(a+s)*u;return o[0]=2*l,o[4]=0,o[8]=0,o[12]=-f,o[1]=0,o[5]=2*c,o[9]=0,o[13]=-d,o[2]=0,o[6]=0,o[10]=-2*u,o[14]=-p,o[3]=0,o[7]=0,o[11]=0,o[15]=1,this}equals(e){const t=this.elements,n=e.elements;for(let r=0;r<16;r++)if(t[r]!==n[r])return!1;return!0}fromArray(e,t=0){for(let n=0;n<16;n++)this.elements[n]=e[n+t];return this}toArray(e=[],t=0){const n=this.elements;return e[t]=n[0],e[t+1]=n[1],e[t+2]=n[2],e[t+3]=n[3],e[t+4]=n[4],e[t+5]=n[5],e[t+6]=n[6],e[t+7]=n[7],e[t+8]=n[8],e[t+9]=n[9],e[t+10]=n[10],e[t+11]=n[11],e[t+12]=n[12],e[t+13]=n[13],e[t+14]=n[14],e[t+15]=n[15],e}}const wi=new B,hn=new Tt,__=new B(0,0,0),g_=new B(1,1,1),Wn=new B,kr=new B,rn=new B,Cl=new Tt,Tl=new qt;class Cr{constructor(e=0,t=0,n=0,r=Cr.DEFAULT_ORDER){this.isEuler=!0,this._x=e,this._y=t,this._z=n,this._order=r}get x(){return this._x}set x(e){this._x=e,this._onChangeCallback()}get y(){return this._y}set y(e){this._y=e,this._onChangeCallback()}get z(){return this._z}set z(e){this._z=e,this._onChangeCallback()}get order(){return this._order}set order(e){this._order=e,this._onChangeCallback()}set(e,t,n,r=this._order){return this._x=e,this._y=t,this._z=n,this._order=r,this._onChangeCallback(),this}clone(){return new this.constructor(this._x,this._y,this._z,this._order)}copy(e){return this._x=e._x,this._y=e._y,this._z=e._z,this._order=e._order,this._onChangeCallback(),this}setFromRotationMatrix(e,t=this._order,n=!0){const r=e.elements,s=r[0],a=r[4],o=r[8],l=r[1],c=r[5],u=r[9],f=r[2],d=r[6],p=r[10];switch(t){case"XYZ":this._y=Math.asin(Qt(o,-1,1)),Math.abs(o)<.9999999?(this._x=Math.atan2(-u,p),this._z=Math.atan2(-a,s)):(this._x=Math.atan2(d,c),this._z=0);break;case"YXZ":this._x=Math.asin(-Qt(u,-1,1)),Math.abs(u)<.9999999?(this._y=Math.atan2(o,p),this._z=Math.atan2(l,c)):(this._y=Math.atan2(-f,s),this._z=0);break;case"ZXY":this._x=Math.asin(Qt(d,-1,1)),Math.abs(d)<.9999999?(this._y=Math.atan2(-f,p),this._z=Math.atan2(-a,c)):(this._y=0,this._z=Math.atan2(l,s));break;case"ZYX":this._y=Math.asin(-Qt(f,-1,1)),Math.abs(f)<.9999999?(this._x=Math.atan2(d,p),this._z=Math.atan2(l,s)):(this._x=0,this._z=Math.atan2(-a,c));break;case"YZX":this._z=Math.asin(Qt(l,-1,1)),Math.abs(l)<.9999999?(this._x=Math.atan2(-u,c),this._y=Math.atan2(-f,s)):(this._x=0,this._y=Math.atan2(o,p));break;case"XZY":this._z=Math.asin(-Qt(a,-1,1)),Math.abs(a)<.9999999?(this._x=Math.atan2(d,c),this._y=Math.atan2(o,s)):(this._x=Math.atan2(-u,p),this._y=0);break;default:console.warn("THREE.Euler: .setFromRotationMatrix() encountered an unknown order: "+t)}return this._order=t,n===!0&&this._onChangeCallback(),this}setFromQuaternion(e,t,n){return Cl.makeRotationFromQuaternion(e),this.setFromRotationMatrix(Cl,t,n)}setFromVector3(e,t=this._order){return this.set(e.x,e.y,e.z,t)}reorder(e){return Tl.setFromEuler(this),this.setFromQuaternion(Tl,e)}equals(e){return e._x===this._x&&e._y===this._y&&e._z===this._z&&e._order===this._order}fromArray(e){return this._x=e[0],this._y=e[1],this._z=e[2],e[3]!==void 0&&(this._order=e[3]),this._onChangeCallback(),this}toArray(e=[],t=0){return e[t]=this._x,e[t+1]=this._y,e[t+2]=this._z,e[t+3]=this._order,e}_onChange(e){return this._onChangeCallback=e,this}_onChangeCallback(){}*[Symbol.iterator](){yield this._x,yield this._y,yield this._z,yield this._order}}Cr.DEFAULT_ORDER="XYZ";class Ma{constructor(){this.mask=1}set(e){this.mask=(1<<e|0)>>>0}enable(e){this.mask|=1<<e|0}enableAll(){this.mask=-1}toggle(e){this.mask^=1<<e|0}disable(e){this.mask&=~(1<<e|0)}disableAll(){this.mask=0}test(e){return(this.mask&e.mask)!==0}isEnabled(e){return(this.mask&(1<<e|0))!==0}}let b_=0;const El=new B,xi=new qt,Dn=new Tt,Ir=new B,Ji=new B,v_=new B,y_=new qt,Ll=new B(1,0,0),Pl=new B(0,1,0),Al=new B(0,0,1),w_={type:"added"},Dl={type:"removed"};class zt extends Wi{constructor(){super(),this.isObject3D=!0,Object.defineProperty(this,"id",{value:b_++}),this.uuid=Xi(),this.name="",this.type="Object3D",this.parent=null,this.children=[],this.up=zt.DEFAULT_UP.clone();const e=new B,t=new Cr,n=new qt,r=new B(1,1,1);function s(){n.setFromEuler(t,!1)}function a(){t.setFromQuaternion(n,void 0,!1)}t._onChange(s),n._onChange(a),Object.defineProperties(this,{position:{configurable:!0,enumerable:!0,value:e},rotation:{configurable:!0,enumerable:!0,value:t},quaternion:{configurable:!0,enumerable:!0,value:n},scale:{configurable:!0,enumerable:!0,value:r},modelViewMatrix:{value:new Tt},normalMatrix:{value:new Yt}}),this.matrix=new Tt,this.matrixWorld=new Tt,this.matrixAutoUpdate=zt.DEFAULT_MATRIX_AUTO_UPDATE,this.matrixWorldNeedsUpdate=!1,this.matrixWorldAutoUpdate=zt.DEFAULT_MATRIX_WORLD_AUTO_UPDATE,this.layers=new Ma,this.visible=!0,this.castShadow=!1,this.receiveShadow=!1,this.frustumCulled=!0,this.renderOrder=0,this.animations=[],this.userData={}}onBeforeRender(){}onAfterRender(){}applyMatrix4(e){this.matrixAutoUpdate&&this.updateMatrix(),this.matrix.premultiply(e),this.matrix.decompose(this.position,this.quaternion,this.scale)}applyQuaternion(e){return this.quaternion.premultiply(e),this}setRotationFromAxisAngle(e,t){this.quaternion.setFromAxisAngle(e,t)}setRotationFromEuler(e){this.quaternion.setFromEuler(e,!0)}setRotationFromMatrix(e){this.quaternion.setFromRotationMatrix(e)}setRotationFromQuaternion(e){this.quaternion.copy(e)}rotateOnAxis(e,t){return xi.setFromAxisAngle(e,t),this.quaternion.multiply(xi),this}rotateOnWorldAxis(e,t){return xi.setFromAxisAngle(e,t),this.quaternion.premultiply(xi),this}rotateX(e){return this.rotateOnAxis(Ll,e)}rotateY(e){return this.rotateOnAxis(Pl,e)}rotateZ(e){return this.rotateOnAxis(Al,e)}translateOnAxis(e,t){return El.copy(e).applyQuaternion(this.quaternion),this.position.add(El.multiplyScalar(t)),this}translateX(e){return this.translateOnAxis(Ll,e)}translateY(e){return this.translateOnAxis(Pl,e)}translateZ(e){return this.translateOnAxis(Al,e)}localToWorld(e){return this.updateWorldMatrix(!0,!1),e.applyMatrix4(this.matrixWorld)}worldToLocal(e){return this.updateWorldMatrix(!0,!1),e.applyMatrix4(Dn.copy(this.matrixWorld).invert())}lookAt(e,t,n){e.isVector3?Ir.copy(e):Ir.set(e,t,n);const r=this.parent;this.updateWorldMatrix(!0,!1),Ji.setFromMatrixPosition(this.matrixWorld),this.isCamera||this.isLight?Dn.lookAt(Ji,Ir,this.up):Dn.lookAt(Ir,Ji,this.up),this.quaternion.setFromRotationMatrix(Dn),r&&(Dn.extractRotation(r.matrixWorld),xi.setFromRotationMatrix(Dn),this.quaternion.premultiply(xi.invert()))}add(e){if(arguments.length>1){for(let t=0;t<arguments.length;t++)this.add(arguments[t]);return this}return e===this?(console.error("THREE.Object3D.add: object can't be added as a child of itself.",e),this):(e&&e.isObject3D?(e.parent!==null&&e.parent.remove(e),e.parent=this,this.children.push(e),e.dispatchEvent(w_)):console.error("THREE.Object3D.add: object not an instance of THREE.Object3D.",e),this)}remove(e){if(arguments.length>1){for(let n=0;n<arguments.length;n++)this.remove(arguments[n]);return this}const t=this.children.indexOf(e);return t!==-1&&(e.parent=null,this.children.splice(t,1),e.dispatchEvent(Dl)),this}removeFromParent(){const e=this.parent;return e!==null&&e.remove(this),this}clear(){for(let e=0;e<this.children.length;e++){const t=this.children[e];t.parent=null,t.dispatchEvent(Dl)}return this.children.length=0,this}attach(e){return this.updateWorldMatrix(!0,!1),Dn.copy(this.matrixWorld).invert(),e.parent!==null&&(e.parent.updateWorldMatrix(!0,!1),Dn.multiply(e.parent.matrixWorld)),e.applyMatrix4(Dn),this.add(e),e.updateWorldMatrix(!1,!0),this}getObjectById(e){return this.getObjectByProperty("id",e)}getObjectByName(e){return this.getObjectByProperty("name",e)}getObjectByProperty(e,t){if(this[e]===t)return this;for(let n=0,r=this.children.length;n<r;n++){const a=this.children[n].getObjectByProperty(e,t);if(a!==void 0)return a}}getObjectsByProperty(e,t){let n=[];this[e]===t&&n.push(this);for(let r=0,s=this.children.length;r<s;r++){const a=this.children[r].getObjectsByProperty(e,t);a.length>0&&(n=n.concat(a))}return n}getWorldPosition(e){return this.updateWorldMatrix(!0,!1),e.setFromMatrixPosition(this.matrixWorld)}getWorldQuaternion(e){return this.updateWorldMatrix(!0,!1),this.matrixWorld.decompose(Ji,e,v_),e}getWorldScale(e){return this.updateWorldMatrix(!0,!1),this.matrixWorld.decompose(Ji,y_,e),e}getWorldDirection(e){this.updateWorldMatrix(!0,!1);const t=this.matrixWorld.elements;return e.set(t[8],t[9],t[10]).normalize()}raycast(){}traverse(e){e(this);const t=this.children;for(let n=0,r=t.length;n<r;n++)t[n].traverse(e)}traverseVisible(e){if(this.visible===!1)return;e(this);const t=this.children;for(let n=0,r=t.length;n<r;n++)t[n].traverseVisible(e)}traverseAncestors(e){const t=this.parent;t!==null&&(e(t),t.traverseAncestors(e))}updateMatrix(){this.matrix.compose(this.position,this.quaternion,this.scale),this.matrixWorldNeedsUpdate=!0}updateMatrixWorld(e){this.matrixAutoUpdate&&this.updateMatrix(),(this.matrixWorldNeedsUpdate||e)&&(this.parent===null?this.matrixWorld.copy(this.matrix):this.matrixWorld.multiplyMatrices(this.parent.matrixWorld,this.matrix),this.matrixWorldNeedsUpdate=!1,e=!0);const t=this.children;for(let n=0,r=t.length;n<r;n++){const s=t[n];(s.matrixWorldAutoUpdate===!0||e===!0)&&s.updateMatrixWorld(e)}}updateWorldMatrix(e,t){const n=this.parent;if(e===!0&&n!==null&&n.matrixWorldAutoUpdate===!0&&n.updateWorldMatrix(!0,!1),this.matrixAutoUpdate&&this.updateMatrix(),this.parent===null?this.matrixWorld.copy(this.matrix):this.matrixWorld.multiplyMatrices(this.parent.matrixWorld,this.matrix),t===!0){const r=this.children;for(let s=0,a=r.length;s<a;s++){const o=r[s];o.matrixWorldAutoUpdate===!0&&o.updateWorldMatrix(!1,!0)}}}toJSON(e){const t=e===void 0||typeof e=="string",n={};t&&(e={geometries:{},materials:{},textures:{},images:{},shapes:{},skeletons:{},animations:{},nodes:{}},n.metadata={version:4.5,type:"Object",generator:"Object3D.toJSON"});const r={};r.uuid=this.uuid,r.type=this.type,this.name!==""&&(r.name=this.name),this.castShadow===!0&&(r.castShadow=!0),this.receiveShadow===!0&&(r.receiveShadow=!0),this.visible===!1&&(r.visible=!1),this.frustumCulled===!1&&(r.frustumCulled=!1),this.renderOrder!==0&&(r.renderOrder=this.renderOrder),Object.keys(this.userData).length>0&&(r.userData=this.userData),r.layers=this.layers.mask,r.matrix=this.matrix.toArray(),this.matrixAutoUpdate===!1&&(r.matrixAutoUpdate=!1),this.isInstancedMesh&&(r.type="InstancedMesh",r.count=this.count,r.instanceMatrix=this.instanceMatrix.toJSON(),this.instanceColor!==null&&(r.instanceColor=this.instanceColor.toJSON()));function s(o,l){return o[l.uuid]===void 0&&(o[l.uuid]=l.toJSON(e)),l.uuid}if(this.isScene)this.background&&(this.background.isColor?r.background=this.background.toJSON():this.background.isTexture&&(r.background=this.background.toJSON(e).uuid)),this.environment&&this.environment.isTexture&&this.environment.isRenderTargetTexture!==!0&&(r.environment=this.environment.toJSON(e).uuid);else if(this.isMesh||this.isLine||this.isPoints){r.geometry=s(e.geometries,this.geometry);const o=this.geometry.parameters;if(o!==void 0&&o.shapes!==void 0){const l=o.shapes;if(Array.isArray(l))for(let c=0,u=l.length;c<u;c++){const f=l[c];s(e.shapes,f)}else s(e.shapes,l)}}if(this.isSkinnedMesh&&(r.bindMode=this.bindMode,r.bindMatrix=this.bindMatrix.toArray(),this.skeleton!==void 0&&(s(e.skeletons,this.skeleton),r.skeleton=this.skeleton.uuid)),this.material!==void 0)if(Array.isArray(this.material)){const o=[];for(let l=0,c=this.material.length;l<c;l++)o.push(s(e.materials,this.material[l]));r.material=o}else r.material=s(e.materials,this.material);if(this.children.length>0){r.children=[];for(let o=0;o<this.children.length;o++)r.children.push(this.children[o].toJSON(e).object)}if(this.animations.length>0){r.animations=[];for(let o=0;o<this.animations.length;o++){const l=this.animations[o];r.animations.push(s(e.animations,l))}}if(t){const o=a(e.geometries),l=a(e.materials),c=a(e.textures),u=a(e.images),f=a(e.shapes),d=a(e.skeletons),p=a(e.animations),m=a(e.nodes);o.length>0&&(n.geometries=o),l.length>0&&(n.materials=l),c.length>0&&(n.textures=c),u.length>0&&(n.images=u),f.length>0&&(n.shapes=f),d.length>0&&(n.skeletons=d),p.length>0&&(n.animations=p),m.length>0&&(n.nodes=m)}return n.object=r,n;function a(o){const l=[];for(const c in o){const u=o[c];delete u.metadata,l.push(u)}return l}}clone(e){return new this.constructor().copy(this,e)}copy(e,t=!0){if(this.name=e.name,this.up.copy(e.up),this.position.copy(e.position),this.rotation.order=e.rotation.order,this.quaternion.copy(e.quaternion),this.scale.copy(e.scale),this.matrix.copy(e.matrix),this.matrixWorld.copy(e.matrixWorld),this.matrixAutoUpdate=e.matrixAutoUpdate,this.matrixWorldNeedsUpdate=e.matrixWorldNeedsUpdate,this.matrixWorldAutoUpdate=e.matrixWorldAutoUpdate,this.layers.mask=e.layers.mask,this.visible=e.visible,this.castShadow=e.castShadow,this.receiveShadow=e.receiveShadow,this.frustumCulled=e.frustumCulled,this.renderOrder=e.renderOrder,this.userData=JSON.parse(JSON.stringify(e.userData)),t===!0)for(let n=0;n<e.children.length;n++){const r=e.children[n];this.add(r.clone())}return this}}zt.DEFAULT_UP=new B(0,1,0);zt.DEFAULT_MATRIX_AUTO_UPDATE=!0;zt.DEFAULT_MATRIX_WORLD_AUTO_UPDATE=!0;const pn=new B,Rn=new B,Gs=new B,kn=new B,Mi=new B,Si=new B,Rl=new B,Hs=new B,Ws=new B,Xs=new B;class In{constructor(e=new B,t=new B,n=new B){this.a=e,this.b=t,this.c=n}static getNormal(e,t,n,r){r.subVectors(n,t),pn.subVectors(e,t),r.cross(pn);const s=r.lengthSq();return s>0?r.multiplyScalar(1/Math.sqrt(s)):r.set(0,0,0)}static getBarycoord(e,t,n,r,s){pn.subVectors(r,t),Rn.subVectors(n,t),Gs.subVectors(e,t);const a=pn.dot(pn),o=pn.dot(Rn),l=pn.dot(Gs),c=Rn.dot(Rn),u=Rn.dot(Gs),f=a*c-o*o;if(f===0)return s.set(-2,-1,-1);const d=1/f,p=(c*l-o*u)*d,m=(a*u-o*l)*d;return s.set(1-p-m,m,p)}static containsPoint(e,t,n,r){return this.getBarycoord(e,t,n,r,kn),kn.x>=0&&kn.y>=0&&kn.x+kn.y<=1}static getUV(e,t,n,r,s,a,o,l){return this.getBarycoord(e,t,n,r,kn),l.set(0,0),l.addScaledVector(s,kn.x),l.addScaledVector(a,kn.y),l.addScaledVector(o,kn.z),l}static isFrontFacing(e,t,n,r){return pn.subVectors(n,t),Rn.subVectors(e,t),pn.cross(Rn).dot(r)<0}set(e,t,n){return this.a.copy(e),this.b.copy(t),this.c.copy(n),this}setFromPointsAndIndices(e,t,n,r){return this.a.copy(e[t]),this.b.copy(e[n]),this.c.copy(e[r]),this}setFromAttributeAndIndices(e,t,n,r){return this.a.fromBufferAttribute(e,t),this.b.fromBufferAttribute(e,n),this.c.fromBufferAttribute(e,r),this}clone(){return new this.constructor().copy(this)}copy(e){return this.a.copy(e.a),this.b.copy(e.b),this.c.copy(e.c),this}getArea(){return pn.subVectors(this.c,this.b),Rn.subVectors(this.a,this.b),pn.cross(Rn).length()*.5}getMidpoint(e){return e.addVectors(this.a,this.b).add(this.c).multiplyScalar(1/3)}getNormal(e){return In.getNormal(this.a,this.b,this.c,e)}getPlane(e){return e.setFromCoplanarPoints(this.a,this.b,this.c)}getBarycoord(e,t){return In.getBarycoord(e,this.a,this.b,this.c,t)}getUV(e,t,n,r,s){return In.getUV(e,this.a,this.b,this.c,t,n,r,s)}containsPoint(e){return In.containsPoint(e,this.a,this.b,this.c)}isFrontFacing(e){return In.isFrontFacing(this.a,this.b,this.c,e)}intersectsBox(e){return e.intersectsTriangle(this)}closestPointToPoint(e,t){const n=this.a,r=this.b,s=this.c;let a,o;Mi.subVectors(r,n),Si.subVectors(s,n),Hs.subVectors(e,n);const l=Mi.dot(Hs),c=Si.dot(Hs);if(l<=0&&c<=0)return t.copy(n);Ws.subVectors(e,r);const u=Mi.dot(Ws),f=Si.dot(Ws);if(u>=0&&f<=u)return t.copy(r);const d=l*f-u*c;if(d<=0&&l>=0&&u<=0)return a=l/(l-u),t.copy(n).addScaledVector(Mi,a);Xs.subVectors(e,s);const p=Mi.dot(Xs),m=Si.dot(Xs);if(m>=0&&p<=m)return t.copy(s);const h=p*c-l*m;if(h<=0&&c>=0&&m<=0)return o=c/(c-m),t.copy(n).addScaledVector(Si,o);const _=u*m-p*f;if(_<=0&&f-u>=0&&p-m>=0)return Rl.subVectors(s,r),o=(f-u)/(f-u+(p-m)),t.copy(r).addScaledVector(Rl,o);const g=1/(_+h+d);return a=h*g,o=d*g,t.copy(n).addScaledVector(Mi,a).addScaledVector(Si,o)}equals(e){return e.a.equals(this.a)&&e.b.equals(this.b)&&e.c.equals(this.c)}}let x_=0;class Tr extends Wi{constructor(){super(),this.isMaterial=!0,Object.defineProperty(this,"id",{value:x_++}),this.uuid=Xi(),this.name="",this.type="Material",this.blending=Ni,this.side=Zn,this.vertexColors=!1,this.opacity=1,this.transparent=!1,this.blendSrc=Dc,this.blendDst=Rc,this.blendEquation=Ai,this.blendSrcAlpha=null,this.blendDstAlpha=null,this.blendEquationAlpha=null,this.depthFunc=oa,this.depthTest=!0,this.depthWrite=!0,this.stencilWriteMask=255,this.stencilFunc=jm,this.stencilRef=0,this.stencilFuncMask=255,this.stencilFail=Ds,this.stencilZFail=Ds,this.stencilZPass=Ds,this.stencilWrite=!1,this.clippingPlanes=null,this.clipIntersection=!1,this.clipShadows=!1,this.shadowSide=null,this.colorWrite=!0,this.precision=null,this.polygonOffset=!1,this.polygonOffsetFactor=0,this.polygonOffsetUnits=0,this.dithering=!1,this.alphaToCoverage=!1,this.premultipliedAlpha=!1,this.forceSinglePass=!1,this.visible=!0,this.toneMapped=!0,this.userData={},this.version=0,this._alphaTest=0}get alphaTest(){return this._alphaTest}set alphaTest(e){this._alphaTest>0!=e>0&&this.version++,this._alphaTest=e}onBuild(){}onBeforeRender(){}onBeforeCompile(){}customProgramCacheKey(){return this.onBeforeCompile.toString()}setValues(e){if(e!==void 0)for(const t in e){const n=e[t];if(n===void 0){console.warn("THREE.Material: '"+t+"' parameter is undefined.");continue}const r=this[t];if(r===void 0){console.warn("THREE."+this.type+": '"+t+"' is not a property of this material.");continue}r&&r.isColor?r.set(n):r&&r.isVector3&&n&&n.isVector3?r.copy(n):this[t]=n}}toJSON(e){const t=e===void 0||typeof e=="string";t&&(e={textures:{},images:{}});const n={metadata:{version:4.5,type:"Material",generator:"Material.toJSON"}};n.uuid=this.uuid,n.type=this.type,this.name!==""&&(n.name=this.name),this.color&&this.color.isColor&&(n.color=this.color.getHex()),this.roughness!==void 0&&(n.roughness=this.roughness),this.metalness!==void 0&&(n.metalness=this.metalness),this.sheen!==void 0&&(n.sheen=this.sheen),this.sheenColor&&this.sheenColor.isColor&&(n.sheenColor=this.sheenColor.getHex()),this.sheenRoughness!==void 0&&(n.sheenRoughness=this.sheenRoughness),this.emissive&&this.emissive.isColor&&(n.emissive=this.emissive.getHex()),this.emissiveIntensity&&this.emissiveIntensity!==1&&(n.emissiveIntensity=this.emissiveIntensity),this.specular&&this.specular.isColor&&(n.specular=this.specular.getHex()),this.specularIntensity!==void 0&&(n.specularIntensity=this.specularIntensity),this.specularColor&&this.specularColor.isColor&&(n.specularColor=this.specularColor.getHex()),this.shininess!==void 0&&(n.shininess=this.shininess),this.clearcoat!==void 0&&(n.clearcoat=this.clearcoat),this.clearcoatRoughness!==void 0&&(n.clearcoatRoughness=this.clearcoatRoughness),this.clearcoatMap&&this.clearcoatMap.isTexture&&(n.clearcoatMap=this.clearcoatMap.toJSON(e).uuid),this.clearcoatRoughnessMap&&this.clearcoatRoughnessMap.isTexture&&(n.clearcoatRoughnessMap=this.clearcoatRoughnessMap.toJSON(e).uuid),this.clearcoatNormalMap&&this.clearcoatNormalMap.isTexture&&(n.clearcoatNormalMap=this.clearcoatNormalMap.toJSON(e).uuid,n.clearcoatNormalScale=this.clearcoatNormalScale.toArray()),this.iridescence!==void 0&&(n.iridescence=this.iridescence),this.iridescenceIOR!==void 0&&(n.iridescenceIOR=this.iridescenceIOR),this.iridescenceThicknessRange!==void 0&&(n.iridescenceThicknessRange=this.iridescenceThicknessRange),this.iridescenceMap&&this.iridescenceMap.isTexture&&(n.iridescenceMap=this.iridescenceMap.toJSON(e).uuid),this.iridescenceThicknessMap&&this.iridescenceThicknessMap.isTexture&&(n.iridescenceThicknessMap=this.iridescenceThicknessMap.toJSON(e).uuid),this.map&&this.map.isTexture&&(n.map=this.map.toJSON(e).uuid),this.matcap&&this.matcap.isTexture&&(n.matcap=this.matcap.toJSON(e).uuid),this.alphaMap&&this.alphaMap.isTexture&&(n.alphaMap=this.alphaMap.toJSON(e).uuid),this.lightMap&&this.lightMap.isTexture&&(n.lightMap=this.lightMap.toJSON(e).uuid,n.lightMapIntensity=this.lightMapIntensity),this.aoMap&&this.aoMap.isTexture&&(n.aoMap=this.aoMap.toJSON(e).uuid,n.aoMapIntensity=this.aoMapIntensity),this.bumpMap&&this.bumpMap.isTexture&&(n.bumpMap=this.bumpMap.toJSON(e).uuid,n.bumpScale=this.bumpScale),this.normalMap&&this.normalMap.isTexture&&(n.normalMap=this.normalMap.toJSON(e).uuid,n.normalMapType=this.normalMapType,n.normalScale=this.normalScale.toArray()),this.displacementMap&&this.displacementMap.isTexture&&(n.displacementMap=this.displacementMap.toJSON(e).uuid,n.displacementScale=this.displacementScale,n.displacementBias=this.displacementBias),this.roughnessMap&&this.roughnessMap.isTexture&&(n.roughnessMap=this.roughnessMap.toJSON(e).uuid),this.metalnessMap&&this.metalnessMap.isTexture&&(n.metalnessMap=this.metalnessMap.toJSON(e).uuid),this.emissiveMap&&this.emissiveMap.isTexture&&(n.emissiveMap=this.emissiveMap.toJSON(e).uuid),this.specularMap&&this.specularMap.isTexture&&(n.specularMap=this.specularMap.toJSON(e).uuid),this.specularIntensityMap&&this.specularIntensityMap.isTexture&&(n.specularIntensityMap=this.specularIntensityMap.toJSON(e).uuid),this.specularColorMap&&this.specularColorMap.isTexture&&(n.specularColorMap=this.specularColorMap.toJSON(e).uuid),this.envMap&&this.envMap.isTexture&&(n.envMap=this.envMap.toJSON(e).uuid,this.combine!==void 0&&(n.combine=this.combine)),this.envMapIntensity!==void 0&&(n.envMapIntensity=this.envMapIntensity),this.reflectivity!==void 0&&(n.reflectivity=this.reflectivity),this.refractionRatio!==void 0&&(n.refractionRatio=this.refractionRatio),this.gradientMap&&this.gradientMap.isTexture&&(n.gradientMap=this.gradientMap.toJSON(e).uuid),this.transmission!==void 0&&(n.transmission=this.transmission),this.transmissionMap&&this.transmissionMap.isTexture&&(n.transmissionMap=this.transmissionMap.toJSON(e).uuid),this.thickness!==void 0&&(n.thickness=this.thickness),this.thicknessMap&&this.thicknessMap.isTexture&&(n.thicknessMap=this.thicknessMap.toJSON(e).uuid),this.attenuationDistance!==void 0&&this.attenuationDistance!==1/0&&(n.attenuationDistance=this.attenuationDistance),this.attenuationColor!==void 0&&(n.attenuationColor=this.attenuationColor.getHex()),this.size!==void 0&&(n.size=this.size),this.shadowSide!==null&&(n.shadowSide=this.shadowSide),this.sizeAttenuation!==void 0&&(n.sizeAttenuation=this.sizeAttenuation),this.blending!==Ni&&(n.blending=this.blending),this.side!==Zn&&(n.side=this.side),this.vertexColors&&(n.vertexColors=!0),this.opacity<1&&(n.opacity=this.opacity),this.transparent===!0&&(n.transparent=this.transparent),n.depthFunc=this.depthFunc,n.depthTest=this.depthTest,n.depthWrite=this.depthWrite,n.colorWrite=this.colorWrite,n.stencilWrite=this.stencilWrite,n.stencilWriteMask=this.stencilWriteMask,n.stencilFunc=this.stencilFunc,n.stencilRef=this.stencilRef,n.stencilFuncMask=this.stencilFuncMask,n.stencilFail=this.stencilFail,n.stencilZFail=this.stencilZFail,n.stencilZPass=this.stencilZPass,this.rotation!==void 0&&this.rotation!==0&&(n.rotation=this.rotation),this.polygonOffset===!0&&(n.polygonOffset=!0),this.polygonOffsetFactor!==0&&(n.polygonOffsetFactor=this.polygonOffsetFactor),this.polygonOffsetUnits!==0&&(n.polygonOffsetUnits=this.polygonOffsetUnits),this.linewidth!==void 0&&this.linewidth!==1&&(n.linewidth=this.linewidth),this.dashSize!==void 0&&(n.dashSize=this.dashSize),this.gapSize!==void 0&&(n.gapSize=this.gapSize),this.scale!==void 0&&(n.scale=this.scale),this.dithering===!0&&(n.dithering=!0),this.alphaTest>0&&(n.alphaTest=this.alphaTest),this.alphaToCoverage===!0&&(n.alphaToCoverage=this.alphaToCoverage),this.premultipliedAlpha===!0&&(n.premultipliedAlpha=this.premultipliedAlpha),this.forceSinglePass===!0&&(n.forceSinglePass=this.forceSinglePass),this.wireframe===!0&&(n.wireframe=this.wireframe),this.wireframeLinewidth>1&&(n.wireframeLinewidth=this.wireframeLinewidth),this.wireframeLinecap!=="round"&&(n.wireframeLinecap=this.wireframeLinecap),this.wireframeLinejoin!=="round"&&(n.wireframeLinejoin=this.wireframeLinejoin),this.flatShading===!0&&(n.flatShading=this.flatShading),this.visible===!1&&(n.visible=!1),this.toneMapped===!1&&(n.toneMapped=!1),this.fog===!1&&(n.fog=!1),Object.keys(this.userData).length>0&&(n.userData=this.userData);function r(s){const a=[];for(const o in s){const l=s[o];delete l.metadata,a.push(l)}return a}if(t){const s=r(e.textures),a=r(e.images);s.length>0&&(n.textures=s),a.length>0&&(n.images=a)}return n}clone(){return new this.constructor().copy(this)}copy(e){this.name=e.name,this.blending=e.blending,this.side=e.side,this.vertexColors=e.vertexColors,this.opacity=e.opacity,this.transparent=e.transparent,this.blendSrc=e.blendSrc,this.blendDst=e.blendDst,this.blendEquation=e.blendEquation,this.blendSrcAlpha=e.blendSrcAlpha,this.blendDstAlpha=e.blendDstAlpha,this.blendEquationAlpha=e.blendEquationAlpha,this.depthFunc=e.depthFunc,this.depthTest=e.depthTest,this.depthWrite=e.depthWrite,this.stencilWriteMask=e.stencilWriteMask,this.stencilFunc=e.stencilFunc,this.stencilRef=e.stencilRef,this.stencilFuncMask=e.stencilFuncMask,this.stencilFail=e.stencilFail,this.stencilZFail=e.stencilZFail,this.stencilZPass=e.stencilZPass,this.stencilWrite=e.stencilWrite;const t=e.clippingPlanes;let n=null;if(t!==null){const r=t.length;n=new Array(r);for(let s=0;s!==r;++s)n[s]=t[s].clone()}return this.clippingPlanes=n,this.clipIntersection=e.clipIntersection,this.clipShadows=e.clipShadows,this.shadowSide=e.shadowSide,this.colorWrite=e.colorWrite,this.precision=e.precision,this.polygonOffset=e.polygonOffset,this.polygonOffsetFactor=e.polygonOffsetFactor,this.polygonOffsetUnits=e.polygonOffsetUnits,this.dithering=e.dithering,this.alphaTest=e.alphaTest,this.alphaToCoverage=e.alphaToCoverage,this.premultipliedAlpha=e.premultipliedAlpha,this.forceSinglePass=e.forceSinglePass,this.visible=e.visible,this.toneMapped=e.toneMapped,this.userData=JSON.parse(JSON.stringify(e.userData)),this}dispose(){this.dispatchEvent({type:"dispose"})}set needsUpdate(e){e===!0&&this.version++}}const Gc={aliceblue:15792383,antiquewhite:16444375,aqua:65535,aquamarine:8388564,azure:15794175,beige:16119260,bisque:16770244,black:0,blanchedalmond:16772045,blue:255,blueviolet:9055202,brown:10824234,burlywood:14596231,cadetblue:6266528,chartreuse:8388352,chocolate:13789470,coral:16744272,cornflowerblue:6591981,cornsilk:16775388,crimson:14423100,cyan:65535,darkblue:139,darkcyan:35723,darkgoldenrod:12092939,darkgray:11119017,darkgreen:25600,darkgrey:11119017,darkkhaki:12433259,darkmagenta:9109643,darkolivegreen:5597999,darkorange:16747520,darkorchid:10040012,darkred:9109504,darksalmon:15308410,darkseagreen:9419919,darkslateblue:4734347,darkslategray:3100495,darkslategrey:3100495,darkturquoise:52945,darkviolet:9699539,deeppink:16716947,deepskyblue:49151,dimgray:6908265,dimgrey:6908265,dodgerblue:2003199,firebrick:11674146,floralwhite:16775920,forestgreen:2263842,fuchsia:16711935,gainsboro:14474460,ghostwhite:16316671,gold:16766720,goldenrod:14329120,gray:8421504,green:32768,greenyellow:11403055,grey:8421504,honeydew:15794160,hotpink:16738740,indianred:13458524,indigo:4915330,ivory:16777200,khaki:15787660,lavender:15132410,lavenderblush:16773365,lawngreen:8190976,lemonchiffon:16775885,lightblue:11393254,lightcoral:15761536,lightcyan:14745599,lightgoldenrodyellow:16448210,lightgray:13882323,lightgreen:9498256,lightgrey:13882323,lightpink:16758465,lightsalmon:16752762,lightseagreen:2142890,lightskyblue:8900346,lightslategray:7833753,lightslategrey:7833753,lightsteelblue:11584734,lightyellow:16777184,lime:65280,limegreen:3329330,linen:16445670,magenta:16711935,maroon:8388608,mediumaquamarine:6737322,mediumblue:205,mediumorchid:12211667,mediumpurple:9662683,mediumseagreen:3978097,mediumslateblue:8087790,mediumspringgreen:64154,mediumturquoise:4772300,mediumvioletred:13047173,midnightblue:1644912,mintcream:16121850,mistyrose:16770273,moccasin:16770229,navajowhite:16768685,navy:128,oldlace:16643558,olive:8421376,olivedrab:7048739,orange:16753920,orangered:16729344,orchid:14315734,palegoldenrod:15657130,palegreen:10025880,paleturquoise:11529966,palevioletred:14381203,papayawhip:16773077,peachpuff:16767673,peru:13468991,pink:16761035,plum:14524637,powderblue:11591910,purple:8388736,rebeccapurple:6697881,red:16711680,rosybrown:12357519,royalblue:4286945,saddlebrown:9127187,salmon:16416882,sandybrown:16032864,seagreen:3050327,seashell:16774638,sienna:10506797,silver:12632256,skyblue:8900331,slateblue:6970061,slategray:7372944,slategrey:7372944,snow:16775930,springgreen:65407,steelblue:4620980,tan:13808780,teal:32896,thistle:14204888,tomato:16737095,turquoise:4251856,violet:15631086,wheat:16113331,white:16777215,whitesmoke:16119285,yellow:16776960,yellowgreen:10145074},mn={h:0,s:0,l:0},Nr={h:0,s:0,l:0};function js(i,e,t){return t<0&&(t+=1),t>1&&(t-=1),t<1/6?i+(e-i)*6*t:t<1/2?e:t<2/3?i+(e-i)*6*(2/3-t):i}class mt{constructor(e,t,n){return this.isColor=!0,this.r=1,this.g=1,this.b=1,t===void 0&&n===void 0?this.set(e):this.setRGB(e,t,n)}set(e){return e&&e.isColor?this.copy(e):typeof e=="number"?this.setHex(e):typeof e=="string"&&this.setStyle(e),this}setScalar(e){return this.r=e,this.g=e,this.b=e,this}setHex(e,t=Mn){return e=Math.floor(e),this.r=(e>>16&255)/255,this.g=(e>>8&255)/255,this.b=(e&255)/255,Wt.toWorkingColorSpace(this,t),this}setRGB(e,t,n,r=Wt.workingColorSpace){return this.r=e,this.g=t,this.b=n,Wt.toWorkingColorSpace(this,r),this}setHSL(e,t,n,r=Wt.workingColorSpace){if(e=wa(e,1),t=Qt(t,0,1),n=Qt(n,0,1),t===0)this.r=this.g=this.b=n;else{const s=n<=.5?n*(1+t):n+t-n*t,a=2*n-s;this.r=js(a,s,e+1/3),this.g=js(a,s,e),this.b=js(a,s,e-1/3)}return Wt.toWorkingColorSpace(this,r),this}setStyle(e,t=Mn){function n(s){s!==void 0&&parseFloat(s)<1&&console.warn("THREE.Color: Alpha component of "+e+" will be ignored.")}let r;if(r=/^(\w+)\(([^\)]*)\)/.exec(e)){let s;const a=r[1],o=r[2];switch(a){case"rgb":case"rgba":if(s=/^\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*(\d*\.?\d+)\s*)?$/.exec(o))return this.r=Math.min(255,parseInt(s[1],10))/255,this.g=Math.min(255,parseInt(s[2],10))/255,this.b=Math.min(255,parseInt(s[3],10))/255,Wt.toWorkingColorSpace(this,t),n(s[4]),this;if(s=/^\s*(\d+)\%\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*(?:,\s*(\d*\.?\d+)\s*)?$/.exec(o))return this.r=Math.min(100,parseInt(s[1],10))/100,this.g=Math.min(100,parseInt(s[2],10))/100,this.b=Math.min(100,parseInt(s[3],10))/100,Wt.toWorkingColorSpace(this,t),n(s[4]),this;break;case"hsl":case"hsla":if(s=/^\s*(\d*\.?\d+)\s*,\s*(\d*\.?\d+)\%\s*,\s*(\d*\.?\d+)\%\s*(?:,\s*(\d*\.?\d+)\s*)?$/.exec(o)){const l=parseFloat(s[1])/360,c=parseFloat(s[2])/100,u=parseFloat(s[3])/100;return n(s[4]),this.setHSL(l,c,u,t)}break;default:console.warn("THREE.Color: Unknown color model "+e)}}else if(r=/^\#([A-Fa-f\d]+)$/.exec(e)){const s=r[1],a=s.length;if(a===3)return this.r=parseInt(s.charAt(0)+s.charAt(0),16)/255,this.g=parseInt(s.charAt(1)+s.charAt(1),16)/255,this.b=parseInt(s.charAt(2)+s.charAt(2),16)/255,Wt.toWorkingColorSpace(this,t),this;if(a===6)return this.r=parseInt(s.charAt(0)+s.charAt(1),16)/255,this.g=parseInt(s.charAt(2)+s.charAt(3),16)/255,this.b=parseInt(s.charAt(4)+s.charAt(5),16)/255,Wt.toWorkingColorSpace(this,t),this;console.warn("THREE.Color: Invalid hex color "+e)}else if(e&&e.length>0)return this.setColorName(e,t);return this}setColorName(e,t=Mn){const n=Gc[e.toLowerCase()];return n!==void 0?this.setHex(n,t):console.warn("THREE.Color: Unknown color "+e),this}clone(){return new this.constructor(this.r,this.g,this.b)}copy(e){return this.r=e.r,this.g=e.g,this.b=e.b,this}copySRGBToLinear(e){return this.r=Fi(e.r),this.g=Fi(e.g),this.b=Fi(e.b),this}copyLinearToSRGB(e){return this.r=Is(e.r),this.g=Is(e.g),this.b=Is(e.b),this}convertSRGBToLinear(){return this.copySRGBToLinear(this),this}convertLinearToSRGB(){return this.copyLinearToSRGB(this),this}getHex(e=Mn){return Wt.fromWorkingColorSpace(Ut.copy(this),e),Qt(Ut.r*255,0,255)<<16^Qt(Ut.g*255,0,255)<<8^Qt(Ut.b*255,0,255)<<0}getHexString(e=Mn){return("000000"+this.getHex(e).toString(16)).slice(-6)}getHSL(e,t=Wt.workingColorSpace){Wt.fromWorkingColorSpace(Ut.copy(this),t);const n=Ut.r,r=Ut.g,s=Ut.b,a=Math.max(n,r,s),o=Math.min(n,r,s);let l,c;const u=(o+a)/2;if(o===a)l=0,c=0;else{const f=a-o;switch(c=u<=.5?f/(a+o):f/(2-a-o),a){case n:l=(r-s)/f+(r<s?6:0);break;case r:l=(s-n)/f+2;break;case s:l=(n-r)/f+4;break}l/=6}return e.h=l,e.s=c,e.l=u,e}getRGB(e,t=Wt.workingColorSpace){return Wt.fromWorkingColorSpace(Ut.copy(this),t),e.r=Ut.r,e.g=Ut.g,e.b=Ut.b,e}getStyle(e=Mn){Wt.fromWorkingColorSpace(Ut.copy(this),e);const t=Ut.r,n=Ut.g,r=Ut.b;return e!==Mn?`color(${e} ${t.toFixed(3)} ${n.toFixed(3)} ${r.toFixed(3)})`:`rgb(${t*255|0},${n*255|0},${r*255|0})`}offsetHSL(e,t,n){return this.getHSL(mn),mn.h+=e,mn.s+=t,mn.l+=n,this.setHSL(mn.h,mn.s,mn.l),this}add(e){return this.r+=e.r,this.g+=e.g,this.b+=e.b,this}addColors(e,t){return this.r=e.r+t.r,this.g=e.g+t.g,this.b=e.b+t.b,this}addScalar(e){return this.r+=e,this.g+=e,this.b+=e,this}sub(e){return this.r=Math.max(0,this.r-e.r),this.g=Math.max(0,this.g-e.g),this.b=Math.max(0,this.b-e.b),this}multiply(e){return this.r*=e.r,this.g*=e.g,this.b*=e.b,this}multiplyScalar(e){return this.r*=e,this.g*=e,this.b*=e,this}lerp(e,t){return this.r+=(e.r-this.r)*t,this.g+=(e.g-this.g)*t,this.b+=(e.b-this.b)*t,this}lerpColors(e,t,n){return this.r=e.r+(t.r-e.r)*n,this.g=e.g+(t.g-e.g)*n,this.b=e.b+(t.b-e.b)*n,this}lerpHSL(e,t){this.getHSL(mn),e.getHSL(Nr);const n=hr(mn.h,Nr.h,t),r=hr(mn.s,Nr.s,t),s=hr(mn.l,Nr.l,t);return this.setHSL(n,r,s),this}equals(e){return e.r===this.r&&e.g===this.g&&e.b===this.b}fromArray(e,t=0){return this.r=e[t],this.g=e[t+1],this.b=e[t+2],this}toArray(e=[],t=0){return e[t]=this.r,e[t+1]=this.g,e[t+2]=this.b,e}fromBufferAttribute(e,t){return this.r=e.getX(t),this.g=e.getY(t),this.b=e.getZ(t),this}toJSON(){return this.getHex()}*[Symbol.iterator](){yield this.r,yield this.g,yield this.b}}const Ut=new mt;mt.NAMES=Gc;class _s extends Tr{constructor(e){super(),this.isMeshBasicMaterial=!0,this.type="MeshBasicMaterial",this.color=new mt(16777215),this.map=null,this.lightMap=null,this.lightMapIntensity=1,this.aoMap=null,this.aoMapIntensity=1,this.specularMap=null,this.alphaMap=null,this.envMap=null,this.combine=kc,this.reflectivity=1,this.refractionRatio=.98,this.wireframe=!1,this.wireframeLinewidth=1,this.wireframeLinecap="round",this.wireframeLinejoin="round",this.fog=!0,this.setValues(e)}copy(e){return super.copy(e),this.color.copy(e.color),this.map=e.map,this.lightMap=e.lightMap,this.lightMapIntensity=e.lightMapIntensity,this.aoMap=e.aoMap,this.aoMapIntensity=e.aoMapIntensity,this.specularMap=e.specularMap,this.alphaMap=e.alphaMap,this.envMap=e.envMap,this.combine=e.combine,this.reflectivity=e.reflectivity,this.refractionRatio=e.refractionRatio,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.wireframeLinecap=e.wireframeLinecap,this.wireframeLinejoin=e.wireframeLinejoin,this.fog=e.fog,this}}const St=new B,zr=new st;class Cn{constructor(e,t,n=!1){if(Array.isArray(e))throw new TypeError("THREE.BufferAttribute: array should be a Typed Array.");this.isBufferAttribute=!0,this.name="",this.array=e,this.itemSize=t,this.count=e!==void 0?e.length/t:0,this.normalized=n,this.usage=wl,this.updateRange={offset:0,count:-1},this.version=0}onUploadCallback(){}set needsUpdate(e){e===!0&&this.version++}setUsage(e){return this.usage=e,this}copy(e){return this.name=e.name,this.array=new e.array.constructor(e.array),this.itemSize=e.itemSize,this.count=e.count,this.normalized=e.normalized,this.usage=e.usage,this}copyAt(e,t,n){e*=this.itemSize,n*=t.itemSize;for(let r=0,s=this.itemSize;r<s;r++)this.array[e+r]=t.array[n+r];return this}copyArray(e){return this.array.set(e),this}applyMatrix3(e){if(this.itemSize===2)for(let t=0,n=this.count;t<n;t++)zr.fromBufferAttribute(this,t),zr.applyMatrix3(e),this.setXY(t,zr.x,zr.y);else if(this.itemSize===3)for(let t=0,n=this.count;t<n;t++)St.fromBufferAttribute(this,t),St.applyMatrix3(e),this.setXYZ(t,St.x,St.y,St.z);return this}applyMatrix4(e){for(let t=0,n=this.count;t<n;t++)St.fromBufferAttribute(this,t),St.applyMatrix4(e),this.setXYZ(t,St.x,St.y,St.z);return this}applyNormalMatrix(e){for(let t=0,n=this.count;t<n;t++)St.fromBufferAttribute(this,t),St.applyNormalMatrix(e),this.setXYZ(t,St.x,St.y,St.z);return this}transformDirection(e){for(let t=0,n=this.count;t<n;t++)St.fromBufferAttribute(this,t),St.transformDirection(e),this.setXYZ(t,St.x,St.y,St.z);return this}set(e,t=0){return this.array.set(e,t),this}getX(e){let t=this.array[e*this.itemSize];return this.normalized&&(t=ar(t,this.array)),t}setX(e,t){return this.normalized&&(t=Kt(t,this.array)),this.array[e*this.itemSize]=t,this}getY(e){let t=this.array[e*this.itemSize+1];return this.normalized&&(t=ar(t,this.array)),t}setY(e,t){return this.normalized&&(t=Kt(t,this.array)),this.array[e*this.itemSize+1]=t,this}getZ(e){let t=this.array[e*this.itemSize+2];return this.normalized&&(t=ar(t,this.array)),t}setZ(e,t){return this.normalized&&(t=Kt(t,this.array)),this.array[e*this.itemSize+2]=t,this}getW(e){let t=this.array[e*this.itemSize+3];return this.normalized&&(t=ar(t,this.array)),t}setW(e,t){return this.normalized&&(t=Kt(t,this.array)),this.array[e*this.itemSize+3]=t,this}setXY(e,t,n){return e*=this.itemSize,this.normalized&&(t=Kt(t,this.array),n=Kt(n,this.array)),this.array[e+0]=t,this.array[e+1]=n,this}setXYZ(e,t,n,r){return e*=this.itemSize,this.normalized&&(t=Kt(t,this.array),n=Kt(n,this.array),r=Kt(r,this.array)),this.array[e+0]=t,this.array[e+1]=n,this.array[e+2]=r,this}setXYZW(e,t,n,r,s){return e*=this.itemSize,this.normalized&&(t=Kt(t,this.array),n=Kt(n,this.array),r=Kt(r,this.array),s=Kt(s,this.array)),this.array[e+0]=t,this.array[e+1]=n,this.array[e+2]=r,this.array[e+3]=s,this}onUpload(e){return this.onUploadCallback=e,this}clone(){return new this.constructor(this.array,this.itemSize).copy(this)}toJSON(){const e={itemSize:this.itemSize,type:this.array.constructor.name,array:Array.from(this.array),normalized:this.normalized};return this.name!==""&&(e.name=this.name),this.usage!==wl&&(e.usage=this.usage),(this.updateRange.offset!==0||this.updateRange.count!==-1)&&(e.updateRange=this.updateRange),e}copyColorsArray(){console.error("THREE.BufferAttribute: copyColorsArray() was removed in r144.")}copyVector2sArray(){console.error("THREE.BufferAttribute: copyVector2sArray() was removed in r144.")}copyVector3sArray(){console.error("THREE.BufferAttribute: copyVector3sArray() was removed in r144.")}copyVector4sArray(){console.error("THREE.BufferAttribute: copyVector4sArray() was removed in r144.")}}class Hc extends Cn{constructor(e,t,n){super(new Uint16Array(e),t,n)}}class Wc extends Cn{constructor(e,t,n){super(new Uint32Array(e),t,n)}}class bt extends Cn{constructor(e,t,n){super(new Float32Array(e),t,n)}}let M_=0;const un=new Tt,qs=new zt,Ci=new B,sn=new Sr,Qi=new Sr,Rt=new B;class $t extends Wi{constructor(){super(),this.isBufferGeometry=!0,Object.defineProperty(this,"id",{value:M_++}),this.uuid=Xi(),this.name="",this.type="BufferGeometry",this.index=null,this.attributes={},this.morphAttributes={},this.morphTargetsRelative=!1,this.groups=[],this.boundingBox=null,this.boundingSphere=null,this.drawRange={start:0,count:1/0},this.userData={}}getIndex(){return this.index}setIndex(e){return Array.isArray(e)?this.index=new(Oc(e)?Wc:Hc)(e,1):this.index=e,this}getAttribute(e){return this.attributes[e]}setAttribute(e,t){return this.attributes[e]=t,this}deleteAttribute(e){return delete this.attributes[e],this}hasAttribute(e){return this.attributes[e]!==void 0}addGroup(e,t,n=0){this.groups.push({start:e,count:t,materialIndex:n})}clearGroups(){this.groups=[]}setDrawRange(e,t){this.drawRange.start=e,this.drawRange.count=t}applyMatrix4(e){const t=this.attributes.position;t!==void 0&&(t.applyMatrix4(e),t.needsUpdate=!0);const n=this.attributes.normal;if(n!==void 0){const s=new Yt().getNormalMatrix(e);n.applyNormalMatrix(s),n.needsUpdate=!0}const r=this.attributes.tangent;return r!==void 0&&(r.transformDirection(e),r.needsUpdate=!0),this.boundingBox!==null&&this.computeBoundingBox(),this.boundingSphere!==null&&this.computeBoundingSphere(),this}applyQuaternion(e){return un.makeRotationFromQuaternion(e),this.applyMatrix4(un),this}rotateX(e){return un.makeRotationX(e),this.applyMatrix4(un),this}rotateY(e){return un.makeRotationY(e),this.applyMatrix4(un),this}rotateZ(e){return un.makeRotationZ(e),this.applyMatrix4(un),this}translate(e,t,n){return un.makeTranslation(e,t,n),this.applyMatrix4(un),this}scale(e,t,n){return un.makeScale(e,t,n),this.applyMatrix4(un),this}lookAt(e){return qs.lookAt(e),qs.updateMatrix(),this.applyMatrix4(qs.matrix),this}center(){return this.computeBoundingBox(),this.boundingBox.getCenter(Ci).negate(),this.translate(Ci.x,Ci.y,Ci.z),this}setFromPoints(e){const t=[];for(let n=0,r=e.length;n<r;n++){const s=e[n];t.push(s.x,s.y,s.z||0)}return this.setAttribute("position",new bt(t,3)),this}computeBoundingBox(){this.boundingBox===null&&(this.boundingBox=new Sr);const e=this.attributes.position,t=this.morphAttributes.position;if(e&&e.isGLBufferAttribute){console.error('THREE.BufferGeometry.computeBoundingBox(): GLBufferAttribute requires a manual bounding box. Alternatively set "mesh.frustumCulled" to "false".',this),this.boundingBox.set(new B(-1/0,-1/0,-1/0),new B(1/0,1/0,1/0));return}if(e!==void 0){if(this.boundingBox.setFromBufferAttribute(e),t)for(let n=0,r=t.length;n<r;n++){const s=t[n];sn.setFromBufferAttribute(s),this.morphTargetsRelative?(Rt.addVectors(this.boundingBox.min,sn.min),this.boundingBox.expandByPoint(Rt),Rt.addVectors(this.boundingBox.max,sn.max),this.boundingBox.expandByPoint(Rt)):(this.boundingBox.expandByPoint(sn.min),this.boundingBox.expandByPoint(sn.max))}}else this.boundingBox.makeEmpty();(isNaN(this.boundingBox.min.x)||isNaN(this.boundingBox.min.y)||isNaN(this.boundingBox.min.z))&&console.error('THREE.BufferGeometry.computeBoundingBox(): Computed min/max have NaN values. The "position" attribute is likely to have NaN values.',this)}computeBoundingSphere(){this.boundingSphere===null&&(this.boundingSphere=new ms);const e=this.attributes.position,t=this.morphAttributes.position;if(e&&e.isGLBufferAttribute){console.error('THREE.BufferGeometry.computeBoundingSphere(): GLBufferAttribute requires a manual bounding sphere. Alternatively set "mesh.frustumCulled" to "false".',this),this.boundingSphere.set(new B,1/0);return}if(e){const n=this.boundingSphere.center;if(sn.setFromBufferAttribute(e),t)for(let s=0,a=t.length;s<a;s++){const o=t[s];Qi.setFromBufferAttribute(o),this.morphTargetsRelative?(Rt.addVectors(sn.min,Qi.min),sn.expandByPoint(Rt),Rt.addVectors(sn.max,Qi.max),sn.expandByPoint(Rt)):(sn.expandByPoint(Qi.min),sn.expandByPoint(Qi.max))}sn.getCenter(n);let r=0;for(let s=0,a=e.count;s<a;s++)Rt.fromBufferAttribute(e,s),r=Math.max(r,n.distanceToSquared(Rt));if(t)for(let s=0,a=t.length;s<a;s++){const o=t[s],l=this.morphTargetsRelative;for(let c=0,u=o.count;c<u;c++)Rt.fromBufferAttribute(o,c),l&&(Ci.fromBufferAttribute(e,c),Rt.add(Ci)),r=Math.max(r,n.distanceToSquared(Rt))}this.boundingSphere.radius=Math.sqrt(r),isNaN(this.boundingSphere.radius)&&console.error('THREE.BufferGeometry.computeBoundingSphere(): Computed radius is NaN. The "position" attribute is likely to have NaN values.',this)}}computeTangents(){const e=this.index,t=this.attributes;if(e===null||t.position===void 0||t.normal===void 0||t.uv===void 0){console.error("THREE.BufferGeometry: .computeTangents() failed. Missing required attributes (index, position, normal or uv)");return}const n=e.array,r=t.position.array,s=t.normal.array,a=t.uv.array,o=r.length/3;this.hasAttribute("tangent")===!1&&this.setAttribute("tangent",new Cn(new Float32Array(4*o),4));const l=this.getAttribute("tangent").array,c=[],u=[];for(let A=0;A<o;A++)c[A]=new B,u[A]=new B;const f=new B,d=new B,p=new B,m=new st,h=new st,_=new st,g=new B,v=new B;function b(A,D,G){f.fromArray(r,A*3),d.fromArray(r,D*3),p.fromArray(r,G*3),m.fromArray(a,A*2),h.fromArray(a,D*2),_.fromArray(a,G*2),d.sub(f),p.sub(f),h.sub(m),_.sub(m);const U=1/(h.x*_.y-_.x*h.y);!isFinite(U)||(g.copy(d).multiplyScalar(_.y).addScaledVector(p,-h.y).multiplyScalar(U),v.copy(p).multiplyScalar(h.x).addScaledVector(d,-_.x).multiplyScalar(U),c[A].add(g),c[D].add(g),c[G].add(g),u[A].add(v),u[D].add(v),u[G].add(v))}let y=this.groups;y.length===0&&(y=[{start:0,count:n.length}]);for(let A=0,D=y.length;A<D;++A){const G=y[A],U=G.start,z=G.count;for(let X=U,ae=U+z;X<ae;X+=3)b(n[X+0],n[X+1],n[X+2])}const w=new B,M=new B,E=new B,x=new B;function C(A){E.fromArray(s,A*3),x.copy(E);const D=c[A];w.copy(D),w.sub(E.multiplyScalar(E.dot(D))).normalize(),M.crossVectors(x,D);const U=M.dot(u[A])<0?-1:1;l[A*4]=w.x,l[A*4+1]=w.y,l[A*4+2]=w.z,l[A*4+3]=U}for(let A=0,D=y.length;A<D;++A){const G=y[A],U=G.start,z=G.count;for(let X=U,ae=U+z;X<ae;X+=3)C(n[X+0]),C(n[X+1]),C(n[X+2])}}computeVertexNormals(){const e=this.index,t=this.getAttribute("position");if(t!==void 0){let n=this.getAttribute("normal");if(n===void 0)n=new Cn(new Float32Array(t.count*3),3),this.setAttribute("normal",n);else for(let d=0,p=n.count;d<p;d++)n.setXYZ(d,0,0,0);const r=new B,s=new B,a=new B,o=new B,l=new B,c=new B,u=new B,f=new B;if(e)for(let d=0,p=e.count;d<p;d+=3){const m=e.getX(d+0),h=e.getX(d+1),_=e.getX(d+2);r.fromBufferAttribute(t,m),s.fromBufferAttribute(t,h),a.fromBufferAttribute(t,_),u.subVectors(a,s),f.subVectors(r,s),u.cross(f),o.fromBufferAttribute(n,m),l.fromBufferAttribute(n,h),c.fromBufferAttribute(n,_),o.add(u),l.add(u),c.add(u),n.setXYZ(m,o.x,o.y,o.z),n.setXYZ(h,l.x,l.y,l.z),n.setXYZ(_,c.x,c.y,c.z)}else for(let d=0,p=t.count;d<p;d+=3)r.fromBufferAttribute(t,d+0),s.fromBufferAttribute(t,d+1),a.fromBufferAttribute(t,d+2),u.subVectors(a,s),f.subVectors(r,s),u.cross(f),n.setXYZ(d+0,u.x,u.y,u.z),n.setXYZ(d+1,u.x,u.y,u.z),n.setXYZ(d+2,u.x,u.y,u.z);this.normalizeNormals(),n.needsUpdate=!0}}merge(){return console.error("THREE.BufferGeometry.merge() has been removed. Use THREE.BufferGeometryUtils.mergeBufferGeometries() instead."),this}normalizeNormals(){const e=this.attributes.normal;for(let t=0,n=e.count;t<n;t++)Rt.fromBufferAttribute(e,t),Rt.normalize(),e.setXYZ(t,Rt.x,Rt.y,Rt.z)}toNonIndexed(){function e(o,l){const c=o.array,u=o.itemSize,f=o.normalized,d=new c.constructor(l.length*u);let p=0,m=0;for(let h=0,_=l.length;h<_;h++){o.isInterleavedBufferAttribute?p=l[h]*o.data.stride+o.offset:p=l[h]*u;for(let g=0;g<u;g++)d[m++]=c[p++]}return new Cn(d,u,f)}if(this.index===null)return console.warn("THREE.BufferGeometry.toNonIndexed(): BufferGeometry is already non-indexed."),this;const t=new $t,n=this.index.array,r=this.attributes;for(const o in r){const l=r[o],c=e(l,n);t.setAttribute(o,c)}const s=this.morphAttributes;for(const o in s){const l=[],c=s[o];for(let u=0,f=c.length;u<f;u++){const d=c[u],p=e(d,n);l.push(p)}t.morphAttributes[o]=l}t.morphTargetsRelative=this.morphTargetsRelative;const a=this.groups;for(let o=0,l=a.length;o<l;o++){const c=a[o];t.addGroup(c.start,c.count,c.materialIndex)}return t}toJSON(){const e={metadata:{version:4.5,type:"BufferGeometry",generator:"BufferGeometry.toJSON"}};if(e.uuid=this.uuid,e.type=this.type,this.name!==""&&(e.name=this.name),Object.keys(this.userData).length>0&&(e.userData=this.userData),this.parameters!==void 0){const l=this.parameters;for(const c in l)l[c]!==void 0&&(e[c]=l[c]);return e}e.data={attributes:{}};const t=this.index;t!==null&&(e.data.index={type:t.array.constructor.name,array:Array.prototype.slice.call(t.array)});const n=this.attributes;for(const l in n){const c=n[l];e.data.attributes[l]=c.toJSON(e.data)}const r={};let s=!1;for(const l in this.morphAttributes){const c=this.morphAttributes[l],u=[];for(let f=0,d=c.length;f<d;f++){const p=c[f];u.push(p.toJSON(e.data))}u.length>0&&(r[l]=u,s=!0)}s&&(e.data.morphAttributes=r,e.data.morphTargetsRelative=this.morphTargetsRelative);const a=this.groups;a.length>0&&(e.data.groups=JSON.parse(JSON.stringify(a)));const o=this.boundingSphere;return o!==null&&(e.data.boundingSphere={center:o.center.toArray(),radius:o.radius}),e}clone(){return new this.constructor().copy(this)}copy(e){this.index=null,this.attributes={},this.morphAttributes={},this.groups=[],this.boundingBox=null,this.boundingSphere=null;const t={};this.name=e.name;const n=e.index;n!==null&&this.setIndex(n.clone(t));const r=e.attributes;for(const c in r){const u=r[c];this.setAttribute(c,u.clone(t))}const s=e.morphAttributes;for(const c in s){const u=[],f=s[c];for(let d=0,p=f.length;d<p;d++)u.push(f[d].clone(t));this.morphAttributes[c]=u}this.morphTargetsRelative=e.morphTargetsRelative;const a=e.groups;for(let c=0,u=a.length;c<u;c++){const f=a[c];this.addGroup(f.start,f.count,f.materialIndex)}const o=e.boundingBox;o!==null&&(this.boundingBox=o.clone());const l=e.boundingSphere;return l!==null&&(this.boundingSphere=l.clone()),this.drawRange.start=e.drawRange.start,this.drawRange.count=e.drawRange.count,this.userData=e.userData,this}dispose(){this.dispatchEvent({type:"dispose"})}}const kl=new Tt,wn=new xa,Fr=new ms,Il=new B,$i=new B,er=new B,tr=new B,Ys=new B,Or=new B,Ur=new st,Br=new st,Vr=new st,Zs=new B,Gr=new B;class Te extends zt{constructor(e=new $t,t=new _s){super(),this.isMesh=!0,this.type="Mesh",this.geometry=e,this.material=t,this.updateMorphTargets()}copy(e,t){return super.copy(e,t),e.morphTargetInfluences!==void 0&&(this.morphTargetInfluences=e.morphTargetInfluences.slice()),e.morphTargetDictionary!==void 0&&(this.morphTargetDictionary=Object.assign({},e.morphTargetDictionary)),this.material=e.material,this.geometry=e.geometry,this}updateMorphTargets(){const t=this.geometry.morphAttributes,n=Object.keys(t);if(n.length>0){const r=t[n[0]];if(r!==void 0){this.morphTargetInfluences=[],this.morphTargetDictionary={};for(let s=0,a=r.length;s<a;s++){const o=r[s].name||String(s);this.morphTargetInfluences.push(0),this.morphTargetDictionary[o]=s}}}}getVertexPosition(e,t){const n=this.geometry,r=n.attributes.position,s=n.morphAttributes.position,a=n.morphTargetsRelative;t.fromBufferAttribute(r,e);const o=this.morphTargetInfluences;if(s&&o){Or.set(0,0,0);for(let l=0,c=s.length;l<c;l++){const u=o[l],f=s[l];u!==0&&(Ys.fromBufferAttribute(f,e),a?Or.addScaledVector(Ys,u):Or.addScaledVector(Ys.sub(t),u))}t.add(Or)}return this.isSkinnedMesh&&this.boneTransform(e,t),t}raycast(e,t){const n=this.geometry,r=this.material,s=this.matrixWorld;if(r===void 0||(n.boundingSphere===null&&n.computeBoundingSphere(),Fr.copy(n.boundingSphere),Fr.applyMatrix4(s),wn.copy(e.ray).recast(e.near),Fr.containsPoint(wn.origin)===!1&&(wn.intersectSphere(Fr,Il)===null||wn.origin.distanceToSquared(Il)>(e.far-e.near)**2))||(kl.copy(s).invert(),wn.copy(e.ray).applyMatrix4(kl),n.boundingBox!==null&&wn.intersectsBox(n.boundingBox)===!1))return;let a;const o=n.index,l=n.attributes.position,c=n.attributes.uv,u=n.attributes.uv2,f=n.groups,d=n.drawRange;if(o!==null)if(Array.isArray(r))for(let p=0,m=f.length;p<m;p++){const h=f[p],_=r[h.materialIndex],g=Math.max(h.start,d.start),v=Math.min(o.count,Math.min(h.start+h.count,d.start+d.count));for(let b=g,y=v;b<y;b+=3){const w=o.getX(b),M=o.getX(b+1),E=o.getX(b+2);a=Hr(this,_,e,wn,c,u,w,M,E),a&&(a.faceIndex=Math.floor(b/3),a.face.materialIndex=h.materialIndex,t.push(a))}}else{const p=Math.max(0,d.start),m=Math.min(o.count,d.start+d.count);for(let h=p,_=m;h<_;h+=3){const g=o.getX(h),v=o.getX(h+1),b=o.getX(h+2);a=Hr(this,r,e,wn,c,u,g,v,b),a&&(a.faceIndex=Math.floor(h/3),t.push(a))}}else if(l!==void 0)if(Array.isArray(r))for(let p=0,m=f.length;p<m;p++){const h=f[p],_=r[h.materialIndex],g=Math.max(h.start,d.start),v=Math.min(l.count,Math.min(h.start+h.count,d.start+d.count));for(let b=g,y=v;b<y;b+=3){const w=b,M=b+1,E=b+2;a=Hr(this,_,e,wn,c,u,w,M,E),a&&(a.faceIndex=Math.floor(b/3),a.face.materialIndex=h.materialIndex,t.push(a))}}else{const p=Math.max(0,d.start),m=Math.min(l.count,d.start+d.count);for(let h=p,_=m;h<_;h+=3){const g=h,v=h+1,b=h+2;a=Hr(this,r,e,wn,c,u,g,v,b),a&&(a.faceIndex=Math.floor(h/3),t.push(a))}}}}function S_(i,e,t,n,r,s,a,o){let l;if(e.side===an?l=n.intersectTriangle(a,s,r,!0,o):l=n.intersectTriangle(r,s,a,e.side===Zn,o),l===null)return null;Gr.copy(o),Gr.applyMatrix4(i.matrixWorld);const c=t.ray.origin.distanceTo(Gr);return c<t.near||c>t.far?null:{distance:c,point:Gr.clone(),object:i}}function Hr(i,e,t,n,r,s,a,o,l){i.getVertexPosition(a,$i),i.getVertexPosition(o,er),i.getVertexPosition(l,tr);const c=S_(i,e,t,n,$i,er,tr,Zs);if(c){r&&(Ur.fromBufferAttribute(r,a),Br.fromBufferAttribute(r,o),Vr.fromBufferAttribute(r,l),c.uv=In.getUV(Zs,$i,er,tr,Ur,Br,Vr,new st)),s&&(Ur.fromBufferAttribute(s,a),Br.fromBufferAttribute(s,o),Vr.fromBufferAttribute(s,l),c.uv2=In.getUV(Zs,$i,er,tr,Ur,Br,Vr,new st));const u={a,b:o,c:l,normal:new B,materialIndex:0};In.getNormal($i,er,tr,u.normal),c.face=u}return c}class Ct extends $t{constructor(e=1,t=1,n=1,r=1,s=1,a=1){super(),this.type="BoxGeometry",this.parameters={width:e,height:t,depth:n,widthSegments:r,heightSegments:s,depthSegments:a};const o=this;r=Math.floor(r),s=Math.floor(s),a=Math.floor(a);const l=[],c=[],u=[],f=[];let d=0,p=0;m("z","y","x",-1,-1,n,t,e,a,s,0),m("z","y","x",1,-1,n,t,-e,a,s,1),m("x","z","y",1,1,e,n,t,r,a,2),m("x","z","y",1,-1,e,n,-t,r,a,3),m("x","y","z",1,-1,e,t,n,r,s,4),m("x","y","z",-1,-1,e,t,-n,r,s,5),this.setIndex(l),this.setAttribute("position",new bt(c,3)),this.setAttribute("normal",new bt(u,3)),this.setAttribute("uv",new bt(f,2));function m(h,_,g,v,b,y,w,M,E,x,C){const A=y/E,D=w/x,G=y/2,U=w/2,z=M/2,X=E+1,ae=x+1;let le=0,$=0;const ne=new B;for(let ue=0;ue<ae;ue++){const be=ue*D-U;for(let q=0;q<X;q++){const ce=q*A-G;ne[h]=ce*v,ne[_]=be*b,ne[g]=z,c.push(ne.x,ne.y,ne.z),ne[h]=0,ne[_]=0,ne[g]=M>0?1:-1,u.push(ne.x,ne.y,ne.z),f.push(q/E),f.push(1-ue/x),le+=1}}for(let ue=0;ue<x;ue++)for(let be=0;be<E;be++){const q=d+be+X*ue,ce=d+be+X*(ue+1),he=d+(be+1)+X*(ue+1),W=d+(be+1)+X*ue;l.push(q,ce,W),l.push(ce,he,W),$+=6}o.addGroup(p,$,C),p+=$,d+=le}}copy(e){return super.copy(e),this.parameters=Object.assign({},e.parameters),this}static fromJSON(e){return new Ct(e.width,e.height,e.depth,e.widthSegments,e.heightSegments,e.depthSegments)}}function Hi(i){const e={};for(const t in i){e[t]={};for(const n in i[t]){const r=i[t][n];r&&(r.isColor||r.isMatrix3||r.isMatrix4||r.isVector2||r.isVector3||r.isVector4||r.isTexture||r.isQuaternion)?e[t][n]=r.clone():Array.isArray(r)?e[t][n]=r.slice():e[t][n]=r}}return e}function Xt(i){const e={};for(let t=0;t<i.length;t++){const n=Hi(i[t]);for(const r in n)e[r]=n[r]}return e}function C_(i){const e=[];for(let t=0;t<i.length;t++)e.push(i[t].clone());return e}function Xc(i){return i.getRenderTarget()===null&&i.outputEncoding===pt?Mn:vr}const T_={clone:Hi,merge:Xt};var E_=`void main() {
	gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}`,L_=`void main() {
	gl_FragColor = vec4( 1.0, 0.0, 0.0, 1.0 );
}`;class mi extends Tr{constructor(e){super(),this.isShaderMaterial=!0,this.type="ShaderMaterial",this.defines={},this.uniforms={},this.uniformsGroups=[],this.vertexShader=E_,this.fragmentShader=L_,this.linewidth=1,this.wireframe=!1,this.wireframeLinewidth=1,this.fog=!1,this.lights=!1,this.clipping=!1,this.extensions={derivatives:!1,fragDepth:!1,drawBuffers:!1,shaderTextureLOD:!1},this.defaultAttributeValues={color:[1,1,1],uv:[0,0],uv2:[0,0]},this.index0AttributeName=void 0,this.uniformsNeedUpdate=!1,this.glslVersion=null,e!==void 0&&this.setValues(e)}copy(e){return super.copy(e),this.fragmentShader=e.fragmentShader,this.vertexShader=e.vertexShader,this.uniforms=Hi(e.uniforms),this.uniformsGroups=C_(e.uniformsGroups),this.defines=Object.assign({},e.defines),this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.fog=e.fog,this.lights=e.lights,this.clipping=e.clipping,this.extensions=Object.assign({},e.extensions),this.glslVersion=e.glslVersion,this}toJSON(e){const t=super.toJSON(e);t.glslVersion=this.glslVersion,t.uniforms={};for(const r in this.uniforms){const a=this.uniforms[r].value;a&&a.isTexture?t.uniforms[r]={type:"t",value:a.toJSON(e).uuid}:a&&a.isColor?t.uniforms[r]={type:"c",value:a.getHex()}:a&&a.isVector2?t.uniforms[r]={type:"v2",value:a.toArray()}:a&&a.isVector3?t.uniforms[r]={type:"v3",value:a.toArray()}:a&&a.isVector4?t.uniforms[r]={type:"v4",value:a.toArray()}:a&&a.isMatrix3?t.uniforms[r]={type:"m3",value:a.toArray()}:a&&a.isMatrix4?t.uniforms[r]={type:"m4",value:a.toArray()}:t.uniforms[r]={value:a}}Object.keys(this.defines).length>0&&(t.defines=this.defines),t.vertexShader=this.vertexShader,t.fragmentShader=this.fragmentShader;const n={};for(const r in this.extensions)this.extensions[r]===!0&&(n[r]=!0);return Object.keys(n).length>0&&(t.extensions=n),t}}class jc extends zt{constructor(){super(),this.isCamera=!0,this.type="Camera",this.matrixWorldInverse=new Tt,this.projectionMatrix=new Tt,this.projectionMatrixInverse=new Tt}copy(e,t){return super.copy(e,t),this.matrixWorldInverse.copy(e.matrixWorldInverse),this.projectionMatrix.copy(e.projectionMatrix),this.projectionMatrixInverse.copy(e.projectionMatrixInverse),this}getWorldDirection(e){this.updateWorldMatrix(!0,!1);const t=this.matrixWorld.elements;return e.set(-t[8],-t[9],-t[10]).normalize()}updateMatrixWorld(e){super.updateMatrixWorld(e),this.matrixWorldInverse.copy(this.matrixWorld).invert()}updateWorldMatrix(e,t){super.updateWorldMatrix(e,t),this.matrixWorldInverse.copy(this.matrixWorld).invert()}clone(){return new this.constructor().copy(this)}}class dn extends jc{constructor(e=50,t=1,n=.1,r=2e3){super(),this.isPerspectiveCamera=!0,this.type="PerspectiveCamera",this.fov=e,this.zoom=1,this.near=n,this.far=r,this.focus=10,this.aspect=t,this.view=null,this.filmGauge=35,this.filmOffset=0,this.updateProjectionMatrix()}copy(e,t){return super.copy(e,t),this.fov=e.fov,this.zoom=e.zoom,this.near=e.near,this.far=e.far,this.focus=e.focus,this.aspect=e.aspect,this.view=e.view===null?null:Object.assign({},e.view),this.filmGauge=e.filmGauge,this.filmOffset=e.filmOffset,this}setFocalLength(e){const t=.5*this.getFilmHeight()/e;this.fov=us*2*Math.atan(t),this.updateProjectionMatrix()}getFocalLength(){const e=Math.tan(dr*.5*this.fov);return .5*this.getFilmHeight()/e}getEffectiveFOV(){return us*2*Math.atan(Math.tan(dr*.5*this.fov)/this.zoom)}getFilmWidth(){return this.filmGauge*Math.min(this.aspect,1)}getFilmHeight(){return this.filmGauge/Math.max(this.aspect,1)}setViewOffset(e,t,n,r,s,a){this.aspect=e/t,this.view===null&&(this.view={enabled:!0,fullWidth:1,fullHeight:1,offsetX:0,offsetY:0,width:1,height:1}),this.view.enabled=!0,this.view.fullWidth=e,this.view.fullHeight=t,this.view.offsetX=n,this.view.offsetY=r,this.view.width=s,this.view.height=a,this.updateProjectionMatrix()}clearViewOffset(){this.view!==null&&(this.view.enabled=!1),this.updateProjectionMatrix()}updateProjectionMatrix(){const e=this.near;let t=e*Math.tan(dr*.5*this.fov)/this.zoom,n=2*t,r=this.aspect*n,s=-.5*r;const a=this.view;if(this.view!==null&&this.view.enabled){const l=a.fullWidth,c=a.fullHeight;s+=a.offsetX*r/l,t-=a.offsetY*n/c,r*=a.width/l,n*=a.height/c}const o=this.filmOffset;o!==0&&(s+=e*o/this.getFilmWidth()),this.projectionMatrix.makePerspective(s,s+r,t,t-n,e,this.far),this.projectionMatrixInverse.copy(this.projectionMatrix).invert()}toJSON(e){const t=super.toJSON(e);return t.object.fov=this.fov,t.object.zoom=this.zoom,t.object.near=this.near,t.object.far=this.far,t.object.focus=this.focus,t.object.aspect=this.aspect,this.view!==null&&(t.object.view=Object.assign({},this.view)),t.object.filmGauge=this.filmGauge,t.object.filmOffset=this.filmOffset,t}}const Ti=-90,Ei=1;class P_ extends zt{constructor(e,t,n){super(),this.type="CubeCamera",this.renderTarget=n;const r=new dn(Ti,Ei,e,t);r.layers=this.layers,r.up.set(0,1,0),r.lookAt(1,0,0),this.add(r);const s=new dn(Ti,Ei,e,t);s.layers=this.layers,s.up.set(0,1,0),s.lookAt(-1,0,0),this.add(s);const a=new dn(Ti,Ei,e,t);a.layers=this.layers,a.up.set(0,0,-1),a.lookAt(0,1,0),this.add(a);const o=new dn(Ti,Ei,e,t);o.layers=this.layers,o.up.set(0,0,1),o.lookAt(0,-1,0),this.add(o);const l=new dn(Ti,Ei,e,t);l.layers=this.layers,l.up.set(0,1,0),l.lookAt(0,0,1),this.add(l);const c=new dn(Ti,Ei,e,t);c.layers=this.layers,c.up.set(0,1,0),c.lookAt(0,0,-1),this.add(c)}update(e,t){this.parent===null&&this.updateMatrixWorld();const n=this.renderTarget,[r,s,a,o,l,c]=this.children,u=e.getRenderTarget(),f=e.toneMapping,d=e.xr.enabled;e.toneMapping=Un,e.xr.enabled=!1;const p=n.texture.generateMipmaps;n.texture.generateMipmaps=!1,e.setRenderTarget(n,0),e.render(t,r),e.setRenderTarget(n,1),e.render(t,s),e.setRenderTarget(n,2),e.render(t,a),e.setRenderTarget(n,3),e.render(t,o),e.setRenderTarget(n,4),e.render(t,l),n.texture.generateMipmaps=p,e.setRenderTarget(n,5),e.render(t,c),e.setRenderTarget(u),e.toneMapping=f,e.xr.enabled=d,n.texture.needsPMREMUpdate=!0}}class qc extends on{constructor(e,t,n,r,s,a,o,l,c,u){e=e!==void 0?e:[],t=t!==void 0?t:Bi,super(e,t,n,r,s,a,o,l,c,u),this.isCubeTexture=!0,this.flipY=!1}get images(){return this.image}set images(e){this.image=e}}class A_ extends pi{constructor(e=1,t={}){super(e,e,t),this.isWebGLCubeRenderTarget=!0;const n={width:e,height:e,depth:1},r=[n,n,n,n,n,n];this.texture=new qc(r,t.mapping,t.wrapS,t.wrapT,t.magFilter,t.minFilter,t.format,t.type,t.anisotropy,t.encoding),this.texture.isRenderTargetTexture=!0,this.texture.generateMipmaps=t.generateMipmaps!==void 0?t.generateMipmaps:!1,this.texture.minFilter=t.minFilter!==void 0?t.minFilter:fn}fromEquirectangularTexture(e,t){this.texture.type=t.type,this.texture.encoding=t.encoding,this.texture.generateMipmaps=t.generateMipmaps,this.texture.minFilter=t.minFilter,this.texture.magFilter=t.magFilter;const n={uniforms:{tEquirect:{value:null}},vertexShader:`

				varying vec3 vWorldDirection;

				vec3 transformDirection( in vec3 dir, in mat4 matrix ) {

					return normalize( ( matrix * vec4( dir, 0.0 ) ).xyz );

				}

				void main() {

					vWorldDirection = transformDirection( position, modelMatrix );

					#include <begin_vertex>
					#include <project_vertex>

				}
			`,fragmentShader:`

				uniform sampler2D tEquirect;

				varying vec3 vWorldDirection;

				#include <common>

				void main() {

					vec3 direction = normalize( vWorldDirection );

					vec2 sampleUV = equirectUv( direction );

					gl_FragColor = texture2D( tEquirect, sampleUV );

				}
			`},r=new Ct(5,5,5),s=new mi({name:"CubemapFromEquirect",uniforms:Hi(n.uniforms),vertexShader:n.vertexShader,fragmentShader:n.fragmentShader,side:an,blending:Yn});s.uniforms.tEquirect.value=t;const a=new Te(r,s),o=t.minFilter;return t.minFilter===gr&&(t.minFilter=fn),new P_(1,10,this).update(e,a),t.minFilter=o,a.geometry.dispose(),a.material.dispose(),this}clear(e,t,n,r){const s=e.getRenderTarget();for(let a=0;a<6;a++)e.setRenderTarget(this,a),e.clear(t,n,r);e.setRenderTarget(s)}}const Ks=new B,D_=new B,R_=new Yt;class ii{constructor(e=new B(1,0,0),t=0){this.isPlane=!0,this.normal=e,this.constant=t}set(e,t){return this.normal.copy(e),this.constant=t,this}setComponents(e,t,n,r){return this.normal.set(e,t,n),this.constant=r,this}setFromNormalAndCoplanarPoint(e,t){return this.normal.copy(e),this.constant=-t.dot(this.normal),this}setFromCoplanarPoints(e,t,n){const r=Ks.subVectors(n,t).cross(D_.subVectors(e,t)).normalize();return this.setFromNormalAndCoplanarPoint(r,e),this}copy(e){return this.normal.copy(e.normal),this.constant=e.constant,this}normalize(){const e=1/this.normal.length();return this.normal.multiplyScalar(e),this.constant*=e,this}negate(){return this.constant*=-1,this.normal.negate(),this}distanceToPoint(e){return this.normal.dot(e)+this.constant}distanceToSphere(e){return this.distanceToPoint(e.center)-e.radius}projectPoint(e,t){return t.copy(e).addScaledVector(this.normal,-this.distanceToPoint(e))}intersectLine(e,t){const n=e.delta(Ks),r=this.normal.dot(n);if(r===0)return this.distanceToPoint(e.start)===0?t.copy(e.start):null;const s=-(e.start.dot(this.normal)+this.constant)/r;return s<0||s>1?null:t.copy(e.start).addScaledVector(n,s)}intersectsLine(e){const t=this.distanceToPoint(e.start),n=this.distanceToPoint(e.end);return t<0&&n>0||n<0&&t>0}intersectsBox(e){return e.intersectsPlane(this)}intersectsSphere(e){return e.intersectsPlane(this)}coplanarPoint(e){return e.copy(this.normal).multiplyScalar(-this.constant)}applyMatrix4(e,t){const n=t||R_.getNormalMatrix(e),r=this.coplanarPoint(Ks).applyMatrix4(e),s=this.normal.applyMatrix3(n).normalize();return this.constant=-r.dot(s),this}translate(e){return this.constant-=e.dot(this.normal),this}equals(e){return e.normal.equals(this.normal)&&e.constant===this.constant}clone(){return new this.constructor().copy(this)}}const Li=new ms,Wr=new B;class Yc{constructor(e=new ii,t=new ii,n=new ii,r=new ii,s=new ii,a=new ii){this.planes=[e,t,n,r,s,a]}set(e,t,n,r,s,a){const o=this.planes;return o[0].copy(e),o[1].copy(t),o[2].copy(n),o[3].copy(r),o[4].copy(s),o[5].copy(a),this}copy(e){const t=this.planes;for(let n=0;n<6;n++)t[n].copy(e.planes[n]);return this}setFromProjectionMatrix(e){const t=this.planes,n=e.elements,r=n[0],s=n[1],a=n[2],o=n[3],l=n[4],c=n[5],u=n[6],f=n[7],d=n[8],p=n[9],m=n[10],h=n[11],_=n[12],g=n[13],v=n[14],b=n[15];return t[0].setComponents(o-r,f-l,h-d,b-_).normalize(),t[1].setComponents(o+r,f+l,h+d,b+_).normalize(),t[2].setComponents(o+s,f+c,h+p,b+g).normalize(),t[3].setComponents(o-s,f-c,h-p,b-g).normalize(),t[4].setComponents(o-a,f-u,h-m,b-v).normalize(),t[5].setComponents(o+a,f+u,h+m,b+v).normalize(),this}intersectsObject(e){const t=e.geometry;return t.boundingSphere===null&&t.computeBoundingSphere(),Li.copy(t.boundingSphere).applyMatrix4(e.matrixWorld),this.intersectsSphere(Li)}intersectsSprite(e){return Li.center.set(0,0,0),Li.radius=.7071067811865476,Li.applyMatrix4(e.matrixWorld),this.intersectsSphere(Li)}intersectsSphere(e){const t=this.planes,n=e.center,r=-e.radius;for(let s=0;s<6;s++)if(t[s].distanceToPoint(n)<r)return!1;return!0}intersectsBox(e){const t=this.planes;for(let n=0;n<6;n++){const r=t[n];if(Wr.x=r.normal.x>0?e.max.x:e.min.x,Wr.y=r.normal.y>0?e.max.y:e.min.y,Wr.z=r.normal.z>0?e.max.z:e.min.z,r.distanceToPoint(Wr)<0)return!1}return!0}containsPoint(e){const t=this.planes;for(let n=0;n<6;n++)if(t[n].distanceToPoint(e)<0)return!1;return!0}clone(){return new this.constructor().copy(this)}}function Zc(){let i=null,e=!1,t=null,n=null;function r(s,a){t(s,a),n=i.requestAnimationFrame(r)}return{start:function(){e!==!0&&t!==null&&(n=i.requestAnimationFrame(r),e=!0)},stop:function(){i.cancelAnimationFrame(n),e=!1},setAnimationLoop:function(s){t=s},setContext:function(s){i=s}}}function k_(i,e){const t=e.isWebGL2,n=new WeakMap;function r(c,u){const f=c.array,d=c.usage,p=i.createBuffer();i.bindBuffer(u,p),i.bufferData(u,f,d),c.onUploadCallback();let m;if(f instanceof Float32Array)m=5126;else if(f instanceof Uint16Array)if(c.isFloat16BufferAttribute)if(t)m=5131;else throw new Error("THREE.WebGLAttributes: Usage of Float16BufferAttribute requires WebGL2.");else m=5123;else if(f instanceof Int16Array)m=5122;else if(f instanceof Uint32Array)m=5125;else if(f instanceof Int32Array)m=5124;else if(f instanceof Int8Array)m=5120;else if(f instanceof Uint8Array)m=5121;else if(f instanceof Uint8ClampedArray)m=5121;else throw new Error("THREE.WebGLAttributes: Unsupported buffer data format: "+f);return{buffer:p,type:m,bytesPerElement:f.BYTES_PER_ELEMENT,version:c.version}}function s(c,u,f){const d=u.array,p=u.updateRange;i.bindBuffer(f,c),p.count===-1?i.bufferSubData(f,0,d):(t?i.bufferSubData(f,p.offset*d.BYTES_PER_ELEMENT,d,p.offset,p.count):i.bufferSubData(f,p.offset*d.BYTES_PER_ELEMENT,d.subarray(p.offset,p.offset+p.count)),p.count=-1),u.onUploadCallback()}function a(c){return c.isInterleavedBufferAttribute&&(c=c.data),n.get(c)}function o(c){c.isInterleavedBufferAttribute&&(c=c.data);const u=n.get(c);u&&(i.deleteBuffer(u.buffer),n.delete(c))}function l(c,u){if(c.isGLBufferAttribute){const d=n.get(c);(!d||d.version<c.version)&&n.set(c,{buffer:c.buffer,type:c.type,bytesPerElement:c.elementSize,version:c.version});return}c.isInterleavedBufferAttribute&&(c=c.data);const f=n.get(c);f===void 0?n.set(c,r(c,u)):f.version<c.version&&(s(f.buffer,c,u),f.version=c.version)}return{get:a,remove:o,update:l}}class gs extends $t{constructor(e=1,t=1,n=1,r=1){super(),this.type="PlaneGeometry",this.parameters={width:e,height:t,widthSegments:n,heightSegments:r};const s=e/2,a=t/2,o=Math.floor(n),l=Math.floor(r),c=o+1,u=l+1,f=e/o,d=t/l,p=[],m=[],h=[],_=[];for(let g=0;g<u;g++){const v=g*d-a;for(let b=0;b<c;b++){const y=b*f-s;m.push(y,-v,0),h.push(0,0,1),_.push(b/o),_.push(1-g/l)}}for(let g=0;g<l;g++)for(let v=0;v<o;v++){const b=v+c*g,y=v+c*(g+1),w=v+1+c*(g+1),M=v+1+c*g;p.push(b,y,M),p.push(y,w,M)}this.setIndex(p),this.setAttribute("position",new bt(m,3)),this.setAttribute("normal",new bt(h,3)),this.setAttribute("uv",new bt(_,2))}copy(e){return super.copy(e),this.parameters=Object.assign({},e.parameters),this}static fromJSON(e){return new gs(e.width,e.height,e.widthSegments,e.heightSegments)}}var I_=`#ifdef USE_ALPHAMAP
	diffuseColor.a *= texture2D( alphaMap, vUv ).g;
#endif`,N_=`#ifdef USE_ALPHAMAP
	uniform sampler2D alphaMap;
#endif`,z_=`#ifdef USE_ALPHATEST
	if ( diffuseColor.a < alphaTest ) discard;
#endif`,F_=`#ifdef USE_ALPHATEST
	uniform float alphaTest;
#endif`,O_=`#ifdef USE_AOMAP
	float ambientOcclusion = ( texture2D( aoMap, vUv2 ).r - 1.0 ) * aoMapIntensity + 1.0;
	reflectedLight.indirectDiffuse *= ambientOcclusion;
	#if defined( USE_ENVMAP ) && defined( STANDARD )
		float dotNV = saturate( dot( geometry.normal, geometry.viewDir ) );
		reflectedLight.indirectSpecular *= computeSpecularOcclusion( dotNV, ambientOcclusion, material.roughness );
	#endif
#endif`,U_=`#ifdef USE_AOMAP
	uniform sampler2D aoMap;
	uniform float aoMapIntensity;
#endif`,B_="vec3 transformed = vec3( position );",V_=`vec3 objectNormal = vec3( normal );
#ifdef USE_TANGENT
	vec3 objectTangent = vec3( tangent.xyz );
#endif`,G_=`vec3 BRDF_Lambert( const in vec3 diffuseColor ) {
	return RECIPROCAL_PI * diffuseColor;
}
vec3 F_Schlick( const in vec3 f0, const in float f90, const in float dotVH ) {
	float fresnel = exp2( ( - 5.55473 * dotVH - 6.98316 ) * dotVH );
	return f0 * ( 1.0 - fresnel ) + ( f90 * fresnel );
}
float F_Schlick( const in float f0, const in float f90, const in float dotVH ) {
	float fresnel = exp2( ( - 5.55473 * dotVH - 6.98316 ) * dotVH );
	return f0 * ( 1.0 - fresnel ) + ( f90 * fresnel );
}
vec3 Schlick_to_F0( const in vec3 f, const in float f90, const in float dotVH ) {
    float x = clamp( 1.0 - dotVH, 0.0, 1.0 );
    float x2 = x * x;
    float x5 = clamp( x * x2 * x2, 0.0, 0.9999 );
    return ( f - vec3( f90 ) * x5 ) / ( 1.0 - x5 );
}
float V_GGX_SmithCorrelated( const in float alpha, const in float dotNL, const in float dotNV ) {
	float a2 = pow2( alpha );
	float gv = dotNL * sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNV ) );
	float gl = dotNV * sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNL ) );
	return 0.5 / max( gv + gl, EPSILON );
}
float D_GGX( const in float alpha, const in float dotNH ) {
	float a2 = pow2( alpha );
	float denom = pow2( dotNH ) * ( a2 - 1.0 ) + 1.0;
	return RECIPROCAL_PI * a2 / pow2( denom );
}
vec3 BRDF_GGX( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, const in vec3 f0, const in float f90, const in float roughness ) {
	float alpha = pow2( roughness );
	vec3 halfDir = normalize( lightDir + viewDir );
	float dotNL = saturate( dot( normal, lightDir ) );
	float dotNV = saturate( dot( normal, viewDir ) );
	float dotNH = saturate( dot( normal, halfDir ) );
	float dotVH = saturate( dot( viewDir, halfDir ) );
	vec3 F = F_Schlick( f0, f90, dotVH );
	float V = V_GGX_SmithCorrelated( alpha, dotNL, dotNV );
	float D = D_GGX( alpha, dotNH );
	return F * ( V * D );
}
#ifdef USE_IRIDESCENCE
	vec3 BRDF_GGX_Iridescence( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, const in vec3 f0, const in float f90, const in float iridescence, const in vec3 iridescenceFresnel, const in float roughness ) {
		float alpha = pow2( roughness );
		vec3 halfDir = normalize( lightDir + viewDir );
		float dotNL = saturate( dot( normal, lightDir ) );
		float dotNV = saturate( dot( normal, viewDir ) );
		float dotNH = saturate( dot( normal, halfDir ) );
		float dotVH = saturate( dot( viewDir, halfDir ) );
		vec3 F = mix( F_Schlick( f0, f90, dotVH ), iridescenceFresnel, iridescence );
		float V = V_GGX_SmithCorrelated( alpha, dotNL, dotNV );
		float D = D_GGX( alpha, dotNH );
		return F * ( V * D );
	}
#endif
vec2 LTC_Uv( const in vec3 N, const in vec3 V, const in float roughness ) {
	const float LUT_SIZE = 64.0;
	const float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
	const float LUT_BIAS = 0.5 / LUT_SIZE;
	float dotNV = saturate( dot( N, V ) );
	vec2 uv = vec2( roughness, sqrt( 1.0 - dotNV ) );
	uv = uv * LUT_SCALE + LUT_BIAS;
	return uv;
}
float LTC_ClippedSphereFormFactor( const in vec3 f ) {
	float l = length( f );
	return max( ( l * l + f.z ) / ( l + 1.0 ), 0.0 );
}
vec3 LTC_EdgeVectorFormFactor( const in vec3 v1, const in vec3 v2 ) {
	float x = dot( v1, v2 );
	float y = abs( x );
	float a = 0.8543985 + ( 0.4965155 + 0.0145206 * y ) * y;
	float b = 3.4175940 + ( 4.1616724 + y ) * y;
	float v = a / b;
	float theta_sintheta = ( x > 0.0 ) ? v : 0.5 * inversesqrt( max( 1.0 - x * x, 1e-7 ) ) - v;
	return cross( v1, v2 ) * theta_sintheta;
}
vec3 LTC_Evaluate( const in vec3 N, const in vec3 V, const in vec3 P, const in mat3 mInv, const in vec3 rectCoords[ 4 ] ) {
	vec3 v1 = rectCoords[ 1 ] - rectCoords[ 0 ];
	vec3 v2 = rectCoords[ 3 ] - rectCoords[ 0 ];
	vec3 lightNormal = cross( v1, v2 );
	if( dot( lightNormal, P - rectCoords[ 0 ] ) < 0.0 ) return vec3( 0.0 );
	vec3 T1, T2;
	T1 = normalize( V - N * dot( V, N ) );
	T2 = - cross( N, T1 );
	mat3 mat = mInv * transposeMat3( mat3( T1, T2, N ) );
	vec3 coords[ 4 ];
	coords[ 0 ] = mat * ( rectCoords[ 0 ] - P );
	coords[ 1 ] = mat * ( rectCoords[ 1 ] - P );
	coords[ 2 ] = mat * ( rectCoords[ 2 ] - P );
	coords[ 3 ] = mat * ( rectCoords[ 3 ] - P );
	coords[ 0 ] = normalize( coords[ 0 ] );
	coords[ 1 ] = normalize( coords[ 1 ] );
	coords[ 2 ] = normalize( coords[ 2 ] );
	coords[ 3 ] = normalize( coords[ 3 ] );
	vec3 vectorFormFactor = vec3( 0.0 );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 0 ], coords[ 1 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 1 ], coords[ 2 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 2 ], coords[ 3 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 3 ], coords[ 0 ] );
	float result = LTC_ClippedSphereFormFactor( vectorFormFactor );
	return vec3( result );
}
float G_BlinnPhong_Implicit( ) {
	return 0.25;
}
float D_BlinnPhong( const in float shininess, const in float dotNH ) {
	return RECIPROCAL_PI * ( shininess * 0.5 + 1.0 ) * pow( dotNH, shininess );
}
vec3 BRDF_BlinnPhong( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, const in vec3 specularColor, const in float shininess ) {
	vec3 halfDir = normalize( lightDir + viewDir );
	float dotNH = saturate( dot( normal, halfDir ) );
	float dotVH = saturate( dot( viewDir, halfDir ) );
	vec3 F = F_Schlick( specularColor, 1.0, dotVH );
	float G = G_BlinnPhong_Implicit( );
	float D = D_BlinnPhong( shininess, dotNH );
	return F * ( G * D );
}
#if defined( USE_SHEEN )
float D_Charlie( float roughness, float dotNH ) {
	float alpha = pow2( roughness );
	float invAlpha = 1.0 / alpha;
	float cos2h = dotNH * dotNH;
	float sin2h = max( 1.0 - cos2h, 0.0078125 );
	return ( 2.0 + invAlpha ) * pow( sin2h, invAlpha * 0.5 ) / ( 2.0 * PI );
}
float V_Neubelt( float dotNV, float dotNL ) {
	return saturate( 1.0 / ( 4.0 * ( dotNL + dotNV - dotNL * dotNV ) ) );
}
vec3 BRDF_Sheen( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, vec3 sheenColor, const in float sheenRoughness ) {
	vec3 halfDir = normalize( lightDir + viewDir );
	float dotNL = saturate( dot( normal, lightDir ) );
	float dotNV = saturate( dot( normal, viewDir ) );
	float dotNH = saturate( dot( normal, halfDir ) );
	float D = D_Charlie( sheenRoughness, dotNH );
	float V = V_Neubelt( dotNV, dotNL );
	return sheenColor * ( D * V );
}
#endif`,H_=`#ifdef USE_IRIDESCENCE
	const mat3 XYZ_TO_REC709 = mat3(
		 3.2404542, -0.9692660,  0.0556434,
		-1.5371385,  1.8760108, -0.2040259,
		-0.4985314,  0.0415560,  1.0572252
	);
	vec3 Fresnel0ToIor( vec3 fresnel0 ) {
		vec3 sqrtF0 = sqrt( fresnel0 );
		return ( vec3( 1.0 ) + sqrtF0 ) / ( vec3( 1.0 ) - sqrtF0 );
	}
	vec3 IorToFresnel0( vec3 transmittedIor, float incidentIor ) {
		return pow2( ( transmittedIor - vec3( incidentIor ) ) / ( transmittedIor + vec3( incidentIor ) ) );
	}
	float IorToFresnel0( float transmittedIor, float incidentIor ) {
		return pow2( ( transmittedIor - incidentIor ) / ( transmittedIor + incidentIor ));
	}
	vec3 evalSensitivity( float OPD, vec3 shift ) {
		float phase = 2.0 * PI * OPD * 1.0e-9;
		vec3 val = vec3( 5.4856e-13, 4.4201e-13, 5.2481e-13 );
		vec3 pos = vec3( 1.6810e+06, 1.7953e+06, 2.2084e+06 );
		vec3 var = vec3( 4.3278e+09, 9.3046e+09, 6.6121e+09 );
		vec3 xyz = val * sqrt( 2.0 * PI * var ) * cos( pos * phase + shift ) * exp( - pow2( phase ) * var );
		xyz.x += 9.7470e-14 * sqrt( 2.0 * PI * 4.5282e+09 ) * cos( 2.2399e+06 * phase + shift[ 0 ] ) * exp( - 4.5282e+09 * pow2( phase ) );
		xyz /= 1.0685e-7;
		vec3 rgb = XYZ_TO_REC709 * xyz;
		return rgb;
	}
	vec3 evalIridescence( float outsideIOR, float eta2, float cosTheta1, float thinFilmThickness, vec3 baseF0 ) {
		vec3 I;
		float iridescenceIOR = mix( outsideIOR, eta2, smoothstep( 0.0, 0.03, thinFilmThickness ) );
		float sinTheta2Sq = pow2( outsideIOR / iridescenceIOR ) * ( 1.0 - pow2( cosTheta1 ) );
		float cosTheta2Sq = 1.0 - sinTheta2Sq;
		if ( cosTheta2Sq < 0.0 ) {
			 return vec3( 1.0 );
		}
		float cosTheta2 = sqrt( cosTheta2Sq );
		float R0 = IorToFresnel0( iridescenceIOR, outsideIOR );
		float R12 = F_Schlick( R0, 1.0, cosTheta1 );
		float R21 = R12;
		float T121 = 1.0 - R12;
		float phi12 = 0.0;
		if ( iridescenceIOR < outsideIOR ) phi12 = PI;
		float phi21 = PI - phi12;
		vec3 baseIOR = Fresnel0ToIor( clamp( baseF0, 0.0, 0.9999 ) );		vec3 R1 = IorToFresnel0( baseIOR, iridescenceIOR );
		vec3 R23 = F_Schlick( R1, 1.0, cosTheta2 );
		vec3 phi23 = vec3( 0.0 );
		if ( baseIOR[ 0 ] < iridescenceIOR ) phi23[ 0 ] = PI;
		if ( baseIOR[ 1 ] < iridescenceIOR ) phi23[ 1 ] = PI;
		if ( baseIOR[ 2 ] < iridescenceIOR ) phi23[ 2 ] = PI;
		float OPD = 2.0 * iridescenceIOR * thinFilmThickness * cosTheta2;
		vec3 phi = vec3( phi21 ) + phi23;
		vec3 R123 = clamp( R12 * R23, 1e-5, 0.9999 );
		vec3 r123 = sqrt( R123 );
		vec3 Rs = pow2( T121 ) * R23 / ( vec3( 1.0 ) - R123 );
		vec3 C0 = R12 + Rs;
		I = C0;
		vec3 Cm = Rs - T121;
		for ( int m = 1; m <= 2; ++ m ) {
			Cm *= r123;
			vec3 Sm = 2.0 * evalSensitivity( float( m ) * OPD, float( m ) * phi );
			I += Cm * Sm;
		}
		return max( I, vec3( 0.0 ) );
	}
#endif`,W_=`#ifdef USE_BUMPMAP
	uniform sampler2D bumpMap;
	uniform float bumpScale;
	vec2 dHdxy_fwd() {
		vec2 dSTdx = dFdx( vUv );
		vec2 dSTdy = dFdy( vUv );
		float Hll = bumpScale * texture2D( bumpMap, vUv ).x;
		float dBx = bumpScale * texture2D( bumpMap, vUv + dSTdx ).x - Hll;
		float dBy = bumpScale * texture2D( bumpMap, vUv + dSTdy ).x - Hll;
		return vec2( dBx, dBy );
	}
	vec3 perturbNormalArb( vec3 surf_pos, vec3 surf_norm, vec2 dHdxy, float faceDirection ) {
		vec3 vSigmaX = dFdx( surf_pos.xyz );
		vec3 vSigmaY = dFdy( surf_pos.xyz );
		vec3 vN = surf_norm;
		vec3 R1 = cross( vSigmaY, vN );
		vec3 R2 = cross( vN, vSigmaX );
		float fDet = dot( vSigmaX, R1 ) * faceDirection;
		vec3 vGrad = sign( fDet ) * ( dHdxy.x * R1 + dHdxy.y * R2 );
		return normalize( abs( fDet ) * surf_norm - vGrad );
	}
#endif`,X_=`#if NUM_CLIPPING_PLANES > 0
	vec4 plane;
	#pragma unroll_loop_start
	for ( int i = 0; i < UNION_CLIPPING_PLANES; i ++ ) {
		plane = clippingPlanes[ i ];
		if ( dot( vClipPosition, plane.xyz ) > plane.w ) discard;
	}
	#pragma unroll_loop_end
	#if UNION_CLIPPING_PLANES < NUM_CLIPPING_PLANES
		bool clipped = true;
		#pragma unroll_loop_start
		for ( int i = UNION_CLIPPING_PLANES; i < NUM_CLIPPING_PLANES; i ++ ) {
			plane = clippingPlanes[ i ];
			clipped = ( dot( vClipPosition, plane.xyz ) > plane.w ) && clipped;
		}
		#pragma unroll_loop_end
		if ( clipped ) discard;
	#endif
#endif`,j_=`#if NUM_CLIPPING_PLANES > 0
	varying vec3 vClipPosition;
	uniform vec4 clippingPlanes[ NUM_CLIPPING_PLANES ];
#endif`,q_=`#if NUM_CLIPPING_PLANES > 0
	varying vec3 vClipPosition;
#endif`,Y_=`#if NUM_CLIPPING_PLANES > 0
	vClipPosition = - mvPosition.xyz;
#endif`,Z_=`#if defined( USE_COLOR_ALPHA )
	diffuseColor *= vColor;
#elif defined( USE_COLOR )
	diffuseColor.rgb *= vColor;
#endif`,K_=`#if defined( USE_COLOR_ALPHA )
	varying vec4 vColor;
#elif defined( USE_COLOR )
	varying vec3 vColor;
#endif`,J_=`#if defined( USE_COLOR_ALPHA )
	varying vec4 vColor;
#elif defined( USE_COLOR ) || defined( USE_INSTANCING_COLOR )
	varying vec3 vColor;
#endif`,Q_=`#if defined( USE_COLOR_ALPHA )
	vColor = vec4( 1.0 );
#elif defined( USE_COLOR ) || defined( USE_INSTANCING_COLOR )
	vColor = vec3( 1.0 );
#endif
#ifdef USE_COLOR
	vColor *= color;
#endif
#ifdef USE_INSTANCING_COLOR
	vColor.xyz *= instanceColor.xyz;
#endif`,$_=`#define PI 3.141592653589793
#define PI2 6.283185307179586
#define PI_HALF 1.5707963267948966
#define RECIPROCAL_PI 0.3183098861837907
#define RECIPROCAL_PI2 0.15915494309189535
#define EPSILON 1e-6
#ifndef saturate
#define saturate( a ) clamp( a, 0.0, 1.0 )
#endif
#define whiteComplement( a ) ( 1.0 - saturate( a ) )
float pow2( const in float x ) { return x*x; }
vec3 pow2( const in vec3 x ) { return x*x; }
float pow3( const in float x ) { return x*x*x; }
float pow4( const in float x ) { float x2 = x*x; return x2*x2; }
float max3( const in vec3 v ) { return max( max( v.x, v.y ), v.z ); }
float average( const in vec3 v ) { return dot( v, vec3( 0.3333333 ) ); }
highp float rand( const in vec2 uv ) {
	const highp float a = 12.9898, b = 78.233, c = 43758.5453;
	highp float dt = dot( uv.xy, vec2( a,b ) ), sn = mod( dt, PI );
	return fract( sin( sn ) * c );
}
#ifdef HIGH_PRECISION
	float precisionSafeLength( vec3 v ) { return length( v ); }
#else
	float precisionSafeLength( vec3 v ) {
		float maxComponent = max3( abs( v ) );
		return length( v / maxComponent ) * maxComponent;
	}
#endif
struct IncidentLight {
	vec3 color;
	vec3 direction;
	bool visible;
};
struct ReflectedLight {
	vec3 directDiffuse;
	vec3 directSpecular;
	vec3 indirectDiffuse;
	vec3 indirectSpecular;
};
struct GeometricContext {
	vec3 position;
	vec3 normal;
	vec3 viewDir;
#ifdef USE_CLEARCOAT
	vec3 clearcoatNormal;
#endif
};
vec3 transformDirection( in vec3 dir, in mat4 matrix ) {
	return normalize( ( matrix * vec4( dir, 0.0 ) ).xyz );
}
vec3 inverseTransformDirection( in vec3 dir, in mat4 matrix ) {
	return normalize( ( vec4( dir, 0.0 ) * matrix ).xyz );
}
mat3 transposeMat3( const in mat3 m ) {
	mat3 tmp;
	tmp[ 0 ] = vec3( m[ 0 ].x, m[ 1 ].x, m[ 2 ].x );
	tmp[ 1 ] = vec3( m[ 0 ].y, m[ 1 ].y, m[ 2 ].y );
	tmp[ 2 ] = vec3( m[ 0 ].z, m[ 1 ].z, m[ 2 ].z );
	return tmp;
}
float luminance( const in vec3 rgb ) {
	const vec3 weights = vec3( 0.2126729, 0.7151522, 0.0721750 );
	return dot( weights, rgb );
}
bool isPerspectiveMatrix( mat4 m ) {
	return m[ 2 ][ 3 ] == - 1.0;
}
vec2 equirectUv( in vec3 dir ) {
	float u = atan( dir.z, dir.x ) * RECIPROCAL_PI2 + 0.5;
	float v = asin( clamp( dir.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;
	return vec2( u, v );
}`,eg=`#ifdef ENVMAP_TYPE_CUBE_UV
	#define cubeUV_minMipLevel 4.0
	#define cubeUV_minTileSize 16.0
	float getFace( vec3 direction ) {
		vec3 absDirection = abs( direction );
		float face = - 1.0;
		if ( absDirection.x > absDirection.z ) {
			if ( absDirection.x > absDirection.y )
				face = direction.x > 0.0 ? 0.0 : 3.0;
			else
				face = direction.y > 0.0 ? 1.0 : 4.0;
		} else {
			if ( absDirection.z > absDirection.y )
				face = direction.z > 0.0 ? 2.0 : 5.0;
			else
				face = direction.y > 0.0 ? 1.0 : 4.0;
		}
		return face;
	}
	vec2 getUV( vec3 direction, float face ) {
		vec2 uv;
		if ( face == 0.0 ) {
			uv = vec2( direction.z, direction.y ) / abs( direction.x );
		} else if ( face == 1.0 ) {
			uv = vec2( - direction.x, - direction.z ) / abs( direction.y );
		} else if ( face == 2.0 ) {
			uv = vec2( - direction.x, direction.y ) / abs( direction.z );
		} else if ( face == 3.0 ) {
			uv = vec2( - direction.z, direction.y ) / abs( direction.x );
		} else if ( face == 4.0 ) {
			uv = vec2( - direction.x, direction.z ) / abs( direction.y );
		} else {
			uv = vec2( direction.x, direction.y ) / abs( direction.z );
		}
		return 0.5 * ( uv + 1.0 );
	}
	vec3 bilinearCubeUV( sampler2D envMap, vec3 direction, float mipInt ) {
		float face = getFace( direction );
		float filterInt = max( cubeUV_minMipLevel - mipInt, 0.0 );
		mipInt = max( mipInt, cubeUV_minMipLevel );
		float faceSize = exp2( mipInt );
		highp vec2 uv = getUV( direction, face ) * ( faceSize - 2.0 ) + 1.0;
		if ( face > 2.0 ) {
			uv.y += faceSize;
			face -= 3.0;
		}
		uv.x += face * faceSize;
		uv.x += filterInt * 3.0 * cubeUV_minTileSize;
		uv.y += 4.0 * ( exp2( CUBEUV_MAX_MIP ) - faceSize );
		uv.x *= CUBEUV_TEXEL_WIDTH;
		uv.y *= CUBEUV_TEXEL_HEIGHT;
		#ifdef texture2DGradEXT
			return texture2DGradEXT( envMap, uv, vec2( 0.0 ), vec2( 0.0 ) ).rgb;
		#else
			return texture2D( envMap, uv ).rgb;
		#endif
	}
	#define cubeUV_r0 1.0
	#define cubeUV_v0 0.339
	#define cubeUV_m0 - 2.0
	#define cubeUV_r1 0.8
	#define cubeUV_v1 0.276
	#define cubeUV_m1 - 1.0
	#define cubeUV_r4 0.4
	#define cubeUV_v4 0.046
	#define cubeUV_m4 2.0
	#define cubeUV_r5 0.305
	#define cubeUV_v5 0.016
	#define cubeUV_m5 3.0
	#define cubeUV_r6 0.21
	#define cubeUV_v6 0.0038
	#define cubeUV_m6 4.0
	float roughnessToMip( float roughness ) {
		float mip = 0.0;
		if ( roughness >= cubeUV_r1 ) {
			mip = ( cubeUV_r0 - roughness ) * ( cubeUV_m1 - cubeUV_m0 ) / ( cubeUV_r0 - cubeUV_r1 ) + cubeUV_m0;
		} else if ( roughness >= cubeUV_r4 ) {
			mip = ( cubeUV_r1 - roughness ) * ( cubeUV_m4 - cubeUV_m1 ) / ( cubeUV_r1 - cubeUV_r4 ) + cubeUV_m1;
		} else if ( roughness >= cubeUV_r5 ) {
			mip = ( cubeUV_r4 - roughness ) * ( cubeUV_m5 - cubeUV_m4 ) / ( cubeUV_r4 - cubeUV_r5 ) + cubeUV_m4;
		} else if ( roughness >= cubeUV_r6 ) {
			mip = ( cubeUV_r5 - roughness ) * ( cubeUV_m6 - cubeUV_m5 ) / ( cubeUV_r5 - cubeUV_r6 ) + cubeUV_m5;
		} else {
			mip = - 2.0 * log2( 1.16 * roughness );		}
		return mip;
	}
	vec4 textureCubeUV( sampler2D envMap, vec3 sampleDir, float roughness ) {
		float mip = clamp( roughnessToMip( roughness ), cubeUV_m0, CUBEUV_MAX_MIP );
		float mipF = fract( mip );
		float mipInt = floor( mip );
		vec3 color0 = bilinearCubeUV( envMap, sampleDir, mipInt );
		if ( mipF == 0.0 ) {
			return vec4( color0, 1.0 );
		} else {
			vec3 color1 = bilinearCubeUV( envMap, sampleDir, mipInt + 1.0 );
			return vec4( mix( color0, color1, mipF ), 1.0 );
		}
	}
#endif`,tg=`vec3 transformedNormal = objectNormal;
#ifdef USE_INSTANCING
	mat3 m = mat3( instanceMatrix );
	transformedNormal /= vec3( dot( m[ 0 ], m[ 0 ] ), dot( m[ 1 ], m[ 1 ] ), dot( m[ 2 ], m[ 2 ] ) );
	transformedNormal = m * transformedNormal;
#endif
transformedNormal = normalMatrix * transformedNormal;
#ifdef FLIP_SIDED
	transformedNormal = - transformedNormal;
#endif
#ifdef USE_TANGENT
	vec3 transformedTangent = ( modelViewMatrix * vec4( objectTangent, 0.0 ) ).xyz;
	#ifdef FLIP_SIDED
		transformedTangent = - transformedTangent;
	#endif
#endif`,ng=`#ifdef USE_DISPLACEMENTMAP
	uniform sampler2D displacementMap;
	uniform float displacementScale;
	uniform float displacementBias;
#endif`,ig=`#ifdef USE_DISPLACEMENTMAP
	transformed += normalize( objectNormal ) * ( texture2D( displacementMap, vUv ).x * displacementScale + displacementBias );
#endif`,rg=`#ifdef USE_EMISSIVEMAP
	vec4 emissiveColor = texture2D( emissiveMap, vUv );
	totalEmissiveRadiance *= emissiveColor.rgb;
#endif`,sg=`#ifdef USE_EMISSIVEMAP
	uniform sampler2D emissiveMap;
#endif`,ag="gl_FragColor = linearToOutputTexel( gl_FragColor );",og=`vec4 LinearToLinear( in vec4 value ) {
	return value;
}
vec4 LinearTosRGB( in vec4 value ) {
	return vec4( mix( pow( value.rgb, vec3( 0.41666 ) ) * 1.055 - vec3( 0.055 ), value.rgb * 12.92, vec3( lessThanEqual( value.rgb, vec3( 0.0031308 ) ) ) ), value.a );
}`,lg=`#ifdef USE_ENVMAP
	#ifdef ENV_WORLDPOS
		vec3 cameraToFrag;
		if ( isOrthographic ) {
			cameraToFrag = normalize( vec3( - viewMatrix[ 0 ][ 2 ], - viewMatrix[ 1 ][ 2 ], - viewMatrix[ 2 ][ 2 ] ) );
		} else {
			cameraToFrag = normalize( vWorldPosition - cameraPosition );
		}
		vec3 worldNormal = inverseTransformDirection( normal, viewMatrix );
		#ifdef ENVMAP_MODE_REFLECTION
			vec3 reflectVec = reflect( cameraToFrag, worldNormal );
		#else
			vec3 reflectVec = refract( cameraToFrag, worldNormal, refractionRatio );
		#endif
	#else
		vec3 reflectVec = vReflect;
	#endif
	#ifdef ENVMAP_TYPE_CUBE
		vec4 envColor = textureCube( envMap, vec3( flipEnvMap * reflectVec.x, reflectVec.yz ) );
	#else
		vec4 envColor = vec4( 0.0 );
	#endif
	#ifdef ENVMAP_BLENDING_MULTIPLY
		outgoingLight = mix( outgoingLight, outgoingLight * envColor.xyz, specularStrength * reflectivity );
	#elif defined( ENVMAP_BLENDING_MIX )
		outgoingLight = mix( outgoingLight, envColor.xyz, specularStrength * reflectivity );
	#elif defined( ENVMAP_BLENDING_ADD )
		outgoingLight += envColor.xyz * specularStrength * reflectivity;
	#endif
#endif`,cg=`#ifdef USE_ENVMAP
	uniform float envMapIntensity;
	uniform float flipEnvMap;
	#ifdef ENVMAP_TYPE_CUBE
		uniform samplerCube envMap;
	#else
		uniform sampler2D envMap;
	#endif
	
#endif`,ug=`#ifdef USE_ENVMAP
	uniform float reflectivity;
	#if defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG ) || defined( LAMBERT )
		#define ENV_WORLDPOS
	#endif
	#ifdef ENV_WORLDPOS
		varying vec3 vWorldPosition;
		uniform float refractionRatio;
	#else
		varying vec3 vReflect;
	#endif
#endif`,fg=`#ifdef USE_ENVMAP
	#if defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG ) || defined( LAMBERT )
		#define ENV_WORLDPOS
	#endif
	#ifdef ENV_WORLDPOS
		
		varying vec3 vWorldPosition;
	#else
		varying vec3 vReflect;
		uniform float refractionRatio;
	#endif
#endif`,dg=`#ifdef USE_ENVMAP
	#ifdef ENV_WORLDPOS
		vWorldPosition = worldPosition.xyz;
	#else
		vec3 cameraToVertex;
		if ( isOrthographic ) {
			cameraToVertex = normalize( vec3( - viewMatrix[ 0 ][ 2 ], - viewMatrix[ 1 ][ 2 ], - viewMatrix[ 2 ][ 2 ] ) );
		} else {
			cameraToVertex = normalize( worldPosition.xyz - cameraPosition );
		}
		vec3 worldNormal = inverseTransformDirection( transformedNormal, viewMatrix );
		#ifdef ENVMAP_MODE_REFLECTION
			vReflect = reflect( cameraToVertex, worldNormal );
		#else
			vReflect = refract( cameraToVertex, worldNormal, refractionRatio );
		#endif
	#endif
#endif`,hg=`#ifdef USE_FOG
	vFogDepth = - mvPosition.z;
#endif`,pg=`#ifdef USE_FOG
	varying float vFogDepth;
#endif`,mg=`#ifdef USE_FOG
	#ifdef FOG_EXP2
		float fogFactor = 1.0 - exp( - fogDensity * fogDensity * vFogDepth * vFogDepth );
	#else
		float fogFactor = smoothstep( fogNear, fogFar, vFogDepth );
	#endif
	gl_FragColor.rgb = mix( gl_FragColor.rgb, fogColor, fogFactor );
#endif`,_g=`#ifdef USE_FOG
	uniform vec3 fogColor;
	varying float vFogDepth;
	#ifdef FOG_EXP2
		uniform float fogDensity;
	#else
		uniform float fogNear;
		uniform float fogFar;
	#endif
#endif`,gg=`#ifdef USE_GRADIENTMAP
	uniform sampler2D gradientMap;
#endif
vec3 getGradientIrradiance( vec3 normal, vec3 lightDirection ) {
	float dotNL = dot( normal, lightDirection );
	vec2 coord = vec2( dotNL * 0.5 + 0.5, 0.0 );
	#ifdef USE_GRADIENTMAP
		return vec3( texture2D( gradientMap, coord ).r );
	#else
		vec2 fw = fwidth( coord ) * 0.5;
		return mix( vec3( 0.7 ), vec3( 1.0 ), smoothstep( 0.7 - fw.x, 0.7 + fw.x, coord.x ) );
	#endif
}`,bg=`#ifdef USE_LIGHTMAP
	vec4 lightMapTexel = texture2D( lightMap, vUv2 );
	vec3 lightMapIrradiance = lightMapTexel.rgb * lightMapIntensity;
	reflectedLight.indirectDiffuse += lightMapIrradiance;
#endif`,vg=`#ifdef USE_LIGHTMAP
	uniform sampler2D lightMap;
	uniform float lightMapIntensity;
#endif`,yg=`LambertMaterial material;
material.diffuseColor = diffuseColor.rgb;
material.specularStrength = specularStrength;`,wg=`varying vec3 vViewPosition;
struct LambertMaterial {
	vec3 diffuseColor;
	float specularStrength;
};
void RE_Direct_Lambert( const in IncidentLight directLight, const in GeometricContext geometry, const in LambertMaterial material, inout ReflectedLight reflectedLight ) {
	float dotNL = saturate( dot( geometry.normal, directLight.direction ) );
	vec3 irradiance = dotNL * directLight.color;
	reflectedLight.directDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
void RE_IndirectDiffuse_Lambert( const in vec3 irradiance, const in GeometricContext geometry, const in LambertMaterial material, inout ReflectedLight reflectedLight ) {
	reflectedLight.indirectDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
#define RE_Direct				RE_Direct_Lambert
#define RE_IndirectDiffuse		RE_IndirectDiffuse_Lambert`,xg=`uniform bool receiveShadow;
uniform vec3 ambientLightColor;
uniform vec3 lightProbe[ 9 ];
vec3 shGetIrradianceAt( in vec3 normal, in vec3 shCoefficients[ 9 ] ) {
	float x = normal.x, y = normal.y, z = normal.z;
	vec3 result = shCoefficients[ 0 ] * 0.886227;
	result += shCoefficients[ 1 ] * 2.0 * 0.511664 * y;
	result += shCoefficients[ 2 ] * 2.0 * 0.511664 * z;
	result += shCoefficients[ 3 ] * 2.0 * 0.511664 * x;
	result += shCoefficients[ 4 ] * 2.0 * 0.429043 * x * y;
	result += shCoefficients[ 5 ] * 2.0 * 0.429043 * y * z;
	result += shCoefficients[ 6 ] * ( 0.743125 * z * z - 0.247708 );
	result += shCoefficients[ 7 ] * 2.0 * 0.429043 * x * z;
	result += shCoefficients[ 8 ] * 0.429043 * ( x * x - y * y );
	return result;
}
vec3 getLightProbeIrradiance( const in vec3 lightProbe[ 9 ], const in vec3 normal ) {
	vec3 worldNormal = inverseTransformDirection( normal, viewMatrix );
	vec3 irradiance = shGetIrradianceAt( worldNormal, lightProbe );
	return irradiance;
}
vec3 getAmbientLightIrradiance( const in vec3 ambientLightColor ) {
	vec3 irradiance = ambientLightColor;
	return irradiance;
}
float getDistanceAttenuation( const in float lightDistance, const in float cutoffDistance, const in float decayExponent ) {
	#if defined ( LEGACY_LIGHTS )
		if ( cutoffDistance > 0.0 && decayExponent > 0.0 ) {
			return pow( saturate( - lightDistance / cutoffDistance + 1.0 ), decayExponent );
		}
		return 1.0;
	#else
		float distanceFalloff = 1.0 / max( pow( lightDistance, decayExponent ), 0.01 );
		if ( cutoffDistance > 0.0 ) {
			distanceFalloff *= pow2( saturate( 1.0 - pow4( lightDistance / cutoffDistance ) ) );
		}
		return distanceFalloff;
	#endif
}
float getSpotAttenuation( const in float coneCosine, const in float penumbraCosine, const in float angleCosine ) {
	return smoothstep( coneCosine, penumbraCosine, angleCosine );
}
#if NUM_DIR_LIGHTS > 0
	struct DirectionalLight {
		vec3 direction;
		vec3 color;
	};
	uniform DirectionalLight directionalLights[ NUM_DIR_LIGHTS ];
	void getDirectionalLightInfo( const in DirectionalLight directionalLight, const in GeometricContext geometry, out IncidentLight light ) {
		light.color = directionalLight.color;
		light.direction = directionalLight.direction;
		light.visible = true;
	}
#endif
#if NUM_POINT_LIGHTS > 0
	struct PointLight {
		vec3 position;
		vec3 color;
		float distance;
		float decay;
	};
	uniform PointLight pointLights[ NUM_POINT_LIGHTS ];
	void getPointLightInfo( const in PointLight pointLight, const in GeometricContext geometry, out IncidentLight light ) {
		vec3 lVector = pointLight.position - geometry.position;
		light.direction = normalize( lVector );
		float lightDistance = length( lVector );
		light.color = pointLight.color;
		light.color *= getDistanceAttenuation( lightDistance, pointLight.distance, pointLight.decay );
		light.visible = ( light.color != vec3( 0.0 ) );
	}
#endif
#if NUM_SPOT_LIGHTS > 0
	struct SpotLight {
		vec3 position;
		vec3 direction;
		vec3 color;
		float distance;
		float decay;
		float coneCos;
		float penumbraCos;
	};
	uniform SpotLight spotLights[ NUM_SPOT_LIGHTS ];
	void getSpotLightInfo( const in SpotLight spotLight, const in GeometricContext geometry, out IncidentLight light ) {
		vec3 lVector = spotLight.position - geometry.position;
		light.direction = normalize( lVector );
		float angleCos = dot( light.direction, spotLight.direction );
		float spotAttenuation = getSpotAttenuation( spotLight.coneCos, spotLight.penumbraCos, angleCos );
		if ( spotAttenuation > 0.0 ) {
			float lightDistance = length( lVector );
			light.color = spotLight.color * spotAttenuation;
			light.color *= getDistanceAttenuation( lightDistance, spotLight.distance, spotLight.decay );
			light.visible = ( light.color != vec3( 0.0 ) );
		} else {
			light.color = vec3( 0.0 );
			light.visible = false;
		}
	}
#endif
#if NUM_RECT_AREA_LIGHTS > 0
	struct RectAreaLight {
		vec3 color;
		vec3 position;
		vec3 halfWidth;
		vec3 halfHeight;
	};
	uniform sampler2D ltc_1;	uniform sampler2D ltc_2;
	uniform RectAreaLight rectAreaLights[ NUM_RECT_AREA_LIGHTS ];
#endif
#if NUM_HEMI_LIGHTS > 0
	struct HemisphereLight {
		vec3 direction;
		vec3 skyColor;
		vec3 groundColor;
	};
	uniform HemisphereLight hemisphereLights[ NUM_HEMI_LIGHTS ];
	vec3 getHemisphereLightIrradiance( const in HemisphereLight hemiLight, const in vec3 normal ) {
		float dotNL = dot( normal, hemiLight.direction );
		float hemiDiffuseWeight = 0.5 * dotNL + 0.5;
		vec3 irradiance = mix( hemiLight.groundColor, hemiLight.skyColor, hemiDiffuseWeight );
		return irradiance;
	}
#endif`,Mg=`#if defined( USE_ENVMAP )
	vec3 getIBLIrradiance( const in vec3 normal ) {
		#if defined( ENVMAP_TYPE_CUBE_UV )
			vec3 worldNormal = inverseTransformDirection( normal, viewMatrix );
			vec4 envMapColor = textureCubeUV( envMap, worldNormal, 1.0 );
			return PI * envMapColor.rgb * envMapIntensity;
		#else
			return vec3( 0.0 );
		#endif
	}
	vec3 getIBLRadiance( const in vec3 viewDir, const in vec3 normal, const in float roughness ) {
		#if defined( ENVMAP_TYPE_CUBE_UV )
			vec3 reflectVec = reflect( - viewDir, normal );
			reflectVec = normalize( mix( reflectVec, normal, roughness * roughness) );
			reflectVec = inverseTransformDirection( reflectVec, viewMatrix );
			vec4 envMapColor = textureCubeUV( envMap, reflectVec, roughness );
			return envMapColor.rgb * envMapIntensity;
		#else
			return vec3( 0.0 );
		#endif
	}
#endif`,Sg=`ToonMaterial material;
material.diffuseColor = diffuseColor.rgb;`,Cg=`varying vec3 vViewPosition;
struct ToonMaterial {
	vec3 diffuseColor;
};
void RE_Direct_Toon( const in IncidentLight directLight, const in GeometricContext geometry, const in ToonMaterial material, inout ReflectedLight reflectedLight ) {
	vec3 irradiance = getGradientIrradiance( geometry.normal, directLight.direction ) * directLight.color;
	reflectedLight.directDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
void RE_IndirectDiffuse_Toon( const in vec3 irradiance, const in GeometricContext geometry, const in ToonMaterial material, inout ReflectedLight reflectedLight ) {
	reflectedLight.indirectDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
#define RE_Direct				RE_Direct_Toon
#define RE_IndirectDiffuse		RE_IndirectDiffuse_Toon`,Tg=`BlinnPhongMaterial material;
material.diffuseColor = diffuseColor.rgb;
material.specularColor = specular;
material.specularShininess = shininess;
material.specularStrength = specularStrength;`,Eg=`varying vec3 vViewPosition;
struct BlinnPhongMaterial {
	vec3 diffuseColor;
	vec3 specularColor;
	float specularShininess;
	float specularStrength;
};
void RE_Direct_BlinnPhong( const in IncidentLight directLight, const in GeometricContext geometry, const in BlinnPhongMaterial material, inout ReflectedLight reflectedLight ) {
	float dotNL = saturate( dot( geometry.normal, directLight.direction ) );
	vec3 irradiance = dotNL * directLight.color;
	reflectedLight.directDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
	reflectedLight.directSpecular += irradiance * BRDF_BlinnPhong( directLight.direction, geometry.viewDir, geometry.normal, material.specularColor, material.specularShininess ) * material.specularStrength;
}
void RE_IndirectDiffuse_BlinnPhong( const in vec3 irradiance, const in GeometricContext geometry, const in BlinnPhongMaterial material, inout ReflectedLight reflectedLight ) {
	reflectedLight.indirectDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
#define RE_Direct				RE_Direct_BlinnPhong
#define RE_IndirectDiffuse		RE_IndirectDiffuse_BlinnPhong`,Lg=`PhysicalMaterial material;
material.diffuseColor = diffuseColor.rgb * ( 1.0 - metalnessFactor );
vec3 dxy = max( abs( dFdx( geometryNormal ) ), abs( dFdy( geometryNormal ) ) );
float geometryRoughness = max( max( dxy.x, dxy.y ), dxy.z );
material.roughness = max( roughnessFactor, 0.0525 );material.roughness += geometryRoughness;
material.roughness = min( material.roughness, 1.0 );
#ifdef IOR
	material.ior = ior;
	#ifdef SPECULAR
		float specularIntensityFactor = specularIntensity;
		vec3 specularColorFactor = specularColor;
		#ifdef USE_SPECULARINTENSITYMAP
			specularIntensityFactor *= texture2D( specularIntensityMap, vUv ).a;
		#endif
		#ifdef USE_SPECULARCOLORMAP
			specularColorFactor *= texture2D( specularColorMap, vUv ).rgb;
		#endif
		material.specularF90 = mix( specularIntensityFactor, 1.0, metalnessFactor );
	#else
		float specularIntensityFactor = 1.0;
		vec3 specularColorFactor = vec3( 1.0 );
		material.specularF90 = 1.0;
	#endif
	material.specularColor = mix( min( pow2( ( material.ior - 1.0 ) / ( material.ior + 1.0 ) ) * specularColorFactor, vec3( 1.0 ) ) * specularIntensityFactor, diffuseColor.rgb, metalnessFactor );
#else
	material.specularColor = mix( vec3( 0.04 ), diffuseColor.rgb, metalnessFactor );
	material.specularF90 = 1.0;
#endif
#ifdef USE_CLEARCOAT
	material.clearcoat = clearcoat;
	material.clearcoatRoughness = clearcoatRoughness;
	material.clearcoatF0 = vec3( 0.04 );
	material.clearcoatF90 = 1.0;
	#ifdef USE_CLEARCOATMAP
		material.clearcoat *= texture2D( clearcoatMap, vUv ).x;
	#endif
	#ifdef USE_CLEARCOAT_ROUGHNESSMAP
		material.clearcoatRoughness *= texture2D( clearcoatRoughnessMap, vUv ).y;
	#endif
	material.clearcoat = saturate( material.clearcoat );	material.clearcoatRoughness = max( material.clearcoatRoughness, 0.0525 );
	material.clearcoatRoughness += geometryRoughness;
	material.clearcoatRoughness = min( material.clearcoatRoughness, 1.0 );
#endif
#ifdef USE_IRIDESCENCE
	material.iridescence = iridescence;
	material.iridescenceIOR = iridescenceIOR;
	#ifdef USE_IRIDESCENCEMAP
		material.iridescence *= texture2D( iridescenceMap, vUv ).r;
	#endif
	#ifdef USE_IRIDESCENCE_THICKNESSMAP
		material.iridescenceThickness = (iridescenceThicknessMaximum - iridescenceThicknessMinimum) * texture2D( iridescenceThicknessMap, vUv ).g + iridescenceThicknessMinimum;
	#else
		material.iridescenceThickness = iridescenceThicknessMaximum;
	#endif
#endif
#ifdef USE_SHEEN
	material.sheenColor = sheenColor;
	#ifdef USE_SHEENCOLORMAP
		material.sheenColor *= texture2D( sheenColorMap, vUv ).rgb;
	#endif
	material.sheenRoughness = clamp( sheenRoughness, 0.07, 1.0 );
	#ifdef USE_SHEENROUGHNESSMAP
		material.sheenRoughness *= texture2D( sheenRoughnessMap, vUv ).a;
	#endif
#endif`,Pg=`struct PhysicalMaterial {
	vec3 diffuseColor;
	float roughness;
	vec3 specularColor;
	float specularF90;
	#ifdef USE_CLEARCOAT
		float clearcoat;
		float clearcoatRoughness;
		vec3 clearcoatF0;
		float clearcoatF90;
	#endif
	#ifdef USE_IRIDESCENCE
		float iridescence;
		float iridescenceIOR;
		float iridescenceThickness;
		vec3 iridescenceFresnel;
		vec3 iridescenceF0;
	#endif
	#ifdef USE_SHEEN
		vec3 sheenColor;
		float sheenRoughness;
	#endif
	#ifdef IOR
		float ior;
	#endif
	#ifdef USE_TRANSMISSION
		float transmission;
		float transmissionAlpha;
		float thickness;
		float attenuationDistance;
		vec3 attenuationColor;
	#endif
};
vec3 clearcoatSpecular = vec3( 0.0 );
vec3 sheenSpecular = vec3( 0.0 );
float IBLSheenBRDF( const in vec3 normal, const in vec3 viewDir, const in float roughness ) {
	float dotNV = saturate( dot( normal, viewDir ) );
	float r2 = roughness * roughness;
	float a = roughness < 0.25 ? -339.2 * r2 + 161.4 * roughness - 25.9 : -8.48 * r2 + 14.3 * roughness - 9.95;
	float b = roughness < 0.25 ? 44.0 * r2 - 23.7 * roughness + 3.26 : 1.97 * r2 - 3.27 * roughness + 0.72;
	float DG = exp( a * dotNV + b ) + ( roughness < 0.25 ? 0.0 : 0.1 * ( roughness - 0.25 ) );
	return saturate( DG * RECIPROCAL_PI );
}
vec2 DFGApprox( const in vec3 normal, const in vec3 viewDir, const in float roughness ) {
	float dotNV = saturate( dot( normal, viewDir ) );
	const vec4 c0 = vec4( - 1, - 0.0275, - 0.572, 0.022 );
	const vec4 c1 = vec4( 1, 0.0425, 1.04, - 0.04 );
	vec4 r = roughness * c0 + c1;
	float a004 = min( r.x * r.x, exp2( - 9.28 * dotNV ) ) * r.x + r.y;
	vec2 fab = vec2( - 1.04, 1.04 ) * a004 + r.zw;
	return fab;
}
vec3 EnvironmentBRDF( const in vec3 normal, const in vec3 viewDir, const in vec3 specularColor, const in float specularF90, const in float roughness ) {
	vec2 fab = DFGApprox( normal, viewDir, roughness );
	return specularColor * fab.x + specularF90 * fab.y;
}
#ifdef USE_IRIDESCENCE
void computeMultiscatteringIridescence( const in vec3 normal, const in vec3 viewDir, const in vec3 specularColor, const in float specularF90, const in float iridescence, const in vec3 iridescenceF0, const in float roughness, inout vec3 singleScatter, inout vec3 multiScatter ) {
#else
void computeMultiscattering( const in vec3 normal, const in vec3 viewDir, const in vec3 specularColor, const in float specularF90, const in float roughness, inout vec3 singleScatter, inout vec3 multiScatter ) {
#endif
	vec2 fab = DFGApprox( normal, viewDir, roughness );
	#ifdef USE_IRIDESCENCE
		vec3 Fr = mix( specularColor, iridescenceF0, iridescence );
	#else
		vec3 Fr = specularColor;
	#endif
	vec3 FssEss = Fr * fab.x + specularF90 * fab.y;
	float Ess = fab.x + fab.y;
	float Ems = 1.0 - Ess;
	vec3 Favg = Fr + ( 1.0 - Fr ) * 0.047619;	vec3 Fms = FssEss * Favg / ( 1.0 - Ems * Favg );
	singleScatter += FssEss;
	multiScatter += Fms * Ems;
}
#if NUM_RECT_AREA_LIGHTS > 0
	void RE_Direct_RectArea_Physical( const in RectAreaLight rectAreaLight, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {
		vec3 normal = geometry.normal;
		vec3 viewDir = geometry.viewDir;
		vec3 position = geometry.position;
		vec3 lightPos = rectAreaLight.position;
		vec3 halfWidth = rectAreaLight.halfWidth;
		vec3 halfHeight = rectAreaLight.halfHeight;
		vec3 lightColor = rectAreaLight.color;
		float roughness = material.roughness;
		vec3 rectCoords[ 4 ];
		rectCoords[ 0 ] = lightPos + halfWidth - halfHeight;		rectCoords[ 1 ] = lightPos - halfWidth - halfHeight;
		rectCoords[ 2 ] = lightPos - halfWidth + halfHeight;
		rectCoords[ 3 ] = lightPos + halfWidth + halfHeight;
		vec2 uv = LTC_Uv( normal, viewDir, roughness );
		vec4 t1 = texture2D( ltc_1, uv );
		vec4 t2 = texture2D( ltc_2, uv );
		mat3 mInv = mat3(
			vec3( t1.x, 0, t1.y ),
			vec3(    0, 1,    0 ),
			vec3( t1.z, 0, t1.w )
		);
		vec3 fresnel = ( material.specularColor * t2.x + ( vec3( 1.0 ) - material.specularColor ) * t2.y );
		reflectedLight.directSpecular += lightColor * fresnel * LTC_Evaluate( normal, viewDir, position, mInv, rectCoords );
		reflectedLight.directDiffuse += lightColor * material.diffuseColor * LTC_Evaluate( normal, viewDir, position, mat3( 1.0 ), rectCoords );
	}
#endif
void RE_Direct_Physical( const in IncidentLight directLight, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {
	float dotNL = saturate( dot( geometry.normal, directLight.direction ) );
	vec3 irradiance = dotNL * directLight.color;
	#ifdef USE_CLEARCOAT
		float dotNLcc = saturate( dot( geometry.clearcoatNormal, directLight.direction ) );
		vec3 ccIrradiance = dotNLcc * directLight.color;
		clearcoatSpecular += ccIrradiance * BRDF_GGX( directLight.direction, geometry.viewDir, geometry.clearcoatNormal, material.clearcoatF0, material.clearcoatF90, material.clearcoatRoughness );
	#endif
	#ifdef USE_SHEEN
		sheenSpecular += irradiance * BRDF_Sheen( directLight.direction, geometry.viewDir, geometry.normal, material.sheenColor, material.sheenRoughness );
	#endif
	#ifdef USE_IRIDESCENCE
		reflectedLight.directSpecular += irradiance * BRDF_GGX_Iridescence( directLight.direction, geometry.viewDir, geometry.normal, material.specularColor, material.specularF90, material.iridescence, material.iridescenceFresnel, material.roughness );
	#else
		reflectedLight.directSpecular += irradiance * BRDF_GGX( directLight.direction, geometry.viewDir, geometry.normal, material.specularColor, material.specularF90, material.roughness );
	#endif
	reflectedLight.directDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
void RE_IndirectDiffuse_Physical( const in vec3 irradiance, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {
	reflectedLight.indirectDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}
void RE_IndirectSpecular_Physical( const in vec3 radiance, const in vec3 irradiance, const in vec3 clearcoatRadiance, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight) {
	#ifdef USE_CLEARCOAT
		clearcoatSpecular += clearcoatRadiance * EnvironmentBRDF( geometry.clearcoatNormal, geometry.viewDir, material.clearcoatF0, material.clearcoatF90, material.clearcoatRoughness );
	#endif
	#ifdef USE_SHEEN
		sheenSpecular += irradiance * material.sheenColor * IBLSheenBRDF( geometry.normal, geometry.viewDir, material.sheenRoughness );
	#endif
	vec3 singleScattering = vec3( 0.0 );
	vec3 multiScattering = vec3( 0.0 );
	vec3 cosineWeightedIrradiance = irradiance * RECIPROCAL_PI;
	#ifdef USE_IRIDESCENCE
		computeMultiscatteringIridescence( geometry.normal, geometry.viewDir, material.specularColor, material.specularF90, material.iridescence, material.iridescenceFresnel, material.roughness, singleScattering, multiScattering );
	#else
		computeMultiscattering( geometry.normal, geometry.viewDir, material.specularColor, material.specularF90, material.roughness, singleScattering, multiScattering );
	#endif
	vec3 totalScattering = singleScattering + multiScattering;
	vec3 diffuse = material.diffuseColor * ( 1.0 - max( max( totalScattering.r, totalScattering.g ), totalScattering.b ) );
	reflectedLight.indirectSpecular += radiance * singleScattering;
	reflectedLight.indirectSpecular += multiScattering * cosineWeightedIrradiance;
	reflectedLight.indirectDiffuse += diffuse * cosineWeightedIrradiance;
}
#define RE_Direct				RE_Direct_Physical
#define RE_Direct_RectArea		RE_Direct_RectArea_Physical
#define RE_IndirectDiffuse		RE_IndirectDiffuse_Physical
#define RE_IndirectSpecular		RE_IndirectSpecular_Physical
float computeSpecularOcclusion( const in float dotNV, const in float ambientOcclusion, const in float roughness ) {
	return saturate( pow( dotNV + ambientOcclusion, exp2( - 16.0 * roughness - 1.0 ) ) - 1.0 + ambientOcclusion );
}`,Ag=`
GeometricContext geometry;
geometry.position = - vViewPosition;
geometry.normal = normal;
geometry.viewDir = ( isOrthographic ) ? vec3( 0, 0, 1 ) : normalize( vViewPosition );
#ifdef USE_CLEARCOAT
	geometry.clearcoatNormal = clearcoatNormal;
#endif
#ifdef USE_IRIDESCENCE
	float dotNVi = saturate( dot( normal, geometry.viewDir ) );
	if ( material.iridescenceThickness == 0.0 ) {
		material.iridescence = 0.0;
	} else {
		material.iridescence = saturate( material.iridescence );
	}
	if ( material.iridescence > 0.0 ) {
		material.iridescenceFresnel = evalIridescence( 1.0, material.iridescenceIOR, dotNVi, material.iridescenceThickness, material.specularColor );
		material.iridescenceF0 = Schlick_to_F0( material.iridescenceFresnel, 1.0, dotNVi );
	}
#endif
IncidentLight directLight;
#if ( NUM_POINT_LIGHTS > 0 ) && defined( RE_Direct )
	PointLight pointLight;
	#if defined( USE_SHADOWMAP ) && NUM_POINT_LIGHT_SHADOWS > 0
	PointLightShadow pointLightShadow;
	#endif
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {
		pointLight = pointLights[ i ];
		getPointLightInfo( pointLight, geometry, directLight );
		#if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_POINT_LIGHT_SHADOWS )
		pointLightShadow = pointLightShadows[ i ];
		directLight.color *= ( directLight.visible && receiveShadow ) ? getPointShadow( pointShadowMap[ i ], pointLightShadow.shadowMapSize, pointLightShadow.shadowBias, pointLightShadow.shadowRadius, vPointShadowCoord[ i ], pointLightShadow.shadowCameraNear, pointLightShadow.shadowCameraFar ) : 1.0;
		#endif
		RE_Direct( directLight, geometry, material, reflectedLight );
	}
	#pragma unroll_loop_end
#endif
#if ( NUM_SPOT_LIGHTS > 0 ) && defined( RE_Direct )
	SpotLight spotLight;
	vec4 spotColor;
	vec3 spotLightCoord;
	bool inSpotLightMap;
	#if defined( USE_SHADOWMAP ) && NUM_SPOT_LIGHT_SHADOWS > 0
	SpotLightShadow spotLightShadow;
	#endif
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {
		spotLight = spotLights[ i ];
		getSpotLightInfo( spotLight, geometry, directLight );
		#if ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS_WITH_MAPS )
		#define SPOT_LIGHT_MAP_INDEX UNROLLED_LOOP_INDEX
		#elif ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS )
		#define SPOT_LIGHT_MAP_INDEX NUM_SPOT_LIGHT_MAPS
		#else
		#define SPOT_LIGHT_MAP_INDEX ( UNROLLED_LOOP_INDEX - NUM_SPOT_LIGHT_SHADOWS + NUM_SPOT_LIGHT_SHADOWS_WITH_MAPS )
		#endif
		#if ( SPOT_LIGHT_MAP_INDEX < NUM_SPOT_LIGHT_MAPS )
			spotLightCoord = vSpotLightCoord[ i ].xyz / vSpotLightCoord[ i ].w;
			inSpotLightMap = all( lessThan( abs( spotLightCoord * 2. - 1. ), vec3( 1.0 ) ) );
			spotColor = texture2D( spotLightMap[ SPOT_LIGHT_MAP_INDEX ], spotLightCoord.xy );
			directLight.color = inSpotLightMap ? directLight.color * spotColor.rgb : directLight.color;
		#endif
		#undef SPOT_LIGHT_MAP_INDEX
		#if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS )
		spotLightShadow = spotLightShadows[ i ];
		directLight.color *= ( directLight.visible && receiveShadow ) ? getShadow( spotShadowMap[ i ], spotLightShadow.shadowMapSize, spotLightShadow.shadowBias, spotLightShadow.shadowRadius, vSpotLightCoord[ i ] ) : 1.0;
		#endif
		RE_Direct( directLight, geometry, material, reflectedLight );
	}
	#pragma unroll_loop_end
#endif
#if ( NUM_DIR_LIGHTS > 0 ) && defined( RE_Direct )
	DirectionalLight directionalLight;
	#if defined( USE_SHADOWMAP ) && NUM_DIR_LIGHT_SHADOWS > 0
	DirectionalLightShadow directionalLightShadow;
	#endif
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {
		directionalLight = directionalLights[ i ];
		getDirectionalLightInfo( directionalLight, geometry, directLight );
		#if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_DIR_LIGHT_SHADOWS )
		directionalLightShadow = directionalLightShadows[ i ];
		directLight.color *= ( directLight.visible && receiveShadow ) ? getShadow( directionalShadowMap[ i ], directionalLightShadow.shadowMapSize, directionalLightShadow.shadowBias, directionalLightShadow.shadowRadius, vDirectionalShadowCoord[ i ] ) : 1.0;
		#endif
		RE_Direct( directLight, geometry, material, reflectedLight );
	}
	#pragma unroll_loop_end
#endif
#if ( NUM_RECT_AREA_LIGHTS > 0 ) && defined( RE_Direct_RectArea )
	RectAreaLight rectAreaLight;
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_RECT_AREA_LIGHTS; i ++ ) {
		rectAreaLight = rectAreaLights[ i ];
		RE_Direct_RectArea( rectAreaLight, geometry, material, reflectedLight );
	}
	#pragma unroll_loop_end
#endif
#if defined( RE_IndirectDiffuse )
	vec3 iblIrradiance = vec3( 0.0 );
	vec3 irradiance = getAmbientLightIrradiance( ambientLightColor );
	irradiance += getLightProbeIrradiance( lightProbe, geometry.normal );
	#if ( NUM_HEMI_LIGHTS > 0 )
		#pragma unroll_loop_start
		for ( int i = 0; i < NUM_HEMI_LIGHTS; i ++ ) {
			irradiance += getHemisphereLightIrradiance( hemisphereLights[ i ], geometry.normal );
		}
		#pragma unroll_loop_end
	#endif
#endif
#if defined( RE_IndirectSpecular )
	vec3 radiance = vec3( 0.0 );
	vec3 clearcoatRadiance = vec3( 0.0 );
#endif`,Dg=`#if defined( RE_IndirectDiffuse )
	#ifdef USE_LIGHTMAP
		vec4 lightMapTexel = texture2D( lightMap, vUv2 );
		vec3 lightMapIrradiance = lightMapTexel.rgb * lightMapIntensity;
		irradiance += lightMapIrradiance;
	#endif
	#if defined( USE_ENVMAP ) && defined( STANDARD ) && defined( ENVMAP_TYPE_CUBE_UV )
		iblIrradiance += getIBLIrradiance( geometry.normal );
	#endif
#endif
#if defined( USE_ENVMAP ) && defined( RE_IndirectSpecular )
	radiance += getIBLRadiance( geometry.viewDir, geometry.normal, material.roughness );
	#ifdef USE_CLEARCOAT
		clearcoatRadiance += getIBLRadiance( geometry.viewDir, geometry.clearcoatNormal, material.clearcoatRoughness );
	#endif
#endif`,Rg=`#if defined( RE_IndirectDiffuse )
	RE_IndirectDiffuse( irradiance, geometry, material, reflectedLight );
#endif
#if defined( RE_IndirectSpecular )
	RE_IndirectSpecular( radiance, iblIrradiance, clearcoatRadiance, geometry, material, reflectedLight );
#endif`,kg=`#if defined( USE_LOGDEPTHBUF ) && defined( USE_LOGDEPTHBUF_EXT )
	gl_FragDepthEXT = vIsPerspective == 0.0 ? gl_FragCoord.z : log2( vFragDepth ) * logDepthBufFC * 0.5;
#endif`,Ig=`#if defined( USE_LOGDEPTHBUF ) && defined( USE_LOGDEPTHBUF_EXT )
	uniform float logDepthBufFC;
	varying float vFragDepth;
	varying float vIsPerspective;
#endif`,Ng=`#ifdef USE_LOGDEPTHBUF
	#ifdef USE_LOGDEPTHBUF_EXT
		varying float vFragDepth;
		varying float vIsPerspective;
	#else
		uniform float logDepthBufFC;
	#endif
#endif`,zg=`#ifdef USE_LOGDEPTHBUF
	#ifdef USE_LOGDEPTHBUF_EXT
		vFragDepth = 1.0 + gl_Position.w;
		vIsPerspective = float( isPerspectiveMatrix( projectionMatrix ) );
	#else
		if ( isPerspectiveMatrix( projectionMatrix ) ) {
			gl_Position.z = log2( max( EPSILON, gl_Position.w + 1.0 ) ) * logDepthBufFC - 1.0;
			gl_Position.z *= gl_Position.w;
		}
	#endif
#endif`,Fg=`#ifdef USE_MAP
	vec4 sampledDiffuseColor = texture2D( map, vUv );
	#ifdef DECODE_VIDEO_TEXTURE
		sampledDiffuseColor = vec4( mix( pow( sampledDiffuseColor.rgb * 0.9478672986 + vec3( 0.0521327014 ), vec3( 2.4 ) ), sampledDiffuseColor.rgb * 0.0773993808, vec3( lessThanEqual( sampledDiffuseColor.rgb, vec3( 0.04045 ) ) ) ), sampledDiffuseColor.w );
	#endif
	diffuseColor *= sampledDiffuseColor;
#endif`,Og=`#ifdef USE_MAP
	uniform sampler2D map;
#endif`,Ug=`#if defined( USE_MAP ) || defined( USE_ALPHAMAP )
	vec2 uv = ( uvTransform * vec3( gl_PointCoord.x, 1.0 - gl_PointCoord.y, 1 ) ).xy;
#endif
#ifdef USE_MAP
	diffuseColor *= texture2D( map, uv );
#endif
#ifdef USE_ALPHAMAP
	diffuseColor.a *= texture2D( alphaMap, uv ).g;
#endif`,Bg=`#if defined( USE_MAP ) || defined( USE_ALPHAMAP )
	uniform mat3 uvTransform;
#endif
#ifdef USE_MAP
	uniform sampler2D map;
#endif
#ifdef USE_ALPHAMAP
	uniform sampler2D alphaMap;
#endif`,Vg=`float metalnessFactor = metalness;
#ifdef USE_METALNESSMAP
	vec4 texelMetalness = texture2D( metalnessMap, vUv );
	metalnessFactor *= texelMetalness.b;
#endif`,Gg=`#ifdef USE_METALNESSMAP
	uniform sampler2D metalnessMap;
#endif`,Hg=`#if defined( USE_MORPHCOLORS ) && defined( MORPHTARGETS_TEXTURE )
	vColor *= morphTargetBaseInfluence;
	for ( int i = 0; i < MORPHTARGETS_COUNT; i ++ ) {
		#if defined( USE_COLOR_ALPHA )
			if ( morphTargetInfluences[ i ] != 0.0 ) vColor += getMorph( gl_VertexID, i, 2 ) * morphTargetInfluences[ i ];
		#elif defined( USE_COLOR )
			if ( morphTargetInfluences[ i ] != 0.0 ) vColor += getMorph( gl_VertexID, i, 2 ).rgb * morphTargetInfluences[ i ];
		#endif
	}
#endif`,Wg=`#ifdef USE_MORPHNORMALS
	objectNormal *= morphTargetBaseInfluence;
	#ifdef MORPHTARGETS_TEXTURE
		for ( int i = 0; i < MORPHTARGETS_COUNT; i ++ ) {
			if ( morphTargetInfluences[ i ] != 0.0 ) objectNormal += getMorph( gl_VertexID, i, 1 ).xyz * morphTargetInfluences[ i ];
		}
	#else
		objectNormal += morphNormal0 * morphTargetInfluences[ 0 ];
		objectNormal += morphNormal1 * morphTargetInfluences[ 1 ];
		objectNormal += morphNormal2 * morphTargetInfluences[ 2 ];
		objectNormal += morphNormal3 * morphTargetInfluences[ 3 ];
	#endif
#endif`,Xg=`#ifdef USE_MORPHTARGETS
	uniform float morphTargetBaseInfluence;
	#ifdef MORPHTARGETS_TEXTURE
		uniform float morphTargetInfluences[ MORPHTARGETS_COUNT ];
		uniform sampler2DArray morphTargetsTexture;
		uniform ivec2 morphTargetsTextureSize;
		vec4 getMorph( const in int vertexIndex, const in int morphTargetIndex, const in int offset ) {
			int texelIndex = vertexIndex * MORPHTARGETS_TEXTURE_STRIDE + offset;
			int y = texelIndex / morphTargetsTextureSize.x;
			int x = texelIndex - y * morphTargetsTextureSize.x;
			ivec3 morphUV = ivec3( x, y, morphTargetIndex );
			return texelFetch( morphTargetsTexture, morphUV, 0 );
		}
	#else
		#ifndef USE_MORPHNORMALS
			uniform float morphTargetInfluences[ 8 ];
		#else
			uniform float morphTargetInfluences[ 4 ];
		#endif
	#endif
#endif`,jg=`#ifdef USE_MORPHTARGETS
	transformed *= morphTargetBaseInfluence;
	#ifdef MORPHTARGETS_TEXTURE
		for ( int i = 0; i < MORPHTARGETS_COUNT; i ++ ) {
			if ( morphTargetInfluences[ i ] != 0.0 ) transformed += getMorph( gl_VertexID, i, 0 ).xyz * morphTargetInfluences[ i ];
		}
	#else
		transformed += morphTarget0 * morphTargetInfluences[ 0 ];
		transformed += morphTarget1 * morphTargetInfluences[ 1 ];
		transformed += morphTarget2 * morphTargetInfluences[ 2 ];
		transformed += morphTarget3 * morphTargetInfluences[ 3 ];
		#ifndef USE_MORPHNORMALS
			transformed += morphTarget4 * morphTargetInfluences[ 4 ];
			transformed += morphTarget5 * morphTargetInfluences[ 5 ];
			transformed += morphTarget6 * morphTargetInfluences[ 6 ];
			transformed += morphTarget7 * morphTargetInfluences[ 7 ];
		#endif
	#endif
#endif`,qg=`float faceDirection = gl_FrontFacing ? 1.0 : - 1.0;
#ifdef FLAT_SHADED
	vec3 fdx = dFdx( vViewPosition );
	vec3 fdy = dFdy( vViewPosition );
	vec3 normal = normalize( cross( fdx, fdy ) );
#else
	vec3 normal = normalize( vNormal );
	#ifdef DOUBLE_SIDED
		normal = normal * faceDirection;
	#endif
	#ifdef USE_TANGENT
		vec3 tangent = normalize( vTangent );
		vec3 bitangent = normalize( vBitangent );
		#ifdef DOUBLE_SIDED
			tangent = tangent * faceDirection;
			bitangent = bitangent * faceDirection;
		#endif
		#if defined( TANGENTSPACE_NORMALMAP ) || defined( USE_CLEARCOAT_NORMALMAP )
			mat3 vTBN = mat3( tangent, bitangent, normal );
		#endif
	#endif
#endif
vec3 geometryNormal = normal;`,Yg=`#ifdef OBJECTSPACE_NORMALMAP
	normal = texture2D( normalMap, vUv ).xyz * 2.0 - 1.0;
	#ifdef FLIP_SIDED
		normal = - normal;
	#endif
	#ifdef DOUBLE_SIDED
		normal = normal * faceDirection;
	#endif
	normal = normalize( normalMatrix * normal );
#elif defined( TANGENTSPACE_NORMALMAP )
	vec3 mapN = texture2D( normalMap, vUv ).xyz * 2.0 - 1.0;
	mapN.xy *= normalScale;
	#ifdef USE_TANGENT
		normal = normalize( vTBN * mapN );
	#else
		normal = perturbNormal2Arb( - vViewPosition, normal, mapN, faceDirection );
	#endif
#elif defined( USE_BUMPMAP )
	normal = perturbNormalArb( - vViewPosition, normal, dHdxy_fwd(), faceDirection );
#endif`,Zg=`#ifndef FLAT_SHADED
	varying vec3 vNormal;
	#ifdef USE_TANGENT
		varying vec3 vTangent;
		varying vec3 vBitangent;
	#endif
#endif`,Kg=`#ifndef FLAT_SHADED
	varying vec3 vNormal;
	#ifdef USE_TANGENT
		varying vec3 vTangent;
		varying vec3 vBitangent;
	#endif
#endif`,Jg=`#ifndef FLAT_SHADED
	vNormal = normalize( transformedNormal );
	#ifdef USE_TANGENT
		vTangent = normalize( transformedTangent );
		vBitangent = normalize( cross( vNormal, vTangent ) * tangent.w );
	#endif
#endif`,Qg=`#ifdef USE_NORMALMAP
	uniform sampler2D normalMap;
	uniform vec2 normalScale;
#endif
#ifdef OBJECTSPACE_NORMALMAP
	uniform mat3 normalMatrix;
#endif
#if ! defined ( USE_TANGENT ) && ( defined ( TANGENTSPACE_NORMALMAP ) || defined ( USE_CLEARCOAT_NORMALMAP ) )
	vec3 perturbNormal2Arb( vec3 eye_pos, vec3 surf_norm, vec3 mapN, float faceDirection ) {
		vec3 q0 = dFdx( eye_pos.xyz );
		vec3 q1 = dFdy( eye_pos.xyz );
		vec2 st0 = dFdx( vUv.st );
		vec2 st1 = dFdy( vUv.st );
		vec3 N = surf_norm;
		vec3 q1perp = cross( q1, N );
		vec3 q0perp = cross( N, q0 );
		vec3 T = q1perp * st0.x + q0perp * st1.x;
		vec3 B = q1perp * st0.y + q0perp * st1.y;
		float det = max( dot( T, T ), dot( B, B ) );
		float scale = ( det == 0.0 ) ? 0.0 : faceDirection * inversesqrt( det );
		return normalize( T * ( mapN.x * scale ) + B * ( mapN.y * scale ) + N * mapN.z );
	}
#endif`,$g=`#ifdef USE_CLEARCOAT
	vec3 clearcoatNormal = geometryNormal;
#endif`,e0=`#ifdef USE_CLEARCOAT_NORMALMAP
	vec3 clearcoatMapN = texture2D( clearcoatNormalMap, vUv ).xyz * 2.0 - 1.0;
	clearcoatMapN.xy *= clearcoatNormalScale;
	#ifdef USE_TANGENT
		clearcoatNormal = normalize( vTBN * clearcoatMapN );
	#else
		clearcoatNormal = perturbNormal2Arb( - vViewPosition, clearcoatNormal, clearcoatMapN, faceDirection );
	#endif
#endif`,t0=`#ifdef USE_CLEARCOATMAP
	uniform sampler2D clearcoatMap;
#endif
#ifdef USE_CLEARCOAT_ROUGHNESSMAP
	uniform sampler2D clearcoatRoughnessMap;
#endif
#ifdef USE_CLEARCOAT_NORMALMAP
	uniform sampler2D clearcoatNormalMap;
	uniform vec2 clearcoatNormalScale;
#endif`,n0=`#ifdef USE_IRIDESCENCEMAP
	uniform sampler2D iridescenceMap;
#endif
#ifdef USE_IRIDESCENCE_THICKNESSMAP
	uniform sampler2D iridescenceThicknessMap;
#endif`,i0=`#ifdef OPAQUE
diffuseColor.a = 1.0;
#endif
#ifdef USE_TRANSMISSION
diffuseColor.a *= material.transmissionAlpha + 0.1;
#endif
gl_FragColor = vec4( outgoingLight, diffuseColor.a );`,r0=`vec3 packNormalToRGB( const in vec3 normal ) {
	return normalize( normal ) * 0.5 + 0.5;
}
vec3 unpackRGBToNormal( const in vec3 rgb ) {
	return 2.0 * rgb.xyz - 1.0;
}
const float PackUpscale = 256. / 255.;const float UnpackDownscale = 255. / 256.;
const vec3 PackFactors = vec3( 256. * 256. * 256., 256. * 256., 256. );
const vec4 UnpackFactors = UnpackDownscale / vec4( PackFactors, 1. );
const float ShiftRight8 = 1. / 256.;
vec4 packDepthToRGBA( const in float v ) {
	vec4 r = vec4( fract( v * PackFactors ), v );
	r.yzw -= r.xyz * ShiftRight8;	return r * PackUpscale;
}
float unpackRGBAToDepth( const in vec4 v ) {
	return dot( v, UnpackFactors );
}
vec2 packDepthToRG( in highp float v ) {
	return packDepthToRGBA( v ).yx;
}
float unpackRGToDepth( const in highp vec2 v ) {
	return unpackRGBAToDepth( vec4( v.xy, 0.0, 0.0 ) );
}
vec4 pack2HalfToRGBA( vec2 v ) {
	vec4 r = vec4( v.x, fract( v.x * 255.0 ), v.y, fract( v.y * 255.0 ) );
	return vec4( r.x - r.y / 255.0, r.y, r.z - r.w / 255.0, r.w );
}
vec2 unpackRGBATo2Half( vec4 v ) {
	return vec2( v.x + ( v.y / 255.0 ), v.z + ( v.w / 255.0 ) );
}
float viewZToOrthographicDepth( const in float viewZ, const in float near, const in float far ) {
	return ( viewZ + near ) / ( near - far );
}
float orthographicDepthToViewZ( const in float linearClipZ, const in float near, const in float far ) {
	return linearClipZ * ( near - far ) - near;
}
float viewZToPerspectiveDepth( const in float viewZ, const in float near, const in float far ) {
	return ( ( near + viewZ ) * far ) / ( ( far - near ) * viewZ );
}
float perspectiveDepthToViewZ( const in float invClipZ, const in float near, const in float far ) {
	return ( near * far ) / ( ( far - near ) * invClipZ - far );
}`,s0=`#ifdef PREMULTIPLIED_ALPHA
	gl_FragColor.rgb *= gl_FragColor.a;
#endif`,a0=`vec4 mvPosition = vec4( transformed, 1.0 );
#ifdef USE_INSTANCING
	mvPosition = instanceMatrix * mvPosition;
#endif
mvPosition = modelViewMatrix * mvPosition;
gl_Position = projectionMatrix * mvPosition;`,o0=`#ifdef DITHERING
	gl_FragColor.rgb = dithering( gl_FragColor.rgb );
#endif`,l0=`#ifdef DITHERING
	vec3 dithering( vec3 color ) {
		float grid_position = rand( gl_FragCoord.xy );
		vec3 dither_shift_RGB = vec3( 0.25 / 255.0, -0.25 / 255.0, 0.25 / 255.0 );
		dither_shift_RGB = mix( 2.0 * dither_shift_RGB, -2.0 * dither_shift_RGB, grid_position );
		return color + dither_shift_RGB;
	}
#endif`,c0=`float roughnessFactor = roughness;
#ifdef USE_ROUGHNESSMAP
	vec4 texelRoughness = texture2D( roughnessMap, vUv );
	roughnessFactor *= texelRoughness.g;
#endif`,u0=`#ifdef USE_ROUGHNESSMAP
	uniform sampler2D roughnessMap;
#endif`,f0=`#if NUM_SPOT_LIGHT_COORDS > 0
	varying vec4 vSpotLightCoord[ NUM_SPOT_LIGHT_COORDS ];
#endif
#if NUM_SPOT_LIGHT_MAPS > 0
	uniform sampler2D spotLightMap[ NUM_SPOT_LIGHT_MAPS ];
#endif
#ifdef USE_SHADOWMAP
	#if NUM_DIR_LIGHT_SHADOWS > 0
		uniform sampler2D directionalShadowMap[ NUM_DIR_LIGHT_SHADOWS ];
		varying vec4 vDirectionalShadowCoord[ NUM_DIR_LIGHT_SHADOWS ];
		struct DirectionalLightShadow {
			float shadowBias;
			float shadowNormalBias;
			float shadowRadius;
			vec2 shadowMapSize;
		};
		uniform DirectionalLightShadow directionalLightShadows[ NUM_DIR_LIGHT_SHADOWS ];
	#endif
	#if NUM_SPOT_LIGHT_SHADOWS > 0
		uniform sampler2D spotShadowMap[ NUM_SPOT_LIGHT_SHADOWS ];
		struct SpotLightShadow {
			float shadowBias;
			float shadowNormalBias;
			float shadowRadius;
			vec2 shadowMapSize;
		};
		uniform SpotLightShadow spotLightShadows[ NUM_SPOT_LIGHT_SHADOWS ];
	#endif
	#if NUM_POINT_LIGHT_SHADOWS > 0
		uniform sampler2D pointShadowMap[ NUM_POINT_LIGHT_SHADOWS ];
		varying vec4 vPointShadowCoord[ NUM_POINT_LIGHT_SHADOWS ];
		struct PointLightShadow {
			float shadowBias;
			float shadowNormalBias;
			float shadowRadius;
			vec2 shadowMapSize;
			float shadowCameraNear;
			float shadowCameraFar;
		};
		uniform PointLightShadow pointLightShadows[ NUM_POINT_LIGHT_SHADOWS ];
	#endif
	float texture2DCompare( sampler2D depths, vec2 uv, float compare ) {
		return step( compare, unpackRGBAToDepth( texture2D( depths, uv ) ) );
	}
	vec2 texture2DDistribution( sampler2D shadow, vec2 uv ) {
		return unpackRGBATo2Half( texture2D( shadow, uv ) );
	}
	float VSMShadow (sampler2D shadow, vec2 uv, float compare ){
		float occlusion = 1.0;
		vec2 distribution = texture2DDistribution( shadow, uv );
		float hard_shadow = step( compare , distribution.x );
		if (hard_shadow != 1.0 ) {
			float distance = compare - distribution.x ;
			float variance = max( 0.00000, distribution.y * distribution.y );
			float softness_probability = variance / (variance + distance * distance );			softness_probability = clamp( ( softness_probability - 0.3 ) / ( 0.95 - 0.3 ), 0.0, 1.0 );			occlusion = clamp( max( hard_shadow, softness_probability ), 0.0, 1.0 );
		}
		return occlusion;
	}
	float getShadow( sampler2D shadowMap, vec2 shadowMapSize, float shadowBias, float shadowRadius, vec4 shadowCoord ) {
		float shadow = 1.0;
		shadowCoord.xyz /= shadowCoord.w;
		shadowCoord.z += shadowBias;
		bool inFrustum = shadowCoord.x >= 0.0 && shadowCoord.x <= 1.0 && shadowCoord.y >= 0.0 && shadowCoord.y <= 1.0;
		bool frustumTest = inFrustum && shadowCoord.z <= 1.0;
		if ( frustumTest ) {
		#if defined( SHADOWMAP_TYPE_PCF )
			vec2 texelSize = vec2( 1.0 ) / shadowMapSize;
			float dx0 = - texelSize.x * shadowRadius;
			float dy0 = - texelSize.y * shadowRadius;
			float dx1 = + texelSize.x * shadowRadius;
			float dy1 = + texelSize.y * shadowRadius;
			float dx2 = dx0 / 2.0;
			float dy2 = dy0 / 2.0;
			float dx3 = dx1 / 2.0;
			float dy3 = dy1 / 2.0;
			shadow = (
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, dy0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, dy0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx2, dy2 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy2 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx3, dy2 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx2, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy, shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx3, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx2, dy3 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy3 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx3, dy3 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, dy1 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy1 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, dy1 ), shadowCoord.z )
			) * ( 1.0 / 17.0 );
		#elif defined( SHADOWMAP_TYPE_PCF_SOFT )
			vec2 texelSize = vec2( 1.0 ) / shadowMapSize;
			float dx = texelSize.x;
			float dy = texelSize.y;
			vec2 uv = shadowCoord.xy;
			vec2 f = fract( uv * shadowMapSize + 0.5 );
			uv -= f * texelSize;
			shadow = (
				texture2DCompare( shadowMap, uv, shadowCoord.z ) +
				texture2DCompare( shadowMap, uv + vec2( dx, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, uv + vec2( 0.0, dy ), shadowCoord.z ) +
				texture2DCompare( shadowMap, uv + texelSize, shadowCoord.z ) +
				mix( texture2DCompare( shadowMap, uv + vec2( -dx, 0.0 ), shadowCoord.z ),
					 texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, 0.0 ), shadowCoord.z ),
					 f.x ) +
				mix( texture2DCompare( shadowMap, uv + vec2( -dx, dy ), shadowCoord.z ),
					 texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, dy ), shadowCoord.z ),
					 f.x ) +
				mix( texture2DCompare( shadowMap, uv + vec2( 0.0, -dy ), shadowCoord.z ),
					 texture2DCompare( shadowMap, uv + vec2( 0.0, 2.0 * dy ), shadowCoord.z ),
					 f.y ) +
				mix( texture2DCompare( shadowMap, uv + vec2( dx, -dy ), shadowCoord.z ),
					 texture2DCompare( shadowMap, uv + vec2( dx, 2.0 * dy ), shadowCoord.z ),
					 f.y ) +
				mix( mix( texture2DCompare( shadowMap, uv + vec2( -dx, -dy ), shadowCoord.z ),
						  texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, -dy ), shadowCoord.z ),
						  f.x ),
					 mix( texture2DCompare( shadowMap, uv + vec2( -dx, 2.0 * dy ), shadowCoord.z ),
						  texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, 2.0 * dy ), shadowCoord.z ),
						  f.x ),
					 f.y )
			) * ( 1.0 / 9.0 );
		#elif defined( SHADOWMAP_TYPE_VSM )
			shadow = VSMShadow( shadowMap, shadowCoord.xy, shadowCoord.z );
		#else
			shadow = texture2DCompare( shadowMap, shadowCoord.xy, shadowCoord.z );
		#endif
		}
		return shadow;
	}
	vec2 cubeToUV( vec3 v, float texelSizeY ) {
		vec3 absV = abs( v );
		float scaleToCube = 1.0 / max( absV.x, max( absV.y, absV.z ) );
		absV *= scaleToCube;
		v *= scaleToCube * ( 1.0 - 2.0 * texelSizeY );
		vec2 planar = v.xy;
		float almostATexel = 1.5 * texelSizeY;
		float almostOne = 1.0 - almostATexel;
		if ( absV.z >= almostOne ) {
			if ( v.z > 0.0 )
				planar.x = 4.0 - v.x;
		} else if ( absV.x >= almostOne ) {
			float signX = sign( v.x );
			planar.x = v.z * signX + 2.0 * signX;
		} else if ( absV.y >= almostOne ) {
			float signY = sign( v.y );
			planar.x = v.x + 2.0 * signY + 2.0;
			planar.y = v.z * signY - 2.0;
		}
		return vec2( 0.125, 0.25 ) * planar + vec2( 0.375, 0.75 );
	}
	float getPointShadow( sampler2D shadowMap, vec2 shadowMapSize, float shadowBias, float shadowRadius, vec4 shadowCoord, float shadowCameraNear, float shadowCameraFar ) {
		vec2 texelSize = vec2( 1.0 ) / ( shadowMapSize * vec2( 4.0, 2.0 ) );
		vec3 lightToPosition = shadowCoord.xyz;
		float dp = ( length( lightToPosition ) - shadowCameraNear ) / ( shadowCameraFar - shadowCameraNear );		dp += shadowBias;
		vec3 bd3D = normalize( lightToPosition );
		#if defined( SHADOWMAP_TYPE_PCF ) || defined( SHADOWMAP_TYPE_PCF_SOFT ) || defined( SHADOWMAP_TYPE_VSM )
			vec2 offset = vec2( - 1, 1 ) * shadowRadius * texelSize.y;
			return (
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xyy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yyy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xyx, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yyx, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xxy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yxy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xxx, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yxx, texelSize.y ), dp )
			) * ( 1.0 / 9.0 );
		#else
			return texture2DCompare( shadowMap, cubeToUV( bd3D, texelSize.y ), dp );
		#endif
	}
#endif`,d0=`#if NUM_SPOT_LIGHT_COORDS > 0
	uniform mat4 spotLightMatrix[ NUM_SPOT_LIGHT_COORDS ];
	varying vec4 vSpotLightCoord[ NUM_SPOT_LIGHT_COORDS ];
#endif
#ifdef USE_SHADOWMAP
	#if NUM_DIR_LIGHT_SHADOWS > 0
		uniform mat4 directionalShadowMatrix[ NUM_DIR_LIGHT_SHADOWS ];
		varying vec4 vDirectionalShadowCoord[ NUM_DIR_LIGHT_SHADOWS ];
		struct DirectionalLightShadow {
			float shadowBias;
			float shadowNormalBias;
			float shadowRadius;
			vec2 shadowMapSize;
		};
		uniform DirectionalLightShadow directionalLightShadows[ NUM_DIR_LIGHT_SHADOWS ];
	#endif
	#if NUM_SPOT_LIGHT_SHADOWS > 0
		struct SpotLightShadow {
			float shadowBias;
			float shadowNormalBias;
			float shadowRadius;
			vec2 shadowMapSize;
		};
		uniform SpotLightShadow spotLightShadows[ NUM_SPOT_LIGHT_SHADOWS ];
	#endif
	#if NUM_POINT_LIGHT_SHADOWS > 0
		uniform mat4 pointShadowMatrix[ NUM_POINT_LIGHT_SHADOWS ];
		varying vec4 vPointShadowCoord[ NUM_POINT_LIGHT_SHADOWS ];
		struct PointLightShadow {
			float shadowBias;
			float shadowNormalBias;
			float shadowRadius;
			vec2 shadowMapSize;
			float shadowCameraNear;
			float shadowCameraFar;
		};
		uniform PointLightShadow pointLightShadows[ NUM_POINT_LIGHT_SHADOWS ];
	#endif
#endif`,h0=`#if ( defined( USE_SHADOWMAP ) && ( NUM_DIR_LIGHT_SHADOWS > 0 || NUM_POINT_LIGHT_SHADOWS > 0 ) ) || ( NUM_SPOT_LIGHT_COORDS > 0 )
	vec3 shadowWorldNormal = inverseTransformDirection( transformedNormal, viewMatrix );
	vec4 shadowWorldPosition;
#endif
#if defined( USE_SHADOWMAP )
	#if NUM_DIR_LIGHT_SHADOWS > 0
		#pragma unroll_loop_start
		for ( int i = 0; i < NUM_DIR_LIGHT_SHADOWS; i ++ ) {
			shadowWorldPosition = worldPosition + vec4( shadowWorldNormal * directionalLightShadows[ i ].shadowNormalBias, 0 );
			vDirectionalShadowCoord[ i ] = directionalShadowMatrix[ i ] * shadowWorldPosition;
		}
		#pragma unroll_loop_end
	#endif
	#if NUM_POINT_LIGHT_SHADOWS > 0
		#pragma unroll_loop_start
		for ( int i = 0; i < NUM_POINT_LIGHT_SHADOWS; i ++ ) {
			shadowWorldPosition = worldPosition + vec4( shadowWorldNormal * pointLightShadows[ i ].shadowNormalBias, 0 );
			vPointShadowCoord[ i ] = pointShadowMatrix[ i ] * shadowWorldPosition;
		}
		#pragma unroll_loop_end
	#endif
#endif
#if NUM_SPOT_LIGHT_COORDS > 0
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_SPOT_LIGHT_COORDS; i ++ ) {
		shadowWorldPosition = worldPosition;
		#if ( defined( USE_SHADOWMAP ) && UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS )
			shadowWorldPosition.xyz += shadowWorldNormal * spotLightShadows[ i ].shadowNormalBias;
		#endif
		vSpotLightCoord[ i ] = spotLightMatrix[ i ] * shadowWorldPosition;
	}
	#pragma unroll_loop_end
#endif`,p0=`float getShadowMask() {
	float shadow = 1.0;
	#ifdef USE_SHADOWMAP
	#if NUM_DIR_LIGHT_SHADOWS > 0
	DirectionalLightShadow directionalLight;
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_DIR_LIGHT_SHADOWS; i ++ ) {
		directionalLight = directionalLightShadows[ i ];
		shadow *= receiveShadow ? getShadow( directionalShadowMap[ i ], directionalLight.shadowMapSize, directionalLight.shadowBias, directionalLight.shadowRadius, vDirectionalShadowCoord[ i ] ) : 1.0;
	}
	#pragma unroll_loop_end
	#endif
	#if NUM_SPOT_LIGHT_SHADOWS > 0
	SpotLightShadow spotLight;
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_SPOT_LIGHT_SHADOWS; i ++ ) {
		spotLight = spotLightShadows[ i ];
		shadow *= receiveShadow ? getShadow( spotShadowMap[ i ], spotLight.shadowMapSize, spotLight.shadowBias, spotLight.shadowRadius, vSpotLightCoord[ i ] ) : 1.0;
	}
	#pragma unroll_loop_end
	#endif
	#if NUM_POINT_LIGHT_SHADOWS > 0
	PointLightShadow pointLight;
	#pragma unroll_loop_start
	for ( int i = 0; i < NUM_POINT_LIGHT_SHADOWS; i ++ ) {
		pointLight = pointLightShadows[ i ];
		shadow *= receiveShadow ? getPointShadow( pointShadowMap[ i ], pointLight.shadowMapSize, pointLight.shadowBias, pointLight.shadowRadius, vPointShadowCoord[ i ], pointLight.shadowCameraNear, pointLight.shadowCameraFar ) : 1.0;
	}
	#pragma unroll_loop_end
	#endif
	#endif
	return shadow;
}`,m0=`#ifdef USE_SKINNING
	mat4 boneMatX = getBoneMatrix( skinIndex.x );
	mat4 boneMatY = getBoneMatrix( skinIndex.y );
	mat4 boneMatZ = getBoneMatrix( skinIndex.z );
	mat4 boneMatW = getBoneMatrix( skinIndex.w );
#endif`,_0=`#ifdef USE_SKINNING
	uniform mat4 bindMatrix;
	uniform mat4 bindMatrixInverse;
	uniform highp sampler2D boneTexture;
	uniform int boneTextureSize;
	mat4 getBoneMatrix( const in float i ) {
		float j = i * 4.0;
		float x = mod( j, float( boneTextureSize ) );
		float y = floor( j / float( boneTextureSize ) );
		float dx = 1.0 / float( boneTextureSize );
		float dy = 1.0 / float( boneTextureSize );
		y = dy * ( y + 0.5 );
		vec4 v1 = texture2D( boneTexture, vec2( dx * ( x + 0.5 ), y ) );
		vec4 v2 = texture2D( boneTexture, vec2( dx * ( x + 1.5 ), y ) );
		vec4 v3 = texture2D( boneTexture, vec2( dx * ( x + 2.5 ), y ) );
		vec4 v4 = texture2D( boneTexture, vec2( dx * ( x + 3.5 ), y ) );
		mat4 bone = mat4( v1, v2, v3, v4 );
		return bone;
	}
#endif`,g0=`#ifdef USE_SKINNING
	vec4 skinVertex = bindMatrix * vec4( transformed, 1.0 );
	vec4 skinned = vec4( 0.0 );
	skinned += boneMatX * skinVertex * skinWeight.x;
	skinned += boneMatY * skinVertex * skinWeight.y;
	skinned += boneMatZ * skinVertex * skinWeight.z;
	skinned += boneMatW * skinVertex * skinWeight.w;
	transformed = ( bindMatrixInverse * skinned ).xyz;
#endif`,b0=`#ifdef USE_SKINNING
	mat4 skinMatrix = mat4( 0.0 );
	skinMatrix += skinWeight.x * boneMatX;
	skinMatrix += skinWeight.y * boneMatY;
	skinMatrix += skinWeight.z * boneMatZ;
	skinMatrix += skinWeight.w * boneMatW;
	skinMatrix = bindMatrixInverse * skinMatrix * bindMatrix;
	objectNormal = vec4( skinMatrix * vec4( objectNormal, 0.0 ) ).xyz;
	#ifdef USE_TANGENT
		objectTangent = vec4( skinMatrix * vec4( objectTangent, 0.0 ) ).xyz;
	#endif
#endif`,v0=`float specularStrength;
#ifdef USE_SPECULARMAP
	vec4 texelSpecular = texture2D( specularMap, vUv );
	specularStrength = texelSpecular.r;
#else
	specularStrength = 1.0;
#endif`,y0=`#ifdef USE_SPECULARMAP
	uniform sampler2D specularMap;
#endif`,w0=`#if defined( TONE_MAPPING )
	gl_FragColor.rgb = toneMapping( gl_FragColor.rgb );
#endif`,x0=`#ifndef saturate
#define saturate( a ) clamp( a, 0.0, 1.0 )
#endif
uniform float toneMappingExposure;
vec3 LinearToneMapping( vec3 color ) {
	return toneMappingExposure * color;
}
vec3 ReinhardToneMapping( vec3 color ) {
	color *= toneMappingExposure;
	return saturate( color / ( vec3( 1.0 ) + color ) );
}
vec3 OptimizedCineonToneMapping( vec3 color ) {
	color *= toneMappingExposure;
	color = max( vec3( 0.0 ), color - 0.004 );
	return pow( ( color * ( 6.2 * color + 0.5 ) ) / ( color * ( 6.2 * color + 1.7 ) + 0.06 ), vec3( 2.2 ) );
}
vec3 RRTAndODTFit( vec3 v ) {
	vec3 a = v * ( v + 0.0245786 ) - 0.000090537;
	vec3 b = v * ( 0.983729 * v + 0.4329510 ) + 0.238081;
	return a / b;
}
vec3 ACESFilmicToneMapping( vec3 color ) {
	const mat3 ACESInputMat = mat3(
		vec3( 0.59719, 0.07600, 0.02840 ),		vec3( 0.35458, 0.90834, 0.13383 ),
		vec3( 0.04823, 0.01566, 0.83777 )
	);
	const mat3 ACESOutputMat = mat3(
		vec3(  1.60475, -0.10208, -0.00327 ),		vec3( -0.53108,  1.10813, -0.07276 ),
		vec3( -0.07367, -0.00605,  1.07602 )
	);
	color *= toneMappingExposure / 0.6;
	color = ACESInputMat * color;
	color = RRTAndODTFit( color );
	color = ACESOutputMat * color;
	return saturate( color );
}
vec3 CustomToneMapping( vec3 color ) { return color; }`,M0=`#ifdef USE_TRANSMISSION
	material.transmission = transmission;
	material.transmissionAlpha = 1.0;
	material.thickness = thickness;
	material.attenuationDistance = attenuationDistance;
	material.attenuationColor = attenuationColor;
	#ifdef USE_TRANSMISSIONMAP
		material.transmission *= texture2D( transmissionMap, vUv ).r;
	#endif
	#ifdef USE_THICKNESSMAP
		material.thickness *= texture2D( thicknessMap, vUv ).g;
	#endif
	vec3 pos = vWorldPosition;
	vec3 v = normalize( cameraPosition - pos );
	vec3 n = inverseTransformDirection( normal, viewMatrix );
	vec4 transmission = getIBLVolumeRefraction(
		n, v, material.roughness, material.diffuseColor, material.specularColor, material.specularF90,
		pos, modelMatrix, viewMatrix, projectionMatrix, material.ior, material.thickness,
		material.attenuationColor, material.attenuationDistance );
	material.transmissionAlpha = mix( material.transmissionAlpha, transmission.a, material.transmission );
	totalDiffuse = mix( totalDiffuse, transmission.rgb, material.transmission );
#endif`,S0=`#ifdef USE_TRANSMISSION
	uniform float transmission;
	uniform float thickness;
	uniform float attenuationDistance;
	uniform vec3 attenuationColor;
	#ifdef USE_TRANSMISSIONMAP
		uniform sampler2D transmissionMap;
	#endif
	#ifdef USE_THICKNESSMAP
		uniform sampler2D thicknessMap;
	#endif
	uniform vec2 transmissionSamplerSize;
	uniform sampler2D transmissionSamplerMap;
	uniform mat4 modelMatrix;
	uniform mat4 projectionMatrix;
	varying vec3 vWorldPosition;
	float w0( float a ) {
		return ( 1.0 / 6.0 ) * ( a * ( a * ( - a + 3.0 ) - 3.0 ) + 1.0 );
	}
	float w1( float a ) {
		return ( 1.0 / 6.0 ) * ( a *  a * ( 3.0 * a - 6.0 ) + 4.0 );
	}
	float w2( float a ){
		return ( 1.0 / 6.0 ) * ( a * ( a * ( - 3.0 * a + 3.0 ) + 3.0 ) + 1.0 );
	}
	float w3( float a ) {
		return ( 1.0 / 6.0 ) * ( a * a * a );
	}
	float g0( float a ) {
		return w0( a ) + w1( a );
	}
	float g1( float a ) {
		return w2( a ) + w3( a );
	}
	float h0( float a ) {
		return - 1.0 + w1( a ) / ( w0( a ) + w1( a ) );
	}
	float h1( float a ) {
		return 1.0 + w3( a ) / ( w2( a ) + w3( a ) );
	}
	vec4 bicubic( sampler2D tex, vec2 uv, vec4 texelSize, vec2 fullSize, float lod ) {
		uv = uv * texelSize.zw + 0.5;
		vec2 iuv = floor( uv );
		vec2 fuv = fract( uv );
		float g0x = g0( fuv.x );
		float g1x = g1( fuv.x );
		float h0x = h0( fuv.x );
		float h1x = h1( fuv.x );
		float h0y = h0( fuv.y );
		float h1y = h1( fuv.y );
		vec2 p0 = ( vec2( iuv.x + h0x, iuv.y + h0y ) - 0.5 ) * texelSize.xy;
		vec2 p1 = ( vec2( iuv.x + h1x, iuv.y + h0y ) - 0.5 ) * texelSize.xy;
		vec2 p2 = ( vec2( iuv.x + h0x, iuv.y + h1y ) - 0.5 ) * texelSize.xy;
		vec2 p3 = ( vec2( iuv.x + h1x, iuv.y + h1y ) - 0.5 ) * texelSize.xy;
		
		vec2 lodFudge = pow( 1.95, lod ) / fullSize;
		return g0( fuv.y ) * ( g0x * textureLod( tex, p0, lod ) + g1x * textureLod( tex, p1, lod ) ) +
			g1( fuv.y ) * ( g0x * textureLod( tex, p2, lod ) + g1x * textureLod( tex, p3, lod ) );
	}
	vec4 textureBicubic( sampler2D sampler, vec2 uv, float lod ) {
		vec2 fLodSize = vec2( textureSize( sampler, int( lod ) ) );
		vec2 cLodSize = vec2( textureSize( sampler, int( lod + 1.0 ) ) );
		vec2 fLodSizeInv = 1.0 / fLodSize;
		vec2 cLodSizeInv = 1.0 / cLodSize;
		vec2 fullSize = vec2( textureSize( sampler, 0 ) );
		vec4 fSample = bicubic( sampler, uv, vec4( fLodSizeInv, fLodSize ), fullSize, floor( lod ) );
		vec4 cSample = bicubic( sampler, uv, vec4( cLodSizeInv, cLodSize ), fullSize, ceil( lod ) );
		return mix( fSample, cSample, fract( lod ) );
	}
	vec3 getVolumeTransmissionRay( const in vec3 n, const in vec3 v, const in float thickness, const in float ior, const in mat4 modelMatrix ) {
		vec3 refractionVector = refract( - v, normalize( n ), 1.0 / ior );
		vec3 modelScale;
		modelScale.x = length( vec3( modelMatrix[ 0 ].xyz ) );
		modelScale.y = length( vec3( modelMatrix[ 1 ].xyz ) );
		modelScale.z = length( vec3( modelMatrix[ 2 ].xyz ) );
		return normalize( refractionVector ) * thickness * modelScale;
	}
	float applyIorToRoughness( const in float roughness, const in float ior ) {
		return roughness * clamp( ior * 2.0 - 2.0, 0.0, 1.0 );
	}
	vec4 getTransmissionSample( const in vec2 fragCoord, const in float roughness, const in float ior ) {
		float lod = log2( transmissionSamplerSize.x ) * applyIorToRoughness( roughness, ior );
		return textureBicubic( transmissionSamplerMap, fragCoord.xy, lod );
	}
	vec3 applyVolumeAttenuation( const in vec3 radiance, const in float transmissionDistance, const in vec3 attenuationColor, const in float attenuationDistance ) {
		if ( isinf( attenuationDistance ) ) {
			return radiance;
		} else {
			vec3 attenuationCoefficient = -log( attenuationColor ) / attenuationDistance;
			vec3 transmittance = exp( - attenuationCoefficient * transmissionDistance );			return transmittance * radiance;
		}
	}
	vec4 getIBLVolumeRefraction( const in vec3 n, const in vec3 v, const in float roughness, const in vec3 diffuseColor,
		const in vec3 specularColor, const in float specularF90, const in vec3 position, const in mat4 modelMatrix,
		const in mat4 viewMatrix, const in mat4 projMatrix, const in float ior, const in float thickness,
		const in vec3 attenuationColor, const in float attenuationDistance ) {
		vec3 transmissionRay = getVolumeTransmissionRay( n, v, thickness, ior, modelMatrix );
		vec3 refractedRayExit = position + transmissionRay;
		vec4 ndcPos = projMatrix * viewMatrix * vec4( refractedRayExit, 1.0 );
		vec2 refractionCoords = ndcPos.xy / ndcPos.w;
		refractionCoords += 1.0;
		refractionCoords /= 2.0;
		vec4 transmittedLight = getTransmissionSample( refractionCoords, roughness, ior );
		vec3 attenuatedColor = applyVolumeAttenuation( transmittedLight.rgb, length( transmissionRay ), attenuationColor, attenuationDistance );
		vec3 F = EnvironmentBRDF( n, v, specularColor, specularF90, roughness );
		return vec4( ( 1.0 - F ) * attenuatedColor * diffuseColor, transmittedLight.a );
	}
#endif`,C0=`#if ( defined( USE_UV ) && ! defined( UVS_VERTEX_ONLY ) )
	varying vec2 vUv;
#endif`,T0=`#ifdef USE_UV
	#ifdef UVS_VERTEX_ONLY
		vec2 vUv;
	#else
		varying vec2 vUv;
	#endif
	uniform mat3 uvTransform;
#endif`,E0=`#ifdef USE_UV
	vUv = ( uvTransform * vec3( uv, 1 ) ).xy;
#endif`,L0=`#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )
	varying vec2 vUv2;
#endif`,P0=`#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )
	attribute vec2 uv2;
	varying vec2 vUv2;
	uniform mat3 uv2Transform;
#endif`,A0=`#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )
	vUv2 = ( uv2Transform * vec3( uv2, 1 ) ).xy;
#endif`,D0=`#if defined( USE_ENVMAP ) || defined( DISTANCE ) || defined ( USE_SHADOWMAP ) || defined ( USE_TRANSMISSION ) || NUM_SPOT_LIGHT_COORDS > 0
	vec4 worldPosition = vec4( transformed, 1.0 );
	#ifdef USE_INSTANCING
		worldPosition = instanceMatrix * worldPosition;
	#endif
	worldPosition = modelMatrix * worldPosition;
#endif`;const R0=`varying vec2 vUv;
uniform mat3 uvTransform;
void main() {
	vUv = ( uvTransform * vec3( uv, 1 ) ).xy;
	gl_Position = vec4( position.xy, 1.0, 1.0 );
}`,k0=`uniform sampler2D t2D;
uniform float backgroundIntensity;
varying vec2 vUv;
void main() {
	vec4 texColor = texture2D( t2D, vUv );
	#ifdef DECODE_VIDEO_TEXTURE
		texColor = vec4( mix( pow( texColor.rgb * 0.9478672986 + vec3( 0.0521327014 ), vec3( 2.4 ) ), texColor.rgb * 0.0773993808, vec3( lessThanEqual( texColor.rgb, vec3( 0.04045 ) ) ) ), texColor.w );
	#endif
	texColor.rgb *= backgroundIntensity;
	gl_FragColor = texColor;
	#include <tonemapping_fragment>
	#include <encodings_fragment>
}`,I0=`varying vec3 vWorldDirection;
#include <common>
void main() {
	vWorldDirection = transformDirection( position, modelMatrix );
	#include <begin_vertex>
	#include <project_vertex>
	gl_Position.z = gl_Position.w;
}`,N0=`#ifdef ENVMAP_TYPE_CUBE
	uniform samplerCube envMap;
#elif defined( ENVMAP_TYPE_CUBE_UV )
	uniform sampler2D envMap;
#endif
uniform float flipEnvMap;
uniform float backgroundBlurriness;
uniform float backgroundIntensity;
varying vec3 vWorldDirection;
#include <cube_uv_reflection_fragment>
void main() {
	#ifdef ENVMAP_TYPE_CUBE
		vec4 texColor = textureCube( envMap, vec3( flipEnvMap * vWorldDirection.x, vWorldDirection.yz ) );
	#elif defined( ENVMAP_TYPE_CUBE_UV )
		vec4 texColor = textureCubeUV( envMap, vWorldDirection, backgroundBlurriness );
	#else
		vec4 texColor = vec4( 0.0, 0.0, 0.0, 1.0 );
	#endif
	texColor.rgb *= backgroundIntensity;
	gl_FragColor = texColor;
	#include <tonemapping_fragment>
	#include <encodings_fragment>
}`,z0=`varying vec3 vWorldDirection;
#include <common>
void main() {
	vWorldDirection = transformDirection( position, modelMatrix );
	#include <begin_vertex>
	#include <project_vertex>
	gl_Position.z = gl_Position.w;
}`,F0=`uniform samplerCube tCube;
uniform float tFlip;
uniform float opacity;
varying vec3 vWorldDirection;
void main() {
	vec4 texColor = textureCube( tCube, vec3( tFlip * vWorldDirection.x, vWorldDirection.yz ) );
	gl_FragColor = texColor;
	gl_FragColor.a *= opacity;
	#include <tonemapping_fragment>
	#include <encodings_fragment>
}`,O0=`#include <common>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
varying vec2 vHighPrecisionZW;
void main() {
	#include <uv_vertex>
	#include <skinbase_vertex>
	#ifdef USE_DISPLACEMENTMAP
		#include <beginnormal_vertex>
		#include <morphnormal_vertex>
		#include <skinnormal_vertex>
	#endif
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	vHighPrecisionZW = gl_Position.zw;
}`,U0=`#if DEPTH_PACKING == 3200
	uniform float opacity;
#endif
#include <common>
#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
varying vec2 vHighPrecisionZW;
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( 1.0 );
	#if DEPTH_PACKING == 3200
		diffuseColor.a = opacity;
	#endif
	#include <map_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <logdepthbuf_fragment>
	float fragCoordZ = 0.5 * vHighPrecisionZW[0] / vHighPrecisionZW[1] + 0.5;
	#if DEPTH_PACKING == 3200
		gl_FragColor = vec4( vec3( 1.0 - fragCoordZ ), opacity );
	#elif DEPTH_PACKING == 3201
		gl_FragColor = packDepthToRGBA( fragCoordZ );
	#endif
}`,B0=`#define DISTANCE
varying vec3 vWorldPosition;
#include <common>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <skinbase_vertex>
	#ifdef USE_DISPLACEMENTMAP
		#include <beginnormal_vertex>
		#include <morphnormal_vertex>
		#include <skinnormal_vertex>
	#endif
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <worldpos_vertex>
	#include <clipping_planes_vertex>
	vWorldPosition = worldPosition.xyz;
}`,V0=`#define DISTANCE
uniform vec3 referencePosition;
uniform float nearDistance;
uniform float farDistance;
varying vec3 vWorldPosition;
#include <common>
#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <clipping_planes_pars_fragment>
void main () {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( 1.0 );
	#include <map_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	float dist = length( vWorldPosition - referencePosition );
	dist = ( dist - nearDistance ) / ( farDistance - nearDistance );
	dist = saturate( dist );
	gl_FragColor = packDepthToRGBA( dist );
}`,G0=`varying vec3 vWorldDirection;
#include <common>
void main() {
	vWorldDirection = transformDirection( position, modelMatrix );
	#include <begin_vertex>
	#include <project_vertex>
}`,H0=`uniform sampler2D tEquirect;
varying vec3 vWorldDirection;
#include <common>
void main() {
	vec3 direction = normalize( vWorldDirection );
	vec2 sampleUV = equirectUv( direction );
	gl_FragColor = texture2D( tEquirect, sampleUV );
	#include <tonemapping_fragment>
	#include <encodings_fragment>
}`,W0=`uniform float scale;
attribute float lineDistance;
varying float vLineDistance;
#include <common>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	vLineDistance = scale * lineDistance;
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>
}`,X0=`uniform vec3 diffuse;
uniform float opacity;
uniform float dashSize;
uniform float totalSize;
varying float vLineDistance;
#include <common>
#include <color_pars_fragment>
#include <fog_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	if ( mod( vLineDistance, totalSize ) > dashSize ) {
		discard;
	}
	vec3 outgoingLight = vec3( 0.0 );
	vec4 diffuseColor = vec4( diffuse, opacity );
	#include <logdepthbuf_fragment>
	#include <color_fragment>
	outgoingLight = diffuseColor.rgb;
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
}`,j0=`#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <envmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>
	#include <morphcolor_vertex>
	#if defined ( USE_ENVMAP ) || defined ( USE_SKINNING )
		#include <beginnormal_vertex>
		#include <morphnormal_vertex>
		#include <skinbase_vertex>
		#include <skinnormal_vertex>
		#include <defaultnormal_vertex>
	#endif
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <worldpos_vertex>
	#include <envmap_vertex>
	#include <fog_vertex>
}`,q0=`uniform vec3 diffuse;
uniform float opacity;
#ifndef FLAT_SHADED
	varying vec3 vNormal;
#endif
#include <common>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <envmap_common_pars_fragment>
#include <envmap_pars_fragment>
#include <fog_pars_fragment>
#include <specularmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <specularmap_fragment>
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	#ifdef USE_LIGHTMAP
		vec4 lightMapTexel = texture2D( lightMap, vUv2 );
		reflectedLight.indirectDiffuse += lightMapTexel.rgb * lightMapIntensity * RECIPROCAL_PI;
	#else
		reflectedLight.indirectDiffuse += vec3( 1.0 );
	#endif
	#include <aomap_fragment>
	reflectedLight.indirectDiffuse *= diffuseColor.rgb;
	vec3 outgoingLight = reflectedLight.indirectDiffuse;
	#include <envmap_fragment>
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}`,Y0=`#define LAMBERT
varying vec3 vViewPosition;
#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <displacementmap_pars_vertex>
#include <envmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	vViewPosition = - mvPosition.xyz;
	#include <worldpos_vertex>
	#include <envmap_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>
}`,Z0=`#define LAMBERT
uniform vec3 diffuse;
uniform vec3 emissive;
uniform float opacity;
#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <envmap_common_pars_fragment>
#include <envmap_pars_fragment>
#include <fog_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <normal_pars_fragment>
#include <lights_lambert_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <specularmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <specularmap_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <emissivemap_fragment>
	#include <lights_lambert_fragment>
	#include <lights_fragment_begin>
	#include <lights_fragment_maps>
	#include <lights_fragment_end>
	#include <aomap_fragment>
	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + totalEmissiveRadiance;
	#include <envmap_fragment>
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}`,K0=`#define MATCAP
varying vec3 vViewPosition;
#include <common>
#include <uv_pars_vertex>
#include <color_pars_vertex>
#include <displacementmap_pars_vertex>
#include <fog_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>
	vViewPosition = - mvPosition.xyz;
}`,J0=`#define MATCAP
uniform vec3 diffuse;
uniform float opacity;
uniform sampler2D matcap;
varying vec3 vViewPosition;
#include <common>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <fog_pars_fragment>
#include <normal_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	vec3 viewDir = normalize( vViewPosition );
	vec3 x = normalize( vec3( viewDir.z, 0.0, - viewDir.x ) );
	vec3 y = cross( viewDir, x );
	vec2 uv = vec2( dot( x, normal ), dot( y, normal ) ) * 0.495 + 0.5;
	#ifdef USE_MATCAP
		vec4 matcapColor = texture2D( matcap, uv );
	#else
		vec4 matcapColor = vec4( vec3( mix( 0.2, 0.8, uv.y ) ), 1.0 );
	#endif
	vec3 outgoingLight = diffuseColor.rgb * matcapColor.rgb;
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}`,Q0=`#define NORMAL
#if defined( FLAT_SHADED ) || defined( USE_BUMPMAP ) || defined( TANGENTSPACE_NORMALMAP )
	varying vec3 vViewPosition;
#endif
#include <common>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
#if defined( FLAT_SHADED ) || defined( USE_BUMPMAP ) || defined( TANGENTSPACE_NORMALMAP )
	vViewPosition = - mvPosition.xyz;
#endif
}`,$0=`#define NORMAL
uniform float opacity;
#if defined( FLAT_SHADED ) || defined( USE_BUMPMAP ) || defined( TANGENTSPACE_NORMALMAP )
	varying vec3 vViewPosition;
#endif
#include <packing>
#include <uv_pars_fragment>
#include <normal_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	#include <logdepthbuf_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	gl_FragColor = vec4( packNormalToRGB( normal ), opacity );
	#ifdef OPAQUE
		gl_FragColor.a = 1.0;
	#endif
}`,e1=`#define PHONG
varying vec3 vViewPosition;
#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <displacementmap_pars_vertex>
#include <envmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	vViewPosition = - mvPosition.xyz;
	#include <worldpos_vertex>
	#include <envmap_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>
}`,t1=`#define PHONG
uniform vec3 diffuse;
uniform vec3 emissive;
uniform vec3 specular;
uniform float shininess;
uniform float opacity;
#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <envmap_common_pars_fragment>
#include <envmap_pars_fragment>
#include <fog_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <normal_pars_fragment>
#include <lights_phong_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <specularmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <specularmap_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <emissivemap_fragment>
	#include <lights_phong_fragment>
	#include <lights_fragment_begin>
	#include <lights_fragment_maps>
	#include <lights_fragment_end>
	#include <aomap_fragment>
	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + reflectedLight.directSpecular + reflectedLight.indirectSpecular + totalEmissiveRadiance;
	#include <envmap_fragment>
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}`,n1=`#define STANDARD
varying vec3 vViewPosition;
#ifdef USE_TRANSMISSION
	varying vec3 vWorldPosition;
#endif
#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <displacementmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	vViewPosition = - mvPosition.xyz;
	#include <worldpos_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>
#ifdef USE_TRANSMISSION
	vWorldPosition = worldPosition.xyz;
#endif
}`,i1=`#define STANDARD
#ifdef PHYSICAL
	#define IOR
	#define SPECULAR
#endif
uniform vec3 diffuse;
uniform vec3 emissive;
uniform float roughness;
uniform float metalness;
uniform float opacity;
#ifdef IOR
	uniform float ior;
#endif
#ifdef SPECULAR
	uniform float specularIntensity;
	uniform vec3 specularColor;
	#ifdef USE_SPECULARINTENSITYMAP
		uniform sampler2D specularIntensityMap;
	#endif
	#ifdef USE_SPECULARCOLORMAP
		uniform sampler2D specularColorMap;
	#endif
#endif
#ifdef USE_CLEARCOAT
	uniform float clearcoat;
	uniform float clearcoatRoughness;
#endif
#ifdef USE_IRIDESCENCE
	uniform float iridescence;
	uniform float iridescenceIOR;
	uniform float iridescenceThicknessMinimum;
	uniform float iridescenceThicknessMaximum;
#endif
#ifdef USE_SHEEN
	uniform vec3 sheenColor;
	uniform float sheenRoughness;
	#ifdef USE_SHEENCOLORMAP
		uniform sampler2D sheenColorMap;
	#endif
	#ifdef USE_SHEENROUGHNESSMAP
		uniform sampler2D sheenRoughnessMap;
	#endif
#endif
varying vec3 vViewPosition;
#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <bsdfs>
#include <iridescence_fragment>
#include <cube_uv_reflection_fragment>
#include <envmap_common_pars_fragment>
#include <envmap_physical_pars_fragment>
#include <fog_pars_fragment>
#include <lights_pars_begin>
#include <normal_pars_fragment>
#include <lights_physical_pars_fragment>
#include <transmission_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <clearcoat_pars_fragment>
#include <iridescence_pars_fragment>
#include <roughnessmap_pars_fragment>
#include <metalnessmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <roughnessmap_fragment>
	#include <metalnessmap_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <clearcoat_normal_fragment_begin>
	#include <clearcoat_normal_fragment_maps>
	#include <emissivemap_fragment>
	#include <lights_physical_fragment>
	#include <lights_fragment_begin>
	#include <lights_fragment_maps>
	#include <lights_fragment_end>
	#include <aomap_fragment>
	vec3 totalDiffuse = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse;
	vec3 totalSpecular = reflectedLight.directSpecular + reflectedLight.indirectSpecular;
	#include <transmission_fragment>
	vec3 outgoingLight = totalDiffuse + totalSpecular + totalEmissiveRadiance;
	#ifdef USE_SHEEN
		float sheenEnergyComp = 1.0 - 0.157 * max3( material.sheenColor );
		outgoingLight = outgoingLight * sheenEnergyComp + sheenSpecular;
	#endif
	#ifdef USE_CLEARCOAT
		float dotNVcc = saturate( dot( geometry.clearcoatNormal, geometry.viewDir ) );
		vec3 Fcc = F_Schlick( material.clearcoatF0, material.clearcoatF90, dotNVcc );
		outgoingLight = outgoingLight * ( 1.0 - material.clearcoat * Fcc ) + clearcoatSpecular * material.clearcoat;
	#endif
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}`,r1=`#define TOON
varying vec3 vViewPosition;
#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <displacementmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	vViewPosition = - mvPosition.xyz;
	#include <worldpos_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>
}`,s1=`#define TOON
uniform vec3 diffuse;
uniform vec3 emissive;
uniform float opacity;
#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <gradientmap_pars_fragment>
#include <fog_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <normal_pars_fragment>
#include <lights_toon_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <emissivemap_fragment>
	#include <lights_toon_fragment>
	#include <lights_fragment_begin>
	#include <lights_fragment_maps>
	#include <lights_fragment_end>
	#include <aomap_fragment>
	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + totalEmissiveRadiance;
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}`,a1=`uniform float size;
uniform float scale;
#include <common>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <color_vertex>
	#include <morphcolor_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <project_vertex>
	gl_PointSize = size;
	#ifdef USE_SIZEATTENUATION
		bool isPerspective = isPerspectiveMatrix( projectionMatrix );
		if ( isPerspective ) gl_PointSize *= ( scale / - mvPosition.z );
	#endif
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <worldpos_vertex>
	#include <fog_vertex>
}`,o1=`uniform vec3 diffuse;
uniform float opacity;
#include <common>
#include <color_pars_fragment>
#include <map_particle_pars_fragment>
#include <alphatest_pars_fragment>
#include <fog_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec3 outgoingLight = vec3( 0.0 );
	vec4 diffuseColor = vec4( diffuse, opacity );
	#include <logdepthbuf_fragment>
	#include <map_particle_fragment>
	#include <color_fragment>
	#include <alphatest_fragment>
	outgoingLight = diffuseColor.rgb;
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
}`,l1=`#include <common>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <shadowmap_pars_vertex>
void main() {
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <worldpos_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>
}`,c1=`uniform vec3 color;
uniform float opacity;
#include <common>
#include <packing>
#include <fog_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <logdepthbuf_pars_fragment>
#include <shadowmap_pars_fragment>
#include <shadowmask_pars_fragment>
void main() {
	#include <logdepthbuf_fragment>
	gl_FragColor = vec4( color, opacity * ( 1.0 - getShadowMask() ) );
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
}`,u1=`uniform float rotation;
uniform vec2 center;
#include <common>
#include <uv_pars_vertex>
#include <fog_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	vec4 mvPosition = modelViewMatrix * vec4( 0.0, 0.0, 0.0, 1.0 );
	vec2 scale;
	scale.x = length( vec3( modelMatrix[ 0 ].x, modelMatrix[ 0 ].y, modelMatrix[ 0 ].z ) );
	scale.y = length( vec3( modelMatrix[ 1 ].x, modelMatrix[ 1 ].y, modelMatrix[ 1 ].z ) );
	#ifndef USE_SIZEATTENUATION
		bool isPerspective = isPerspectiveMatrix( projectionMatrix );
		if ( isPerspective ) scale *= - mvPosition.z;
	#endif
	vec2 alignedPosition = ( position.xy - ( center - vec2( 0.5 ) ) ) * scale;
	vec2 rotatedPosition;
	rotatedPosition.x = cos( rotation ) * alignedPosition.x - sin( rotation ) * alignedPosition.y;
	rotatedPosition.y = sin( rotation ) * alignedPosition.x + cos( rotation ) * alignedPosition.y;
	mvPosition.xy += rotatedPosition;
	gl_Position = projectionMatrix * mvPosition;
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>
}`,f1=`uniform vec3 diffuse;
uniform float opacity;
#include <common>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <fog_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
void main() {
	#include <clipping_planes_fragment>
	vec3 outgoingLight = vec3( 0.0 );
	vec4 diffuseColor = vec4( diffuse, opacity );
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	outgoingLight = diffuseColor.rgb;
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
}`,Je={alphamap_fragment:I_,alphamap_pars_fragment:N_,alphatest_fragment:z_,alphatest_pars_fragment:F_,aomap_fragment:O_,aomap_pars_fragment:U_,begin_vertex:B_,beginnormal_vertex:V_,bsdfs:G_,iridescence_fragment:H_,bumpmap_pars_fragment:W_,clipping_planes_fragment:X_,clipping_planes_pars_fragment:j_,clipping_planes_pars_vertex:q_,clipping_planes_vertex:Y_,color_fragment:Z_,color_pars_fragment:K_,color_pars_vertex:J_,color_vertex:Q_,common:$_,cube_uv_reflection_fragment:eg,defaultnormal_vertex:tg,displacementmap_pars_vertex:ng,displacementmap_vertex:ig,emissivemap_fragment:rg,emissivemap_pars_fragment:sg,encodings_fragment:ag,encodings_pars_fragment:og,envmap_fragment:lg,envmap_common_pars_fragment:cg,envmap_pars_fragment:ug,envmap_pars_vertex:fg,envmap_physical_pars_fragment:Mg,envmap_vertex:dg,fog_vertex:hg,fog_pars_vertex:pg,fog_fragment:mg,fog_pars_fragment:_g,gradientmap_pars_fragment:gg,lightmap_fragment:bg,lightmap_pars_fragment:vg,lights_lambert_fragment:yg,lights_lambert_pars_fragment:wg,lights_pars_begin:xg,lights_toon_fragment:Sg,lights_toon_pars_fragment:Cg,lights_phong_fragment:Tg,lights_phong_pars_fragment:Eg,lights_physical_fragment:Lg,lights_physical_pars_fragment:Pg,lights_fragment_begin:Ag,lights_fragment_maps:Dg,lights_fragment_end:Rg,logdepthbuf_fragment:kg,logdepthbuf_pars_fragment:Ig,logdepthbuf_pars_vertex:Ng,logdepthbuf_vertex:zg,map_fragment:Fg,map_pars_fragment:Og,map_particle_fragment:Ug,map_particle_pars_fragment:Bg,metalnessmap_fragment:Vg,metalnessmap_pars_fragment:Gg,morphcolor_vertex:Hg,morphnormal_vertex:Wg,morphtarget_pars_vertex:Xg,morphtarget_vertex:jg,normal_fragment_begin:qg,normal_fragment_maps:Yg,normal_pars_fragment:Zg,normal_pars_vertex:Kg,normal_vertex:Jg,normalmap_pars_fragment:Qg,clearcoat_normal_fragment_begin:$g,clearcoat_normal_fragment_maps:e0,clearcoat_pars_fragment:t0,iridescence_pars_fragment:n0,output_fragment:i0,packing:r0,premultiplied_alpha_fragment:s0,project_vertex:a0,dithering_fragment:o0,dithering_pars_fragment:l0,roughnessmap_fragment:c0,roughnessmap_pars_fragment:u0,shadowmap_pars_fragment:f0,shadowmap_pars_vertex:d0,shadowmap_vertex:h0,shadowmask_pars_fragment:p0,skinbase_vertex:m0,skinning_pars_vertex:_0,skinning_vertex:g0,skinnormal_vertex:b0,specularmap_fragment:v0,specularmap_pars_fragment:y0,tonemapping_fragment:w0,tonemapping_pars_fragment:x0,transmission_fragment:M0,transmission_pars_fragment:S0,uv_pars_fragment:C0,uv_pars_vertex:T0,uv_vertex:E0,uv2_pars_fragment:L0,uv2_pars_vertex:P0,uv2_vertex:A0,worldpos_vertex:D0,background_vert:R0,background_frag:k0,backgroundCube_vert:I0,backgroundCube_frag:N0,cube_vert:z0,cube_frag:F0,depth_vert:O0,depth_frag:U0,distanceRGBA_vert:B0,distanceRGBA_frag:V0,equirect_vert:G0,equirect_frag:H0,linedashed_vert:W0,linedashed_frag:X0,meshbasic_vert:j0,meshbasic_frag:q0,meshlambert_vert:Y0,meshlambert_frag:Z0,meshmatcap_vert:K0,meshmatcap_frag:J0,meshnormal_vert:Q0,meshnormal_frag:$0,meshphong_vert:e1,meshphong_frag:t1,meshphysical_vert:n1,meshphysical_frag:i1,meshtoon_vert:r1,meshtoon_frag:s1,points_vert:a1,points_frag:o1,shadow_vert:l1,shadow_frag:c1,sprite_vert:u1,sprite_frag:f1},ve={common:{diffuse:{value:new mt(16777215)},opacity:{value:1},map:{value:null},uvTransform:{value:new Yt},uv2Transform:{value:new Yt},alphaMap:{value:null},alphaTest:{value:0}},specularmap:{specularMap:{value:null}},envmap:{envMap:{value:null},flipEnvMap:{value:-1},reflectivity:{value:1},ior:{value:1.5},refractionRatio:{value:.98}},aomap:{aoMap:{value:null},aoMapIntensity:{value:1}},lightmap:{lightMap:{value:null},lightMapIntensity:{value:1}},emissivemap:{emissiveMap:{value:null}},bumpmap:{bumpMap:{value:null},bumpScale:{value:1}},normalmap:{normalMap:{value:null},normalScale:{value:new st(1,1)}},displacementmap:{displacementMap:{value:null},displacementScale:{value:1},displacementBias:{value:0}},roughnessmap:{roughnessMap:{value:null}},metalnessmap:{metalnessMap:{value:null}},gradientmap:{gradientMap:{value:null}},fog:{fogDensity:{value:25e-5},fogNear:{value:1},fogFar:{value:2e3},fogColor:{value:new mt(16777215)}},lights:{ambientLightColor:{value:[]},lightProbe:{value:[]},directionalLights:{value:[],properties:{direction:{},color:{}}},directionalLightShadows:{value:[],properties:{shadowBias:{},shadowNormalBias:{},shadowRadius:{},shadowMapSize:{}}},directionalShadowMap:{value:[]},directionalShadowMatrix:{value:[]},spotLights:{value:[],properties:{color:{},position:{},direction:{},distance:{},coneCos:{},penumbraCos:{},decay:{}}},spotLightShadows:{value:[],properties:{shadowBias:{},shadowNormalBias:{},shadowRadius:{},shadowMapSize:{}}},spotLightMap:{value:[]},spotShadowMap:{value:[]},spotLightMatrix:{value:[]},pointLights:{value:[],properties:{color:{},position:{},decay:{},distance:{}}},pointLightShadows:{value:[],properties:{shadowBias:{},shadowNormalBias:{},shadowRadius:{},shadowMapSize:{},shadowCameraNear:{},shadowCameraFar:{}}},pointShadowMap:{value:[]},pointShadowMatrix:{value:[]},hemisphereLights:{value:[],properties:{direction:{},skyColor:{},groundColor:{}}},rectAreaLights:{value:[],properties:{color:{},position:{},width:{},height:{}}},ltc_1:{value:null},ltc_2:{value:null}},points:{diffuse:{value:new mt(16777215)},opacity:{value:1},size:{value:1},scale:{value:1},map:{value:null},alphaMap:{value:null},alphaTest:{value:0},uvTransform:{value:new Yt}},sprite:{diffuse:{value:new mt(16777215)},opacity:{value:1},center:{value:new st(.5,.5)},rotation:{value:0},map:{value:null},alphaMap:{value:null},alphaTest:{value:0},uvTransform:{value:new Yt}}},Sn={basic:{uniforms:Xt([ve.common,ve.specularmap,ve.envmap,ve.aomap,ve.lightmap,ve.fog]),vertexShader:Je.meshbasic_vert,fragmentShader:Je.meshbasic_frag},lambert:{uniforms:Xt([ve.common,ve.specularmap,ve.envmap,ve.aomap,ve.lightmap,ve.emissivemap,ve.bumpmap,ve.normalmap,ve.displacementmap,ve.fog,ve.lights,{emissive:{value:new mt(0)}}]),vertexShader:Je.meshlambert_vert,fragmentShader:Je.meshlambert_frag},phong:{uniforms:Xt([ve.common,ve.specularmap,ve.envmap,ve.aomap,ve.lightmap,ve.emissivemap,ve.bumpmap,ve.normalmap,ve.displacementmap,ve.fog,ve.lights,{emissive:{value:new mt(0)},specular:{value:new mt(1118481)},shininess:{value:30}}]),vertexShader:Je.meshphong_vert,fragmentShader:Je.meshphong_frag},standard:{uniforms:Xt([ve.common,ve.envmap,ve.aomap,ve.lightmap,ve.emissivemap,ve.bumpmap,ve.normalmap,ve.displacementmap,ve.roughnessmap,ve.metalnessmap,ve.fog,ve.lights,{emissive:{value:new mt(0)},roughness:{value:1},metalness:{value:0},envMapIntensity:{value:1}}]),vertexShader:Je.meshphysical_vert,fragmentShader:Je.meshphysical_frag},toon:{uniforms:Xt([ve.common,ve.aomap,ve.lightmap,ve.emissivemap,ve.bumpmap,ve.normalmap,ve.displacementmap,ve.gradientmap,ve.fog,ve.lights,{emissive:{value:new mt(0)}}]),vertexShader:Je.meshtoon_vert,fragmentShader:Je.meshtoon_frag},matcap:{uniforms:Xt([ve.common,ve.bumpmap,ve.normalmap,ve.displacementmap,ve.fog,{matcap:{value:null}}]),vertexShader:Je.meshmatcap_vert,fragmentShader:Je.meshmatcap_frag},points:{uniforms:Xt([ve.points,ve.fog]),vertexShader:Je.points_vert,fragmentShader:Je.points_frag},dashed:{uniforms:Xt([ve.common,ve.fog,{scale:{value:1},dashSize:{value:1},totalSize:{value:2}}]),vertexShader:Je.linedashed_vert,fragmentShader:Je.linedashed_frag},depth:{uniforms:Xt([ve.common,ve.displacementmap]),vertexShader:Je.depth_vert,fragmentShader:Je.depth_frag},normal:{uniforms:Xt([ve.common,ve.bumpmap,ve.normalmap,ve.displacementmap,{opacity:{value:1}}]),vertexShader:Je.meshnormal_vert,fragmentShader:Je.meshnormal_frag},sprite:{uniforms:Xt([ve.sprite,ve.fog]),vertexShader:Je.sprite_vert,fragmentShader:Je.sprite_frag},background:{uniforms:{uvTransform:{value:new Yt},t2D:{value:null},backgroundIntensity:{value:1}},vertexShader:Je.background_vert,fragmentShader:Je.background_frag},backgroundCube:{uniforms:{envMap:{value:null},flipEnvMap:{value:-1},backgroundBlurriness:{value:0},backgroundIntensity:{value:1}},vertexShader:Je.backgroundCube_vert,fragmentShader:Je.backgroundCube_frag},cube:{uniforms:{tCube:{value:null},tFlip:{value:-1},opacity:{value:1}},vertexShader:Je.cube_vert,fragmentShader:Je.cube_frag},equirect:{uniforms:{tEquirect:{value:null}},vertexShader:Je.equirect_vert,fragmentShader:Je.equirect_frag},distanceRGBA:{uniforms:Xt([ve.common,ve.displacementmap,{referencePosition:{value:new B},nearDistance:{value:1},farDistance:{value:1e3}}]),vertexShader:Je.distanceRGBA_vert,fragmentShader:Je.distanceRGBA_frag},shadow:{uniforms:Xt([ve.lights,ve.fog,{color:{value:new mt(0)},opacity:{value:1}}]),vertexShader:Je.shadow_vert,fragmentShader:Je.shadow_frag}};Sn.physical={uniforms:Xt([Sn.standard.uniforms,{clearcoat:{value:0},clearcoatMap:{value:null},clearcoatRoughness:{value:0},clearcoatRoughnessMap:{value:null},clearcoatNormalScale:{value:new st(1,1)},clearcoatNormalMap:{value:null},iridescence:{value:0},iridescenceMap:{value:null},iridescenceIOR:{value:1.3},iridescenceThicknessMinimum:{value:100},iridescenceThicknessMaximum:{value:400},iridescenceThicknessMap:{value:null},sheen:{value:0},sheenColor:{value:new mt(0)},sheenColorMap:{value:null},sheenRoughness:{value:1},sheenRoughnessMap:{value:null},transmission:{value:0},transmissionMap:{value:null},transmissionSamplerSize:{value:new st},transmissionSamplerMap:{value:null},thickness:{value:0},thicknessMap:{value:null},attenuationDistance:{value:0},attenuationColor:{value:new mt(0)},specularIntensity:{value:1},specularIntensityMap:{value:null},specularColor:{value:new mt(1,1,1)},specularColorMap:{value:null}}]),vertexShader:Je.meshphysical_vert,fragmentShader:Je.meshphysical_frag};const Xr={r:0,b:0,g:0};function d1(i,e,t,n,r,s,a){const o=new mt(0);let l=s===!0?0:1,c,u,f=null,d=0,p=null;function m(_,g){let v=!1,b=g.isScene===!0?g.background:null;b&&b.isTexture&&(b=(g.backgroundBlurriness>0?t:e).get(b));const y=i.xr,w=y.getSession&&y.getSession();w&&w.environmentBlendMode==="additive"&&(b=null),b===null?h(o,l):b&&b.isColor&&(h(b,1),v=!0),(i.autoClear||v)&&i.clear(i.autoClearColor,i.autoClearDepth,i.autoClearStencil),b&&(b.isCubeTexture||b.mapping===ps)?(u===void 0&&(u=new Te(new Ct(1,1,1),new mi({name:"BackgroundCubeMaterial",uniforms:Hi(Sn.backgroundCube.uniforms),vertexShader:Sn.backgroundCube.vertexShader,fragmentShader:Sn.backgroundCube.fragmentShader,side:an,depthTest:!1,depthWrite:!1,fog:!1})),u.geometry.deleteAttribute("normal"),u.geometry.deleteAttribute("uv"),u.onBeforeRender=function(M,E,x){this.matrixWorld.copyPosition(x.matrixWorld)},Object.defineProperty(u.material,"envMap",{get:function(){return this.uniforms.envMap.value}}),r.update(u)),u.material.uniforms.envMap.value=b,u.material.uniforms.flipEnvMap.value=b.isCubeTexture&&b.isRenderTargetTexture===!1?-1:1,u.material.uniforms.backgroundBlurriness.value=g.backgroundBlurriness,u.material.uniforms.backgroundIntensity.value=g.backgroundIntensity,u.material.toneMapped=b.encoding!==pt,(f!==b||d!==b.version||p!==i.toneMapping)&&(u.material.needsUpdate=!0,f=b,d=b.version,p=i.toneMapping),u.layers.enableAll(),_.unshift(u,u.geometry,u.material,0,0,null)):b&&b.isTexture&&(c===void 0&&(c=new Te(new gs(2,2),new mi({name:"BackgroundMaterial",uniforms:Hi(Sn.background.uniforms),vertexShader:Sn.background.vertexShader,fragmentShader:Sn.background.fragmentShader,side:Zn,depthTest:!1,depthWrite:!1,fog:!1})),c.geometry.deleteAttribute("normal"),Object.defineProperty(c.material,"map",{get:function(){return this.uniforms.t2D.value}}),r.update(c)),c.material.uniforms.t2D.value=b,c.material.uniforms.backgroundIntensity.value=g.backgroundIntensity,c.material.toneMapped=b.encoding!==pt,b.matrixAutoUpdate===!0&&b.updateMatrix(),c.material.uniforms.uvTransform.value.copy(b.matrix),(f!==b||d!==b.version||p!==i.toneMapping)&&(c.material.needsUpdate=!0,f=b,d=b.version,p=i.toneMapping),c.layers.enableAll(),_.unshift(c,c.geometry,c.material,0,0,null))}function h(_,g){_.getRGB(Xr,Xc(i)),n.buffers.color.setClear(Xr.r,Xr.g,Xr.b,g,a)}return{getClearColor:function(){return o},setClearColor:function(_,g=1){o.set(_),l=g,h(o,l)},getClearAlpha:function(){return l},setClearAlpha:function(_){l=_,h(o,l)},render:m}}function h1(i,e,t,n){const r=i.getParameter(34921),s=n.isWebGL2?null:e.get("OES_vertex_array_object"),a=n.isWebGL2||s!==null,o={},l=_(null);let c=l,u=!1;function f(z,X,ae,le,$){let ne=!1;if(a){const ue=h(le,ae,X);c!==ue&&(c=ue,p(c.object)),ne=g(z,le,ae,$),ne&&v(z,le,ae,$)}else{const ue=X.wireframe===!0;(c.geometry!==le.id||c.program!==ae.id||c.wireframe!==ue)&&(c.geometry=le.id,c.program=ae.id,c.wireframe=ue,ne=!0)}$!==null&&t.update($,34963),(ne||u)&&(u=!1,x(z,X,ae,le),$!==null&&i.bindBuffer(34963,t.get($).buffer))}function d(){return n.isWebGL2?i.createVertexArray():s.createVertexArrayOES()}function p(z){return n.isWebGL2?i.bindVertexArray(z):s.bindVertexArrayOES(z)}function m(z){return n.isWebGL2?i.deleteVertexArray(z):s.deleteVertexArrayOES(z)}function h(z,X,ae){const le=ae.wireframe===!0;let $=o[z.id];$===void 0&&($={},o[z.id]=$);let ne=$[X.id];ne===void 0&&(ne={},$[X.id]=ne);let ue=ne[le];return ue===void 0&&(ue=_(d()),ne[le]=ue),ue}function _(z){const X=[],ae=[],le=[];for(let $=0;$<r;$++)X[$]=0,ae[$]=0,le[$]=0;return{geometry:null,program:null,wireframe:!1,newAttributes:X,enabledAttributes:ae,attributeDivisors:le,object:z,attributes:{},index:null}}function g(z,X,ae,le){const $=c.attributes,ne=X.attributes;let ue=0;const be=ae.getAttributes();for(const q in be)if(be[q].location>=0){const he=$[q];let W=ne[q];if(W===void 0&&(q==="instanceMatrix"&&z.instanceMatrix&&(W=z.instanceMatrix),q==="instanceColor"&&z.instanceColor&&(W=z.instanceColor)),he===void 0||he.attribute!==W||W&&he.data!==W.data)return!0;ue++}return c.attributesNum!==ue||c.index!==le}function v(z,X,ae,le){const $={},ne=X.attributes;let ue=0;const be=ae.getAttributes();for(const q in be)if(be[q].location>=0){let he=ne[q];he===void 0&&(q==="instanceMatrix"&&z.instanceMatrix&&(he=z.instanceMatrix),q==="instanceColor"&&z.instanceColor&&(he=z.instanceColor));const W={};W.attribute=he,he&&he.data&&(W.data=he.data),$[q]=W,ue++}c.attributes=$,c.attributesNum=ue,c.index=le}function b(){const z=c.newAttributes;for(let X=0,ae=z.length;X<ae;X++)z[X]=0}function y(z){w(z,0)}function w(z,X){const ae=c.newAttributes,le=c.enabledAttributes,$=c.attributeDivisors;ae[z]=1,le[z]===0&&(i.enableVertexAttribArray(z),le[z]=1),$[z]!==X&&((n.isWebGL2?i:e.get("ANGLE_instanced_arrays"))[n.isWebGL2?"vertexAttribDivisor":"vertexAttribDivisorANGLE"](z,X),$[z]=X)}function M(){const z=c.newAttributes,X=c.enabledAttributes;for(let ae=0,le=X.length;ae<le;ae++)X[ae]!==z[ae]&&(i.disableVertexAttribArray(ae),X[ae]=0)}function E(z,X,ae,le,$,ne){n.isWebGL2===!0&&(ae===5124||ae===5125)?i.vertexAttribIPointer(z,X,ae,$,ne):i.vertexAttribPointer(z,X,ae,le,$,ne)}function x(z,X,ae,le){if(n.isWebGL2===!1&&(z.isInstancedMesh||le.isInstancedBufferGeometry)&&e.get("ANGLE_instanced_arrays")===null)return;b();const $=le.attributes,ne=ae.getAttributes(),ue=X.defaultAttributeValues;for(const be in ne){const q=ne[be];if(q.location>=0){let ce=$[be];if(ce===void 0&&(be==="instanceMatrix"&&z.instanceMatrix&&(ce=z.instanceMatrix),be==="instanceColor"&&z.instanceColor&&(ce=z.instanceColor)),ce!==void 0){const he=ce.normalized,W=ce.itemSize,Se=t.get(ce);if(Se===void 0)continue;const we=Se.buffer,Ee=Se.type,Ce=Se.bytesPerElement;if(ce.isInterleavedBufferAttribute){const Fe=ce.data,ze=Fe.stride,oe=ce.offset;if(Fe.isInstancedInterleavedBuffer){for(let ye=0;ye<q.locationSize;ye++)w(q.location+ye,Fe.meshPerAttribute);z.isInstancedMesh!==!0&&le._maxInstanceCount===void 0&&(le._maxInstanceCount=Fe.meshPerAttribute*Fe.count)}else for(let ye=0;ye<q.locationSize;ye++)y(q.location+ye);i.bindBuffer(34962,we);for(let ye=0;ye<q.locationSize;ye++)E(q.location+ye,W/q.locationSize,Ee,he,ze*Ce,(oe+W/q.locationSize*ye)*Ce)}else{if(ce.isInstancedBufferAttribute){for(let Fe=0;Fe<q.locationSize;Fe++)w(q.location+Fe,ce.meshPerAttribute);z.isInstancedMesh!==!0&&le._maxInstanceCount===void 0&&(le._maxInstanceCount=ce.meshPerAttribute*ce.count)}else for(let Fe=0;Fe<q.locationSize;Fe++)y(q.location+Fe);i.bindBuffer(34962,we);for(let Fe=0;Fe<q.locationSize;Fe++)E(q.location+Fe,W/q.locationSize,Ee,he,W*Ce,W/q.locationSize*Fe*Ce)}}else if(ue!==void 0){const he=ue[be];if(he!==void 0)switch(he.length){case 2:i.vertexAttrib2fv(q.location,he);break;case 3:i.vertexAttrib3fv(q.location,he);break;case 4:i.vertexAttrib4fv(q.location,he);break;default:i.vertexAttrib1fv(q.location,he)}}}}M()}function C(){G();for(const z in o){const X=o[z];for(const ae in X){const le=X[ae];for(const $ in le)m(le[$].object),delete le[$];delete X[ae]}delete o[z]}}function A(z){if(o[z.id]===void 0)return;const X=o[z.id];for(const ae in X){const le=X[ae];for(const $ in le)m(le[$].object),delete le[$];delete X[ae]}delete o[z.id]}function D(z){for(const X in o){const ae=o[X];if(ae[z.id]===void 0)continue;const le=ae[z.id];for(const $ in le)m(le[$].object),delete le[$];delete ae[z.id]}}function G(){U(),u=!0,c!==l&&(c=l,p(c.object))}function U(){l.geometry=null,l.program=null,l.wireframe=!1}return{setup:f,reset:G,resetDefaultState:U,dispose:C,releaseStatesOfGeometry:A,releaseStatesOfProgram:D,initAttributes:b,enableAttribute:y,disableUnusedAttributes:M}}function p1(i,e,t,n){const r=n.isWebGL2;let s;function a(c){s=c}function o(c,u){i.drawArrays(s,c,u),t.update(u,s,1)}function l(c,u,f){if(f===0)return;let d,p;if(r)d=i,p="drawArraysInstanced";else if(d=e.get("ANGLE_instanced_arrays"),p="drawArraysInstancedANGLE",d===null){console.error("THREE.WebGLBufferRenderer: using THREE.InstancedBufferGeometry but hardware does not support extension ANGLE_instanced_arrays.");return}d[p](s,c,u,f),t.update(u,s,f)}this.setMode=a,this.render=o,this.renderInstances=l}function m1(i,e,t){let n;function r(){if(n!==void 0)return n;if(e.has("EXT_texture_filter_anisotropic")===!0){const E=e.get("EXT_texture_filter_anisotropic");n=i.getParameter(E.MAX_TEXTURE_MAX_ANISOTROPY_EXT)}else n=0;return n}function s(E){if(E==="highp"){if(i.getShaderPrecisionFormat(35633,36338).precision>0&&i.getShaderPrecisionFormat(35632,36338).precision>0)return"highp";E="mediump"}return E==="mediump"&&i.getShaderPrecisionFormat(35633,36337).precision>0&&i.getShaderPrecisionFormat(35632,36337).precision>0?"mediump":"lowp"}const a=typeof WebGL2RenderingContext<"u"&&i instanceof WebGL2RenderingContext;let o=t.precision!==void 0?t.precision:"highp";const l=s(o);l!==o&&(console.warn("THREE.WebGLRenderer:",o,"not supported, using",l,"instead."),o=l);const c=a||e.has("WEBGL_draw_buffers"),u=t.logarithmicDepthBuffer===!0,f=i.getParameter(34930),d=i.getParameter(35660),p=i.getParameter(3379),m=i.getParameter(34076),h=i.getParameter(34921),_=i.getParameter(36347),g=i.getParameter(36348),v=i.getParameter(36349),b=d>0,y=a||e.has("OES_texture_float"),w=b&&y,M=a?i.getParameter(36183):0;return{isWebGL2:a,drawBuffers:c,getMaxAnisotropy:r,getMaxPrecision:s,precision:o,logarithmicDepthBuffer:u,maxTextures:f,maxVertexTextures:d,maxTextureSize:p,maxCubemapSize:m,maxAttributes:h,maxVertexUniforms:_,maxVaryings:g,maxFragmentUniforms:v,vertexTextures:b,floatFragmentTextures:y,floatVertexTextures:w,maxSamples:M}}function _1(i){const e=this;let t=null,n=0,r=!1,s=!1;const a=new ii,o=new Yt,l={value:null,needsUpdate:!1};this.uniform=l,this.numPlanes=0,this.numIntersection=0,this.init=function(f,d){const p=f.length!==0||d||n!==0||r;return r=d,n=f.length,p},this.beginShadows=function(){s=!0,u(null)},this.endShadows=function(){s=!1},this.setGlobalState=function(f,d){t=u(f,d,0)},this.setState=function(f,d,p){const m=f.clippingPlanes,h=f.clipIntersection,_=f.clipShadows,g=i.get(f);if(!r||m===null||m.length===0||s&&!_)s?u(null):c();else{const v=s?0:n,b=v*4;let y=g.clippingState||null;l.value=y,y=u(m,d,b,p);for(let w=0;w!==b;++w)y[w]=t[w];g.clippingState=y,this.numIntersection=h?this.numPlanes:0,this.numPlanes+=v}};function c(){l.value!==t&&(l.value=t,l.needsUpdate=n>0),e.numPlanes=n,e.numIntersection=0}function u(f,d,p,m){const h=f!==null?f.length:0;let _=null;if(h!==0){if(_=l.value,m!==!0||_===null){const g=p+h*4,v=d.matrixWorldInverse;o.getNormalMatrix(v),(_===null||_.length<g)&&(_=new Float32Array(g));for(let b=0,y=p;b!==h;++b,y+=4)a.copy(f[b]).applyMatrix4(v,o),a.normal.toArray(_,y),_[y+3]=a.constant}l.value=_,l.needsUpdate=!0}return e.numPlanes=h,e.numIntersection=0,_}}function g1(i){let e=new WeakMap;function t(a,o){return o===la?a.mapping=Bi:o===ca&&(a.mapping=Vi),a}function n(a){if(a&&a.isTexture&&a.isRenderTargetTexture===!1){const o=a.mapping;if(o===la||o===ca)if(e.has(a)){const l=e.get(a).texture;return t(l,a.mapping)}else{const l=a.image;if(l&&l.height>0){const c=new A_(l.height/2);return c.fromEquirectangularTexture(i,a),e.set(a,c),a.addEventListener("dispose",r),t(c.texture,a.mapping)}else return null}}return a}function r(a){const o=a.target;o.removeEventListener("dispose",r);const l=e.get(o);l!==void 0&&(e.delete(o),l.dispose())}function s(){e=new WeakMap}return{get:n,dispose:s}}class b1 extends jc{constructor(e=-1,t=1,n=1,r=-1,s=.1,a=2e3){super(),this.isOrthographicCamera=!0,this.type="OrthographicCamera",this.zoom=1,this.view=null,this.left=e,this.right=t,this.top=n,this.bottom=r,this.near=s,this.far=a,this.updateProjectionMatrix()}copy(e,t){return super.copy(e,t),this.left=e.left,this.right=e.right,this.top=e.top,this.bottom=e.bottom,this.near=e.near,this.far=e.far,this.zoom=e.zoom,this.view=e.view===null?null:Object.assign({},e.view),this}setViewOffset(e,t,n,r,s,a){this.view===null&&(this.view={enabled:!0,fullWidth:1,fullHeight:1,offsetX:0,offsetY:0,width:1,height:1}),this.view.enabled=!0,this.view.fullWidth=e,this.view.fullHeight=t,this.view.offsetX=n,this.view.offsetY=r,this.view.width=s,this.view.height=a,this.updateProjectionMatrix()}clearViewOffset(){this.view!==null&&(this.view.enabled=!1),this.updateProjectionMatrix()}updateProjectionMatrix(){const e=(this.right-this.left)/(2*this.zoom),t=(this.top-this.bottom)/(2*this.zoom),n=(this.right+this.left)/2,r=(this.top+this.bottom)/2;let s=n-e,a=n+e,o=r+t,l=r-t;if(this.view!==null&&this.view.enabled){const c=(this.right-this.left)/this.view.fullWidth/this.zoom,u=(this.top-this.bottom)/this.view.fullHeight/this.zoom;s+=c*this.view.offsetX,a=s+c*this.view.width,o-=u*this.view.offsetY,l=o-u*this.view.height}this.projectionMatrix.makeOrthographic(s,a,o,l,this.near,this.far),this.projectionMatrixInverse.copy(this.projectionMatrix).invert()}toJSON(e){const t=super.toJSON(e);return t.object.zoom=this.zoom,t.object.left=this.left,t.object.right=this.right,t.object.top=this.top,t.object.bottom=this.bottom,t.object.near=this.near,t.object.far=this.far,this.view!==null&&(t.object.view=Object.assign({},this.view)),t}}const Di=4,Nl=[.125,.215,.35,.446,.526,.582],ai=20,Js=new b1,zl=new mt;let Qs=null;const ri=(1+Math.sqrt(5))/2,Pi=1/ri,Fl=[new B(1,1,1),new B(-1,1,1),new B(1,1,-1),new B(-1,1,-1),new B(0,ri,Pi),new B(0,ri,-Pi),new B(Pi,0,ri),new B(-Pi,0,ri),new B(ri,Pi,0),new B(-ri,Pi,0)];class Ol{constructor(e){this._renderer=e,this._pingPongRenderTarget=null,this._lodMax=0,this._cubeSize=0,this._lodPlanes=[],this._sizeLods=[],this._sigmas=[],this._blurMaterial=null,this._cubemapMaterial=null,this._equirectMaterial=null,this._compileMaterial(this._blurMaterial)}fromScene(e,t=0,n=.1,r=100){Qs=this._renderer.getRenderTarget(),this._setSize(256);const s=this._allocateTargets();return s.depthBuffer=!0,this._sceneToCubeUV(e,n,r,s),t>0&&this._blur(s,0,0,t),this._applyPMREM(s),this._cleanup(s),s}fromEquirectangular(e,t=null){return this._fromTexture(e,t)}fromCubemap(e,t=null){return this._fromTexture(e,t)}compileCubemapShader(){this._cubemapMaterial===null&&(this._cubemapMaterial=Vl(),this._compileMaterial(this._cubemapMaterial))}compileEquirectangularShader(){this._equirectMaterial===null&&(this._equirectMaterial=Bl(),this._compileMaterial(this._equirectMaterial))}dispose(){this._dispose(),this._cubemapMaterial!==null&&this._cubemapMaterial.dispose(),this._equirectMaterial!==null&&this._equirectMaterial.dispose()}_setSize(e){this._lodMax=Math.floor(Math.log2(e)),this._cubeSize=Math.pow(2,this._lodMax)}_dispose(){this._blurMaterial!==null&&this._blurMaterial.dispose(),this._pingPongRenderTarget!==null&&this._pingPongRenderTarget.dispose();for(let e=0;e<this._lodPlanes.length;e++)this._lodPlanes[e].dispose()}_cleanup(e){this._renderer.setRenderTarget(Qs),e.scissorTest=!1,jr(e,0,0,e.width,e.height)}_fromTexture(e,t){e.mapping===Bi||e.mapping===Vi?this._setSize(e.image.length===0?16:e.image[0].width||e.image[0].image.width):this._setSize(e.image.width/4),Qs=this._renderer.getRenderTarget();const n=t||this._allocateTargets();return this._textureToCubeUV(e,n),this._applyPMREM(n),this._cleanup(n),n}_allocateTargets(){const e=3*Math.max(this._cubeSize,112),t=4*this._cubeSize,n={magFilter:fn,minFilter:fn,generateMipmaps:!1,type:br,format:gn,encoding:hi,depthBuffer:!1},r=Ul(e,t,n);if(this._pingPongRenderTarget===null||this._pingPongRenderTarget.width!==e||this._pingPongRenderTarget.height!==t){this._pingPongRenderTarget!==null&&this._dispose(),this._pingPongRenderTarget=Ul(e,t,n);const{_lodMax:s}=this;({sizeLods:this._sizeLods,lodPlanes:this._lodPlanes,sigmas:this._sigmas}=v1(s)),this._blurMaterial=y1(s,e,t)}return r}_compileMaterial(e){const t=new Te(this._lodPlanes[0],e);this._renderer.compile(t,Js)}_sceneToCubeUV(e,t,n,r){const o=new dn(90,1,t,n),l=[1,-1,1,1,1,1],c=[1,1,1,-1,-1,-1],u=this._renderer,f=u.autoClear,d=u.toneMapping;u.getClearColor(zl),u.toneMapping=Un,u.autoClear=!1;const p=new _s({name:"PMREM.Background",side:an,depthWrite:!1,depthTest:!1}),m=new Te(new Ct,p);let h=!1;const _=e.background;_?_.isColor&&(p.color.copy(_),e.background=null,h=!0):(p.color.copy(zl),h=!0);for(let g=0;g<6;g++){const v=g%3;v===0?(o.up.set(0,l[g],0),o.lookAt(c[g],0,0)):v===1?(o.up.set(0,0,l[g]),o.lookAt(0,c[g],0)):(o.up.set(0,l[g],0),o.lookAt(0,0,c[g]));const b=this._cubeSize;jr(r,v*b,g>2?b:0,b,b),u.setRenderTarget(r),h&&u.render(m,o),u.render(e,o)}m.geometry.dispose(),m.material.dispose(),u.toneMapping=d,u.autoClear=f,e.background=_}_textureToCubeUV(e,t){const n=this._renderer,r=e.mapping===Bi||e.mapping===Vi;r?(this._cubemapMaterial===null&&(this._cubemapMaterial=Vl()),this._cubemapMaterial.uniforms.flipEnvMap.value=e.isRenderTargetTexture===!1?-1:1):this._equirectMaterial===null&&(this._equirectMaterial=Bl());const s=r?this._cubemapMaterial:this._equirectMaterial,a=new Te(this._lodPlanes[0],s),o=s.uniforms;o.envMap.value=e;const l=this._cubeSize;jr(t,0,0,3*l,2*l),n.setRenderTarget(t),n.render(a,Js)}_applyPMREM(e){const t=this._renderer,n=t.autoClear;t.autoClear=!1;for(let r=1;r<this._lodPlanes.length;r++){const s=Math.sqrt(this._sigmas[r]*this._sigmas[r]-this._sigmas[r-1]*this._sigmas[r-1]),a=Fl[(r-1)%Fl.length];this._blur(e,r-1,r,s,a)}t.autoClear=n}_blur(e,t,n,r,s){const a=this._pingPongRenderTarget;this._halfBlur(e,a,t,n,r,"latitudinal",s),this._halfBlur(a,e,n,n,r,"longitudinal",s)}_halfBlur(e,t,n,r,s,a,o){const l=this._renderer,c=this._blurMaterial;a!=="latitudinal"&&a!=="longitudinal"&&console.error("blur direction must be either latitudinal or longitudinal!");const u=3,f=new Te(this._lodPlanes[r],c),d=c.uniforms,p=this._sizeLods[n]-1,m=isFinite(s)?Math.PI/(2*p):2*Math.PI/(2*ai-1),h=s/m,_=isFinite(s)?1+Math.floor(u*h):ai;_>ai&&console.warn(`sigmaRadians, ${s}, is too large and will clip, as it requested ${_} samples when the maximum is set to ${ai}`);const g=[];let v=0;for(let E=0;E<ai;++E){const x=E/h,C=Math.exp(-x*x/2);g.push(C),E===0?v+=C:E<_&&(v+=2*C)}for(let E=0;E<g.length;E++)g[E]=g[E]/v;d.envMap.value=e.texture,d.samples.value=_,d.weights.value=g,d.latitudinal.value=a==="latitudinal",o&&(d.poleAxis.value=o);const{_lodMax:b}=this;d.dTheta.value=m,d.mipInt.value=b-n;const y=this._sizeLods[r],w=3*y*(r>b-Di?r-b+Di:0),M=4*(this._cubeSize-y);jr(t,w,M,3*y,2*y),l.setRenderTarget(t),l.render(f,Js)}}function v1(i){const e=[],t=[],n=[];let r=i;const s=i-Di+1+Nl.length;for(let a=0;a<s;a++){const o=Math.pow(2,r);t.push(o);let l=1/o;a>i-Di?l=Nl[a-i+Di-1]:a===0&&(l=0),n.push(l);const c=1/(o-2),u=-c,f=1+c,d=[u,u,f,u,f,f,u,u,f,f,u,f],p=6,m=6,h=3,_=2,g=1,v=new Float32Array(h*m*p),b=new Float32Array(_*m*p),y=new Float32Array(g*m*p);for(let M=0;M<p;M++){const E=M%3*2/3-1,x=M>2?0:-1,C=[E,x,0,E+2/3,x,0,E+2/3,x+1,0,E,x,0,E+2/3,x+1,0,E,x+1,0];v.set(C,h*m*M),b.set(d,_*m*M);const A=[M,M,M,M,M,M];y.set(A,g*m*M)}const w=new $t;w.setAttribute("position",new Cn(v,h)),w.setAttribute("uv",new Cn(b,_)),w.setAttribute("faceIndex",new Cn(y,g)),e.push(w),r>Di&&r--}return{lodPlanes:e,sizeLods:t,sigmas:n}}function Ul(i,e,t){const n=new pi(i,e,t);return n.texture.mapping=ps,n.texture.name="PMREM.cubeUv",n.scissorTest=!0,n}function jr(i,e,t,n,r){i.viewport.set(e,t,n,r),i.scissor.set(e,t,n,r)}function y1(i,e,t){const n=new Float32Array(ai),r=new B(0,1,0);return new mi({name:"SphericalGaussianBlur",defines:{n:ai,CUBEUV_TEXEL_WIDTH:1/e,CUBEUV_TEXEL_HEIGHT:1/t,CUBEUV_MAX_MIP:`${i}.0`},uniforms:{envMap:{value:null},samples:{value:1},weights:{value:n},latitudinal:{value:!1},dTheta:{value:0},mipInt:{value:0},poleAxis:{value:r}},vertexShader:Sa(),fragmentShader:`

			precision mediump float;
			precision mediump int;

			varying vec3 vOutputDirection;

			uniform sampler2D envMap;
			uniform int samples;
			uniform float weights[ n ];
			uniform bool latitudinal;
			uniform float dTheta;
			uniform float mipInt;
			uniform vec3 poleAxis;

			#define ENVMAP_TYPE_CUBE_UV
			#include <cube_uv_reflection_fragment>

			vec3 getSample( float theta, vec3 axis ) {

				float cosTheta = cos( theta );
				// Rodrigues' axis-angle rotation
				vec3 sampleDirection = vOutputDirection * cosTheta
					+ cross( axis, vOutputDirection ) * sin( theta )
					+ axis * dot( axis, vOutputDirection ) * ( 1.0 - cosTheta );

				return bilinearCubeUV( envMap, sampleDirection, mipInt );

			}

			void main() {

				vec3 axis = latitudinal ? poleAxis : cross( poleAxis, vOutputDirection );

				if ( all( equal( axis, vec3( 0.0 ) ) ) ) {

					axis = vec3( vOutputDirection.z, 0.0, - vOutputDirection.x );

				}

				axis = normalize( axis );

				gl_FragColor = vec4( 0.0, 0.0, 0.0, 1.0 );
				gl_FragColor.rgb += weights[ 0 ] * getSample( 0.0, axis );

				for ( int i = 1; i < n; i++ ) {

					if ( i >= samples ) {

						break;

					}

					float theta = dTheta * float( i );
					gl_FragColor.rgb += weights[ i ] * getSample( -1.0 * theta, axis );
					gl_FragColor.rgb += weights[ i ] * getSample( theta, axis );

				}

			}
		`,blending:Yn,depthTest:!1,depthWrite:!1})}function Bl(){return new mi({name:"EquirectangularToCubeUV",uniforms:{envMap:{value:null}},vertexShader:Sa(),fragmentShader:`

			precision mediump float;
			precision mediump int;

			varying vec3 vOutputDirection;

			uniform sampler2D envMap;

			#include <common>

			void main() {

				vec3 outputDirection = normalize( vOutputDirection );
				vec2 uv = equirectUv( outputDirection );

				gl_FragColor = vec4( texture2D ( envMap, uv ).rgb, 1.0 );

			}
		`,blending:Yn,depthTest:!1,depthWrite:!1})}function Vl(){return new mi({name:"CubemapToCubeUV",uniforms:{envMap:{value:null},flipEnvMap:{value:-1}},vertexShader:Sa(),fragmentShader:`

			precision mediump float;
			precision mediump int;

			uniform float flipEnvMap;

			varying vec3 vOutputDirection;

			uniform samplerCube envMap;

			void main() {

				gl_FragColor = textureCube( envMap, vec3( flipEnvMap * vOutputDirection.x, vOutputDirection.yz ) );

			}
		`,blending:Yn,depthTest:!1,depthWrite:!1})}function Sa(){return`

		precision mediump float;
		precision mediump int;

		attribute float faceIndex;

		varying vec3 vOutputDirection;

		// RH coordinate system; PMREM face-indexing convention
		vec3 getDirection( vec2 uv, float face ) {

			uv = 2.0 * uv - 1.0;

			vec3 direction = vec3( uv, 1.0 );

			if ( face == 0.0 ) {

				direction = direction.zyx; // ( 1, v, u ) pos x

			} else if ( face == 1.0 ) {

				direction = direction.xzy;
				direction.xz *= -1.0; // ( -u, 1, -v ) pos y

			} else if ( face == 2.0 ) {

				direction.x *= -1.0; // ( -u, v, 1 ) pos z

			} else if ( face == 3.0 ) {

				direction = direction.zyx;
				direction.xz *= -1.0; // ( -1, v, -u ) neg x

			} else if ( face == 4.0 ) {

				direction = direction.xzy;
				direction.xy *= -1.0; // ( -u, -1, v ) neg y

			} else if ( face == 5.0 ) {

				direction.z *= -1.0; // ( u, v, -1 ) neg z

			}

			return direction;

		}

		void main() {

			vOutputDirection = getDirection( uv, faceIndex );
			gl_Position = vec4( position, 1.0 );

		}
	`}function w1(i){let e=new WeakMap,t=null;function n(o){if(o&&o.isTexture){const l=o.mapping,c=l===la||l===ca,u=l===Bi||l===Vi;if(c||u)if(o.isRenderTargetTexture&&o.needsPMREMUpdate===!0){o.needsPMREMUpdate=!1;let f=e.get(o);return t===null&&(t=new Ol(i)),f=c?t.fromEquirectangular(o,f):t.fromCubemap(o,f),e.set(o,f),f.texture}else{if(e.has(o))return e.get(o).texture;{const f=o.image;if(c&&f&&f.height>0||u&&f&&r(f)){t===null&&(t=new Ol(i));const d=c?t.fromEquirectangular(o):t.fromCubemap(o);return e.set(o,d),o.addEventListener("dispose",s),d.texture}else return null}}}return o}function r(o){let l=0;const c=6;for(let u=0;u<c;u++)o[u]!==void 0&&l++;return l===c}function s(o){const l=o.target;l.removeEventListener("dispose",s);const c=e.get(l);c!==void 0&&(e.delete(l),c.dispose())}function a(){e=new WeakMap,t!==null&&(t.dispose(),t=null)}return{get:n,dispose:a}}function x1(i){const e={};function t(n){if(e[n]!==void 0)return e[n];let r;switch(n){case"WEBGL_depth_texture":r=i.getExtension("WEBGL_depth_texture")||i.getExtension("MOZ_WEBGL_depth_texture")||i.getExtension("WEBKIT_WEBGL_depth_texture");break;case"EXT_texture_filter_anisotropic":r=i.getExtension("EXT_texture_filter_anisotropic")||i.getExtension("MOZ_EXT_texture_filter_anisotropic")||i.getExtension("WEBKIT_EXT_texture_filter_anisotropic");break;case"WEBGL_compressed_texture_s3tc":r=i.getExtension("WEBGL_compressed_texture_s3tc")||i.getExtension("MOZ_WEBGL_compressed_texture_s3tc")||i.getExtension("WEBKIT_WEBGL_compressed_texture_s3tc");break;case"WEBGL_compressed_texture_pvrtc":r=i.getExtension("WEBGL_compressed_texture_pvrtc")||i.getExtension("WEBKIT_WEBGL_compressed_texture_pvrtc");break;default:r=i.getExtension(n)}return e[n]=r,r}return{has:function(n){return t(n)!==null},init:function(n){n.isWebGL2?t("EXT_color_buffer_float"):(t("WEBGL_depth_texture"),t("OES_texture_float"),t("OES_texture_half_float"),t("OES_texture_half_float_linear"),t("OES_standard_derivatives"),t("OES_element_index_uint"),t("OES_vertex_array_object"),t("ANGLE_instanced_arrays")),t("OES_texture_float_linear"),t("EXT_color_buffer_half_float"),t("WEBGL_multisampled_render_to_texture")},get:function(n){const r=t(n);return r===null&&console.warn("THREE.WebGLRenderer: "+n+" extension not supported."),r}}}function M1(i,e,t,n){const r={},s=new WeakMap;function a(f){const d=f.target;d.index!==null&&e.remove(d.index);for(const m in d.attributes)e.remove(d.attributes[m]);d.removeEventListener("dispose",a),delete r[d.id];const p=s.get(d);p&&(e.remove(p),s.delete(d)),n.releaseStatesOfGeometry(d),d.isInstancedBufferGeometry===!0&&delete d._maxInstanceCount,t.memory.geometries--}function o(f,d){return r[d.id]===!0||(d.addEventListener("dispose",a),r[d.id]=!0,t.memory.geometries++),d}function l(f){const d=f.attributes;for(const m in d)e.update(d[m],34962);const p=f.morphAttributes;for(const m in p){const h=p[m];for(let _=0,g=h.length;_<g;_++)e.update(h[_],34962)}}function c(f){const d=[],p=f.index,m=f.attributes.position;let h=0;if(p!==null){const v=p.array;h=p.version;for(let b=0,y=v.length;b<y;b+=3){const w=v[b+0],M=v[b+1],E=v[b+2];d.push(w,M,M,E,E,w)}}else{const v=m.array;h=m.version;for(let b=0,y=v.length/3-1;b<y;b+=3){const w=b+0,M=b+1,E=b+2;d.push(w,M,M,E,E,w)}}const _=new(Oc(d)?Wc:Hc)(d,1);_.version=h;const g=s.get(f);g&&e.remove(g),s.set(f,_)}function u(f){const d=s.get(f);if(d){const p=f.index;p!==null&&d.version<p.version&&c(f)}else c(f);return s.get(f)}return{get:o,update:l,getWireframeAttribute:u}}function S1(i,e,t,n){const r=n.isWebGL2;let s;function a(d){s=d}let o,l;function c(d){o=d.type,l=d.bytesPerElement}function u(d,p){i.drawElements(s,p,o,d*l),t.update(p,s,1)}function f(d,p,m){if(m===0)return;let h,_;if(r)h=i,_="drawElementsInstanced";else if(h=e.get("ANGLE_instanced_arrays"),_="drawElementsInstancedANGLE",h===null){console.error("THREE.WebGLIndexedBufferRenderer: using THREE.InstancedBufferGeometry but hardware does not support extension ANGLE_instanced_arrays.");return}h[_](s,p,o,d*l,m),t.update(p,s,m)}this.setMode=a,this.setIndex=c,this.render=u,this.renderInstances=f}function C1(i){const e={geometries:0,textures:0},t={frame:0,calls:0,triangles:0,points:0,lines:0};function n(s,a,o){switch(t.calls++,a){case 4:t.triangles+=o*(s/3);break;case 1:t.lines+=o*(s/2);break;case 3:t.lines+=o*(s-1);break;case 2:t.lines+=o*s;break;case 0:t.points+=o*s;break;default:console.error("THREE.WebGLInfo: Unknown draw mode:",a);break}}function r(){t.frame++,t.calls=0,t.triangles=0,t.points=0,t.lines=0}return{memory:e,render:t,programs:null,autoReset:!0,reset:r,update:n}}function T1(i,e){return i[0]-e[0]}function E1(i,e){return Math.abs(e[1])-Math.abs(i[1])}function L1(i,e,t){const n={},r=new Float32Array(8),s=new WeakMap,a=new Nt,o=[];for(let c=0;c<8;c++)o[c]=[c,0];function l(c,u,f){const d=c.morphTargetInfluences;if(e.isWebGL2===!0){const p=u.morphAttributes.position||u.morphAttributes.normal||u.morphAttributes.color,m=p!==void 0?p.length:0;let h=s.get(u);if(h===void 0||h.count!==m){let z=function(){G.dispose(),s.delete(u),u.removeEventListener("dispose",z)};h!==void 0&&h.texture.dispose();const v=u.morphAttributes.position!==void 0,b=u.morphAttributes.normal!==void 0,y=u.morphAttributes.color!==void 0,w=u.morphAttributes.position||[],M=u.morphAttributes.normal||[],E=u.morphAttributes.color||[];let x=0;v===!0&&(x=1),b===!0&&(x=2),y===!0&&(x=3);let C=u.attributes.position.count*x,A=1;C>e.maxTextureSize&&(A=Math.ceil(C/e.maxTextureSize),C=e.maxTextureSize);const D=new Float32Array(C*A*4*m),G=new Vc(D,C,A,m);G.type=ci,G.needsUpdate=!0;const U=x*4;for(let X=0;X<m;X++){const ae=w[X],le=M[X],$=E[X],ne=C*A*4*X;for(let ue=0;ue<ae.count;ue++){const be=ue*U;v===!0&&(a.fromBufferAttribute(ae,ue),D[ne+be+0]=a.x,D[ne+be+1]=a.y,D[ne+be+2]=a.z,D[ne+be+3]=0),b===!0&&(a.fromBufferAttribute(le,ue),D[ne+be+4]=a.x,D[ne+be+5]=a.y,D[ne+be+6]=a.z,D[ne+be+7]=0),y===!0&&(a.fromBufferAttribute($,ue),D[ne+be+8]=a.x,D[ne+be+9]=a.y,D[ne+be+10]=a.z,D[ne+be+11]=$.itemSize===4?a.w:1)}}h={count:m,texture:G,size:new st(C,A)},s.set(u,h),u.addEventListener("dispose",z)}let _=0;for(let v=0;v<d.length;v++)_+=d[v];const g=u.morphTargetsRelative?1:1-_;f.getUniforms().setValue(i,"morphTargetBaseInfluence",g),f.getUniforms().setValue(i,"morphTargetInfluences",d),f.getUniforms().setValue(i,"morphTargetsTexture",h.texture,t),f.getUniforms().setValue(i,"morphTargetsTextureSize",h.size)}else{const p=d===void 0?0:d.length;let m=n[u.id];if(m===void 0||m.length!==p){m=[];for(let b=0;b<p;b++)m[b]=[b,0];n[u.id]=m}for(let b=0;b<p;b++){const y=m[b];y[0]=b,y[1]=d[b]}m.sort(E1);for(let b=0;b<8;b++)b<p&&m[b][1]?(o[b][0]=m[b][0],o[b][1]=m[b][1]):(o[b][0]=Number.MAX_SAFE_INTEGER,o[b][1]=0);o.sort(T1);const h=u.morphAttributes.position,_=u.morphAttributes.normal;let g=0;for(let b=0;b<8;b++){const y=o[b],w=y[0],M=y[1];w!==Number.MAX_SAFE_INTEGER&&M?(h&&u.getAttribute("morphTarget"+b)!==h[w]&&u.setAttribute("morphTarget"+b,h[w]),_&&u.getAttribute("morphNormal"+b)!==_[w]&&u.setAttribute("morphNormal"+b,_[w]),r[b]=M,g+=M):(h&&u.hasAttribute("morphTarget"+b)===!0&&u.deleteAttribute("morphTarget"+b),_&&u.hasAttribute("morphNormal"+b)===!0&&u.deleteAttribute("morphNormal"+b),r[b]=0)}const v=u.morphTargetsRelative?1:1-g;f.getUniforms().setValue(i,"morphTargetBaseInfluence",v),f.getUniforms().setValue(i,"morphTargetInfluences",r)}}return{update:l}}function P1(i,e,t,n){let r=new WeakMap;function s(l){const c=n.render.frame,u=l.geometry,f=e.get(l,u);return r.get(f)!==c&&(e.update(f),r.set(f,c)),l.isInstancedMesh&&(l.hasEventListener("dispose",o)===!1&&l.addEventListener("dispose",o),t.update(l.instanceMatrix,34962),l.instanceColor!==null&&t.update(l.instanceColor,34962)),f}function a(){r=new WeakMap}function o(l){const c=l.target;c.removeEventListener("dispose",o),t.remove(c.instanceMatrix),c.instanceColor!==null&&t.remove(c.instanceColor)}return{update:s,dispose:a}}const Kc=new on,Jc=new Vc,Qc=new p_,$c=new qc,Gl=[],Hl=[],Wl=new Float32Array(16),Xl=new Float32Array(9),jl=new Float32Array(4);function ji(i,e,t){const n=i[0];if(n<=0||n>0)return i;const r=e*t;let s=Gl[r];if(s===void 0&&(s=new Float32Array(r),Gl[r]=s),e!==0){n.toArray(s,0);for(let a=1,o=0;a!==e;++a)o+=t,i[a].toArray(s,o)}return s}function Et(i,e){if(i.length!==e.length)return!1;for(let t=0,n=i.length;t<n;t++)if(i[t]!==e[t])return!1;return!0}function Lt(i,e){for(let t=0,n=e.length;t<n;t++)i[t]=e[t]}function bs(i,e){let t=Hl[e];t===void 0&&(t=new Int32Array(e),Hl[e]=t);for(let n=0;n!==e;++n)t[n]=i.allocateTextureUnit();return t}function A1(i,e){const t=this.cache;t[0]!==e&&(i.uniform1f(this.addr,e),t[0]=e)}function D1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y)&&(i.uniform2f(this.addr,e.x,e.y),t[0]=e.x,t[1]=e.y);else{if(Et(t,e))return;i.uniform2fv(this.addr,e),Lt(t,e)}}function R1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y||t[2]!==e.z)&&(i.uniform3f(this.addr,e.x,e.y,e.z),t[0]=e.x,t[1]=e.y,t[2]=e.z);else if(e.r!==void 0)(t[0]!==e.r||t[1]!==e.g||t[2]!==e.b)&&(i.uniform3f(this.addr,e.r,e.g,e.b),t[0]=e.r,t[1]=e.g,t[2]=e.b);else{if(Et(t,e))return;i.uniform3fv(this.addr,e),Lt(t,e)}}function k1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y||t[2]!==e.z||t[3]!==e.w)&&(i.uniform4f(this.addr,e.x,e.y,e.z,e.w),t[0]=e.x,t[1]=e.y,t[2]=e.z,t[3]=e.w);else{if(Et(t,e))return;i.uniform4fv(this.addr,e),Lt(t,e)}}function I1(i,e){const t=this.cache,n=e.elements;if(n===void 0){if(Et(t,e))return;i.uniformMatrix2fv(this.addr,!1,e),Lt(t,e)}else{if(Et(t,n))return;jl.set(n),i.uniformMatrix2fv(this.addr,!1,jl),Lt(t,n)}}function N1(i,e){const t=this.cache,n=e.elements;if(n===void 0){if(Et(t,e))return;i.uniformMatrix3fv(this.addr,!1,e),Lt(t,e)}else{if(Et(t,n))return;Xl.set(n),i.uniformMatrix3fv(this.addr,!1,Xl),Lt(t,n)}}function z1(i,e){const t=this.cache,n=e.elements;if(n===void 0){if(Et(t,e))return;i.uniformMatrix4fv(this.addr,!1,e),Lt(t,e)}else{if(Et(t,n))return;Wl.set(n),i.uniformMatrix4fv(this.addr,!1,Wl),Lt(t,n)}}function F1(i,e){const t=this.cache;t[0]!==e&&(i.uniform1i(this.addr,e),t[0]=e)}function O1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y)&&(i.uniform2i(this.addr,e.x,e.y),t[0]=e.x,t[1]=e.y);else{if(Et(t,e))return;i.uniform2iv(this.addr,e),Lt(t,e)}}function U1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y||t[2]!==e.z)&&(i.uniform3i(this.addr,e.x,e.y,e.z),t[0]=e.x,t[1]=e.y,t[2]=e.z);else{if(Et(t,e))return;i.uniform3iv(this.addr,e),Lt(t,e)}}function B1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y||t[2]!==e.z||t[3]!==e.w)&&(i.uniform4i(this.addr,e.x,e.y,e.z,e.w),t[0]=e.x,t[1]=e.y,t[2]=e.z,t[3]=e.w);else{if(Et(t,e))return;i.uniform4iv(this.addr,e),Lt(t,e)}}function V1(i,e){const t=this.cache;t[0]!==e&&(i.uniform1ui(this.addr,e),t[0]=e)}function G1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y)&&(i.uniform2ui(this.addr,e.x,e.y),t[0]=e.x,t[1]=e.y);else{if(Et(t,e))return;i.uniform2uiv(this.addr,e),Lt(t,e)}}function H1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y||t[2]!==e.z)&&(i.uniform3ui(this.addr,e.x,e.y,e.z),t[0]=e.x,t[1]=e.y,t[2]=e.z);else{if(Et(t,e))return;i.uniform3uiv(this.addr,e),Lt(t,e)}}function W1(i,e){const t=this.cache;if(e.x!==void 0)(t[0]!==e.x||t[1]!==e.y||t[2]!==e.z||t[3]!==e.w)&&(i.uniform4ui(this.addr,e.x,e.y,e.z,e.w),t[0]=e.x,t[1]=e.y,t[2]=e.z,t[3]=e.w);else{if(Et(t,e))return;i.uniform4uiv(this.addr,e),Lt(t,e)}}function X1(i,e,t){const n=this.cache,r=t.allocateTextureUnit();n[0]!==r&&(i.uniform1i(this.addr,r),n[0]=r),t.setTexture2D(e||Kc,r)}function j1(i,e,t){const n=this.cache,r=t.allocateTextureUnit();n[0]!==r&&(i.uniform1i(this.addr,r),n[0]=r),t.setTexture3D(e||Qc,r)}function q1(i,e,t){const n=this.cache,r=t.allocateTextureUnit();n[0]!==r&&(i.uniform1i(this.addr,r),n[0]=r),t.setTextureCube(e||$c,r)}function Y1(i,e,t){const n=this.cache,r=t.allocateTextureUnit();n[0]!==r&&(i.uniform1i(this.addr,r),n[0]=r),t.setTexture2DArray(e||Jc,r)}function Z1(i){switch(i){case 5126:return A1;case 35664:return D1;case 35665:return R1;case 35666:return k1;case 35674:return I1;case 35675:return N1;case 35676:return z1;case 5124:case 35670:return F1;case 35667:case 35671:return O1;case 35668:case 35672:return U1;case 35669:case 35673:return B1;case 5125:return V1;case 36294:return G1;case 36295:return H1;case 36296:return W1;case 35678:case 36198:case 36298:case 36306:case 35682:return X1;case 35679:case 36299:case 36307:return j1;case 35680:case 36300:case 36308:case 36293:return q1;case 36289:case 36303:case 36311:case 36292:return Y1}}function K1(i,e){i.uniform1fv(this.addr,e)}function J1(i,e){const t=ji(e,this.size,2);i.uniform2fv(this.addr,t)}function Q1(i,e){const t=ji(e,this.size,3);i.uniform3fv(this.addr,t)}function $1(i,e){const t=ji(e,this.size,4);i.uniform4fv(this.addr,t)}function eb(i,e){const t=ji(e,this.size,4);i.uniformMatrix2fv(this.addr,!1,t)}function tb(i,e){const t=ji(e,this.size,9);i.uniformMatrix3fv(this.addr,!1,t)}function nb(i,e){const t=ji(e,this.size,16);i.uniformMatrix4fv(this.addr,!1,t)}function ib(i,e){i.uniform1iv(this.addr,e)}function rb(i,e){i.uniform2iv(this.addr,e)}function sb(i,e){i.uniform3iv(this.addr,e)}function ab(i,e){i.uniform4iv(this.addr,e)}function ob(i,e){i.uniform1uiv(this.addr,e)}function lb(i,e){i.uniform2uiv(this.addr,e)}function cb(i,e){i.uniform3uiv(this.addr,e)}function ub(i,e){i.uniform4uiv(this.addr,e)}function fb(i,e,t){const n=this.cache,r=e.length,s=bs(t,r);Et(n,s)||(i.uniform1iv(this.addr,s),Lt(n,s));for(let a=0;a!==r;++a)t.setTexture2D(e[a]||Kc,s[a])}function db(i,e,t){const n=this.cache,r=e.length,s=bs(t,r);Et(n,s)||(i.uniform1iv(this.addr,s),Lt(n,s));for(let a=0;a!==r;++a)t.setTexture3D(e[a]||Qc,s[a])}function hb(i,e,t){const n=this.cache,r=e.length,s=bs(t,r);Et(n,s)||(i.uniform1iv(this.addr,s),Lt(n,s));for(let a=0;a!==r;++a)t.setTextureCube(e[a]||$c,s[a])}function pb(i,e,t){const n=this.cache,r=e.length,s=bs(t,r);Et(n,s)||(i.uniform1iv(this.addr,s),Lt(n,s));for(let a=0;a!==r;++a)t.setTexture2DArray(e[a]||Jc,s[a])}function mb(i){switch(i){case 5126:return K1;case 35664:return J1;case 35665:return Q1;case 35666:return $1;case 35674:return eb;case 35675:return tb;case 35676:return nb;case 5124:case 35670:return ib;case 35667:case 35671:return rb;case 35668:case 35672:return sb;case 35669:case 35673:return ab;case 5125:return ob;case 36294:return lb;case 36295:return cb;case 36296:return ub;case 35678:case 36198:case 36298:case 36306:case 35682:return fb;case 35679:case 36299:case 36307:return db;case 35680:case 36300:case 36308:case 36293:return hb;case 36289:case 36303:case 36311:case 36292:return pb}}class _b{constructor(e,t,n){this.id=e,this.addr=n,this.cache=[],this.setValue=Z1(t.type)}}class gb{constructor(e,t,n){this.id=e,this.addr=n,this.cache=[],this.size=t.size,this.setValue=mb(t.type)}}class bb{constructor(e){this.id=e,this.seq=[],this.map={}}setValue(e,t,n){const r=this.seq;for(let s=0,a=r.length;s!==a;++s){const o=r[s];o.setValue(e,t[o.id],n)}}}const $s=/(\w+)(\])?(\[|\.)?/g;function ql(i,e){i.seq.push(e),i.map[e.id]=e}function vb(i,e,t){const n=i.name,r=n.length;for($s.lastIndex=0;;){const s=$s.exec(n),a=$s.lastIndex;let o=s[1];const l=s[2]==="]",c=s[3];if(l&&(o=o|0),c===void 0||c==="["&&a+2===r){ql(t,c===void 0?new _b(o,i,e):new gb(o,i,e));break}else{let f=t.map[o];f===void 0&&(f=new bb(o),ql(t,f)),t=f}}}class es{constructor(e,t){this.seq=[],this.map={};const n=e.getProgramParameter(t,35718);for(let r=0;r<n;++r){const s=e.getActiveUniform(t,r),a=e.getUniformLocation(t,s.name);vb(s,a,this)}}setValue(e,t,n,r){const s=this.map[t];s!==void 0&&s.setValue(e,n,r)}setOptional(e,t,n){const r=t[n];r!==void 0&&this.setValue(e,n,r)}static upload(e,t,n,r){for(let s=0,a=t.length;s!==a;++s){const o=t[s],l=n[o.id];l.needsUpdate!==!1&&o.setValue(e,l.value,r)}}static seqWithValue(e,t){const n=[];for(let r=0,s=e.length;r!==s;++r){const a=e[r];a.id in t&&n.push(a)}return n}}function Yl(i,e,t){const n=i.createShader(e);return i.shaderSource(n,t),i.compileShader(n),n}let yb=0;function wb(i,e){const t=i.split(`
`),n=[],r=Math.max(e-6,0),s=Math.min(e+6,t.length);for(let a=r;a<s;a++){const o=a+1;n.push(`${o===e?">":" "} ${o}: ${t[a]}`)}return n.join(`
`)}function xb(i){switch(i){case hi:return["Linear","( value )"];case pt:return["sRGB","( value )"];default:return console.warn("THREE.WebGLProgram: Unsupported encoding:",i),["Linear","( value )"]}}function Zl(i,e,t){const n=i.getShaderParameter(e,35713),r=i.getShaderInfoLog(e).trim();if(n&&r==="")return"";const s=/ERROR: 0:(\d+)/.exec(r);if(s){const a=parseInt(s[1]);return t.toUpperCase()+`

`+r+`

`+wb(i.getShaderSource(e),a)}else return r}function Mb(i,e){const t=xb(e);return"vec4 "+i+"( vec4 value ) { return LinearTo"+t[0]+t[1]+"; }"}function Sb(i,e){let t;switch(e){case wm:t="Linear";break;case xm:t="Reinhard";break;case Mm:t="OptimizedCineon";break;case Sm:t="ACESFilmic";break;case Cm:t="Custom";break;default:console.warn("THREE.WebGLProgram: Unsupported toneMapping:",e),t="Linear"}return"vec3 "+i+"( vec3 color ) { return "+t+"ToneMapping( color ); }"}function Cb(i){return[i.extensionDerivatives||!!i.envMapCubeUVHeight||i.bumpMap||i.tangentSpaceNormalMap||i.clearcoatNormalMap||i.flatShading||i.shaderID==="physical"?"#extension GL_OES_standard_derivatives : enable":"",(i.extensionFragDepth||i.logarithmicDepthBuffer)&&i.rendererExtensionFragDepth?"#extension GL_EXT_frag_depth : enable":"",i.extensionDrawBuffers&&i.rendererExtensionDrawBuffers?"#extension GL_EXT_draw_buffers : require":"",(i.extensionShaderTextureLOD||i.envMap||i.transmission)&&i.rendererExtensionShaderTextureLod?"#extension GL_EXT_shader_texture_lod : enable":""].filter(or).join(`
`)}function Tb(i){const e=[];for(const t in i){const n=i[t];n!==!1&&e.push("#define "+t+" "+n)}return e.join(`
`)}function Eb(i,e){const t={},n=i.getProgramParameter(e,35721);for(let r=0;r<n;r++){const s=i.getActiveAttrib(e,r),a=s.name;let o=1;s.type===35674&&(o=2),s.type===35675&&(o=3),s.type===35676&&(o=4),t[a]={type:s.type,location:i.getAttribLocation(e,a),locationSize:o}}return t}function or(i){return i!==""}function Kl(i,e){const t=e.numSpotLightShadows+e.numSpotLightMaps-e.numSpotLightShadowsWithMaps;return i.replace(/NUM_DIR_LIGHTS/g,e.numDirLights).replace(/NUM_SPOT_LIGHTS/g,e.numSpotLights).replace(/NUM_SPOT_LIGHT_MAPS/g,e.numSpotLightMaps).replace(/NUM_SPOT_LIGHT_COORDS/g,t).replace(/NUM_RECT_AREA_LIGHTS/g,e.numRectAreaLights).replace(/NUM_POINT_LIGHTS/g,e.numPointLights).replace(/NUM_HEMI_LIGHTS/g,e.numHemiLights).replace(/NUM_DIR_LIGHT_SHADOWS/g,e.numDirLightShadows).replace(/NUM_SPOT_LIGHT_SHADOWS_WITH_MAPS/g,e.numSpotLightShadowsWithMaps).replace(/NUM_SPOT_LIGHT_SHADOWS/g,e.numSpotLightShadows).replace(/NUM_POINT_LIGHT_SHADOWS/g,e.numPointLightShadows)}function Jl(i,e){return i.replace(/NUM_CLIPPING_PLANES/g,e.numClippingPlanes).replace(/UNION_CLIPPING_PLANES/g,e.numClippingPlanes-e.numClipIntersection)}const Lb=/^[ \t]*#include +<([\w\d./]+)>/gm;function pa(i){return i.replace(Lb,Pb)}function Pb(i,e){const t=Je[e];if(t===void 0)throw new Error("Can not resolve #include <"+e+">");return pa(t)}const Ab=/#pragma unroll_loop_start\s+for\s*\(\s*int\s+i\s*=\s*(\d+)\s*;\s*i\s*<\s*(\d+)\s*;\s*i\s*\+\+\s*\)\s*{([\s\S]+?)}\s+#pragma unroll_loop_end/g;function Ql(i){return i.replace(Ab,Db)}function Db(i,e,t,n){let r="";for(let s=parseInt(e);s<parseInt(t);s++)r+=n.replace(/\[\s*i\s*\]/g,"[ "+s+" ]").replace(/UNROLLED_LOOP_INDEX/g,s);return r}function $l(i){let e="precision "+i.precision+` float;
precision `+i.precision+" int;";return i.precision==="highp"?e+=`
#define HIGH_PRECISION`:i.precision==="mediump"?e+=`
#define MEDIUM_PRECISION`:i.precision==="lowp"&&(e+=`
#define LOW_PRECISION`),e}function Rb(i){let e="SHADOWMAP_TYPE_BASIC";return i.shadowMapType===Ac?e="SHADOWMAP_TYPE_PCF":i.shadowMapType===$p?e="SHADOWMAP_TYPE_PCF_SOFT":i.shadowMapType===sr&&(e="SHADOWMAP_TYPE_VSM"),e}function kb(i){let e="ENVMAP_TYPE_CUBE";if(i.envMap)switch(i.envMapMode){case Bi:case Vi:e="ENVMAP_TYPE_CUBE";break;case ps:e="ENVMAP_TYPE_CUBE_UV";break}return e}function Ib(i){let e="ENVMAP_MODE_REFLECTION";if(i.envMap)switch(i.envMapMode){case Vi:e="ENVMAP_MODE_REFRACTION";break}return e}function Nb(i){let e="ENVMAP_BLENDING_NONE";if(i.envMap)switch(i.combine){case kc:e="ENVMAP_BLENDING_MULTIPLY";break;case vm:e="ENVMAP_BLENDING_MIX";break;case ym:e="ENVMAP_BLENDING_ADD";break}return e}function zb(i){const e=i.envMapCubeUVHeight;if(e===null)return null;const t=Math.log2(e)-2,n=1/e;return{texelWidth:1/(3*Math.max(Math.pow(2,t),7*16)),texelHeight:n,maxMip:t}}function Fb(i,e,t,n){const r=i.getContext(),s=t.defines;let a=t.vertexShader,o=t.fragmentShader;const l=Rb(t),c=kb(t),u=Ib(t),f=Nb(t),d=zb(t),p=t.isWebGL2?"":Cb(t),m=Tb(s),h=r.createProgram();let _,g,v=t.glslVersion?"#version "+t.glslVersion+`
`:"";t.isRawShaderMaterial?(_=[m].filter(or).join(`
`),_.length>0&&(_+=`
`),g=[p,m].filter(or).join(`
`),g.length>0&&(g+=`
`)):(_=[$l(t),"#define SHADER_NAME "+t.shaderName,m,t.instancing?"#define USE_INSTANCING":"",t.instancingColor?"#define USE_INSTANCING_COLOR":"",t.supportsVertexTextures?"#define VERTEX_TEXTURES":"",t.useFog&&t.fog?"#define USE_FOG":"",t.useFog&&t.fogExp2?"#define FOG_EXP2":"",t.map?"#define USE_MAP":"",t.envMap?"#define USE_ENVMAP":"",t.envMap?"#define "+u:"",t.lightMap?"#define USE_LIGHTMAP":"",t.aoMap?"#define USE_AOMAP":"",t.emissiveMap?"#define USE_EMISSIVEMAP":"",t.bumpMap?"#define USE_BUMPMAP":"",t.normalMap?"#define USE_NORMALMAP":"",t.normalMap&&t.objectSpaceNormalMap?"#define OBJECTSPACE_NORMALMAP":"",t.normalMap&&t.tangentSpaceNormalMap?"#define TANGENTSPACE_NORMALMAP":"",t.clearcoatMap?"#define USE_CLEARCOATMAP":"",t.clearcoatRoughnessMap?"#define USE_CLEARCOAT_ROUGHNESSMAP":"",t.clearcoatNormalMap?"#define USE_CLEARCOAT_NORMALMAP":"",t.iridescenceMap?"#define USE_IRIDESCENCEMAP":"",t.iridescenceThicknessMap?"#define USE_IRIDESCENCE_THICKNESSMAP":"",t.displacementMap&&t.supportsVertexTextures?"#define USE_DISPLACEMENTMAP":"",t.specularMap?"#define USE_SPECULARMAP":"",t.specularIntensityMap?"#define USE_SPECULARINTENSITYMAP":"",t.specularColorMap?"#define USE_SPECULARCOLORMAP":"",t.roughnessMap?"#define USE_ROUGHNESSMAP":"",t.metalnessMap?"#define USE_METALNESSMAP":"",t.alphaMap?"#define USE_ALPHAMAP":"",t.transmission?"#define USE_TRANSMISSION":"",t.transmissionMap?"#define USE_TRANSMISSIONMAP":"",t.thicknessMap?"#define USE_THICKNESSMAP":"",t.sheenColorMap?"#define USE_SHEENCOLORMAP":"",t.sheenRoughnessMap?"#define USE_SHEENROUGHNESSMAP":"",t.vertexTangents?"#define USE_TANGENT":"",t.vertexColors?"#define USE_COLOR":"",t.vertexAlphas?"#define USE_COLOR_ALPHA":"",t.vertexUvs?"#define USE_UV":"",t.uvsVertexOnly?"#define UVS_VERTEX_ONLY":"",t.flatShading?"#define FLAT_SHADED":"",t.skinning?"#define USE_SKINNING":"",t.morphTargets?"#define USE_MORPHTARGETS":"",t.morphNormals&&t.flatShading===!1?"#define USE_MORPHNORMALS":"",t.morphColors&&t.isWebGL2?"#define USE_MORPHCOLORS":"",t.morphTargetsCount>0&&t.isWebGL2?"#define MORPHTARGETS_TEXTURE":"",t.morphTargetsCount>0&&t.isWebGL2?"#define MORPHTARGETS_TEXTURE_STRIDE "+t.morphTextureStride:"",t.morphTargetsCount>0&&t.isWebGL2?"#define MORPHTARGETS_COUNT "+t.morphTargetsCount:"",t.doubleSided?"#define DOUBLE_SIDED":"",t.flipSided?"#define FLIP_SIDED":"",t.shadowMapEnabled?"#define USE_SHADOWMAP":"",t.shadowMapEnabled?"#define "+l:"",t.sizeAttenuation?"#define USE_SIZEATTENUATION":"",t.logarithmicDepthBuffer?"#define USE_LOGDEPTHBUF":"",t.logarithmicDepthBuffer&&t.rendererExtensionFragDepth?"#define USE_LOGDEPTHBUF_EXT":"","uniform mat4 modelMatrix;","uniform mat4 modelViewMatrix;","uniform mat4 projectionMatrix;","uniform mat4 viewMatrix;","uniform mat3 normalMatrix;","uniform vec3 cameraPosition;","uniform bool isOrthographic;","#ifdef USE_INSTANCING","	attribute mat4 instanceMatrix;","#endif","#ifdef USE_INSTANCING_COLOR","	attribute vec3 instanceColor;","#endif","attribute vec3 position;","attribute vec3 normal;","attribute vec2 uv;","#ifdef USE_TANGENT","	attribute vec4 tangent;","#endif","#if defined( USE_COLOR_ALPHA )","	attribute vec4 color;","#elif defined( USE_COLOR )","	attribute vec3 color;","#endif","#if ( defined( USE_MORPHTARGETS ) && ! defined( MORPHTARGETS_TEXTURE ) )","	attribute vec3 morphTarget0;","	attribute vec3 morphTarget1;","	attribute vec3 morphTarget2;","	attribute vec3 morphTarget3;","	#ifdef USE_MORPHNORMALS","		attribute vec3 morphNormal0;","		attribute vec3 morphNormal1;","		attribute vec3 morphNormal2;","		attribute vec3 morphNormal3;","	#else","		attribute vec3 morphTarget4;","		attribute vec3 morphTarget5;","		attribute vec3 morphTarget6;","		attribute vec3 morphTarget7;","	#endif","#endif","#ifdef USE_SKINNING","	attribute vec4 skinIndex;","	attribute vec4 skinWeight;","#endif",`
`].filter(or).join(`
`),g=[p,$l(t),"#define SHADER_NAME "+t.shaderName,m,t.useFog&&t.fog?"#define USE_FOG":"",t.useFog&&t.fogExp2?"#define FOG_EXP2":"",t.map?"#define USE_MAP":"",t.matcap?"#define USE_MATCAP":"",t.envMap?"#define USE_ENVMAP":"",t.envMap?"#define "+c:"",t.envMap?"#define "+u:"",t.envMap?"#define "+f:"",d?"#define CUBEUV_TEXEL_WIDTH "+d.texelWidth:"",d?"#define CUBEUV_TEXEL_HEIGHT "+d.texelHeight:"",d?"#define CUBEUV_MAX_MIP "+d.maxMip+".0":"",t.lightMap?"#define USE_LIGHTMAP":"",t.aoMap?"#define USE_AOMAP":"",t.emissiveMap?"#define USE_EMISSIVEMAP":"",t.bumpMap?"#define USE_BUMPMAP":"",t.normalMap?"#define USE_NORMALMAP":"",t.normalMap&&t.objectSpaceNormalMap?"#define OBJECTSPACE_NORMALMAP":"",t.normalMap&&t.tangentSpaceNormalMap?"#define TANGENTSPACE_NORMALMAP":"",t.clearcoat?"#define USE_CLEARCOAT":"",t.clearcoatMap?"#define USE_CLEARCOATMAP":"",t.clearcoatRoughnessMap?"#define USE_CLEARCOAT_ROUGHNESSMAP":"",t.clearcoatNormalMap?"#define USE_CLEARCOAT_NORMALMAP":"",t.iridescence?"#define USE_IRIDESCENCE":"",t.iridescenceMap?"#define USE_IRIDESCENCEMAP":"",t.iridescenceThicknessMap?"#define USE_IRIDESCENCE_THICKNESSMAP":"",t.specularMap?"#define USE_SPECULARMAP":"",t.specularIntensityMap?"#define USE_SPECULARINTENSITYMAP":"",t.specularColorMap?"#define USE_SPECULARCOLORMAP":"",t.roughnessMap?"#define USE_ROUGHNESSMAP":"",t.metalnessMap?"#define USE_METALNESSMAP":"",t.alphaMap?"#define USE_ALPHAMAP":"",t.alphaTest?"#define USE_ALPHATEST":"",t.sheen?"#define USE_SHEEN":"",t.sheenColorMap?"#define USE_SHEENCOLORMAP":"",t.sheenRoughnessMap?"#define USE_SHEENROUGHNESSMAP":"",t.transmission?"#define USE_TRANSMISSION":"",t.transmissionMap?"#define USE_TRANSMISSIONMAP":"",t.thicknessMap?"#define USE_THICKNESSMAP":"",t.decodeVideoTexture?"#define DECODE_VIDEO_TEXTURE":"",t.vertexTangents?"#define USE_TANGENT":"",t.vertexColors||t.instancingColor?"#define USE_COLOR":"",t.vertexAlphas?"#define USE_COLOR_ALPHA":"",t.vertexUvs?"#define USE_UV":"",t.uvsVertexOnly?"#define UVS_VERTEX_ONLY":"",t.gradientMap?"#define USE_GRADIENTMAP":"",t.flatShading?"#define FLAT_SHADED":"",t.doubleSided?"#define DOUBLE_SIDED":"",t.flipSided?"#define FLIP_SIDED":"",t.shadowMapEnabled?"#define USE_SHADOWMAP":"",t.shadowMapEnabled?"#define "+l:"",t.premultipliedAlpha?"#define PREMULTIPLIED_ALPHA":"",t.useLegacyLights?"#define LEGACY_LIGHTS":"",t.logarithmicDepthBuffer?"#define USE_LOGDEPTHBUF":"",t.logarithmicDepthBuffer&&t.rendererExtensionFragDepth?"#define USE_LOGDEPTHBUF_EXT":"","uniform mat4 viewMatrix;","uniform vec3 cameraPosition;","uniform bool isOrthographic;",t.toneMapping!==Un?"#define TONE_MAPPING":"",t.toneMapping!==Un?Je.tonemapping_pars_fragment:"",t.toneMapping!==Un?Sb("toneMapping",t.toneMapping):"",t.dithering?"#define DITHERING":"",t.opaque?"#define OPAQUE":"",Je.encodings_pars_fragment,Mb("linearToOutputTexel",t.outputEncoding),t.useDepthPacking?"#define DEPTH_PACKING "+t.depthPacking:"",`
`].filter(or).join(`
`)),a=pa(a),a=Kl(a,t),a=Jl(a,t),o=pa(o),o=Kl(o,t),o=Jl(o,t),a=Ql(a),o=Ql(o),t.isWebGL2&&t.isRawShaderMaterial!==!0&&(v=`#version 300 es
`,_=["precision mediump sampler2DArray;","#define attribute in","#define varying out","#define texture2D texture"].join(`
`)+`
`+_,g=["#define varying in",t.glslVersion===xl?"":"layout(location = 0) out highp vec4 pc_fragColor;",t.glslVersion===xl?"":"#define gl_FragColor pc_fragColor","#define gl_FragDepthEXT gl_FragDepth","#define texture2D texture","#define textureCube texture","#define texture2DProj textureProj","#define texture2DLodEXT textureLod","#define texture2DProjLodEXT textureProjLod","#define textureCubeLodEXT textureLod","#define texture2DGradEXT textureGrad","#define texture2DProjGradEXT textureProjGrad","#define textureCubeGradEXT textureGrad"].join(`
`)+`
`+g);const b=v+_+a,y=v+g+o,w=Yl(r,35633,b),M=Yl(r,35632,y);if(r.attachShader(h,w),r.attachShader(h,M),t.index0AttributeName!==void 0?r.bindAttribLocation(h,0,t.index0AttributeName):t.morphTargets===!0&&r.bindAttribLocation(h,0,"position"),r.linkProgram(h),i.debug.checkShaderErrors){const C=r.getProgramInfoLog(h).trim(),A=r.getShaderInfoLog(w).trim(),D=r.getShaderInfoLog(M).trim();let G=!0,U=!0;if(r.getProgramParameter(h,35714)===!1){G=!1;const z=Zl(r,w,"vertex"),X=Zl(r,M,"fragment");console.error("THREE.WebGLProgram: Shader Error "+r.getError()+" - VALIDATE_STATUS "+r.getProgramParameter(h,35715)+`

Program Info Log: `+C+`
`+z+`
`+X)}else C!==""?console.warn("THREE.WebGLProgram: Program Info Log:",C):(A===""||D==="")&&(U=!1);U&&(this.diagnostics={runnable:G,programLog:C,vertexShader:{log:A,prefix:_},fragmentShader:{log:D,prefix:g}})}r.deleteShader(w),r.deleteShader(M);let E;this.getUniforms=function(){return E===void 0&&(E=new es(r,h)),E};let x;return this.getAttributes=function(){return x===void 0&&(x=Eb(r,h)),x},this.destroy=function(){n.releaseStatesOfProgram(this),r.deleteProgram(h),this.program=void 0},this.name=t.shaderName,this.id=yb++,this.cacheKey=e,this.usedTimes=1,this.program=h,this.vertexShader=w,this.fragmentShader=M,this}let Ob=0;class Ub{constructor(){this.shaderCache=new Map,this.materialCache=new Map}update(e){const t=e.vertexShader,n=e.fragmentShader,r=this._getShaderStage(t),s=this._getShaderStage(n),a=this._getShaderCacheForMaterial(e);return a.has(r)===!1&&(a.add(r),r.usedTimes++),a.has(s)===!1&&(a.add(s),s.usedTimes++),this}remove(e){const t=this.materialCache.get(e);for(const n of t)n.usedTimes--,n.usedTimes===0&&this.shaderCache.delete(n.code);return this.materialCache.delete(e),this}getVertexShaderID(e){return this._getShaderStage(e.vertexShader).id}getFragmentShaderID(e){return this._getShaderStage(e.fragmentShader).id}dispose(){this.shaderCache.clear(),this.materialCache.clear()}_getShaderCacheForMaterial(e){const t=this.materialCache;let n=t.get(e);return n===void 0&&(n=new Set,t.set(e,n)),n}_getShaderStage(e){const t=this.shaderCache;let n=t.get(e);return n===void 0&&(n=new Bb(e),t.set(e,n)),n}}class Bb{constructor(e){this.id=Ob++,this.code=e,this.usedTimes=0}}function Vb(i,e,t,n,r,s,a){const o=new Ma,l=new Ub,c=[],u=r.isWebGL2,f=r.logarithmicDepthBuffer,d=r.vertexTextures;let p=r.precision;const m={MeshDepthMaterial:"depth",MeshDistanceMaterial:"distanceRGBA",MeshNormalMaterial:"normal",MeshBasicMaterial:"basic",MeshLambertMaterial:"lambert",MeshPhongMaterial:"phong",MeshToonMaterial:"toon",MeshStandardMaterial:"physical",MeshPhysicalMaterial:"physical",MeshMatcapMaterial:"matcap",LineBasicMaterial:"basic",LineDashedMaterial:"dashed",PointsMaterial:"points",ShadowMaterial:"shadow",SpriteMaterial:"sprite"};function h(x,C,A,D,G){const U=D.fog,z=G.geometry,X=x.isMeshStandardMaterial?D.environment:null,ae=(x.isMeshStandardMaterial?t:e).get(x.envMap||X),le=!!ae&&ae.mapping===ps?ae.image.height:null,$=m[x.type];x.precision!==null&&(p=r.getMaxPrecision(x.precision),p!==x.precision&&console.warn("THREE.WebGLProgram.getParameters:",x.precision,"not supported, using",p,"instead."));const ne=z.morphAttributes.position||z.morphAttributes.normal||z.morphAttributes.color,ue=ne!==void 0?ne.length:0;let be=0;z.morphAttributes.position!==void 0&&(be=1),z.morphAttributes.normal!==void 0&&(be=2),z.morphAttributes.color!==void 0&&(be=3);let q,ce,he,W;if($){const ze=Sn[$];q=ze.vertexShader,ce=ze.fragmentShader}else q=x.vertexShader,ce=x.fragmentShader,l.update(x),he=l.getVertexShaderID(x),W=l.getFragmentShaderID(x);const Se=i.getRenderTarget(),we=x.alphaTest>0,Ee=x.clearcoat>0,Ce=x.iridescence>0;return{isWebGL2:u,shaderID:$,shaderName:x.type,vertexShader:q,fragmentShader:ce,defines:x.defines,customVertexShaderID:he,customFragmentShaderID:W,isRawShaderMaterial:x.isRawShaderMaterial===!0,glslVersion:x.glslVersion,precision:p,instancing:G.isInstancedMesh===!0,instancingColor:G.isInstancedMesh===!0&&G.instanceColor!==null,supportsVertexTextures:d,outputEncoding:Se===null?i.outputEncoding:Se.isXRRenderTarget===!0?Se.texture.encoding:hi,map:!!x.map,matcap:!!x.matcap,envMap:!!ae,envMapMode:ae&&ae.mapping,envMapCubeUVHeight:le,lightMap:!!x.lightMap,aoMap:!!x.aoMap,emissiveMap:!!x.emissiveMap,bumpMap:!!x.bumpMap,normalMap:!!x.normalMap,objectSpaceNormalMap:x.normalMapType===Xm,tangentSpaceNormalMap:x.normalMapType===Wm,decodeVideoTexture:!!x.map&&x.map.isVideoTexture===!0&&x.map.encoding===pt,clearcoat:Ee,clearcoatMap:Ee&&!!x.clearcoatMap,clearcoatRoughnessMap:Ee&&!!x.clearcoatRoughnessMap,clearcoatNormalMap:Ee&&!!x.clearcoatNormalMap,iridescence:Ce,iridescenceMap:Ce&&!!x.iridescenceMap,iridescenceThicknessMap:Ce&&!!x.iridescenceThicknessMap,displacementMap:!!x.displacementMap,roughnessMap:!!x.roughnessMap,metalnessMap:!!x.metalnessMap,specularMap:!!x.specularMap,specularIntensityMap:!!x.specularIntensityMap,specularColorMap:!!x.specularColorMap,opaque:x.transparent===!1&&x.blending===Ni,alphaMap:!!x.alphaMap,alphaTest:we,gradientMap:!!x.gradientMap,sheen:x.sheen>0,sheenColorMap:!!x.sheenColorMap,sheenRoughnessMap:!!x.sheenRoughnessMap,transmission:x.transmission>0,transmissionMap:!!x.transmissionMap,thicknessMap:!!x.thicknessMap,combine:x.combine,vertexTangents:!!x.normalMap&&!!z.attributes.tangent,vertexColors:x.vertexColors,vertexAlphas:x.vertexColors===!0&&!!z.attributes.color&&z.attributes.color.itemSize===4,vertexUvs:!!x.map||!!x.bumpMap||!!x.normalMap||!!x.specularMap||!!x.alphaMap||!!x.emissiveMap||!!x.roughnessMap||!!x.metalnessMap||!!x.clearcoatMap||!!x.clearcoatRoughnessMap||!!x.clearcoatNormalMap||!!x.iridescenceMap||!!x.iridescenceThicknessMap||!!x.displacementMap||!!x.transmissionMap||!!x.thicknessMap||!!x.specularIntensityMap||!!x.specularColorMap||!!x.sheenColorMap||!!x.sheenRoughnessMap,uvsVertexOnly:!(!!x.map||!!x.bumpMap||!!x.normalMap||!!x.specularMap||!!x.alphaMap||!!x.emissiveMap||!!x.roughnessMap||!!x.metalnessMap||!!x.clearcoatNormalMap||!!x.iridescenceMap||!!x.iridescenceThicknessMap||x.transmission>0||!!x.transmissionMap||!!x.thicknessMap||!!x.specularIntensityMap||!!x.specularColorMap||x.sheen>0||!!x.sheenColorMap||!!x.sheenRoughnessMap)&&!!x.displacementMap,fog:!!U,useFog:x.fog===!0,fogExp2:U&&U.isFogExp2,flatShading:!!x.flatShading,sizeAttenuation:x.sizeAttenuation,logarithmicDepthBuffer:f,skinning:G.isSkinnedMesh===!0,morphTargets:z.morphAttributes.position!==void 0,morphNormals:z.morphAttributes.normal!==void 0,morphColors:z.morphAttributes.color!==void 0,morphTargetsCount:ue,morphTextureStride:be,numDirLights:C.directional.length,numPointLights:C.point.length,numSpotLights:C.spot.length,numSpotLightMaps:C.spotLightMap.length,numRectAreaLights:C.rectArea.length,numHemiLights:C.hemi.length,numDirLightShadows:C.directionalShadowMap.length,numPointLightShadows:C.pointShadowMap.length,numSpotLightShadows:C.spotShadowMap.length,numSpotLightShadowsWithMaps:C.numSpotLightShadowsWithMaps,numClippingPlanes:a.numPlanes,numClipIntersection:a.numIntersection,dithering:x.dithering,shadowMapEnabled:i.shadowMap.enabled&&A.length>0,shadowMapType:i.shadowMap.type,toneMapping:x.toneMapped?i.toneMapping:Un,useLegacyLights:i.useLegacyLights,premultipliedAlpha:x.premultipliedAlpha,doubleSided:x.side===zn,flipSided:x.side===an,useDepthPacking:!!x.depthPacking,depthPacking:x.depthPacking||0,index0AttributeName:x.index0AttributeName,extensionDerivatives:x.extensions&&x.extensions.derivatives,extensionFragDepth:x.extensions&&x.extensions.fragDepth,extensionDrawBuffers:x.extensions&&x.extensions.drawBuffers,extensionShaderTextureLOD:x.extensions&&x.extensions.shaderTextureLOD,rendererExtensionFragDepth:u||n.has("EXT_frag_depth"),rendererExtensionDrawBuffers:u||n.has("WEBGL_draw_buffers"),rendererExtensionShaderTextureLod:u||n.has("EXT_shader_texture_lod"),customProgramCacheKey:x.customProgramCacheKey()}}function _(x){const C=[];if(x.shaderID?C.push(x.shaderID):(C.push(x.customVertexShaderID),C.push(x.customFragmentShaderID)),x.defines!==void 0)for(const A in x.defines)C.push(A),C.push(x.defines[A]);return x.isRawShaderMaterial===!1&&(g(C,x),v(C,x),C.push(i.outputEncoding)),C.push(x.customProgramCacheKey),C.join()}function g(x,C){x.push(C.precision),x.push(C.outputEncoding),x.push(C.envMapMode),x.push(C.envMapCubeUVHeight),x.push(C.combine),x.push(C.vertexUvs),x.push(C.fogExp2),x.push(C.sizeAttenuation),x.push(C.morphTargetsCount),x.push(C.morphAttributeCount),x.push(C.numDirLights),x.push(C.numPointLights),x.push(C.numSpotLights),x.push(C.numSpotLightMaps),x.push(C.numHemiLights),x.push(C.numRectAreaLights),x.push(C.numDirLightShadows),x.push(C.numPointLightShadows),x.push(C.numSpotLightShadows),x.push(C.numSpotLightShadowsWithMaps),x.push(C.shadowMapType),x.push(C.toneMapping),x.push(C.numClippingPlanes),x.push(C.numClipIntersection),x.push(C.depthPacking)}function v(x,C){o.disableAll(),C.isWebGL2&&o.enable(0),C.supportsVertexTextures&&o.enable(1),C.instancing&&o.enable(2),C.instancingColor&&o.enable(3),C.map&&o.enable(4),C.matcap&&o.enable(5),C.envMap&&o.enable(6),C.lightMap&&o.enable(7),C.aoMap&&o.enable(8),C.emissiveMap&&o.enable(9),C.bumpMap&&o.enable(10),C.normalMap&&o.enable(11),C.objectSpaceNormalMap&&o.enable(12),C.tangentSpaceNormalMap&&o.enable(13),C.clearcoat&&o.enable(14),C.clearcoatMap&&o.enable(15),C.clearcoatRoughnessMap&&o.enable(16),C.clearcoatNormalMap&&o.enable(17),C.iridescence&&o.enable(18),C.iridescenceMap&&o.enable(19),C.iridescenceThicknessMap&&o.enable(20),C.displacementMap&&o.enable(21),C.specularMap&&o.enable(22),C.roughnessMap&&o.enable(23),C.metalnessMap&&o.enable(24),C.gradientMap&&o.enable(25),C.alphaMap&&o.enable(26),C.alphaTest&&o.enable(27),C.vertexColors&&o.enable(28),C.vertexAlphas&&o.enable(29),C.vertexUvs&&o.enable(30),C.vertexTangents&&o.enable(31),C.uvsVertexOnly&&o.enable(32),x.push(o.mask),o.disableAll(),C.fog&&o.enable(0),C.useFog&&o.enable(1),C.flatShading&&o.enable(2),C.logarithmicDepthBuffer&&o.enable(3),C.skinning&&o.enable(4),C.morphTargets&&o.enable(5),C.morphNormals&&o.enable(6),C.morphColors&&o.enable(7),C.premultipliedAlpha&&o.enable(8),C.shadowMapEnabled&&o.enable(9),C.useLegacyLights&&o.enable(10),C.doubleSided&&o.enable(11),C.flipSided&&o.enable(12),C.useDepthPacking&&o.enable(13),C.dithering&&o.enable(14),C.specularIntensityMap&&o.enable(15),C.specularColorMap&&o.enable(16),C.transmission&&o.enable(17),C.transmissionMap&&o.enable(18),C.thicknessMap&&o.enable(19),C.sheen&&o.enable(20),C.sheenColorMap&&o.enable(21),C.sheenRoughnessMap&&o.enable(22),C.decodeVideoTexture&&o.enable(23),C.opaque&&o.enable(24),x.push(o.mask)}function b(x){const C=m[x.type];let A;if(C){const D=Sn[C];A=T_.clone(D.uniforms)}else A=x.uniforms;return A}function y(x,C){let A;for(let D=0,G=c.length;D<G;D++){const U=c[D];if(U.cacheKey===C){A=U,++A.usedTimes;break}}return A===void 0&&(A=new Fb(i,C,x,s),c.push(A)),A}function w(x){if(--x.usedTimes===0){const C=c.indexOf(x);c[C]=c[c.length-1],c.pop(),x.destroy()}}function M(x){l.remove(x)}function E(){l.dispose()}return{getParameters:h,getProgramCacheKey:_,getUniforms:b,acquireProgram:y,releaseProgram:w,releaseShaderCache:M,programs:c,dispose:E}}function Gb(){let i=new WeakMap;function e(s){let a=i.get(s);return a===void 0&&(a={},i.set(s,a)),a}function t(s){i.delete(s)}function n(s,a,o){i.get(s)[a]=o}function r(){i=new WeakMap}return{get:e,remove:t,update:n,dispose:r}}function Hb(i,e){return i.groupOrder!==e.groupOrder?i.groupOrder-e.groupOrder:i.renderOrder!==e.renderOrder?i.renderOrder-e.renderOrder:i.material.id!==e.material.id?i.material.id-e.material.id:i.z!==e.z?i.z-e.z:i.id-e.id}function ec(i,e){return i.groupOrder!==e.groupOrder?i.groupOrder-e.groupOrder:i.renderOrder!==e.renderOrder?i.renderOrder-e.renderOrder:i.z!==e.z?e.z-i.z:i.id-e.id}function tc(){const i=[];let e=0;const t=[],n=[],r=[];function s(){e=0,t.length=0,n.length=0,r.length=0}function a(f,d,p,m,h,_){let g=i[e];return g===void 0?(g={id:f.id,object:f,geometry:d,material:p,groupOrder:m,renderOrder:f.renderOrder,z:h,group:_},i[e]=g):(g.id=f.id,g.object=f,g.geometry=d,g.material=p,g.groupOrder=m,g.renderOrder=f.renderOrder,g.z=h,g.group=_),e++,g}function o(f,d,p,m,h,_){const g=a(f,d,p,m,h,_);p.transmission>0?n.push(g):p.transparent===!0?r.push(g):t.push(g)}function l(f,d,p,m,h,_){const g=a(f,d,p,m,h,_);p.transmission>0?n.unshift(g):p.transparent===!0?r.unshift(g):t.unshift(g)}function c(f,d){t.length>1&&t.sort(f||Hb),n.length>1&&n.sort(d||ec),r.length>1&&r.sort(d||ec)}function u(){for(let f=e,d=i.length;f<d;f++){const p=i[f];if(p.id===null)break;p.id=null,p.object=null,p.geometry=null,p.material=null,p.group=null}}return{opaque:t,transmissive:n,transparent:r,init:s,push:o,unshift:l,finish:u,sort:c}}function Wb(){let i=new WeakMap;function e(n,r){const s=i.get(n);let a;return s===void 0?(a=new tc,i.set(n,[a])):r>=s.length?(a=new tc,s.push(a)):a=s[r],a}function t(){i=new WeakMap}return{get:e,dispose:t}}function Xb(){const i={};return{get:function(e){if(i[e.id]!==void 0)return i[e.id];let t;switch(e.type){case"DirectionalLight":t={direction:new B,color:new mt};break;case"SpotLight":t={position:new B,direction:new B,color:new mt,distance:0,coneCos:0,penumbraCos:0,decay:0};break;case"PointLight":t={position:new B,color:new mt,distance:0,decay:0};break;case"HemisphereLight":t={direction:new B,skyColor:new mt,groundColor:new mt};break;case"RectAreaLight":t={color:new mt,position:new B,halfWidth:new B,halfHeight:new B};break}return i[e.id]=t,t}}}function jb(){const i={};return{get:function(e){if(i[e.id]!==void 0)return i[e.id];let t;switch(e.type){case"DirectionalLight":t={shadowBias:0,shadowNormalBias:0,shadowRadius:1,shadowMapSize:new st};break;case"SpotLight":t={shadowBias:0,shadowNormalBias:0,shadowRadius:1,shadowMapSize:new st};break;case"PointLight":t={shadowBias:0,shadowNormalBias:0,shadowRadius:1,shadowMapSize:new st,shadowCameraNear:1,shadowCameraFar:1e3};break}return i[e.id]=t,t}}}let qb=0;function Yb(i,e){return(e.castShadow?2:0)-(i.castShadow?2:0)+(e.map?1:0)-(i.map?1:0)}function Zb(i,e){const t=new Xb,n=jb(),r={version:0,hash:{directionalLength:-1,pointLength:-1,spotLength:-1,rectAreaLength:-1,hemiLength:-1,numDirectionalShadows:-1,numPointShadows:-1,numSpotShadows:-1,numSpotMaps:-1},ambient:[0,0,0],probe:[],directional:[],directionalShadow:[],directionalShadowMap:[],directionalShadowMatrix:[],spot:[],spotLightMap:[],spotShadow:[],spotShadowMap:[],spotLightMatrix:[],rectArea:[],rectAreaLTC1:null,rectAreaLTC2:null,point:[],pointShadow:[],pointShadowMap:[],pointShadowMatrix:[],hemi:[],numSpotLightShadowsWithMaps:0};for(let u=0;u<9;u++)r.probe.push(new B);const s=new B,a=new Tt,o=new Tt;function l(u,f){let d=0,p=0,m=0;for(let D=0;D<9;D++)r.probe[D].set(0,0,0);let h=0,_=0,g=0,v=0,b=0,y=0,w=0,M=0,E=0,x=0;u.sort(Yb);const C=f===!0?Math.PI:1;for(let D=0,G=u.length;D<G;D++){const U=u[D],z=U.color,X=U.intensity,ae=U.distance,le=U.shadow&&U.shadow.map?U.shadow.map.texture:null;if(U.isAmbientLight)d+=z.r*X*C,p+=z.g*X*C,m+=z.b*X*C;else if(U.isLightProbe)for(let $=0;$<9;$++)r.probe[$].addScaledVector(U.sh.coefficients[$],X);else if(U.isDirectionalLight){const $=t.get(U);if($.color.copy(U.color).multiplyScalar(U.intensity*C),U.castShadow){const ne=U.shadow,ue=n.get(U);ue.shadowBias=ne.bias,ue.shadowNormalBias=ne.normalBias,ue.shadowRadius=ne.radius,ue.shadowMapSize=ne.mapSize,r.directionalShadow[h]=ue,r.directionalShadowMap[h]=le,r.directionalShadowMatrix[h]=U.shadow.matrix,y++}r.directional[h]=$,h++}else if(U.isSpotLight){const $=t.get(U);$.position.setFromMatrixPosition(U.matrixWorld),$.color.copy(z).multiplyScalar(X*C),$.distance=ae,$.coneCos=Math.cos(U.angle),$.penumbraCos=Math.cos(U.angle*(1-U.penumbra)),$.decay=U.decay,r.spot[g]=$;const ne=U.shadow;if(U.map&&(r.spotLightMap[E]=U.map,E++,ne.updateMatrices(U),U.castShadow&&x++),r.spotLightMatrix[g]=ne.matrix,U.castShadow){const ue=n.get(U);ue.shadowBias=ne.bias,ue.shadowNormalBias=ne.normalBias,ue.shadowRadius=ne.radius,ue.shadowMapSize=ne.mapSize,r.spotShadow[g]=ue,r.spotShadowMap[g]=le,M++}g++}else if(U.isRectAreaLight){const $=t.get(U);$.color.copy(z).multiplyScalar(X),$.halfWidth.set(U.width*.5,0,0),$.halfHeight.set(0,U.height*.5,0),r.rectArea[v]=$,v++}else if(U.isPointLight){const $=t.get(U);if($.color.copy(U.color).multiplyScalar(U.intensity*C),$.distance=U.distance,$.decay=U.decay,U.castShadow){const ne=U.shadow,ue=n.get(U);ue.shadowBias=ne.bias,ue.shadowNormalBias=ne.normalBias,ue.shadowRadius=ne.radius,ue.shadowMapSize=ne.mapSize,ue.shadowCameraNear=ne.camera.near,ue.shadowCameraFar=ne.camera.far,r.pointShadow[_]=ue,r.pointShadowMap[_]=le,r.pointShadowMatrix[_]=U.shadow.matrix,w++}r.point[_]=$,_++}else if(U.isHemisphereLight){const $=t.get(U);$.skyColor.copy(U.color).multiplyScalar(X*C),$.groundColor.copy(U.groundColor).multiplyScalar(X*C),r.hemi[b]=$,b++}}v>0&&(e.isWebGL2||i.has("OES_texture_float_linear")===!0?(r.rectAreaLTC1=ve.LTC_FLOAT_1,r.rectAreaLTC2=ve.LTC_FLOAT_2):i.has("OES_texture_half_float_linear")===!0?(r.rectAreaLTC1=ve.LTC_HALF_1,r.rectAreaLTC2=ve.LTC_HALF_2):console.error("THREE.WebGLRenderer: Unable to use RectAreaLight. Missing WebGL extensions.")),r.ambient[0]=d,r.ambient[1]=p,r.ambient[2]=m;const A=r.hash;(A.directionalLength!==h||A.pointLength!==_||A.spotLength!==g||A.rectAreaLength!==v||A.hemiLength!==b||A.numDirectionalShadows!==y||A.numPointShadows!==w||A.numSpotShadows!==M||A.numSpotMaps!==E)&&(r.directional.length=h,r.spot.length=g,r.rectArea.length=v,r.point.length=_,r.hemi.length=b,r.directionalShadow.length=y,r.directionalShadowMap.length=y,r.pointShadow.length=w,r.pointShadowMap.length=w,r.spotShadow.length=M,r.spotShadowMap.length=M,r.directionalShadowMatrix.length=y,r.pointShadowMatrix.length=w,r.spotLightMatrix.length=M+E-x,r.spotLightMap.length=E,r.numSpotLightShadowsWithMaps=x,A.directionalLength=h,A.pointLength=_,A.spotLength=g,A.rectAreaLength=v,A.hemiLength=b,A.numDirectionalShadows=y,A.numPointShadows=w,A.numSpotShadows=M,A.numSpotMaps=E,r.version=qb++)}function c(u,f){let d=0,p=0,m=0,h=0,_=0;const g=f.matrixWorldInverse;for(let v=0,b=u.length;v<b;v++){const y=u[v];if(y.isDirectionalLight){const w=r.directional[d];w.direction.setFromMatrixPosition(y.matrixWorld),s.setFromMatrixPosition(y.target.matrixWorld),w.direction.sub(s),w.direction.transformDirection(g),d++}else if(y.isSpotLight){const w=r.spot[m];w.position.setFromMatrixPosition(y.matrixWorld),w.position.applyMatrix4(g),w.direction.setFromMatrixPosition(y.matrixWorld),s.setFromMatrixPosition(y.target.matrixWorld),w.direction.sub(s),w.direction.transformDirection(g),m++}else if(y.isRectAreaLight){const w=r.rectArea[h];w.position.setFromMatrixPosition(y.matrixWorld),w.position.applyMatrix4(g),o.identity(),a.copy(y.matrixWorld),a.premultiply(g),o.extractRotation(a),w.halfWidth.set(y.width*.5,0,0),w.halfHeight.set(0,y.height*.5,0),w.halfWidth.applyMatrix4(o),w.halfHeight.applyMatrix4(o),h++}else if(y.isPointLight){const w=r.point[p];w.position.setFromMatrixPosition(y.matrixWorld),w.position.applyMatrix4(g),p++}else if(y.isHemisphereLight){const w=r.hemi[_];w.direction.setFromMatrixPosition(y.matrixWorld),w.direction.transformDirection(g),_++}}}return{setup:l,setupView:c,state:r}}function nc(i,e){const t=new Zb(i,e),n=[],r=[];function s(){n.length=0,r.length=0}function a(f){n.push(f)}function o(f){r.push(f)}function l(f){t.setup(n,f)}function c(f){t.setupView(n,f)}return{init:s,state:{lightsArray:n,shadowsArray:r,lights:t},setupLights:l,setupLightsView:c,pushLight:a,pushShadow:o}}function Kb(i,e){let t=new WeakMap;function n(s,a=0){const o=t.get(s);let l;return o===void 0?(l=new nc(i,e),t.set(s,[l])):a>=o.length?(l=new nc(i,e),o.push(l)):l=o[a],l}function r(){t=new WeakMap}return{get:n,dispose:r}}class Jb extends Tr{constructor(e){super(),this.isMeshDepthMaterial=!0,this.type="MeshDepthMaterial",this.depthPacking=Gm,this.map=null,this.alphaMap=null,this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.wireframe=!1,this.wireframeLinewidth=1,this.setValues(e)}copy(e){return super.copy(e),this.depthPacking=e.depthPacking,this.map=e.map,this.alphaMap=e.alphaMap,this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this}}class Qb extends Tr{constructor(e){super(),this.isMeshDistanceMaterial=!0,this.type="MeshDistanceMaterial",this.referencePosition=new B,this.nearDistance=1,this.farDistance=1e3,this.map=null,this.alphaMap=null,this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.setValues(e)}copy(e){return super.copy(e),this.referencePosition.copy(e.referencePosition),this.nearDistance=e.nearDistance,this.farDistance=e.farDistance,this.map=e.map,this.alphaMap=e.alphaMap,this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this}}const $b=`void main() {
	gl_Position = vec4( position, 1.0 );
}`,e2=`uniform sampler2D shadow_pass;
uniform vec2 resolution;
uniform float radius;
#include <packing>
void main() {
	const float samples = float( VSM_SAMPLES );
	float mean = 0.0;
	float squared_mean = 0.0;
	float uvStride = samples <= 1.0 ? 0.0 : 2.0 / ( samples - 1.0 );
	float uvStart = samples <= 1.0 ? 0.0 : - 1.0;
	for ( float i = 0.0; i < samples; i ++ ) {
		float uvOffset = uvStart + i * uvStride;
		#ifdef HORIZONTAL_PASS
			vec2 distribution = unpackRGBATo2Half( texture2D( shadow_pass, ( gl_FragCoord.xy + vec2( uvOffset, 0.0 ) * radius ) / resolution ) );
			mean += distribution.x;
			squared_mean += distribution.y * distribution.y + distribution.x * distribution.x;
		#else
			float depth = unpackRGBAToDepth( texture2D( shadow_pass, ( gl_FragCoord.xy + vec2( 0.0, uvOffset ) * radius ) / resolution ) );
			mean += depth;
			squared_mean += depth * depth;
		#endif
	}
	mean = mean / samples;
	squared_mean = squared_mean / samples;
	float std_dev = sqrt( squared_mean - mean * mean );
	gl_FragColor = pack2HalfToRGBA( vec2( mean, std_dev ) );
}`;function t2(i,e,t){let n=new Yc;const r=new st,s=new st,a=new Nt,o=new Jb({depthPacking:Hm}),l=new Qb,c={},u=t.maxTextureSize,f={[Zn]:an,[an]:Zn,[zn]:zn},d=new mi({defines:{VSM_SAMPLES:8},uniforms:{shadow_pass:{value:null},resolution:{value:new st},radius:{value:4}},vertexShader:$b,fragmentShader:e2}),p=d.clone();p.defines.HORIZONTAL_PASS=1;const m=new $t;m.setAttribute("position",new Cn(new Float32Array([-1,-1,.5,3,-1,.5,-1,3,.5]),3));const h=new Te(m,d),_=this;this.enabled=!1,this.autoUpdate=!0,this.needsUpdate=!1,this.type=Ac,this.render=function(y,w,M){if(_.enabled===!1||_.autoUpdate===!1&&_.needsUpdate===!1||y.length===0)return;const E=i.getRenderTarget(),x=i.getActiveCubeFace(),C=i.getActiveMipmapLevel(),A=i.state;A.setBlending(Yn),A.buffers.color.setClear(1,1,1,1),A.buffers.depth.setTest(!0),A.setScissorTest(!1);for(let D=0,G=y.length;D<G;D++){const U=y[D],z=U.shadow;if(z===void 0){console.warn("THREE.WebGLShadowMap:",U,"has no shadow.");continue}if(z.autoUpdate===!1&&z.needsUpdate===!1)continue;r.copy(z.mapSize);const X=z.getFrameExtents();if(r.multiply(X),s.copy(z.mapSize),(r.x>u||r.y>u)&&(r.x>u&&(s.x=Math.floor(u/X.x),r.x=s.x*X.x,z.mapSize.x=s.x),r.y>u&&(s.y=Math.floor(u/X.y),r.y=s.y*X.y,z.mapSize.y=s.y)),z.map===null){const le=this.type!==sr?{minFilter:jt,magFilter:jt}:{};z.map=new pi(r.x,r.y,le),z.map.texture.name=U.name+".shadowMap",z.camera.updateProjectionMatrix()}i.setRenderTarget(z.map),i.clear();const ae=z.getViewportCount();for(let le=0;le<ae;le++){const $=z.getViewport(le);a.set(s.x*$.x,s.y*$.y,s.x*$.z,s.y*$.w),A.viewport(a),z.updateMatrices(U,le),n=z.getFrustum(),b(w,M,z.camera,U,this.type)}z.isPointLightShadow!==!0&&this.type===sr&&g(z,M),z.needsUpdate=!1}_.needsUpdate=!1,i.setRenderTarget(E,x,C)};function g(y,w){const M=e.update(h);d.defines.VSM_SAMPLES!==y.blurSamples&&(d.defines.VSM_SAMPLES=y.blurSamples,p.defines.VSM_SAMPLES=y.blurSamples,d.needsUpdate=!0,p.needsUpdate=!0),y.mapPass===null&&(y.mapPass=new pi(r.x,r.y)),d.uniforms.shadow_pass.value=y.map.texture,d.uniforms.resolution.value=y.mapSize,d.uniforms.radius.value=y.radius,i.setRenderTarget(y.mapPass),i.clear(),i.renderBufferDirect(w,null,M,d,h,null),p.uniforms.shadow_pass.value=y.mapPass.texture,p.uniforms.resolution.value=y.mapSize,p.uniforms.radius.value=y.radius,i.setRenderTarget(y.map),i.clear(),i.renderBufferDirect(w,null,M,p,h,null)}function v(y,w,M,E,x,C){let A=null;const D=M.isPointLight===!0?y.customDistanceMaterial:y.customDepthMaterial;if(D!==void 0)A=D;else if(A=M.isPointLight===!0?l:o,i.localClippingEnabled&&w.clipShadows===!0&&Array.isArray(w.clippingPlanes)&&w.clippingPlanes.length!==0||w.displacementMap&&w.displacementScale!==0||w.alphaMap&&w.alphaTest>0||w.map&&w.alphaTest>0){const G=A.uuid,U=w.uuid;let z=c[G];z===void 0&&(z={},c[G]=z);let X=z[U];X===void 0&&(X=A.clone(),z[U]=X),A=X}return A.visible=w.visible,A.wireframe=w.wireframe,C===sr?A.side=w.shadowSide!==null?w.shadowSide:w.side:A.side=w.shadowSide!==null?w.shadowSide:f[w.side],A.alphaMap=w.alphaMap,A.alphaTest=w.alphaTest,A.map=w.map,A.clipShadows=w.clipShadows,A.clippingPlanes=w.clippingPlanes,A.clipIntersection=w.clipIntersection,A.displacementMap=w.displacementMap,A.displacementScale=w.displacementScale,A.displacementBias=w.displacementBias,A.wireframeLinewidth=w.wireframeLinewidth,A.linewidth=w.linewidth,M.isPointLight===!0&&A.isMeshDistanceMaterial===!0&&(A.referencePosition.setFromMatrixPosition(M.matrixWorld),A.nearDistance=E,A.farDistance=x),A}function b(y,w,M,E,x){if(y.visible===!1)return;if(y.layers.test(w.layers)&&(y.isMesh||y.isLine||y.isPoints)&&(y.castShadow||y.receiveShadow&&x===sr)&&(!y.frustumCulled||n.intersectsObject(y))){y.modelViewMatrix.multiplyMatrices(M.matrixWorldInverse,y.matrixWorld);const D=e.update(y),G=y.material;if(Array.isArray(G)){const U=D.groups;for(let z=0,X=U.length;z<X;z++){const ae=U[z],le=G[ae.materialIndex];if(le&&le.visible){const $=v(y,le,E,M.near,M.far,x);i.renderBufferDirect(M,null,D,$,y,ae)}}}else if(G.visible){const U=v(y,G,E,M.near,M.far,x);i.renderBufferDirect(M,null,D,U,y,null)}}const A=y.children;for(let D=0,G=A.length;D<G;D++)b(A[D],w,M,E,x)}}function n2(i,e,t){const n=t.isWebGL2;function r(){let V=!1;const ie=new Nt;let fe=null;const De=new Nt(0,0,0,0);return{setMask:function(Ie){fe!==Ie&&!V&&(i.colorMask(Ie,Ie,Ie,Ie),fe=Ie)},setLocked:function(Ie){V=Ie},setClear:function(Ie,ht,At,Gt,vn){vn===!0&&(Ie*=Gt,ht*=Gt,At*=Gt),ie.set(Ie,ht,At,Gt),De.equals(ie)===!1&&(i.clearColor(Ie,ht,At,Gt),De.copy(ie))},reset:function(){V=!1,fe=null,De.set(-1,0,0,0)}}}function s(){let V=!1,ie=null,fe=null,De=null;return{setTest:function(Ie){Ie?we(2929):Ee(2929)},setMask:function(Ie){ie!==Ie&&!V&&(i.depthMask(Ie),ie=Ie)},setFunc:function(Ie){if(fe!==Ie){switch(Ie){case dm:i.depthFunc(512);break;case hm:i.depthFunc(519);break;case pm:i.depthFunc(513);break;case oa:i.depthFunc(515);break;case mm:i.depthFunc(514);break;case _m:i.depthFunc(518);break;case gm:i.depthFunc(516);break;case bm:i.depthFunc(517);break;default:i.depthFunc(515)}fe=Ie}},setLocked:function(Ie){V=Ie},setClear:function(Ie){De!==Ie&&(i.clearDepth(Ie),De=Ie)},reset:function(){V=!1,ie=null,fe=null,De=null}}}function a(){let V=!1,ie=null,fe=null,De=null,Ie=null,ht=null,At=null,Gt=null,vn=null;return{setTest:function(yt){V||(yt?we(2960):Ee(2960))},setMask:function(yt){ie!==yt&&!V&&(i.stencilMask(yt),ie=yt)},setFunc:function(yt,cn,yn){(fe!==yt||De!==cn||Ie!==yn)&&(i.stencilFunc(yt,cn,yn),fe=yt,De=cn,Ie=yn)},setOp:function(yt,cn,yn){(ht!==yt||At!==cn||Gt!==yn)&&(i.stencilOp(yt,cn,yn),ht=yt,At=cn,Gt=yn)},setLocked:function(yt){V=yt},setClear:function(yt){vn!==yt&&(i.clearStencil(yt),vn=yt)},reset:function(){V=!1,ie=null,fe=null,De=null,Ie=null,ht=null,At=null,Gt=null,vn=null}}}const o=new r,l=new s,c=new a,u=new WeakMap,f=new WeakMap;let d={},p={},m=new WeakMap,h=[],_=null,g=!1,v=null,b=null,y=null,w=null,M=null,E=null,x=null,C=!1,A=null,D=null,G=null,U=null,z=null;const X=i.getParameter(35661);let ae=!1,le=0;const $=i.getParameter(7938);$.indexOf("WebGL")!==-1?(le=parseFloat(/^WebGL (\d)/.exec($)[1]),ae=le>=1):$.indexOf("OpenGL ES")!==-1&&(le=parseFloat(/^OpenGL ES (\d)/.exec($)[1]),ae=le>=2);let ne=null,ue={};const be=i.getParameter(3088),q=i.getParameter(2978),ce=new Nt().fromArray(be),he=new Nt().fromArray(q);function W(V,ie,fe){const De=new Uint8Array(4),Ie=i.createTexture();i.bindTexture(V,Ie),i.texParameteri(V,10241,9728),i.texParameteri(V,10240,9728);for(let ht=0;ht<fe;ht++)i.texImage2D(ie+ht,0,6408,1,1,0,6408,5121,De);return Ie}const Se={};Se[3553]=W(3553,3553,1),Se[34067]=W(34067,34069,6),o.setClear(0,0,0,1),l.setClear(1),c.setClear(0),we(2929),l.setFunc(oa),ot(!1),Pt(Xo),we(2884),Le(Yn);function we(V){d[V]!==!0&&(i.enable(V),d[V]=!0)}function Ee(V){d[V]!==!1&&(i.disable(V),d[V]=!1)}function Ce(V,ie){return p[V]!==ie?(i.bindFramebuffer(V,ie),p[V]=ie,n&&(V===36009&&(p[36160]=ie),V===36160&&(p[36009]=ie)),!0):!1}function Fe(V,ie){let fe=h,De=!1;if(V)if(fe=m.get(ie),fe===void 0&&(fe=[],m.set(ie,fe)),V.isWebGLMultipleRenderTargets){const Ie=V.texture;if(fe.length!==Ie.length||fe[0]!==36064){for(let ht=0,At=Ie.length;ht<At;ht++)fe[ht]=36064+ht;fe.length=Ie.length,De=!0}}else fe[0]!==36064&&(fe[0]=36064,De=!0);else fe[0]!==1029&&(fe[0]=1029,De=!0);De&&(t.isWebGL2?i.drawBuffers(fe):e.get("WEBGL_draw_buffers").drawBuffersWEBGL(fe))}function ze(V){return _!==V?(i.useProgram(V),_=V,!0):!1}const oe={[Ai]:32774,[tm]:32778,[nm]:32779};if(n)oe[Zo]=32775,oe[Ko]=32776;else{const V=e.get("EXT_blend_minmax");V!==null&&(oe[Zo]=V.MIN_EXT,oe[Ko]=V.MAX_EXT)}const ye={[im]:0,[rm]:1,[sm]:768,[Dc]:770,[fm]:776,[cm]:774,[om]:772,[am]:769,[Rc]:771,[um]:775,[lm]:773};function Le(V,ie,fe,De,Ie,ht,At,Gt){if(V===Yn){g===!0&&(Ee(3042),g=!1);return}if(g===!1&&(we(3042),g=!0),V!==em){if(V!==v||Gt!==C){if((b!==Ai||M!==Ai)&&(i.blendEquation(32774),b=Ai,M=Ai),Gt)switch(V){case Ni:i.blendFuncSeparate(1,771,1,771);break;case jo:i.blendFunc(1,1);break;case qo:i.blendFuncSeparate(0,769,0,1);break;case Yo:i.blendFuncSeparate(0,768,0,770);break;default:console.error("THREE.WebGLState: Invalid blending: ",V);break}else switch(V){case Ni:i.blendFuncSeparate(770,771,1,771);break;case jo:i.blendFunc(770,1);break;case qo:i.blendFuncSeparate(0,769,0,1);break;case Yo:i.blendFunc(0,768);break;default:console.error("THREE.WebGLState: Invalid blending: ",V);break}y=null,w=null,E=null,x=null,v=V,C=Gt}return}Ie=Ie||ie,ht=ht||fe,At=At||De,(ie!==b||Ie!==M)&&(i.blendEquationSeparate(oe[ie],oe[Ie]),b=ie,M=Ie),(fe!==y||De!==w||ht!==E||At!==x)&&(i.blendFuncSeparate(ye[fe],ye[De],ye[ht],ye[At]),y=fe,w=De,E=ht,x=At),v=V,C=!1}function Xe(V,ie){V.side===zn?Ee(2884):we(2884);let fe=V.side===an;ie&&(fe=!fe),ot(fe),V.blending===Ni&&V.transparent===!1?Le(Yn):Le(V.blending,V.blendEquation,V.blendSrc,V.blendDst,V.blendEquationAlpha,V.blendSrcAlpha,V.blendDstAlpha,V.premultipliedAlpha),l.setFunc(V.depthFunc),l.setTest(V.depthTest),l.setMask(V.depthWrite),o.setMask(V.colorWrite);const De=V.stencilWrite;c.setTest(De),De&&(c.setMask(V.stencilWriteMask),c.setFunc(V.stencilFunc,V.stencilRef,V.stencilFuncMask),c.setOp(V.stencilFail,V.stencilZFail,V.stencilZPass)),ct(V.polygonOffset,V.polygonOffsetFactor,V.polygonOffsetUnits),V.alphaToCoverage===!0?we(32926):Ee(32926)}function ot(V){A!==V&&(V?i.frontFace(2304):i.frontFace(2305),A=V)}function Pt(V){V!==Jp?(we(2884),V!==D&&(V===Xo?i.cullFace(1029):V===Qp?i.cullFace(1028):i.cullFace(1032))):Ee(2884),D=V}function lt(V){V!==G&&(ae&&i.lineWidth(V),G=V)}function ct(V,ie,fe){V?(we(32823),(U!==ie||z!==fe)&&(i.polygonOffset(ie,fe),U=ie,z=fe)):Ee(32823)}function en(V){V?we(3089):Ee(3089)}function Ft(V){V===void 0&&(V=33984+X-1),ne!==V&&(i.activeTexture(V),ne=V)}function R(V,ie,fe){fe===void 0&&(ne===null?fe=33984+X-1:fe=ne);let De=ue[fe];De===void 0&&(De={type:void 0,texture:void 0},ue[fe]=De),(De.type!==V||De.texture!==ie)&&(ne!==fe&&(i.activeTexture(fe),ne=fe),i.bindTexture(V,ie||Se[V]),De.type=V,De.texture=ie)}function T(){const V=ue[ne];V!==void 0&&V.type!==void 0&&(i.bindTexture(V.type,null),V.type=void 0,V.texture=void 0)}function te(){try{i.compressedTexImage2D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function me(){try{i.compressedTexImage3D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function pe(){try{i.texSubImage2D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function xe(){try{i.texSubImage3D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function Be(){try{i.compressedTexSubImage2D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function Me(){try{i.compressedTexSubImage3D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function re(){try{i.texStorage2D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function Pe(){try{i.texStorage3D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function Re(){try{i.texImage2D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function ke(){try{i.texImage3D.apply(i,arguments)}catch(V){console.error("THREE.WebGLState:",V)}}function Ue(V){ce.equals(V)===!1&&(i.scissor(V.x,V.y,V.z,V.w),ce.copy(V))}function Ae(V){he.equals(V)===!1&&(i.viewport(V.x,V.y,V.z,V.w),he.copy(V))}function _e(V,ie){let fe=f.get(ie);fe===void 0&&(fe=new WeakMap,f.set(ie,fe));let De=fe.get(V);De===void 0&&(De=i.getUniformBlockIndex(ie,V.name),fe.set(V,De))}function je(V,ie){const De=f.get(ie).get(V);u.get(ie)!==De&&(i.uniformBlockBinding(ie,De,V.__bindingPointIndex),u.set(ie,De))}function He(){i.disable(3042),i.disable(2884),i.disable(2929),i.disable(32823),i.disable(3089),i.disable(2960),i.disable(32926),i.blendEquation(32774),i.blendFunc(1,0),i.blendFuncSeparate(1,0,1,0),i.colorMask(!0,!0,!0,!0),i.clearColor(0,0,0,0),i.depthMask(!0),i.depthFunc(513),i.clearDepth(1),i.stencilMask(4294967295),i.stencilFunc(519,0,4294967295),i.stencilOp(7680,7680,7680),i.clearStencil(0),i.cullFace(1029),i.frontFace(2305),i.polygonOffset(0,0),i.activeTexture(33984),i.bindFramebuffer(36160,null),n===!0&&(i.bindFramebuffer(36009,null),i.bindFramebuffer(36008,null)),i.useProgram(null),i.lineWidth(1),i.scissor(0,0,i.canvas.width,i.canvas.height),i.viewport(0,0,i.canvas.width,i.canvas.height),d={},ne=null,ue={},p={},m=new WeakMap,h=[],_=null,g=!1,v=null,b=null,y=null,w=null,M=null,E=null,x=null,C=!1,A=null,D=null,G=null,U=null,z=null,ce.set(0,0,i.canvas.width,i.canvas.height),he.set(0,0,i.canvas.width,i.canvas.height),o.reset(),l.reset(),c.reset()}return{buffers:{color:o,depth:l,stencil:c},enable:we,disable:Ee,bindFramebuffer:Ce,drawBuffers:Fe,useProgram:ze,setBlending:Le,setMaterial:Xe,setFlipSided:ot,setCullFace:Pt,setLineWidth:lt,setPolygonOffset:ct,setScissorTest:en,activeTexture:Ft,bindTexture:R,unbindTexture:T,compressedTexImage2D:te,compressedTexImage3D:me,texImage2D:Re,texImage3D:ke,updateUBOMapping:_e,uniformBlockBinding:je,texStorage2D:re,texStorage3D:Pe,texSubImage2D:pe,texSubImage3D:xe,compressedTexSubImage2D:Be,compressedTexSubImage3D:Me,scissor:Ue,viewport:Ae,reset:He}}function i2(i,e,t,n,r,s,a){const o=r.isWebGL2,l=r.maxTextures,c=r.maxCubemapSize,u=r.maxTextureSize,f=r.maxSamples,d=e.has("WEBGL_multisampled_render_to_texture")?e.get("WEBGL_multisampled_render_to_texture"):null,p=typeof navigator>"u"?!1:/OculusBrowser/g.test(navigator.userAgent),m=new WeakMap;let h;const _=new WeakMap;let g=!1;try{g=typeof OffscreenCanvas<"u"&&new OffscreenCanvas(1,1).getContext("2d")!==null}catch{}function v(R,T){return g?new OffscreenCanvas(R,T):fs("canvas")}function b(R,T,te,me){let pe=1;if((R.width>me||R.height>me)&&(pe=me/Math.max(R.width,R.height)),pe<1||T===!0)if(typeof HTMLImageElement<"u"&&R instanceof HTMLImageElement||typeof HTMLCanvasElement<"u"&&R instanceof HTMLCanvasElement||typeof ImageBitmap<"u"&&R instanceof ImageBitmap){const xe=T?Fc:Math.floor,Be=xe(pe*R.width),Me=xe(pe*R.height);h===void 0&&(h=v(Be,Me));const re=te?v(Be,Me):h;return re.width=Be,re.height=Me,re.getContext("2d").drawImage(R,0,0,Be,Me),console.warn("THREE.WebGLRenderer: Texture has been resized from ("+R.width+"x"+R.height+") to ("+Be+"x"+Me+")."),re}else return"data"in R&&console.warn("THREE.WebGLRenderer: Image in DataTexture is too big ("+R.width+"x"+R.height+")."),R;return R}function y(R){return ha(R.width)&&ha(R.height)}function w(R){return o?!1:R.wrapS!==_n||R.wrapT!==_n||R.minFilter!==jt&&R.minFilter!==fn}function M(R,T){return R.generateMipmaps&&T&&R.minFilter!==jt&&R.minFilter!==fn}function E(R){i.generateMipmap(R)}function x(R,T,te,me,pe=!1){if(o===!1)return T;if(R!==null){if(i[R]!==void 0)return i[R];console.warn("THREE.WebGLRenderer: Attempt to use non-existing WebGL internal format '"+R+"'")}let xe=T;return T===6403&&(te===5126&&(xe=33326),te===5131&&(xe=33325),te===5121&&(xe=33321)),T===33319&&(te===5126&&(xe=33328),te===5131&&(xe=33327),te===5121&&(xe=33323)),T===6408&&(te===5126&&(xe=34836),te===5131&&(xe=34842),te===5121&&(xe=me===pt&&pe===!1?35907:32856),te===32819&&(xe=32854),te===32820&&(xe=32855)),(xe===33325||xe===33326||xe===33327||xe===33328||xe===34842||xe===34836)&&e.get("EXT_color_buffer_float"),xe}function C(R,T,te){return M(R,te)===!0||R.isFramebufferTexture&&R.minFilter!==jt&&R.minFilter!==fn?Math.log2(Math.max(T.width,T.height))+1:R.mipmaps!==void 0&&R.mipmaps.length>0?R.mipmaps.length:R.isCompressedTexture&&Array.isArray(R.image)?T.mipmaps.length:1}function A(R){return R===jt||R===Jo||R===Cs?9728:9729}function D(R){const T=R.target;T.removeEventListener("dispose",D),U(T),T.isVideoTexture&&m.delete(T)}function G(R){const T=R.target;T.removeEventListener("dispose",G),X(T)}function U(R){const T=n.get(R);if(T.__webglInit===void 0)return;const te=R.source,me=_.get(te);if(me){const pe=me[T.__cacheKey];pe.usedTimes--,pe.usedTimes===0&&z(R),Object.keys(me).length===0&&_.delete(te)}n.remove(R)}function z(R){const T=n.get(R);i.deleteTexture(T.__webglTexture);const te=R.source,me=_.get(te);delete me[T.__cacheKey],a.memory.textures--}function X(R){const T=R.texture,te=n.get(R),me=n.get(T);if(me.__webglTexture!==void 0&&(i.deleteTexture(me.__webglTexture),a.memory.textures--),R.depthTexture&&R.depthTexture.dispose(),R.isWebGLCubeRenderTarget)for(let pe=0;pe<6;pe++)i.deleteFramebuffer(te.__webglFramebuffer[pe]),te.__webglDepthbuffer&&i.deleteRenderbuffer(te.__webglDepthbuffer[pe]);else{if(i.deleteFramebuffer(te.__webglFramebuffer),te.__webglDepthbuffer&&i.deleteRenderbuffer(te.__webglDepthbuffer),te.__webglMultisampledFramebuffer&&i.deleteFramebuffer(te.__webglMultisampledFramebuffer),te.__webglColorRenderbuffer)for(let pe=0;pe<te.__webglColorRenderbuffer.length;pe++)te.__webglColorRenderbuffer[pe]&&i.deleteRenderbuffer(te.__webglColorRenderbuffer[pe]);te.__webglDepthRenderbuffer&&i.deleteRenderbuffer(te.__webglDepthRenderbuffer)}if(R.isWebGLMultipleRenderTargets)for(let pe=0,xe=T.length;pe<xe;pe++){const Be=n.get(T[pe]);Be.__webglTexture&&(i.deleteTexture(Be.__webglTexture),a.memory.textures--),n.remove(T[pe])}n.remove(T),n.remove(R)}let ae=0;function le(){ae=0}function $(){const R=ae;return R>=l&&console.warn("THREE.WebGLTextures: Trying to use "+R+" texture units while this GPU supports only "+l),ae+=1,R}function ne(R){const T=[];return T.push(R.wrapS),T.push(R.wrapT),T.push(R.wrapR||0),T.push(R.magFilter),T.push(R.minFilter),T.push(R.anisotropy),T.push(R.internalFormat),T.push(R.format),T.push(R.type),T.push(R.generateMipmaps),T.push(R.premultiplyAlpha),T.push(R.flipY),T.push(R.unpackAlignment),T.push(R.encoding),T.join()}function ue(R,T){const te=n.get(R);if(R.isVideoTexture&&en(R),R.isRenderTargetTexture===!1&&R.version>0&&te.__version!==R.version){const me=R.image;if(me===null)console.warn("THREE.WebGLRenderer: Texture marked for update but no image data found.");else if(me.complete===!1)console.warn("THREE.WebGLRenderer: Texture marked for update but image is incomplete");else{Ee(te,R,T);return}}t.bindTexture(3553,te.__webglTexture,33984+T)}function be(R,T){const te=n.get(R);if(R.version>0&&te.__version!==R.version){Ee(te,R,T);return}t.bindTexture(35866,te.__webglTexture,33984+T)}function q(R,T){const te=n.get(R);if(R.version>0&&te.__version!==R.version){Ee(te,R,T);return}t.bindTexture(32879,te.__webglTexture,33984+T)}function ce(R,T){const te=n.get(R);if(R.version>0&&te.__version!==R.version){Ce(te,R,T);return}t.bindTexture(34067,te.__webglTexture,33984+T)}const he={[ua]:10497,[_n]:33071,[fa]:33648},W={[jt]:9728,[Jo]:9984,[Cs]:9986,[fn]:9729,[Tm]:9985,[gr]:9987};function Se(R,T,te){if(te?(i.texParameteri(R,10242,he[T.wrapS]),i.texParameteri(R,10243,he[T.wrapT]),(R===32879||R===35866)&&i.texParameteri(R,32882,he[T.wrapR]),i.texParameteri(R,10240,W[T.magFilter]),i.texParameteri(R,10241,W[T.minFilter])):(i.texParameteri(R,10242,33071),i.texParameteri(R,10243,33071),(R===32879||R===35866)&&i.texParameteri(R,32882,33071),(T.wrapS!==_n||T.wrapT!==_n)&&console.warn("THREE.WebGLRenderer: Texture is not power of two. Texture.wrapS and Texture.wrapT should be set to THREE.ClampToEdgeWrapping."),i.texParameteri(R,10240,A(T.magFilter)),i.texParameteri(R,10241,A(T.minFilter)),T.minFilter!==jt&&T.minFilter!==fn&&console.warn("THREE.WebGLRenderer: Texture is not power of two. Texture.minFilter should be set to THREE.NearestFilter or THREE.LinearFilter.")),e.has("EXT_texture_filter_anisotropic")===!0){const me=e.get("EXT_texture_filter_anisotropic");if(T.magFilter===jt||T.minFilter!==Cs&&T.minFilter!==gr||T.type===ci&&e.has("OES_texture_float_linear")===!1||o===!1&&T.type===br&&e.has("OES_texture_half_float_linear")===!1)return;(T.anisotropy>1||n.get(T).__currentAnisotropy)&&(i.texParameterf(R,me.TEXTURE_MAX_ANISOTROPY_EXT,Math.min(T.anisotropy,r.getMaxAnisotropy())),n.get(T).__currentAnisotropy=T.anisotropy)}}function we(R,T){let te=!1;R.__webglInit===void 0&&(R.__webglInit=!0,T.addEventListener("dispose",D));const me=T.source;let pe=_.get(me);pe===void 0&&(pe={},_.set(me,pe));const xe=ne(T);if(xe!==R.__cacheKey){pe[xe]===void 0&&(pe[xe]={texture:i.createTexture(),usedTimes:0},a.memory.textures++,te=!0),pe[xe].usedTimes++;const Be=pe[R.__cacheKey];Be!==void 0&&(pe[R.__cacheKey].usedTimes--,Be.usedTimes===0&&z(T)),R.__cacheKey=xe,R.__webglTexture=pe[xe].texture}return te}function Ee(R,T,te){let me=3553;(T.isDataArrayTexture||T.isCompressedArrayTexture)&&(me=35866),T.isData3DTexture&&(me=32879);const pe=we(R,T),xe=T.source;t.bindTexture(me,R.__webglTexture,33984+te);const Be=n.get(xe);if(xe.version!==Be.__version||pe===!0){t.activeTexture(33984+te),i.pixelStorei(37440,T.flipY),i.pixelStorei(37441,T.premultiplyAlpha),i.pixelStorei(3317,T.unpackAlignment),i.pixelStorei(37443,0);const Me=w(T)&&y(T.image)===!1;let re=b(T.image,Me,!1,u);re=Ft(T,re);const Pe=y(re)||o,Re=s.convert(T.format,T.encoding);let ke=s.convert(T.type),Ue=x(T.internalFormat,Re,ke,T.encoding,T.isVideoTexture);Se(me,T,Pe);let Ae;const _e=T.mipmaps,je=o&&T.isVideoTexture!==!0,He=Be.__version===void 0||pe===!0,V=C(T,re,Pe);if(T.isDepthTexture)Ue=6402,o?T.type===ci?Ue=36012:T.type===li?Ue=33190:T.type===zi?Ue=35056:Ue=33189:T.type===ci&&console.error("WebGLRenderer: Floating point depth texture requires WebGL2."),T.format===ui&&Ue===6402&&T.type!==Nc&&T.type!==li&&(console.warn("THREE.WebGLRenderer: Use UnsignedShortType or UnsignedIntType for DepthFormat DepthTexture."),T.type=li,ke=s.convert(T.type)),T.format===Gi&&Ue===6402&&(Ue=34041,T.type!==zi&&(console.warn("THREE.WebGLRenderer: Use UnsignedInt248Type for DepthStencilFormat DepthTexture."),T.type=zi,ke=s.convert(T.type))),He&&(je?t.texStorage2D(3553,1,Ue,re.width,re.height):t.texImage2D(3553,0,Ue,re.width,re.height,0,Re,ke,null));else if(T.isDataTexture)if(_e.length>0&&Pe){je&&He&&t.texStorage2D(3553,V,Ue,_e[0].width,_e[0].height);for(let ie=0,fe=_e.length;ie<fe;ie++)Ae=_e[ie],je?t.texSubImage2D(3553,ie,0,0,Ae.width,Ae.height,Re,ke,Ae.data):t.texImage2D(3553,ie,Ue,Ae.width,Ae.height,0,Re,ke,Ae.data);T.generateMipmaps=!1}else je?(He&&t.texStorage2D(3553,V,Ue,re.width,re.height),t.texSubImage2D(3553,0,0,0,re.width,re.height,Re,ke,re.data)):t.texImage2D(3553,0,Ue,re.width,re.height,0,Re,ke,re.data);else if(T.isCompressedTexture)if(T.isCompressedArrayTexture){je&&He&&t.texStorage3D(35866,V,Ue,_e[0].width,_e[0].height,re.depth);for(let ie=0,fe=_e.length;ie<fe;ie++)Ae=_e[ie],T.format!==gn?Re!==null?je?t.compressedTexSubImage3D(35866,ie,0,0,0,Ae.width,Ae.height,re.depth,Re,Ae.data,0,0):t.compressedTexImage3D(35866,ie,Ue,Ae.width,Ae.height,re.depth,0,Ae.data,0,0):console.warn("THREE.WebGLRenderer: Attempt to load unsupported compressed texture format in .uploadTexture()"):je?t.texSubImage3D(35866,ie,0,0,0,Ae.width,Ae.height,re.depth,Re,ke,Ae.data):t.texImage3D(35866,ie,Ue,Ae.width,Ae.height,re.depth,0,Re,ke,Ae.data)}else{je&&He&&t.texStorage2D(3553,V,Ue,_e[0].width,_e[0].height);for(let ie=0,fe=_e.length;ie<fe;ie++)Ae=_e[ie],T.format!==gn?Re!==null?je?t.compressedTexSubImage2D(3553,ie,0,0,Ae.width,Ae.height,Re,Ae.data):t.compressedTexImage2D(3553,ie,Ue,Ae.width,Ae.height,0,Ae.data):console.warn("THREE.WebGLRenderer: Attempt to load unsupported compressed texture format in .uploadTexture()"):je?t.texSubImage2D(3553,ie,0,0,Ae.width,Ae.height,Re,ke,Ae.data):t.texImage2D(3553,ie,Ue,Ae.width,Ae.height,0,Re,ke,Ae.data)}else if(T.isDataArrayTexture)je?(He&&t.texStorage3D(35866,V,Ue,re.width,re.height,re.depth),t.texSubImage3D(35866,0,0,0,0,re.width,re.height,re.depth,Re,ke,re.data)):t.texImage3D(35866,0,Ue,re.width,re.height,re.depth,0,Re,ke,re.data);else if(T.isData3DTexture)je?(He&&t.texStorage3D(32879,V,Ue,re.width,re.height,re.depth),t.texSubImage3D(32879,0,0,0,0,re.width,re.height,re.depth,Re,ke,re.data)):t.texImage3D(32879,0,Ue,re.width,re.height,re.depth,0,Re,ke,re.data);else if(T.isFramebufferTexture){if(He)if(je)t.texStorage2D(3553,V,Ue,re.width,re.height);else{let ie=re.width,fe=re.height;for(let De=0;De<V;De++)t.texImage2D(3553,De,Ue,ie,fe,0,Re,ke,null),ie>>=1,fe>>=1}}else if(_e.length>0&&Pe){je&&He&&t.texStorage2D(3553,V,Ue,_e[0].width,_e[0].height);for(let ie=0,fe=_e.length;ie<fe;ie++)Ae=_e[ie],je?t.texSubImage2D(3553,ie,0,0,Re,ke,Ae):t.texImage2D(3553,ie,Ue,Re,ke,Ae);T.generateMipmaps=!1}else je?(He&&t.texStorage2D(3553,V,Ue,re.width,re.height),t.texSubImage2D(3553,0,0,0,Re,ke,re)):t.texImage2D(3553,0,Ue,Re,ke,re);M(T,Pe)&&E(me),Be.__version=xe.version,T.onUpdate&&T.onUpdate(T)}R.__version=T.version}function Ce(R,T,te){if(T.image.length!==6)return;const me=we(R,T),pe=T.source;t.bindTexture(34067,R.__webglTexture,33984+te);const xe=n.get(pe);if(pe.version!==xe.__version||me===!0){t.activeTexture(33984+te),i.pixelStorei(37440,T.flipY),i.pixelStorei(37441,T.premultiplyAlpha),i.pixelStorei(3317,T.unpackAlignment),i.pixelStorei(37443,0);const Be=T.isCompressedTexture||T.image[0].isCompressedTexture,Me=T.image[0]&&T.image[0].isDataTexture,re=[];for(let ie=0;ie<6;ie++)!Be&&!Me?re[ie]=b(T.image[ie],!1,!0,c):re[ie]=Me?T.image[ie].image:T.image[ie],re[ie]=Ft(T,re[ie]);const Pe=re[0],Re=y(Pe)||o,ke=s.convert(T.format,T.encoding),Ue=s.convert(T.type),Ae=x(T.internalFormat,ke,Ue,T.encoding),_e=o&&T.isVideoTexture!==!0,je=xe.__version===void 0||me===!0;let He=C(T,Pe,Re);Se(34067,T,Re);let V;if(Be){_e&&je&&t.texStorage2D(34067,He,Ae,Pe.width,Pe.height);for(let ie=0;ie<6;ie++){V=re[ie].mipmaps;for(let fe=0;fe<V.length;fe++){const De=V[fe];T.format!==gn?ke!==null?_e?t.compressedTexSubImage2D(34069+ie,fe,0,0,De.width,De.height,ke,De.data):t.compressedTexImage2D(34069+ie,fe,Ae,De.width,De.height,0,De.data):console.warn("THREE.WebGLRenderer: Attempt to load unsupported compressed texture format in .setTextureCube()"):_e?t.texSubImage2D(34069+ie,fe,0,0,De.width,De.height,ke,Ue,De.data):t.texImage2D(34069+ie,fe,Ae,De.width,De.height,0,ke,Ue,De.data)}}}else{V=T.mipmaps,_e&&je&&(V.length>0&&He++,t.texStorage2D(34067,He,Ae,re[0].width,re[0].height));for(let ie=0;ie<6;ie++)if(Me){_e?t.texSubImage2D(34069+ie,0,0,0,re[ie].width,re[ie].height,ke,Ue,re[ie].data):t.texImage2D(34069+ie,0,Ae,re[ie].width,re[ie].height,0,ke,Ue,re[ie].data);for(let fe=0;fe<V.length;fe++){const Ie=V[fe].image[ie].image;_e?t.texSubImage2D(34069+ie,fe+1,0,0,Ie.width,Ie.height,ke,Ue,Ie.data):t.texImage2D(34069+ie,fe+1,Ae,Ie.width,Ie.height,0,ke,Ue,Ie.data)}}else{_e?t.texSubImage2D(34069+ie,0,0,0,ke,Ue,re[ie]):t.texImage2D(34069+ie,0,Ae,ke,Ue,re[ie]);for(let fe=0;fe<V.length;fe++){const De=V[fe];_e?t.texSubImage2D(34069+ie,fe+1,0,0,ke,Ue,De.image[ie]):t.texImage2D(34069+ie,fe+1,Ae,ke,Ue,De.image[ie])}}}M(T,Re)&&E(34067),xe.__version=pe.version,T.onUpdate&&T.onUpdate(T)}R.__version=T.version}function Fe(R,T,te,me,pe){const xe=s.convert(te.format,te.encoding),Be=s.convert(te.type),Me=x(te.internalFormat,xe,Be,te.encoding);n.get(T).__hasExternalTextures||(pe===32879||pe===35866?t.texImage3D(pe,0,Me,T.width,T.height,T.depth,0,xe,Be,null):t.texImage2D(pe,0,Me,T.width,T.height,0,xe,Be,null)),t.bindFramebuffer(36160,R),ct(T)?d.framebufferTexture2DMultisampleEXT(36160,me,pe,n.get(te).__webglTexture,0,lt(T)):(pe===3553||pe>=34069&&pe<=34074)&&i.framebufferTexture2D(36160,me,pe,n.get(te).__webglTexture,0),t.bindFramebuffer(36160,null)}function ze(R,T,te){if(i.bindRenderbuffer(36161,R),T.depthBuffer&&!T.stencilBuffer){let me=33189;if(te||ct(T)){const pe=T.depthTexture;pe&&pe.isDepthTexture&&(pe.type===ci?me=36012:pe.type===li&&(me=33190));const xe=lt(T);ct(T)?d.renderbufferStorageMultisampleEXT(36161,xe,me,T.width,T.height):i.renderbufferStorageMultisample(36161,xe,me,T.width,T.height)}else i.renderbufferStorage(36161,me,T.width,T.height);i.framebufferRenderbuffer(36160,36096,36161,R)}else if(T.depthBuffer&&T.stencilBuffer){const me=lt(T);te&&ct(T)===!1?i.renderbufferStorageMultisample(36161,me,35056,T.width,T.height):ct(T)?d.renderbufferStorageMultisampleEXT(36161,me,35056,T.width,T.height):i.renderbufferStorage(36161,34041,T.width,T.height),i.framebufferRenderbuffer(36160,33306,36161,R)}else{const me=T.isWebGLMultipleRenderTargets===!0?T.texture:[T.texture];for(let pe=0;pe<me.length;pe++){const xe=me[pe],Be=s.convert(xe.format,xe.encoding),Me=s.convert(xe.type),re=x(xe.internalFormat,Be,Me,xe.encoding),Pe=lt(T);te&&ct(T)===!1?i.renderbufferStorageMultisample(36161,Pe,re,T.width,T.height):ct(T)?d.renderbufferStorageMultisampleEXT(36161,Pe,re,T.width,T.height):i.renderbufferStorage(36161,re,T.width,T.height)}}i.bindRenderbuffer(36161,null)}function oe(R,T){if(T&&T.isWebGLCubeRenderTarget)throw new Error("Depth Texture with cube render targets is not supported");if(t.bindFramebuffer(36160,R),!(T.depthTexture&&T.depthTexture.isDepthTexture))throw new Error("renderTarget.depthTexture must be an instance of THREE.DepthTexture");(!n.get(T.depthTexture).__webglTexture||T.depthTexture.image.width!==T.width||T.depthTexture.image.height!==T.height)&&(T.depthTexture.image.width=T.width,T.depthTexture.image.height=T.height,T.depthTexture.needsUpdate=!0),ue(T.depthTexture,0);const me=n.get(T.depthTexture).__webglTexture,pe=lt(T);if(T.depthTexture.format===ui)ct(T)?d.framebufferTexture2DMultisampleEXT(36160,36096,3553,me,0,pe):i.framebufferTexture2D(36160,36096,3553,me,0);else if(T.depthTexture.format===Gi)ct(T)?d.framebufferTexture2DMultisampleEXT(36160,33306,3553,me,0,pe):i.framebufferTexture2D(36160,33306,3553,me,0);else throw new Error("Unknown depthTexture format")}function ye(R){const T=n.get(R),te=R.isWebGLCubeRenderTarget===!0;if(R.depthTexture&&!T.__autoAllocateDepthBuffer){if(te)throw new Error("target.depthTexture not supported in Cube render targets");oe(T.__webglFramebuffer,R)}else if(te){T.__webglDepthbuffer=[];for(let me=0;me<6;me++)t.bindFramebuffer(36160,T.__webglFramebuffer[me]),T.__webglDepthbuffer[me]=i.createRenderbuffer(),ze(T.__webglDepthbuffer[me],R,!1)}else t.bindFramebuffer(36160,T.__webglFramebuffer),T.__webglDepthbuffer=i.createRenderbuffer(),ze(T.__webglDepthbuffer,R,!1);t.bindFramebuffer(36160,null)}function Le(R,T,te){const me=n.get(R);T!==void 0&&Fe(me.__webglFramebuffer,R,R.texture,36064,3553),te!==void 0&&ye(R)}function Xe(R){const T=R.texture,te=n.get(R),me=n.get(T);R.addEventListener("dispose",G),R.isWebGLMultipleRenderTargets!==!0&&(me.__webglTexture===void 0&&(me.__webglTexture=i.createTexture()),me.__version=T.version,a.memory.textures++);const pe=R.isWebGLCubeRenderTarget===!0,xe=R.isWebGLMultipleRenderTargets===!0,Be=y(R)||o;if(pe){te.__webglFramebuffer=[];for(let Me=0;Me<6;Me++)te.__webglFramebuffer[Me]=i.createFramebuffer()}else{if(te.__webglFramebuffer=i.createFramebuffer(),xe)if(r.drawBuffers){const Me=R.texture;for(let re=0,Pe=Me.length;re<Pe;re++){const Re=n.get(Me[re]);Re.__webglTexture===void 0&&(Re.__webglTexture=i.createTexture(),a.memory.textures++)}}else console.warn("THREE.WebGLRenderer: WebGLMultipleRenderTargets can only be used with WebGL2 or WEBGL_draw_buffers extension.");if(o&&R.samples>0&&ct(R)===!1){const Me=xe?T:[T];te.__webglMultisampledFramebuffer=i.createFramebuffer(),te.__webglColorRenderbuffer=[],t.bindFramebuffer(36160,te.__webglMultisampledFramebuffer);for(let re=0;re<Me.length;re++){const Pe=Me[re];te.__webglColorRenderbuffer[re]=i.createRenderbuffer(),i.bindRenderbuffer(36161,te.__webglColorRenderbuffer[re]);const Re=s.convert(Pe.format,Pe.encoding),ke=s.convert(Pe.type),Ue=x(Pe.internalFormat,Re,ke,Pe.encoding,R.isXRRenderTarget===!0),Ae=lt(R);i.renderbufferStorageMultisample(36161,Ae,Ue,R.width,R.height),i.framebufferRenderbuffer(36160,36064+re,36161,te.__webglColorRenderbuffer[re])}i.bindRenderbuffer(36161,null),R.depthBuffer&&(te.__webglDepthRenderbuffer=i.createRenderbuffer(),ze(te.__webglDepthRenderbuffer,R,!0)),t.bindFramebuffer(36160,null)}}if(pe){t.bindTexture(34067,me.__webglTexture),Se(34067,T,Be);for(let Me=0;Me<6;Me++)Fe(te.__webglFramebuffer[Me],R,T,36064,34069+Me);M(T,Be)&&E(34067),t.unbindTexture()}else if(xe){const Me=R.texture;for(let re=0,Pe=Me.length;re<Pe;re++){const Re=Me[re],ke=n.get(Re);t.bindTexture(3553,ke.__webglTexture),Se(3553,Re,Be),Fe(te.__webglFramebuffer,R,Re,36064+re,3553),M(Re,Be)&&E(3553)}t.unbindTexture()}else{let Me=3553;(R.isWebGL3DRenderTarget||R.isWebGLArrayRenderTarget)&&(o?Me=R.isWebGL3DRenderTarget?32879:35866:console.error("THREE.WebGLTextures: THREE.Data3DTexture and THREE.DataArrayTexture only supported with WebGL2.")),t.bindTexture(Me,me.__webglTexture),Se(Me,T,Be),Fe(te.__webglFramebuffer,R,T,36064,Me),M(T,Be)&&E(Me),t.unbindTexture()}R.depthBuffer&&ye(R)}function ot(R){const T=y(R)||o,te=R.isWebGLMultipleRenderTargets===!0?R.texture:[R.texture];for(let me=0,pe=te.length;me<pe;me++){const xe=te[me];if(M(xe,T)){const Be=R.isWebGLCubeRenderTarget?34067:3553,Me=n.get(xe).__webglTexture;t.bindTexture(Be,Me),E(Be),t.unbindTexture()}}}function Pt(R){if(o&&R.samples>0&&ct(R)===!1){const T=R.isWebGLMultipleRenderTargets?R.texture:[R.texture],te=R.width,me=R.height;let pe=16384;const xe=[],Be=R.stencilBuffer?33306:36096,Me=n.get(R),re=R.isWebGLMultipleRenderTargets===!0;if(re)for(let Pe=0;Pe<T.length;Pe++)t.bindFramebuffer(36160,Me.__webglMultisampledFramebuffer),i.framebufferRenderbuffer(36160,36064+Pe,36161,null),t.bindFramebuffer(36160,Me.__webglFramebuffer),i.framebufferTexture2D(36009,36064+Pe,3553,null,0);t.bindFramebuffer(36008,Me.__webglMultisampledFramebuffer),t.bindFramebuffer(36009,Me.__webglFramebuffer);for(let Pe=0;Pe<T.length;Pe++){xe.push(36064+Pe),R.depthBuffer&&xe.push(Be);const Re=Me.__ignoreDepthValues!==void 0?Me.__ignoreDepthValues:!1;if(Re===!1&&(R.depthBuffer&&(pe|=256),R.stencilBuffer&&(pe|=1024)),re&&i.framebufferRenderbuffer(36008,36064,36161,Me.__webglColorRenderbuffer[Pe]),Re===!0&&(i.invalidateFramebuffer(36008,[Be]),i.invalidateFramebuffer(36009,[Be])),re){const ke=n.get(T[Pe]).__webglTexture;i.framebufferTexture2D(36009,36064,3553,ke,0)}i.blitFramebuffer(0,0,te,me,0,0,te,me,pe,9728),p&&i.invalidateFramebuffer(36008,xe)}if(t.bindFramebuffer(36008,null),t.bindFramebuffer(36009,null),re)for(let Pe=0;Pe<T.length;Pe++){t.bindFramebuffer(36160,Me.__webglMultisampledFramebuffer),i.framebufferRenderbuffer(36160,36064+Pe,36161,Me.__webglColorRenderbuffer[Pe]);const Re=n.get(T[Pe]).__webglTexture;t.bindFramebuffer(36160,Me.__webglFramebuffer),i.framebufferTexture2D(36009,36064+Pe,3553,Re,0)}t.bindFramebuffer(36009,Me.__webglMultisampledFramebuffer)}}function lt(R){return Math.min(f,R.samples)}function ct(R){const T=n.get(R);return o&&R.samples>0&&e.has("WEBGL_multisampled_render_to_texture")===!0&&T.__useRenderToTexture!==!1}function en(R){const T=a.render.frame;m.get(R)!==T&&(m.set(R,T),R.update())}function Ft(R,T){const te=R.encoding,me=R.format,pe=R.type;return R.isCompressedTexture===!0||R.isVideoTexture===!0||R.format===da||te!==hi&&(te===pt?o===!1?e.has("EXT_sRGB")===!0&&me===gn?(R.format=da,R.minFilter=fn,R.generateMipmaps=!1):T=Uc.sRGBToLinear(T):(me!==gn||pe!==di)&&console.warn("THREE.WebGLTextures: sRGB encoded textures have to use RGBAFormat and UnsignedByteType."):console.error("THREE.WebGLTextures: Unsupported texture encoding:",te)),T}this.allocateTextureUnit=$,this.resetTextureUnits=le,this.setTexture2D=ue,this.setTexture2DArray=be,this.setTexture3D=q,this.setTextureCube=ce,this.rebindTextures=Le,this.setupRenderTarget=Xe,this.updateRenderTargetMipmap=ot,this.updateMultisampleRenderTarget=Pt,this.setupDepthRenderbuffer=ye,this.setupFrameBufferTexture=Fe,this.useMultisampledRTT=ct}function r2(i,e,t){const n=t.isWebGL2;function r(s,a=null){let o;if(s===di)return 5121;if(s===Am)return 32819;if(s===Dm)return 32820;if(s===Em)return 5120;if(s===Lm)return 5122;if(s===Nc)return 5123;if(s===Pm)return 5124;if(s===li)return 5125;if(s===ci)return 5126;if(s===br)return n?5131:(o=e.get("OES_texture_half_float"),o!==null?o.HALF_FLOAT_OES:null);if(s===Rm)return 6406;if(s===gn)return 6408;if(s===km)return 6409;if(s===Im)return 6410;if(s===ui)return 6402;if(s===Gi)return 34041;if(s===da)return o=e.get("EXT_sRGB"),o!==null?o.SRGB_ALPHA_EXT:null;if(s===Nm)return 6403;if(s===zm)return 36244;if(s===Fm)return 33319;if(s===Om)return 33320;if(s===Um)return 36249;if(s===Ts||s===Es||s===Ls||s===Ps)if(a===pt)if(o=e.get("WEBGL_compressed_texture_s3tc_srgb"),o!==null){if(s===Ts)return o.COMPRESSED_SRGB_S3TC_DXT1_EXT;if(s===Es)return o.COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT;if(s===Ls)return o.COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT;if(s===Ps)return o.COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT}else return null;else if(o=e.get("WEBGL_compressed_texture_s3tc"),o!==null){if(s===Ts)return o.COMPRESSED_RGB_S3TC_DXT1_EXT;if(s===Es)return o.COMPRESSED_RGBA_S3TC_DXT1_EXT;if(s===Ls)return o.COMPRESSED_RGBA_S3TC_DXT3_EXT;if(s===Ps)return o.COMPRESSED_RGBA_S3TC_DXT5_EXT}else return null;if(s===Qo||s===$o||s===el||s===tl)if(o=e.get("WEBGL_compressed_texture_pvrtc"),o!==null){if(s===Qo)return o.COMPRESSED_RGB_PVRTC_4BPPV1_IMG;if(s===$o)return o.COMPRESSED_RGB_PVRTC_2BPPV1_IMG;if(s===el)return o.COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;if(s===tl)return o.COMPRESSED_RGBA_PVRTC_2BPPV1_IMG}else return null;if(s===Bm)return o=e.get("WEBGL_compressed_texture_etc1"),o!==null?o.COMPRESSED_RGB_ETC1_WEBGL:null;if(s===nl||s===il)if(o=e.get("WEBGL_compressed_texture_etc"),o!==null){if(s===nl)return a===pt?o.COMPRESSED_SRGB8_ETC2:o.COMPRESSED_RGB8_ETC2;if(s===il)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ETC2_EAC:o.COMPRESSED_RGBA8_ETC2_EAC}else return null;if(s===rl||s===sl||s===al||s===ol||s===ll||s===cl||s===ul||s===fl||s===dl||s===hl||s===pl||s===ml||s===_l||s===gl)if(o=e.get("WEBGL_compressed_texture_astc"),o!==null){if(s===rl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR:o.COMPRESSED_RGBA_ASTC_4x4_KHR;if(s===sl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR:o.COMPRESSED_RGBA_ASTC_5x4_KHR;if(s===al)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR:o.COMPRESSED_RGBA_ASTC_5x5_KHR;if(s===ol)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR:o.COMPRESSED_RGBA_ASTC_6x5_KHR;if(s===ll)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR:o.COMPRESSED_RGBA_ASTC_6x6_KHR;if(s===cl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR:o.COMPRESSED_RGBA_ASTC_8x5_KHR;if(s===ul)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR:o.COMPRESSED_RGBA_ASTC_8x6_KHR;if(s===fl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR:o.COMPRESSED_RGBA_ASTC_8x8_KHR;if(s===dl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR:o.COMPRESSED_RGBA_ASTC_10x5_KHR;if(s===hl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR:o.COMPRESSED_RGBA_ASTC_10x6_KHR;if(s===pl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR:o.COMPRESSED_RGBA_ASTC_10x8_KHR;if(s===ml)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR:o.COMPRESSED_RGBA_ASTC_10x10_KHR;if(s===_l)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR:o.COMPRESSED_RGBA_ASTC_12x10_KHR;if(s===gl)return a===pt?o.COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR:o.COMPRESSED_RGBA_ASTC_12x12_KHR}else return null;if(s===As)if(o=e.get("EXT_texture_compression_bptc"),o!==null){if(s===As)return a===pt?o.COMPRESSED_SRGB_ALPHA_BPTC_UNORM_EXT:o.COMPRESSED_RGBA_BPTC_UNORM_EXT}else return null;if(s===Vm||s===bl||s===vl||s===yl)if(o=e.get("EXT_texture_compression_rgtc"),o!==null){if(s===As)return o.COMPRESSED_RED_RGTC1_EXT;if(s===bl)return o.COMPRESSED_SIGNED_RED_RGTC1_EXT;if(s===vl)return o.COMPRESSED_RED_GREEN_RGTC2_EXT;if(s===yl)return o.COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT}else return null;return s===zi?n?34042:(o=e.get("WEBGL_depth_texture"),o!==null?o.UNSIGNED_INT_24_8_WEBGL:null):i[s]!==void 0?i[s]:null}return{convert:r}}class s2 extends dn{constructor(e=[]){super(),this.isArrayCamera=!0,this.cameras=e}}class qr extends zt{constructor(){super(),this.isGroup=!0,this.type="Group"}}const a2={type:"move"};class ea{constructor(){this._targetRay=null,this._grip=null,this._hand=null}getHandSpace(){return this._hand===null&&(this._hand=new qr,this._hand.matrixAutoUpdate=!1,this._hand.visible=!1,this._hand.joints={},this._hand.inputState={pinching:!1}),this._hand}getTargetRaySpace(){return this._targetRay===null&&(this._targetRay=new qr,this._targetRay.matrixAutoUpdate=!1,this._targetRay.visible=!1,this._targetRay.hasLinearVelocity=!1,this._targetRay.linearVelocity=new B,this._targetRay.hasAngularVelocity=!1,this._targetRay.angularVelocity=new B),this._targetRay}getGripSpace(){return this._grip===null&&(this._grip=new qr,this._grip.matrixAutoUpdate=!1,this._grip.visible=!1,this._grip.hasLinearVelocity=!1,this._grip.linearVelocity=new B,this._grip.hasAngularVelocity=!1,this._grip.angularVelocity=new B),this._grip}dispatchEvent(e){return this._targetRay!==null&&this._targetRay.dispatchEvent(e),this._grip!==null&&this._grip.dispatchEvent(e),this._hand!==null&&this._hand.dispatchEvent(e),this}connect(e){if(e&&e.hand){const t=this._hand;if(t)for(const n of e.hand.values())this._getHandJoint(t,n)}return this.dispatchEvent({type:"connected",data:e}),this}disconnect(e){return this.dispatchEvent({type:"disconnected",data:e}),this._targetRay!==null&&(this._targetRay.visible=!1),this._grip!==null&&(this._grip.visible=!1),this._hand!==null&&(this._hand.visible=!1),this}update(e,t,n){let r=null,s=null,a=null;const o=this._targetRay,l=this._grip,c=this._hand;if(e&&t.session.visibilityState!=="visible-blurred"){if(c&&e.hand){a=!0;for(const h of e.hand.values()){const _=t.getJointPose(h,n),g=this._getHandJoint(c,h);_!==null&&(g.matrix.fromArray(_.transform.matrix),g.matrix.decompose(g.position,g.rotation,g.scale),g.jointRadius=_.radius),g.visible=_!==null}const u=c.joints["index-finger-tip"],f=c.joints["thumb-tip"],d=u.position.distanceTo(f.position),p=.02,m=.005;c.inputState.pinching&&d>p+m?(c.inputState.pinching=!1,this.dispatchEvent({type:"pinchend",handedness:e.handedness,target:this})):!c.inputState.pinching&&d<=p-m&&(c.inputState.pinching=!0,this.dispatchEvent({type:"pinchstart",handedness:e.handedness,target:this}))}else l!==null&&e.gripSpace&&(s=t.getPose(e.gripSpace,n),s!==null&&(l.matrix.fromArray(s.transform.matrix),l.matrix.decompose(l.position,l.rotation,l.scale),s.linearVelocity?(l.hasLinearVelocity=!0,l.linearVelocity.copy(s.linearVelocity)):l.hasLinearVelocity=!1,s.angularVelocity?(l.hasAngularVelocity=!0,l.angularVelocity.copy(s.angularVelocity)):l.hasAngularVelocity=!1));o!==null&&(r=t.getPose(e.targetRaySpace,n),r===null&&s!==null&&(r=s),r!==null&&(o.matrix.fromArray(r.transform.matrix),o.matrix.decompose(o.position,o.rotation,o.scale),r.linearVelocity?(o.hasLinearVelocity=!0,o.linearVelocity.copy(r.linearVelocity)):o.hasLinearVelocity=!1,r.angularVelocity?(o.hasAngularVelocity=!0,o.angularVelocity.copy(r.angularVelocity)):o.hasAngularVelocity=!1,this.dispatchEvent(a2)))}return o!==null&&(o.visible=r!==null),l!==null&&(l.visible=s!==null),c!==null&&(c.visible=a!==null),this}_getHandJoint(e,t){if(e.joints[t.jointName]===void 0){const n=new qr;n.matrixAutoUpdate=!1,n.visible=!1,e.joints[t.jointName]=n,e.add(n)}return e.joints[t.jointName]}}class o2 extends on{constructor(e,t,n,r,s,a,o,l,c,u){if(u=u!==void 0?u:ui,u!==ui&&u!==Gi)throw new Error("DepthTexture format must be either THREE.DepthFormat or THREE.DepthStencilFormat");n===void 0&&u===ui&&(n=li),n===void 0&&u===Gi&&(n=zi),super(null,r,s,a,o,l,u,n,c),this.isDepthTexture=!0,this.image={width:e,height:t},this.magFilter=o!==void 0?o:jt,this.minFilter=l!==void 0?l:jt,this.flipY=!1,this.generateMipmaps=!1}}class l2 extends Wi{constructor(e,t){super();const n=this;let r=null,s=1,a=null,o="local-floor",l=1,c=null,u=null,f=null,d=null,p=null,m=null;const h=t.getContextAttributes();let _=null,g=null;const v=[],b=[],y=new Set,w=new Map,M=new dn;M.layers.enable(1),M.viewport=new Nt;const E=new dn;E.layers.enable(2),E.viewport=new Nt;const x=[M,E],C=new s2;C.layers.enable(1),C.layers.enable(2);let A=null,D=null;this.cameraAutoUpdate=!0,this.enabled=!1,this.isPresenting=!1,this.getController=function(q){let ce=v[q];return ce===void 0&&(ce=new ea,v[q]=ce),ce.getTargetRaySpace()},this.getControllerGrip=function(q){let ce=v[q];return ce===void 0&&(ce=new ea,v[q]=ce),ce.getGripSpace()},this.getHand=function(q){let ce=v[q];return ce===void 0&&(ce=new ea,v[q]=ce),ce.getHandSpace()};function G(q){const ce=b.indexOf(q.inputSource);if(ce===-1)return;const he=v[ce];he!==void 0&&he.dispatchEvent({type:q.type,data:q.inputSource})}function U(){r.removeEventListener("select",G),r.removeEventListener("selectstart",G),r.removeEventListener("selectend",G),r.removeEventListener("squeeze",G),r.removeEventListener("squeezestart",G),r.removeEventListener("squeezeend",G),r.removeEventListener("end",U),r.removeEventListener("inputsourceschange",z);for(let q=0;q<v.length;q++){const ce=b[q];ce!==null&&(b[q]=null,v[q].disconnect(ce))}A=null,D=null,e.setRenderTarget(_),p=null,d=null,f=null,r=null,g=null,be.stop(),n.isPresenting=!1,n.dispatchEvent({type:"sessionend"})}this.setFramebufferScaleFactor=function(q){s=q,n.isPresenting===!0&&console.warn("THREE.WebXRManager: Cannot change framebuffer scale while presenting.")},this.setReferenceSpaceType=function(q){o=q,n.isPresenting===!0&&console.warn("THREE.WebXRManager: Cannot change reference space type while presenting.")},this.getReferenceSpace=function(){return c||a},this.setReferenceSpace=function(q){c=q},this.getBaseLayer=function(){return d!==null?d:p},this.getBinding=function(){return f},this.getFrame=function(){return m},this.getSession=function(){return r},this.setSession=async function(q){if(r=q,r!==null){if(_=e.getRenderTarget(),r.addEventListener("select",G),r.addEventListener("selectstart",G),r.addEventListener("selectend",G),r.addEventListener("squeeze",G),r.addEventListener("squeezestart",G),r.addEventListener("squeezeend",G),r.addEventListener("end",U),r.addEventListener("inputsourceschange",z),h.xrCompatible!==!0&&await t.makeXRCompatible(),r.renderState.layers===void 0||e.capabilities.isWebGL2===!1){const ce={antialias:r.renderState.layers===void 0?h.antialias:!0,alpha:h.alpha,depth:h.depth,stencil:h.stencil,framebufferScaleFactor:s};p=new XRWebGLLayer(r,t,ce),r.updateRenderState({baseLayer:p}),g=new pi(p.framebufferWidth,p.framebufferHeight,{format:gn,type:di,encoding:e.outputEncoding,stencilBuffer:h.stencil})}else{let ce=null,he=null,W=null;h.depth&&(W=h.stencil?35056:33190,ce=h.stencil?Gi:ui,he=h.stencil?zi:li);const Se={colorFormat:32856,depthFormat:W,scaleFactor:s};f=new XRWebGLBinding(r,t),d=f.createProjectionLayer(Se),r.updateRenderState({layers:[d]}),g=new pi(d.textureWidth,d.textureHeight,{format:gn,type:di,depthTexture:new o2(d.textureWidth,d.textureHeight,he,void 0,void 0,void 0,void 0,void 0,void 0,ce),stencilBuffer:h.stencil,encoding:e.outputEncoding,samples:h.antialias?4:0});const we=e.properties.get(g);we.__ignoreDepthValues=d.ignoreDepthValues}g.isXRRenderTarget=!0,this.setFoveation(l),c=null,a=await r.requestReferenceSpace(o),be.setContext(r),be.start(),n.isPresenting=!0,n.dispatchEvent({type:"sessionstart"})}};function z(q){for(let ce=0;ce<q.removed.length;ce++){const he=q.removed[ce],W=b.indexOf(he);W>=0&&(b[W]=null,v[W].disconnect(he))}for(let ce=0;ce<q.added.length;ce++){const he=q.added[ce];let W=b.indexOf(he);if(W===-1){for(let we=0;we<v.length;we++)if(we>=b.length){b.push(he),W=we;break}else if(b[we]===null){b[we]=he,W=we;break}if(W===-1)break}const Se=v[W];Se&&Se.connect(he)}}const X=new B,ae=new B;function le(q,ce,he){X.setFromMatrixPosition(ce.matrixWorld),ae.setFromMatrixPosition(he.matrixWorld);const W=X.distanceTo(ae),Se=ce.projectionMatrix.elements,we=he.projectionMatrix.elements,Ee=Se[14]/(Se[10]-1),Ce=Se[14]/(Se[10]+1),Fe=(Se[9]+1)/Se[5],ze=(Se[9]-1)/Se[5],oe=(Se[8]-1)/Se[0],ye=(we[8]+1)/we[0],Le=Ee*oe,Xe=Ee*ye,ot=W/(-oe+ye),Pt=ot*-oe;ce.matrixWorld.decompose(q.position,q.quaternion,q.scale),q.translateX(Pt),q.translateZ(ot),q.matrixWorld.compose(q.position,q.quaternion,q.scale),q.matrixWorldInverse.copy(q.matrixWorld).invert();const lt=Ee+ot,ct=Ce+ot,en=Le-Pt,Ft=Xe+(W-Pt),R=Fe*Ce/ct*lt,T=ze*Ce/ct*lt;q.projectionMatrix.makePerspective(en,Ft,R,T,lt,ct)}function $(q,ce){ce===null?q.matrixWorld.copy(q.matrix):q.matrixWorld.multiplyMatrices(ce.matrixWorld,q.matrix),q.matrixWorldInverse.copy(q.matrixWorld).invert()}this.updateCamera=function(q){if(r===null)return;C.near=E.near=M.near=q.near,C.far=E.far=M.far=q.far,(A!==C.near||D!==C.far)&&(r.updateRenderState({depthNear:C.near,depthFar:C.far}),A=C.near,D=C.far);const ce=q.parent,he=C.cameras;$(C,ce);for(let Se=0;Se<he.length;Se++)$(he[Se],ce);C.matrixWorld.decompose(C.position,C.quaternion,C.scale),q.matrix.copy(C.matrix),q.matrix.decompose(q.position,q.quaternion,q.scale);const W=q.children;for(let Se=0,we=W.length;Se<we;Se++)W[Se].updateMatrixWorld(!0);he.length===2?le(C,M,E):C.projectionMatrix.copy(M.projectionMatrix)},this.getCamera=function(){return C},this.getFoveation=function(){if(!(d===null&&p===null))return l},this.setFoveation=function(q){l=q,d!==null&&(d.fixedFoveation=q),p!==null&&p.fixedFoveation!==void 0&&(p.fixedFoveation=q)},this.getPlanes=function(){return y};let ne=null;function ue(q,ce){if(u=ce.getViewerPose(c||a),m=ce,u!==null){const he=u.views;p!==null&&(e.setRenderTargetFramebuffer(g,p.framebuffer),e.setRenderTarget(g));let W=!1;he.length!==C.cameras.length&&(C.cameras.length=0,W=!0);for(let Se=0;Se<he.length;Se++){const we=he[Se];let Ee=null;if(p!==null)Ee=p.getViewport(we);else{const Fe=f.getViewSubImage(d,we);Ee=Fe.viewport,Se===0&&(e.setRenderTargetTextures(g,Fe.colorTexture,d.ignoreDepthValues?void 0:Fe.depthStencilTexture),e.setRenderTarget(g))}let Ce=x[Se];Ce===void 0&&(Ce=new dn,Ce.layers.enable(Se),Ce.viewport=new Nt,x[Se]=Ce),Ce.matrix.fromArray(we.transform.matrix),Ce.projectionMatrix.fromArray(we.projectionMatrix),Ce.viewport.set(Ee.x,Ee.y,Ee.width,Ee.height),Se===0&&C.matrix.copy(Ce.matrix),W===!0&&C.cameras.push(Ce)}}for(let he=0;he<v.length;he++){const W=b[he],Se=v[he];W!==null&&Se!==void 0&&Se.update(W,ce,c||a)}if(ne&&ne(q,ce),ce.detectedPlanes){n.dispatchEvent({type:"planesdetected",data:ce.detectedPlanes});let he=null;for(const W of y)ce.detectedPlanes.has(W)||(he===null&&(he=[]),he.push(W));if(he!==null)for(const W of he)y.delete(W),w.delete(W),n.dispatchEvent({type:"planeremoved",data:W});for(const W of ce.detectedPlanes)if(!y.has(W))y.add(W),w.set(W,ce.lastChangedTime),n.dispatchEvent({type:"planeadded",data:W});else{const Se=w.get(W);W.lastChangedTime>Se&&(w.set(W,W.lastChangedTime),n.dispatchEvent({type:"planechanged",data:W}))}}m=null}const be=new Zc;be.setAnimationLoop(ue),this.setAnimationLoop=function(q){ne=q},this.dispose=function(){}}}function c2(i,e){function t(h,_){_.color.getRGB(h.fogColor.value,Xc(i)),_.isFog?(h.fogNear.value=_.near,h.fogFar.value=_.far):_.isFogExp2&&(h.fogDensity.value=_.density)}function n(h,_,g,v,b){_.isMeshBasicMaterial||_.isMeshLambertMaterial?r(h,_):_.isMeshToonMaterial?(r(h,_),u(h,_)):_.isMeshPhongMaterial?(r(h,_),c(h,_)):_.isMeshStandardMaterial?(r(h,_),f(h,_),_.isMeshPhysicalMaterial&&d(h,_,b)):_.isMeshMatcapMaterial?(r(h,_),p(h,_)):_.isMeshDepthMaterial?r(h,_):_.isMeshDistanceMaterial?(r(h,_),m(h,_)):_.isMeshNormalMaterial?r(h,_):_.isLineBasicMaterial?(s(h,_),_.isLineDashedMaterial&&a(h,_)):_.isPointsMaterial?o(h,_,g,v):_.isSpriteMaterial?l(h,_):_.isShadowMaterial?(h.color.value.copy(_.color),h.opacity.value=_.opacity):_.isShaderMaterial&&(_.uniformsNeedUpdate=!1)}function r(h,_){h.opacity.value=_.opacity,_.color&&h.diffuse.value.copy(_.color),_.emissive&&h.emissive.value.copy(_.emissive).multiplyScalar(_.emissiveIntensity),_.map&&(h.map.value=_.map),_.alphaMap&&(h.alphaMap.value=_.alphaMap),_.bumpMap&&(h.bumpMap.value=_.bumpMap,h.bumpScale.value=_.bumpScale,_.side===an&&(h.bumpScale.value*=-1)),_.displacementMap&&(h.displacementMap.value=_.displacementMap,h.displacementScale.value=_.displacementScale,h.displacementBias.value=_.displacementBias),_.emissiveMap&&(h.emissiveMap.value=_.emissiveMap),_.normalMap&&(h.normalMap.value=_.normalMap,h.normalScale.value.copy(_.normalScale),_.side===an&&h.normalScale.value.negate()),_.specularMap&&(h.specularMap.value=_.specularMap),_.alphaTest>0&&(h.alphaTest.value=_.alphaTest);const g=e.get(_).envMap;if(g&&(h.envMap.value=g,h.flipEnvMap.value=g.isCubeTexture&&g.isRenderTargetTexture===!1?-1:1,h.reflectivity.value=_.reflectivity,h.ior.value=_.ior,h.refractionRatio.value=_.refractionRatio),_.lightMap){h.lightMap.value=_.lightMap;const y=i.useLegacyLights===!0?Math.PI:1;h.lightMapIntensity.value=_.lightMapIntensity*y}_.aoMap&&(h.aoMap.value=_.aoMap,h.aoMapIntensity.value=_.aoMapIntensity);let v;_.map?v=_.map:_.specularMap?v=_.specularMap:_.displacementMap?v=_.displacementMap:_.normalMap?v=_.normalMap:_.bumpMap?v=_.bumpMap:_.roughnessMap?v=_.roughnessMap:_.metalnessMap?v=_.metalnessMap:_.alphaMap?v=_.alphaMap:_.emissiveMap?v=_.emissiveMap:_.clearcoatMap?v=_.clearcoatMap:_.clearcoatNormalMap?v=_.clearcoatNormalMap:_.clearcoatRoughnessMap?v=_.clearcoatRoughnessMap:_.iridescenceMap?v=_.iridescenceMap:_.iridescenceThicknessMap?v=_.iridescenceThicknessMap:_.specularIntensityMap?v=_.specularIntensityMap:_.specularColorMap?v=_.specularColorMap:_.transmissionMap?v=_.transmissionMap:_.thicknessMap?v=_.thicknessMap:_.sheenColorMap?v=_.sheenColorMap:_.sheenRoughnessMap&&(v=_.sheenRoughnessMap),v!==void 0&&(v.isWebGLRenderTarget&&(v=v.texture),v.matrixAutoUpdate===!0&&v.updateMatrix(),h.uvTransform.value.copy(v.matrix));let b;_.aoMap?b=_.aoMap:_.lightMap&&(b=_.lightMap),b!==void 0&&(b.isWebGLRenderTarget&&(b=b.texture),b.matrixAutoUpdate===!0&&b.updateMatrix(),h.uv2Transform.value.copy(b.matrix))}function s(h,_){h.diffuse.value.copy(_.color),h.opacity.value=_.opacity}function a(h,_){h.dashSize.value=_.dashSize,h.totalSize.value=_.dashSize+_.gapSize,h.scale.value=_.scale}function o(h,_,g,v){h.diffuse.value.copy(_.color),h.opacity.value=_.opacity,h.size.value=_.size*g,h.scale.value=v*.5,_.map&&(h.map.value=_.map),_.alphaMap&&(h.alphaMap.value=_.alphaMap),_.alphaTest>0&&(h.alphaTest.value=_.alphaTest);let b;_.map?b=_.map:_.alphaMap&&(b=_.alphaMap),b!==void 0&&(b.matrixAutoUpdate===!0&&b.updateMatrix(),h.uvTransform.value.copy(b.matrix))}function l(h,_){h.diffuse.value.copy(_.color),h.opacity.value=_.opacity,h.rotation.value=_.rotation,_.map&&(h.map.value=_.map),_.alphaMap&&(h.alphaMap.value=_.alphaMap),_.alphaTest>0&&(h.alphaTest.value=_.alphaTest);let g;_.map?g=_.map:_.alphaMap&&(g=_.alphaMap),g!==void 0&&(g.matrixAutoUpdate===!0&&g.updateMatrix(),h.uvTransform.value.copy(g.matrix))}function c(h,_){h.specular.value.copy(_.specular),h.shininess.value=Math.max(_.shininess,1e-4)}function u(h,_){_.gradientMap&&(h.gradientMap.value=_.gradientMap)}function f(h,_){h.roughness.value=_.roughness,h.metalness.value=_.metalness,_.roughnessMap&&(h.roughnessMap.value=_.roughnessMap),_.metalnessMap&&(h.metalnessMap.value=_.metalnessMap),e.get(_).envMap&&(h.envMapIntensity.value=_.envMapIntensity)}function d(h,_,g){h.ior.value=_.ior,_.sheen>0&&(h.sheenColor.value.copy(_.sheenColor).multiplyScalar(_.sheen),h.sheenRoughness.value=_.sheenRoughness,_.sheenColorMap&&(h.sheenColorMap.value=_.sheenColorMap),_.sheenRoughnessMap&&(h.sheenRoughnessMap.value=_.sheenRoughnessMap)),_.clearcoat>0&&(h.clearcoat.value=_.clearcoat,h.clearcoatRoughness.value=_.clearcoatRoughness,_.clearcoatMap&&(h.clearcoatMap.value=_.clearcoatMap),_.clearcoatRoughnessMap&&(h.clearcoatRoughnessMap.value=_.clearcoatRoughnessMap),_.clearcoatNormalMap&&(h.clearcoatNormalScale.value.copy(_.clearcoatNormalScale),h.clearcoatNormalMap.value=_.clearcoatNormalMap,_.side===an&&h.clearcoatNormalScale.value.negate())),_.iridescence>0&&(h.iridescence.value=_.iridescence,h.iridescenceIOR.value=_.iridescenceIOR,h.iridescenceThicknessMinimum.value=_.iridescenceThicknessRange[0],h.iridescenceThicknessMaximum.value=_.iridescenceThicknessRange[1],_.iridescenceMap&&(h.iridescenceMap.value=_.iridescenceMap),_.iridescenceThicknessMap&&(h.iridescenceThicknessMap.value=_.iridescenceThicknessMap)),_.transmission>0&&(h.transmission.value=_.transmission,h.transmissionSamplerMap.value=g.texture,h.transmissionSamplerSize.value.set(g.width,g.height),_.transmissionMap&&(h.transmissionMap.value=_.transmissionMap),h.thickness.value=_.thickness,_.thicknessMap&&(h.thicknessMap.value=_.thicknessMap),h.attenuationDistance.value=_.attenuationDistance,h.attenuationColor.value.copy(_.attenuationColor)),h.specularIntensity.value=_.specularIntensity,h.specularColor.value.copy(_.specularColor),_.specularIntensityMap&&(h.specularIntensityMap.value=_.specularIntensityMap),_.specularColorMap&&(h.specularColorMap.value=_.specularColorMap)}function p(h,_){_.matcap&&(h.matcap.value=_.matcap)}function m(h,_){h.referencePosition.value.copy(_.referencePosition),h.nearDistance.value=_.nearDistance,h.farDistance.value=_.farDistance}return{refreshFogUniforms:t,refreshMaterialUniforms:n}}function u2(i,e,t,n){let r={},s={},a=[];const o=t.isWebGL2?i.getParameter(35375):0;function l(v,b){const y=b.program;n.uniformBlockBinding(v,y)}function c(v,b){let y=r[v.id];y===void 0&&(m(v),y=u(v),r[v.id]=y,v.addEventListener("dispose",_));const w=b.program;n.updateUBOMapping(v,w);const M=e.render.frame;s[v.id]!==M&&(d(v),s[v.id]=M)}function u(v){const b=f();v.__bindingPointIndex=b;const y=i.createBuffer(),w=v.__size,M=v.usage;return i.bindBuffer(35345,y),i.bufferData(35345,w,M),i.bindBuffer(35345,null),i.bindBufferBase(35345,b,y),y}function f(){for(let v=0;v<o;v++)if(a.indexOf(v)===-1)return a.push(v),v;return console.error("THREE.WebGLRenderer: Maximum number of simultaneously usable uniforms groups reached."),0}function d(v){const b=r[v.id],y=v.uniforms,w=v.__cache;i.bindBuffer(35345,b);for(let M=0,E=y.length;M<E;M++){const x=y[M];if(p(x,M,w)===!0){const C=x.__offset,A=Array.isArray(x.value)?x.value:[x.value];let D=0;for(let G=0;G<A.length;G++){const U=A[G],z=h(U);typeof U=="number"?(x.__data[0]=U,i.bufferSubData(35345,C+D,x.__data)):U.isMatrix3?(x.__data[0]=U.elements[0],x.__data[1]=U.elements[1],x.__data[2]=U.elements[2],x.__data[3]=U.elements[0],x.__data[4]=U.elements[3],x.__data[5]=U.elements[4],x.__data[6]=U.elements[5],x.__data[7]=U.elements[0],x.__data[8]=U.elements[6],x.__data[9]=U.elements[7],x.__data[10]=U.elements[8],x.__data[11]=U.elements[0]):(U.toArray(x.__data,D),D+=z.storage/Float32Array.BYTES_PER_ELEMENT)}i.bufferSubData(35345,C,x.__data)}}i.bindBuffer(35345,null)}function p(v,b,y){const w=v.value;if(y[b]===void 0){if(typeof w=="number")y[b]=w;else{const M=Array.isArray(w)?w:[w],E=[];for(let x=0;x<M.length;x++)E.push(M[x].clone());y[b]=E}return!0}else if(typeof w=="number"){if(y[b]!==w)return y[b]=w,!0}else{const M=Array.isArray(y[b])?y[b]:[y[b]],E=Array.isArray(w)?w:[w];for(let x=0;x<M.length;x++){const C=M[x];if(C.equals(E[x])===!1)return C.copy(E[x]),!0}}return!1}function m(v){const b=v.uniforms;let y=0;const w=16;let M=0;for(let E=0,x=b.length;E<x;E++){const C=b[E],A={boundary:0,storage:0},D=Array.isArray(C.value)?C.value:[C.value];for(let G=0,U=D.length;G<U;G++){const z=D[G],X=h(z);A.boundary+=X.boundary,A.storage+=X.storage}if(C.__data=new Float32Array(A.storage/Float32Array.BYTES_PER_ELEMENT),C.__offset=y,E>0){M=y%w;const G=w-M;M!==0&&G-A.boundary<0&&(y+=w-M,C.__offset=y)}y+=A.storage}return M=y%w,M>0&&(y+=w-M),v.__size=y,v.__cache={},this}function h(v){const b={boundary:0,storage:0};return typeof v=="number"?(b.boundary=4,b.storage=4):v.isVector2?(b.boundary=8,b.storage=8):v.isVector3||v.isColor?(b.boundary=16,b.storage=12):v.isVector4?(b.boundary=16,b.storage=16):v.isMatrix3?(b.boundary=48,b.storage=48):v.isMatrix4?(b.boundary=64,b.storage=64):v.isTexture?console.warn("THREE.WebGLRenderer: Texture samplers can not be part of an uniforms group."):console.warn("THREE.WebGLRenderer: Unsupported uniform value type.",v),b}function _(v){const b=v.target;b.removeEventListener("dispose",_);const y=a.indexOf(b.__bindingPointIndex);a.splice(y,1),i.deleteBuffer(r[b.id]),delete r[b.id],delete s[b.id]}function g(){for(const v in r)i.deleteBuffer(r[v]);a=[],r={},s={}}return{bind:l,update:c,dispose:g}}function f2(){const i=fs("canvas");return i.style.display="block",i}function Ca(i={}){this.isWebGLRenderer=!0;const e=i.canvas!==void 0?i.canvas:f2(),t=i.context!==void 0?i.context:null,n=i.depth!==void 0?i.depth:!0,r=i.stencil!==void 0?i.stencil:!0,s=i.antialias!==void 0?i.antialias:!1,a=i.premultipliedAlpha!==void 0?i.premultipliedAlpha:!0,o=i.preserveDrawingBuffer!==void 0?i.preserveDrawingBuffer:!1,l=i.powerPreference!==void 0?i.powerPreference:"default",c=i.failIfMajorPerformanceCaveat!==void 0?i.failIfMajorPerformanceCaveat:!1;let u;t!==null?u=t.getContextAttributes().alpha:u=i.alpha!==void 0?i.alpha:!1;let f=null,d=null;const p=[],m=[];this.domElement=e,this.debug={checkShaderErrors:!0},this.autoClear=!0,this.autoClearColor=!0,this.autoClearDepth=!0,this.autoClearStencil=!0,this.sortObjects=!0,this.clippingPlanes=[],this.localClippingEnabled=!1,this.outputEncoding=hi,this.useLegacyLights=!0,this.toneMapping=Un,this.toneMappingExposure=1;const h=this;let _=!1,g=0,v=0,b=null,y=-1,w=null;const M=new Nt,E=new Nt;let x=null,C=e.width,A=e.height,D=1,G=null,U=null;const z=new Nt(0,0,C,A),X=new Nt(0,0,C,A);let ae=!1;const le=new Yc;let $=!1,ne=!1,ue=null;const be=new Tt,q=new B,ce={background:null,fog:null,environment:null,overrideMaterial:null,isScene:!0};function he(){return b===null?D:1}let W=t;function Se(P,j){for(let ee=0;ee<P.length;ee++){const H=P[ee],se=e.getContext(H,j);if(se!==null)return se}return null}try{const P={alpha:!0,depth:n,stencil:r,antialias:s,premultipliedAlpha:a,preserveDrawingBuffer:o,powerPreference:l,failIfMajorPerformanceCaveat:c};if("setAttribute"in e&&e.setAttribute("data-engine",`three.js r${ya}`),e.addEventListener("webglcontextlost",ke,!1),e.addEventListener("webglcontextrestored",Ue,!1),e.addEventListener("webglcontextcreationerror",Ae,!1),W===null){const j=["webgl2","webgl","experimental-webgl"];if(h.isWebGL1Renderer===!0&&j.shift(),W=Se(j,P),W===null)throw Se(j)?new Error("Error creating WebGL context with your selected attributes."):new Error("Error creating WebGL context.")}W.getShaderPrecisionFormat===void 0&&(W.getShaderPrecisionFormat=function(){return{rangeMin:1,rangeMax:1,precision:1}})}catch(P){throw console.error("THREE.WebGLRenderer: "+P.message),P}let we,Ee,Ce,Fe,ze,oe,ye,Le,Xe,ot,Pt,lt,ct,en,Ft,R,T,te,me,pe,xe,Be,Me,re;function Pe(){we=new x1(W),Ee=new m1(W,we,i),we.init(Ee),Be=new r2(W,we,Ee),Ce=new n2(W,we,Ee),Fe=new C1,ze=new Gb,oe=new i2(W,we,Ce,ze,Ee,Be,Fe),ye=new g1(h),Le=new w1(h),Xe=new k_(W,Ee),Me=new h1(W,we,Xe,Ee),ot=new M1(W,Xe,Fe,Me),Pt=new P1(W,ot,Xe,Fe),me=new L1(W,Ee,oe),R=new _1(ze),lt=new Vb(h,ye,Le,we,Ee,Me,R),ct=new c2(h,ze),en=new Wb,Ft=new Kb(we,Ee),te=new d1(h,ye,Le,Ce,Pt,u,a),T=new t2(h,Pt,Ee),re=new u2(W,Fe,Ee,Ce),pe=new p1(W,we,Fe,Ee),xe=new S1(W,we,Fe,Ee),Fe.programs=lt.programs,h.capabilities=Ee,h.extensions=we,h.properties=ze,h.renderLists=en,h.shadowMap=T,h.state=Ce,h.info=Fe}Pe();const Re=new l2(h,W);this.xr=Re,this.getContext=function(){return W},this.getContextAttributes=function(){return W.getContextAttributes()},this.forceContextLoss=function(){const P=we.get("WEBGL_lose_context");P&&P.loseContext()},this.forceContextRestore=function(){const P=we.get("WEBGL_lose_context");P&&P.restoreContext()},this.getPixelRatio=function(){return D},this.setPixelRatio=function(P){P!==void 0&&(D=P,this.setSize(C,A,!1))},this.getSize=function(P){return P.set(C,A)},this.setSize=function(P,j,ee=!0){if(Re.isPresenting){console.warn("THREE.WebGLRenderer: Can't change size while VR device is presenting.");return}C=P,A=j,e.width=Math.floor(P*D),e.height=Math.floor(j*D),ee===!0&&(e.style.width=P+"px",e.style.height=j+"px"),this.setViewport(0,0,P,j)},this.getDrawingBufferSize=function(P){return P.set(C*D,A*D).floor()},this.setDrawingBufferSize=function(P,j,ee){C=P,A=j,D=ee,e.width=Math.floor(P*ee),e.height=Math.floor(j*ee),this.setViewport(0,0,P,j)},this.getCurrentViewport=function(P){return P.copy(M)},this.getViewport=function(P){return P.copy(z)},this.setViewport=function(P,j,ee,H){P.isVector4?z.set(P.x,P.y,P.z,P.w):z.set(P,j,ee,H),Ce.viewport(M.copy(z).multiplyScalar(D).floor())},this.getScissor=function(P){return P.copy(X)},this.setScissor=function(P,j,ee,H){P.isVector4?X.set(P.x,P.y,P.z,P.w):X.set(P,j,ee,H),Ce.scissor(E.copy(X).multiplyScalar(D).floor())},this.getScissorTest=function(){return ae},this.setScissorTest=function(P){Ce.setScissorTest(ae=P)},this.setOpaqueSort=function(P){G=P},this.setTransparentSort=function(P){U=P},this.getClearColor=function(P){return P.copy(te.getClearColor())},this.setClearColor=function(){te.setClearColor.apply(te,arguments)},this.getClearAlpha=function(){return te.getClearAlpha()},this.setClearAlpha=function(){te.setClearAlpha.apply(te,arguments)},this.clear=function(P=!0,j=!0,ee=!0){let H=0;P&&(H|=16384),j&&(H|=256),ee&&(H|=1024),W.clear(H)},this.clearColor=function(){this.clear(!0,!1,!1)},this.clearDepth=function(){this.clear(!1,!0,!1)},this.clearStencil=function(){this.clear(!1,!1,!0)},this.dispose=function(){e.removeEventListener("webglcontextlost",ke,!1),e.removeEventListener("webglcontextrestored",Ue,!1),e.removeEventListener("webglcontextcreationerror",Ae,!1),en.dispose(),Ft.dispose(),ze.dispose(),ye.dispose(),Le.dispose(),Pt.dispose(),Me.dispose(),re.dispose(),lt.dispose(),Re.dispose(),Re.removeEventListener("sessionstart",fe),Re.removeEventListener("sessionend",De),ue&&(ue.dispose(),ue=null),Ie.stop()};function ke(P){P.preventDefault(),console.log("THREE.WebGLRenderer: Context Lost."),_=!0}function Ue(){console.log("THREE.WebGLRenderer: Context Restored."),_=!1;const P=Fe.autoReset,j=T.enabled,ee=T.autoUpdate,H=T.needsUpdate,se=T.type;Pe(),Fe.autoReset=P,T.enabled=j,T.autoUpdate=ee,T.needsUpdate=H,T.type=se}function Ae(P){console.error("THREE.WebGLRenderer: A WebGL context could not be created. Reason: ",P.statusMessage)}function _e(P){const j=P.target;j.removeEventListener("dispose",_e),je(j)}function je(P){He(P),ze.remove(P)}function He(P){const j=ze.get(P).programs;j!==void 0&&(j.forEach(function(ee){lt.releaseProgram(ee)}),P.isShaderMaterial&&lt.releaseShaderCache(P))}this.renderBufferDirect=function(P,j,ee,H,se,We){j===null&&(j=ce);const Ke=se.isMesh&&se.matrixWorld.determinant()<0,Qe=tu(P,j,ee,H,se);Ce.setMaterial(H,Ke);let $e=ee.index,rt=1;H.wireframe===!0&&($e=ot.getWireframeAttribute(ee),rt=2);const et=ee.drawRange,tt=ee.attributes.position;let xt=et.start*rt,tn=(et.start+et.count)*rt;We!==null&&(xt=Math.max(xt,We.start*rt),tn=Math.min(tn,(We.start+We.count)*rt)),$e!==null?(xt=Math.max(xt,0),tn=Math.min(tn,$e.count)):tt!=null&&(xt=Math.max(xt,0),tn=Math.min(tn,tt.count));const En=tn-xt;if(En<0||En===1/0)return;Me.setup(se,H,Qe,ee,$e);let Kn,Mt=pe;if($e!==null&&(Kn=Xe.get($e),Mt=xe,Mt.setIndex(Kn)),se.isMesh)H.wireframe===!0?(Ce.setLineWidth(H.wireframeLinewidth*he()),Mt.setMode(1)):Mt.setMode(4);else if(se.isLine){let nt=H.linewidth;nt===void 0&&(nt=1),Ce.setLineWidth(nt*he()),se.isLineSegments?Mt.setMode(1):se.isLineLoop?Mt.setMode(2):Mt.setMode(3)}else se.isPoints?Mt.setMode(0):se.isSprite&&Mt.setMode(4);if(se.isInstancedMesh)Mt.renderInstances(xt,En,se.count);else if(ee.isInstancedBufferGeometry){const nt=ee._maxInstanceCount!==void 0?ee._maxInstanceCount:1/0,vs=Math.min(ee.instanceCount,nt);Mt.renderInstances(xt,En,vs)}else Mt.render(xt,En)},this.compile=function(P,j){function ee(H,se,We){H.transparent===!0&&H.side===zn&&H.forceSinglePass===!1?(H.side=an,H.needsUpdate=!0,cn(H,se,We),H.side=Zn,H.needsUpdate=!0,cn(H,se,We),H.side=zn):cn(H,se,We)}d=Ft.get(P),d.init(),m.push(d),P.traverseVisible(function(H){H.isLight&&H.layers.test(j.layers)&&(d.pushLight(H),H.castShadow&&d.pushShadow(H))}),d.setupLights(h.useLegacyLights),P.traverse(function(H){const se=H.material;if(se)if(Array.isArray(se))for(let We=0;We<se.length;We++){const Ke=se[We];ee(Ke,P,H)}else ee(se,P,H)}),m.pop(),d=null};let V=null;function ie(P){V&&V(P)}function fe(){Ie.stop()}function De(){Ie.start()}const Ie=new Zc;Ie.setAnimationLoop(ie),typeof self<"u"&&Ie.setContext(self),this.setAnimationLoop=function(P){V=P,Re.setAnimationLoop(P),P===null?Ie.stop():Ie.start()},Re.addEventListener("sessionstart",fe),Re.addEventListener("sessionend",De),this.render=function(P,j){if(j!==void 0&&j.isCamera!==!0){console.error("THREE.WebGLRenderer.render: camera is not an instance of THREE.Camera.");return}if(_===!0)return;P.matrixWorldAutoUpdate===!0&&P.updateMatrixWorld(),j.parent===null&&j.matrixWorldAutoUpdate===!0&&j.updateMatrixWorld(),Re.enabled===!0&&Re.isPresenting===!0&&(Re.cameraAutoUpdate===!0&&Re.updateCamera(j),j=Re.getCamera()),P.isScene===!0&&P.onBeforeRender(h,P,j,b),d=Ft.get(P,m.length),d.init(),m.push(d),be.multiplyMatrices(j.projectionMatrix,j.matrixWorldInverse),le.setFromProjectionMatrix(be),ne=this.localClippingEnabled,$=R.init(this.clippingPlanes,ne),f=en.get(P,p.length),f.init(),p.push(f),ht(P,j,0,h.sortObjects),f.finish(),h.sortObjects===!0&&f.sort(G,U),$===!0&&R.beginShadows();const ee=d.state.shadowsArray;if(T.render(ee,P,j),$===!0&&R.endShadows(),this.info.autoReset===!0&&this.info.reset(),te.render(f,P),d.setupLights(h.useLegacyLights),j.isArrayCamera){const H=j.cameras;for(let se=0,We=H.length;se<We;se++){const Ke=H[se];At(f,P,Ke,Ke.viewport)}}else At(f,P,j);b!==null&&(oe.updateMultisampleRenderTarget(b),oe.updateRenderTargetMipmap(b)),P.isScene===!0&&P.onAfterRender(h,P,j),Me.resetDefaultState(),y=-1,w=null,m.pop(),m.length>0?d=m[m.length-1]:d=null,p.pop(),p.length>0?f=p[p.length-1]:f=null};function ht(P,j,ee,H){if(P.visible===!1)return;if(P.layers.test(j.layers)){if(P.isGroup)ee=P.renderOrder;else if(P.isLOD)P.autoUpdate===!0&&P.update(j);else if(P.isLight)d.pushLight(P),P.castShadow&&d.pushShadow(P);else if(P.isSprite){if(!P.frustumCulled||le.intersectsSprite(P)){H&&q.setFromMatrixPosition(P.matrixWorld).applyMatrix4(be);const Ke=Pt.update(P),Qe=P.material;Qe.visible&&f.push(P,Ke,Qe,ee,q.z,null)}}else if((P.isMesh||P.isLine||P.isPoints)&&(P.isSkinnedMesh&&P.skeleton.frame!==Fe.render.frame&&(P.skeleton.update(),P.skeleton.frame=Fe.render.frame),!P.frustumCulled||le.intersectsObject(P))){H&&q.setFromMatrixPosition(P.matrixWorld).applyMatrix4(be);const Ke=Pt.update(P),Qe=P.material;if(Array.isArray(Qe)){const $e=Ke.groups;for(let rt=0,et=$e.length;rt<et;rt++){const tt=$e[rt],xt=Qe[tt.materialIndex];xt&&xt.visible&&f.push(P,Ke,xt,ee,q.z,tt)}}else Qe.visible&&f.push(P,Ke,Qe,ee,q.z,null)}}const We=P.children;for(let Ke=0,Qe=We.length;Ke<Qe;Ke++)ht(We[Ke],j,ee,H)}function At(P,j,ee,H){const se=P.opaque,We=P.transmissive,Ke=P.transparent;d.setupLightsView(ee),$===!0&&R.setGlobalState(h.clippingPlanes,ee),We.length>0&&Gt(se,j,ee),H&&Ce.viewport(M.copy(H)),se.length>0&&vn(se,j,ee),We.length>0&&vn(We,j,ee),Ke.length>0&&vn(Ke,j,ee),Ce.buffers.depth.setTest(!0),Ce.buffers.depth.setMask(!0),Ce.buffers.color.setMask(!0),Ce.setPolygonOffset(!1)}function Gt(P,j,ee){const H=Ee.isWebGL2;ue===null&&(ue=new pi(1024,1024,{generateMipmaps:!0,type:we.has("EXT_color_buffer_half_float")?br:di,minFilter:gr,samples:H&&s===!0?4:0}));const se=h.getRenderTarget();h.setRenderTarget(ue),h.clear();const We=h.toneMapping;h.toneMapping=Un,vn(P,j,ee),h.toneMapping=We,oe.updateMultisampleRenderTarget(ue),oe.updateRenderTargetMipmap(ue),h.setRenderTarget(se)}function vn(P,j,ee){const H=j.isScene===!0?j.overrideMaterial:null;for(let se=0,We=P.length;se<We;se++){const Ke=P[se],Qe=Ke.object,$e=Ke.geometry,rt=H===null?Ke.material:H,et=Ke.group;Qe.layers.test(ee.layers)&&yt(Qe,j,ee,$e,rt,et)}}function yt(P,j,ee,H,se,We){P.onBeforeRender(h,j,ee,H,se,We),P.modelViewMatrix.multiplyMatrices(ee.matrixWorldInverse,P.matrixWorld),P.normalMatrix.getNormalMatrix(P.modelViewMatrix),se.onBeforeRender(h,j,ee,H,P,We),se.transparent===!0&&se.side===zn&&se.forceSinglePass===!1?(se.side=an,se.needsUpdate=!0,h.renderBufferDirect(ee,j,H,se,P,We),se.side=Zn,se.needsUpdate=!0,h.renderBufferDirect(ee,j,H,se,P,We),se.side=zn):h.renderBufferDirect(ee,j,H,se,P,We),P.onAfterRender(h,j,ee,H,se,We)}function cn(P,j,ee){j.isScene!==!0&&(j=ce);const H=ze.get(P),se=d.state.lights,We=d.state.shadowsArray,Ke=se.state.version,Qe=lt.getParameters(P,se.state,We,j,ee),$e=lt.getProgramCacheKey(Qe);let rt=H.programs;H.environment=P.isMeshStandardMaterial?j.environment:null,H.fog=j.fog,H.envMap=(P.isMeshStandardMaterial?Le:ye).get(P.envMap||H.environment),rt===void 0&&(P.addEventListener("dispose",_e),rt=new Map,H.programs=rt);let et=rt.get($e);if(et!==void 0){if(H.currentProgram===et&&H.lightsStateVersion===Ke)return yn(P,Qe),et}else Qe.uniforms=lt.getUniforms(P),P.onBuild(ee,Qe,h),P.onBeforeCompile(Qe,h),et=lt.acquireProgram(Qe,$e),rt.set($e,et),H.uniforms=Qe.uniforms;const tt=H.uniforms;(!P.isShaderMaterial&&!P.isRawShaderMaterial||P.clipping===!0)&&(tt.clippingPlanes=R.uniform),yn(P,Qe),H.needsLights=iu(P),H.lightsStateVersion=Ke,H.needsLights&&(tt.ambientLightColor.value=se.state.ambient,tt.lightProbe.value=se.state.probe,tt.directionalLights.value=se.state.directional,tt.directionalLightShadows.value=se.state.directionalShadow,tt.spotLights.value=se.state.spot,tt.spotLightShadows.value=se.state.spotShadow,tt.rectAreaLights.value=se.state.rectArea,tt.ltc_1.value=se.state.rectAreaLTC1,tt.ltc_2.value=se.state.rectAreaLTC2,tt.pointLights.value=se.state.point,tt.pointLightShadows.value=se.state.pointShadow,tt.hemisphereLights.value=se.state.hemi,tt.directionalShadowMap.value=se.state.directionalShadowMap,tt.directionalShadowMatrix.value=se.state.directionalShadowMatrix,tt.spotShadowMap.value=se.state.spotShadowMap,tt.spotLightMatrix.value=se.state.spotLightMatrix,tt.spotLightMap.value=se.state.spotLightMap,tt.pointShadowMap.value=se.state.pointShadowMap,tt.pointShadowMatrix.value=se.state.pointShadowMatrix);const xt=et.getUniforms(),tn=es.seqWithValue(xt.seq,tt);return H.currentProgram=et,H.uniformsList=tn,et}function yn(P,j){const ee=ze.get(P);ee.outputEncoding=j.outputEncoding,ee.instancing=j.instancing,ee.skinning=j.skinning,ee.morphTargets=j.morphTargets,ee.morphNormals=j.morphNormals,ee.morphColors=j.morphColors,ee.morphTargetsCount=j.morphTargetsCount,ee.numClippingPlanes=j.numClippingPlanes,ee.numIntersection=j.numClipIntersection,ee.vertexAlphas=j.vertexAlphas,ee.vertexTangents=j.vertexTangents,ee.toneMapping=j.toneMapping}function tu(P,j,ee,H,se){j.isScene!==!0&&(j=ce),oe.resetTextureUnits();const We=j.fog,Ke=H.isMeshStandardMaterial?j.environment:null,Qe=b===null?h.outputEncoding:b.isXRRenderTarget===!0?b.texture.encoding:hi,$e=(H.isMeshStandardMaterial?Le:ye).get(H.envMap||Ke),rt=H.vertexColors===!0&&!!ee.attributes.color&&ee.attributes.color.itemSize===4,et=!!H.normalMap&&!!ee.attributes.tangent,tt=!!ee.morphAttributes.position,xt=!!ee.morphAttributes.normal,tn=!!ee.morphAttributes.color,En=H.toneMapped?h.toneMapping:Un,Kn=ee.morphAttributes.position||ee.morphAttributes.normal||ee.morphAttributes.color,Mt=Kn!==void 0?Kn.length:0,nt=ze.get(H),vs=d.state.lights;if($===!0&&(ne===!0||P!==w)){const nn=P===w&&H.id===y;R.setState(H,P,nn)}let Dt=!1;H.version===nt.__version?(nt.needsLights&&nt.lightsStateVersion!==vs.state.version||nt.outputEncoding!==Qe||se.isInstancedMesh&&nt.instancing===!1||!se.isInstancedMesh&&nt.instancing===!0||se.isSkinnedMesh&&nt.skinning===!1||!se.isSkinnedMesh&&nt.skinning===!0||nt.envMap!==$e||H.fog===!0&&nt.fog!==We||nt.numClippingPlanes!==void 0&&(nt.numClippingPlanes!==R.numPlanes||nt.numIntersection!==R.numIntersection)||nt.vertexAlphas!==rt||nt.vertexTangents!==et||nt.morphTargets!==tt||nt.morphNormals!==xt||nt.morphColors!==tn||nt.toneMapping!==En||Ee.isWebGL2===!0&&nt.morphTargetsCount!==Mt)&&(Dt=!0):(Dt=!0,nt.__version=H.version);let Jn=nt.currentProgram;Dt===!0&&(Jn=cn(H,j,se));let La=!1,qi=!1,ys=!1;const Ht=Jn.getUniforms(),Qn=nt.uniforms;if(Ce.useProgram(Jn.program)&&(La=!0,qi=!0,ys=!0),H.id!==y&&(y=H.id,qi=!0),La||w!==P){if(Ht.setValue(W,"projectionMatrix",P.projectionMatrix),Ee.logarithmicDepthBuffer&&Ht.setValue(W,"logDepthBufFC",2/(Math.log(P.far+1)/Math.LN2)),w!==P&&(w=P,qi=!0,ys=!0),H.isShaderMaterial||H.isMeshPhongMaterial||H.isMeshToonMaterial||H.isMeshStandardMaterial||H.envMap){const nn=Ht.map.cameraPosition;nn!==void 0&&nn.setValue(W,q.setFromMatrixPosition(P.matrixWorld))}(H.isMeshPhongMaterial||H.isMeshToonMaterial||H.isMeshLambertMaterial||H.isMeshBasicMaterial||H.isMeshStandardMaterial||H.isShaderMaterial)&&Ht.setValue(W,"isOrthographic",P.isOrthographicCamera===!0),(H.isMeshPhongMaterial||H.isMeshToonMaterial||H.isMeshLambertMaterial||H.isMeshBasicMaterial||H.isMeshStandardMaterial||H.isShaderMaterial||H.isShadowMaterial||se.isSkinnedMesh)&&Ht.setValue(W,"viewMatrix",P.matrixWorldInverse)}if(se.isSkinnedMesh){Ht.setOptional(W,se,"bindMatrix"),Ht.setOptional(W,se,"bindMatrixInverse");const nn=se.skeleton;nn&&(Ee.floatVertexTextures?(nn.boneTexture===null&&nn.computeBoneTexture(),Ht.setValue(W,"boneTexture",nn.boneTexture,oe),Ht.setValue(W,"boneTextureSize",nn.boneTextureSize)):console.warn("THREE.WebGLRenderer: SkinnedMesh can only be used with WebGL 2. With WebGL 1 OES_texture_float and vertex textures support is required."))}const ws=ee.morphAttributes;if((ws.position!==void 0||ws.normal!==void 0||ws.color!==void 0&&Ee.isWebGL2===!0)&&me.update(se,ee,Jn),(qi||nt.receiveShadow!==se.receiveShadow)&&(nt.receiveShadow=se.receiveShadow,Ht.setValue(W,"receiveShadow",se.receiveShadow)),H.isMeshGouraudMaterial&&H.envMap!==null&&(Qn.envMap.value=$e,Qn.flipEnvMap.value=$e.isCubeTexture&&$e.isRenderTargetTexture===!1?-1:1),qi&&(Ht.setValue(W,"toneMappingExposure",h.toneMappingExposure),nt.needsLights&&nu(Qn,ys),We&&H.fog===!0&&ct.refreshFogUniforms(Qn,We),ct.refreshMaterialUniforms(Qn,H,D,A,ue),es.upload(W,nt.uniformsList,Qn,oe)),H.isShaderMaterial&&H.uniformsNeedUpdate===!0&&(es.upload(W,nt.uniformsList,Qn,oe),H.uniformsNeedUpdate=!1),H.isSpriteMaterial&&Ht.setValue(W,"center",se.center),Ht.setValue(W,"modelViewMatrix",se.modelViewMatrix),Ht.setValue(W,"normalMatrix",se.normalMatrix),Ht.setValue(W,"modelMatrix",se.matrixWorld),H.isShaderMaterial||H.isRawShaderMaterial){const nn=H.uniformsGroups;for(let xs=0,ru=nn.length;xs<ru;xs++)if(Ee.isWebGL2){const Pa=nn[xs];re.update(Pa,Jn),re.bind(Pa,Jn)}else console.warn("THREE.WebGLRenderer: Uniform Buffer Objects can only be used with WebGL 2.")}return Jn}function nu(P,j){P.ambientLightColor.needsUpdate=j,P.lightProbe.needsUpdate=j,P.directionalLights.needsUpdate=j,P.directionalLightShadows.needsUpdate=j,P.pointLights.needsUpdate=j,P.pointLightShadows.needsUpdate=j,P.spotLights.needsUpdate=j,P.spotLightShadows.needsUpdate=j,P.rectAreaLights.needsUpdate=j,P.hemisphereLights.needsUpdate=j}function iu(P){return P.isMeshLambertMaterial||P.isMeshToonMaterial||P.isMeshPhongMaterial||P.isMeshStandardMaterial||P.isShadowMaterial||P.isShaderMaterial&&P.lights===!0}this.getActiveCubeFace=function(){return g},this.getActiveMipmapLevel=function(){return v},this.getRenderTarget=function(){return b},this.setRenderTargetTextures=function(P,j,ee){ze.get(P.texture).__webglTexture=j,ze.get(P.depthTexture).__webglTexture=ee;const H=ze.get(P);H.__hasExternalTextures=!0,H.__hasExternalTextures&&(H.__autoAllocateDepthBuffer=ee===void 0,H.__autoAllocateDepthBuffer||we.has("WEBGL_multisampled_render_to_texture")===!0&&(console.warn("THREE.WebGLRenderer: Render-to-texture extension was disabled because an external texture was provided"),H.__useRenderToTexture=!1))},this.setRenderTargetFramebuffer=function(P,j){const ee=ze.get(P);ee.__webglFramebuffer=j,ee.__useDefaultFramebuffer=j===void 0},this.setRenderTarget=function(P,j=0,ee=0){b=P,g=j,v=ee;let H=!0,se=null,We=!1,Ke=!1;if(P){const $e=ze.get(P);$e.__useDefaultFramebuffer!==void 0?(Ce.bindFramebuffer(36160,null),H=!1):$e.__webglFramebuffer===void 0?oe.setupRenderTarget(P):$e.__hasExternalTextures&&oe.rebindTextures(P,ze.get(P.texture).__webglTexture,ze.get(P.depthTexture).__webglTexture);const rt=P.texture;(rt.isData3DTexture||rt.isDataArrayTexture||rt.isCompressedArrayTexture)&&(Ke=!0);const et=ze.get(P).__webglFramebuffer;P.isWebGLCubeRenderTarget?(se=et[j],We=!0):Ee.isWebGL2&&P.samples>0&&oe.useMultisampledRTT(P)===!1?se=ze.get(P).__webglMultisampledFramebuffer:se=et,M.copy(P.viewport),E.copy(P.scissor),x=P.scissorTest}else M.copy(z).multiplyScalar(D).floor(),E.copy(X).multiplyScalar(D).floor(),x=ae;if(Ce.bindFramebuffer(36160,se)&&Ee.drawBuffers&&H&&Ce.drawBuffers(P,se),Ce.viewport(M),Ce.scissor(E),Ce.setScissorTest(x),We){const $e=ze.get(P.texture);W.framebufferTexture2D(36160,36064,34069+j,$e.__webglTexture,ee)}else if(Ke){const $e=ze.get(P.texture),rt=j||0;W.framebufferTextureLayer(36160,36064,$e.__webglTexture,ee||0,rt)}y=-1},this.readRenderTargetPixels=function(P,j,ee,H,se,We,Ke){if(!(P&&P.isWebGLRenderTarget)){console.error("THREE.WebGLRenderer.readRenderTargetPixels: renderTarget is not THREE.WebGLRenderTarget.");return}let Qe=ze.get(P).__webglFramebuffer;if(P.isWebGLCubeRenderTarget&&Ke!==void 0&&(Qe=Qe[Ke]),Qe){Ce.bindFramebuffer(36160,Qe);try{const $e=P.texture,rt=$e.format,et=$e.type;if(rt!==gn&&Be.convert(rt)!==W.getParameter(35739)){console.error("THREE.WebGLRenderer.readRenderTargetPixels: renderTarget is not in RGBA or implementation defined format.");return}const tt=et===br&&(we.has("EXT_color_buffer_half_float")||Ee.isWebGL2&&we.has("EXT_color_buffer_float"));if(et!==di&&Be.convert(et)!==W.getParameter(35738)&&!(et===ci&&(Ee.isWebGL2||we.has("OES_texture_float")||we.has("WEBGL_color_buffer_float")))&&!tt){console.error("THREE.WebGLRenderer.readRenderTargetPixels: renderTarget is not in UnsignedByteType or implementation defined type.");return}j>=0&&j<=P.width-H&&ee>=0&&ee<=P.height-se&&W.readPixels(j,ee,H,se,Be.convert(rt),Be.convert(et),We)}finally{const $e=b!==null?ze.get(b).__webglFramebuffer:null;Ce.bindFramebuffer(36160,$e)}}},this.copyFramebufferToTexture=function(P,j,ee=0){const H=Math.pow(2,-ee),se=Math.floor(j.image.width*H),We=Math.floor(j.image.height*H);oe.setTexture2D(j,0),W.copyTexSubImage2D(3553,ee,0,0,P.x,P.y,se,We),Ce.unbindTexture()},this.copyTextureToTexture=function(P,j,ee,H=0){const se=j.image.width,We=j.image.height,Ke=Be.convert(ee.format),Qe=Be.convert(ee.type);oe.setTexture2D(ee,0),W.pixelStorei(37440,ee.flipY),W.pixelStorei(37441,ee.premultiplyAlpha),W.pixelStorei(3317,ee.unpackAlignment),j.isDataTexture?W.texSubImage2D(3553,H,P.x,P.y,se,We,Ke,Qe,j.image.data):j.isCompressedTexture?W.compressedTexSubImage2D(3553,H,P.x,P.y,j.mipmaps[0].width,j.mipmaps[0].height,Ke,j.mipmaps[0].data):W.texSubImage2D(3553,H,P.x,P.y,Ke,Qe,j.image),H===0&&ee.generateMipmaps&&W.generateMipmap(3553),Ce.unbindTexture()},this.copyTextureToTexture3D=function(P,j,ee,H,se=0){if(h.isWebGL1Renderer){console.warn("THREE.WebGLRenderer.copyTextureToTexture3D: can only be used with WebGL2.");return}const We=P.max.x-P.min.x+1,Ke=P.max.y-P.min.y+1,Qe=P.max.z-P.min.z+1,$e=Be.convert(H.format),rt=Be.convert(H.type);let et;if(H.isData3DTexture)oe.setTexture3D(H,0),et=32879;else if(H.isDataArrayTexture)oe.setTexture2DArray(H,0),et=35866;else{console.warn("THREE.WebGLRenderer.copyTextureToTexture3D: only supports THREE.DataTexture3D and THREE.DataTexture2DArray.");return}W.pixelStorei(37440,H.flipY),W.pixelStorei(37441,H.premultiplyAlpha),W.pixelStorei(3317,H.unpackAlignment);const tt=W.getParameter(3314),xt=W.getParameter(32878),tn=W.getParameter(3316),En=W.getParameter(3315),Kn=W.getParameter(32877),Mt=ee.isCompressedTexture?ee.mipmaps[0]:ee.image;W.pixelStorei(3314,Mt.width),W.pixelStorei(32878,Mt.height),W.pixelStorei(3316,P.min.x),W.pixelStorei(3315,P.min.y),W.pixelStorei(32877,P.min.z),ee.isDataTexture||ee.isData3DTexture?W.texSubImage3D(et,se,j.x,j.y,j.z,We,Ke,Qe,$e,rt,Mt.data):ee.isCompressedArrayTexture?(console.warn("THREE.WebGLRenderer.copyTextureToTexture3D: untested support for compressed srcTexture."),W.compressedTexSubImage3D(et,se,j.x,j.y,j.z,We,Ke,Qe,$e,Mt.data)):W.texSubImage3D(et,se,j.x,j.y,j.z,We,Ke,Qe,$e,rt,Mt),W.pixelStorei(3314,tt),W.pixelStorei(32878,xt),W.pixelStorei(3316,tn),W.pixelStorei(3315,En),W.pixelStorei(32877,Kn),se===0&&H.generateMipmaps&&W.generateMipmap(et),Ce.unbindTexture()},this.initTexture=function(P){P.isCubeTexture?oe.setTextureCube(P,0):P.isData3DTexture?oe.setTexture3D(P,0):P.isDataArrayTexture||P.isCompressedArrayTexture?oe.setTexture2DArray(P,0):oe.setTexture2D(P,0),Ce.unbindTexture()},this.resetState=function(){g=0,v=0,b=null,Ce.reset(),Me.reset()},typeof __THREE_DEVTOOLS__<"u"&&__THREE_DEVTOOLS__.dispatchEvent(new CustomEvent("observe",{detail:this}))}Object.defineProperties(Ca.prototype,{physicallyCorrectLights:{get:function(){return console.warn("THREE.WebGLRenderer: the property .physicallyCorrectLights has been removed. Set renderer.useLegacyLights instead."),!this.useLegacyLights},set:function(i){console.warn("THREE.WebGLRenderer: the property .physicallyCorrectLights has been removed. Set renderer.useLegacyLights instead."),this.useLegacyLights=!i}}});class d2 extends Ca{}d2.prototype.isWebGL1Renderer=!0;class h2 extends zt{constructor(){super(),this.isScene=!0,this.type="Scene",this.background=null,this.environment=null,this.fog=null,this.backgroundBlurriness=0,this.backgroundIntensity=1,this.overrideMaterial=null,typeof __THREE_DEVTOOLS__<"u"&&__THREE_DEVTOOLS__.dispatchEvent(new CustomEvent("observe",{detail:this}))}copy(e,t){return super.copy(e,t),e.background!==null&&(this.background=e.background.clone()),e.environment!==null&&(this.environment=e.environment.clone()),e.fog!==null&&(this.fog=e.fog.clone()),this.backgroundBlurriness=e.backgroundBlurriness,this.backgroundIntensity=e.backgroundIntensity,e.overrideMaterial!==null&&(this.overrideMaterial=e.overrideMaterial.clone()),this.matrixAutoUpdate=e.matrixAutoUpdate,this}toJSON(e){const t=super.toJSON(e);return this.fog!==null&&(t.object.fog=this.fog.toJSON()),this.backgroundBlurriness>0&&(t.object.backgroundBlurriness=this.backgroundBlurriness),this.backgroundIntensity!==1&&(t.object.backgroundIntensity=this.backgroundIntensity),t}get autoUpdate(){return console.warn("THREE.Scene: autoUpdate was renamed to matrixWorldAutoUpdate in r144."),this.matrixWorldAutoUpdate}set autoUpdate(e){console.warn("THREE.Scene: autoUpdate was renamed to matrixWorldAutoUpdate in r144."),this.matrixWorldAutoUpdate=e}}class eu extends Tr{constructor(e){super(),this.isLineBasicMaterial=!0,this.type="LineBasicMaterial",this.color=new mt(16777215),this.linewidth=1,this.linecap="round",this.linejoin="round",this.fog=!0,this.setValues(e)}copy(e){return super.copy(e),this.color.copy(e.color),this.linewidth=e.linewidth,this.linecap=e.linecap,this.linejoin=e.linejoin,this.fog=e.fog,this}}const ic=new B,rc=new B,sc=new Tt,ta=new xa,Yr=new ms;class Xn extends zt{constructor(e=new $t,t=new eu){super(),this.isLine=!0,this.type="Line",this.geometry=e,this.material=t,this.updateMorphTargets()}copy(e,t){return super.copy(e,t),this.material=e.material,this.geometry=e.geometry,this}computeLineDistances(){const e=this.geometry;if(e.index===null){const t=e.attributes.position,n=[0];for(let r=1,s=t.count;r<s;r++)ic.fromBufferAttribute(t,r-1),rc.fromBufferAttribute(t,r),n[r]=n[r-1],n[r]+=ic.distanceTo(rc);e.setAttribute("lineDistance",new bt(n,1))}else console.warn("THREE.Line.computeLineDistances(): Computation only possible with non-indexed BufferGeometry.");return this}raycast(e,t){const n=this.geometry,r=this.matrixWorld,s=e.params.Line.threshold,a=n.drawRange;if(n.boundingSphere===null&&n.computeBoundingSphere(),Yr.copy(n.boundingSphere),Yr.applyMatrix4(r),Yr.radius+=s,e.ray.intersectsSphere(Yr)===!1)return;sc.copy(r).invert(),ta.copy(e.ray).applyMatrix4(sc);const o=s/((this.scale.x+this.scale.y+this.scale.z)/3),l=o*o,c=new B,u=new B,f=new B,d=new B,p=this.isLineSegments?2:1,m=n.index,_=n.attributes.position;if(m!==null){const g=Math.max(0,a.start),v=Math.min(m.count,a.start+a.count);for(let b=g,y=v-1;b<y;b+=p){const w=m.getX(b),M=m.getX(b+1);if(c.fromBufferAttribute(_,w),u.fromBufferAttribute(_,M),ta.distanceSqToSegment(c,u,d,f)>l)continue;d.applyMatrix4(this.matrixWorld);const x=e.ray.origin.distanceTo(d);x<e.near||x>e.far||t.push({distance:x,point:f.clone().applyMatrix4(this.matrixWorld),index:b,face:null,faceIndex:null,object:this})}}else{const g=Math.max(0,a.start),v=Math.min(_.count,a.start+a.count);for(let b=g,y=v-1;b<y;b+=p){if(c.fromBufferAttribute(_,b),u.fromBufferAttribute(_,b+1),ta.distanceSqToSegment(c,u,d,f)>l)continue;d.applyMatrix4(this.matrixWorld);const M=e.ray.origin.distanceTo(d);M<e.near||M>e.far||t.push({distance:M,point:f.clone().applyMatrix4(this.matrixWorld),index:b,face:null,faceIndex:null,object:this})}}}updateMorphTargets(){const t=this.geometry.morphAttributes,n=Object.keys(t);if(n.length>0){const r=t[n[0]];if(r!==void 0){this.morphTargetInfluences=[],this.morphTargetDictionary={};for(let s=0,a=r.length;s<a;s++){const o=r[s].name||String(s);this.morphTargetInfluences.push(0),this.morphTargetDictionary[o]=s}}}}}class Bt extends $t{constructor(e=1,t=1,n=1,r=32,s=1,a=!1,o=0,l=Math.PI*2){super(),this.type="CylinderGeometry",this.parameters={radiusTop:e,radiusBottom:t,height:n,radialSegments:r,heightSegments:s,openEnded:a,thetaStart:o,thetaLength:l};const c=this;r=Math.floor(r),s=Math.floor(s);const u=[],f=[],d=[],p=[];let m=0;const h=[],_=n/2;let g=0;v(),a===!1&&(e>0&&b(!0),t>0&&b(!1)),this.setIndex(u),this.setAttribute("position",new bt(f,3)),this.setAttribute("normal",new bt(d,3)),this.setAttribute("uv",new bt(p,2));function v(){const y=new B,w=new B;let M=0;const E=(t-e)/n;for(let x=0;x<=s;x++){const C=[],A=x/s,D=A*(t-e)+e;for(let G=0;G<=r;G++){const U=G/r,z=U*l+o,X=Math.sin(z),ae=Math.cos(z);w.x=D*X,w.y=-A*n+_,w.z=D*ae,f.push(w.x,w.y,w.z),y.set(X,E,ae).normalize(),d.push(y.x,y.y,y.z),p.push(U,1-A),C.push(m++)}h.push(C)}for(let x=0;x<r;x++)for(let C=0;C<s;C++){const A=h[C][x],D=h[C+1][x],G=h[C+1][x+1],U=h[C][x+1];u.push(A,D,U),u.push(D,G,U),M+=6}c.addGroup(g,M,0),g+=M}function b(y){const w=m,M=new st,E=new B;let x=0;const C=y===!0?e:t,A=y===!0?1:-1;for(let G=1;G<=r;G++)f.push(0,_*A,0),d.push(0,A,0),p.push(.5,.5),m++;const D=m;for(let G=0;G<=r;G++){const z=G/r*l+o,X=Math.cos(z),ae=Math.sin(z);E.x=C*ae,E.y=_*A,E.z=C*X,f.push(E.x,E.y,E.z),d.push(0,A,0),M.x=X*.5+.5,M.y=ae*.5*A+.5,p.push(M.x,M.y),m++}for(let G=0;G<r;G++){const U=w+G,z=D+G;y===!0?u.push(z,z+1,U):u.push(z+1,z,U),x+=3}c.addGroup(g,x,y===!0?1:2),g+=x}}copy(e){return super.copy(e),this.parameters=Object.assign({},e.parameters),this}static fromJSON(e){return new Bt(e.radiusTop,e.radiusBottom,e.height,e.radialSegments,e.heightSegments,e.openEnded,e.thetaStart,e.thetaLength)}}class Ta extends $t{constructor(e=[],t=[],n=1,r=0){super(),this.type="PolyhedronGeometry",this.parameters={vertices:e,indices:t,radius:n,detail:r};const s=[],a=[];o(r),c(n),u(),this.setAttribute("position",new bt(s,3)),this.setAttribute("normal",new bt(s.slice(),3)),this.setAttribute("uv",new bt(a,2)),r===0?this.computeVertexNormals():this.normalizeNormals();function o(v){const b=new B,y=new B,w=new B;for(let M=0;M<t.length;M+=3)p(t[M+0],b),p(t[M+1],y),p(t[M+2],w),l(b,y,w,v)}function l(v,b,y,w){const M=w+1,E=[];for(let x=0;x<=M;x++){E[x]=[];const C=v.clone().lerp(y,x/M),A=b.clone().lerp(y,x/M),D=M-x;for(let G=0;G<=D;G++)G===0&&x===M?E[x][G]=C:E[x][G]=C.clone().lerp(A,G/D)}for(let x=0;x<M;x++)for(let C=0;C<2*(M-x)-1;C++){const A=Math.floor(C/2);C%2===0?(d(E[x][A+1]),d(E[x+1][A]),d(E[x][A])):(d(E[x][A+1]),d(E[x+1][A+1]),d(E[x+1][A]))}}function c(v){const b=new B;for(let y=0;y<s.length;y+=3)b.x=s[y+0],b.y=s[y+1],b.z=s[y+2],b.normalize().multiplyScalar(v),s[y+0]=b.x,s[y+1]=b.y,s[y+2]=b.z}function u(){const v=new B;for(let b=0;b<s.length;b+=3){v.x=s[b+0],v.y=s[b+1],v.z=s[b+2];const y=_(v)/2/Math.PI+.5,w=g(v)/Math.PI+.5;a.push(y,1-w)}m(),f()}function f(){for(let v=0;v<a.length;v+=6){const b=a[v+0],y=a[v+2],w=a[v+4],M=Math.max(b,y,w),E=Math.min(b,y,w);M>.9&&E<.1&&(b<.2&&(a[v+0]+=1),y<.2&&(a[v+2]+=1),w<.2&&(a[v+4]+=1))}}function d(v){s.push(v.x,v.y,v.z)}function p(v,b){const y=v*3;b.x=e[y+0],b.y=e[y+1],b.z=e[y+2]}function m(){const v=new B,b=new B,y=new B,w=new B,M=new st,E=new st,x=new st;for(let C=0,A=0;C<s.length;C+=9,A+=6){v.set(s[C+0],s[C+1],s[C+2]),b.set(s[C+3],s[C+4],s[C+5]),y.set(s[C+6],s[C+7],s[C+8]),M.set(a[A+0],a[A+1]),E.set(a[A+2],a[A+3]),x.set(a[A+4],a[A+5]),w.copy(v).add(b).add(y).divideScalar(3);const D=_(w);h(M,A+0,v,D),h(E,A+2,b,D),h(x,A+4,y,D)}}function h(v,b,y,w){w<0&&v.x===1&&(a[b]=v.x-1),y.x===0&&y.z===0&&(a[b]=w/2/Math.PI+.5)}function _(v){return Math.atan2(v.z,-v.x)}function g(v){return Math.atan2(-v.y,Math.sqrt(v.x*v.x+v.z*v.z))}}copy(e){return super.copy(e),this.parameters=Object.assign({},e.parameters),this}static fromJSON(e){return new Ta(e.vertices,e.indices,e.radius,e.details)}}class Ri extends Ta{constructor(e=1,t=0){const n=[1,0,0,-1,0,0,0,1,0,0,-1,0,0,0,1,0,0,-1],r=[0,2,4,0,4,3,0,3,5,0,5,2,1,2,5,1,5,3,1,3,4,1,4,2];super(n,r,e,t),this.type="OctahedronGeometry",this.parameters={radius:e,detail:t}}static fromJSON(e){return new Ri(e.radius,e.detail)}}class Ea extends $t{constructor(e=1,t=32,n=16,r=0,s=Math.PI*2,a=0,o=Math.PI){super(),this.type="SphereGeometry",this.parameters={radius:e,widthSegments:t,heightSegments:n,phiStart:r,phiLength:s,thetaStart:a,thetaLength:o},t=Math.max(3,Math.floor(t)),n=Math.max(2,Math.floor(n));const l=Math.min(a+o,Math.PI);let c=0;const u=[],f=new B,d=new B,p=[],m=[],h=[],_=[];for(let g=0;g<=n;g++){const v=[],b=g/n;let y=0;g==0&&a==0?y=.5/t:g==n&&l==Math.PI&&(y=-.5/t);for(let w=0;w<=t;w++){const M=w/t;f.x=-e*Math.cos(r+M*s)*Math.sin(a+b*o),f.y=e*Math.cos(a+b*o),f.z=e*Math.sin(r+M*s)*Math.sin(a+b*o),m.push(f.x,f.y,f.z),d.copy(f).normalize(),h.push(d.x,d.y,d.z),_.push(M+y,1-b),v.push(c++)}u.push(v)}for(let g=0;g<n;g++)for(let v=0;v<t;v++){const b=u[g][v+1],y=u[g][v],w=u[g+1][v],M=u[g+1][v+1];(g!==0||a>0)&&p.push(b,y,M),(g!==n-1||l<Math.PI)&&p.push(y,w,M)}this.setIndex(p),this.setAttribute("position",new bt(m,3)),this.setAttribute("normal",new bt(h,3)),this.setAttribute("uv",new bt(_,2))}copy(e){return super.copy(e),this.parameters=Object.assign({},e.parameters),this}static fromJSON(e){return new Ea(e.radius,e.widthSegments,e.heightSegments,e.phiStart,e.phiLength,e.thetaStart,e.thetaLength)}}class oi extends $t{constructor(e=1,t=.4,n=12,r=48,s=Math.PI*2){super(),this.type="TorusGeometry",this.parameters={radius:e,tube:t,radialSegments:n,tubularSegments:r,arc:s},n=Math.floor(n),r=Math.floor(r);const a=[],o=[],l=[],c=[],u=new B,f=new B,d=new B;for(let p=0;p<=n;p++)for(let m=0;m<=r;m++){const h=m/r*s,_=p/n*Math.PI*2;f.x=(e+t*Math.cos(_))*Math.cos(h),f.y=(e+t*Math.cos(_))*Math.sin(h),f.z=t*Math.sin(_),o.push(f.x,f.y,f.z),u.x=e*Math.cos(h),u.y=e*Math.sin(h),d.subVectors(f,u).normalize(),l.push(d.x,d.y,d.z),c.push(m/r),c.push(p/n)}for(let p=1;p<=n;p++)for(let m=1;m<=r;m++){const h=(r+1)*p+m-1,_=(r+1)*(p-1)+m-1,g=(r+1)*(p-1)+m,v=(r+1)*p+m;a.push(h,_,v),a.push(_,g,v)}this.setIndex(a),this.setAttribute("position",new bt(o,3)),this.setAttribute("normal",new bt(l,3)),this.setAttribute("uv",new bt(c,2))}copy(e){return super.copy(e),this.parameters=Object.assign({},e.parameters),this}static fromJSON(e){return new oi(e.radius,e.tube,e.radialSegments,e.tubularSegments,e.arc)}}class p2{constructor(e,t,n=0,r=1/0){this.ray=new xa(e,t),this.near=n,this.far=r,this.camera=null,this.layers=new Ma,this.params={Mesh:{},Line:{threshold:1},LOD:{},Points:{threshold:1},Sprite:{}}}set(e,t){this.ray.set(e,t)}setFromCamera(e,t){t.isPerspectiveCamera?(this.ray.origin.setFromMatrixPosition(t.matrixWorld),this.ray.direction.set(e.x,e.y,.5).unproject(t).sub(this.ray.origin).normalize(),this.camera=t):t.isOrthographicCamera?(this.ray.origin.set(e.x,e.y,(t.near+t.far)/(t.near-t.far)).unproject(t),this.ray.direction.set(0,0,-1).transformDirection(t.matrixWorld),this.camera=t):console.error("THREE.Raycaster: Unsupported camera type: "+t.type)}intersectObject(e,t=!0,n=[]){return ma(e,this,n,t),n.sort(ac),n}intersectObjects(e,t=!0,n=[]){for(let r=0,s=e.length;r<s;r++)ma(e[r],this,n,t);return n.sort(ac),n}}function ac(i,e){return i.distance-e.distance}function ma(i,e,t,n){if(i.layers.test(e.layers)&&i.raycast(e,t),n===!0){const r=i.children;for(let s=0,a=r.length;s<a;s++)ma(r[s],e,t,!0)}}typeof __THREE_DEVTOOLS__<"u"&&__THREE_DEVTOOLS__.dispatchEvent(new CustomEvent("register",{detail:{revision:ya}}));typeof window<"u"&&(window.__THREE__?console.warn("WARNING: Multiple instances of Three.js being imported."):window.__THREE__=ya);const ni=new p2,Jt=new B,jn=new B,_t=new qt,oc={X:new B(1,0,0),Y:new B(0,1,0),Z:new B(0,0,1)},na={type:"change"},lc={type:"mouseDown"},cc={type:"mouseUp",mode:null},uc={type:"objectChange"};class m2 extends zt{constructor(e,t){super(),t===void 0&&(console.warn('THREE.TransformControls: The second parameter "domElement" is now mandatory.'),t=document),this.isTransformControls=!0,this.visible=!1,this.domElement=t,this.domElement.style.touchAction="none";const n=new w2;this._gizmo=n,this.add(n);const r=new x2;this._plane=r,this.add(r);const s=this;function a(v,b){let y=b;Object.defineProperty(s,v,{get:function(){return y!==void 0?y:b},set:function(w){y!==w&&(y=w,r[v]=w,n[v]=w,s.dispatchEvent({type:v+"-changed",value:w}),s.dispatchEvent(na))}}),s[v]=b,r[v]=b,n[v]=b}a("camera",e),a("object",void 0),a("enabled",!0),a("axis",null),a("mode","translate"),a("translationSnap",null),a("rotationSnap",null),a("scaleSnap",null),a("space","world"),a("size",1),a("dragging",!1),a("showX",!0),a("showY",!0),a("showZ",!0);const o=new B,l=new B,c=new qt,u=new qt,f=new B,d=new qt,p=new B,m=new B,h=new B,_=0,g=new B;a("worldPosition",o),a("worldPositionStart",l),a("worldQuaternion",c),a("worldQuaternionStart",u),a("cameraPosition",f),a("cameraQuaternion",d),a("pointStart",p),a("pointEnd",m),a("rotationAxis",h),a("rotationAngle",_),a("eye",g),this._offset=new B,this._startNorm=new B,this._endNorm=new B,this._cameraScale=new B,this._parentPosition=new B,this._parentQuaternion=new qt,this._parentQuaternionInv=new qt,this._parentScale=new B,this._worldScaleStart=new B,this._worldQuaternionInv=new qt,this._worldScale=new B,this._positionStart=new B,this._quaternionStart=new qt,this._scaleStart=new B,this._getPointer=_2.bind(this),this._onPointerDown=b2.bind(this),this._onPointerHover=g2.bind(this),this._onPointerMove=v2.bind(this),this._onPointerUp=y2.bind(this),this.domElement.addEventListener("pointerdown",this._onPointerDown),this.domElement.addEventListener("pointermove",this._onPointerHover),this.domElement.addEventListener("pointerup",this._onPointerUp)}updateMatrixWorld(){this.object!==void 0&&(this.object.updateMatrixWorld(),this.object.parent===null?console.error("TransformControls: The attached 3D object must be a part of the scene graph."):this.object.parent.matrixWorld.decompose(this._parentPosition,this._parentQuaternion,this._parentScale),this.object.matrixWorld.decompose(this.worldPosition,this.worldQuaternion,this._worldScale),this._parentQuaternionInv.copy(this._parentQuaternion).invert(),this._worldQuaternionInv.copy(this.worldQuaternion).invert()),this.camera.updateMatrixWorld(),this.camera.matrixWorld.decompose(this.cameraPosition,this.cameraQuaternion,this._cameraScale),this.camera.isOrthographicCamera?this.camera.getWorldDirection(this.eye).negate():this.eye.copy(this.cameraPosition).sub(this.worldPosition).normalize(),super.updateMatrixWorld(this)}pointerHover(e){if(this.object===void 0||this.dragging===!0)return;ni.setFromCamera(e,this.camera);const t=ia(this._gizmo.picker[this.mode],ni);t?this.axis=t.object.name:this.axis=null}pointerDown(e){if(!(this.object===void 0||this.dragging===!0||e.button!==0)&&this.axis!==null){ni.setFromCamera(e,this.camera);const t=ia(this._plane,ni,!0);t&&(this.object.updateMatrixWorld(),this.object.parent.updateMatrixWorld(),this._positionStart.copy(this.object.position),this._quaternionStart.copy(this.object.quaternion),this._scaleStart.copy(this.object.scale),this.object.matrixWorld.decompose(this.worldPositionStart,this.worldQuaternionStart,this._worldScaleStart),this.pointStart.copy(t.point).sub(this.worldPositionStart)),this.dragging=!0,lc.mode=this.mode,this.dispatchEvent(lc)}}pointerMove(e){const t=this.axis,n=this.mode,r=this.object;let s=this.space;if(n==="scale"?s="local":(t==="E"||t==="XYZE"||t==="XYZ")&&(s="world"),r===void 0||t===null||this.dragging===!1||e.button!==-1)return;ni.setFromCamera(e,this.camera);const a=ia(this._plane,ni,!0);if(!!a){if(this.pointEnd.copy(a.point).sub(this.worldPositionStart),n==="translate")this._offset.copy(this.pointEnd).sub(this.pointStart),s==="local"&&t!=="XYZ"&&this._offset.applyQuaternion(this._worldQuaternionInv),t.indexOf("X")===-1&&(this._offset.x=0),t.indexOf("Y")===-1&&(this._offset.y=0),t.indexOf("Z")===-1&&(this._offset.z=0),s==="local"&&t!=="XYZ"?this._offset.applyQuaternion(this._quaternionStart).divide(this._parentScale):this._offset.applyQuaternion(this._parentQuaternionInv).divide(this._parentScale),r.position.copy(this._offset).add(this._positionStart),this.translationSnap&&(s==="local"&&(r.position.applyQuaternion(_t.copy(this._quaternionStart).invert()),t.search("X")!==-1&&(r.position.x=Math.round(r.position.x/this.translationSnap)*this.translationSnap),t.search("Y")!==-1&&(r.position.y=Math.round(r.position.y/this.translationSnap)*this.translationSnap),t.search("Z")!==-1&&(r.position.z=Math.round(r.position.z/this.translationSnap)*this.translationSnap),r.position.applyQuaternion(this._quaternionStart)),s==="world"&&(r.parent&&r.position.add(Jt.setFromMatrixPosition(r.parent.matrixWorld)),t.search("X")!==-1&&(r.position.x=Math.round(r.position.x/this.translationSnap)*this.translationSnap),t.search("Y")!==-1&&(r.position.y=Math.round(r.position.y/this.translationSnap)*this.translationSnap),t.search("Z")!==-1&&(r.position.z=Math.round(r.position.z/this.translationSnap)*this.translationSnap),r.parent&&r.position.sub(Jt.setFromMatrixPosition(r.parent.matrixWorld))));else if(n==="scale"){if(t.search("XYZ")!==-1){let o=this.pointEnd.length()/this.pointStart.length();this.pointEnd.dot(this.pointStart)<0&&(o*=-1),jn.set(o,o,o)}else Jt.copy(this.pointStart),jn.copy(this.pointEnd),Jt.applyQuaternion(this._worldQuaternionInv),jn.applyQuaternion(this._worldQuaternionInv),jn.divide(Jt),t.search("X")===-1&&(jn.x=1),t.search("Y")===-1&&(jn.y=1),t.search("Z")===-1&&(jn.z=1);r.scale.copy(this._scaleStart).multiply(jn),this.scaleSnap&&(t.search("X")!==-1&&(r.scale.x=Math.round(r.scale.x/this.scaleSnap)*this.scaleSnap||this.scaleSnap),t.search("Y")!==-1&&(r.scale.y=Math.round(r.scale.y/this.scaleSnap)*this.scaleSnap||this.scaleSnap),t.search("Z")!==-1&&(r.scale.z=Math.round(r.scale.z/this.scaleSnap)*this.scaleSnap||this.scaleSnap))}else if(n==="rotate"){this._offset.copy(this.pointEnd).sub(this.pointStart);const o=20/this.worldPosition.distanceTo(Jt.setFromMatrixPosition(this.camera.matrixWorld));t==="E"?(this.rotationAxis.copy(this.eye),this.rotationAngle=this.pointEnd.angleTo(this.pointStart),this._startNorm.copy(this.pointStart).normalize(),this._endNorm.copy(this.pointEnd).normalize(),this.rotationAngle*=this._endNorm.cross(this._startNorm).dot(this.eye)<0?1:-1):t==="XYZE"?(this.rotationAxis.copy(this._offset).cross(this.eye).normalize(),this.rotationAngle=this._offset.dot(Jt.copy(this.rotationAxis).cross(this.eye))*o):(t==="X"||t==="Y"||t==="Z")&&(this.rotationAxis.copy(oc[t]),Jt.copy(oc[t]),s==="local"&&Jt.applyQuaternion(this.worldQuaternion),this.rotationAngle=this._offset.dot(Jt.cross(this.eye).normalize())*o),this.rotationSnap&&(this.rotationAngle=Math.round(this.rotationAngle/this.rotationSnap)*this.rotationSnap),s==="local"&&t!=="E"&&t!=="XYZE"?(r.quaternion.copy(this._quaternionStart),r.quaternion.multiply(_t.setFromAxisAngle(this.rotationAxis,this.rotationAngle)).normalize()):(this.rotationAxis.applyQuaternion(this._parentQuaternionInv),r.quaternion.copy(_t.setFromAxisAngle(this.rotationAxis,this.rotationAngle)),r.quaternion.multiply(this._quaternionStart).normalize())}this.dispatchEvent(na),this.dispatchEvent(uc)}}pointerUp(e){e.button===0&&(this.dragging&&this.axis!==null&&(cc.mode=this.mode,this.dispatchEvent(cc)),this.dragging=!1,this.axis=null)}dispose(){this.domElement.removeEventListener("pointerdown",this._onPointerDown),this.domElement.removeEventListener("pointermove",this._onPointerHover),this.domElement.removeEventListener("pointermove",this._onPointerMove),this.domElement.removeEventListener("pointerup",this._onPointerUp),this.traverse(function(e){e.geometry&&e.geometry.dispose(),e.material&&e.material.dispose()})}attach(e){return this.object=e,this.visible=!0,this}detach(){return this.object=void 0,this.visible=!1,this.axis=null,this}reset(){!this.enabled||this.dragging&&(this.object.position.copy(this._positionStart),this.object.quaternion.copy(this._quaternionStart),this.object.scale.copy(this._scaleStart),this.dispatchEvent(na),this.dispatchEvent(uc),this.pointStart.copy(this.pointEnd))}getRaycaster(){return ni}getMode(){return this.mode}setMode(e){this.mode=e}setTranslationSnap(e){this.translationSnap=e}setRotationSnap(e){this.rotationSnap=e}setScaleSnap(e){this.scaleSnap=e}setSize(e){this.size=e}setSpace(e){this.space=e}}function _2(i){if(this.domElement.ownerDocument.pointerLockElement)return{x:0,y:0,button:i.button};{const e=this.domElement.getBoundingClientRect();return{x:(i.clientX-e.left)/e.width*2-1,y:-(i.clientY-e.top)/e.height*2+1,button:i.button}}}function g2(i){if(!!this.enabled)switch(i.pointerType){case"mouse":case"pen":this.pointerHover(this._getPointer(i));break}}function b2(i){!this.enabled||(document.pointerLockElement||this.domElement.setPointerCapture(i.pointerId),this.domElement.addEventListener("pointermove",this._onPointerMove),this.pointerHover(this._getPointer(i)),this.pointerDown(this._getPointer(i)))}function v2(i){!this.enabled||this.pointerMove(this._getPointer(i))}function y2(i){!this.enabled||(this.domElement.releasePointerCapture(i.pointerId),this.domElement.removeEventListener("pointermove",this._onPointerMove),this.pointerUp(this._getPointer(i)))}function ia(i,e,t){const n=e.intersectObject(i,!0);for(let r=0;r<n.length;r++)if(n[r].object.visible||t)return n[r];return!1}const Zr=new Cr,ut=new B(0,1,0),fc=new B(0,0,0),dc=new Tt,Kr=new qt,ts=new qt,xn=new B,hc=new Tt,lr=new B(1,0,0),si=new B(0,1,0),cr=new B(0,0,1),Jr=new B,nr=new B,ir=new B;class w2 extends zt{constructor(){super(),this.isTransformControlsGizmo=!0,this.type="TransformControlsGizmo";const e=new _s({depthTest:!1,depthWrite:!1,fog:!1,toneMapped:!1,transparent:!0}),t=new eu({depthTest:!1,depthWrite:!1,fog:!1,toneMapped:!1,transparent:!0}),n=e.clone();n.opacity=.15;const r=t.clone();r.opacity=.5;const s=e.clone();s.color.setHex(16711680);const a=e.clone();a.color.setHex(65280);const o=e.clone();o.color.setHex(255);const l=e.clone();l.color.setHex(16711680),l.opacity=.5;const c=e.clone();c.color.setHex(65280),c.opacity=.5;const u=e.clone();u.color.setHex(255),u.opacity=.5;const f=e.clone();f.opacity=.25;const d=e.clone();d.color.setHex(16776960),d.opacity=.25,e.clone().color.setHex(16776960);const m=e.clone();m.color.setHex(7895160);const h=new Bt(0,.04,.1,12);h.translate(0,.05,0);const _=new Ct(.08,.08,.08);_.translate(0,.04,0);const g=new $t;g.setAttribute("position",new bt([0,0,0,1,0,0],3));const v=new Bt(.0075,.0075,.5,3);v.translate(0,.25,0);function b(X,ae){const le=new oi(X,.0075,3,64,ae*Math.PI*2);return le.rotateY(Math.PI/2),le.rotateX(Math.PI/2),le}function y(){const X=new $t;return X.setAttribute("position",new bt([0,0,0,1,1,1],3)),X}const w={X:[[new Te(h,s),[.5,0,0],[0,0,-Math.PI/2]],[new Te(h,s),[-.5,0,0],[0,0,Math.PI/2]],[new Te(v,s),[0,0,0],[0,0,-Math.PI/2]]],Y:[[new Te(h,a),[0,.5,0]],[new Te(h,a),[0,-.5,0],[Math.PI,0,0]],[new Te(v,a)]],Z:[[new Te(h,o),[0,0,.5],[Math.PI/2,0,0]],[new Te(h,o),[0,0,-.5],[-Math.PI/2,0,0]],[new Te(v,o),null,[Math.PI/2,0,0]]],XYZ:[[new Te(new Ri(.1,0),f.clone()),[0,0,0]]],XY:[[new Te(new Ct(.15,.15,.01),u.clone()),[.15,.15,0]]],YZ:[[new Te(new Ct(.15,.15,.01),l.clone()),[0,.15,.15],[0,Math.PI/2,0]]],XZ:[[new Te(new Ct(.15,.15,.01),c.clone()),[.15,0,.15],[-Math.PI/2,0,0]]]},M={X:[[new Te(new Bt(.2,0,.6,4),n),[.3,0,0],[0,0,-Math.PI/2]],[new Te(new Bt(.2,0,.6,4),n),[-.3,0,0],[0,0,Math.PI/2]]],Y:[[new Te(new Bt(.2,0,.6,4),n),[0,.3,0]],[new Te(new Bt(.2,0,.6,4),n),[0,-.3,0],[0,0,Math.PI]]],Z:[[new Te(new Bt(.2,0,.6,4),n),[0,0,.3],[Math.PI/2,0,0]],[new Te(new Bt(.2,0,.6,4),n),[0,0,-.3],[-Math.PI/2,0,0]]],XYZ:[[new Te(new Ri(.2,0),n)]],XY:[[new Te(new Ct(.2,.2,.01),n),[.15,.15,0]]],YZ:[[new Te(new Ct(.2,.2,.01),n),[0,.15,.15],[0,Math.PI/2,0]]],XZ:[[new Te(new Ct(.2,.2,.01),n),[.15,0,.15],[-Math.PI/2,0,0]]]},E={START:[[new Te(new Ri(.01,2),r),null,null,null,"helper"]],END:[[new Te(new Ri(.01,2),r),null,null,null,"helper"]],DELTA:[[new Xn(y(),r),null,null,null,"helper"]],X:[[new Xn(g,r.clone()),[-1e3,0,0],null,[1e6,1,1],"helper"]],Y:[[new Xn(g,r.clone()),[0,-1e3,0],[0,0,Math.PI/2],[1e6,1,1],"helper"]],Z:[[new Xn(g,r.clone()),[0,0,-1e3],[0,-Math.PI/2,0],[1e6,1,1],"helper"]]},x={XYZE:[[new Te(b(.5,1),m),null,[0,Math.PI/2,0]]],X:[[new Te(b(.5,.5),s)]],Y:[[new Te(b(.5,.5),a),null,[0,0,-Math.PI/2]]],Z:[[new Te(b(.5,.5),o),null,[0,Math.PI/2,0]]],E:[[new Te(b(.75,1),d),null,[0,Math.PI/2,0]]]},C={AXIS:[[new Xn(g,r.clone()),[-1e3,0,0],null,[1e6,1,1],"helper"]]},A={XYZE:[[new Te(new Ea(.25,10,8),n)]],X:[[new Te(new oi(.5,.1,4,24),n),[0,0,0],[0,-Math.PI/2,-Math.PI/2]]],Y:[[new Te(new oi(.5,.1,4,24),n),[0,0,0],[Math.PI/2,0,0]]],Z:[[new Te(new oi(.5,.1,4,24),n),[0,0,0],[0,0,-Math.PI/2]]],E:[[new Te(new oi(.75,.1,2,24),n)]]},D={X:[[new Te(_,s),[.5,0,0],[0,0,-Math.PI/2]],[new Te(v,s),[0,0,0],[0,0,-Math.PI/2]],[new Te(_,s),[-.5,0,0],[0,0,Math.PI/2]]],Y:[[new Te(_,a),[0,.5,0]],[new Te(v,a)],[new Te(_,a),[0,-.5,0],[0,0,Math.PI]]],Z:[[new Te(_,o),[0,0,.5],[Math.PI/2,0,0]],[new Te(v,o),[0,0,0],[Math.PI/2,0,0]],[new Te(_,o),[0,0,-.5],[-Math.PI/2,0,0]]],XY:[[new Te(new Ct(.15,.15,.01),u),[.15,.15,0]]],YZ:[[new Te(new Ct(.15,.15,.01),l),[0,.15,.15],[0,Math.PI/2,0]]],XZ:[[new Te(new Ct(.15,.15,.01),c),[.15,0,.15],[-Math.PI/2,0,0]]],XYZ:[[new Te(new Ct(.1,.1,.1),f.clone())]]},G={X:[[new Te(new Bt(.2,0,.6,4),n),[.3,0,0],[0,0,-Math.PI/2]],[new Te(new Bt(.2,0,.6,4),n),[-.3,0,0],[0,0,Math.PI/2]]],Y:[[new Te(new Bt(.2,0,.6,4),n),[0,.3,0]],[new Te(new Bt(.2,0,.6,4),n),[0,-.3,0],[0,0,Math.PI]]],Z:[[new Te(new Bt(.2,0,.6,4),n),[0,0,.3],[Math.PI/2,0,0]],[new Te(new Bt(.2,0,.6,4),n),[0,0,-.3],[-Math.PI/2,0,0]]],XY:[[new Te(new Ct(.2,.2,.01),n),[.15,.15,0]]],YZ:[[new Te(new Ct(.2,.2,.01),n),[0,.15,.15],[0,Math.PI/2,0]]],XZ:[[new Te(new Ct(.2,.2,.01),n),[.15,0,.15],[-Math.PI/2,0,0]]],XYZ:[[new Te(new Ct(.2,.2,.2),n),[0,0,0]]]},U={X:[[new Xn(g,r.clone()),[-1e3,0,0],null,[1e6,1,1],"helper"]],Y:[[new Xn(g,r.clone()),[0,-1e3,0],[0,0,Math.PI/2],[1e6,1,1],"helper"]],Z:[[new Xn(g,r.clone()),[0,0,-1e3],[0,-Math.PI/2,0],[1e6,1,1],"helper"]]};function z(X){const ae=new zt;for(const le in X)for(let $=X[le].length;$--;){const ne=X[le][$][0].clone(),ue=X[le][$][1],be=X[le][$][2],q=X[le][$][3],ce=X[le][$][4];ne.name=le,ne.tag=ce,ue&&ne.position.set(ue[0],ue[1],ue[2]),be&&ne.rotation.set(be[0],be[1],be[2]),q&&ne.scale.set(q[0],q[1],q[2]),ne.updateMatrix();const he=ne.geometry.clone();he.applyMatrix4(ne.matrix),ne.geometry=he,ne.renderOrder=1/0,ne.position.set(0,0,0),ne.rotation.set(0,0,0),ne.scale.set(1,1,1),ae.add(ne)}return ae}this.gizmo={},this.picker={},this.helper={},this.add(this.gizmo.translate=z(w)),this.add(this.gizmo.rotate=z(x)),this.add(this.gizmo.scale=z(D)),this.add(this.picker.translate=z(M)),this.add(this.picker.rotate=z(A)),this.add(this.picker.scale=z(G)),this.add(this.helper.translate=z(E)),this.add(this.helper.rotate=z(C)),this.add(this.helper.scale=z(U)),this.picker.translate.visible=!1,this.picker.rotate.visible=!1,this.picker.scale.visible=!1}updateMatrixWorld(e){const n=(this.mode==="scale"?"local":this.space)==="local"?this.worldQuaternion:ts;this.gizmo.translate.visible=this.mode==="translate",this.gizmo.rotate.visible=this.mode==="rotate",this.gizmo.scale.visible=this.mode==="scale",this.helper.translate.visible=this.mode==="translate",this.helper.rotate.visible=this.mode==="rotate",this.helper.scale.visible=this.mode==="scale";let r=[];r=r.concat(this.picker[this.mode].children),r=r.concat(this.gizmo[this.mode].children),r=r.concat(this.helper[this.mode].children);for(let s=0;s<r.length;s++){const a=r[s];a.visible=!0,a.rotation.set(0,0,0),a.position.copy(this.worldPosition);let o;if(this.camera.isOrthographicCamera?o=(this.camera.top-this.camera.bottom)/this.camera.zoom:o=this.worldPosition.distanceTo(this.cameraPosition)*Math.min(1.9*Math.tan(Math.PI*this.camera.fov/360)/this.camera.zoom,7),a.scale.set(1,1,1).multiplyScalar(o*this.size/4),a.tag==="helper"){a.visible=!1,a.name==="AXIS"?(a.visible=!!this.axis,this.axis==="X"&&(_t.setFromEuler(Zr.set(0,0,0)),a.quaternion.copy(n).multiply(_t),Math.abs(ut.copy(lr).applyQuaternion(n).dot(this.eye))>.9&&(a.visible=!1)),this.axis==="Y"&&(_t.setFromEuler(Zr.set(0,0,Math.PI/2)),a.quaternion.copy(n).multiply(_t),Math.abs(ut.copy(si).applyQuaternion(n).dot(this.eye))>.9&&(a.visible=!1)),this.axis==="Z"&&(_t.setFromEuler(Zr.set(0,Math.PI/2,0)),a.quaternion.copy(n).multiply(_t),Math.abs(ut.copy(cr).applyQuaternion(n).dot(this.eye))>.9&&(a.visible=!1)),this.axis==="XYZE"&&(_t.setFromEuler(Zr.set(0,Math.PI/2,0)),ut.copy(this.rotationAxis),a.quaternion.setFromRotationMatrix(dc.lookAt(fc,ut,si)),a.quaternion.multiply(_t),a.visible=this.dragging),this.axis==="E"&&(a.visible=!1)):a.name==="START"?(a.position.copy(this.worldPositionStart),a.visible=this.dragging):a.name==="END"?(a.position.copy(this.worldPosition),a.visible=this.dragging):a.name==="DELTA"?(a.position.copy(this.worldPositionStart),a.quaternion.copy(this.worldQuaternionStart),Jt.set(1e-10,1e-10,1e-10).add(this.worldPositionStart).sub(this.worldPosition).multiplyScalar(-1),Jt.applyQuaternion(this.worldQuaternionStart.clone().invert()),a.scale.copy(Jt),a.visible=this.dragging):(a.quaternion.copy(n),this.dragging?a.position.copy(this.worldPositionStart):a.position.copy(this.worldPosition),this.axis&&(a.visible=this.axis.search(a.name)!==-1));continue}a.quaternion.copy(n),this.mode==="translate"||this.mode==="scale"?(a.name==="X"&&Math.abs(ut.copy(lr).applyQuaternion(n).dot(this.eye))>.99&&(a.scale.set(1e-10,1e-10,1e-10),a.visible=!1),a.name==="Y"&&Math.abs(ut.copy(si).applyQuaternion(n).dot(this.eye))>.99&&(a.scale.set(1e-10,1e-10,1e-10),a.visible=!1),a.name==="Z"&&Math.abs(ut.copy(cr).applyQuaternion(n).dot(this.eye))>.99&&(a.scale.set(1e-10,1e-10,1e-10),a.visible=!1),a.name==="XY"&&Math.abs(ut.copy(cr).applyQuaternion(n).dot(this.eye))<.2&&(a.scale.set(1e-10,1e-10,1e-10),a.visible=!1),a.name==="YZ"&&Math.abs(ut.copy(lr).applyQuaternion(n).dot(this.eye))<.2&&(a.scale.set(1e-10,1e-10,1e-10),a.visible=!1),a.name==="XZ"&&Math.abs(ut.copy(si).applyQuaternion(n).dot(this.eye))<.2&&(a.scale.set(1e-10,1e-10,1e-10),a.visible=!1)):this.mode==="rotate"&&(Kr.copy(n),ut.copy(this.eye).applyQuaternion(_t.copy(n).invert()),a.name.search("E")!==-1&&a.quaternion.setFromRotationMatrix(dc.lookAt(this.eye,fc,si)),a.name==="X"&&(_t.setFromAxisAngle(lr,Math.atan2(-ut.y,ut.z)),_t.multiplyQuaternions(Kr,_t),a.quaternion.copy(_t)),a.name==="Y"&&(_t.setFromAxisAngle(si,Math.atan2(ut.x,ut.z)),_t.multiplyQuaternions(Kr,_t),a.quaternion.copy(_t)),a.name==="Z"&&(_t.setFromAxisAngle(cr,Math.atan2(ut.y,ut.x)),_t.multiplyQuaternions(Kr,_t),a.quaternion.copy(_t))),a.visible=a.visible&&(a.name.indexOf("X")===-1||this.showX),a.visible=a.visible&&(a.name.indexOf("Y")===-1||this.showY),a.visible=a.visible&&(a.name.indexOf("Z")===-1||this.showZ),a.visible=a.visible&&(a.name.indexOf("E")===-1||this.showX&&this.showY&&this.showZ),a.material._color=a.material._color||a.material.color.clone(),a.material._opacity=a.material._opacity||a.material.opacity,a.material.color.copy(a.material._color),a.material.opacity=a.material._opacity,this.enabled&&this.axis&&(a.name===this.axis||this.axis.split("").some(function(l){return a.name===l}))&&(a.material.color.setHex(16776960),a.material.opacity=1)}super.updateMatrixWorld(e)}}class x2 extends Te{constructor(){super(new gs(1e5,1e5,2,2),new _s({visible:!1,wireframe:!0,side:zn,transparent:!0,opacity:.1,toneMapped:!1})),this.isTransformControlsPlane=!0,this.type="TransformControlsPlane"}updateMatrixWorld(e){let t=this.space;switch(this.position.copy(this.worldPosition),this.mode==="scale"&&(t="local"),Jr.copy(lr).applyQuaternion(t==="local"?this.worldQuaternion:ts),nr.copy(si).applyQuaternion(t==="local"?this.worldQuaternion:ts),ir.copy(cr).applyQuaternion(t==="local"?this.worldQuaternion:ts),ut.copy(nr),this.mode){case"translate":case"scale":switch(this.axis){case"X":ut.copy(this.eye).cross(Jr),xn.copy(Jr).cross(ut);break;case"Y":ut.copy(this.eye).cross(nr),xn.copy(nr).cross(ut);break;case"Z":ut.copy(this.eye).cross(ir),xn.copy(ir).cross(ut);break;case"XY":xn.copy(ir);break;case"YZ":xn.copy(Jr);break;case"XZ":ut.copy(ir),xn.copy(nr);break;case"XYZ":case"E":xn.set(0,0,0);break}break;case"rotate":default:xn.set(0,0,0)}xn.length()===0?this.quaternion.copy(this.cameraQuaternion):(hc.lookAt(Jt.set(0,0,0),xn,ut),this.quaternion.setFromRotationMatrix(hc)),super.updateMatrixWorld(e)}}function pc(i){let e;return{c(){e=N("div"),L(e,"class","gizmo")},m(t,n){O(t,e,n)},d(t){t&&F(e)}}}function M2(i){let e,t=i[0].handle&&pc();return{c(){t&&t.c(),e=Zt()},m(n,r){t&&t.m(n,r),O(n,e,r)},p(n,[r]){n[0].handle?t||(t=pc(),t.c(),t.m(e.parentNode,e)):t&&(t.d(1),t=null)},i:ge,o:ge,d(n){t&&t.d(n),n&&F(e)}}}function mc(i,e){return i>0&&i<90?e:i>-180&&i<-90||i>0?-e:e}function S2(i,e,t){let n,r,{gizmoData:s,gizmoCamData:a}=fr;ft(i,s,E=>t(0,r=E)),ft(i,a,E=>t(5,n=E)),at(()=>{r.handle&&(y(r),v(),M(),g())});let o,l,c,u,f,d,p,m,h,_=!1;function g(){f&&f.render(u,l)}function v(){f=new Ca({alpha:!0}),f.setPixelRatio(window.devicePixelRatio),f.setSize(window.innerWidth,window.innerHeight),document.body.appendChild(f.domElement);const E=window.innerWidth/window.innerHeight;o=new dn(45,E,.01),l=o,l.lookAt(0,200,0),d=new m2(l,f.domElement),d.addEventListener("change",g),d.addEventListener("objectChange",x=>{_||b()}),d.attach(c),d.showX=!0,d.showY=!0,d.showZ=!0,d.size=.5,u.add(d),window.addEventListener("keydown",async function(x){if(!_)switch(x.keyCode){case 90:d.setMode("translate");break;case 82:d.setMode("rotate");break;case 27:await Ne("closeGizmo"),w();break;case 69:await Ne("placeObject"),await Ne("closeGizmo"),w();break}})}function b(){const E={handle:p,position:{x:c.position.x,y:-c.position.z,z:c.position.y},rotation:{x:Ln.radToDeg(c.rotation.x),y:Ln.radToDeg(-c.rotation.z),z:Ln.radToDeg(c.rotation.y)}};Ne("gizmo-object-update",E)}function y(E){!E.handle||(u=new h2,c=new Te,u.add(c),t(3,p=E.handle),c.position.set(E.position.x,E.position.z,-E.position.y),c.rotation.order="YZX",c.rotation.set(Ln.degToRad(E.rotation.x),Ln.degToRad(mc(E.rotation.x,E.rotation.z)),Ln.degToRad(E.rotation.y)))}function w(){_=!0,f.domElement.remove(),t(3,p=null),u.remove(c),f=null,c=null,t(4,m=null),h=null,l=null,d=null}function M(){_||(t(4,m=n.camCords),h=n.camRot,l.position.set(m.x,m.z,-m.y),l.rotation.order="YZX",l.rotation.set(Ln.degToRad(h.x),Ln.degToRad(mc(h.x,h.z)),Ln.degToRad(h.y)))}return i.$$.update=()=>{i.$$.dirty&56&&n.camCords!==m&&p&&M()},[r,s,a,p,m,n]}class C2 extends Ze{constructor(e){super(),Ye(this,e,S2,M2,qe,{})}}function T2(i){let e,t,n,r,s,a,o,l,c,u,f,d,p;return{c(){e=N("div"),t=N("div"),t.textContent="Key Binds",n=Y(),r=N("div"),s=N("p"),s.textContent=`${i[1].press_Z_gizmo_helper}`,a=Y(),o=N("p"),o.textContent=`${i[1].press_R_gizmo_helper}`,l=Y(),c=N("p"),c.textContent=`${i[1].press_E_gizmo_helper}`,u=Y(),f=N("p"),f.textContent=`${i[1].press_esc_gizmo_helper}`,d=Y(),p=N("p"),p.textContent=`${i[1].press_alt_gizmo_helper}`,L(t,"class","heading"),L(r,"class","body"),L(e,"class","gizmo-helper-main")},m(m,h){O(m,e,h),S(e,t),S(e,n),S(e,r),S(r,s),S(r,a),S(r,o),S(r,l),S(r,c),S(r,u),S(r,f),S(r,d),S(r,p)},p:ge,i:ge,o:ge,d(m){m&&F(e)}}}function E2(i,e,t){let n,{locales:r}=vt;return ft(i,r,a=>t(2,n=a)),[r,n]}class L2 extends Ze{constructor(e){super(),Ye(this,e,E2,T2,qe,{})}}function P2(i){let e,t,n,r;return e=new C2({}),n=new L2({}),{c(){Q(e.$$.fragment),t=Y(),Q(n.$$.fragment)},m(s,a){K(e,s,a),O(s,t,a),K(n,s,a),r=!0},i(s){r||(k(e.$$.fragment,s),k(n.$$.fragment,s),r=!0)},o(s){I(e.$$.fragment,s),I(n.$$.fragment,s),r=!1},d(s){J(e,s),s&&F(t),J(n,s)}}}function A2(i){let e,t;return e=new Yp({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function D2(i){let e,t;return e=new Hp({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function _c(i){let e,t;return e=new Kp({}),{c(){Q(e.$$.fragment)},m(n,r){K(e,n,r),t=!0},i(n){t||(k(e.$$.fragment,n),t=!0)},o(n){I(e.$$.fragment,n),t=!1},d(n){J(e,n)}}}function R2(i){let e,t,n,r,s;const a=[D2,A2,P2],o=[];function l(u,f){return u[0]?0:u[1]?1:u[2]?2:-1}~(e=l(i))&&(t=o[e]=a[e](i));let c=i[3]&&_c();return{c(){t&&t.c(),n=Y(),c&&c.c(),r=Zt()},m(u,f){~e&&o[e].m(u,f),O(u,n,f),c&&c.m(u,f),O(u,r,f),s=!0},p(u,[f]){let d=e;e=l(u),e!==d&&(t&&(Ve(),I(o[d],1,1,()=>{o[d]=null}),Ge()),~e?(t=o[e],t||(t=o[e]=a[e](u),t.c()),k(t,1),t.m(n.parentNode,n)):t=null),u[3]?c?f&8&&k(c,1):(c=_c(),c.c(),k(c,1),c.m(r.parentNode,r)):c&&(Ve(),I(c,1,1,()=>{c=null}),Ge())},i(u){s||(k(t),k(c),s=!0)},o(u){I(t),I(c),s=!1},d(u){~e&&o[e].d(u),u&&F(n),c&&c.d(u),u&&F(r)}}}function k2(i,e,t){let n,r,s,a;Fu();let{show:o}=vt;ft(i,o,f=>t(0,n=f));let{showReport:l}=mr;ft(i,l,f=>t(1,r=f));let{unreadReport:c}=aa;ft(i,c,f=>t(3,a=f));let{showObject:u}=fr;return ft(i,u,f=>t(2,s=f)),document.onkeyup=vt.handleKeyUp,[n,r,s,a,o,l,c,u]}class I2 extends Ze{constructor(e){super(),Ye(this,e,k2,R2,qe,{})}}new I2({target:document.getElementById("app")});
