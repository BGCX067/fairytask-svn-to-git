package fairy.ui.containers
{
	import fairy.ui.UIConst;

	/**
	 * 横向ListBase 
	 * @author flashyiyi
	 * 
	 */
	public class GHListBase extends GListBase
	{
		public function GHListBase(skin:*=null, replace:Boolean=true, type:String=UIConst.HORIZONTAL, itemRender:*=null)
		{
			super(skin, replace, type, itemRender);
		}
	}
}