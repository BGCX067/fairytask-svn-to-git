package fairy.ui.html
{
	import fairy.ui.UIConst;
	import fairy.ui.layout.LinearLayout;
	
	
	/**
	 * 表格
	 * @author flashyiyi
	 * 
	 */
	public class TableTag extends GFrameView
	{
		public function TableTag()
		{
			super();
			
			var layout:LinearLayout = new LinearLayout();
			layout.type = UIConst.VERTICAL;
			setLayout(layout);
		}
	}
}