﻿package src.utils.common.component.display {

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.Dictionary;

	import src.utils.common.util.DisObjUtil;

    public class AbstractDisplayObject extends Sprite {//参考flash as3殿堂之路 扩展显示对象
        private var dictionary:Dictionary;

        public function AbstractDisplayObject() {
            this.dictionary = new Dictionary();
        }

        public function destroy():void {
            DisObjUtil.removeAllChildren(this);
            DisObjUtil.removeMe(this);
            this.removeAllEventListener();
        }

        override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
            super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            if (type == Event.REMOVED_FROM_STAGE)return;
            if (this.dictionary[type] == null) {
                this.dictionary[type] = new Array();
            }
            for (var i:int = 0; i < this.dictionary[type].length; i++) {
                if (this.dictionary[type][i] == listener) {
                    return;
                }
            }
            this.dictionary[type].push(listener);
        }

        private function removeAllEventListener():void {
            for (var i:String in dictionary) {
                for (var j:int = 0; j < dictionary[i].length; j++) {
                    this.removeEventListener(i, dictionary[i][j]);
                }
            }
        }
    }
}
