package src{
	import flash.display.DisplayObject;

	public class KeyCode {
		public function KeyCode() {
		}

		public static function leftDown(diso:DisplayObject):void {
			diso.x -= 1.2;//向左移动
		}

		public static function rightDown(diso:DisplayObject):void {
			diso.x += 1.2;//向右移动
		}

		public static function upDown(diso:DisplayObject):void {
			diso.y -= 1.2;//向下移动
		}

		public static function downDown(diso:DisplayObject):void {
			diso.y += 1.2;//向上移动
		}
	}
}
