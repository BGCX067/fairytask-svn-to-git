package com.jzonl.engine.layer.map
{
	import flash.utils.*;
	
	public class Wall extends Object
	{
		public var mapId:int;
		public var mapWidth:int;
		public var mapHeight:int;
		private var _stepX:int;
		private var _stepY:int;
		private var _numOfMask:int;
		protected var _wallReady:Boolean = false;
		private var _itemList:Array;
		private var _byte:ByteArray;
		
		public function Wall()
		{
		}
		public function get numOfMask() : int
		{
			return _numOfMask;
		}
		public function get itemList() : Array
		{
			return _itemList;
		}
		public function setData(byteData:ByteArray) : void
		{
			mapId = 10;//byteData.readInt();
			
			MapInfo.mapWidth	=	mapWidth = byteData.readInt();
			MapInfo.mapHeight	=	mapHeight = byteData.readInt();
//			trace(mapWidth);
//			trace(mapHeight);
			_stepX = byteData.readInt();
			_stepY = byteData.readInt();
//			trace("_stepX",_stepX,"_stepY",_stepY);
//			_numOfMask = byteData.readInt();
			//trace("_numOfMask",_numOfMask);
			_byte = new ByteArray();
			byteData.readBytes(_byte, 0, byteData.bytesAvailable);
			_byte.uncompress();
			_wallReady = true;
			/*if(StageInfo.debug)
			{
				//画阻挡与网格
				StageInfo.blockLayer.drawBlock(_byte,mapWidth,mapHeight);
			}*/
		}
		public function clear() : void
		{
			_wallReady = false;
			mapId = -1;
			if(null!=_byte)
			{
				_byte.length	=	0;
				_byte = null;
			}
		}
		public function searchNearestWalkable(posX:int, posY:int) : Object
		{
			//trace("只有找找附近的了....");
			var nearX:Number;
			var nearY:Number;
			if (canWalk(posX, posY))
			{
				return {successful:true, x:posX, y:posY};
			}
			var range:Number = 1000;
			var idx:int = 0;
			while (idx < 1000)
			{
				nearX = Math.random() * range - 500 + posX;
				nearY = Math.random() * range - 500 + posY;
				if (canWalk(nearX, nearY))
				{
					return {successful:true, x:nearX, y:nearY};
				}
				idx++;
			}
			return {successful:false};
		}
		public function searchNearestWalkableInRange(sx:int, sy:int, rx:Number = 10, ry:Number = 20) : Object
		{
			var px:Number = NaN;
			var py:Number = NaN;
			var idx:int = 0;
			while (idx < 1000)
			{
				px = Math.random() * (ry - rx) + rx + sx;
				py = Math.random() * (ry - rx) + rx + sy;
				if (canWalk(px, py))
				{
					return {successful:true, x:px, y:py};
				}
				idx++;
			}
			return {successful:false};
		}
		public function canWalk(px:uint, py:uint) : Boolean
		{
			return !isWall(px, py);
		}
		public function isWall(px:uint, py:uint) : Boolean
		{
			if (_wallReady == false)
			{
				return true;
			}
			if (!_byte)
			{
				return true;
			}
			if (px < 0 || px > mapWidth || py < 0 || py > mapHeight)
			{
				return true;
			}
			var mapPos:int = int(py / _stepY) * int(mapWidth / _stepX) + px / _stepX;
			return _byte[mapPos];
		}
	}
}
