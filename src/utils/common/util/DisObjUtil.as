package src.utils.common.util {

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class DisObjUtil {
		public static function toStageCenter(diso:DisplayObject):void {//舞台居中的函数
			diso.x = 0;
			diso.y = 0;
			var rec:Rectangle = diso.getBounds(diso.stage);
			diso.x = -rec.x - rec.width / 2 + diso.stage.stageWidth / 2;
			diso.y = -rec.y - rec.height / 2 + diso.stage.stageHeight / 2;
		}

		public static function removeMe(dc:DisplayObject):void {//移除自身
			if (dc != null && dc.stage != null && dc.parent != null) {
				dc.parent.removeChild(dc);
			}
		}

		public static function removeAllChildren(dc:DisplayObjectContainer):void {//移除全部子对象
			while (dc && dc.numChildren) {
				dc.removeChildAt(0);
			}
		}
	}
}
