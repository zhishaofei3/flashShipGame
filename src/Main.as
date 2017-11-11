package src{

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.IME;

	[SWF (backgroundColor="0xF0F0F0", width=640, height=480, frameRate="60")]//参考building interactive entertainment with ActionScript 3.0
	public class Main extends MovieClip {
		private static var welcome:UIWelcome;
		public static var playerName:String;
		public static var st:Stage;
		public function Main() {
			
		}

		private function init(e:Event = null):void {
			playerName = "player";//设置玩家默认的名字
			Main.st = stage;//设置st为舞台
			var viewContainer:Sprite = new Sprite();//设置总容器
			addChild(viewContainer);//把总容器加入舞台
			LayerManager.initView(viewContainer);//把总容器传给LayerManager初始化
			gotoWelcome();//执行gotoWelcome函数
		}

		public static function gotoWelcome():void{
			Level1Manager.destroy();//销毁第一关
			Level2Manager.destroy();//销毁第二关
			if(welcome==null){
				welcome = new UIWelcome();//新建开始画面元件
			}
			st.addChild(welcome);//把开始画面元件放入舞台
			welcome.startBtn.addEventListener(MouseEvent.CLICK, onClickHandler);//为开始游戏按钮添加侦听
		}

		private static function onClickHandler(e:MouseEvent):void { //参考Essential ActionScript 3.0
			if(welcome.nameTxt.text!=""){//如果文字不为空
				playerName = welcome.nameTxt.text;//把文字设置成玩家昵称
			}else{
				playerName = "abc";//默认为abc
			}
			gotoLevel1();//开始第一关
		}

		private static function gotoLevel1():void {
			st.removeChild(welcome);//从舞台移除welcome容器
			Level1Manager.init();//初始化第一关
		}

		public static function gotoLevel2():void {
			Level1Manager.destroy();//销毁第一关
			Level2Manager.init();//初始化第二关
		}
	}
}
