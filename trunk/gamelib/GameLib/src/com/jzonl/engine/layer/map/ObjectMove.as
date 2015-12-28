package com.jzonl.engine.layer.map
{
	import flash.geom.Point;
	/**
	 * 人物移动路径计算 
	 * @author Navy
	 */
	public class ObjectMove extends Object
	{
		private static var GROUP_FOLLOW_DISTANCE:uint = 70;
		
		public function ObjectMove()
		{
			return;
		}
		public static function getRoute(startX:int, startY:int, endX:int, endY:int, wall:Wall):Array
		{
			var idx:int = 1;
			var offX:Number;
			var offY:Number;
			var routeArr:Array=[];
			var routePoint:RoutePoint = null;
			var endPoint:Point = new Point(endX, endY);
			var startPoint:Point = new Point(startX, startY);
			var disPoint:int = Point.distance(endPoint, startPoint);
			if (wall != null)
			{
				if (wall.isWall(startPoint.x, startPoint.y))
				{
					//trace("你站在墙上");
					offX = (endX - startX) * 10 / disPoint;
					offY = (endY - startY) * 10 / disPoint;
					while (idx < 5)
					{
						startPoint.offset(offX, offY);
						if (!wall.isWall(startPoint.x, startPoint.y))
						{
							startPoint.offset(offX * idx, offY * idx);
							return getRoute(startPoint.x, startPoint.y, endX, endY, wall);
						}
						idx++;
					}
					return [];
				}
				var dis:int	=	60;
				if (wall.isWall(endPoint.x, endPoint.y))
				{
					//trace("你点的是墙");
					if (!wall.isWall((endPoint.x - dis), endPoint.y)){
						endX = (endX - dis);
					} else {
						if (!wall.isWall((endPoint.x + dis), endPoint.y)){
							endX = (endX + dis);
						} else {
							if (disPoint > 20){
								return getDirectRoute(endX, endY, startX, startY, endPoint, startPoint, wall);
							}
							return [];
						}
					}
				}
			}
			var asterArr:Array = Astar.find(startX, startY, endX, endY, wall);
			if (asterArr!=null)
			{
				routePoint = new RoutePoint(startX, startY, endX, endY, asterArr, wall);
				routeArr = routePoint.route;
				if (routeArr && routeArr.length > 1)
				{
					routeArr.shift();
				}
				return routeArr;
			}
			return getDirectRoute(endX, endY, startX, startY, endPoint, startPoint, wall);
		}
		private static function getDirectRoute(endX:int, endY:int, startX:int, startY:int, endPoint:Point, startPoint:Point, wall:Wall):Array
		{
			var pDis:int = Point.distance(endPoint, startPoint);
			var disX:Number = (endX - startX) * 10 / pDis;
			var disY:Number = (endY - startY) * 10 / pDis;
			var step:int = 0;
			while (!wall.isWall(startX + disX * step, startY + disY * step))
			{
				startPoint.offset(disX, disY);
				step++;
			}
			startPoint.offset(-disX, -disY);
			return [[startPoint.x, startPoint.y]];
		}
		/**
		 * 取得附近路线 
		 * @param startX
		 * @param startY
		 * @param endX
		 * @param endY
		 * @param wall
		 * @return 
		 * 
		 */
		public static function getCloseToRoute(startX:int, startY:int, endX:int, endY:int, wall:Wall):Array
		{
			var fPointClone:Point = null;
			var returnArr:Array = null;
			var routeArr:Array = getRoute(startX, startY, endX, endY, wall);
			if (getRoute(startX, startY, endX, endY, wall) == null || routeArr.length <= 0)
			{
				return routeArr;
			}
			var followDis:uint = GROUP_FOLLOW_DISTANCE;
			var firstPoint:Point = new Point(routeArr[0][0], routeArr[0][1]);
			var startPoint:Point = new Point(startX, startY);
			var startDis:int = Point.distance(firstPoint, startPoint);
			if (routeArr.length == 1)
			{
				if (startDis < followDis)
				{
					return [[startX, startY]];
				}
				fPointClone = firstPoint.clone();
				fPointClone.offset((startPoint.x - firstPoint.x) * followDis / startDis, (startPoint.y - firstPoint.y) * followDis / startDis);
				returnArr = [[fPointClone.x, fPointClone.y]];
				return returnArr;
			}
			var rountCount:int = routeArr.length - 1;
			while (rountCount > 0)
			{
				
				firstPoint = new Point(routeArr[rountCount][0], routeArr[rountCount][1]);
				startPoint = new Point(routeArr[(rountCount - 1)][0], routeArr[(rountCount - 1)][1]);
				startDis = Point.distance(firstPoint, startPoint);
				if (startDis < followDis)
				{
					followDis = followDis - startDis;
				}
				else
				{
					fPointClone = firstPoint.clone();
					fPointClone.offset((startPoint.x - firstPoint.x) * followDis / startDis, (startPoint.y - firstPoint.y) * followDis / startDis);
					returnArr = routeArr.slice(0, (routeArr.length - 1));
					returnArr.push([fPointClone.x, fPointClone.y]);
					return returnArr;
				}
				rountCount--;
			}
			return null;
		}
		/**
		 * 取得战斗路径 
		 * @param startX
		 * @param startY
		 * @param endX
		 * @param endY
		 * @return 
		 * 
		 */
		public static function getBattleRoute(startX:int, startY:int, endX:int, endY:int):Point
		{
			var startPoint:Point = new Point(startX, startY);
			var endPoint:Point = new Point(endX, endY);
			var distance:int = Point.distance(startPoint, endPoint);
			var endPointClone:Point = endPoint.clone();
			endPointClone.offset((startX - endX) * GROUP_FOLLOW_DISTANCE / distance, (startY - endY) * GROUP_FOLLOW_DISTANCE / distance);
			endPointClone.x	=	int(endPointClone.x);
			endPointClone.y	=	int(endPointClone.y);
			return endPointClone;
		}
	}
}
