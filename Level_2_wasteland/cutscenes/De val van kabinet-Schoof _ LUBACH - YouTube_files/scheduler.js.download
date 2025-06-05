(function(){'use strict';var g;function h(a){var b=0;return function(){return b<a.length?{done:!1,value:a[b++]}:{done:!0}}}
var k=typeof Object.defineProperties=="function"?Object.defineProperty:function(a,b,c){if(a==Array.prototype||a==Object.prototype)return a;a[b]=c.value;return a};
function aa(a){a=["object"==typeof globalThis&&globalThis,a,"object"==typeof window&&window,"object"==typeof self&&self,"object"==typeof global&&global];for(var b=0;b<a.length;++b){var c=a[b];if(c&&c.Math==Math)return c}throw Error("Cannot find global object");}
var l=aa(this);function m(a,b){if(b)a:{var c=l;a=a.split(".");for(var d=0;d<a.length-1;d++){var e=a[d];if(!(e in c))break a;c=c[e]}a=a[a.length-1];d=c[a];b=b(d);b!=d&&b!=null&&k(c,a,{configurable:!0,writable:!0,value:b})}}
m("Symbol",function(a){function b(f){if(this instanceof b)throw new TypeError("Symbol is not a constructor");return new c(d+(f||"")+"_"+e++,f)}
function c(f,u){this.g=f;k(this,"description",{configurable:!0,writable:!0,value:u})}
if(a)return a;c.prototype.toString=function(){return this.g};
var d="jscomp_symbol_"+(Math.random()*1E9>>>0)+"_",e=0;return b});
m("Symbol.iterator",function(a){if(a)return a;a=Symbol("Symbol.iterator");for(var b="Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array".split(" "),c=0;c<b.length;c++){var d=l[b[c]];typeof d==="function"&&typeof d.prototype[a]!="function"&&k(d.prototype,a,{configurable:!0,writable:!0,value:function(){return ba(h(this))}})}return a});
function ba(a){a={next:a};a[Symbol.iterator]=function(){return this};
return a}
var ca=typeof Object.create=="function"?Object.create:function(a){function b(){}
b.prototype=a;return new b},n;
if(typeof Object.setPrototypeOf=="function")n=Object.setPrototypeOf;else{var p;a:{var da={a:!0},q={};try{q.__proto__=da;p=q.a;break a}catch(a){}p=!1}n=p?function(a,b){a.__proto__=b;if(a.__proto__!==b)throw new TypeError(a+" is not extensible");return a}:null}var r=n;
function t(a){var b=typeof Symbol!="undefined"&&Symbol.iterator&&a[Symbol.iterator];if(b)return b.call(a);if(typeof a.length=="number")return{next:h(a)};throw Error(String(a)+" is not an iterable or ArrayLike");}
m("Symbol.dispose",function(a){return a?a:Symbol("Symbol.dispose")});
function ha(a,b){a instanceof String&&(a+="");var c=0,d=!1,e={next:function(){if(!d&&c<a.length){var f=c++;return{value:b(f,a[f]),done:!1}}d=!0;return{done:!0,value:void 0}}};
e[Symbol.iterator]=function(){return e};
return e}
m("Object.values",function(a){return a?a:function(b){var c=[],d;for(d in b)Object.prototype.hasOwnProperty.call(b,d)&&c.push(b[d]);return c}});
m("Array.prototype.values",function(a){return a?a:function(){return ha(this,function(b,c){return c})}});/*

 Copyright The Closure Library Authors.
 SPDX-License-Identifier: Apache-2.0
*/
var v=this||self;function w(a){a=a.split(".");for(var b=v,c=0;c<a.length;c++)if(b=b[a[c]],b==null)return null;return b}
function x(a,b){a=a.split(".");for(var c=v,d;a.length&&(d=a.shift());)a.length||b===void 0?c[d]&&c[d]!==Object.prototype[d]?c=c[d]:c=c[d]={}:c[d]=b}
;var y=Math.max,ia=y.apply,z=Object.values({ba:1,aa:2,Z:4,ea:8,ga:16,ca:32,U:64,X:128,V:256,fa:512,W:1024,Y:2048,da:4096}),A;if(z instanceof Array)A=z;else{for(var ja=t(z),B,C=[];!(B=ja.next()).done;)C.push(B.value);A=C}ia.call(y,Math,A);function D(){this.s=this.s;this.B=this.B}
D.prototype.s=!1;D.prototype.dispose=function(){this.s||(this.s=!0,this.G())};
D.prototype[Symbol.dispose]=function(){this.dispose()};
D.prototype.G=function(){if(this.B)for(;this.B.length;)this.B.shift()()};var E=v.window,F,G,H=(E==null?void 0:(F=E.yt)==null?void 0:F.config_)||(E==null?void 0:(G=E.ytcfg)==null?void 0:G.data_)||{};x("yt.config_",H);function I(a,b){return a in H?H[a]:b}
;function J(a,b){a=I("EXPERIMENT_FLAGS",{})[a];return a===void 0&&b!==void 0?b:Number(a||0)}
;var ka=J("web_emulated_idle_callback_delay",300),K=1E3/60-3,L=[8,5,4,3,2,1,0];
function M(a){a=a===void 0?{}:a;D.call(this);this.i=[];this.h={};this.D=this.g=0;this.C=this.l=!1;this.u=[];this.A=this.F=!1;for(var b=t(L),c=b.next();!c.done;c=b.next())this.i[c.value]=[];this.j=0;this.N=a.timeout||1;this.o=K;this.m=0;this.H=this.R.bind(this);this.M=this.T.bind(this);this.J=this.O.bind(this);this.K=this.P.bind(this);this.L=this.S.bind(this);if(b=!!window.requestIdleCallback&&!!window.cancelIdleCallback)b=I("EXPERIMENT_FLAGS",{}).disable_scheduler_requestIdleCallback,b=!(typeof b===
"string"&&b==="false"?0:b);this.I=b;(this.v=a.useRaf!==!1&&!!window.requestAnimationFrame)&&document.addEventListener("visibilitychange",this.H)}
M.prototype=ca(D.prototype);M.prototype.constructor=M;if(r)r(M,D);else for(var N in D)if(N!="prototype")if(Object.defineProperties){var O=Object.getOwnPropertyDescriptor(D,N);O&&Object.defineProperty(M,N,O)}else M[N]=D[N];function P(a,b){var c=Date.now();Q(b);b=Date.now()-c;a.l||(a.o-=b)}
function R(a,b,c,d){++a.D;if(c===10)return P(a,b),a.D;var e=a.D;a.h[e]=b;a.l&&!d?a.u.push({id:e,priority:c}):(a.i[c].push(e),a.C||a.l||(a.g!==0&&S(a)!==a.m&&T(a),a.start()));return e}
function U(a){a.u.length=0;for(var b=5;b>=0;b--)a.i[b].length=0;a.i[8].length=0;a.h={};T(a)}
function S(a){if(a.i[8].length){if(a.A)return 4;if(!document.hidden&&a.v)return 3}for(var b=5;b>=a.j;b--)if(a.i[b].length>0)return b>0?!document.hidden&&a.v?3:2:1;return 0}
function la(a){var b=w("yt.logging.errors.log");b&&b(a)}
function Q(a){try{a()}catch(b){la(b)}}
function ma(a){for(var b=t(L),c=b.next();!c.done;c=b.next())if(a.i[c.value].length)return!0;return!1}
g=M.prototype;g.P=function(a){var b=void 0;a&&(b=a.timeRemaining());this.F=!0;V(this,b);this.F=!1};
g.T=function(){V(this)};
g.O=function(){na(this)};
g.S=function(a){this.A=!0;var b=S(this);b===4&&b!==this.m&&(T(this),this.start());V(this,void 0,a);this.A=!1};
g.R=function(){document.hidden||na(this);this.g&&(T(this),this.start())};
function na(a){T(a);a.l=!0;for(var b=Date.now(),c=a.i[8];c.length;){var d=c.shift(),e=a.h[d];delete a.h[d];e&&Q(e)}oa(a);a.l=!1;ma(a)&&a.start();a.o-=Date.now()-b}
function oa(a){for(var b=0,c=a.u.length;b<c;b++){var d=a.u[b];a.i[d.priority].push(d.id)}a.u.length=0}
function V(a,b,c){a.A&&a.m===4&&a.g||T(a);a.l=!0;b=Date.now()+(b||a.o);for(var d=a.i[5];d.length;){var e=d.shift(),f=a.h[e];delete a.h[e];if(f)try{f(c)}catch(ua){la(ua)}}for(d=a.i[4];d.length;)c=d.shift(),e=a.h[c],delete a.h[c],e&&Q(e);d=a.F?0:1;d=a.j>d?a.j:d;if(!(Date.now()>=b)){do{a:{c=a;e=d;for(f=3;f>=e;f--)for(var u=c.i[f];u.length;){var ea=u.shift(),fa=c.h[ea];delete c.h[ea];if(fa){c=fa;break a}}c=null}c&&Q(c)}while(c&&Date.now()<b)}a.l=!1;oa(a);a.o=K;ma(a)&&a.start()}
g.start=function(){this.C=!1;if(this.g===0)switch(this.m=S(this),this.m){case 1:var a=this.K;this.g=this.I?window.requestIdleCallback(a,{timeout:3E3}):window.setTimeout(a,ka);break;case 2:this.g=window.setTimeout(this.M,this.N);break;case 3:this.g=window.requestAnimationFrame(this.L);break;case 4:this.g=window.setTimeout(this.J,0)}};
function T(a){if(a.g){switch(a.m){case 1:var b=a.g;a.I?window.cancelIdleCallback(b):window.clearTimeout(b);break;case 2:case 4:window.clearTimeout(a.g);break;case 3:window.cancelAnimationFrame(a.g)}a.g=0}}
g.G=function(){U(this);T(this);this.v&&document.removeEventListener("visibilitychange",this.H);D.prototype.G.call(this)};var W=w("yt.scheduler.instance.timerIdMap_")||{},pa=J("kevlar_tuner_scheduler_soft_state_timer_ms",800),X=0,Y=0;function Z(){var a=w("ytglobal.schedulerInstanceInstance_");if(!a||a.s)a=new M(I("scheduler")||{}),x("ytglobal.schedulerInstanceInstance_",a);return a}
function qa(){ra();var a=w("ytglobal.schedulerInstanceInstance_");a&&(a&&typeof a.dispose=="function"&&a.dispose(),x("ytglobal.schedulerInstanceInstance_",null))}
function ra(){U(Z());for(var a in W)W.hasOwnProperty(a)&&delete W[Number(a)]}
function sa(a,b,c){if(!c)return c=c===void 0,-R(Z(),a,b,c);var d=window.setTimeout(function(){var e=R(Z(),a,b);W[d]=e},c);
return d}
function ta(a){var b=Z();P(b,a)}
function va(a){var b=Z();if(a<0)delete b.h[-a];else{var c=W[a];c?(delete b.h[c],delete W[a]):window.clearTimeout(a)}}
function wa(){xa()}
function xa(){window.clearTimeout(X);Z().start()}
function ya(){var a=Z();T(a);a.C=!0;window.clearTimeout(X);X=window.setTimeout(wa,pa)}
function za(){window.clearTimeout(Y);Y=window.setTimeout(function(){Aa(0)},pa)}
function Aa(a){za();var b=Z();b.j=a;b.start()}
function Ba(a){za();var b=Z();b.j>a&&(b.j=a,b.start())}
function Ca(){window.clearTimeout(Y);var a=Z();a.j=0;a.start()}
;w("yt.scheduler.initialized")||(x("yt.scheduler.instance.dispose",qa),x("yt.scheduler.instance.addJob",sa),x("yt.scheduler.instance.addImmediateJob",ta),x("yt.scheduler.instance.cancelJob",va),x("yt.scheduler.instance.cancelAllJobs",ra),x("yt.scheduler.instance.start",xa),x("yt.scheduler.instance.pause",ya),x("yt.scheduler.instance.setPriorityThreshold",Aa),x("yt.scheduler.instance.enablePriorityThreshold",Ba),x("yt.scheduler.instance.clearPriorityThreshold",Ca),x("yt.scheduler.initialized",!0));}).call(this);
