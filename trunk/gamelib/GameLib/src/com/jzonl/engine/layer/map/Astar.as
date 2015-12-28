package com.jzonl.engine.layer.map
{
	import flash.display.Shape;

	public class Astar
	{
		private static var STEP_LENGTH:int = 25;
		private static var hittest_cost:Number = 0;
		private static var cancelled:Boolean = false;
		private static const COST_STRAIGHT:int = 10;
		private static const COST_DIAGONAL:int = 14;
		private static const NOTE_ID_INDEX:int = 0;
		private static const NOTE_OPEN_INDEX:int = 1;
		private static const NOTE_CLOSED_INDEX:int = 2;
		private static var _maxTryValue:int = 14000;
		private static var _openListAry:Array;
		private static var _openCountLength:int;
		private static var _openID:int;
		private static var _xPointListAry:Array;
		private static var _yPointListAry:Array;
		private static var _pathScoreListAry:Array;
		private static var _movementCostListAry:Array;
		private static var _parentListAry:Array;
		private static var _noteMapAry:Array;
		private static var _wall:Wall;
		
		public function Astar()
		{
			return;
		}
		public static function cancel() : void
		{
			cancelled = true;
		}
		public static function find(startX:int, startY:int, endX:int, endY:int,wall:Wall) : Array
		{
			//var tmpShap	:Shape	=	new Shape();
			//trace("开始来找路....");
			var tmpArr:Array = [];
			initLists();
			_wall =wall;
			_openCountLength = 0;
			_openID = -1;
			openNote(startX, startY, 0, 0, 0);
			var curCount	:int	=	0;
			var idx			:int 	= 0;
			var px			:int	= 0;
			var py			:int 	= 0;
			var aroundArr	:Array 	= [];
			var tmpOpenId	:int 	= 0;
			var cost		:int 	= 0;
			var score		:int 	= 0;
			while (_openCountLength > 0)
			{
				++curCount;
				if (curCount > _maxTryValue)
				{
					destroyLists();
					return null;
				}
				
				idx = _openListAry[0];
				closeNote(idx);
				px = _xPointListAry[idx];
				py = _yPointListAry[idx];
				if (Math.abs(px - endX) < STEP_LENGTH && Math.abs(py - endY) < STEP_LENGTH)
				{
					return getPathAry(startX, startY, idx);
				}
				aroundArr = getArounds(px, py);
				for each (tmpArr in aroundArr)
				{
					/*tmpShap.graphics.beginFill(0x00ff00);
					tmpShap.graphics.drawRect(px,py,25,25);
					tmpShap.graphics.endFill();
					StageInfo.tileLayer.addChild(tmpShap);*/
					
					cost = _movementCostListAry[idx] + (tmpArr[0] == px || tmpArr[1] == py ? (COST_STRAIGHT) : (COST_DIAGONAL));
					var xDiff	:int	=	Math.abs(endX - tmpArr[0]);
					var yDiff	:int	=	Math.abs(endY - tmpArr[1]);
					score = cost + (xDiff*xDiff + yDiff*yDiff) * COST_STRAIGHT;
					if (isOpen(tmpArr[0], tmpArr[1]))
					{
						tmpOpenId = _noteMapAry[tmpArr[1]][tmpArr[0]][NOTE_ID_INDEX];
						if (cost < _movementCostListAry[tmpOpenId])
						{
							_movementCostListAry[tmpOpenId] = cost;
							_pathScoreListAry[tmpOpenId] = score;
							_parentListAry[tmpOpenId] = idx;
							aheadNote(getIndex(tmpOpenId));
						}
					}
					else
					{
						openNote(tmpArr[0], tmpArr[1], score, cost, idx);
					}
				}
			}
			destroyLists();
			//trace("没找到路径 ");
			return null;
		}
		private static function openNote(startX:int, startY:int, score:int, cost:int, _parent:int) : void
		{
			_openCountLength++;
			_openID++;
			if (_noteMapAry[startY] == null)
			{
				_noteMapAry[startY] = [];
			}
			_noteMapAry[startY][startX] = new Array();
			_noteMapAry[startY][startX][NOTE_OPEN_INDEX] = true;
			_noteMapAry[startY][startX][NOTE_ID_INDEX] = _openID;
			_xPointListAry.push(startX);
			_yPointListAry.push(startY);
			_pathScoreListAry.push(score);
			_movementCostListAry.push(cost);
			_parentListAry.push(_parent);
			_openListAry.push(_openID);
			aheadNote(_openCountLength);
		}
		private static function closeNote(idx:int) : void
		{
			_openCountLength--;
			var posX:int = _xPointListAry[idx];
			var posY:int = _yPointListAry[idx];
			_noteMapAry[posY][posX][NOTE_OPEN_INDEX] = false;
			_noteMapAry[posY][posX][NOTE_CLOSED_INDEX] = true;
			if (_openCountLength <= 0)
			{
				_openCountLength = 0;
				_openListAry = [];
				return;
			}
			_openListAry[0] = _openListAry.pop();
			backNote();
		}
		private static function aheadNote(openLength:int) : void
		{
			var openHalf	:int = 0;
			var openPre		:int = 0;
			while (openLength > 1)
			{
				openHalf = Math.floor(openLength / 2);
				if (getScore(openLength) < getScore(openHalf))
				{
					openPre = _openListAry[(openLength - 1)];
					_openListAry[(openLength - 1)] = _openListAry[(openHalf - 1)];
					_openListAry[(openHalf - 1)] = openPre;
					openLength = openHalf;
				}
				else
				{
					break;
				}
			}
		}
		private static function backNote() : void
		{
			var rPod:int = 1;
			var cPod:int = 0;
			var oPod:int = 0;
			while (true)
			{
				cPod = rPod;
				if (2 * cPod <= _openCountLength)
				{
					if (getScore(rPod) > getScore(2 * cPod))
					{
						rPod = 2 * cPod;
					}
					if (2 * cPod + 1 <= _openCountLength)
					{
						if (getScore(rPod) > getScore(2 * cPod + 1))
						{
							rPod = 2 * cPod + 1;
						}
					}
				}
				if (cPod == rPod)
				{
					break;
					continue;
				}
				oPod = _openListAry[(cPod - 1)];
				_openListAry[(cPod - 1)] = _openListAry[(rPod - 1)];
				_openListAry[(rPod - 1)] = oPod;
			}
		}
		private static function isOpen(px:int, py:int) : Boolean
		{
			if (_noteMapAry[py] == null)
			{
				return false;
			}
			if (_noteMapAry[py][px] == null)
			{
				return false;
			}
			return _noteMapAry[py][px][NOTE_OPEN_INDEX];
		}
		private static function isClosed(px:int, py:int) : Boolean
		{
			if (_noteMapAry[py] == null)
			{
				return false;
			}
			if (_noteMapAry[py][px] == null)
			{
				return false;
			}
			return _noteMapAry[py][px][NOTE_CLOSED_INDEX];
		}
		/**
		 * 找周围八方向点 
		 * @param posX
		 * @param posY
		 * @return 
		 * 
		 */
		private static function getArounds(posX:int, posY:int) : Array
		{
			var aroundArr:Array = [];
			var tmpX:int = 0;
			var tmpY:int = 0;
			var bothCanWalk:Boolean = false;
			tmpX = posX + STEP_LENGTH;
			tmpY = posY;
			var xRightCanWalk:Boolean = _wall.canWalk(tmpX, tmpY);//右能不能走
			if (_wall.canWalk(tmpX, tmpY) && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX;
			tmpY = posY + STEP_LENGTH;
			//下方能不能走
			var yDownCanWalk:Boolean = _wall.canWalk(tmpX, tmpY);
			if (_wall.canWalk(tmpX, tmpY) && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX - STEP_LENGTH;
			tmpY = posY;
			//左面能不能走
			var xLeftCanWalk:Boolean = _wall.canWalk(tmpX, tmpY);
			if (_wall.canWalk(tmpX, tmpY) && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX;
			tmpY = posY - STEP_LENGTH;
			//上方能不能走
			var yUpCanWalk:Boolean = _wall.canWalk(tmpX, tmpY);
			if (_wall.canWalk(tmpX, tmpY) && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX + STEP_LENGTH;
			tmpY = posY + STEP_LENGTH;
			//右下方能不能走
			bothCanWalk = _wall.canWalk(tmpX, tmpY);
			if (bothCanWalk && xRightCanWalk && yDownCanWalk && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX - STEP_LENGTH;
			tmpY = posY + STEP_LENGTH;
			//左下能不能走
			bothCanWalk = _wall.canWalk(tmpX, tmpY);
			if (bothCanWalk && xLeftCanWalk && yDownCanWalk && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX - STEP_LENGTH;
			tmpY = posY - STEP_LENGTH;
			//左上能不能走
			bothCanWalk = _wall.canWalk(tmpX, tmpY);
			if (bothCanWalk && xLeftCanWalk && yUpCanWalk && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			tmpX = posX + STEP_LENGTH;
			tmpY = posY - STEP_LENGTH;
			//左下能不能走
			bothCanWalk = _wall.canWalk(tmpX, tmpY);
			if (bothCanWalk && xRightCanWalk && yUpCanWalk && !isClosed(tmpX, tmpY))
			{
				aroundArr.push([tmpX, tmpY]);
			}
			return aroundArr;
		}
		private static function getPathAry(startX:int, startY:int, idx:int) : Array
		{
			var pathArr:Array = [];
			var px:int = _xPointListAry[idx];
			var py:int = _yPointListAry[idx];
			while (px != startX || py != startY)
			{
				
				pathArr.unshift([px, py]);
				idx = _parentListAry[idx];
				px = _xPointListAry[idx];
				py = _yPointListAry[idx];
			}
			pathArr.unshift([startX, startY]);
			destroyLists();
			//trace("最后取得的路径:",pathArr);
			return pathArr;
		}
		private static function getIndex(idx:int) : int
		{
			var index:int = 1;
			for each (var tmpOpenId:int in _openListAry)
			{
				if (tmpOpenId == idx)
				{
					return index;
				}
				index++;
			}
			return -1;
		}
		private static function getScore(param1:int) : int
		{
			return _pathScoreListAry[_openListAry[(param1 - 1)]];
		}
		private static function initLists() : void
		{
			_openListAry = [];
			_xPointListAry = [];
			_yPointListAry = [];
			_pathScoreListAry = [];
			_movementCostListAry = [];
			_parentListAry = [];
			_noteMapAry = [];
		}
		private static function destroyLists() : void
		{
			_openListAry = null;
			_xPointListAry = null;
			_yPointListAry = null;
			_pathScoreListAry = null;
			_movementCostListAry = null;
			_parentListAry = null;
			_noteMapAry = null;
			_wall = null;
		}
	}
}
