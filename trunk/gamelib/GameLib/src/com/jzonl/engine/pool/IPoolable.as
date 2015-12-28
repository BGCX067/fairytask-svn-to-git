package com.jzonl.engine.pool
{
	/**
	 * 数据池接口 
	 * @author hanjy
	 */	
	public interface IPoolable
	{
		function get destroyed():Boolean;
		function renew():void;
		function destroy():void;
	}
}