package com.jzonl.engine.layer.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	public class Tile extends Sprite
	{
		public var urlStream:URLStream = null;
		public var url:String = null;
		public var onLoadedCallback:Function = null;
		public var loaded:Boolean = false;
		public var loader:Loader = null;
		
		public function Tile()
		{
			loader = new Loader();
			addChild(loader);
			alpha	=	0;
		}
		
		public function loadTile():void
		{
			if (url && !loaded)
			{
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded,false,0,true);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onComplete,false,0,true);
				loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError,false,0,true);
				loader.load(new URLRequest(url));
			}
		}
		
		/**
		 * 加载完毕 
		 * @param evt
		 * 
		 */
		private function onLoaded(evt:Event):void
		{
			loaded = true;
			alpha	=	1;
			try{
				loader.close();
			}
			catch(err:Error){}
			if (onLoadedCallback != null)
			{
				onLoadedCallback.apply();
			}
		}
		
		public function unloadTile():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaded);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onComplete);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			try{
				loader.close();
			}
			catch(err:Error){}
			loaded = false;
		}
		
		protected function onComplete(event:Event):void
		{
			loaded = true;
			alpha	=	1;
			if (onLoadedCallback != null)
			{
				onLoadedCallback.apply();
			}
		}
		
		protected function onIOError(event:IOErrorEvent):void
		{
			unloadTile();
			if (onLoadedCallback != null)
			{
				onLoadedCallback.apply();
			}
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			unloadTile();
			if (onLoadedCallback != null)
			{
				onLoadedCallback.apply();
			}
		}
	}
}