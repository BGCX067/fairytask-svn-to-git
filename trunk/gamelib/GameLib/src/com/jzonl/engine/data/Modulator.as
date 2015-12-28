package com.jzonl.engine.data
{
	import com.jzonl.engine.event.LogicEvent;
	import com.jzonl.engine.event.SceneEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * 数据中心 
	 * @author hanjy
	 * 
	 */	
	public class Modulator extends EventDispatcher
	{
		public static var instance	:Modulator	=	null;
		public var scene				:Scene		=	null; //场景 只存在一个
		
		public static function getInstance():Modulator
		{
			if(instance==null)
			{
				instance	=	new Modulator();
			}
			return instance;
		}
		
		public function Modulator(target:IEventDispatcher=null)
		{
			if(instance)
			{
				throw new Error("事件中心只能存在一个");
			}
			instance	=	this;
			scene		=	new Scene();
		}
		
		public function sendLogicEvent(evt:String,obj:Object=null):void
		{
			dispatchEvent(new LogicEvent(evt,obj));
		}
		
		public function sendSceneEvent(evt:String,arr:Array=null):void
		{
			dispatchEvent(new SceneEvent(evt,arr));
		}
	}
}