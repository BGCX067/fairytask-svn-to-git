package fairy.ui.controls
{
	import fairy.skin.VSilderSkin;
	import fairy.ui.UIConst;
	import fairy.util.core.ClassFactory;

	/**
	 * 纵向拖动块 
	 * @author flashyiyi
	 * 
	 */
	public class GVSilder extends GSilder
	{
		public static var defaultSkin:* = VSilderSkin
		
		public function GVSilder(skin:* =null, replace:Boolean=true, fields:Object=null)
		{
			if (!skin)
				skin = defaultSkin;
			
			super(skin, replace, fields);
			
			this.direction = UIConst.VERTICAL;
		}
	}
}