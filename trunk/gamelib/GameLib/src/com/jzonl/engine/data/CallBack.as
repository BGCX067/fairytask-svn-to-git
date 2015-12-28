package com.jzonl.engine.data
{
	import flash.events.Event;

	public class CallBack
	{
		public	var		_addfunc:Function;
		public	var		_removefunc:Function;		
		public	var		_args:Array;
		/**
		 *对象类型 
		 */		
		public	var		_type:*;
		private var 	_flagArr	:Array	=	[];
		
		public function CallBack(addfunc:Function,
								 removefunc:Function,args:Array,								
								 type:* =	-1)
		{
			_addfunc	=	addfunc;
			_removefunc =	removefunc;
			_args		=	args;			
			_type	=	type;
		}
		
		public function Call(isAdd:Boolean):*
		{
			//特殊处理，当参数1为场景对象时，判断下类型			
			if(_args[1] is SceneObject)
			{
				var obj:SceneObject	= _args[1] ;
				
				if(_type is Array)
				{
					var		arr:Array			=	_type;
					var		same:Boolean		=	false;
					for(var	 p:int = 0; p < arr.length; p++)
					{
						if(arr[p]	==	obj.Type)
						{
							same	=	true;
							break;
						}
					}
					if(!same)
					{
						return;	
					}
				}
				else
				{
					if(_type != -1 && _type != obj.Type)
					{
						return ;
					}
				}
			}
			var		func:Function	=	(isAdd?_addfunc:_removefunc);
			
			if(null == func)
				return null;
			if(_args.length > 2)
			{
				return func.call(this,_args[0],_args[1],_args[2]);			
			}
			else
			{
				return func.call(this,_args[0],_args[1]);		
			}
		}
	}
}
