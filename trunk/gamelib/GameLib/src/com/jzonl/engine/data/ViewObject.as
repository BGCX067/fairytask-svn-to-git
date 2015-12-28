package com.jzonl.engine.data
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class ViewObject extends ObjectData
	{
		public var objId	:Point;
		/**
		 * 视图对象 
		 * @param _parent
		 * @param objKey
		 * @param target
		 * 
		 */
		public function ViewObject(_parent:ObjectData, objKey:Point, target:IEventDispatcher=null)
		{
			objId	=	objKey;
			super(_parent, objKey.toString(), target);
		}
		
		public	function	set ObjKey(val:String):void
		{
			_objKey	=	val;
		}
	}
}