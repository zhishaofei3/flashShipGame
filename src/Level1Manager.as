package src{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import src.utils.common.util.DisObjUtil;

	public class Level1Manager {
		private static var me:MovieClip;//自己的船
		private static var island:MovieClip;//小岛
		private static var enemyArray:Array = new Array();//敌人数组
		private static const rockSpeedStart:Number = 0.04;//敌船移动最小速度
		private static var lastTime:uint;//上一次记录的时间
		private static var failPanel:UIFailPanel = new UIFailPanel();//失败弹窗

		public function Level1Manager() {
		}

		private static var addT:Timer;//计时器

		public static function init():void {
			addT = new Timer(400, 6);//初始化计时器，400毫秒执行一次，共执行6次
			createBg();//创建背景
			createMe();//创建自己的小船
			createIsland();//创建小岛
			KeyManager.keyFunction(Main.st);//把舞台传入按键管理类
			Main.st.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);//增加帧频事件
			addT.addEventListener(TimerEvent.TIMER, addShip);//增加Timer事件
			addT.start();//开启计时器
		}

		private static function createBg():void {
			var bg:UIBackGround1 = new UIBackGround1();//创建背景
			LayerManager.bgContainer.addChild(bg);//放入背景至背景容器
		}

		private static function createMe():void {
			if (me == null) {
				me = new UIMe();//创建玩家小船
			}
			me.x = Main.st.stageWidth / 2;//设置玩家小船x坐标
			me.y = Main.st.stageHeight - me.width;////设置玩家小船y坐标
			LayerManager.shipContainer.addChild(me);//把玩家小船放入小船容器
			CarryOutKeyFunction.objectMove(me);//把小船传入移动管理类
			Main.st.focus = Main.st;//设置焦点到舞台
		}

		private static function createIsland():void {
			island = new UIIsland();//创建小岛
			island.x = Main.st.stageWidth / 2;//设置小岛x坐标
			island.y = island.height / 2;//设置小岛y坐标
			LayerManager.islandContainer.addChild(island);//放入小岛至小岛容器
		}

		private static function addShip(e:TimerEvent = null):void {//增加新敌人
			var rint:int = int(Enemy.enemyClass.length * Math.random());//产生随机数
			var enemy:Enemy = new Enemy();//创建新敌人
			enemy.type = rint;//设置新敌人的类型为随机出的类型
			if (Math.random() > 0.5) {//根据随机数决定出生位置 参考ActionScript3.0GameProgrammingUniversity里的A3GPU05_AirRaid
				var hrand:Boolean = Math.random() > 0.5;//根据随机数设置位置
				enemy.y = Main.st.stageHeight * Math.random();
				enemy.x = hrand ? Main.st.stageWidth + enemy.width : -enemy.width;
				enemy.dx = hrand ? -Math.random() * 2 : Math.random() * 2;
				enemy.dy = enemy.y < (Main.st.stageHeight / 2) ? Math.random() * 2 : -Math.random() * 2;
			} else {
				var vrand:Boolean = Math.random() > 0.5;
				enemy.x = Main.st.stageWidth * Math.random();
				enemy.y = vrand ? Main.st.stageHeight + enemy.height : -enemy.height;
				enemy.dy = vrand ? -Math.random() * 2 : Math.random() * 2;
				enemy.dx = enemy.x < (Main.st.stageWidth / 2) ? Math.random() * 2 : -Math.random() * 2;
			}
			LayerManager.shipContainer.addChild(enemy);//把敌人放入小船容器
			enemyArray.push(enemy);//把敌人放入小船数组
		}

		public static function onEnterFrameHandler(e:Event):void {
			var timePassed:uint = getTimer() - lastTime;//时间差 参考ActionScript3.0GameProgrammingUniversity里的A3GPU05_AirRaid，这样可以让坐标位置计算的更加精准，不受flash player帧频影响
			lastTime += timePassed;//更新最后的时间
			moveRocks(timePassed);//把时间差作为参数传入移动敌人的函数
			checkCollisions();//检测是否碰到敌人或小岛
		}

		public static function moveRocks(timeDiff:uint):void {//移动敌人的函数 敌人位置的计算方法参考 ActionScript3.0GameProgrammingUniversity里的A3GPU07_SpaceRocks的陨石移动
			for (var i:int = enemyArray.length - 1; i >= 0; i--) {
				var enemy:Enemy = enemyArray[i];
				var rockSpeed:Number = rockSpeedStart + Math.random() * 0.1;
				enemy.x += enemyArray[i].dx * timeDiff * rockSpeed;
				enemy.y += enemyArray[i].dy * timeDiff * rockSpeed;
				// 当敌人移出舞台，重置位置
				if ((enemy.dx > 0) && (enemy.x > 640)) {//如果敌人的方向是向右的，并且移出了舞台的右侧，则重置敌人的位置到舞台左侧
					enemy.x -= 665;
				}
				if ((enemy.dx < 0) && (enemy.x < -25)) {//如果敌人的方向是向左的，并且移出了舞台的左侧，则重置敌人的位置到舞台右侧
					enemy.x += 565;
				}
				if ((enemy.dy > 0) && (enemy.y > 480)) {//如果敌人的方向是向下的，并且移出了舞台的下侧，则重置敌人的位置到舞台上侧
					enemy.y -= 505;
				}
				if ((enemy.dy < 0) && (enemy.y < -25)) {//如果敌人的方向是向上的，并且移出了舞台的上侧，则重置敌人的位置到舞台下侧
					enemy.y += 505;
				}
			}
		}

		private static function checkCollisions():void {//碰撞检测(敌人或小岛) 参考 ActionScript3.0GameProgrammingUniversity里的A3GPU05_AirRaid的坦克子弹与飞机的碰撞检测
			for (var j:int = enemyArray.length - 1; j >= 0; j--) {//将敌人数组里的敌人分别取出
				var enemy:Enemy = enemyArray[j];//取出一个敌人
				if (enemy.hitTestObject(me)) {//判断敌人是否与我碰撞
					Main.st.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);//移除帧频事件
					LayerManager.tipContainer.addChild(failPanel);//放置失败弹窗
					DisObjUtil.toStageCenter(failPanel);//将失败弹窗居中
					failPanel.tf.text = Main.playerName + " player , you lose game";//设置失败弹窗文字
					failPanel.replaybtn.addEventListener(MouseEvent.CLICK, onReplayBtn);//给replay按钮增加点击事件
					return;//返回，不必再进行小岛判断
				}
			}
			if (island.hitTestObject(me)) {//判断小岛是否与我碰撞
				Main.gotoLevel2();//进入第二关
			}
		}

		private static function onReplayBtn(e:MouseEvent):void {
			Main.gotoWelcome();//进入开始画面
		}

		public static function destroy():void {
			Main.st.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);//移除帧频事件
			LayerManager.clearContainer(LayerManager.bgContainer);//清空背景容器
			LayerManager.clearContainer(LayerManager.tipContainer);//清空弹窗容器
			LayerManager.clearContainer(LayerManager.islandContainer);//清空小岛容器
			while(enemyArray.length){//清空敌人
				Enemy(enemyArray[0]).destroy();//销毁敌人
				enemyArray.splice(0, 1);//从敌人数组中移除该敌人
			}
			LayerManager.clearContainer(LayerManager.shipContainer);//清空小船容器
		}
	}
}
