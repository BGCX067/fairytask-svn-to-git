package com.jzonl.engine.resource
{
	import com.jzonl.engine.data.BaseData;
	import com.jzonl.engine.data.Modulator;
	import com.jzonl.engine.event.LogicEvent;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	/**
	 * 配置管理器：
	 * 用于协调各个配置文件的加载，使用，提供一种快捷访问有关配置文件的方式 
	 * @author jyhan
	 * 
	 */
	public class StaticIni
	{
		private static		var 	initArr		:BaseData	=	null;
		private static		var		configClass	:Object		=	null;
		
		private static		var		langData	:Object		=	null;
		private static		var		iniData		:Object		=	null;
		
		private static 	var 	serverData	:BaseData	=	new BaseData();
						
		public function StaticIni(target:IEventDispatcher=null)
		{
			//super(target);
		}
		
		/**
		 * 带文本替换功能的字符串
		 * @param StrID
		 * @param valArr
		 * @return 
		 * 
		 */		
		public static function getSwfLangStrVar(StrID:String,valArr:Array):String
		{
			if(langData == null)
			{
				return StrID;
			}			
			var data:*	=	langData[StrID];
			
			if(data == null)
			{
				return StrID;
			}
			
			var strData:String = String(data);
			
			var dataarray	:Array = [];			
			var indexpre	:int;
			var indexback	:int;
			var strget		:String;
			
			indexpre 	= strData.indexOf("{");
			indexback 	= strData.indexOf("}");
			
			while (indexpre != -1 && indexback != -1)
			{
				strget = strData.substring(indexpre, indexback + 1);
				
				var number		:int 	= int(strData.charAt(strData.indexOf("@") + 1));
				
				var strreplace	:String	=	valArr[number]
				
				strData 	= strData.replace(strget, strreplace);				
				indexpre 	= strData.indexOf("{");
				indexback 	= strData.indexOf("}");
			}
			
			return strData;
		}
		
		/**
		 * 文本转对象 
		 * @return 
		 * 
		 */
		public static function StrToObj(str:String):BaseData
		{
			var tmpObj		:BaseData	=	new BaseData();
			var indexpre	:int;
			var indexback	:int;
			var tmpStr		:String	=	"";
			indexpre 	= str.indexOf("{");
			indexback 	= str.indexOf("}");
			if(indexpre != -1 && indexback != -1)
			{
				tmpStr	= str.substring(indexpre+1, indexback);
				var tmpArr:Array	=	tmpStr.split(",");
				var itemArr	:Array	=	[];
				var itemStr	:String	=	"";
				while(tmpArr.length>0)
				{
					itemStr	=	tmpArr.shift();
					itemArr	=	itemStr.split(":");
					tmpObj.HandleProperties(itemArr.shift(),itemArr.shift());
				}
				return tmpObj;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * 取得服务器配置obj 
		 * @return 
		 * 
		 */
		public static function GetServerObj(configID:String):BaseData
		{
			if(serverData.CheckProperties(configID))
			{
				return serverData.GetProperties(configID);
			}
			return null;
		}
		
		/**
		 * 取得服务器配置string 
		 * @return 
		 * 
		 */
		public static function GetServerVar(configID:String,key:String):String
		{
			if(serverData.CheckProperties(configID))
			{
				return serverData.GetProperties(configID).GetProperties(key);
			}
			return null;
		}
		
		/**
		 * 从文件加载 
		 * @param path
		 */
		public static function initByPath(path:String):void
		{
			var urlLoader	:URLLoader	=	new URLLoader();
			urlLoader.load(new URLRequest(path));
			urlLoader.addEventListener(Event.COMPLETE, onConfigureLoaded);
			function onConfigureLoaded(evt:Event):void
			{
				var loginData	:Array	=	evt.target.data.split("\r\n");
				var indexpre	:int;
				var indexback	:int;
				var currentKey	:String	=	"";
				var tmpStr		:String	=	"";
				var tmpArray	:Array	=	[];
				var tmpObj		:BaseData	=	new BaseData();
				while(loginData.length>0)
				{
					tmpStr	=	loginData.shift();
					if(tmpStr=="")
					{
						continue;
					}
					//读表头
					indexpre 	= tmpStr.indexOf("[");
					indexback 	= tmpStr.indexOf("]");
					if(indexpre != -1 && indexback != -1)
					{
						tmpObj	=	new BaseData();
						currentKey = tmpStr.substring(indexpre+1, indexback);
					}
					else
					{
						//读内容
						tmpArray	=	tmpStr.split("=");
						if(tmpArray.length>0)
						{
							tmpObj.HandleProperties(tmpArray[0],tmpArray[1]);
						}
					}
					if(currentKey!="")
					{
						serverData.HandleProperties(currentKey,tmpObj);
					}
				}
				Modulator.getInstance().sendLogicEvent(LogicEvent.SERVERINIT);
			}
		}
		
		
		/**
		 * 获取配置好的字符串
		 * @param StrID
		 * @return 
		 * 
		 */		
		public static function getSwfLangStr(StrID:String):String
		{
			if(langData == null)
			{
				return StrID;
			}
			
			var data:*	=	langData[StrID];
			
			if(data == null)
			{
				return StrID;
			}
			else
			{
				return String(data)
			}
		}
		
		public	static	function initStaticFromObj(objData:Object):void
		{
			if(configClass == null)
			{
				configClass	=	objData;
				langData	=	configClass["getClassObj"]("Lang");
				iniData		=	configClass["getClassObj"]("IniClass");
			}
		}
		
		/**
		 * 获取配置信息 
		 * @param configID
		 * @return 
		 * 
		 */		
		public static function getIniObj(configID:String):Object
		{
			if(iniData == null)
			{
				return null;
			}
			return iniData[configID];
		}
		
		/**
		 * 获取Ini配置信息值
		 * @param configID
		 * @param valKey
		 * @return 
		 * 
		 */		
		public static function getIniVar(configID:*,valKey:String):String
		{
			if(iniData == null)
			{
				return null;
			}
			var dataobj:Object	=	getIniObj(String(configID));
			
			if(dataobj == null)
			{
				return ""
			}
			else
			{
				return dataobj[valKey];
			}
		}
		
		/**
		 * 以list列出的key 
		 * @param configID
		 * @return 
		 * 
		 */
		public static function getIniList(configID:*):Array
		{
			if(iniData == null)
			{
				return null;
			}
			var dataobj:Object	=	getIniObj(String(configID));
			
			if(dataobj == null||dataobj["list"]==null)
			{
				return []
			}
			else
			{
				return dataobj["list"].split(",");
			}
		}
		
		
		public static function getRes(configID:*):String
		{
			if(iniData == null)
			{
				return null;
			}
			var dataobj:Object	=	getIniObj(String(configID));
			
			if(dataobj == null)
			{
				return ""
			}
			else
			{
				return dataobj["path"];
			}
		}
		
		
		
		public static function getClipClass(loadinfo:LoaderInfo,ClassPath:String):Class
		{
			return loadinfo.applicationDomain.getDefinition(ClassPath) as Class;
		}
	}
}