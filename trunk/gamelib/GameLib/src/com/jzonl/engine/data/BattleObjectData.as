package com.jzonl.engine.data
{
	import flash.geom.Point;
	
	public class BattleObjectData extends ObjectData
	{
		//玩家是0 右下 怪物是1 左上
		public var againest	:int;
		public var objId		:Point;
		
		public function BattleObjectData(id:Point)
		{
			objId	=	id;
			super(null,id.toString());
		}
	}
}