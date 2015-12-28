package com.jzonl.engine.resource.loader
{
	import com.jzonl.engine.data.BaseData;
	import com.jzonl.engine.managers.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;

	/**
	 * swf文件加载，适合加载文件大小较小的文件
	 * @author jyhan
	 */
	public class SwfLoader
	{
		//1级加载队列:
		static private var _itemArray1:Array=[];

		//2级缓存加载队列:
		static private var _itemArray2:Array=[];

		//加载器是否空闲
		static private var _isFree:Boolean=false;

		//缓存加载器
		static private var _swfLoaderArr:Array;

		//加载线程
		static private var _lines:uint=5;

		static private var _testCount:uint=0;

		//***********************************************************

		//对象加载完成后将要添加的容器
		private var _beAddContainer:DisplayObjectContainer;

		private var _complete:Function;
		private var _process:Function;

		private var _valList:Array;
		private var _isCache	:Boolean	=	false;
		private var _resUrl	:String	=	"";

		//***********************************************************

		private var _isLoading:Boolean=false;
		private var loader:Loader;

		//***********************************************************
		
		//加入可以缓存的内容
		protected static var resData	:BaseData	=	new BaseData();

		public function SwfLoader()
		{
			super();
		}

		/**
		 * 加载资源
		 * @param url				：资源地址
		 * @param beAddContainer	：显示容器（可选，当有值时，自动添加到容器中）
		 * @param canBeFind			：是否动过改变资源加载后的存放域，使得资源可以通过类名被重新创建（可选，默认false);
		 * @param complete			：完成处理函数
		 * @param process			：进度处理函数
		 * @param valList			：跟随complete一起传递的参数
		 * @param pCache			：是否缓存 缓存的直接取出
		 *
		 */
		public static function StartLoad(url:String, beAddContainer:DisplayObjectContainer=null, canBeFind:Boolean=false, complete:Function=null, process:Function=null,valList:Array=null,pCache:Boolean=false):void
		{
			if (_swfLoaderArr == null)
			{
				_swfLoaderArr= [];
				for (var i:int=0; i < _lines; i++)
				{
					_swfLoaderArr.push(new SwfLoader());
				}
			}
			
			if(resData.CheckProperties(url))
			{
				var copyRes	:DisplayObject	=	ResManager.copy(resData.GetProperties(url));
				if(copyRes!=null)
				{
					complete.call(null,copyRes, valList);
				}
				return;
			}

			//缓存加载队列			
			if (_isFree)
			{
				_itemArray1.push([url, beAddContainer, canBeFind, complete,process, valList,pCache]);
			}
			else
			{
				_itemArray2.push([url, beAddContainer, canBeFind, complete,process, valList,pCache]);
			}

			_testCount++;

			//开始队列
			findFreeToLoad();
		}

		//寻找空闲的加载器加载队列
		private static function findFreeToLoad():void
		{
			var loadings:SwfLoader;
			var freeLoadConut:uint=0;

			//寻找出一个加载器
			for (var i:int=0; i < _lines; i++)
			{
				loadings=_swfLoaderArr[i]
				//找到空闲加载器
				if (!loadings._isLoading)
				{
					//如果找加载队列不为空时
					if (_itemArray1.length > 0)
					{
						//取出一个加载进行加载
						_isFree=false;
						var tArr:Array=_itemArray1.shift() as Array;
						loadings.load(tArr[0], tArr[1], tArr[2], tArr[3], tArr[4], tArr[5], tArr[6]);
					}
					else
					{
						freeLoadConut++;
					}
				}
			}

			if (freeLoadConut == _lines && _isFree == false)
			{
				var tSize:uint=_itemArray2.length;

				_isFree=true;
				_itemArray1=new Array();

				for (var j:int=0; j < tSize; j++)
				{
					_itemArray1.push(_itemArray2.shift());
				}

				_itemArray2=new Array();

				findFreeToLoad();
			}
		}

		private function load(url:String, beAddContainer:DisplayObjectContainer=null, canBeFind:Boolean=false, complete:Function=null,process:Function=null, valList:Array=null,pCache:Boolean=false):void
		{
			_isLoading=true;
			_resUrl	=	url;
			_beAddContainer=beAddContainer;
			_complete=complete;
			_process=process;
			_valList=valList;
			_isCache	=	pCache;

			//创建并记录loader
			loader=new Loader();

			configureListeners(loader.contentLoaderInfo)

			var request:URLRequest=new URLRequest(url);

			if (canBeFind)
			{
				var context:LoaderContext=new LoaderContext();
				if (Security.sandboxType == Security.REMOTE)
				{
					context.securityDomain=SecurityDomain.currentDomain;
				}
				context.applicationDomain=ApplicationDomain.currentDomain;
				loader.load(request, context);
			}
			else
			{
				loader.load(request)
			}
		}

		/**配置加载事件*/
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS,			progressHandler);
//            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS,	httpStatusHandler);
//            dispatcher.addEventListener(Event.INIT,						initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
//            dispatcher.addEventListener(Event.OPEN,						openHandler);            
//            dispatcher.addEventListener(Event.UNLOAD,					unLoadHandler);
		}

		private function completeHandler(event:Event):void
		{
			SwfLoader._testCount--;
			event.target.removeEventListener(Event.COMPLETE, completeHandler);
			if(event.target.content!=null&&_isCache)
			{
				SwfLoader.resData.HandleProperties(_resUrl,event.target.content);
			}
			if (_beAddContainer == null)
			{
				_isLoading=false;
				if (_complete != null)
				{
					_complete.call(this, event.target.content, _valList);
					//GC.gc();
				}
				SwfLoader.findFreeToLoad();
			}
			else
			{
				_beAddContainer.addEventListener(Event.ADDED, onObjBeAdd);
				_beAddContainer.addChild(event.target.content);
			}
		}

		/**当加载对象被添加*/
		private function onObjBeAdd(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.ADDED, onObjBeAdd);
			_isLoading=false;
//        	this.dispatchEvent(new LoadEvent(LoadEvent.LOAD_ADD,e.target));
			if (_complete != null)
			{
				_complete.call(this, e.target, _valList);
			}
			_beAddContainer=null;
			findFreeToLoad();
		}

		private function progressHandler(event:ProgressEvent):void
		{
			if(_process!=null)
			{
				_process.call(this,event);
			}
		}

		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
//        	this.dispatchEvent(event);
//            trace("httpStatusHandler: " + event);
		}

		private function initHandler(event:Event):void
		{
//        	this.dispatchEvent(event);
//			trace("initHandler: " + event);
//			trace("[-2]");
		}

		private function ioErrorHandler(event:IOErrorEvent):void
		{
			//trace("SwfLoadError->", event.text);
			if (_complete != null)
			{
				_complete.call(this, null, _valList);
			}
			event.target.removeEventListener(Event.COMPLETE, completeHandler);
			_testCount--;
			_isLoading=false;
			findFreeToLoad();
		}

		private function openHandler(event:Event):void
		{
//        	this.dispatchEvent(event.clone());
//			trace("openHandler: " + event);
		}

		private function unLoadHandler(event:Event):void
		{
//        	this.dispatchEvent(event.clone());
//			trace("unLoadHandler: " + event);
		}
	}
}