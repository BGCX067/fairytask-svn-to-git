package com.jzonl.engine.utils
{
	import flash.net.LocalConnection;
	import flash.utils.Timer;
	
	public class GC
	{
		private static var hasCreated			:Boolean		=	false;
		
		public function GC()
		{
			throw new Error(" GC 禁止实例化");
		}
						
		/** 提供给外部的手动GC方法，忽略所有的参数
		 * @param rest
		 */	
		public static function gc(...rest):void
		{
			try
			{
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			}
			catch(err:Error)
			{
			}
		}
	}
}