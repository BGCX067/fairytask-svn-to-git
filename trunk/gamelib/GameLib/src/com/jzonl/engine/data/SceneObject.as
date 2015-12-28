package com.jzonl.engine.data
{
	import flash.geom.Point;
	
	public class SceneObject extends ObjectData
	{
		//objid
		private	var		_objId		:Point;
		//type
		private	var		_type		:uint	= 0;
		//modelid
		private	var		_modelId	:uint	= 0;
		
		
		public function SceneObject(ID:Point)
		{
			_objId			=	ID;
			super(null,String(_objId));
		}
			
		public function get Type():uint
		{
			return _type;
		}
		public	function set ModelId(model:uint):void
		{
			_modelId	=	model;
		}
		
		public function set Type(type:uint):void
		{
			_type		=	type;
		}
		
		public function get ModelId():uint
		{
			return _modelId;
		}
		override public function HandlePropertiesEx(PropertiesName:String, PropertiesValue:*):void
		{
			switch(PropertiesName)
			{
				case "Model":
					ModelId	=	PropertiesValue;
					break;
				case "Type":
					Type	=	PropertiesValue;
					break;
			}
			super.HandlePropertiesEx(PropertiesName,PropertiesValue);
		}
		
		override public function DeletePropertiesEx(PropertiesName:String):void
		{
			super.DeletePropertiesEx(PropertiesName);	
		}	
		public	function	get ObjID():Point
		{
			return _objId;
		}
		public	function	set ObjID(val:Point):void
		{
			_objId	=	val;
		}
	}
}