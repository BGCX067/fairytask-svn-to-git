package com.jzonl.engine.managers
{
	import com.jzonl.engine.GameStage;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;

    public class KeyManager {
        private static var initialized:Boolean = false;
        private static var keysDown:Object = new Object();
        private static var _normal:Object = {};
        private static var _ctrl:Object = {};
        private static var _alt:Object = {};
        private static var _shift:Object = {};
        private static var _ctrlAlt:Object = {};
        private static var _ctrlAltShift:Object = {};

        public static function initialize(pStage:Stage):void{
            if (!initialized){
                pStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
                pStage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
                pStage.addEventListener(Event.DEACTIVATE, clearKeys);
                pStage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, onFocusChange);
                initialized = true;
            };
        }
        private static function onFocusChange(evt:FocusEvent):void{
//            var _local2:Boolean = LoginLayer.instance.contains(LoginLayer.loginFrame);
//            if (!_local2){
//                evt.stopImmediatePropagation();
//                evt.stopPropagation();
//            };
        }
		/**
		 * 注册事件 
		 * @param pCode
		 * @param pFun
		 * 
		 */
        public static function regCode(pCode:int, pFun:Function):void{
            _normal[pCode] = pFun;
        }
		/**
		 * 释放注册 
		 * @param pCode
		 * 
		 */
        public static function unRegCode(pCode:int):void{
            _normal[pCode] = null;
        }
        public static function regNormal(_arg1:String, _arg2:Function):void{
            _normal[_arg1.charCodeAt(0)] = _arg2;
        }
        public static function unRegNormal(_arg1:String):void{
            _normal[_arg1.charCodeAt(0)] = null;
        }
        public static function regCtrl(_arg1:String, _arg2:Function):void{
            _ctrl[_arg1.charCodeAt(0)] = _arg2;
        }
        public static function regAlt(_arg1:String, _arg2:Function):void{
            _alt[_arg1.charCodeAt(0)] = _arg2;
        }
        public static function regCtrlAlt(_arg1:String, _arg2:Function):void{
            _ctrlAlt[_arg1.charCodeAt(0)] = _arg2;
        }
        public static function isDown(pCode:uint):Boolean{
            if (!initialized){
                throw (new Error("Key class has yet been initialized."));
            };
            return (Boolean((pCode in keysDown)));
        }
        private static function keyPressed(evt:KeyboardEvent):void{
            keysDown[evt.keyCode] = true;
            globalKey(evt);
        }
        private static function keyReleased(evt:KeyboardEvent):void{
            if ((evt.keyCode in keysDown))
			{
				keysDown[evt.keyCode];
            }
        }
        private static function clearKeys(evt:Event):void{
            keysDown = new Object();
        }
        private static function globalKey(evt:KeyboardEvent):void{
            var fun:Function;
            if (GameStage.instance.autoGuideFly){
                return;
            }
            if (((evt.ctrlKey) && (evt.altKey))){
                fun = _ctrlAlt[evt.charCode];
            } else {
                if (evt.ctrlKey){
                    fun = _ctrl[evt.charCode];
                } else {
                    if (evt.altKey){
                        fun = _alt[evt.charCode];
                    } else {
                        fun = _normal[evt.charCode];
                    }
                }
            }
            if (fun != null){
                fun(evt);
            }
        }

    }
}