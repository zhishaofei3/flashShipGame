package src{

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import src.utils.common.util.DisObjUtil;

	public class LayerManager extends Sprite {
		public static var bgContainer:Sprite;//背景层
		public static var shipContainer:Sprite;//船层
		public static var islandContainer:Sprite;//小岛层
		public static var tipContainer:Sprite;//提示层

		public function LayerManager() {
		}

		public static function initView(cont:Sprite):void{
			bgContainer = new Sprite();//设置背景层容器
			cont.addChild(bgContainer);//背景层容器放入总容器
			shipContainer = new Sprite();//设置小船层容器
			cont.addChild(shipContainer);//小船层容器放入总容器
			islandContainer = new Sprite();//设置小岛容器
			cont.addChild(islandContainer);//小岛容器放入总容器
			tipContainer = new Sprite();//设置提示层容器
			cont.addChild(tipContainer);//提示层容器放入总容器
		}

		public static function clearContainer(container:DisplayObjectContainer):void {
			DisObjUtil.removeAllChildren(container);//清除容器内的所有元件
		}
	}
}
