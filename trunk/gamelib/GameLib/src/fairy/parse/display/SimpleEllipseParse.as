package fairy.parse.display
{
	import fairy.parse.graphics.GraphicsEllipse;
	import fairy.parse.graphics.GraphicsFill;
	import fairy.parse.graphics.GraphicsLineStyle;
	
	/**
	 * 书写简单的Ellipse
	 * @author flashyiyi
	 * 
	 */
	public class SimpleEllipseParse extends EllipseParse
	{
		public function SimpleEllipseParse(width:Number,height:Number,color:Number = 0x0,fill:Number = 0xFFFFFF)
		{
			super(
				new GraphicsEllipse(0,0,width,height),
				isNaN(color) ? null : new GraphicsLineStyle(0,color),
				isNaN(fill) ? null : new GraphicsFill(fill)
			);
		}
	}
}