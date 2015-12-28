package com.jzonl.engine.utils
{
	import com.jzonl.engine.GameStage;
	import com.jzonl.engine.layer.map.Wall;

	public class MapMath
	{
		public function MapMath()
		{
		}
		
		/**
		 * 计算场景位置
		 * @param posX
		 * @param posY
		 * @return 
		 * 
		 */		
		public static function calPosAux(posX:int, posY:int,wall:Wall):Object
		{
			var mult:Number = 1;
			var fposX	:Number	=	0;
			var fposY	:Number	=	0;
			fposX	=	-GameStage.x;
			fposY	=	-GameStage.y;
			var retX:Number = (GameStage.stageWidth * mult) / 2-posX;
			var retY:Number = (GameStage.stageHeight * mult) / 2-posY;
			if (retX >= fposX)
			{
				retX = fposX;
			}
			else if (retX < GameStage.stageWidth * mult-(wall.mapWidth)+fposX)
			{
				retX = GameStage.stageWidth * mult-(wall.mapWidth)+fposX;
			}
			if (retY >= fposY)
			{
				retY = fposY;
			}
			else if(retY < GameStage.stageHeight * mult-wall.mapHeight+fposY)
			{
				retY = GameStage.stageHeight * mult-wall.mapHeight+fposY;
			}
			retX = retX;
			retY = retY;
			return {x:retX,y:retY,overwrite:true}
		}
	}
}