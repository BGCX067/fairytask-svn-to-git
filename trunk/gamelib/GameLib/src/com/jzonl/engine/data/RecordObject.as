package com.jzonl.engine.data
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class RecordObject extends ObjectData
	{
		public function RecordObject(parent:ObjectData=null, objKey:String=null, target:IEventDispatcher=null)
		{
			super(parent, objKey, target);
		}
	}
}