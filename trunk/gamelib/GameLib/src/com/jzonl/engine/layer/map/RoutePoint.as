package com.jzonl.engine.layer.map
{
	/**
	 * 路径点 
	 * 只把要转弯的点给出来， 人物按照二点间直线来走就行了
	 * @author Navy
	 */	
	public class RoutePoint
	{
		public var route:Array;
		public static const KEY_POINT_LENGTH:int = 10;
		
		public function RoutePoint(startX:int, startY:int, endX:int, endY:int, pathArr:Array, wall:Wall)
		{
			this.route = [];
			this.getRoute(startX, startY, endX, endY, pathArr, wall);
		}
		private function getRoute(startX:int, startY:int, endX:int, endY:int, pathArr:Array,wall:Wall) : void
		{
			var stepSpace:int	=	1;
			var wallPosX:int = 0;
			var wallPosY:int = 0;
			var tmpRoute:Array = [];
			var disX:int = endX - startX;
			var disY:int = endY - startY;
			var directSpace:Number = Math.round(Math.sqrt(disX * disX + disY * disY));
			var hasWall:Boolean = false;
			var isStartPoint:Boolean = false;
			var isEndPoint:Boolean = false;
			
			while (stepSpace < directSpace)
			{
				wallPosX = Math.round(startX + stepSpace*disX / directSpace);
				wallPosY = Math.round(startY + stepSpace*disY / directSpace);
				if(wall != null)
				{
					if(wall.isWall(wallPosX, wallPosY))
					{
						hasWall = true;
						break;
					}
				}
				stepSpace += KEY_POINT_LENGTH;
			}
			if (!hasWall)
			{
				stepSpace = 0;
				while (stepSpace < this.route.length)
				{
					tmpRoute = this.route[stepSpace];
					if (tmpRoute[0] == startX && tmpRoute[1] == startY)
					{
						isStartPoint = true;
					}
					if (tmpRoute[0] == endX && tmpRoute[1] == endY)
					{
						isEndPoint = true;
					}
					stepSpace++;
				}
				if (!isStartPoint)
				{
					this.route.push([startX, startY]);
				}
				if (!isEndPoint)
				{
					this.route.push([endX, endY]);
				}
				return;
			}
			var tPosX:int = startX;
			var tPosY:int = startY;
			var oppDisX:int = startX - endX;
			var stepSpaceCount:int = 0;
			var tmpDirectSpace:Number = 0;
			directSpace = 0;
			stepSpace = 0;
			while (stepSpace < pathArr.length)
			{
				tmpRoute = pathArr[stepSpace];
				tmpDirectSpace = Math.abs((disY * tmpRoute[0] + oppDisX * tmpRoute[1] + (endX * startY - startX * endY)) / Math.sqrt(disY * disY + oppDisX * oppDisX));
				if (directSpace < tmpDirectSpace)
				{
					directSpace = tmpDirectSpace;
					tPosX = tmpRoute[0];
					tPosY = tmpRoute[1];
					stepSpaceCount = stepSpace + 1;
				}
				stepSpace++;
			}
			if (directSpace == 0)
			{
				return;
			}
			stepSpace = 0;
			while (stepSpace < this.route.length)
			{
				
				tmpRoute = this.route[stepSpace];
				if (tmpRoute[0] == startX && tmpRoute[1] == startY)
				{
					isStartPoint = true;
				}
				stepSpace++;
			}
			if (!isStartPoint)
			{
				this.route.push([startX, startY]);
			}
			var tmpPathArr:Array = [];
			stepSpace = 0;
			while (stepSpace < stepSpaceCount)
			{
				tmpPathArr[stepSpace] = pathArr[stepSpace];
				stepSpace++;
			}
			var tmpPathArr2:Array = [];
			stepSpace = stepSpaceCount;
			while (stepSpace < pathArr.length)
			{
				tmpPathArr2[stepSpace - stepSpaceCount] = pathArr[stepSpace];
				stepSpace++;
			}
			if (tmpPathArr.length > 0)
			{
				this.getRoute(startX, startY, tPosX, tPosY, tmpPathArr,wall);
			}
			if (tmpPathArr2.length > 0)
			{
				this.getRoute(tPosX, tPosY, endX, endY, tmpPathArr2,wall);
			}
			stepSpace = 0;
			while (stepSpace < this.route.length)
			{
				tmpRoute = this.route[stepSpace];
				if (tmpRoute[0] == endX && tmpRoute[1] == endY)
				{
					isEndPoint = true;
				}
				stepSpace++;
			}
			if (!isEndPoint)
			{
				this.route.push([endX, endY]);
			}
		}
	}
}
