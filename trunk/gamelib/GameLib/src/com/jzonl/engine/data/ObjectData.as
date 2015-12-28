package com.jzonl.engine.data
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class ObjectData extends BaseData
	{	
		protected	var		_objKey:String;	
		
		//父容器
		protected	var		_parent			:BaseData;
		protected	var		_bindManage		:BindManager;			
	
		public function ObjectData(parent:ObjectData=null,objKey:String=null,target:IEventDispatcher=null)
		{		
			_parent		=	parent;
			_objKey		=	objKey;
			_bindManage	=	BindManager.getInstance();
		}
		
		public function get parent():BaseData
		{
			return _parent;
		}
		public function set parent(val:BaseData):void
		{
			_parent	=	val;
		}

		public function DeletePropertiesEx(PropertiesName:String):void
		{
			if(CheckProperties(PropertiesName))
			{
				var	PropertiesValue:*	=	GetProperties(PropertiesName);			
				super.DeleteProperties(PropertiesName);
				_bindManage.CallBind(this,PropertiesName,PropertiesValue,false);
			}
		}
		
		/**
		 * 重新ObjectData的方法，添加服务器Addobj时回调的处理 
		 * @param PropertiesName
		 * @param PropertiesValue
		 * 
		 */		
		public function HandlePropertiesEx(PropertiesName:String, PropertiesValue:*):void
		{
			super.HandleProperties(PropertiesName,PropertiesValue);	
			_bindManage.CallBind(this,PropertiesName,PropertiesValue,true);
		}
		
		public	function	get ObjKey():String
		{
			return _objKey;
		}
	}
}