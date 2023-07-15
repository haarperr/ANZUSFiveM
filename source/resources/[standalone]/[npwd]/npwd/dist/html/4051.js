/*! For license information please see 4051.js.LICENSE.txt */
"use strict";(self.webpackChunk_npwd_nui=self.webpackChunk_npwd_nui||[]).push([[4051,5472],{79884:function(t,e,n){var r=n(10262),i=n(63223),a=n(53182),o=n(14517),s=n(15452),u=n(12817),l=n(17153),h=n(98202),c=n(85602),d=n(81929),f=n(84963),m=n(61250);const p=["animation","className","component","height","style","variant","width"];let g,v,w,y,b=t=>t;const k=(0,s.keyframes)(g||(g=b`
  0% {
    opacity: 1;
  }

  50% {
    opacity: 0.4;
  }

  100% {
    opacity: 1;
  }
`)),S=(0,s.keyframes)(v||(v=b`
  0% {
    transform: translateX(-100%);
  }

  50% {
    /* +0.5s of delay between each loop */
    transform: translateX(100%);
  }

  100% {
    transform: translateX(100%);
  }
`)),_=(0,c.ZP)("span",{name:"MuiSkeleton",slot:"Root",overridesResolver:(t,e)=>{const{ownerState:n}=t;return[e.root,e[n.variant],!1!==n.animation&&e[n.animation],n.hasChildren&&e.withChildren,n.hasChildren&&!n.width&&e.fitContent,n.hasChildren&&!n.height&&e.heightAuto]}})((({theme:t,ownerState:e})=>{const n=(0,l.Wy)(t.shape.borderRadius)||"px",r=(0,l.YL)(t.shape.borderRadius);return(0,i.Z)({display:"block",backgroundColor:t.vars?t.vars.palette.Skeleton.bg:(0,h.Fq)(t.palette.text.primary,"light"===t.palette.mode?.11:.13),height:"1.2em"},"text"===e.variant&&{marginTop:0,marginBottom:0,height:"auto",transformOrigin:"0 55%",transform:"scale(1, 0.60)",borderRadius:`${r}${n}/${Math.round(r/.6*10)/10}${n}`,"&:empty:before":{content:'"\\00a0"'}},"circular"===e.variant&&{borderRadius:"50%"},"rounded"===e.variant&&{borderRadius:(t.vars||t).shape.borderRadius},e.hasChildren&&{"& > *":{visibility:"hidden"}},e.hasChildren&&!e.width&&{maxWidth:"fit-content"},e.hasChildren&&!e.height&&{height:"auto"})}),(({ownerState:t})=>"pulse"===t.animation&&(0,s.css)(w||(w=b`
      animation: ${0} 1.5s ease-in-out 0.5s infinite;
    `),k)),(({ownerState:t,theme:e})=>"wave"===t.animation&&(0,s.css)(y||(y=b`
      position: relative;
      overflow: hidden;

      /* Fix bug in Safari https://bugs.webkit.org/show_bug.cgi?id=68196 */
      -webkit-mask-image: -webkit-radial-gradient(white, black);

      &::after {
        animation: ${0} 1.6s linear 0.5s infinite;
        background: linear-gradient(
          90deg,
          transparent,
          ${0},
          transparent
        );
        content: '';
        position: absolute;
        transform: translateX(-100%); /* Avoid flash during server-side hydration */
        bottom: 0;
        left: 0;
        right: 0;
        top: 0;
      }
    `),S,(e.vars||e).palette.action.hover))),C=a.forwardRef((function(t,e){const n=(0,d.Z)({props:t,name:"MuiSkeleton"}),{animation:a="pulse",className:s,component:l="span",height:h,style:c,variant:g="text",width:v}=n,w=(0,r.Z)(n,p),y=(0,i.Z)({},n,{animation:a,component:l,variant:g,hasChildren:Boolean(w.children)}),b=(t=>{const{classes:e,variant:n,animation:r,hasChildren:i,width:a,height:o}=t,s={root:["root",n,r,i&&"withChildren",i&&!a&&"fitContent",i&&!o&&"heightAuto"]};return(0,u.Z)(s,f.B,e)})(y);return(0,m.jsx)(_,(0,i.Z)({as:l,ref:e,className:(0,o.Z)(b.root,s),ownerState:y},w,{style:(0,i.Z)({width:v,height:h},c)}))}));e.Z=C},84963:function(t,e,n){n.d(e,{B:function(){return a}});var r=n(51270),i=n(13665);function a(t){return(0,i.Z)("MuiSkeleton",t)}const o=(0,r.Z)("MuiSkeleton",["root","text","rectangular","rounded","circular","pulse","wave","withChildren","fitContent","heightAuto"]);e.Z=o},17153:function(t,e,n){function r(t){return String(parseFloat(t)).length===String(t).length}function i(t){return String(t).match(/[\d.\-+]*\s*(.*)/)[1]||""}function a(t){return parseFloat(t)}function o(t){return(e,n)=>{const r=i(e);if(r===n)return e;let o=a(e);"px"!==r&&("em"===r||"rem"===r)&&(o=a(e)*a(t));let s=o;if("px"!==n)if("em"===n)s=o/a(t);else{if("rem"!==n)return e;s=o/a(t)}return parseFloat(s.toFixed(5))+n}}function s({size:t,grid:e}){const n=t-t%e,r=n+e;return t-n<r-t?n:r}function u({lineHeight:t,pixels:e,htmlFontSize:n}){return e/(t*n)}function l({cssProperty:t,min:e,max:n,unit:r="rem",breakpoints:i=[600,900,1200],transform:a=null}){const o={[t]:`${e}${r}`},s=(n-e)/i[i.length-1];return i.forEach((n=>{let i=e+s*n;null!==a&&(i=a(i)),o[`@media (min-width:${n}px)`]={[t]:`${Math.round(1e4*i)/1e4}${r}`}})),o}n.d(e,{LV:function(){return s},Wy:function(){return i},YL:function(){return a},dA:function(){return r},vY:function(){return u},vs:function(){return o},ze:function(){return l}})},95472:function(t,e,n){n(52458);var r=n(53182),i=60103;if(e.Fragment=60107,"function"==typeof Symbol&&Symbol.for){var a=Symbol.for;i=a("react.element"),e.Fragment=a("react.fragment")}var o=r.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,s=Object.prototype.hasOwnProperty,u={key:!0,ref:!0,__self:!0,__source:!0};function l(t,e,n){var r,a={},l=null,h=null;for(r in void 0!==n&&(l=""+n),void 0!==e.key&&(l=""+e.key),void 0!==e.ref&&(h=e.ref),e)s.call(e,r)&&!u.hasOwnProperty(r)&&(a[r]=e[r]);if(t&&t.defaultProps)for(r in e=t.defaultProps)void 0===a[r]&&(a[r]=e[r]);return{$$typeof:i,type:t,key:l,ref:h,props:a,_owner:o.current}}e.jsx=l,e.jsxs=l}}]);