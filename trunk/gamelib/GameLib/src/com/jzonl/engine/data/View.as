package com.jzonl.engine.data
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class View extends ObjectData
	{		
		private var _scene:Scene;
		public  var ViewId:uint	=	0;
		
		public function View(nViewId:uint,target:IEventDispatcher=null) 
		{
			_scene	=	Modulator.instance.scene;
			ViewId 	= 	nViewId;
			super(null,"View"+nViewId);
		}		
		public function ViewAdd(nObjectId:Point,pList:Array):void
		{
			//IO.traceLog("View add",_nViewId,nObjectId);
			//trace("pList:::",pList);
			var		tobj:ObjectData	= 	new ViewObject(this,nObjectId);
			var		i:uint	=	0 ;		
			while(pList.length>0)
			{						
				var proName:String	= _scene.getObjKey(pList.shift());
				tobj.HandlePropertiesEx(proName,pList.shift());	
//				trace(proName,data);
			}
			HandlePropertiesEx(String(nObjectId),tobj);
		}
		public function ViewRemove(nObjectId:Point):void
		{
			if(CheckProperties(String(nObjectId)))
			{
				DeletePropertiesEx(String(nObjectId));
			}				
		}		
		public function Clear():void
		{
			//清掉视图内容
			this.clearProperties();
			//GC.gc();
			//IO.traceLog("View" + _nViewId," Clear");
		}
		
		/**
		 * 根据物品属性获取物品对象 (仅支持int属性)
		 * @return 
		 * 
		 */		
		public function getItemByType(prop:String,pVal:*):ViewObject
		{
			var tmpObj	:ViewObject;
			for(var key:String in this.data)
			{
				if(GetProperties(key) is ViewObject)
				{
					tmpObj	=	GetProperties(key);
					if(tmpObj.GetProperties(prop)==pVal)
					{
						return tmpObj;
					}
				}
			}
			return null;
		}
	}
}