package com.jzonl.engine.managers
{
	import com.jzonl.engine.data.BaseData;
	import com.jzonl.engine.resource.loader.SwfLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 资源管理器 
	 * @author Hanjy
	 * 
	 */	
	public class ResManager extends BaseData
	{
		private static	var res:ResManager;
				
		public static function getInstance():ResManager
		{
			if(res==null)
			{
				res	=	new ResManager();
			}
			return res;
		}
		
		public function ResManager(target:IEventDispatcher=null)
		{
		}
				
		public static function getResContentCopy(key:String):DisplayObject
		{
			return copy(getResContent(key));
		}

		public static function getResContent(key:String):DisplayObject
		{
			if(!isResHave(key))
			{
				return null;
			}
			
			var tRes:Object	=	res.GetProperties(key);
			
			if(tRes == null)
			{
				return null;
			}
			
			if(tRes is Bitmap)
			{
				var myBitmapData	:BitmapData		= 	new BitmapData(tRes.width, tRes.height, true, 0);
					myBitmapData.draw(tRes as Bitmap);
				return new Bitmap(myBitmapData);
			}
			else
			{
				var tClass:Class	=	tRes.constructor;
				
				tRes	=	new tClass();
				
				return  tRes as DisplayObject;
			} 
		}
		
		/**
		 * 加载一系列资源
		 * listArr[i]		:{key:String,url:String}
		 * onLoadComplete	:列表加载完成后的回调
		 * */
		public static function loadResList(listArr:Array,onLoadComplete:Function = null,thisObj:Object = null,onItemFun:Function = null):void
		{
			var tLength	:uint		=	listArr.length
			var n		:uint		=	0
			var	tKey	:String		=	"";
			var	tUrl	:String		=	"";
			var isClass	:Boolean	=	false
			
			var onLoadOver:Function	=	function(...argc):void
			{
				n++;
				if(tLength<=n)
				{
					if(onLoadComplete != null)
					{
						onLoadComplete.call(thisObj);
					}					
				}
				else
				{
					if(onItemFun != null)
					{
						onItemFun.call(thisObj);
					}					
				}				
			}
			
			for(var i:uint = 0 ; i < tLength ; i ++)
			{
				if(listArr[i].hasOwnProperty("key"))
				{
					tKey	=	listArr[i].key
				}
				else
				{
					throw new Error("LoadList have no key Item!");
				}
				
				if(listArr[i].hasOwnProperty("url"))
				{
					tUrl	=	listArr[i].url
				}
				else
				{
					throw new Error("LoadList have no url Item!");
				}
				
				if(listArr[i].hasOwnProperty("isClass"))
				{
					isClass	=	listArr[i].isClass
				}
				loadRes(tKey,tUrl,isClass,onLoadOver);
			}
		}
		
		/**
		 * 加载并缓存资源
		 * 
		 * @param key				：资源ID
		 * @param resPath			：资源加载地址
		 * @param onLoadComplete	：资源加载成功后的回调
		 * @param thisObj			：回调容器
		 * */
		public static function loadRes(key:String,resPath:String,isClassRes:Boolean	=	false,onLoadComplete:Function = null,onProcess:Function=null,pList:Array = null):void
		{
			if (res	==	null)
			{
				res	= 	ResManager.getInstance();
			}
						
			if(isResHave(key))
			{
				if( onLoadComplete!= null)
				{
					onLoadComplete(getResContent(key),pList);
				}				
				return;
			}
			
			var url		:String	=	resPath;
			//加载堆栈
			var tArray	:Array;
						
			if(!res.CheckProperties("temp"+key))
			{
				//新建1级缓冲
				tArray	=	new Array();
				res.HandleProperties("temp"+key,tArray);
				tArray.push([onLoadComplete,pList])
				
				SwfLoader.StartLoad(url,null,isClassRes,onLoadOver,onProcess,[key,tArray]);
			}
			else
			{
				//缓存加载序列
				if(onLoadComplete != null)
				{
					tArray		=	res.GetProperties("temp"+key);
					tArray.push([onLoadComplete,pList]);
				}				
			}
		}
		
		private static function onLoadOver(val:DisplayObject,pList:Array = null):void
		{
			var key		:String	=	pList[0];
			var tArray	:Array	=	pList[1];
			//保存资源
			res.HandleProperties(key,val);
			
			var tArr	:Array;
			
			var tFun	:Function;
			var tList	:Array;
			
			//取出1级缓存
			tArray	=	res.GetProperties("temp"+key);
			
			while(tArray.length>0)
			{
				tArr	=	tArray.pop();
				tFun	=	tArr[0];
				tList	=	tArr[1];
				
				if(tFun!=null)
				{
					var t:*	=	getResContent(key)
					tFun(t,tList);
				}
			}
			
			res.DeleteProperties("temp"+key);
		}
		
		public static function newResClass(className:String):DisplayObject
		{
			if(className == "" || className == null)
			{
				return null;
			}
			else
			{
				var cla		:Object			=	null;				
				var view	:DisplayObject	=	null;
				try
				{
					cla		=	getDefinitionByName(className)
					view	=	new cla() as DisplayObject;
					if(view==null)
					{
						var bmd:BitmapData	=	new cla() as BitmapData;
						view	 = new Bitmap(bmd);
					}
				}
				catch(e:*)
				{
					view	=	null;
				}
				return view;
			}
		}
		
		public static function getResClass(className:String):Class
		{
			if(className == "" || className == null)
			{
				return null;
			}
			else
			{
				var cla		:Class			=	null;				
				try
				{
					cla		=	ApplicationDomain.currentDomain.getDefinition(className) as Class;
				}
				catch(e:*)
				{
					cla	=	null;
				}
				return cla;
			}
		}
		
		/**
		 * 简单复制
		 * @param val		要复制的mc
		 * @param isLoaded	被复制对象是否加载过，如果未被加载过则不能使用二进制复制法
		 * @return 
		 * 
		 */		
		public static function copy(val:Object):DisplayObject
		{
			if(val == null)
			{
				return null;
			}
			
			if(val is Bitmap)
			{
				var myBitmapData	:BitmapData		= 	new BitmapData(val.width, val.height, true, 0);
					myBitmapData.draw(val as Bitmap);
				return new Bitmap(myBitmapData);
			}
			else
			{
				var tClass:Class	=	val.constructor;			
				return new tClass();
			}
			return null;
		}
		
		/**
		 * 判断资源是否缓存
		 * @param key
		 * 
		 */		
		public static function isResHave(key:String):Boolean
		{
			if (res	==	null)
			{
				res	=	ResManager.getInstance();
				return false;
			}
			
			if(key == null || key == "")
			{
				return false;
			}
			//IO.traceLog(key,"\ncheck key:"+res.CheckProperties(key));
			return res.CheckProperties(key);
		}
		
		
		
		/**
		 * 删除资源缓存
		 *  
		 * @param key	资源ID
		 * 
		 */		
		public static function deleteRes(key:String):void
		{
			if (res	==	null)
			{
				res	=	ResManager.getInstance();
				return;
			}
			
			if(key == null || key == "")
			{
				return;
			}

			if(res.CheckProperties(key))
			{
				res.DeleteProperties(key)
				if(res.CheckProperties("temp"+key))
				{
					res.DeleteProperties("temp"+key);
				}
			}
		}
	}
}