package fairy.ui.containers
{
	import fairy.ui.UIConst;
	import fairy.ui.layout.AbsoluteLayout;
	import fairy.ui.layout.LinearLayout;

	/**
	 * 纵向Box
	 * @author flashyiyi
	 * 
	 */
	public class GVBox extends GBox
	{
		public function GVBox(skin:*=null, replace:Boolean=true)
		{
			super(skin, replace);
			type = UIConst.VERTICAL;
		}
	}
}