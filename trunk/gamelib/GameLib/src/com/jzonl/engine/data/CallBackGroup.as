package com.jzonl.engine.data
{
	/**
	 * 	回调组类 负责维护某一对象，属性，表格的回调表
	 */
	public class CallBackGroup
	{
		//回调表
		private	var		_callbackTable:Array		 = new Array();	
		
		//回收索引堆栈
		private	var		_indexStack:Array			= new Array();	
		
		public function CallBackGroup()
		{
		}
		/**
		 * 向回调组里增加一个回调 
		 * @param callback
		 * @return 回调索引
		 * 
		 */		
		public function Add(callback:CallBack):int
		{		
			var	index:int	=	0;
			
			if(_indexStack.length < 1)
			{
				//回收堆栈为空，取新索引
				index = _callbackTable.length;
			}
			else
			{
				//取堆栈中，回收回来的索引值
				index = _indexStack.pop();
			}
			_callbackTable[index] = callback;	
			
			return index;
		}
		/**
		 * 根据索引移除回调 
		 * @param index
		 * 
		 */		
		public function Remove(index:uint):void
		{
			//置对应索引位置为空
			_callbackTable[index]	 = 	null;
			//回收索引编号
			_indexStack.push(index);			
		}
		
		public function DoCallBack(PropertiesName:String,PropertiesValue:*,isAdd:Boolean):void
		{
			var	i:uint	=	0;
			for(i = 0; i < _callbackTable.length; i++ )
			{
				if(_callbackTable[i] != null)
				{
					var	callback:CallBack	=	_callbackTable[i] as CallBack;
					
					callback._args[0]	=	PropertiesName;
					callback._args[1]	=	PropertiesValue;
						
					callback.Call(isAdd);
				}
			}		
		}
		/**
		 * 根据索引获取函数 
		 * @param index
		 * @return  
		 * 
		 */		
		public	function	GetFunc(index:uint,isAdd:Boolean):Function
		{
			var		callback:CallBack	=	_callbackTable[index];
			return ( isAdd ? callback._addfunc:callback._removefunc);
		}
		
		public function 	getDataForEach(func:Function):void
		{
			var	i:uint	=	0;
			for(i = 0; i < _callbackTable.length; i++ )
			{
				if(_callbackTable[i] != null)
				{
					func(_callbackTable[i]._addfunc,_callbackTable[i]._removefunc);				
				}
			}						
		}
	}
}