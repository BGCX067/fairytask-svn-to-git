package com.jzonl.engine.resource
{
	import com.jzonl.engine.GameStage;
	import com.jzonl.engine.data.BaseData;
	import com.jzonl.engine.utils.IO;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * 动态资源加载
	 * 资源可一次加载，重复使用 
	 * @author hanjy
	 * 
	 */	
	public class QueueLoader
	{
		private static var loaderArr		:Array	=	[];
		private static var queueFirstArr	:Array	=	[];
		private static var queueSecondArr	:Array	=	[];
		private static var isFree			:Boolean	=	false;
		private static var itemCount		:int	=	0;
		private static var data			:BaseData	=	new BaseData();
		private static var npcCatch		:BaseData	=	new BaseData();
		private static var monsterCatch	:BaseData	=	new BaseData();
		
		private var _isLoading		:Boolean	=	false;
		private var _byteLoader	:URLLoader;
		private var _content		:DisplayObject;
		private var _url			:String;
		private var _isDuplicate	:Boolean	=	true;
		private var _params		:Array	=	null;
		
		private var _completeCall	:Function;
		private var _processCall	:Function;
		
		public function QueueLoader()
		{
		}
		
		/**
		 * 开始加载资源，如果资源库有内容，直接返回 
		 * @param url
		 * @param completeCall
		 * @param processCall
		 * @param duplicate
		 * @param isQuick
		 * @param params 回调参数
		 * 
		 */
		public static function StartLoad(url:String,completeCall:Function,processCall:Function=null,duplicate:Boolean=true,isQuick:Boolean=false,params:Array=null):void
		{
			if(loaderArr.length==0)
			{
				var idx:int=0;
				while(idx<10)
				{
					loaderArr.push(new QueueLoader());
					idx++;
				}
			}
			url	=	url+"?version="+GameStage.version;
			//如果有数据直接返回
			if(data.CheckProperties(url))
			{
				var tmpContent:ByteArray	=	data.GetProperties(url);
				if(null!=params)
				{
					copyRes(tmpContent,completeCall,params);
				}
				else
				{
					copyRes(tmpContent,completeCall);
				}
			}
			else
			{
				var loadInfo:Array	=	[url,completeCall,processCall,duplicate,isQuick,params];
				if(isFree)
				{
					queueFirstArr.push(loadInfo);
				}
				else
				{
					queueSecondArr.push(loadInfo);
				}
				itemCount++;
				findFreeToLoad();
			}
		}
		
		/**
		 * 找到空闲的加载器 
		 */
		//private static var _cloadArr	:Array	=	[];
		private static function findFreeToLoad():void
		{
			var freeLoadConut:uint=0;
			
			for each(var tmpLoader:QueueLoader in loaderArr)
			{
				//找到空闲加载器
				if(!tmpLoader._isLoading)
				{
					//如果找加载队列不为空时
					if (queueFirstArr.length > 0)
					{
						//取出一个加载进行加载
						isFree=false;
						var tmpArr	:Array	=	queueFirstArr.shift();
						tmpLoader.threadLoad(tmpArr[0],tmpArr[1],tmpArr[2],tmpArr[3],tmpArr[5]);
					}
					else
					{
						freeLoadConut++;
					}
				}
			}
			
			if (freeLoadConut == loaderArr.length && isFree == false)
			{
				isFree=true;
				queueFirstArr=[];
				while(queueSecondArr.length>0)
				{
					queueFirstArr.push(queueSecondArr.shift());
				}
				findFreeToLoad();
			}
		}
		
		/**
		 * 复制资源 
		 * @param byte
		 * 
		 */
		private static function copyRes(byte:ByteArray,callBack:Function=null,params:Array=null):void
		{
			var loader	:Loader	=	new Loader();
			loader.loadBytes(byte);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(evt:Event):void
			{
				if (callBack != null)
				{
					if(params==null)
					{
						callBack.call(this, evt.target.content);
					}
					else
					{
						callBack.call(this, evt.target.content,params);
					}
				}
			});
		}
		
		private function threadLoad(...args):void
		{
			//var tArr:Array=queueFirstArr.shift();
			load(args[0], args[1], args[2], args[3], args[4]);
		}
		
		private function load(url:String,completeCall:Function,processCall:Function=null,duplicate:Boolean=true,params:Array=null):void
		{
			_url			=	url;
			_isLoading		=	true;
			_completeCall	=	completeCall;
			_processCall	=	processCall;
			_isDuplicate	=	duplicate;
			_params			=	params;
			//_valList=valList;
			
			//创建并记录loader
			//StageInfo.lowThread.addWork(threadLoad,[url]);
			_byteLoader=new URLLoader();
			_byteLoader.dataFormat	=	URLLoaderDataFormat.BINARY;
			configureListeners(_byteLoader)
			_byteLoader.load(new URLRequest(_url));
		}
		
		/**配置加载事件*/
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		/**
		 * 加载完毕 
		 * @param event
		 */
		private function completeHandler(event:Event):void
		{
			_isLoading=false;
			itemCount--;
			event.target.removeEventListener(Event.COMPLETE, completeHandler);
			if(_isDuplicate)
			{
				QueueLoader.data.HandleProperties(_url,event.target.data);
			}
			copyRes(event.target.data,_completeCall,_params);
			findFreeToLoad();
			(event.target as URLLoader).close();
		}
		
		/**
		 * 加载进度 
		 * @param event
		 */
		private function progressHandler(event:ProgressEvent):void
		{
			if(_processCall!=null)
			{
				_processCall.call(this,event);
			}
		}
		
		/**
		 * 错误控制 
		 * @param event
		 */
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			IO.traceLog("QueueLoadError->", event.text);
			event.target.removeEventListener(Event.COMPLETE, completeHandler);
			itemCount--;
			_isLoading=false;
			findFreeToLoad();
		}
		
		public function unload():void
		{
			if(null!=_byteLoader)
			{
				try{
					_byteLoader.close();
				}
				catch(err:Error){}
			}
		}
		
		/**
		 * 清除缓存 
		 */
		public static function clear():void
		{
			while(loaderArr.length>0)
			{
				var tmpLoader	:QueueLoader	=	loaderArr.shift();
				tmpLoader.unload();
				tmpLoader	=	null;
			}
			data.getDataForEach(function(key:String,val:*):void
			{
				if(key!="res/npc/normal_npc.swf")
				{
					val	=	null;
				}
			});
			data.clearProperties();
		}
	}
}