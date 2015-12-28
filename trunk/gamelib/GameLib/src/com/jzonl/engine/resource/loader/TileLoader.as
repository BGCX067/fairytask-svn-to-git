package com.jzonl.engine.resource.loader
{
	import com.jzonl.engine.layer.map.connection.MapClient;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * 地图块加载器 
	 * @author Navy
	 */
	public class TileLoader extends Object
	{
		private var _urlLoader:URLLoader;
		private var _server:MapClient;
		private var _obj:Object;
		public  var url:String;
		
		public function TileLoader(mapClient:MapClient)
		{
			_server = mapClient;
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE, completeHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		public function completeHandler(event:Event):void
		{
			_obj.length = _urlLoader.data.length;
			_obj.data = _urlLoader.data;
			_server.onData(_obj);
			loadNext();
		}
		
		public function load(tmpobj:Object):void
		{
			url = tmpobj.url;
			if (url)
			{
				_obj = tmpobj;
				_urlLoader.load(new URLRequest(url));
			}
		}
		
		public function loadNext():void
		{
			url = null;
			_urlLoader.close();
			if (_server.urlList.length > 0)
			{
				_obj = _server.urlList.shift();
				load(_obj);
			}
		}
		
		public function errorHandler(event:IOErrorEvent):void
		{
			url = null;
			loadNext();
		}
		
	}
}