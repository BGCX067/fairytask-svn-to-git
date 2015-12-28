package fairy.ui.controls
{
	import fairy.skin.HScrollBarSkin;
	import fairy.ui.UIConst;
	import fairy.util.core.ClassFactory;
	
	/**
	 * 横向滚动条
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class GHScrollBar extends GScrollBar
	{
		public static var defaultSkin:* = HScrollBarSkin;
		
		public function GHScrollBar(skin:*=null, replace:Boolean=true)
		{
			if (!skin)
				skin = defaultSkin;
			
			super(skin, replace);
		
			this.direction = UIConst.HORIZONTAL;
		}
	}
}