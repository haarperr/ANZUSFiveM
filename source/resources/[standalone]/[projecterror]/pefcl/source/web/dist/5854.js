(self.webpackChunkweb=self.webpackChunkweb||[]).push([[5854],{5854:function(module,__unused_webpack_exports,__webpack_require__){eval('!function(e,t){ true?module.exports=t(__webpack_require__(9648)):0}(this,(function(e){"use strict";function t(e){return e&&"object"==typeof e&&"default"in e?e:{default:e}}var r=t(e),a={words:{m:["један минут","једног минута"],mm:["%d минут","%d минута","%d минута"],h:["један сат","једног сата"],hh:["%d сат","%d сата","%d сати"],d:["један дан","једног дана"],dd:["%d дан","%d дана","%d дана"],M:["један месец","једног месеца"],MM:["%d месец","%d месеца","%d месеци"],y:["једну годину","једне године"],yy:["%d годину","%d године","%d година"]},correctGrammarCase:function(e,t){return e%10>=1&&e%10<=4&&(e%100<10||e%100>=20)?e%10==1?t[0]:t[1]:t[2]},relativeTimeFormatter:function(e,t,r,d){var i=a.words[r];if(1===r.length)return"y"===r&&t?"једна година":d||t?i[0]:i[1];var m=a.correctGrammarCase(e,i);return"yy"===r&&t&&"%d годину"===m?e+" година":m.replace("%d",e)}},d={name:"sr-cyrl",weekdays:"Недеља_Понедељак_Уторак_Среда_Четвртак_Петак_Субота".split("_"),weekdaysShort:"Нед._Пон._Уто._Сре._Чет._Пет._Суб.".split("_"),weekdaysMin:"не_по_ут_ср_че_пе_су".split("_"),months:"Јануар_Фебруар_Март_Април_Мај_Јун_Јул_Август_Септембар_Октобар_Новембар_Децембар".split("_"),monthsShort:"Јан._Феб._Мар._Апр._Мај_Јун_Јул_Авг._Сеп._Окт._Нов._Дец.".split("_"),weekStart:1,relativeTime:{future:"за %s",past:"пре %s",s:"неколико секунди",m:a.relativeTimeFormatter,mm:a.relativeTimeFormatter,h:a.relativeTimeFormatter,hh:a.relativeTimeFormatter,d:a.relativeTimeFormatter,dd:a.relativeTimeFormatter,M:a.relativeTimeFormatter,MM:a.relativeTimeFormatter,y:a.relativeTimeFormatter,yy:a.relativeTimeFormatter},ordinal:function(e){return e+"."},formats:{LT:"H:mm",LTS:"H:mm:ss",L:"D. M. YYYY.",LL:"D. MMMM YYYY.",LLL:"D. MMMM YYYY. H:mm",LLLL:"dddd, D. MMMM YYYY. H:mm"}};return r.default.locale(d,null,!0),d}));//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiNTg1NC5qcyIsIm1hcHBpbmdzIjoiQUFBQSxlQUFlLEtBQW9ELGtCQUFrQixtQkFBTyxDQUFDLElBQU8sR0FBRyxDQUErSSxDQUFDLG1CQUFtQixhQUFhLGNBQWMsK0NBQStDLFdBQVcsY0FBYyxPQUFPLCtWQUErVixrQ0FBa0Msc0VBQXNFLHlDQUF5QyxpQkFBaUIsK0RBQStELGdDQUFnQyxrRUFBa0UsSUFBSSxzWkFBc1osMlRBQTJULHFCQUFxQixhQUFhLFVBQVUsc0hBQXNILHFDQUFxQyIsInNvdXJjZXMiOlsid2VicGFjazovL3dlYi8uL25vZGVfbW9kdWxlcy8ucG5wbS9kYXlqc0AxLjEwLjcvbm9kZV9tb2R1bGVzL2RheWpzL2xvY2FsZS9zci1jeXJsLmpzP2I0YWEiXSwic291cmNlc0NvbnRlbnQiOlsiIWZ1bmN0aW9uKGUsdCl7XCJvYmplY3RcIj09dHlwZW9mIGV4cG9ydHMmJlwidW5kZWZpbmVkXCIhPXR5cGVvZiBtb2R1bGU/bW9kdWxlLmV4cG9ydHM9dChyZXF1aXJlKFwiZGF5anNcIikpOlwiZnVuY3Rpb25cIj09dHlwZW9mIGRlZmluZSYmZGVmaW5lLmFtZD9kZWZpbmUoW1wiZGF5anNcIl0sdCk6KGU9XCJ1bmRlZmluZWRcIiE9dHlwZW9mIGdsb2JhbFRoaXM/Z2xvYmFsVGhpczplfHxzZWxmKS5kYXlqc19sb2NhbGVfc3JfY3lybD10KGUuZGF5anMpfSh0aGlzLChmdW5jdGlvbihlKXtcInVzZSBzdHJpY3RcIjtmdW5jdGlvbiB0KGUpe3JldHVybiBlJiZcIm9iamVjdFwiPT10eXBlb2YgZSYmXCJkZWZhdWx0XCJpbiBlP2U6e2RlZmF1bHQ6ZX19dmFyIHI9dChlKSxhPXt3b3Jkczp7bTpbXCLRmNC10LTQsNC9INC80LjQvdGD0YJcIixcItGY0LXQtNC90L7QsyDQvNC40L3Rg9GC0LBcIl0sbW06W1wiJWQg0LzQuNC90YPRglwiLFwiJWQg0LzQuNC90YPRgtCwXCIsXCIlZCDQvNC40L3Rg9GC0LBcIl0saDpbXCLRmNC10LTQsNC9INGB0LDRglwiLFwi0ZjQtdC00L3QvtCzINGB0LDRgtCwXCJdLGhoOltcIiVkINGB0LDRglwiLFwiJWQg0YHQsNGC0LBcIixcIiVkINGB0LDRgtC4XCJdLGQ6W1wi0ZjQtdC00LDQvSDQtNCw0L1cIixcItGY0LXQtNC90L7QsyDQtNCw0L3QsFwiXSxkZDpbXCIlZCDQtNCw0L1cIixcIiVkINC00LDQvdCwXCIsXCIlZCDQtNCw0L3QsFwiXSxNOltcItGY0LXQtNCw0L0g0LzQtdGB0LXRhlwiLFwi0ZjQtdC00L3QvtCzINC80LXRgdC10YbQsFwiXSxNTTpbXCIlZCDQvNC10YHQtdGGXCIsXCIlZCDQvNC10YHQtdGG0LBcIixcIiVkINC80LXRgdC10YbQuFwiXSx5OltcItGY0LXQtNC90YMg0LPQvtC00LjQvdGDXCIsXCLRmNC10LTQvdC1INCz0L7QtNC40L3QtVwiXSx5eTpbXCIlZCDQs9C+0LTQuNC90YNcIixcIiVkINCz0L7QtNC40L3QtVwiLFwiJWQg0LPQvtC00LjQvdCwXCJdfSxjb3JyZWN0R3JhbW1hckNhc2U6ZnVuY3Rpb24oZSx0KXtyZXR1cm4gZSUxMD49MSYmZSUxMDw9NCYmKGUlMTAwPDEwfHxlJTEwMD49MjApP2UlMTA9PTE/dFswXTp0WzFdOnRbMl19LHJlbGF0aXZlVGltZUZvcm1hdHRlcjpmdW5jdGlvbihlLHQscixkKXt2YXIgaT1hLndvcmRzW3JdO2lmKDE9PT1yLmxlbmd0aClyZXR1cm5cInlcIj09PXImJnQ/XCLRmNC10LTQvdCwINCz0L7QtNC40L3QsFwiOmR8fHQ/aVswXTppWzFdO3ZhciBtPWEuY29ycmVjdEdyYW1tYXJDYXNlKGUsaSk7cmV0dXJuXCJ5eVwiPT09ciYmdCYmXCIlZCDQs9C+0LTQuNC90YNcIj09PW0/ZStcIiDQs9C+0LTQuNC90LBcIjptLnJlcGxhY2UoXCIlZFwiLGUpfX0sZD17bmFtZTpcInNyLWN5cmxcIix3ZWVrZGF5czpcItCd0LXQtNC10ZnQsF/Qn9C+0L3QtdC00LXRmdCw0Lpf0KPRgtC+0YDQsNC6X9Ch0YDQtdC00LBf0KfQtdGC0LLRgNGC0LDQul/Qn9C10YLQsNC6X9Ch0YPQsdC+0YLQsFwiLnNwbGl0KFwiX1wiKSx3ZWVrZGF5c1Nob3J0Olwi0J3QtdC0Ll/Qn9C+0L0uX9Cj0YLQvi5f0KHRgNC1Ll/Qp9C10YIuX9Cf0LXRgi5f0KHRg9CxLlwiLnNwbGl0KFwiX1wiKSx3ZWVrZGF5c01pbjpcItC90LVf0L/Qvl/Rg9GCX9GB0YBf0YfQtV/Qv9C1X9GB0YNcIi5zcGxpdChcIl9cIiksbW9udGhzOlwi0IjQsNC90YPQsNGAX9Ck0LXQsdGA0YPQsNGAX9Cc0LDRgNGCX9CQ0L/RgNC40Ltf0JzQsNGYX9CI0YPQvV/QiNGD0Ltf0JDQstCz0YPRgdGCX9Ch0LXQv9GC0LXQvNCx0LDRgF/QntC60YLQvtCx0LDRgF/QndC+0LLQtdC80LHQsNGAX9CU0LXRhtC10LzQsdCw0YBcIi5zcGxpdChcIl9cIiksbW9udGhzU2hvcnQ6XCLQiNCw0L0uX9Ck0LXQsS5f0JzQsNGALl/QkNC/0YAuX9Cc0LDRmF/QiNGD0L1f0IjRg9C7X9CQ0LLQsy5f0KHQtdC/Ll/QntC60YIuX9Cd0L7Qsi5f0JTQtdGGLlwiLnNwbGl0KFwiX1wiKSx3ZWVrU3RhcnQ6MSxyZWxhdGl2ZVRpbWU6e2Z1dHVyZTpcItC30LAgJXNcIixwYXN0Olwi0L/RgNC1ICVzXCIsczpcItC90LXQutC+0LvQuNC60L4g0YHQtdC60YPQvdC00LhcIixtOmEucmVsYXRpdmVUaW1lRm9ybWF0dGVyLG1tOmEucmVsYXRpdmVUaW1lRm9ybWF0dGVyLGg6YS5yZWxhdGl2ZVRpbWVGb3JtYXR0ZXIsaGg6YS5yZWxhdGl2ZVRpbWVGb3JtYXR0ZXIsZDphLnJlbGF0aXZlVGltZUZvcm1hdHRlcixkZDphLnJlbGF0aXZlVGltZUZvcm1hdHRlcixNOmEucmVsYXRpdmVUaW1lRm9ybWF0dGVyLE1NOmEucmVsYXRpdmVUaW1lRm9ybWF0dGVyLHk6YS5yZWxhdGl2ZVRpbWVGb3JtYXR0ZXIseXk6YS5yZWxhdGl2ZVRpbWVGb3JtYXR0ZXJ9LG9yZGluYWw6ZnVuY3Rpb24oZSl7cmV0dXJuIGUrXCIuXCJ9LGZvcm1hdHM6e0xUOlwiSDptbVwiLExUUzpcIkg6bW06c3NcIixMOlwiRC4gTS4gWVlZWS5cIixMTDpcIkQuIE1NTU0gWVlZWS5cIixMTEw6XCJELiBNTU1NIFlZWVkuIEg6bW1cIixMTExMOlwiZGRkZCwgRC4gTU1NTSBZWVlZLiBIOm1tXCJ9fTtyZXR1cm4gci5kZWZhdWx0LmxvY2FsZShkLG51bGwsITApLGR9KSk7Il0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///5854\n')}}]);