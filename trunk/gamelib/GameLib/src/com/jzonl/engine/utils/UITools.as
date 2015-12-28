package com.jzonl.engine.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 显示对象处理工具 
	 * @author hanjy
	 * 
	 */	
	public class UITools
	{
		public function UITools()
		{
		}
		
		/**
		 * 清理容器子对象 
		 * @param pContainer
		 * 
		 */
		public static function clearChild(pContainer:Sprite):void
		{
			while(pContainer.numChildren>0)
			{
				pContainer.removeChildAt(0);
			}
		}
	}
}