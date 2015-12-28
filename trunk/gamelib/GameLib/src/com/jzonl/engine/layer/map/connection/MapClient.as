package com.jzonl.engine.layer.map.connection
{
	import com.jzonl.engine.resource.loader.TileLoader;
	
	import flash.events.*;
	
	public class MapClient extends MapConnection
	{
		private var serverId:int;
		public var onData:Function;
		public var urlList:Array;
		private var clientId:int;
		public var freeList:Array;
		
		public function MapClient(param1:int = 1)
		{
			super(MapConnection.CLIENT, param1);
			this.freeList = new Array();
			this.urlList = new Array();
			this.initTileList();
		}
		
		public function getFreeLoader() : TileLoader
		{
			var count:int = 0;
			while (count < freeList.length)
			{
				if (this.freeList[count].url == null)
				{
					return freeList[count];
				}
				count++;
			}
			return null;
		}
		
		public function initTileList() : void
		{
			var count:int = 0;
			while (count < 5)
			{
				freeList[count] = new TileLoader(this);
				count++;
			}
		}
		
		public function clearAll() : void
		{
			this.urlList.length = 0;
			var _loc_1:int = 0;
			while (_loc_1 < this.freeList.length)
			{
				
				if (this.freeList[_loc_1].url != null)
				{
					TileLoader(this.freeList[_loc_1]).loadNext();
				}
				_loc_1++;
			}
		}
		
		override public function receiveMessage(param1:Object) : void
		{
			if (this.onData != null)
			{
				this.onData(param1);
			}
		}
		
		override public function receiveStatus(param1:Object) : void
		{
		}
		
		public function load(param1:Object) : void
		{
			var tmpLoader:TileLoader = this.getFreeLoader();
			if (tmpLoader)
			{
				tmpLoader.load(param1);
			}
			else
			{
				urlList.push(param1);
			}
		}
		
		override protected function statusHandler(event:StatusEvent) : void
		{
			switch(event.level)
			{
				case "status":
				{
					break;
				}
				case "error":
				{
					break;
				}
				default:
				{
					break;
					break;
				}
			}
		}
	}
}