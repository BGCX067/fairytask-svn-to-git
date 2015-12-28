package com.jzonl.engine.event
{
	import flash.events.Event;
	
	public class LoadingEvent extends Event
	{
		public static const FILE_LOADING	:String	=	"fileLoading";
		public static const DATA_LOADING	:String	=	"dataLoading";
		public static const LOADING_READY	:String="loadingReady";
		public static const BACKBROUD_LOADED	:String="backgroudLoaded";
		public static const LOAD_SHOW:String="LoadShow";
		public static const LOAD_HIDE:String="LoadHide";
		public static const SCENE_PROCESSING	:String	= "SCENE_PROCESS";
		public static const SCENE_LOAD		:String	=	"SCENE_LOADED";
		
		private var _data	:Object;
		public function LoadingEvent(type:String, value:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data	=	value;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

	}
}