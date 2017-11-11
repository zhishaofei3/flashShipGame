package src{

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class CarryOutKeyFunction extends EventDispatcher {
		private static var downArray:Array = [];//按下的数组
		private static var displayObject:DisplayObject;//显示对象
		private static var carryOutArray:Array = [];//当前数组

		public function CarryOutKeyFunction() {
		}

		public static function objectMove(dso:DisplayObject):void {//设置需要移动的物体
			displayObject = dso;//赋值到全局变量
			displayObject.addEventListener(Event.ENTER_FRAME, onEnterFrame);//反复执行注册过的函数
		}

		public static function register(keyCode:uint, fun:Function):void {
			downArray[ keyCode ] = fun;
			if (carryOutArray.indexOf(downArray[ keyCode ]) == -1) {
				carryOutArray.push(downArray[keyCode]);
			}
		}

		public static function deleteFun(keyCode:uint):void {//根据键值从数组里删除注册函数
			var i:int = carryOutArray.indexOf(downArray[keyCode]);
			carryOutArray.splice(i, 1);
		}

		private static function onEnterFrame(event:Event):void {
			if (carryOutArray != null) {
				for (var index:int = 0; index < carryOutArray.length; ++index) {
					if (carryOutArray[ index ] != null) {
						carryOutArray[ index ](displayObject);
					}
				}
			}
		}
	}
}
