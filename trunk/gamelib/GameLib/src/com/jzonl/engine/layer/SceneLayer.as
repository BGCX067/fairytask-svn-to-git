package com.jzonl.engine.layer
{
	import com.jzonl.engine.data.Modulator;
	import com.jzonl.engine.event.LogicEvent;
	import com.jzonl.engine.event.SceneEvent;
	import com.jzonl.engine.layer.map.MaskWall;
	import com.jzonl.engine.layer.map.Wall;
	import com.jzonl.engine.layer.scene.BattleLayer;
	import com.jzonl.engine.layer.scene.ItemLayer;
	import com.jzonl.engine.layer.scene.TileLayer;
	import com.jzonl.engine.layer.scene.WildLayer;
	import com.jzonl.engine.utils.IO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	/**
	 * 场景层 
	 * @author hanjy
	 * 
	 */	
	public final class SceneLayer extends Sprite
	{
		private var _tileLayer	:TileLayer	=	new TileLayer();
		private var _wildLayer	:WildLayer	=	new WildLayer();
		private var _loader	:URLLoader	=	new URLLoader();
		private var _itemLayer	:ItemLayer	=	new ItemLayer();
		
		//数据
		private var model		:Modulator;
		
		//属性
		public var wall		:Wall; //阻挡
		public var maskWall	:MaskWall; //阴影
		public var mWidth		:int; //地图宽度
		public var mHeight		:int; //地图高度
		protected var modelId	:int;
		
		//内部
		private var _mapPath	:String	=	"res/scenes/";
		
		public function SceneLayer()
		{
			super();
			model	=	Modulator.getInstance();
			//添加人物层
			addChild(_tileLayer);
			addChild(_wildLayer);
			addChild(_itemLayer);
			//addChild(_battleLayer);
			//加载事件
			_loader.addEventListener(Event.COMPLETE, onWallLoaded);
			_loader.addEventListener(IOErrorEvent.IO_ERROR,onWallError);
		}

		public function get wildLayer():WildLayer
		{
			return _wildLayer;
		}

		/**
		 * 初始化城市场景 
		 * @param pId 场景ID
		 * 
		 */
		public function showCity(pId:int):void
		{
			//先清理城市场景
			if(wall&&maskWall)
			{
				clearCity();
			}
			
			modelId	=	pId;
			
			wall		=	new Wall();
			maskWall	=	new MaskWall();
			_tileLayer.visible	=	true;
			//addChildAt(tileLayer,0);
			
			//加载地图
			_loader.dataFormat	=	URLLoaderDataFormat.BINARY;
			_loader.load(new URLRequest(_mapPath+pId+"/"+pId+".wall"));
		}
		/**
		 * 加载完毕 
		 * @param evt
		 * 
		 */
		private function onWallLoaded(evt:Event):void
		{
			_loader.removeEventListener(Event.COMPLETE, onWallLoaded);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR,onWallError);
			wall.setData(_loader.data);
			mWidth	=	wall.mapWidth;
			mHeight	=	wall.mapHeight;
			
			_loader.addEventListener(Event.COMPLETE, onMaskLoaded);
			_loader.addEventListener(IOErrorEvent.IO_ERROR,onMaskError);
			_loader.dataFormat	=	URLLoaderDataFormat.BINARY;
			_loader.load(new URLRequest(_mapPath+modelId+"/"+modelId+".mask"));
		}
		
		/**
		 * 墙加载错误 
		 * @param evt
		 * 
		 */		
		private function onWallError(evt:IOErrorEvent):void
		{
			IO.traceLog([modelId+".wall","加载错误"]);
			_loader.load(new URLRequest(_mapPath+modelId+"/"+modelId+".wall"));
		}
		
		/**
		 * 阴影加载错误 
		 * @param evt
		 * 
		 */			
		private function onMaskError(evt:IOErrorEvent):void
		{
			IO.traceLog([modelId+".mask","加载错误"]);
			_loader.load(new URLRequest(_mapPath+modelId+"/"+modelId+".mask"));
		}
		
		/**
		 * 阴影加完后，就可以进游戏了 
		 * @param evt
		 * 
		 */
		private function onMaskLoaded(evt:Event):void
		{
			_loader.removeEventListener(Event.COMPLETE, onMaskLoaded);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR,onMaskError);
			maskWall.setData(_loader.data);
			
			tileLayer.setMap(modelId,model.scene.InitX,model.scene.InitY,mWidth,mHeight);
			
			model.sendSceneEvent(SceneEvent.SceneLoaded);
		}
		
		/**
		 * 清理城市场景 
		 */
		public function clearCity():void
		{
			if(null!=wall&&null!=maskWall)
			{
				wall.clear();
				maskWall.clear();
			}
			if(tileLayer.parent!=null)
			{
				tileLayer.clearAll();
				tileLayer.visible	=	false;
				//removeChild(tileLayer);
			}
		}
		
		/**
		 * 加载野外场景 
		 */
		public function showWild(pId:int,fId:int):void
		{
			//清理城市
			clearCity();
			_wildLayer.visible	=	true;
			//加载野外
			_wildLayer.loadMap(pId,fId);
			//addChildAt(_wildLayer,0);
			//addChild(itemLayer);
		}
		
		/**
		 * 清理野外 
		 */
		public function clearWild():void
		{
			_wildLayer.clear();
			if(_wildLayer.parent)
			{
				_wildLayer.visible	=	false;
			}
		}
		
		
		/**
		 * 取得地图层 
		 * @return 
		 * 
		 */
		public function get tileLayer():TileLayer
		{
			return _tileLayer;
		}
		
		/**
		 * 取得人物层 
		 * @return 
		 * 
		 */
		public function get itemLayer():ItemLayer
		{
			return _itemLayer;
		}

		
		/**
		 * 是否显示自己 
		 * @param showOwn
		 * 
		 */
		public function hideItem(showOwn:Boolean=false):void
		{
			if(!showOwn)
			{
				_itemLayer.visible	=	false;
			}
			else
			{
				//itemLayer.
			}
		}
		
		public function showItem():void
		{
			_itemLayer.visible	=	true;
		}
	}
}