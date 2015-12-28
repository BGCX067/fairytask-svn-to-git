package com.jzonl.engine.data
{
	import com.jzonl.engine.utils.IO;

	public class Record extends ObjectData
	{
		/**
		 * 表格名
		 */		
		public	var recName		:String	= "";
		public var colLength	:int;
		/**
		 *表格列类型 
		 */		
		private	var _nMaxRow:int		= -1;	
		
		//表格对象以表格名存在model上
		public function Record(pName:String)
		{
			recName = pName;
			super(null,pName);
		}

		/**
		 *表格最大行行号 
		 */
		public function get nMaxRow():int
		{
			return _nMaxRow;
		}

		/**
		 * 添加记录表一行
		 * @pList msg 数据
		 */
		public function AddRow(pList:Array):void
		{
			var rowValue:Array = new Array();
			//表中没空行
			//插入是若nRow无数据，插在nRow上，否则从nRow后面开始插
			var		i:uint	=	0 ;		
		
			//给表格添加一行
			//参数 string	strName;	// 表名
			//参数 int		nRow;		// 插入的行号
			//参数 int		nRows;		// 行数
			//参数 CVar		数据
			var nRow	:int	=	pList.shift();
			var nRows	:int	=	pList.shift();
			for(i = 0 ; i < nRows; i++)
			{
				var	row:uint		= i + nRow;	
				var recObject	:RecordObject	=	new RecordObject(this,String(row));
				var cols:uint = 0;
				for(cols = 0; cols < colLength; cols++)
				{
					recObject.HandleProperties(String(cols),pList.shift());
				}			
				
				this.HandlePropertiesEx(String(row),recObject);				
			}
			
		}
		
		/**
		 * 删除哪个就哪个，后面行号不变 
		 * @param nRow
		 * 
		 */
		public function DelRow(nRow:uint):void
		{
			DeletePropertiesEx(String(nRow));
		}
		public function QueryRecord(row:uint,col:uint):*
		{
			if(CheckProperties(String(row)))
			{				
				var rowValue:Array =	this.GetProperties(String(row));
				return rowValue[col];
			}
			return null;
		}
		/**
		 * 修改表格数据
		 * @param pList
		 */
		public function RecordGrid(pList:Array):void
		{
			//参数 int		nCount		// 数据数量
			//参数 int		nRow
			//参数 int		nCol		
			//参数 数据		
			var	nCount	:uint	=	pList.shift();
			var	nRow	:int;
			var	nCol	:int;
			var rowObj	:RecordObject
			for(var i:int = 0 ; i < nCount; i++)
			{
				nRow	=	pList.shift();
				nCol	=	pList.shift();
				if(!this.CheckProperties(String(nRow)))
				{
					//trace("这一行没有:"+nRow);
					continue;
				}
				else
				{
					rowObj	=	this.GetProperties(String(nRow));
					rowObj.HandlePropertiesEx(String(nCol),pList.shift());
					IO.traceLog("  grid row:" + nRow + " nCol:"+ nCol + " value:" + rowObj.GetProperties(String(nCol)));
				}
			}
			if(null!=rowObj)
			{
				//this.HandlePropertiesEx(String(nRow),rowObj);
			}
					
		}
		public function RecordClear():void
		{	
			var j:int = 0;
			for(j = _nMaxRow; j >= 0; j--)
			{
				if(CheckProperties(String(j)))
				{						
					this.DeletePropertiesEx(String(j));
				}
			}
		}
		/**
		 * 获得表格内容 
		 * @param val
		 * @return 范围表格内容的二维数组
		 * 
		 */		
		public	function GetArray():Array
		{
			var		content:Array = new Array(_nMaxRow + 1);
			var		i:Number = 0;	
			for(i = 0; i < _nMaxRow + 1; i++)
			{
				if(CheckProperties(String(i)))
				{
					content[i] = GetProperties(String(i));
				}
			}
			return content;
		}	
		public function Clear():void
		{
			//清掉表格内容
			this.clearProperties();
			_nMaxRow	=	-1;
			//IO.traceLog(_recName," Clear");
			//GC.gc();
		}
	}
}