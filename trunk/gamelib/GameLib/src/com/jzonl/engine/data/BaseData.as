package com.jzonl.engine.data
{
	import flash.utils.Dictionary;
	/**
	 * 游戏基础数据 预计所有数据都通过这个来扩展 
	 * @author hanjy
	 * 
	 */	
	public class BaseData
	{
		//数据记录
		private var _data	:Dictionary;
		
		public function BaseData(weakKeys:Boolean=false)
		{
			_data	=	new Dictionary(weakKeys);
		}
		
		/**
		 * 设置属性 
		 * @param pKey
		 * @param pVal
		 * 
		 */
		public function HandleProperties(pKey:*,pVal:*):void
		{
			_data[pKey]	=	pVal;
		}
		
		/**
		 * 通过键值 取得属性 
		 * @param pKey
		 * @return 
		 * 
		 */
		public function GetProperties(pKey:*):*
		{
			return _data[pKey];
		}
		
		public final function GetPropertiesEx(PropertiesName:String):*
		{		
			if(!CheckProperties(PropertiesName))
			{
				return 0;
			}
			return GetProperties(PropertiesName);			
		}
		/**
		 * 检测属性是否存在 
		 * @param pKey
		 * @return 
		 * 
		 */
		public function CheckProperties(pKey:*):Boolean
		{
			return _data.hasOwnProperty(pKey);
		}
		
		/**
		 * 检查是否有属性 
		 * @return 
		 */
		public final function HasProperties():Boolean
		{
			var hasContent	:Boolean	=	false;
			for(var p:String in this._data)
			{
				hasContent	=	true;
				break;
			}
			return hasContent;
		}
		
		/**删除属性*/
		public final function DeleteProperties(PropertiesName : String):void
		{
			if (this._data.hasOwnProperty(PropertiesName) == true)
			{
				delete this._data[PropertiesName];
			}
			else
			{
				//throw new Error("[BaseObject::DeleteProperties]指定参数不存在！");
			}
		}
		
		/**
		 * 遍历数据 
		 * @param func
		 * 
		 */
		public function getDataForEach(func:Function):void
		{
			for(var p:String in _data)
			{
				func.call(this,p,_data[String(p)]);
			}
		}
		
		/**
		 * 清除所有属性 
		 */
		public function clearProperties():void
		{
			_data	=	new Dictionary();
		}

		public function get data():Dictionary
		{
			return _data;
		}

		public function set data(value:Dictionary):void
		{
			_data = value;
		}

	}
}