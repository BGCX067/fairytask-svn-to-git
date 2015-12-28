package com.jzonl.engine.data
{
	import flash.events.IEventDispatcher;
	
	public class BindManager extends BaseData
	{
		
		private static 	var 	_self	:BindManager;		
		
		//主角属性绑定
		private 	var		_arrRoleProperty:BaseData;
		
		private 	var		_callbackTable	:BaseData;
		
		private	var		_sceneobjGroup	:CallBackGroup;
		private	var		_arrSceneProp	:BaseData;
		
		//视图回调组数组
		protected var _viewCallBackGroup:Array			= new Array();		
		//表格回调组数组
		protected var _recCallBackGroup:Array			= new Array();		
		
		
		/**获取实例*/
		public static function getInstance():BindManager
		{
			if ( _self == null )
			{
				_self = new BindManager();
			}
			return _self;
		}
		
		
		public function BindManager(target:IEventDispatcher=null)
		{
			Init();
		}
		private function Init():void
		{
			_callbackTable	=	new BaseData();
			_sceneobjGroup	=	new CallBackGroup();
			_arrSceneProp	=	new BaseData();
		}
		/**
		 * 绑定场景属性 
		 * @param scene
		 * @param PropertiesName
		 * @param addfunc
		 * @param removefunc
		 * @param pList
		 * @return 
		 * 
		 */		
		public function  BindSceneProperty(scene:Scene,PropertiesName:String,
										   addfunc:Function,removefunc:Function,
										   pList:Array = null):int
		{
			var		pArray:Array	=	null;
			//可带参
			if(null == pList)
			{
				pArray	=	new Array(PropertiesName,scene.GetPropertiesEx(PropertiesName));
			}
			else
			{
				pArray	=	new Array(PropertiesName,scene.GetPropertiesEx(PropertiesName),pList);
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,removefunc,pArray);
			
			//属性存在先回调一次
			if(scene.CheckProperties(PropertiesName))
			{
				callback.Call(true);
			}
			
			if(!_arrSceneProp.CheckProperties(PropertiesName))
			{
				_arrSceneProp.HandleProperties(PropertiesName, new CallBackGroup());
			}	
			
			return _arrSceneProp.GetProperties(PropertiesName).Add(callback);			
		}
		/**
		 * 绑定场景对象 
		 * @param scene
		 * @param addfunc
		 * @param removefunc
		 * @param datatype
		 * @param type
		 * @return 
		 * 
		 */		
		public function  BindSceneObj(scene:Scene,addfunc:Function,removefunc:Function,type:*):int
		{
			var	callback:CallBack	=	new CallBack(addfunc,removefunc,new Array(),type);		
			
			scene.getDataForEach(function (propName:String,val:*):void
			{
				//对目前所有的场景对象醉一次遍历
				if (val is SceneObject)
				{								
					//添加回调时都先调一次
					callback._args	=	new Array(propName,val);
					callback.Call(true);
				}								
			});
			
			return _sceneobjGroup.Add(callback);			
		}
		
		/**
		 * 绑定场景对象属性
		 * 只有场景中对象才能使用该方法，视图中对象不可使用 
		 * @param Obj
		 * @param PropertiesName
		 * @param addfunc
		 * @param removefunc
		 * @param pList
		 * @return 
		 * 
		 */		
		public function  BindPropInSceneObj(Obj:ObjectData,PropertiesName:String,
									addfunc:Function,removefunc:Function,
									pList:Array = null):int
		{
			
			var		pArray:Array	=	null;
			//可带参
			if(null == pList)
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName));
			}
			else
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName),pList);
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,removefunc,pArray);
			
			//属性存在先回调一次
			if(Obj.CheckProperties(PropertiesName))
			{
				callback.Call(true);
			}
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			var	objKey:String		=	Obj.ObjKey;
			
			if (!_callbackTable.CheckProperties(objKey))
			{
				_callbackTable.HandleProperties(objKey , new BaseData());
			}
			var	arrBindProp:BaseData	= _callbackTable.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindProp.CheckProperties(PropertiesName))
			{
				arrBindProp.HandleProperties(PropertiesName,new CallBackGroup());
			}
			var	callbackgroup:CallBackGroup	=	arrBindProp.GetProperties(PropertiesName);	
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
						
			return callbackgroup.Add(callback);				
		}
		/**
		 * 绑定视图对象属性
		 * 只有视图中对象才能使用该方法，场景对象不可使用 
		 * @param Obj
		 * @param PropertiesName
		 * @param addfunc
		 * @param removefunc
		 * @param pList
		 * @return 
		 * 
		 */		
		public function  BindPropInViewObj(viewObj:View,objKey:String,
									PropertiesName:String,
									addfunc:Function,removefunc:Function,
									pList:Array = null):int
		{
			
			var		pArray:Array	=	null;
			
			//视图中对象的属性绑定，属于二次绑定，对象一定能取到
			var		Obj:ObjectData	=	viewObj.GetPropertiesEx(objKey);
			//可带参
			if(null == pList)
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName));
			}
			else
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName),pList);
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,removefunc,pArray);
			
			//属性存在先回调一次
			if(Obj.CheckProperties(PropertiesName))
			{
				callback.Call(true);
			}
			
			//先检查是否有该视图的回调
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			var	viewKey:String		=	viewObj.ObjKey;
			
			if (!_callbackTable.CheckProperties(viewKey))
			{
				_callbackTable.HandleProperties(viewKey , new BaseData());
			}
			var	arrBindObj:BaseData	= _callbackTable.GetProperties(viewKey);
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应视图对象的回调表
			if (!arrBindObj.CheckProperties(objKey))
			{
				arrBindObj.HandleProperties(objKey , new BaseData());
			}
			var	arrBindObjProp:BaseData	= arrBindObj.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindObjProp.CheckProperties(PropertiesName))
			{				
				arrBindObjProp.HandleProperties(PropertiesName,new CallBackGroup());
			}			
			var	callbackgroup:CallBackGroup	=	arrBindObjProp.GetProperties(PropertiesName);	
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
						
			return callbackgroup.Add(callback);				
		}
		/**
		 * 绑定视图 
		 * @param scene 场景
		 * @param viewid 视图id, 用View.xxx
		 * @param addfunc 添加视图属性时
		 * @param removefunc 移除视力属性时
		 * @param data 传递的数据，通过addfunc/removefunc使用
		 * @return 绑定序列号 解绑时用
		 * 
		 */
		public	function BindView(scene:Scene,viewid:int,addfunc:Function,removefunc:Function,data:* = null):uint
		{
			//如果没有这个视图的话，创建它
			var	viewName:String	= "View" + String(viewid);
			if(!scene.CheckProperties(viewName))
			{
				var	view:View	=	new View(viewid);
				scene.HandlePropertiesEx(viewName,view);	
			}
			if (null == _viewCallBackGroup[viewName])
			{
				_viewCallBackGroup[viewName] = new CallBackGroup();
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,removefunc,new Array());		
			callback._args[2]		=	data;
			
			//遍历当前视图及视图中的数据
			scene.getDataForEach(function (propName:String,val:*):void
			{
				if(val is View  && (val as View).ViewId == viewid)
				{		
					val.getDataForEach(function (propName:String,val:*):void
					{				
						if(val is ViewObject)
						{
							callback._args	=	new Array(propName,val,data);
							callback.Call(true);
						}							
					});
					
				}								
			});
			
			return _viewCallBackGroup[viewName].Add(callback);	
		}
		/**
		 * 绑定表格 
		 * @param scene 场景
		 * @param recName 表格名称
		 * @param addfunc 属性添加更改时
		 * @param removefunc 移除属性时 一般为行
		 * @param data 传递的数据，通过addfunc/removefunc使用
		 * @return 绑定序列号 解绑时用
		 * @author hanjy
		 */
		public	function BindRecord(scene:Scene,recName:String,addfunc:Function,removefunc:Function,data:* = null):uint
		{			
			if (null == _recCallBackGroup[recName])
			{
				_recCallBackGroup[recName] = new CallBackGroup();
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,removefunc,new Array());	
			
			//遍历当前视图及视图中的数据
			if(scene.CheckProperties(recName))
			{
				var tmpRecord	:Record	=	scene.GetProperties(recName);
				tmpRecord.getDataForEach(function (propName:String,val:*):void
				{				
					if(val is RecordObject)
					{
						callback._args	=	new Array(propName,val);
						if(data)
						{
							callback._args[2]		=	data;
						}
						callback.Call(true);
					}							
				});
			}
			return _recCallBackGroup[recName].Add(callback);	
		}
		/**
		 * 绑定特定属性到特定控件的指定变量 
		 * @param PropertiesName
		 * @param callback
		 * 
		 */		
		public function BindProp(Obj:ObjectData,PropertiesName:String,control:Object,value:*,data:*=null):int
		{	
			var		pList:Array	 =  new Array(control,value);	
			if(data!=null)
			{
				pList.push(data);
			}
			var		index:int	 =	-1;
			if(Obj is SceneObject || Obj is BattleObjectData || Obj is View)
			{
				index	=	BindPropInSceneObj(Obj,PropertiesName,BindFunc,null,pList);
			}
			else if(Obj is ViewObject)
			{
				index	=	BindPropInViewObj(Obj.parent as View,Obj.ObjKey,PropertiesName,BindFunc,null,pList);
			}
			else if(Obj is Scene)
			{
				index	=	BindSceneProperty(Obj as Scene,PropertiesName,BindFunc,null,pList);
			}	
			return index;
		}
		
		private function BindFunc(PropertiesName:String,PropertiesValue:*,pList:Array):void
		{
			var		Obj:Object	=	pList[0];
			var		value:*		=	pList[1];
			Obj[value]			=	PropertiesValue;	
		}
		
		/**
		 * 绑定视图属性 
		 * @param view
		 * @param PropertiesName
		 * @param addfunc
		 * @param pList
		 * @return 
		 * 
		 */
		public function BindViewProp(view:View,PropertiesName:String,addfunc:Function,pList:*=null):int
		{
			var		pArray:Array	=	null;
			//可带参
			if(null == pList)
			{
				pArray	=	new Array(PropertiesName,view.GetPropertiesEx(PropertiesName));
			}
			else
			{
				pArray	=	new Array(PropertiesName,view.GetPropertiesEx(PropertiesName),pList);
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,null,pArray);
			
			//属性存在先回调一次
			if(view.CheckProperties(PropertiesName))
			{
				callback.Call(true);
			}
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			var	objKey:String		=	view.ObjKey;
			
			if (!_callbackTable.CheckProperties(objKey))
			{
				_callbackTable.HandleProperties(objKey , new BaseData());
			}
			var	arrBindProp:BaseData	= _callbackTable.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindProp.CheckProperties(PropertiesName))
			{
				arrBindProp.HandleProperties(PropertiesName,new CallBackGroup());
			}
			var	callbackgroup:CallBackGroup	=	arrBindProp.GetProperties(PropertiesName);	
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			return callbackgroup.Add(callback);
		}
		
		/**
		 * 绑定有交父对象obj的属性 
		 * @param Obj
		 * @param PropertiesName
		 * @param addfunc
		 * @param pList
		 * @return 
		 * 
		 */
		public function BindObjProp(Obj:ObjectData,PropertiesName:String,addfunc:Function,pList:*=null):int
		{
			var		pArray:Array	=	null;
			//可带参
			if(null == pList)
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName));
			}
			else
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName),pList);
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,null,pArray);
			
			//属性存在先回调一次
			if(Obj.CheckProperties(PropertiesName))
			{
				callback.Call(true);
			}
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			if(Obj.parent==null)
			{
				return -1;
			}
			var	objKey:String		=	(Obj.parent as ObjectData).ObjKey;
			
			if (!_callbackTable.CheckProperties(objKey))
			{
				_callbackTable.HandleProperties(objKey , new BaseData());
			}
			var	arrBindProp:BaseData	= _callbackTable.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			
			if (!arrBindProp.CheckProperties(Obj.ObjKey))
			{
				arrBindProp.HandleProperties(Obj.ObjKey , new BaseData());
			}
			arrBindProp	= arrBindProp.GetProperties(Obj.ObjKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindProp.CheckProperties(PropertiesName))
			{
				arrBindProp.HandleProperties(PropertiesName,new CallBackGroup());
			}
			var	callbackgroup:CallBackGroup	=	arrBindProp.GetProperties(PropertiesName);	
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			return callbackgroup.Add(callback);
		}
		
		/**
		 * 绑定表格属性 
		 * @param Obj
		 * @param PropertiesName
		 * @param addFunc
		 * @param data
		 * 
		 */
		public function BindRecordProp(Obj:ObjectData,PropertiesName:String,addfunc:Function,pList:*=null):int
		{
			var		pArray:Array	=	null;
			//可带参
			if(null == pList)
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName));
			}
			else
			{
				pArray	=	new Array(PropertiesName,Obj.GetPropertiesEx(PropertiesName),pList);
			}
			
			var	callback:CallBack	=	new CallBack(addfunc,null,pArray);
			
			//属性存在先回调一次
			if(Obj.CheckProperties(PropertiesName))
			{
				callback.Call(true);
			}
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			var	objKey:String		=	(Obj.parent as Record).ObjKey;
			
			if (!_callbackTable.CheckProperties(objKey))
			{
				_callbackTable.HandleProperties(objKey , new BaseData());
			}
			var	arrBindProp:BaseData	= _callbackTable.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			
			if (!arrBindProp.CheckProperties(Obj.ObjKey))
			{
				arrBindProp.HandleProperties(Obj.ObjKey , new BaseData());
			}
			arrBindProp	= arrBindProp.GetProperties(Obj.ObjKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindProp.CheckProperties(PropertiesName))
			{
				arrBindProp.HandleProperties(PropertiesName,new CallBackGroup());
			}
			var	callbackgroup:CallBackGroup	=	arrBindProp.GetProperties(PropertiesName);	
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			return callbackgroup.Add(callback);
		}
		
		//绑定场景的obj变化，切场景时，需要重新绑定
		
		
		//绑定视图变化，切场景时，需要重新绑定
		
		//绑定表格变化，切场景时，需要重新绑定
		
		
		//绑定属性变化，当对象移除，自动解除绑定， 当需要永久绑定时，肯定是多层绑定
		//多层绑定肯定会在一层绑定时，遍历绑定其他层
		
		public function CallBind(Obj:ObjectData,PropertiesName:String, PropertiesValue:*,isAdd:Boolean):void
		{
			//分类处理			
			if(Obj is Scene)
			{	
				//场景				
				CallSceneBind(Obj,PropertiesName,PropertiesValue,isAdd);	
			}
			
			else if(Obj is SceneObject)
			{
				//场景对象
				//肯定是属性变化,属性只有变化，没有删除
				CallSceneObjectBind(Obj as SceneObject,PropertiesName,PropertiesValue);				
			}
			else if(Obj is View)
			{			
				//视图有两种，一种属性，一种是对象
				//CallView(Obj as View,PropertiesName,PropertiesValue,isAdd);
				if(PropertiesValue is ObjectData)
				{
					//视图
					CallView(Obj as View,PropertiesName,PropertiesValue,isAdd);
				}
				else
				{
					CallSceneObjectBind(Obj as ObjectData,PropertiesName,PropertiesValue);	
				}
			}
			else if(Obj is Record)
			{			
				//表格
				CallRecord(Obj as Record,PropertiesName,PropertiesValue,isAdd);
			}
			else if(Obj is RecordObject)
			{			
				//表格对象 只有变化没有删除
				CallRecordObject(Obj as RecordObject,PropertiesName,PropertiesValue);
			}
			else if(Obj is ViewObject)
			{			
				//视图对象
				//肯定是属性变化,属性只有变化，没有删除
				CallViewObjct(Obj as ViewObject,PropertiesName,PropertiesValue);
			}			
		}
		public function CallSceneBind(Obj:ObjectData,PropertiesName:String, PropertiesValue:*,isAdd:Boolean):void
		{
			//场景有四种子对象			
			if(PropertiesValue is SceneObject)
			{
				//场景对象
				_sceneobjGroup.DoCallBack(PropertiesName,PropertiesValue,isAdd);
			}
			else if(PropertiesValue is View)
			{
				//视图
				//视图增加不需要操作
			}
			else if(PropertiesValue is Record)
			{
				//表格
				//表格增加也不需要操作
			}
			else 
			{
				if(!_arrSceneProp.CheckProperties(PropertiesName))
				{
					return ;
				}				
				//场景属性，属性只有变化，没有删除
				_arrSceneProp.GetProperties(PropertiesName).DoCallBack(PropertiesName,PropertiesValue,true);
			}
		}
		public function CallSceneObjectBind(Obj:ObjectData,PropertiesName:String, PropertiesValue:*):void
		{
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//检查对象对应的属性回调表
			var	objKey:String		=	Obj.ObjKey;
			
			if (!_callbackTable.CheckProperties(objKey))
			{
				return ;
			}
			var	arrBindProp:BaseData	= _callbackTable.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//检查对应属性				
			if(!arrBindProp.CheckProperties(PropertiesName))
			{
				return;
			}
			var	callbackgroup:CallBackGroup	=	arrBindProp.GetProperties(PropertiesName);	
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			callbackgroup.DoCallBack(PropertiesName,PropertiesValue,true);
		}
		public function CallView(Obj:View,PropertiesName:String, PropertiesValue:*,isAdd:Boolean):void
		{
			//场景有四种子对象			
			if(PropertiesValue is ViewObject)
			{
				//视图对象
				if(null !=	_viewCallBackGroup[Obj.ObjKey])
				{
					(_viewCallBackGroup[Obj.ObjKey] as CallBackGroup).DoCallBack(PropertiesName,PropertiesValue,isAdd);
				}
			}
		}
		public function CallRecord(Obj:Record,PropertiesName:String, PropertiesValue:*,isAdd:Boolean):void
		{
			//场景有四种子对象			
			if(PropertiesValue is RecordObject)
			{
				//视图对象
				if(null !=	_recCallBackGroup[Obj.recName])
				{
					(_recCallBackGroup[Obj.recName] as CallBackGroup).DoCallBack(PropertiesName,PropertiesValue,isAdd);
				}
			}
			else 
			{
				//视图属性，属性只有变化，没有删除
				//暂不考虑
			}
		}
		/**
		 * 表格对象属性 
		 * @param Obj
		 * @param PropertiesName
		 * @param PropertiesValue
		 * 
		 */
		public function CallRecordObject(Obj:RecordObject,PropertiesName:String, PropertiesValue:*):void
		{
			//先检查是否有该视图的回调
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			var	recordKey:String		=	(Obj.parent as Record).ObjKey;
				
			if (!_callbackTable.CheckProperties(recordKey))
			{
				return;
			}
			var	arrBindObj:BaseData	= _callbackTable.GetProperties(recordKey);
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应视图对象的回调表
			if (!arrBindObj.CheckProperties(Obj.ObjKey))
			{
				return;
			}
			var	arrBindObjProp:BaseData	= arrBindObj.GetProperties(Obj.ObjKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindObjProp.CheckProperties(PropertiesName))
			{				
				return;
			}			
			var	callbackgroup:CallBackGroup	=	arrBindObjProp.GetProperties(PropertiesName);
			callbackgroup.DoCallBack(PropertiesName,PropertiesValue,true);
		}
		
		public function CallViewObjct(Obj:ViewObject,PropertiesName:String, PropertiesValue:*):void
		{
			//先检查是否有该视图的回调
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			//添加对象对应的属性回调表
			var	viewKey:String		=	(Obj.parent as View).ObjKey;
				
			if (!_callbackTable.CheckProperties(viewKey))
			{
				return;
			}
			var	arrBindObj:BaseData	= _callbackTable.GetProperties(viewKey);
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应视图对象的回调表
			if (!arrBindObj.CheckProperties(Obj.ObjKey))
			{
				return;
			}
			var	arrBindObjProp:BaseData	= arrBindObj.GetProperties(Obj.ObjKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindObjProp.CheckProperties(PropertiesName))
			{				
				return;
			}			
			var	callbackgroup:CallBackGroup	=	arrBindObjProp.GetProperties(PropertiesName);
			callbackgroup.DoCallBack(PropertiesName,PropertiesValue,true);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////
		//解除bind
		public function UnbindSceneProperty(PropertiesName:String,index:int):void
		{
			if(_arrSceneProp.CheckProperties(PropertiesName))
			{
				(_arrSceneProp.GetProperties(PropertiesName) as CallBackGroup).Remove(index);
			}
			index = -1;
		}
		
		public function UnbindSceneObj(index:int):int
		{
			_sceneobjGroup.Remove(index);
			return -1;
		}
		public function UnbindProp(Obj:ObjectData,PropertiesName:String,index:*):int
		{		
			if(index==null||-1 == index)
			{
				return -1;
			}
			if(Obj is SceneObject)
			{
				UnbindPropInSceneObj(Obj as SceneObject,PropertiesName,index);
			}
			else if(Obj is ViewObject)
			{
				UnbindPropInViewObj(Obj.parent as View,Obj.ObjKey,PropertiesName,index);
			}
			else if(Obj is Scene)
			{
				UnbindSceneProperty(PropertiesName,index);
			}		
			return -1;
		}
		
		private function UnbindPropInSceneObj(Obj:SceneObject,PropertiesName:String,index:int):int
		{
			//添加对象对应的属性回调表
			var	objKey:String		=	Obj.ObjKey;
			
			if (!_callbackTable.CheckProperties(objKey))
			{
				return -1;
			}
			var	arrBindProp:BaseData	= _callbackTable.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindProp.CheckProperties(PropertiesName))
			{
				return -1;
			}
			var	callbackgroup:CallBackGroup	=	arrBindProp.GetProperties(PropertiesName);	
			
			callbackgroup.Remove(index);
			return -1;
		}
		
		private function UnbindPropInViewObj(viewObj:View,objKey:String,PropertiesName:String,index:int):int
		{
			//添加对象对应的属性回调表
			var	viewKey:String		=	viewObj.ObjKey;
			
			if (!_callbackTable.CheckProperties(viewKey))
			{
				_callbackTable.HandleProperties(viewKey , new BaseData());
			}
			var	arrBindObj:BaseData	= _callbackTable.GetProperties(viewKey);
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应视图对象的回调表
			if (!arrBindObj.CheckProperties(objKey))
			{
				return -1;
			}
			var	arrBindObjProp:BaseData	= arrBindObj.GetProperties(objKey);
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//添加对应属性的回调					
			if(!arrBindObjProp.CheckProperties(PropertiesName))
			{				
				return -1;
			}			
			var	callbackgroup:CallBackGroup	=	arrBindObjProp.GetProperties(PropertiesName);	
			
			callbackgroup.Remove(index);
			return -1;
		}
		
		/**
		 * 解除视图绑定 
		 * @param viewid
		 * @param index
		 * @return 
		 * 
		 */
		public function UnbindView(viewid:int,index:int):int
		{
			var viewName	:String	=	"View"+viewid;
			if (null == _viewCallBackGroup[viewName])
			{
				return -1;
			}
			(_viewCallBackGroup[viewName] as CallBackGroup).Remove(index);
			return -1;
		}
		
		public function UnbindRecord(recName:String,index:int):int
		{
			if (null == _recCallBackGroup[recName])
			{
				return -1;
			}
			(_recCallBackGroup[recName] as CallBackGroup).Remove(index);
			return -1;
		}
		public function ShiftBind(srcKey:String,desKey:String):void
		{
			if (_callbackTable.CheckProperties(srcKey))
			{
				var	arrBindProp:BaseData	= _callbackTable.GetProperties(srcKey);
				_callbackTable.DeleteProperties(srcKey);
				_callbackTable.HandleProperties(desKey,arrBindProp);
			}
		}
		
	}
}