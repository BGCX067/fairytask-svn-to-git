package com.jzonl.engine.data
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class Scene extends ObjectData
	{
		/**玩家ID*/
		public	var roleID			:Point;

		public var sceneObjType	:Array	=	[];
		/**
		 *属性表数组 
		 */		
		private var _proTable:BaseData	= new	BaseData();
		private var _propCount:uint		=	0;
		//公开属性
		public var id				:Point;
		public var ConfigID		:int;
		public var Type			:int;
		public var Model			:int;
		public var NameID			:int;
		public var FightScene		:int;
		public var FlyType			:int;
		public var SceneType		:int;
		public var InitX			:int;
		public var InitY			:int;
		public var FieldScene		:int;
		/**
		 *表格表数据 
		 */		
		private var _recTable:BaseData	= new	BaseData();
	
		public function Scene()
		{
			super(null,"0",null);			
		}
		
		public	function AddObj(pList:Array):void
		{
			if(sceneObjType.length==0)
			{
				//throw new Error("没有属性定义，不要乱加人。");
				return ;
			}
			//玩家一定不是在这里的
			var tobj:SceneObject;
			var objID:Point	=	pList[0];
			//是否触发
			var isTrigger	:Boolean	=	true;
			if(CheckProperties(String(objID)))
			{
				isTrigger	=	false;
				tobj = GetProperties(String(objID));
			}
			else
			{
				tobj = new SceneObject(objID);
			}
			var idx:int	=	0;
			var key:int;
			for(var i:int=0;i<(pList.length-1)/2;i++)
			{
				idx	=	2*i+1;
				key	=	pList[idx];
				tobj.HandlePropertiesEx(sceneObjType[key],pList[idx+1]);
			}
			if(isTrigger)
			{
				HandlePropertiesEx(String(objID),tobj);
			}
		}
		/**
		 * 根据对象唯一ID获取对象实例
		 * @return 返回对象实例
		 * 
		 */				
		public	 function GetObject(objID:Point):SceneObject
		{
			if(!CheckProperties(String(objID)))
			{
				return null;
			}
			return	 GetProperties(String(objID)) as SceneObject;
		}
		
		/**
		 * 根据序号取名字 
		 * @param idx
		 * @return 
		 * 
		 */
		public function getObjKey(idx:int):String
		{
			if(sceneObjType.length>0)
			{
				return sceneObjType[idx];
			}
			else
			{
				throw new Error("没初始化表");
			}
			return idx;
		}
		
		public	function CreateRecordTable(pList:Array):void
		{
			//添加表格格式
			//参数 int		nCount;		// 表格数量
			//参数 string	strName;	// 表格名称，以0结束的字符串，前面不包含长度
			//参数 int		nCols;		// 列数，最大256
			//参数 int		nColType[];	// 列类型 要干掉的
			//...  其他列的类型
			// ... 其他表的信息
			
			var count:int	=	pList.shift();
			
			for (var i:int = 0; i < count; i++)
			{
				var	recName:String	= pList.shift();
				var	nCols:uint		= pList.shift();
				
				_recTable.HandleProperties(String(i),recName);			
				
				//以表名为索引存放表格对象
				var	record:Record	= new Record(recName);
				record.colLength	=	nCols;	
				HandlePropertiesEx(recName,record);
				
				//IO.traceLog("记录表初始化:",recName,nCols);
			}
		}	
		
		/**
		 * 添加任务 未实现 
		 * @param recordName
		 * @param pList
		 * 
		 */
		public function addRecord(recordName:String,pList:Array):void
		{
			if(CheckProperties(recordName))
			{
				var	record:Record	= GetProperties(recordName);
			}
		}
		
		public	function GetPropertyName(index:uint):String
		{
			return _proTable.GetProperties(String(index));
		}
		public	function GetPropertyType(index:uint):String
		{
			return _proTable.GetProperties(String(index + _propCount));
		}
		public	function GetRecordName(index:uint):String
		{
			return _recTable.GetProperties(String(index));
		}
	
		/**
		 *	不通过回调直接取属性 
		 * @param val 属性名
		 * @return 属性值
		 * 
		 */		
		public	function GePropertyEx(val:String):*
		{
			return		GetProperties(val);
		}
		/**
		 *	不通过回调直接取表格
		 * @param val 表格名
		 * @return 表格对象
		 * 
		 */		
		public	function GetRecordEx(val:String):Record
		{
			return		GetProperties(val) as Record;
		}
		
		/**
		 * 根据视图名称检查视图是否存在 
		 * @param viewid
		 * @return 
		 * 
		 */
		public function CheckView(viewid:int):Boolean
		{
			//视图名临时这么写
			var	viewName:String	= "View" + String(viewid);
			return CheckProperties(viewName);
		}
		
		public	function GetView(viewid:int):View
		{
			//视图名临时这么写
			var	viewName:String	= "View" + String(viewid);
			var	view:View;
			
			if(CheckProperties(viewName))
			{
				view	=	GetProperties(viewName);	
			}	
			else
			{
				view	=	new View(viewid);
				HandlePropertiesEx(viewName,view);	
			}
			return	view;
		}	
		//////////////////////////////////////////////////////////////////////////////
		public function Clear():void
		{			
			//super.clearProperties();
			//teamData.clearProperties();
			//清除掉场景对象,视图,表格，其他不能清
			getDataForEach(function (propName:String,val:*):void
			{
				if (val is SceneObject&&!val.CheckProperties("PLAYER_FLAG"))
				{
					/*if(val.CheckProperties("client_res_link"))
					{
						val.GetProperties("client_res_link").clear();
					}*/
					DeletePropertiesEx(propName);				
				}	
				else if(val is View)
				{
					//不清视图
					//(val as View).Clear()
				}
				else if(val is Record)
				{
					//不清表格
					//(val as Record).Clear()
				}	
				else
				{
					//DeleteProperties(propName);
				}
				
			});
		}
		
		public	function get Role():SceneObject
		{			
			return GetObject(roleID);
		}
	}
}