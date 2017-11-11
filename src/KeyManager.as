package src{

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyManager {
		public function KeyManager() {
		}

		public static function keyFunction(stage:Stage):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);//侦听键盘按键按下方法
			stage.addEventListener(KeyboardEvent.KEY_UP, onUpKey);//侦听键盘按键抬起方法
		}

		public static function removeKeyFunction(stage:Stage):void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);//移除键盘按键按下侦听
			stage.removeEventListener(KeyboardEvent.KEY_UP, onUpKey);//移除键盘按键抬起侦听
		}

		private static function onKey(e:KeyboardEvent):void {//参考ActionScript3.0GameProgrammingUniversity里的A3GPU12_RacingGame
			switch (e.keyCode) {//设置按下
				case Keyboard.LEFT:
					CarryOutKeyFunction.register(Keyboard.LEFT, KeyCode.leftDown);
					break;
				case Keyboard.UP:
					CarryOutKeyFunction.register(Keyboard.UP, KeyCode.upDown);
					break;
				case Keyboard.RIGHT:
					CarryOutKeyFunction.register(Keyboard.RIGHT, KeyCode.rightDown);
					break;
				case Keyboard.DOWN:
					CarryOutKeyFunction.register(Keyboard.DOWN, KeyCode.downDown);
					break;
				default:
					break;
			}
		}

		private static function onUpKey(event:KeyboardEvent):void {
			CarryOutKeyFunction.deleteFun(event.keyCode);//移除按下
		}
	}
}
