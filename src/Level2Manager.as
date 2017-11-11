package src{

	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import src.utils.common.util.DisObjUtil;

	public class Level2Manager {
		private static var textArray:Array;//文字数组
		private static var boxArray:Array = new Array();//装箱子的容器
		private static var lifeTxt:TextField;//生命值文本框
		private static var _life:int;//生命值
		private static var successPanel:UISuccessPanel = new UISuccessPanel();//成功弹窗
		private static var failPanel:UIFailPanel = new UIFailPanel();//失败弹窗
		
		public function Level2Manager() {
		}

		public static function init():void {
			textArray = ["gift","empty","empty","trap","trap"];//文字数组初始化
			_life = 2;//设置生命
			createBg();//创建背景
			createLifeTxt();//创建生命值文本框
			initBox();//创建箱子
		}

		private static function createBg():void {
			var bg:UIBackGround2 = new UIBackGround2();//创建背景2
			LayerManager.bgContainer.addChild(bg);//放入背景容器
		}

		private static function createLifeTxt():void{
			lifeTxt = new TextField();//创建生命文本框
			lifeTxt.text = "life: " +  String(life);//设置文本框显示生命值
			lifeTxt.setTextFormat(getTextFormat());//设置文本框样式，20号字、粗体
			LayerManager.tipContainer.addChild(lifeTxt);//把生命文本框放入提示容器层
		}

		private static function initBox():void {
			for (var i:int = 0; i <= 4; i++) {//创建5个箱子
				var box:UIBox = new UIBox();//创建箱子
				box.addEventListener(MouseEvent.CLICK, onClickHandler);//给箱子侦听鼠标单击事件
				var rand:int = Math.random() * textArray.length;//随机一个小于箱子数量的数
				box.tf.text = textArray.splice(rand, 1);//移除数组中的值，并赋值到箱子的文本框中
				TextField(box.tf).visible = false;//隐藏箱子上的文本框
				box.buttonMode = true;//设置箱子上的光标变成手型
				box.x = Math.random() * (Main.st.stageWidth - box.width);//箱子位置随机摆放
				box.y = Math.random() * (Main.st.stageHeight - box.height);//箱子位置随机摆放
				LayerManager.shipContainer.addChild(box);//把箱子放入装箱子的容器层中
			}
		}

		private static function onClickHandler(e:MouseEvent):void {
			var box:UIBox = e.target as UIBox;//取当前点击的箱子
			box.removeEventListener(MouseEvent.CLICK, onClickHandler);//移除单击事件
			box.tf.visible = true;//让该箱子的文本框显示出来
			if (box.tf.text == "gift") {//如果是礼物，则弹出成功弹窗
				LayerManager.tipContainer.addChild(successPanel);
				DisObjUtil.toStageCenter(successPanel);//让成功弹窗居中
				successPanel.tf.text = Main.playerName + " player , you win game";//设置昵称提示文字
				successPanel.replaybtn.addEventListener(MouseEvent.CLICK, onReplayBtn);//为成功弹窗的重玩按钮添加侦听单击事件
			} else if (box.tf.text == "trap") {//如果是炸弹，则生命值-1
				life--;
				if (life == 0) {//如果生命值为0，则游戏失败，弹出失败弹窗
					LayerManager.tipContainer.addChild(failPanel);
					DisObjUtil.toStageCenter(failPanel);//让失败弹窗居中
					failPanel.tf.text = Main.playerName + " player , you lose game";//设置昵称提示文字
					failPanel.replaybtn.addEventListener(MouseEvent.CLICK, onReplayBtn);//为失败弹窗的重玩按钮添加侦听单击事件
				}
			} else {
			}
		}

		private static function onReplayBtn(e:MouseEvent):void{
			Main.gotoWelcome();//返回到开始画面
		}

		public static function destroy():void {//销毁此关
			if (textArray) {//如果此数组存在
				if (textArray.length != 0) {//如果数组不为空
					textArray.length = 0;//使数组清空
				}
			}
			for (var i:int = 0; i < boxArray.length; i++) {//遍历箱子数组
				var box:UIBox = boxArray[i];//取出当前箱子
				box.removeEventListener(MouseEvent.CLICK, onClickHandler);//移除当前箱子的鼠标单击事件
				box = null;//设置箱子为null值
			}
			LayerManager.clearContainer(LayerManager.tipContainer);//清空提示层容器
			LayerManager.clearContainer(LayerManager.bgContainer);//清空背景层容器
			LayerManager.clearContainer(LayerManager.shipContainer);//清空箱子层容器
		}

		public static function set life(value:int):void {
			_life = value;//更新生命值
			lifeTxt.text = "life: " + String(life);//更新生命值文本框
			lifeTxt.setTextFormat(getTextFormat());//设置生命值文本框样式
		}

		private static function getTextFormat():TextFormat{//获得文本框的样式 参考ActionScript3.0GameProgrammingUniversity里的A3GPU09_TextExamples
			var tfFormat:TextFormat = new TextFormat();
			tfFormat.bold =true;
			tfFormat.size = 20;
			return tfFormat;
		}

		public static function get life():int{
			return _life;//获得当前生命值
		}
	}
}
