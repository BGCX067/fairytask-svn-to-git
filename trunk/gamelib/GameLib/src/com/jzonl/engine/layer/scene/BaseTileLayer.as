package com.jzonl.engine.layer.scene
{
	import com.jzonl.engine.GameStage;
	import com.jzonl.engine.data.Modulator;
	import com.jzonl.engine.event.LoadingEvent;
	import com.jzonl.engine.event.LogicEvent;
	import com.jzonl.engine.event.SceneEvent;
	import com.jzonl.engine.layer.map.Tile;
	import com.jzonl.engine.resource.QueueLoader;
	import com.jzonl.engine.utils.GC;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	/**
	 * tile基类 
	 * @author hanjy
	 * 
	 */	
	public class BaseTileLayer extends Sprite
	{
		protected var tileTable:Object;
		protected var tileFlag:Object;
		protected var pmapId:int;
		protected var pWidth:int;
		protected var pHeight:int;
		protected var preX:int;
		protected var preY:int;
		protected var preBUp:int;
		protected var preBDown:int;
		protected var preBLeft:int;
		protected var preBRight:int;
		protected var concurrentLoading:int = 0;
		protected var tileRequestArray:Array;
		//各种容器
		protected var snapContainer	:Sprite	=	new Sprite();
		protected var realContainer	:Sprite	=	new Sprite();
		//设置地图
		protected var mapWidth	:int;
		protected var mapHeight	:int;
		protected var model		:Modulator;
		
		//常量
		protected var TILE_WIDTH	:int = 403;
		protected var TILE_HEIGHT	:int = 243;
		
		public function BaseTileLayer()
		{
			mouseChildren	=	false;
			tileRequestArray = new Array();
			tileTable = {};
			pmapId = -1;
			preX = -1;
			preY = -1;
			model	=	Modulator.getInstance();
			
			addChild(snapContainer);
			//realContainer.alpha	=	0;
			addChild(realContainer);
			
			//添加事件监听
			addEventListener(MouseEvent.CLICK,onClickMap);
		}
		
		private function onClickMap(evt:MouseEvent):void
		{
			model.sendSceneEvent(SceneEvent.CLICK_SCENE,[GameStage.stage.mouseX, GameStage.stage.mouseY]);
		}
		
		/**
		 * 设置地图 
		 * @param pMapID
		 * @param initX
		 * @param initY
		 * @param mapWidth
		 * @param mapHeight
		 * 
		 */
		public function setMap(pMapID:int, initX:int, initY:int, pMapWidth:int, pMapHeight:int):void
		{
			if(pMapID==-1)
			{
				return;
			}
			clearAll();
			pmapId = pMapID;
			mapWidth	=	pMapWidth;
			mapHeight	=	pMapHeight;
			pWidth = Math.ceil(mapWidth / TILE_WIDTH);
			pHeight = Math.ceil(mapHeight / TILE_HEIGHT);
			setCenterPix(initX, initY);
			//要加载缩略图
			QueueLoader.StartLoad("res/map/thumbnail/"+pMapID+".jpg", onSnapshotLoaded,null,true,false);
			
			/*_timer.addEventListener(TimerEvent.TIMER,onTimerGC,false,0,true);
			
			_timer.start();*/
		}
		
		/**
		 * 地图缩略图加载完毕 
		 * @param val
		 * 
		 */
		private function onSnapshotLoaded(val:Bitmap):void
		{
			while(snapContainer.numChildren>0)
			{
				snapContainer.removeChildAt(0);
			}
			
			var tmpSnap	:Bitmap	=	val;
			if(mapWidth>8191||mapHeight>2048)
			{
				var scaleRateX	:Number	=	mapWidth/tmpSnap.width;
				var scaleRateY	:Number	=	mapHeight/tmpSnap.height;
				var clipsH		:int	=	Math.ceil(mapWidth/8191);
				var clipsV		:int	=	Math.ceil(mapHeight/2048);
				
				var tmpWidth		:Number	=	tmpSnap.width/clipsH;
				var tmpHeight		:Number	=	tmpSnap.height/clipsV;
				
				var tmpX		:Number	=	0;
				var tmpY		:Number	=	0;
				
				
				for(var i:int=0;i<clipsH;i++)
				{
					for(var j:int=0;j<clipsV;j++)
					{
						tmpX	= i*tmpWidth;
						tmpY	= j*tmpHeight;
						var tmpBitMap		:Bitmap	=	new Bitmap();
						var tmpBitMapData	:BitmapData	=	new BitmapData(tmpWidth,tmpHeight);
						tmpBitMapData.copyPixels(tmpSnap.bitmapData,new Rectangle(tmpX,tmpY,tmpWidth,tmpHeight),new Point(0,0));
						
						tmpBitMap.bitmapData	=	tmpBitMapData;
						tmpBitMap.width		=	tmpWidth*scaleRateX;
						tmpBitMap.height	=	tmpHeight*scaleRateY;
						
						tmpBitMap.x	=	scaleRateX*tmpX;
						tmpBitMap.y	=	tmpY*scaleRateY;
						snapContainer.addChild(tmpBitMap);
					}
				}
			}
			else
			{
				tmpSnap.width	=	mapWidth;
				tmpSnap.height	=	mapHeight;
				
				snapContainer.addChild(tmpSnap);
			}
			
			model.dispatchEvent(new LoadingEvent(LoadingEvent.SCENE_LOAD));
		}
		
		/**
		 * 设置地图中心 
		 * @param initX
		 * @param initY
		 * 
		 */
		public function setCenterPix(initX:Number, initY:Number):void
		{
			setCenter(initX / TILE_WIDTH, initY / TILE_HEIGHT, initX, initY);
		}
		
		/**
		 * 地图中心  
		 * @param initStepX
		 * @param initStepY
		 * @param initX
		 * @param initY
		 * 
		 */
		public function setCenter(initStepX:int, initStepY:int, initX:int, initY:int):void
		{
			var cols:int = 0;
			var rows:int = 0;
			var posX:int = initX - (initStepX * TILE_WIDTH + TILE_WIDTH / 2);
			var posY:int = initY - (initStepY * TILE_HEIGHT + TILE_HEIGHT / 2);
			var tmpPreBLeft		:int = 0;
			var tmpPreBRight	:int = 0;
			var tmpPreBUp		:int = 0;
			var tmpPreBDown		:int = 0;
			if (posX > 70)
			{
				tmpPreBLeft = 1;
				tmpPreBRight = 2;
			}
			else if (posX < -70)
			{
				tmpPreBLeft = 2;
				tmpPreBRight = 1;
			}
			else
			{
				tmpPreBLeft = 1;
				tmpPreBRight = 1;
			}
			if (posY > 30)
			{
				tmpPreBUp = 1;
				tmpPreBDown = 2;
			}
			else if (posY < -30)
			{
				tmpPreBUp = 2;
				tmpPreBDown = 1;
			}
			else
			{
				tmpPreBUp = 1;
				tmpPreBDown = 1;
			}
			if (initStepX == (pWidth - 1))
			{
				tmpPreBLeft = 3;
				tmpPreBRight = 0;
			}
			else if (initStepX == 0)
			{
				tmpPreBLeft = 0;
				tmpPreBRight = 2;
			}
			else if (initStepX == pWidth - 2)
			{
				tmpPreBLeft = 2;
				tmpPreBRight = 1;
			}
			if (initStepY == (pHeight - 1))
			{
				tmpPreBUp = 3;
				tmpPreBDown = 0;
			}
			else if (initStepY == 0)
			{
				tmpPreBUp = 0;
				tmpPreBDown = 2;
			}
			else if (initStepY == pHeight - 2)
			{
				tmpPreBUp = 2;
				tmpPreBDown = 1;
			}
			if (preX == initStepX && preY == initStepY && preBDown == tmpPreBDown && preBUp == tmpPreBUp && preBLeft == tmpPreBLeft && preBRight == tmpPreBRight)
			{
				return;
			}
			tileFlag = {};
			tileRequestArray = [];
			preX = initStepX;
			preY = initStepY;
			preBUp = tmpPreBUp;
			preBDown = tmpPreBDown;
			preBLeft = tmpPreBLeft;
			preBRight = tmpPreBRight;
			var hCount:int = tmpPreBLeft > tmpPreBRight ? tmpPreBLeft:tmpPreBRight;
			var vCount:int = tmpPreBUp > tmpPreBDown ? tmpPreBUp:tmpPreBDown;
			var realCount:int = hCount > vCount ? hCount:vCount;
			loadTile(initStepX, initStepY);
			var idx:int = 1;
			while (idx <= realCount)
			{
				cols = initStepX - idx;
				rows = initStepY - idx;
				while (cols <= initStepX + idx)
				{
					if (cols >= 0 && cols < pWidth && rows >= 0 && rows < pHeight && cols >= initStepX - tmpPreBLeft && cols <= initStepX + tmpPreBRight && rows >= initStepY - tmpPreBUp && rows <= initStepY + tmpPreBDown)
					{
						loadTile(cols, rows);
					}
					cols++;
				}
				cols = initStepX - idx;
				rows = initStepY + idx;
				while (cols <= initStepX + idx)
				{
					if (cols >= 0 && cols < pWidth && rows >= 0 && rows < pHeight && cols >= initStepX - tmpPreBLeft && cols <= initStepX + tmpPreBRight && rows >= initStepY - tmpPreBUp && rows <= initStepY + tmpPreBDown)
					{
						loadTile(cols, rows);
					}
					cols++;
				}
				cols = initStepX - idx;
				rows = initStepY - idx + 1;
				while (rows <= initStepY + idx - 1)
				{
					if (cols >= 0 && cols < pWidth && rows >= 0 && rows < pHeight && cols >= initStepX - tmpPreBLeft && cols <= initStepX + tmpPreBRight && rows >= initStepY - tmpPreBUp && rows <= initStepY + tmpPreBDown)
					{
						loadTile(cols, rows);
					}
					rows++;
				}
				cols = initStepX + idx;
				rows = initStepY - idx + 1;
				while (rows <= initStepY + idx - 1)
				{
					if (cols >= 0 && cols < pWidth && rows >= 0 && rows < pHeight && cols >= initStepX - tmpPreBLeft && cols <= initStepX + tmpPreBRight && rows >= initStepY - tmpPreBUp && rows <= initStepY + tmpPreBDown)
					{
						loadTile(cols, rows);
					}
					rows++;
				}
				idx++;
			}
			//clearUnused();
			loadQueue();
		}
		
		protected function loadTile(cols:int,rows:int):void
		{
			
		}
		
		protected function loadQueue():void
		{
			var tileName	:String = null;
			var tile		:Tile = null;
			while (concurrentLoading <= 5 && tileRequestArray.length > 0)
			{
				tileName = tileRequestArray.shift();
				tile = tileTable[tileName];
				if (!tile.loaded && !tile.urlStream)
				{
					concurrentLoading--;
					tile.loadTile();
				}
			}
		}
		protected function onTileLoaded():void
		{
			concurrentLoading--;
			loadQueue();
		}
		public function clearAll():void
		{
			/*while(snapContainer.numChildren>0)
			{
				//snapContainer.removeChildAt(0);
			}*/
			/*_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER,onTimerGC);*/
			
			mapId	=	-1;
			var tile:Tile = null;
			for each (tile in tileTable)
			{
				realContainer.removeChild(tile);
				tile.unloadTile();
				tile	=	null;
			}
			while(realContainer.numChildren>0)
			{
				realContainer.removeChildAt(0);
			}
			preX = -1;
			preY = -1;
			tileFlag = {};
			tileTable = {};
			tileRequestArray = [];
			concurrentLoading = 0;
			tileRequestArray.length	=	0;
			//GC.gc();
		}
		private function clearUnused():void
		{
			var tileName:String = null;
			var tile:Tile = null;
			for (tileName in tileTable)
			{
				if (!tileFlag[tileName])
				{
					tile = tileTable[tileName];
					concurrentLoading--;
					realContainer.removeChild(tile);
					tile.unloadTile();
					delete tileTable[tileName];
				}
			}
		}
		
		//====================================================================
		//get set 方法区
		public function get mapId():int
		{
			return pmapId;
		}
		
		public function set mapId(value:int):void
		{
			pmapId = value;
		}
	}
}