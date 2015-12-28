package fairy.ui.containers
{
	import fairy.ui.UIConst;

	/**
	 * 横向Box
	 * @author flashyiyi
	 * 
	 */
	public class GHBox extends GBox
	{
		public function GHBox(skin:*=null, replace:Boolean=true)
		{
			super(skin, replace);
			type = UIConst.HORIZONTAL;
		}
	}
}