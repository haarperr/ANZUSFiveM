"use strict";(self.webpackChunkweb=self.webpackChunkweb||[]).push([[2527,1932],{1003:function(__unused_webpack_module,exports,__webpack_require__){eval("\r\nexports.__esModule = true;\r\nexports.NuiContext = void 0;\r\nvar react_1 = __webpack_require__(329);\r\nexports.NuiContext = react_1.createContext({\r\n    removeHandler: function () {\r\n        console.log('Failed to remove event. The context has not been initialized');\r\n    },\r\n    addHandler: function () {\r\n        console.log('Failed to add event. The context has not been initialized');\r\n    }\r\n});\r\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMTAwMy5qcyIsIm1hcHBpbmdzIjoiQUFBYTtBQUNiLGtCQUFrQjtBQUNsQixrQkFBa0I7QUFDbEIsY0FBYyxtQkFBTyxDQUFDLEdBQU87QUFDN0Isa0JBQWtCO0FBQ2xCO0FBQ0E7QUFDQSxLQUFLO0FBQ0w7QUFDQTtBQUNBO0FBQ0EsQ0FBQyIsInNvdXJjZXMiOlsid2VicGFjazovL3dlYi8uL25vZGVfbW9kdWxlcy8ucG5wbS9yZWFjdC1maXZlbS1ob29rc0AxLjAuMS0yL25vZGVfbW9kdWxlcy9yZWFjdC1maXZlbS1ob29rcy9kaXN0L2NvbnRleHQvTnVpQ29udGV4dC5qcz8yOWI0Il0sInNvdXJjZXNDb250ZW50IjpbIlwidXNlIHN0cmljdFwiO1xyXG5leHBvcnRzLl9fZXNNb2R1bGUgPSB0cnVlO1xyXG5leHBvcnRzLk51aUNvbnRleHQgPSB2b2lkIDA7XHJcbnZhciByZWFjdF8xID0gcmVxdWlyZShcInJlYWN0XCIpO1xyXG5leHBvcnRzLk51aUNvbnRleHQgPSByZWFjdF8xLmNyZWF0ZUNvbnRleHQoe1xyXG4gICAgcmVtb3ZlSGFuZGxlcjogZnVuY3Rpb24gKCkge1xyXG4gICAgICAgIGNvbnNvbGUubG9nKCdGYWlsZWQgdG8gcmVtb3ZlIGV2ZW50LiBUaGUgY29udGV4dCBoYXMgbm90IGJlZW4gaW5pdGlhbGl6ZWQnKTtcclxuICAgIH0sXHJcbiAgICBhZGRIYW5kbGVyOiBmdW5jdGlvbiAoKSB7XHJcbiAgICAgICAgY29uc29sZS5sb2coJ0ZhaWxlZCB0byBhZGQgZXZlbnQuIFRoZSBjb250ZXh0IGhhcyBub3QgYmVlbiBpbml0aWFsaXplZCcpO1xyXG4gICAgfVxyXG59KTtcclxuIl0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///1003\n")},3341:function(__unused_webpack_module,exports,__webpack_require__){eval("\r\nexports.__esModule = true;\r\nexports.useNuiEvent = void 0;\r\nvar react_1 = __webpack_require__(329);\r\nvar NuiContext_1 = __webpack_require__(1003);\r\nfunction useNuiEvent(options) {\r\n    var _a;\r\n    var context = react_1.useContext((_a = options.context) !== null && _a !== void 0 ? _a : NuiContext_1.NuiContext);\r\n    var _b = react_1.useState(options.defaultValue), data = _b[0], setData = _b[1];\r\n    if (!context) {\r\n        throw new Error('useNuiEvent must be used inside the NuiProvider');\r\n    }\r\n    if (!options.event) {\r\n        throw new Error('Cannot use NuiEvent on nothing.');\r\n    }\r\n    react_1.useEffect(function () {\r\n        context.addHandler(options.event, function (event) {\r\n            var payload = event.data.payload;\r\n            try {\r\n                if (typeof event.data.payload === 'string') {\r\n                    payload = JSON.parse(event.data.payload);\r\n                }\r\n            }\r\n            catch (e) { }\r\n            setData(payload);\r\n            if (options.callback && typeof options.callback === 'function') {\r\n                options.callback(payload);\r\n            }\r\n        });\r\n        return function () {\r\n            context.removeHandler(options.event);\r\n        };\r\n    }, []);\r\n    return { data: data };\r\n}\r\nexports.useNuiEvent = useNuiEvent;\r\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMzM0MS5qcyIsIm1hcHBpbmdzIjoiQUFBYTtBQUNiLGtCQUFrQjtBQUNsQixtQkFBbUI7QUFDbkIsY0FBYyxtQkFBTyxDQUFDLEdBQU87QUFDN0IsbUJBQW1CLG1CQUFPLENBQUMsSUFBdUI7QUFDbEQ7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLFNBQVM7QUFDVDtBQUNBO0FBQ0E7QUFDQSxLQUFLO0FBQ0wsYUFBYTtBQUNiO0FBQ0EsbUJBQW1CIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vd2ViLy4vbm9kZV9tb2R1bGVzLy5wbnBtL3JlYWN0LWZpdmVtLWhvb2tzQDEuMC4xLTIvbm9kZV9tb2R1bGVzL3JlYWN0LWZpdmVtLWhvb2tzL2Rpc3QvaG9va3MvdXNlTnVpRXZlbnQuanM/NDkzNyJdLCJzb3VyY2VzQ29udGVudCI6WyJcInVzZSBzdHJpY3RcIjtcclxuZXhwb3J0cy5fX2VzTW9kdWxlID0gdHJ1ZTtcclxuZXhwb3J0cy51c2VOdWlFdmVudCA9IHZvaWQgMDtcclxudmFyIHJlYWN0XzEgPSByZXF1aXJlKFwicmVhY3RcIik7XHJcbnZhciBOdWlDb250ZXh0XzEgPSByZXF1aXJlKFwiLi4vY29udGV4dC9OdWlDb250ZXh0XCIpO1xyXG5mdW5jdGlvbiB1c2VOdWlFdmVudChvcHRpb25zKSB7XHJcbiAgICB2YXIgX2E7XHJcbiAgICB2YXIgY29udGV4dCA9IHJlYWN0XzEudXNlQ29udGV4dCgoX2EgPSBvcHRpb25zLmNvbnRleHQpICE9PSBudWxsICYmIF9hICE9PSB2b2lkIDAgPyBfYSA6IE51aUNvbnRleHRfMS5OdWlDb250ZXh0KTtcclxuICAgIHZhciBfYiA9IHJlYWN0XzEudXNlU3RhdGUob3B0aW9ucy5kZWZhdWx0VmFsdWUpLCBkYXRhID0gX2JbMF0sIHNldERhdGEgPSBfYlsxXTtcclxuICAgIGlmICghY29udGV4dCkge1xyXG4gICAgICAgIHRocm93IG5ldyBFcnJvcigndXNlTnVpRXZlbnQgbXVzdCBiZSB1c2VkIGluc2lkZSB0aGUgTnVpUHJvdmlkZXInKTtcclxuICAgIH1cclxuICAgIGlmICghb3B0aW9ucy5ldmVudCkge1xyXG4gICAgICAgIHRocm93IG5ldyBFcnJvcignQ2Fubm90IHVzZSBOdWlFdmVudCBvbiBub3RoaW5nLicpO1xyXG4gICAgfVxyXG4gICAgcmVhY3RfMS51c2VFZmZlY3QoZnVuY3Rpb24gKCkge1xyXG4gICAgICAgIGNvbnRleHQuYWRkSGFuZGxlcihvcHRpb25zLmV2ZW50LCBmdW5jdGlvbiAoZXZlbnQpIHtcclxuICAgICAgICAgICAgdmFyIHBheWxvYWQgPSBldmVudC5kYXRhLnBheWxvYWQ7XHJcbiAgICAgICAgICAgIHRyeSB7XHJcbiAgICAgICAgICAgICAgICBpZiAodHlwZW9mIGV2ZW50LmRhdGEucGF5bG9hZCA9PT0gJ3N0cmluZycpIHtcclxuICAgICAgICAgICAgICAgICAgICBwYXlsb2FkID0gSlNPTi5wYXJzZShldmVudC5kYXRhLnBheWxvYWQpO1xyXG4gICAgICAgICAgICAgICAgfVxyXG4gICAgICAgICAgICB9XHJcbiAgICAgICAgICAgIGNhdGNoIChlKSB7IH1cclxuICAgICAgICAgICAgc2V0RGF0YShwYXlsb2FkKTtcclxuICAgICAgICAgICAgaWYgKG9wdGlvbnMuY2FsbGJhY2sgJiYgdHlwZW9mIG9wdGlvbnMuY2FsbGJhY2sgPT09ICdmdW5jdGlvbicpIHtcclxuICAgICAgICAgICAgICAgIG9wdGlvbnMuY2FsbGJhY2socGF5bG9hZCk7XHJcbiAgICAgICAgICAgIH1cclxuICAgICAgICB9KTtcclxuICAgICAgICByZXR1cm4gZnVuY3Rpb24gKCkge1xyXG4gICAgICAgICAgICBjb250ZXh0LnJlbW92ZUhhbmRsZXIob3B0aW9ucy5ldmVudCk7XHJcbiAgICAgICAgfTtcclxuICAgIH0sIFtdKTtcclxuICAgIHJldHVybiB7IGRhdGE6IGRhdGEgfTtcclxufVxyXG5leHBvcnRzLnVzZU51aUV2ZW50ID0gdXNlTnVpRXZlbnQ7XHJcbiJdLCJuYW1lcyI6W10sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///3341\n")},2527:function(__unused_webpack_module,exports,__webpack_require__){eval('\r\nvar __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {\r\n    if (k2 === undefined) k2 = k;\r\n    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });\r\n}) : (function(o, m, k, k2) {\r\n    if (k2 === undefined) k2 = k;\r\n    o[k2] = m[k];\r\n}));\r\nvar __exportStar = (this && this.__exportStar) || function(m, exports) {\r\n    for (var p in m) if (p !== "default" && !Object.prototype.hasOwnProperty.call(exports, p)) __createBinding(exports, m, p);\r\n};\r\nexports.__esModule = true;\r\n__exportStar(__webpack_require__(7816), exports);\r\n__exportStar(__webpack_require__(1003), exports);\r\n__exportStar(__webpack_require__(3341), exports);\r\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMjUyNy5qcyIsIm1hcHBpbmdzIjoiQUFBYTtBQUNiO0FBQ0E7QUFDQSxtQ0FBbUMsb0NBQW9DLGdCQUFnQjtBQUN2RixDQUFDO0FBQ0Q7QUFDQTtBQUNBLENBQUM7QUFDRDtBQUNBO0FBQ0E7QUFDQSxrQkFBa0I7QUFDbEIsYUFBYSxtQkFBTyxDQUFDLElBQXdCO0FBQzdDLGFBQWEsbUJBQU8sQ0FBQyxJQUFzQjtBQUMzQyxhQUFhLG1CQUFPLENBQUMsSUFBcUIiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly93ZWIvLi9ub2RlX21vZHVsZXMvLnBucG0vcmVhY3QtZml2ZW0taG9va3NAMS4wLjEtMi9ub2RlX21vZHVsZXMvcmVhY3QtZml2ZW0taG9va3MvZGlzdC9pbmRleC5qcz83NzgyIl0sInNvdXJjZXNDb250ZW50IjpbIlwidXNlIHN0cmljdFwiO1xyXG52YXIgX19jcmVhdGVCaW5kaW5nID0gKHRoaXMgJiYgdGhpcy5fX2NyZWF0ZUJpbmRpbmcpIHx8IChPYmplY3QuY3JlYXRlID8gKGZ1bmN0aW9uKG8sIG0sIGssIGsyKSB7XHJcbiAgICBpZiAoazIgPT09IHVuZGVmaW5lZCkgazIgPSBrO1xyXG4gICAgT2JqZWN0LmRlZmluZVByb3BlcnR5KG8sIGsyLCB7IGVudW1lcmFibGU6IHRydWUsIGdldDogZnVuY3Rpb24oKSB7IHJldHVybiBtW2tdOyB9IH0pO1xyXG59KSA6IChmdW5jdGlvbihvLCBtLCBrLCBrMikge1xyXG4gICAgaWYgKGsyID09PSB1bmRlZmluZWQpIGsyID0gaztcclxuICAgIG9bazJdID0gbVtrXTtcclxufSkpO1xyXG52YXIgX19leHBvcnRTdGFyID0gKHRoaXMgJiYgdGhpcy5fX2V4cG9ydFN0YXIpIHx8IGZ1bmN0aW9uKG0sIGV4cG9ydHMpIHtcclxuICAgIGZvciAodmFyIHAgaW4gbSkgaWYgKHAgIT09IFwiZGVmYXVsdFwiICYmICFPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwoZXhwb3J0cywgcCkpIF9fY3JlYXRlQmluZGluZyhleHBvcnRzLCBtLCBwKTtcclxufTtcclxuZXhwb3J0cy5fX2VzTW9kdWxlID0gdHJ1ZTtcclxuX19leHBvcnRTdGFyKHJlcXVpcmUoXCIuL3Byb3ZpZGVyL051aVByb3ZpZGVyXCIpLCBleHBvcnRzKTtcclxuX19leHBvcnRTdGFyKHJlcXVpcmUoXCIuL2NvbnRleHQvTnVpQ29udGV4dFwiKSwgZXhwb3J0cyk7XHJcbl9fZXhwb3J0U3RhcihyZXF1aXJlKFwiLi9ob29rcy91c2VOdWlFdmVudFwiKSwgZXhwb3J0cyk7XHJcbiJdLCJuYW1lcyI6W10sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///2527\n')},7816:function(__unused_webpack_module,exports,__webpack_require__){eval('\r\nvar __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {\r\n    if (k2 === undefined) k2 = k;\r\n    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });\r\n}) : (function(o, m, k, k2) {\r\n    if (k2 === undefined) k2 = k;\r\n    o[k2] = m[k];\r\n}));\r\nvar __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {\r\n    Object.defineProperty(o, "default", { enumerable: true, value: v });\r\n}) : function(o, v) {\r\n    o["default"] = v;\r\n});\r\nvar __importStar = (this && this.__importStar) || function (mod) {\r\n    if (mod && mod.__esModule) return mod;\r\n    var result = {};\r\n    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);\r\n    __setModuleDefault(result, mod);\r\n    return result;\r\n};\r\nvar __spreadArray = (this && this.__spreadArray) || function (to, from) {\r\n    for (var i = 0, il = from.length, j = to.length; i < il; i++, j++)\r\n        to[j] = from[i];\r\n    return to;\r\n};\r\nexports.__esModule = true;\r\nexports.NuiProvider = void 0;\r\nvar react_1 = __importStar(__webpack_require__(329));\r\nvar NuiContext_1 = __webpack_require__(1003);\r\nvar NuiProvider = function (props) {\r\n    var _a;\r\n    var Context = (_a = props.context) !== null && _a !== void 0 ? _a : NuiContext_1.NuiContext;\r\n    var handlers = react_1.useRef({});\r\n    handlers.current = {};\r\n    var addHandler = function (event, handler) {\r\n        var _a;\r\n        var existingHandlers = (_a = handlers.current[event]) !== null && _a !== void 0 ? _a : [];\r\n        handlers.current[event] = __spreadArray(__spreadArray([], existingHandlers), [handler]);\r\n    };\r\n    var removeHandler = function (event) {\r\n        delete handlers.current[event];\r\n    };\r\n    var eventHandler = function (event) {\r\n        if (props.validateEvent && !props.validateEvent(event)) {\r\n            return;\r\n        }\r\n        var type = event.data.type;\r\n        if (handlers.current &&\r\n            handlers.current[type] &&\r\n            handlers.current[type].length > 0) {\r\n            handlers.current[type].forEach(function (handler) {\r\n                handler(event);\r\n            });\r\n        }\r\n    };\r\n    react_1.useEffect(function () {\r\n        window.addEventListener(\'message\', eventHandler);\r\n        return function () { return window.removeEventListener(\'message\', eventHandler); };\r\n    }, []);\r\n    return (react_1["default"].createElement(Context.Provider, { value: { addHandler: addHandler, removeHandler: removeHandler } }, props.children));\r\n};\r\nexports.NuiProvider = NuiProvider;\r\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiNzgxNi5qcyIsIm1hcHBpbmdzIjoiQUFBYTtBQUNiO0FBQ0E7QUFDQSxtQ0FBbUMsb0NBQW9DLGdCQUFnQjtBQUN2RixDQUFDO0FBQ0Q7QUFDQTtBQUNBLENBQUM7QUFDRDtBQUNBLDBDQUEwQyw0QkFBNEI7QUFDdEUsQ0FBQztBQUNEO0FBQ0EsQ0FBQztBQUNEO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxxREFBcUQsUUFBUTtBQUM3RDtBQUNBO0FBQ0E7QUFDQSxrQkFBa0I7QUFDbEIsbUJBQW1CO0FBQ25CLDJCQUEyQixtQkFBTyxDQUFDLEdBQU87QUFDMUMsbUJBQW1CLG1CQUFPLENBQUMsSUFBdUI7QUFDbEQ7QUFDQTtBQUNBO0FBQ0Esb0NBQW9DO0FBQ3BDO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsYUFBYTtBQUNiO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsNkJBQTZCO0FBQzdCLEtBQUs7QUFDTCxpRUFBaUUsU0FBUyx3REFBd0Q7QUFDbEk7QUFDQSxtQkFBbUIiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly93ZWIvLi9ub2RlX21vZHVsZXMvLnBucG0vcmVhY3QtZml2ZW0taG9va3NAMS4wLjEtMi9ub2RlX21vZHVsZXMvcmVhY3QtZml2ZW0taG9va3MvZGlzdC9wcm92aWRlci9OdWlQcm92aWRlci5qcz9jNjhhIl0sInNvdXJjZXNDb250ZW50IjpbIlwidXNlIHN0cmljdFwiO1xyXG52YXIgX19jcmVhdGVCaW5kaW5nID0gKHRoaXMgJiYgdGhpcy5fX2NyZWF0ZUJpbmRpbmcpIHx8IChPYmplY3QuY3JlYXRlID8gKGZ1bmN0aW9uKG8sIG0sIGssIGsyKSB7XHJcbiAgICBpZiAoazIgPT09IHVuZGVmaW5lZCkgazIgPSBrO1xyXG4gICAgT2JqZWN0LmRlZmluZVByb3BlcnR5KG8sIGsyLCB7IGVudW1lcmFibGU6IHRydWUsIGdldDogZnVuY3Rpb24oKSB7IHJldHVybiBtW2tdOyB9IH0pO1xyXG59KSA6IChmdW5jdGlvbihvLCBtLCBrLCBrMikge1xyXG4gICAgaWYgKGsyID09PSB1bmRlZmluZWQpIGsyID0gaztcclxuICAgIG9bazJdID0gbVtrXTtcclxufSkpO1xyXG52YXIgX19zZXRNb2R1bGVEZWZhdWx0ID0gKHRoaXMgJiYgdGhpcy5fX3NldE1vZHVsZURlZmF1bHQpIHx8IChPYmplY3QuY3JlYXRlID8gKGZ1bmN0aW9uKG8sIHYpIHtcclxuICAgIE9iamVjdC5kZWZpbmVQcm9wZXJ0eShvLCBcImRlZmF1bHRcIiwgeyBlbnVtZXJhYmxlOiB0cnVlLCB2YWx1ZTogdiB9KTtcclxufSkgOiBmdW5jdGlvbihvLCB2KSB7XHJcbiAgICBvW1wiZGVmYXVsdFwiXSA9IHY7XHJcbn0pO1xyXG52YXIgX19pbXBvcnRTdGFyID0gKHRoaXMgJiYgdGhpcy5fX2ltcG9ydFN0YXIpIHx8IGZ1bmN0aW9uIChtb2QpIHtcclxuICAgIGlmIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpIHJldHVybiBtb2Q7XHJcbiAgICB2YXIgcmVzdWx0ID0ge307XHJcbiAgICBpZiAobW9kICE9IG51bGwpIGZvciAodmFyIGsgaW4gbW9kKSBpZiAoayAhPT0gXCJkZWZhdWx0XCIgJiYgT2JqZWN0LnByb3RvdHlwZS5oYXNPd25Qcm9wZXJ0eS5jYWxsKG1vZCwgaykpIF9fY3JlYXRlQmluZGluZyhyZXN1bHQsIG1vZCwgayk7XHJcbiAgICBfX3NldE1vZHVsZURlZmF1bHQocmVzdWx0LCBtb2QpO1xyXG4gICAgcmV0dXJuIHJlc3VsdDtcclxufTtcclxudmFyIF9fc3ByZWFkQXJyYXkgPSAodGhpcyAmJiB0aGlzLl9fc3ByZWFkQXJyYXkpIHx8IGZ1bmN0aW9uICh0bywgZnJvbSkge1xyXG4gICAgZm9yICh2YXIgaSA9IDAsIGlsID0gZnJvbS5sZW5ndGgsIGogPSB0by5sZW5ndGg7IGkgPCBpbDsgaSsrLCBqKyspXHJcbiAgICAgICAgdG9bal0gPSBmcm9tW2ldO1xyXG4gICAgcmV0dXJuIHRvO1xyXG59O1xyXG5leHBvcnRzLl9fZXNNb2R1bGUgPSB0cnVlO1xyXG5leHBvcnRzLk51aVByb3ZpZGVyID0gdm9pZCAwO1xyXG52YXIgcmVhY3RfMSA9IF9faW1wb3J0U3RhcihyZXF1aXJlKFwicmVhY3RcIikpO1xyXG52YXIgTnVpQ29udGV4dF8xID0gcmVxdWlyZShcIi4uL2NvbnRleHQvTnVpQ29udGV4dFwiKTtcclxudmFyIE51aVByb3ZpZGVyID0gZnVuY3Rpb24gKHByb3BzKSB7XHJcbiAgICB2YXIgX2E7XHJcbiAgICB2YXIgQ29udGV4dCA9IChfYSA9IHByb3BzLmNvbnRleHQpICE9PSBudWxsICYmIF9hICE9PSB2b2lkIDAgPyBfYSA6IE51aUNvbnRleHRfMS5OdWlDb250ZXh0O1xyXG4gICAgdmFyIGhhbmRsZXJzID0gcmVhY3RfMS51c2VSZWYoe30pO1xyXG4gICAgaGFuZGxlcnMuY3VycmVudCA9IHt9O1xyXG4gICAgdmFyIGFkZEhhbmRsZXIgPSBmdW5jdGlvbiAoZXZlbnQsIGhhbmRsZXIpIHtcclxuICAgICAgICB2YXIgX2E7XHJcbiAgICAgICAgdmFyIGV4aXN0aW5nSGFuZGxlcnMgPSAoX2EgPSBoYW5kbGVycy5jdXJyZW50W2V2ZW50XSkgIT09IG51bGwgJiYgX2EgIT09IHZvaWQgMCA/IF9hIDogW107XHJcbiAgICAgICAgaGFuZGxlcnMuY3VycmVudFtldmVudF0gPSBfX3NwcmVhZEFycmF5KF9fc3ByZWFkQXJyYXkoW10sIGV4aXN0aW5nSGFuZGxlcnMpLCBbaGFuZGxlcl0pO1xyXG4gICAgfTtcclxuICAgIHZhciByZW1vdmVIYW5kbGVyID0gZnVuY3Rpb24gKGV2ZW50KSB7XHJcbiAgICAgICAgZGVsZXRlIGhhbmRsZXJzLmN1cnJlbnRbZXZlbnRdO1xyXG4gICAgfTtcclxuICAgIHZhciBldmVudEhhbmRsZXIgPSBmdW5jdGlvbiAoZXZlbnQpIHtcclxuICAgICAgICBpZiAocHJvcHMudmFsaWRhdGVFdmVudCAmJiAhcHJvcHMudmFsaWRhdGVFdmVudChldmVudCkpIHtcclxuICAgICAgICAgICAgcmV0dXJuO1xyXG4gICAgICAgIH1cclxuICAgICAgICB2YXIgdHlwZSA9IGV2ZW50LmRhdGEudHlwZTtcclxuICAgICAgICBpZiAoaGFuZGxlcnMuY3VycmVudCAmJlxyXG4gICAgICAgICAgICBoYW5kbGVycy5jdXJyZW50W3R5cGVdICYmXHJcbiAgICAgICAgICAgIGhhbmRsZXJzLmN1cnJlbnRbdHlwZV0ubGVuZ3RoID4gMCkge1xyXG4gICAgICAgICAgICBoYW5kbGVycy5jdXJyZW50W3R5cGVdLmZvckVhY2goZnVuY3Rpb24gKGhhbmRsZXIpIHtcclxuICAgICAgICAgICAgICAgIGhhbmRsZXIoZXZlbnQpO1xyXG4gICAgICAgICAgICB9KTtcclxuICAgICAgICB9XHJcbiAgICB9O1xyXG4gICAgcmVhY3RfMS51c2VFZmZlY3QoZnVuY3Rpb24gKCkge1xyXG4gICAgICAgIHdpbmRvdy5hZGRFdmVudExpc3RlbmVyKCdtZXNzYWdlJywgZXZlbnRIYW5kbGVyKTtcclxuICAgICAgICByZXR1cm4gZnVuY3Rpb24gKCkgeyByZXR1cm4gd2luZG93LnJlbW92ZUV2ZW50TGlzdGVuZXIoJ21lc3NhZ2UnLCBldmVudEhhbmRsZXIpOyB9O1xyXG4gICAgfSwgW10pO1xyXG4gICAgcmV0dXJuIChyZWFjdF8xW1wiZGVmYXVsdFwiXS5jcmVhdGVFbGVtZW50KENvbnRleHQuUHJvdmlkZXIsIHsgdmFsdWU6IHsgYWRkSGFuZGxlcjogYWRkSGFuZGxlciwgcmVtb3ZlSGFuZGxlcjogcmVtb3ZlSGFuZGxlciB9IH0sIHByb3BzLmNoaWxkcmVuKSk7XHJcbn07XHJcbmV4cG9ydHMuTnVpUHJvdmlkZXIgPSBOdWlQcm92aWRlcjtcclxuIl0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///7816\n')}}]);