package fairy.ui.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import fairy.display.GBase;
	import fairy.events.ItemClickEvent;
	import fairy.ui.controls.GButton;
	import fairy.ui.layout.LinearLayout;
	/**
	 * 按钮条
	 * 
	 * 标签规则：子对象的render将会被作为子对象的默认skin
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class GButtonBar extends GRepeater
	{
		public function GButtonBar(skin:*=null, replace:Boolean=true,ref:* = null,fields:Object = null)
		{
			if (!ref)
				ref = GButton;
			
			super(skin, replace,ref);
		}
	}
}