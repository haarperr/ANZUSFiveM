"use strict";(self.webpackChunknpwd_qb_racing=self.webpackChunknpwd_qb_racing||[]).push([[353],{5042:(e,r,t)=>{t.d(r,{Z:()=>n});const n=function(e){var r=Object.create(null);return function(t){return void 0===r[t]&&(r[t]=e(t)),r[t]}}},9729:(e,r,t)=>{t.d(r,{O:()=>p});const n=function(e){for(var r,t=0,n=0,o=e.length;o>=4;++n,o-=4)r=1540483477*(65535&(r=255&e.charCodeAt(n)|(255&e.charCodeAt(++n))<<8|(255&e.charCodeAt(++n))<<16|(255&e.charCodeAt(++n))<<24))+(59797*(r>>>16)<<16),t=1540483477*(65535&(r^=r>>>24))+(59797*(r>>>16)<<16)^1540483477*(65535&t)+(59797*(t>>>16)<<16);switch(o){case 3:t^=(255&e.charCodeAt(n+2))<<16;case 2:t^=(255&e.charCodeAt(n+1))<<8;case 1:t=1540483477*(65535&(t^=255&e.charCodeAt(n)))+(59797*(t>>>16)<<16)}return(((t=1540483477*(65535&(t^=t>>>13))+(59797*(t>>>16)<<16))^t>>>15)>>>0).toString(36)},o={animationIterationCount:1,borderImageOutset:1,borderImageSlice:1,borderImageWidth:1,boxFlex:1,boxFlexGroup:1,boxOrdinalGroup:1,columnCount:1,columns:1,flex:1,flexGrow:1,flexPositive:1,flexShrink:1,flexNegative:1,flexOrder:1,gridRow:1,gridRowEnd:1,gridRowSpan:1,gridRowStart:1,gridColumn:1,gridColumnEnd:1,gridColumnSpan:1,gridColumnStart:1,msGridRow:1,msGridRowSpan:1,msGridColumn:1,msGridColumnSpan:1,fontWeight:1,lineHeight:1,opacity:1,order:1,orphans:1,tabSize:1,widows:1,zIndex:1,zoom:1,WebkitLineClamp:1,fillOpacity:1,floodOpacity:1,stopOpacity:1,strokeDasharray:1,strokeDashoffset:1,strokeMiterlimit:1,strokeOpacity:1,strokeWidth:1};var i=t(5042),a=/[A-Z]|^ms/g,s=/_EMO_([^_]+?)_([^]*?)_EMO_/g,l=function(e){return 45===e.charCodeAt(1)},u=function(e){return null!=e&&"boolean"!=typeof e},c=(0,i.Z)((function(e){return l(e)?e:e.replace(a,"-$&").toLowerCase()})),f=function(e,r){switch(e){case"animation":case"animationName":if("string"==typeof r)return r.replace(s,(function(e,r,t){return v={name:r,styles:t,next:v},r}))}return 1===o[e]||l(e)||"number"!=typeof r||0===r?r:r+"px"};function d(e,r,t){if(null==t)return"";if(void 0!==t.__emotion_styles)return t;switch(typeof t){case"boolean":return"";case"object":if(1===t.anim)return v={name:t.name,styles:t.styles,next:v},t.name;if(void 0!==t.styles){var n=t.next;if(void 0!==n)for(;void 0!==n;)v={name:n.name,styles:n.styles,next:v},n=n.next;return t.styles+";"}return function(e,r,t){var n="";if(Array.isArray(t))for(var o=0;o<t.length;o++)n+=d(e,r,t[o])+";";else for(var i in t){var a=t[i];if("object"!=typeof a)null!=r&&void 0!==r[a]?n+=i+"{"+r[a]+"}":u(a)&&(n+=c(i)+":"+f(i,a)+";");else if(!Array.isArray(a)||"string"!=typeof a[0]||null!=r&&void 0!==r[a[0]]){var s=d(e,r,a);switch(i){case"animation":case"animationName":n+=c(i)+":"+s+";";break;default:n+=i+"{"+s+"}"}}else for(var l=0;l<a.length;l++)u(a[l])&&(n+=c(i)+":"+f(i,a[l])+";")}return n}(e,r,t);case"function":if(void 0!==e){var o=v,i=t(e);return v=o,d(e,r,i)}}if(null==r)return t;var a=r[t];return void 0!==a?a:t}var v,m=/label:\s*([^\s;\n{]+)\s*(;|$)/g,p=function(e,r,t){if(1===e.length&&"object"==typeof e[0]&&null!==e[0]&&void 0!==e[0].styles)return e[0];var o=!0,i="";v=void 0;var a=e[0];null==a||void 0===a.raw?(o=!1,i+=d(t,r,a)):i+=a[0];for(var s=1;s<e.length;s++)i+=d(t,r,e[s]),o&&(i+=a[s]);m.lastIndex=0;for(var l,u="";null!==(l=m.exec(i));)u+="-"+l[1];return{name:n(i)+u,styles:i,next:v}}},444:(e,r,t)=>{function n(e,r,t){var n="";return t.split(" ").forEach((function(t){void 0!==e[t]?r.push(e[t]+";"):n+=t+" "})),n}t.d(r,{fp:()=>n,My:()=>i,hC:()=>o});var o=function(e,r,t){var n=e.key+"-"+r.name;!1===t&&void 0===e.registered[n]&&(e.registered[n]=r.styles)},i=function(e,r,t){o(e,r,t);var n=e.key+"-"+r.name;if(void 0===e.inserted[r.name]){var i=r;do{e.insert(r===i?"."+n:"",i,e.sheet,!0),i=i.next}while(void 0!==i)}}},7462:(e,r,t)=>{function n(){return n=Object.assign?Object.assign.bind():function(e){for(var r=1;r<arguments.length;r++){var t=arguments[r];for(var n in t)Object.prototype.hasOwnProperty.call(t,n)&&(e[n]=t[n])}return e},n.apply(this,arguments)}t.d(r,{Z:()=>n})}}]);
//# sourceMappingURL=data:application/json;charset=utf-8;base64,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RUFFZCxHQUNvQmhILEVBQU1xSCxPQUFPTCxJQUFlSSxFQUFVLElBQU1QLEVBQVksR0FBSU8sRUFBU3BILEVBQU1zSCxPQUFPLEdBRXBHRixFQUFVQSxFQUFReEMsZ0JBQ0N4RSxJQUFaZ0gsRUFDWCxDQUNGLEMsaUJDekNlLFNBQVNHLElBY3RCLE9BYkFBLEVBQVd0SCxPQUFPdUgsT0FBU3ZILE9BQU91SCxPQUFPQyxPQUFTLFNBQVVDLEdBQzFELElBQUssSUFBSWxILEVBQUksRUFBR0EsRUFBSW1ILFVBQVVqSCxPQUFRRixJQUFLLENBQ3pDLElBQUlvSCxFQUFTRCxVQUFVbkgsR0FFdkIsSUFBSyxJQUFJNkQsS0FBT3VELEVBQ1YzSCxPQUFPNEgsVUFBVUMsZUFBZUMsS0FBS0gsRUFBUXZELEtBQy9DcUQsRUFBT3JELEdBQU91RCxFQUFPdkQsR0FHM0IsQ0FFQSxPQUFPcUQsQ0FDVCxFQUNPSCxFQUFTUyxNQUFNQyxLQUFNTixVQUM5QixDIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vbnB3ZF9xYl9yYWNpbmcvLi9ub2RlX21vZHVsZXMvQGVtb3Rpb24vbWVtb2l6ZS9kaXN0L2Vtb3Rpb24tbWVtb2l6ZS5lc20uanMiLCJ3ZWJwYWNrOi8vbnB3ZF9xYl9yYWNpbmcvLi9ub2RlX21vZHVsZXMvQGVtb3Rpb24vaGFzaC9kaXN0L2Vtb3Rpb24taGFzaC5lc20uanMiLCJ3ZWJwYWNrOi8vbnB3ZF9xYl9yYWNpbmcvLi9ub2RlX21vZHVsZXMvQGVtb3Rpb24vc2VyaWFsaXplL25vZGVfbW9kdWxlcy9AZW1vdGlvbi91bml0bGVzcy9kaXN0L2Vtb3Rpb24tdW5pdGxlc3MuZXNtLmpzIiwid2VicGFjazovL25wd2RfcWJfcmFjaW5nLy4vbm9kZV9tb2R1bGVzL0BlbW90aW9uL3NlcmlhbGl6ZS9kaXN0L2Vtb3Rpb24tc2VyaWFsaXplLmJyb3dzZXIuZXNtLmpzIiwid2VicGFjazovL25wd2RfcWJfcmFjaW5nLy4vbm9kZV9tb2R1bGVzL0BlbW90aW9uL3V0aWxzL2Rpc3QvZW1vdGlvbi11dGlscy5icm93c2VyLmVzbS5qcyIsIndlYnBhY2s6Ly9ucHdkX3FiX3JhY2luZy8uL25vZGVfbW9kdWxlcy9AYmFiZWwvcnVudGltZS9oZWxwZXJzL2VzbS9leHRlbmRzLmpzIl0sInNvdXJjZXNDb250ZW50IjpbImZ1bmN0aW9uIG1lbW9pemUoZm4pIHtcbiAgdmFyIGNhY2hlID0gT2JqZWN0LmNyZWF0ZShudWxsKTtcbiAgcmV0dXJuIGZ1bmN0aW9uIChhcmcpIHtcbiAgICBpZiAoY2FjaGVbYXJnXSA9PT0gdW5kZWZpbmVkKSBjYWNoZVthcmddID0gZm4oYXJnKTtcbiAgICByZXR1cm4gY2FjaGVbYXJnXTtcbiAgfTtcbn1cblxuZXhwb3J0IGRlZmF1bHQgbWVtb2l6ZTtcbiIsIi8qIGVzbGludC1kaXNhYmxlICovXG4vLyBJbnNwaXJlZCBieSBodHRwczovL2dpdGh1Yi5jb20vZ2FyeWNvdXJ0L211cm11cmhhc2gtanNcbi8vIFBvcnRlZCBmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9hYXBwbGVieS9zbWhhc2hlci9ibG9iLzYxYTA1MzBmMjgyNzdmMmU4NTBiZmMzOTYwMGNlNjFkMDJiNTE4ZGUvc3JjL011cm11ckhhc2gyLmNwcCNMMzctTDg2XG5mdW5jdGlvbiBtdXJtdXIyKHN0cikge1xuICAvLyAnbScgYW5kICdyJyBhcmUgbWl4aW5nIGNvbnN0YW50cyBnZW5lcmF0ZWQgb2ZmbGluZS5cbiAgLy8gVGhleSdyZSBub3QgcmVhbGx5ICdtYWdpYycsIHRoZXkganVzdCBoYXBwZW4gdG8gd29yayB3ZWxsLlxuICAvLyBjb25zdCBtID0gMHg1YmQxZTk5NTtcbiAgLy8gY29uc3QgciA9IDI0O1xuICAvLyBJbml0aWFsaXplIHRoZSBoYXNoXG4gIHZhciBoID0gMDsgLy8gTWl4IDQgYnl0ZXMgYXQgYSB0aW1lIGludG8gdGhlIGhhc2hcblxuICB2YXIgayxcbiAgICAgIGkgPSAwLFxuICAgICAgbGVuID0gc3RyLmxlbmd0aDtcblxuICBmb3IgKDsgbGVuID49IDQ7ICsraSwgbGVuIC09IDQpIHtcbiAgICBrID0gc3RyLmNoYXJDb2RlQXQoaSkgJiAweGZmIHwgKHN0ci5jaGFyQ29kZUF0KCsraSkgJiAweGZmKSA8PCA4IHwgKHN0ci5jaGFyQ29kZUF0KCsraSkgJiAweGZmKSA8PCAxNiB8IChzdHIuY2hhckNvZGVBdCgrK2kpICYgMHhmZikgPDwgMjQ7XG4gICAgayA9XG4gICAgLyogTWF0aC5pbXVsKGssIG0pOiAqL1xuICAgIChrICYgMHhmZmZmKSAqIDB4NWJkMWU5OTUgKyAoKGsgPj4+IDE2KSAqIDB4ZTk5NSA8PCAxNik7XG4gICAgayBePVxuICAgIC8qIGsgPj4+IHI6ICovXG4gICAgayA+Pj4gMjQ7XG4gICAgaCA9XG4gICAgLyogTWF0aC5pbXVsKGssIG0pOiAqL1xuICAgIChrICYgMHhmZmZmKSAqIDB4NWJkMWU5OTUgKyAoKGsgPj4+IDE2KSAqIDB4ZTk5NSA8PCAxNikgXlxuICAgIC8qIE1hdGguaW11bChoLCBtKTogKi9cbiAgICAoaCAmIDB4ZmZmZikgKiAweDViZDFlOTk1ICsgKChoID4+PiAxNikgKiAweGU5OTUgPDwgMTYpO1xuICB9IC8vIEhhbmRsZSB0aGUgbGFzdCBmZXcgYnl0ZXMgb2YgdGhlIGlucHV0IGFycmF5XG5cblxuICBzd2l0Y2ggKGxlbikge1xuICAgIGNhc2UgMzpcbiAgICAgIGggXj0gKHN0ci5jaGFyQ29kZUF0KGkgKyAyKSAmIDB4ZmYpIDw8IDE2O1xuXG4gICAgY2FzZSAyOlxuICAgICAgaCBePSAoc3RyLmNoYXJDb2RlQXQoaSArIDEpICYgMHhmZikgPDwgODtcblxuICAgIGNhc2UgMTpcbiAgICAgIGggXj0gc3RyLmNoYXJDb2RlQXQoaSkgJiAweGZmO1xuICAgICAgaCA9XG4gICAgICAvKiBNYXRoLmltdWwoaCwgbSk6ICovXG4gICAgICAoaCAmIDB4ZmZmZikgKiAweDViZDFlOTk1ICsgKChoID4+PiAxNikgKiAweGU5OTUgPDwgMTYpO1xuICB9IC8vIERvIGEgZmV3IGZpbmFsIG1peGVzIG9mIHRoZSBoYXNoIHRvIGVuc3VyZSB0aGUgbGFzdCBmZXdcbiAgLy8gYnl0ZXMgYXJlIHdlbGwtaW5jb3Jwb3JhdGVkLlxuXG5cbiAgaCBePSBoID4+PiAxMztcbiAgaCA9XG4gIC8qIE1hdGguaW11bChoLCBtKTogKi9cbiAgKGggJiAweGZmZmYpICogMHg1YmQxZTk5NSArICgoaCA+Pj4gMTYpICogMHhlOTk1IDw8IDE2KTtcbiAgcmV0dXJuICgoaCBeIGggPj4+IDE1KSA+Pj4gMCkudG9TdHJpbmcoMzYpO1xufVxuXG5leHBvcnQgZGVmYXVsdCBtdXJtdXIyO1xuIiwidmFyIHVuaXRsZXNzS2V5cyA9IHtcbiAgYW5pbWF0aW9uSXRlcmF0aW9uQ291bnQ6IDEsXG4gIGJvcmRlckltYWdlT3V0c2V0OiAxLFxuICBib3JkZXJJbWFnZVNsaWNlOiAxLFxuICBib3JkZXJJbWFnZVdpZHRoOiAxLFxuICBib3hGbGV4OiAxLFxuICBib3hGbGV4R3JvdXA6IDEsXG4gIGJveE9yZGluYWxHcm91cDogMSxcbiAgY29sdW1uQ291bnQ6IDEsXG4gIGNvbHVtbnM6IDEsXG4gIGZsZXg6IDEsXG4gIGZsZXhHcm93OiAxLFxuICBmbGV4UG9zaXRpdmU6IDEsXG4gIGZsZXhTaHJpbms6IDEsXG4gIGZsZXhOZWdhdGl2ZTogMSxcbiAgZmxleE9yZGVyOiAxLFxuICBncmlkUm93OiAxLFxuICBncmlkUm93RW5kOiAxLFxuICBncmlkUm93U3BhbjogMSxcbiAgZ3JpZFJvd1N0YXJ0OiAxLFxuICBncmlkQ29sdW1uOiAxLFxuICBncmlkQ29sdW1uRW5kOiAxLFxuICBncmlkQ29sdW1uU3BhbjogMSxcbiAgZ3JpZENvbHVtblN0YXJ0OiAxLFxuICBtc0dyaWRSb3c6IDEsXG4gIG1zR3JpZFJvd1NwYW46IDEsXG4gIG1zR3JpZENvbHVtbjogMSxcbiAgbXNHcmlkQ29sdW1uU3BhbjogMSxcbiAgZm9udFdlaWdodDogMSxcbiAgbGluZUhlaWdodDogMSxcbiAgb3BhY2l0eTogMSxcbiAgb3JkZXI6IDEsXG4gIG9ycGhhbnM6IDEsXG4gIHRhYlNpemU6IDEsXG4gIHdpZG93czogMSxcbiAgekluZGV4OiAxLFxuICB6b29tOiAxLFxuICBXZWJraXRMaW5lQ2xhbXA6IDEsXG4gIC8vIFNWRy1yZWxhdGVkIHByb3BlcnRpZXNcbiAgZmlsbE9wYWNpdHk6IDEsXG4gIGZsb29kT3BhY2l0eTogMSxcbiAgc3RvcE9wYWNpdHk6IDEsXG4gIHN0cm9rZURhc2hhcnJheTogMSxcbiAgc3Ryb2tlRGFzaG9mZnNldDogMSxcbiAgc3Ryb2tlTWl0ZXJsaW1pdDogMSxcbiAgc3Ryb2tlT3BhY2l0eTogMSxcbiAgc3Ryb2tlV2lkdGg6IDFcbn07XG5cbmV4cG9ydCBkZWZhdWx0IHVuaXRsZXNzS2V5cztcbiIsImltcG9ydCBoYXNoU3RyaW5nIGZyb20gJ0BlbW90aW9uL2hhc2gnO1xuaW1wb3J0IHVuaXRsZXNzIGZyb20gJ0BlbW90aW9uL3VuaXRsZXNzJztcbmltcG9ydCBtZW1vaXplIGZyb20gJ0BlbW90aW9uL21lbW9pemUnO1xuXG52YXIgSUxMRUdBTF9FU0NBUEVfU0VRVUVOQ0VfRVJST1IgPSBcIllvdSBoYXZlIGlsbGVnYWwgZXNjYXBlIHNlcXVlbmNlIGluIHlvdXIgdGVtcGxhdGUgbGl0ZXJhbCwgbW9zdCBsaWtlbHkgaW5zaWRlIGNvbnRlbnQncyBwcm9wZXJ0eSB2YWx1ZS5cXG5CZWNhdXNlIHlvdSB3cml0ZSB5b3VyIENTUyBpbnNpZGUgYSBKYXZhU2NyaXB0IHN0cmluZyB5b3UgYWN0dWFsbHkgaGF2ZSB0byBkbyBkb3VibGUgZXNjYXBpbmcsIHNvIGZvciBleGFtcGxlIFxcXCJjb250ZW50OiAnXFxcXDAwZDcnO1xcXCIgc2hvdWxkIGJlY29tZSBcXFwiY29udGVudDogJ1xcXFxcXFxcMDBkNyc7XFxcIi5cXG5Zb3UgY2FuIHJlYWQgbW9yZSBhYm91dCB0aGlzIGhlcmU6XFxuaHR0cHM6Ly9kZXZlbG9wZXIubW96aWxsYS5vcmcvZW4tVVMvZG9jcy9XZWIvSmF2YVNjcmlwdC9SZWZlcmVuY2UvVGVtcGxhdGVfbGl0ZXJhbHMjRVMyMDE4X3JldmlzaW9uX29mX2lsbGVnYWxfZXNjYXBlX3NlcXVlbmNlc1wiO1xudmFyIFVOREVGSU5FRF9BU19PQkpFQ1RfS0VZX0VSUk9SID0gXCJZb3UgaGF2ZSBwYXNzZWQgaW4gZmFsc3kgdmFsdWUgYXMgc3R5bGUgb2JqZWN0J3Mga2V5IChjYW4gaGFwcGVuIHdoZW4gaW4gZXhhbXBsZSB5b3UgcGFzcyB1bmV4cG9ydGVkIGNvbXBvbmVudCBhcyBjb21wdXRlZCBrZXkpLlwiO1xudmFyIGh5cGhlbmF0ZVJlZ2V4ID0gL1tBLVpdfF5tcy9nO1xudmFyIGFuaW1hdGlvblJlZ2V4ID0gL19FTU9fKFteX10rPylfKFteXSo/KV9FTU9fL2c7XG5cbnZhciBpc0N1c3RvbVByb3BlcnR5ID0gZnVuY3Rpb24gaXNDdXN0b21Qcm9wZXJ0eShwcm9wZXJ0eSkge1xuICByZXR1cm4gcHJvcGVydHkuY2hhckNvZGVBdCgxKSA9PT0gNDU7XG59O1xuXG52YXIgaXNQcm9jZXNzYWJsZVZhbHVlID0gZnVuY3Rpb24gaXNQcm9jZXNzYWJsZVZhbHVlKHZhbHVlKSB7XG4gIHJldHVybiB2YWx1ZSAhPSBudWxsICYmIHR5cGVvZiB2YWx1ZSAhPT0gJ2Jvb2xlYW4nO1xufTtcblxudmFyIHByb2Nlc3NTdHlsZU5hbWUgPSAvKiAjX19QVVJFX18gKi9tZW1vaXplKGZ1bmN0aW9uIChzdHlsZU5hbWUpIHtcbiAgcmV0dXJuIGlzQ3VzdG9tUHJvcGVydHkoc3R5bGVOYW1lKSA/IHN0eWxlTmFtZSA6IHN0eWxlTmFtZS5yZXBsYWNlKGh5cGhlbmF0ZVJlZ2V4LCAnLSQmJykudG9Mb3dlckNhc2UoKTtcbn0pO1xuXG52YXIgcHJvY2Vzc1N0eWxlVmFsdWUgPSBmdW5jdGlvbiBwcm9jZXNzU3R5bGVWYWx1ZShrZXksIHZhbHVlKSB7XG4gIHN3aXRjaCAoa2V5KSB7XG4gICAgY2FzZSAnYW5pbWF0aW9uJzpcbiAgICBjYXNlICdhbmltYXRpb25OYW1lJzpcbiAgICAgIHtcbiAgICAgICAgaWYgKHR5cGVvZiB2YWx1ZSA9PT0gJ3N0cmluZycpIHtcbiAgICAgICAgICByZXR1cm4gdmFsdWUucmVwbGFjZShhbmltYXRpb25SZWdleCwgZnVuY3Rpb24gKG1hdGNoLCBwMSwgcDIpIHtcbiAgICAgICAgICAgIGN1cnNvciA9IHtcbiAgICAgICAgICAgICAgbmFtZTogcDEsXG4gICAgICAgICAgICAgIHN0eWxlczogcDIsXG4gICAgICAgICAgICAgIG5leHQ6IGN1cnNvclxuICAgICAgICAgICAgfTtcbiAgICAgICAgICAgIHJldHVybiBwMTtcbiAgICAgICAgICB9KTtcbiAgICAgICAgfVxuICAgICAgfVxuICB9XG5cbiAgaWYgKHVuaXRsZXNzW2tleV0gIT09IDEgJiYgIWlzQ3VzdG9tUHJvcGVydHkoa2V5KSAmJiB0eXBlb2YgdmFsdWUgPT09ICdudW1iZXInICYmIHZhbHVlICE9PSAwKSB7XG4gICAgcmV0dXJuIHZhbHVlICsgJ3B4JztcbiAgfVxuXG4gIHJldHVybiB2YWx1ZTtcbn07XG5cbmlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nKSB7XG4gIHZhciBjb250ZW50VmFsdWVQYXR0ZXJuID0gLyh2YXJ8YXR0cnxjb3VudGVycz98dXJsfCgoKHJlcGVhdGluZy0pPyhsaW5lYXJ8cmFkaWFsKSl8Y29uaWMpLWdyYWRpZW50KVxcKHwobm8tKT8ob3BlbnxjbG9zZSktcXVvdGUvO1xuICB2YXIgY29udGVudFZhbHVlcyA9IFsnbm9ybWFsJywgJ25vbmUnLCAnaW5pdGlhbCcsICdpbmhlcml0JywgJ3Vuc2V0J107XG4gIHZhciBvbGRQcm9jZXNzU3R5bGVWYWx1ZSA9IHByb2Nlc3NTdHlsZVZhbHVlO1xuICB2YXIgbXNQYXR0ZXJuID0gL14tbXMtLztcbiAgdmFyIGh5cGhlblBhdHRlcm4gPSAvLSguKS9nO1xuICB2YXIgaHlwaGVuYXRlZENhY2hlID0ge307XG5cbiAgcHJvY2Vzc1N0eWxlVmFsdWUgPSBmdW5jdGlvbiBwcm9jZXNzU3R5bGVWYWx1ZShrZXksIHZhbHVlKSB7XG4gICAgaWYgKGtleSA9PT0gJ2NvbnRlbnQnKSB7XG4gICAgICBpZiAodHlwZW9mIHZhbHVlICE9PSAnc3RyaW5nJyB8fCBjb250ZW50VmFsdWVzLmluZGV4T2YodmFsdWUpID09PSAtMSAmJiAhY29udGVudFZhbHVlUGF0dGVybi50ZXN0KHZhbHVlKSAmJiAodmFsdWUuY2hhckF0KDApICE9PSB2YWx1ZS5jaGFyQXQodmFsdWUubGVuZ3RoIC0gMSkgfHwgdmFsdWUuY2hhckF0KDApICE9PSAnXCInICYmIHZhbHVlLmNoYXJBdCgwKSAhPT0gXCInXCIpKSB7XG4gICAgICAgIHRocm93IG5ldyBFcnJvcihcIllvdSBzZWVtIHRvIGJlIHVzaW5nIGEgdmFsdWUgZm9yICdjb250ZW50JyB3aXRob3V0IHF1b3RlcywgdHJ5IHJlcGxhY2luZyBpdCB3aXRoIGBjb250ZW50OiAnXFxcIlwiICsgdmFsdWUgKyBcIlxcXCInYFwiKTtcbiAgICAgIH1cbiAgICB9XG5cbiAgICB2YXIgcHJvY2Vzc2VkID0gb2xkUHJvY2Vzc1N0eWxlVmFsdWUoa2V5LCB2YWx1ZSk7XG5cbiAgICBpZiAocHJvY2Vzc2VkICE9PSAnJyAmJiAhaXNDdXN0b21Qcm9wZXJ0eShrZXkpICYmIGtleS5pbmRleE9mKCctJykgIT09IC0xICYmIGh5cGhlbmF0ZWRDYWNoZVtrZXldID09PSB1bmRlZmluZWQpIHtcbiAgICAgIGh5cGhlbmF0ZWRDYWNoZVtrZXldID0gdHJ1ZTtcbiAgICAgIGNvbnNvbGUuZXJyb3IoXCJVc2luZyBrZWJhYi1jYXNlIGZvciBjc3MgcHJvcGVydGllcyBpbiBvYmplY3RzIGlzIG5vdCBzdXBwb3J0ZWQuIERpZCB5b3UgbWVhbiBcIiArIGtleS5yZXBsYWNlKG1zUGF0dGVybiwgJ21zLScpLnJlcGxhY2UoaHlwaGVuUGF0dGVybiwgZnVuY3Rpb24gKHN0ciwgX2NoYXIpIHtcbiAgICAgICAgcmV0dXJuIF9jaGFyLnRvVXBwZXJDYXNlKCk7XG4gICAgICB9KSArIFwiP1wiKTtcbiAgICB9XG5cbiAgICByZXR1cm4gcHJvY2Vzc2VkO1xuICB9O1xufVxuXG52YXIgbm9Db21wb25lbnRTZWxlY3Rvck1lc3NhZ2UgPSAnQ29tcG9uZW50IHNlbGVjdG9ycyBjYW4gb25seSBiZSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggJyArICdAZW1vdGlvbi9iYWJlbC1wbHVnaW4sIHRoZSBzd2MgRW1vdGlvbiBwbHVnaW4sIG9yIGFub3RoZXIgRW1vdGlvbi1hd2FyZSAnICsgJ2NvbXBpbGVyIHRyYW5zZm9ybS4nO1xuXG5mdW5jdGlvbiBoYW5kbGVJbnRlcnBvbGF0aW9uKG1lcmdlZFByb3BzLCByZWdpc3RlcmVkLCBpbnRlcnBvbGF0aW9uKSB7XG4gIGlmIChpbnRlcnBvbGF0aW9uID09IG51bGwpIHtcbiAgICByZXR1cm4gJyc7XG4gIH1cblxuICBpZiAoaW50ZXJwb2xhdGlvbi5fX2Vtb3Rpb25fc3R5bGVzICE9PSB1bmRlZmluZWQpIHtcbiAgICBpZiAocHJvY2Vzcy5lbnYuTk9ERV9FTlYgIT09ICdwcm9kdWN0aW9uJyAmJiBpbnRlcnBvbGF0aW9uLnRvU3RyaW5nKCkgPT09ICdOT19DT01QT05FTlRfU0VMRUNUT1InKSB7XG4gICAgICB0aHJvdyBuZXcgRXJyb3Iobm9Db21wb25lbnRTZWxlY3Rvck1lc3NhZ2UpO1xuICAgIH1cblxuICAgIHJldHVybiBpbnRlcnBvbGF0aW9uO1xuICB9XG5cbiAgc3dpdGNoICh0eXBlb2YgaW50ZXJwb2xhdGlvbikge1xuICAgIGNhc2UgJ2Jvb2xlYW4nOlxuICAgICAge1xuICAgICAgICByZXR1cm4gJyc7XG4gICAgICB9XG5cbiAgICBjYXNlICdvYmplY3QnOlxuICAgICAge1xuICAgICAgICBpZiAoaW50ZXJwb2xhdGlvbi5hbmltID09PSAxKSB7XG4gICAgICAgICAgY3Vyc29yID0ge1xuICAgICAgICAgICAgbmFtZTogaW50ZXJwb2xhdGlvbi5uYW1lLFxuICAgICAgICAgICAgc3R5bGVzOiBpbnRlcnBvbGF0aW9uLnN0eWxlcyxcbiAgICAgICAgICAgIG5leHQ6IGN1cnNvclxuICAgICAgICAgIH07XG4gICAgICAgICAgcmV0dXJuIGludGVycG9sYXRpb24ubmFtZTtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmIChpbnRlcnBvbGF0aW9uLnN0eWxlcyAhPT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgdmFyIG5leHQgPSBpbnRlcnBvbGF0aW9uLm5leHQ7XG5cbiAgICAgICAgICBpZiAobmV4dCAhPT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgICAvLyBub3QgdGhlIG1vc3QgZWZmaWNpZW50IHRoaW5nIGV2ZXIgYnV0IHRoaXMgaXMgYSBwcmV0dHkgcmFyZSBjYXNlXG4gICAgICAgICAgICAvLyBhbmQgdGhlcmUgd2lsbCBiZSB2ZXJ5IGZldyBpdGVyYXRpb25zIG9mIHRoaXMgZ2VuZXJhbGx5XG4gICAgICAgICAgICB3aGlsZSAobmV4dCAhPT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgICAgIGN1cnNvciA9IHtcbiAgICAgICAgICAgICAgICBuYW1lOiBuZXh0Lm5hbWUsXG4gICAgICAgICAgICAgICAgc3R5bGVzOiBuZXh0LnN0eWxlcyxcbiAgICAgICAgICAgICAgICBuZXh0OiBjdXJzb3JcbiAgICAgICAgICAgICAgfTtcbiAgICAgICAgICAgICAgbmV4dCA9IG5leHQubmV4dDtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9XG5cbiAgICAgICAgICB2YXIgc3R5bGVzID0gaW50ZXJwb2xhdGlvbi5zdHlsZXMgKyBcIjtcIjtcblxuICAgICAgICAgIGlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nICYmIGludGVycG9sYXRpb24ubWFwICE9PSB1bmRlZmluZWQpIHtcbiAgICAgICAgICAgIHN0eWxlcyArPSBpbnRlcnBvbGF0aW9uLm1hcDtcbiAgICAgICAgICB9XG5cbiAgICAgICAgICByZXR1cm4gc3R5bGVzO1xuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIGNyZWF0ZVN0cmluZ0Zyb21PYmplY3QobWVyZ2VkUHJvcHMsIHJlZ2lzdGVyZWQsIGludGVycG9sYXRpb24pO1xuICAgICAgfVxuXG4gICAgY2FzZSAnZnVuY3Rpb24nOlxuICAgICAge1xuICAgICAgICBpZiAobWVyZ2VkUHJvcHMgIT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgIHZhciBwcmV2aW91c0N1cnNvciA9IGN1cnNvcjtcbiAgICAgICAgICB2YXIgcmVzdWx0ID0gaW50ZXJwb2xhdGlvbihtZXJnZWRQcm9wcyk7XG4gICAgICAgICAgY3Vyc29yID0gcHJldmlvdXNDdXJzb3I7XG4gICAgICAgICAgcmV0dXJuIGhhbmRsZUludGVycG9sYXRpb24obWVyZ2VkUHJvcHMsIHJlZ2lzdGVyZWQsIHJlc3VsdCk7XG4gICAgICAgIH0gZWxzZSBpZiAocHJvY2Vzcy5lbnYuTk9ERV9FTlYgIT09ICdwcm9kdWN0aW9uJykge1xuICAgICAgICAgIGNvbnNvbGUuZXJyb3IoJ0Z1bmN0aW9ucyB0aGF0IGFyZSBpbnRlcnBvbGF0ZWQgaW4gY3NzIGNhbGxzIHdpbGwgYmUgc3RyaW5naWZpZWQuXFxuJyArICdJZiB5b3Ugd2FudCB0byBoYXZlIGEgY3NzIGNhbGwgYmFzZWQgb24gcHJvcHMsIGNyZWF0ZSBhIGZ1bmN0aW9uIHRoYXQgcmV0dXJucyBhIGNzcyBjYWxsIGxpa2UgdGhpc1xcbicgKyAnbGV0IGR5bmFtaWNTdHlsZSA9IChwcm9wcykgPT4gY3NzYGNvbG9yOiAke3Byb3BzLmNvbG9yfWBcXG4nICsgJ0l0IGNhbiBiZSBjYWxsZWQgZGlyZWN0bHkgd2l0aCBwcm9wcyBvciBpbnRlcnBvbGF0ZWQgaW4gYSBzdHlsZWQgY2FsbCBsaWtlIHRoaXNcXG4nICsgXCJsZXQgU29tZUNvbXBvbmVudCA9IHN0eWxlZCgnZGl2JylgJHtkeW5hbWljU3R5bGV9YFwiKTtcbiAgICAgICAgfVxuXG4gICAgICAgIGJyZWFrO1xuICAgICAgfVxuXG4gICAgY2FzZSAnc3RyaW5nJzpcbiAgICAgIGlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nKSB7XG4gICAgICAgIHZhciBtYXRjaGVkID0gW107XG4gICAgICAgIHZhciByZXBsYWNlZCA9IGludGVycG9sYXRpb24ucmVwbGFjZShhbmltYXRpb25SZWdleCwgZnVuY3Rpb24gKG1hdGNoLCBwMSwgcDIpIHtcbiAgICAgICAgICB2YXIgZmFrZVZhck5hbWUgPSBcImFuaW1hdGlvblwiICsgbWF0Y2hlZC5sZW5ndGg7XG4gICAgICAgICAgbWF0Y2hlZC5wdXNoKFwiY29uc3QgXCIgKyBmYWtlVmFyTmFtZSArIFwiID0ga2V5ZnJhbWVzYFwiICsgcDIucmVwbGFjZSgvXkBrZXlmcmFtZXMgYW5pbWF0aW9uLVxcdysvLCAnJykgKyBcImBcIik7XG4gICAgICAgICAgcmV0dXJuIFwiJHtcIiArIGZha2VWYXJOYW1lICsgXCJ9XCI7XG4gICAgICAgIH0pO1xuXG4gICAgICAgIGlmIChtYXRjaGVkLmxlbmd0aCkge1xuICAgICAgICAgIGNvbnNvbGUuZXJyb3IoJ2BrZXlmcmFtZXNgIG91dHB1dCBnb3QgaW50ZXJwb2xhdGVkIGludG8gcGxhaW4gc3RyaW5nLCBwbGVhc2Ugd3JhcCBpdCB3aXRoIGBjc3NgLlxcblxcbicgKyAnSW5zdGVhZCBvZiBkb2luZyB0aGlzOlxcblxcbicgKyBbXS5jb25jYXQobWF0Y2hlZCwgW1wiYFwiICsgcmVwbGFjZWQgKyBcImBcIl0pLmpvaW4oJ1xcbicpICsgJ1xcblxcbllvdSBzaG91bGQgd3JhcCBpdCB3aXRoIGBjc3NgIGxpa2UgdGhpczpcXG5cXG4nICsgKFwiY3NzYFwiICsgcmVwbGFjZWQgKyBcImBcIikpO1xuICAgICAgICB9XG4gICAgICB9XG5cbiAgICAgIGJyZWFrO1xuICB9IC8vIGZpbmFsaXplIHN0cmluZyB2YWx1ZXMgKHJlZ3VsYXIgc3RyaW5ncyBhbmQgZnVuY3Rpb25zIGludGVycG9sYXRlZCBpbnRvIGNzcyBjYWxscylcblxuXG4gIGlmIChyZWdpc3RlcmVkID09IG51bGwpIHtcbiAgICByZXR1cm4gaW50ZXJwb2xhdGlvbjtcbiAgfVxuXG4gIHZhciBjYWNoZWQgPSByZWdpc3RlcmVkW2ludGVycG9sYXRpb25dO1xuICByZXR1cm4gY2FjaGVkICE9PSB1bmRlZmluZWQgPyBjYWNoZWQgOiBpbnRlcnBvbGF0aW9uO1xufVxuXG5mdW5jdGlvbiBjcmVhdGVTdHJpbmdGcm9tT2JqZWN0KG1lcmdlZFByb3BzLCByZWdpc3RlcmVkLCBvYmopIHtcbiAgdmFyIHN0cmluZyA9ICcnO1xuXG4gIGlmIChBcnJheS5pc0FycmF5KG9iaikpIHtcbiAgICBmb3IgKHZhciBpID0gMDsgaSA8IG9iai5sZW5ndGg7IGkrKykge1xuICAgICAgc3RyaW5nICs9IGhhbmRsZUludGVycG9sYXRpb24obWVyZ2VkUHJvcHMsIHJlZ2lzdGVyZWQsIG9ialtpXSkgKyBcIjtcIjtcbiAgICB9XG4gIH0gZWxzZSB7XG4gICAgZm9yICh2YXIgX2tleSBpbiBvYmopIHtcbiAgICAgIHZhciB2YWx1ZSA9IG9ialtfa2V5XTtcblxuICAgICAgaWYgKHR5cGVvZiB2YWx1ZSAhPT0gJ29iamVjdCcpIHtcbiAgICAgICAgaWYgKHJlZ2lzdGVyZWQgIT0gbnVsbCAmJiByZWdpc3RlcmVkW3ZhbHVlXSAhPT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgc3RyaW5nICs9IF9rZXkgKyBcIntcIiArIHJlZ2lzdGVyZWRbdmFsdWVdICsgXCJ9XCI7XG4gICAgICAgIH0gZWxzZSBpZiAoaXNQcm9jZXNzYWJsZVZhbHVlKHZhbHVlKSkge1xuICAgICAgICAgIHN0cmluZyArPSBwcm9jZXNzU3R5bGVOYW1lKF9rZXkpICsgXCI6XCIgKyBwcm9jZXNzU3R5bGVWYWx1ZShfa2V5LCB2YWx1ZSkgKyBcIjtcIjtcbiAgICAgICAgfVxuICAgICAgfSBlbHNlIHtcbiAgICAgICAgaWYgKF9rZXkgPT09ICdOT19DT01QT05FTlRfU0VMRUNUT1InICYmIHByb2Nlc3MuZW52Lk5PREVfRU5WICE9PSAncHJvZHVjdGlvbicpIHtcbiAgICAgICAgICB0aHJvdyBuZXcgRXJyb3Iobm9Db21wb25lbnRTZWxlY3Rvck1lc3NhZ2UpO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKEFycmF5LmlzQXJyYXkodmFsdWUpICYmIHR5cGVvZiB2YWx1ZVswXSA9PT0gJ3N0cmluZycgJiYgKHJlZ2lzdGVyZWQgPT0gbnVsbCB8fCByZWdpc3RlcmVkW3ZhbHVlWzBdXSA9PT0gdW5kZWZpbmVkKSkge1xuICAgICAgICAgIGZvciAodmFyIF9pID0gMDsgX2kgPCB2YWx1ZS5sZW5ndGg7IF9pKyspIHtcbiAgICAgICAgICAgIGlmIChpc1Byb2Nlc3NhYmxlVmFsdWUodmFsdWVbX2ldKSkge1xuICAgICAgICAgICAgICBzdHJpbmcgKz0gcHJvY2Vzc1N0eWxlTmFtZShfa2V5KSArIFwiOlwiICsgcHJvY2Vzc1N0eWxlVmFsdWUoX2tleSwgdmFsdWVbX2ldKSArIFwiO1wiO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICB2YXIgaW50ZXJwb2xhdGVkID0gaGFuZGxlSW50ZXJwb2xhdGlvbihtZXJnZWRQcm9wcywgcmVnaXN0ZXJlZCwgdmFsdWUpO1xuXG4gICAgICAgICAgc3dpdGNoIChfa2V5KSB7XG4gICAgICAgICAgICBjYXNlICdhbmltYXRpb24nOlxuICAgICAgICAgICAgY2FzZSAnYW5pbWF0aW9uTmFtZSc6XG4gICAgICAgICAgICAgIHtcbiAgICAgICAgICAgICAgICBzdHJpbmcgKz0gcHJvY2Vzc1N0eWxlTmFtZShfa2V5KSArIFwiOlwiICsgaW50ZXJwb2xhdGVkICsgXCI7XCI7XG4gICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgZGVmYXVsdDpcbiAgICAgICAgICAgICAge1xuICAgICAgICAgICAgICAgIGlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nICYmIF9rZXkgPT09ICd1bmRlZmluZWQnKSB7XG4gICAgICAgICAgICAgICAgICBjb25zb2xlLmVycm9yKFVOREVGSU5FRF9BU19PQkpFQ1RfS0VZX0VSUk9SKTtcbiAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICBzdHJpbmcgKz0gX2tleSArIFwie1wiICsgaW50ZXJwb2xhdGVkICsgXCJ9XCI7XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICB9XG4gICAgICAgIH1cbiAgICAgIH1cbiAgICB9XG4gIH1cblxuICByZXR1cm4gc3RyaW5nO1xufVxuXG52YXIgbGFiZWxQYXR0ZXJuID0gL2xhYmVsOlxccyooW15cXHM7XFxue10rKVxccyooO3wkKS9nO1xudmFyIHNvdXJjZU1hcFBhdHRlcm47XG5cbmlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nKSB7XG4gIHNvdXJjZU1hcFBhdHRlcm4gPSAvXFwvXFwqI1xcc3NvdXJjZU1hcHBpbmdVUkw9ZGF0YTphcHBsaWNhdGlvblxcL2pzb247XFxTK1xccytcXCpcXC8vZztcbn0gLy8gdGhpcyBpcyB0aGUgY3Vyc29yIGZvciBrZXlmcmFtZXNcbi8vIGtleWZyYW1lcyBhcmUgc3RvcmVkIG9uIHRoZSBTZXJpYWxpemVkU3R5bGVzIG9iamVjdCBhcyBhIGxpbmtlZCBsaXN0XG5cblxudmFyIGN1cnNvcjtcbnZhciBzZXJpYWxpemVTdHlsZXMgPSBmdW5jdGlvbiBzZXJpYWxpemVTdHlsZXMoYXJncywgcmVnaXN0ZXJlZCwgbWVyZ2VkUHJvcHMpIHtcbiAgaWYgKGFyZ3MubGVuZ3RoID09PSAxICYmIHR5cGVvZiBhcmdzWzBdID09PSAnb2JqZWN0JyAmJiBhcmdzWzBdICE9PSBudWxsICYmIGFyZ3NbMF0uc3R5bGVzICE9PSB1bmRlZmluZWQpIHtcbiAgICByZXR1cm4gYXJnc1swXTtcbiAgfVxuXG4gIHZhciBzdHJpbmdNb2RlID0gdHJ1ZTtcbiAgdmFyIHN0eWxlcyA9ICcnO1xuICBjdXJzb3IgPSB1bmRlZmluZWQ7XG4gIHZhciBzdHJpbmdzID0gYXJnc1swXTtcblxuICBpZiAoc3RyaW5ncyA9PSBudWxsIHx8IHN0cmluZ3MucmF3ID09PSB1bmRlZmluZWQpIHtcbiAgICBzdHJpbmdNb2RlID0gZmFsc2U7XG4gICAgc3R5bGVzICs9IGhhbmRsZUludGVycG9sYXRpb24obWVyZ2VkUHJvcHMsIHJlZ2lzdGVyZWQsIHN0cmluZ3MpO1xuICB9IGVsc2Uge1xuICAgIGlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nICYmIHN0cmluZ3NbMF0gPT09IHVuZGVmaW5lZCkge1xuICAgICAgY29uc29sZS5lcnJvcihJTExFR0FMX0VTQ0FQRV9TRVFVRU5DRV9FUlJPUik7XG4gICAgfVxuXG4gICAgc3R5bGVzICs9IHN0cmluZ3NbMF07XG4gIH0gLy8gd2Ugc3RhcnQgYXQgMSBzaW5jZSB3ZSd2ZSBhbHJlYWR5IGhhbmRsZWQgdGhlIGZpcnN0IGFyZ1xuXG5cbiAgZm9yICh2YXIgaSA9IDE7IGkgPCBhcmdzLmxlbmd0aDsgaSsrKSB7XG4gICAgc3R5bGVzICs9IGhhbmRsZUludGVycG9sYXRpb24obWVyZ2VkUHJvcHMsIHJlZ2lzdGVyZWQsIGFyZ3NbaV0pO1xuXG4gICAgaWYgKHN0cmluZ01vZGUpIHtcbiAgICAgIGlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nICYmIHN0cmluZ3NbaV0gPT09IHVuZGVmaW5lZCkge1xuICAgICAgICBjb25zb2xlLmVycm9yKElMTEVHQUxfRVNDQVBFX1NFUVVFTkNFX0VSUk9SKTtcbiAgICAgIH1cblxuICAgICAgc3R5bGVzICs9IHN0cmluZ3NbaV07XG4gICAgfVxuICB9XG5cbiAgdmFyIHNvdXJjZU1hcDtcblxuICBpZiAocHJvY2Vzcy5lbnYuTk9ERV9FTlYgIT09ICdwcm9kdWN0aW9uJykge1xuICAgIHN0eWxlcyA9IHN0eWxlcy5yZXBsYWNlKHNvdXJjZU1hcFBhdHRlcm4sIGZ1bmN0aW9uIChtYXRjaCkge1xuICAgICAgc291cmNlTWFwID0gbWF0Y2g7XG4gICAgICByZXR1cm4gJyc7XG4gICAgfSk7XG4gIH0gLy8gdXNpbmcgYSBnbG9iYWwgcmVnZXggd2l0aCAuZXhlYyBpcyBzdGF0ZWZ1bCBzbyBsYXN0SW5kZXggaGFzIHRvIGJlIHJlc2V0IGVhY2ggdGltZVxuXG5cbiAgbGFiZWxQYXR0ZXJuLmxhc3RJbmRleCA9IDA7XG4gIHZhciBpZGVudGlmaWVyTmFtZSA9ICcnO1xuICB2YXIgbWF0Y2g7IC8vIGh0dHBzOi8vZXNiZW5jaC5jb20vYmVuY2gvNWI4MDljMmNmMjk0OTgwMGEwZjYxZmI1XG5cbiAgd2hpbGUgKChtYXRjaCA9IGxhYmVsUGF0dGVybi5leGVjKHN0eWxlcykpICE9PSBudWxsKSB7XG4gICAgaWRlbnRpZmllck5hbWUgKz0gJy0nICsgLy8gJEZsb3dGaXhNZSB3ZSBrbm93IGl0J3Mgbm90IG51bGxcbiAgICBtYXRjaFsxXTtcbiAgfVxuXG4gIHZhciBuYW1lID0gaGFzaFN0cmluZyhzdHlsZXMpICsgaWRlbnRpZmllck5hbWU7XG5cbiAgaWYgKHByb2Nlc3MuZW52Lk5PREVfRU5WICE9PSAncHJvZHVjdGlvbicpIHtcbiAgICAvLyAkRmxvd0ZpeE1lIFNlcmlhbGl6ZWRTdHlsZXMgdHlwZSBkb2Vzbid0IGhhdmUgdG9TdHJpbmcgcHJvcGVydHkgKGFuZCB3ZSBkb24ndCB3YW50IHRvIGFkZCBpdClcbiAgICByZXR1cm4ge1xuICAgICAgbmFtZTogbmFtZSxcbiAgICAgIHN0eWxlczogc3R5bGVzLFxuICAgICAgbWFwOiBzb3VyY2VNYXAsXG4gICAgICBuZXh0OiBjdXJzb3IsXG4gICAgICB0b1N0cmluZzogZnVuY3Rpb24gdG9TdHJpbmcoKSB7XG4gICAgICAgIHJldHVybiBcIllvdSBoYXZlIHRyaWVkIHRvIHN0cmluZ2lmeSBvYmplY3QgcmV0dXJuZWQgZnJvbSBgY3NzYCBmdW5jdGlvbi4gSXQgaXNuJ3Qgc3VwcG9zZWQgdG8gYmUgdXNlZCBkaXJlY3RseSAoZS5nLiBhcyB2YWx1ZSBvZiB0aGUgYGNsYXNzTmFtZWAgcHJvcCksIGJ1dCByYXRoZXIgaGFuZGVkIHRvIGVtb3Rpb24gc28gaXQgY2FuIGhhbmRsZSBpdCAoZS5nLiBhcyB2YWx1ZSBvZiBgY3NzYCBwcm9wKS5cIjtcbiAgICAgIH1cbiAgICB9O1xuICB9XG5cbiAgcmV0dXJuIHtcbiAgICBuYW1lOiBuYW1lLFxuICAgIHN0eWxlczogc3R5bGVzLFxuICAgIG5leHQ6IGN1cnNvclxuICB9O1xufTtcblxuZXhwb3J0IHsgc2VyaWFsaXplU3R5bGVzIH07XG4iLCJ2YXIgaXNCcm93c2VyID0gXCJvYmplY3RcIiAhPT0gJ3VuZGVmaW5lZCc7XG5mdW5jdGlvbiBnZXRSZWdpc3RlcmVkU3R5bGVzKHJlZ2lzdGVyZWQsIHJlZ2lzdGVyZWRTdHlsZXMsIGNsYXNzTmFtZXMpIHtcbiAgdmFyIHJhd0NsYXNzTmFtZSA9ICcnO1xuICBjbGFzc05hbWVzLnNwbGl0KCcgJykuZm9yRWFjaChmdW5jdGlvbiAoY2xhc3NOYW1lKSB7XG4gICAgaWYgKHJlZ2lzdGVyZWRbY2xhc3NOYW1lXSAhPT0gdW5kZWZpbmVkKSB7XG4gICAgICByZWdpc3RlcmVkU3R5bGVzLnB1c2gocmVnaXN0ZXJlZFtjbGFzc05hbWVdICsgXCI7XCIpO1xuICAgIH0gZWxzZSB7XG4gICAgICByYXdDbGFzc05hbWUgKz0gY2xhc3NOYW1lICsgXCIgXCI7XG4gICAgfVxuICB9KTtcbiAgcmV0dXJuIHJhd0NsYXNzTmFtZTtcbn1cbnZhciByZWdpc3RlclN0eWxlcyA9IGZ1bmN0aW9uIHJlZ2lzdGVyU3R5bGVzKGNhY2hlLCBzZXJpYWxpemVkLCBpc1N0cmluZ1RhZykge1xuICB2YXIgY2xhc3NOYW1lID0gY2FjaGUua2V5ICsgXCItXCIgKyBzZXJpYWxpemVkLm5hbWU7XG5cbiAgaWYgKCAvLyB3ZSBvbmx5IG5lZWQgdG8gYWRkIHRoZSBzdHlsZXMgdG8gdGhlIHJlZ2lzdGVyZWQgY2FjaGUgaWYgdGhlXG4gIC8vIGNsYXNzIG5hbWUgY291bGQgYmUgdXNlZCBmdXJ0aGVyIGRvd25cbiAgLy8gdGhlIHRyZWUgYnV0IGlmIGl0J3MgYSBzdHJpbmcgdGFnLCB3ZSBrbm93IGl0IHdvbid0XG4gIC8vIHNvIHdlIGRvbid0IGhhdmUgdG8gYWRkIGl0IHRvIHJlZ2lzdGVyZWQgY2FjaGUuXG4gIC8vIHRoaXMgaW1wcm92ZXMgbWVtb3J5IHVzYWdlIHNpbmNlIHdlIGNhbiBhdm9pZCBzdG9yaW5nIHRoZSB3aG9sZSBzdHlsZSBzdHJpbmdcbiAgKGlzU3RyaW5nVGFnID09PSBmYWxzZSB8fCAvLyB3ZSBuZWVkIHRvIGFsd2F5cyBzdG9yZSBpdCBpZiB3ZSdyZSBpbiBjb21wYXQgbW9kZSBhbmRcbiAgLy8gaW4gbm9kZSBzaW5jZSBlbW90aW9uLXNlcnZlciByZWxpZXMgb24gd2hldGhlciBhIHN0eWxlIGlzIGluXG4gIC8vIHRoZSByZWdpc3RlcmVkIGNhY2hlIHRvIGtub3cgd2hldGhlciBhIHN0eWxlIGlzIGdsb2JhbCBvciBub3RcbiAgLy8gYWxzbywgbm90ZSB0aGF0IHRoaXMgY2hlY2sgd2lsbCBiZSBkZWFkIGNvZGUgZWxpbWluYXRlZCBpbiB0aGUgYnJvd3NlclxuICBpc0Jyb3dzZXIgPT09IGZhbHNlICkgJiYgY2FjaGUucmVnaXN0ZXJlZFtjbGFzc05hbWVdID09PSB1bmRlZmluZWQpIHtcbiAgICBjYWNoZS5yZWdpc3RlcmVkW2NsYXNzTmFtZV0gPSBzZXJpYWxpemVkLnN0eWxlcztcbiAgfVxufTtcbnZhciBpbnNlcnRTdHlsZXMgPSBmdW5jdGlvbiBpbnNlcnRTdHlsZXMoY2FjaGUsIHNlcmlhbGl6ZWQsIGlzU3RyaW5nVGFnKSB7XG4gIHJlZ2lzdGVyU3R5bGVzKGNhY2hlLCBzZXJpYWxpemVkLCBpc1N0cmluZ1RhZyk7XG4gIHZhciBjbGFzc05hbWUgPSBjYWNoZS5rZXkgKyBcIi1cIiArIHNlcmlhbGl6ZWQubmFtZTtcblxuICBpZiAoY2FjaGUuaW5zZXJ0ZWRbc2VyaWFsaXplZC5uYW1lXSA9PT0gdW5kZWZpbmVkKSB7XG4gICAgdmFyIGN1cnJlbnQgPSBzZXJpYWxpemVkO1xuXG4gICAgZG8ge1xuICAgICAgdmFyIG1heWJlU3R5bGVzID0gY2FjaGUuaW5zZXJ0KHNlcmlhbGl6ZWQgPT09IGN1cnJlbnQgPyBcIi5cIiArIGNsYXNzTmFtZSA6ICcnLCBjdXJyZW50LCBjYWNoZS5zaGVldCwgdHJ1ZSk7XG5cbiAgICAgIGN1cnJlbnQgPSBjdXJyZW50Lm5leHQ7XG4gICAgfSB3aGlsZSAoY3VycmVudCAhPT0gdW5kZWZpbmVkKTtcbiAgfVxufTtcblxuZXhwb3J0IHsgZ2V0UmVnaXN0ZXJlZFN0eWxlcywgaW5zZXJ0U3R5bGVzLCByZWdpc3RlclN0eWxlcyB9O1xuIiwiZXhwb3J0IGRlZmF1bHQgZnVuY3Rpb24gX2V4dGVuZHMoKSB7XG4gIF9leHRlbmRzID0gT2JqZWN0LmFzc2lnbiA/IE9iamVjdC5hc3NpZ24uYmluZCgpIDogZnVuY3Rpb24gKHRhcmdldCkge1xuICAgIGZvciAodmFyIGkgPSAxOyBpIDwgYXJndW1lbnRzLmxlbmd0aDsgaSsrKSB7XG4gICAgICB2YXIgc291cmNlID0gYXJndW1lbnRzW2ldO1xuXG4gICAgICBmb3IgKHZhciBrZXkgaW4gc291cmNlKSB7XG4gICAgICAgIGlmIChPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwoc291cmNlLCBrZXkpKSB7XG4gICAgICAgICAgdGFyZ2V0W2tleV0gPSBzb3VyY2Vba2V5XTtcbiAgICAgICAgfVxuICAgICAgfVxuICAgIH1cblxuICAgIHJldHVybiB0YXJnZXQ7XG4gIH07XG4gIHJldHVybiBfZXh0ZW5kcy5hcHBseSh0aGlzLCBhcmd1bWVudHMpO1xufSJdLCJuYW1lcyI6WyJmbiIsImNhY2hlIiwiT2JqZWN0IiwiY3JlYXRlIiwiYXJnIiwidW5kZWZpbmVkIiwic3RyIiwiayIsImgiLCJpIiwibGVuIiwibGVuZ3RoIiwiY2hhckNvZGVBdCIsInRvU3RyaW5nIiwiYW5pbWF0aW9uSXRlcmF0aW9uQ291bnQiLCJib3JkZXJJbWFnZU91dHNldCIsImJvcmRlckltYWdlU2xpY2UiLCJib3JkZXJJbWFnZVdpZHRoIiwiYm94RmxleCIsImJveEZsZXhHcm91cCIsImJveE9yZGluYWxHcm91cCIsImNvbHVtbkNvdW50IiwiY29sdW1ucyIsImZsZXgiLCJmbGV4R3JvdyIsImZsZXhQb3NpdGl2ZSIsImZsZXhTaHJpbmsiLCJmbGV4TmVnYXRpdmUiLCJmbGV4T3JkZXIiLCJncmlkUm93IiwiZ3JpZFJvd0VuZCIsImdyaWRSb3dTcGFuIiwiZ3JpZFJvd1N0YXJ0IiwiZ3JpZENvbHVtbiIsImdyaWRDb2x1bW5FbmQiLCJncmlkQ29sdW1uU3BhbiIsImdyaWRDb2x1bW5TdGFydCIsIm1zR3JpZFJvdyIsIm1zR3JpZFJvd1NwYW4iLCJtc0dyaWRDb2x1bW4iLCJtc0dyaWRDb2x1bW5TcGFuIiwiZm9udFdlaWdodCIsImxpbmVIZWlnaHQiLCJvcGFjaXR5Iiwib3JkZXIiLCJvcnBoYW5zIiwidGFiU2l6ZSIsIndpZG93cyIsInpJbmRleCIsInpvb20iLCJXZWJraXRMaW5lQ2xhbXAiLCJmaWxsT3BhY2l0eSIsImZsb29kT3BhY2l0eSIsInN0b3BPcGFjaXR5Iiwic3Ryb2tlRGFzaGFycmF5Iiwic3Ryb2tlRGFzaG9mZnNldCIsInN0cm9rZU1pdGVybGltaXQiLCJzdHJva2VPcGFjaXR5Iiwic3Ryb2tlV2lkdGgiLCJoeXBoZW5hdGVSZWdleCIsImFuaW1hdGlvblJlZ2V4IiwiaXNDdXN0b21Qcm9wZXJ0eSIsInByb3BlcnR5IiwiaXNQcm9jZXNzYWJsZVZhbHVlIiwidmFsdWUiLCJwcm9jZXNzU3R5bGVOYW1lIiwic3R5bGVOYW1lIiwicmVwbGFjZSIsInRvTG93ZXJDYXNlIiwicHJvY2Vzc1N0eWxlVmFsdWUiLCJrZXkiLCJtYXRjaCIsInAxIiwicDIiLCJjdXJzb3IiLCJuYW1lIiwic3R5bGVzIiwibmV4dCIsImhhbmRsZUludGVycG9sYXRpb24iLCJtZXJnZWRQcm9wcyIsInJlZ2lzdGVyZWQiLCJpbnRlcnBvbGF0aW9uIiwiX19lbW90aW9uX3N0eWxlcyIsImFuaW0iLCJvYmoiLCJzdHJpbmciLCJBcnJheSIsImlzQXJyYXkiLCJfa2V5IiwiaW50ZXJwb2xhdGVkIiwiX2kiLCJjcmVhdGVTdHJpbmdGcm9tT2JqZWN0IiwicHJldmlvdXNDdXJzb3IiLCJyZXN1bHQiLCJjYWNoZWQiLCJsYWJlbFBhdHRlcm4iLCJzZXJpYWxpemVTdHlsZXMiLCJhcmdzIiwic3RyaW5nTW9kZSIsInN0cmluZ3MiLCJyYXciLCJsYXN0SW5kZXgiLCJpZGVudGlmaWVyTmFtZSIsImV4ZWMiLCJnZXRSZWdpc3RlcmVkU3R5bGVzIiwicmVnaXN0ZXJlZFN0eWxlcyIsImNsYXNzTmFtZXMiLCJyYXdDbGFzc05hbWUiLCJzcGxpdCIsImZvckVhY2giLCJjbGFzc05hbWUiLCJwdXNoIiwicmVnaXN0ZXJTdHlsZXMiLCJzZXJpYWxpemVkIiwiaXNTdHJpbmdUYWciLCJpbnNlcnRTdHlsZXMiLCJpbnNlcnRlZCIsImN1cnJlbnQiLCJpbnNlcnQiLCJzaGVldCIsIl9leHRlbmRzIiwiYXNzaWduIiwiYmluZCIsInRhcmdldCIsImFyZ3VtZW50cyIsInNvdXJjZSIsInByb3RvdHlwZSIsImhhc093blByb3BlcnR5IiwiY2FsbCIsImFwcGx5IiwidGhpcyJdLCJzb3VyY2VSb290IjoiIn0=