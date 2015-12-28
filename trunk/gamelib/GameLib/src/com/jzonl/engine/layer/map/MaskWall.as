package com.jzonl.engine.layer.map
{
	import flash.utils.*;
	
	public class MaskWall extends Object
	{
		public var mapId:int;
		public var mapWidth:int;
		public var mapHeight:int;
		private var _stepX:int;
		private var _stepY:int;
		private var _numOfMask:int;
		protected var _maskReady:Boolean = false;
		private var _itemList:Array;
		private var _byte:ByteArray;
		
		public function MaskWall()
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
		public function setData(maskData:ByteArray) : void
		{
			//mapId = maskData.readInt();
			mapWidth = maskData.readInt();
			mapHeight = maskData.readInt();
			_stepX = maskData.readInt();
			_stepY = maskData.readInt();
			_byte = new ByteArray();
			maskData.readBytes(_byte, 0, maskData.bytesAvailable);
			_byte.uncompress();
			_maskReady = true;
		}
		public function clear() : void
		{
			_maskReady = false;
			mapId = -1;
			if(null!=_byte)
			{
				_byte.length	=	0;
				_byte = null;
			}
		}
		
		public function isMask(px:uint, py:uint) : Boolean
		{
			if (_maskReady == false)
			{
				return false;
			}
			if (!_byte)
			{
				return false;
			}
			if (px < 0 || px > mapWidth || py < 0 || py > mapHeight)
			{
				//trace("来这里是不正常的",px,"py:",py);
				return false;
			}
			var mapPos:int = int(py / _stepY) * int(mapWidth / _stepX) + px / _stepX;
			return _byte[mapPos];
		}
	}
}
