package com.jzonl.engine.utils
{
	import com.jzonl.engine.data.BaseData;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;

	public class TimeServer
	{
		private static var date:Date = new Date();
		public static var lastTime	:int;
		
		public function TimeServer()
		{
			throw new Error("This is a static container.");
		}
		public static function onEnterFrame(event:Event):void
		{
			date = new Date();
		}
		public static function now():Number
		{
			return date.getTime();
		}
		
		/**
		 * 定时调用器
		 * @param pData
		 * @param callBack
		 * @param pList
		 */
		public static function lazyCall(pData:BaseData,callBack:Function,pList:Array=null):void
		{
			var timer:Timer	=	new Timer(1000,20);
			var onTimer:Function	=	function(evt:TimerEvent):void
			{
				if(pData!=null&&pData.HasProperties())
				{
					callBack.call();
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, onTimer);
				}
			};
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			var onFinish	:Function	=	function(evt:TimerEvent):void
			{
				callBack.call();
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onFinish);
			};
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onFinish);
			timer.start();
		}
	}
}