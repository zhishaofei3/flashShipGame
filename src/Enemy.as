package src{

	import flash.display.MovieClip;

	import src.utils.common.component.display.AbstractDisplayObject;

	public class Enemy extends AbstractDisplayObject {
		public static const enemyClass:Array = [UIFrigateIcon, UISharkIcon, UIShipIcon];
		public var mc:MovieClip;//设置敌人的影片剪辑
		public var dx:Number;//设置敌人的水平移动差值
		public var dy:Number;//设置敌人的竖直移动差值
		private var _type:int;//设置敌人的类型

		public function Enemy() {
		}

		public function get type():int {//获取敌人的类型
			return _type;
		}

		public function set type(value:int):void {//设置的同时，创建敌人的影片剪辑
			var Cls:Class = Enemy.enemyClass[value];
			mc = new Cls();
			addChild(mc);
			_type = value;
		}

		override public function destroy():void {//销毁此敌人
			removeChild(mc);//从舞台中移除影片剪辑
			mc = null;//设置影片剪辑为空
			super.destroy();//调用父类的销毁
		}
	}
}
