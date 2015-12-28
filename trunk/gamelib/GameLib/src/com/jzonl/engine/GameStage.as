package com.jzonl.engine
{
	import com.jzonl.engine.layer.SceneLayer;
	import com.jzonl.engine.layer.scene.BattleLayer;
	import com.jzonl.engine.layer.scene.ItemLayer;
	import com.jzonl.engine.layer.scene.TileLayer;
	import com.jzonl.engine.layer.system.UILayer;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * 游戏场景 
	 * @author hanjy
	 * 
	 */	
	public class GameStage
	{
		public static var instance	:GameStage	=	null;
		public static var stage		:Stage	=	null;
		public static var rootW		:Number	=	1000;
		public static var rootH		:Number	=	600;
		public static var version		:String	=	"";
		public static var isLocal		:Boolean	=	false;
		//游戏各层
		public static var mainLayer	:Sprite		=	new Sprite();//主场景
		public static var sceneLayer	:SceneLayer	=	new SceneLayer();//场景层
		public static var battleLayer	:BattleLayer	=	new BattleLayer();
		public static var effectLayer		:Sprite	=	new Sprite(); //效果层
		public static var uiSpace			:UILayer	=	new UILayer();
		public static var mouseSpace		:Sprite	=	new Sprite();
		public static var sysSpace		:Sprite	=	new Sprite();
		private static var maskLayer		:Sprite	=	new Sprite();//蒙版层
		
		//系统层定义
		//public static var messageLayer	:MessageLayer;
		public static var tipsLayer		:Sprite;
		public static var debugLayer	:Sprite	=	new Sprite();
		//调试
		//==============================================================
		private static var _debug			:Boolean	=	false;
		//常量定义
		//==============================================================
		//是否自动引导
		public var autoGuideFly			:Boolean	=	false;
		
		public function GameStage()
		{
		}

		public static function initStage(_stage:Stage,_w:Number,_h:Number,_isDebug:Boolean=false):void
		{
			//写入验证
			var currentTime	:Number	=	new Date().getTime();
			var expireTime	:Number	=	new Date(2013, 5, 30).getTime();
			if(currentTime>expireTime)
			{
				throw new Error("can not init stage.");
				return;
			}
			
			if(instance==null)
			{
				instance	=	new GameStage();
			}
			
			stage	=	_stage;
			rootW	=	_w;
			rootH	=	_h;
			_debug	=	_isDebug;
			//设置舞台布局============================================================================
			stage.align		=	StageAlign.TOP_LEFT;
			stage.scaleMode	=	StageScaleMode.NO_SCALE;
			
			maskLayer.graphics.beginFill(0);
			maskLayer.graphics.drawRect(0,0,rootW,rootH);
			maskLayer.graphics.endFill();
			//=============================================
			
			stage.addChild(mainLayer);
			//添加游戏场景
			mainLayer.addChild(sceneLayer);
			mainLayer.addChild(maskLayer);
			mainLayer.addChild(battleLayer);
			mainLayer.addChild(effectLayer);
			
			effectLayer.mouseChildren = false;
			effectLayer.mouseEnabled	=	false;
			
			battleLayer.visible	=	false;
			//UI层
			mainLayer.addChild(uiSpace);
			
			//系统层
			tipsLayer	=	new Sprite();
			mainLayer.addChild(tipsLayer);
			
			mainLayer.addChild(debugLayer);
			
			instance.onStageReSize(null);
			
			stage.addEventListener(Event.RESIZE,instance.onStageReSize);
			
			sceneLayer.mask	=	maskLayer;
			//蒙版
			instance.stageMask();
		}
		
		/**
		 * 对场景进行蒙版 
		 * 
		 */
		private function stageMask():void
		{
			maskLayer.width	=	stage.stageWidth;
			maskLayer.height	=	stage.stageHeight;
			maskLayer.x		=	-mainLayer.x;
			maskLayer.y		=	-mainLayer.y;
		}
		
		private function onStageReSize(evt:Event):void
		{
			mainLayer.x	=(stage.stageWidth-rootW)*.5;
			mainLayer.y	=(stage.stageHeight-rootH)*.5;
			stageMask();
		}
		
		/**
		 * 显示战斗 
		 */
		public function showBattle(isAnimate:Boolean=false):void
		{
			battleLayer.show();
			sceneLayer.hideItem();
		}
		
		/**
		 * 隐藏战斗 
		 * @param isAnimate
		 * 
		 */
		public function hideBattle(isAnimate:Boolean=false):void
		{
			battleLayer.hide();
			sceneLayer.showItem();
		}
		
		public static function get itemLayer():ItemLayer
		{
			return sceneLayer.itemLayer;
		}
		
		/**
		 * 场景x位置 
		 * @return 
		 */
		public static function get x():Number
		{
			return mainLayer.x;
		}
		/**
		 * 场景y位置 
		 * @return 
		 */
		public static function get y():Number
		{
			return mainLayer.y;
		}
		
		/**
		 * 场景宽 
		 * @return 
		 */
		public static function get stageWidth():Number
		{
			return stage.stageWidth;
		}
		
		/**
		 * 场景高 
		 * @return 
		 */
		public static function get stageHeight():Number
		{
			return stage.stageHeight;
		}
		
		/**
		 * 取得地图层 
		 * @return 
		 * 
		 */
		public static function get tileLayer():TileLayer
		{
			return sceneLayer.tileLayer;
		}
	}
}