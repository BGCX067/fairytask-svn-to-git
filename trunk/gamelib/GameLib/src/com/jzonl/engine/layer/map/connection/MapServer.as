package com.jzonl.engine.layer.map.connection
{
	import com.jzonl.engine.resource.loader.TileLoader;

	public class MapServer extends MapConnection
	{
		public var urlList:Array;
		private var clientId:int;
		public var freeList:Array;
		
		public function MapServer(param1:int = 1)
		{
			this.freeList = new Array();
			this.urlList = new Array();
			super(MapConnection.SERVER, param1);
			this.initTileList();
			return;
		}
		
		public function getFreeLoader() : TileLoader
		{
			var _loc_1:int = 0;
			while (_loc_1 < this.freeList.length)
			{
				
				if (this.freeList[_loc_1].url == null)
				{
					return this.freeList[_loc_1];
				}
				_loc_1++;
			}
			return null;
		}
		
		public function initTileList() : void
		{
			var _loc_1:int = 0;
			while (_loc_1 < 5)
			{
				
				_loc_1++;
			}
			return;
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
			return;
		}
		
		override public function receiveMessage(param1:Object) : void
		{
			var _loc_2:TileLoader = null;
			switch(param1.type)
			{
				case MapConnection.MSG_TYPE_LOAD:
				{
					_loc_2 = this.getFreeLoader();
					if (_loc_2)
					{
						_loc_2.load(param1);
					}
					else
					{
						this.urlList.push(param1);
					}
					break;
				}
				case MapConnection.MSG_TYPE_CLEAR:
				{
					this.clearAll();
					break;
				}
				default:
				{
					break;
					break;
				}
			}
			return;
		}
		
	}
}