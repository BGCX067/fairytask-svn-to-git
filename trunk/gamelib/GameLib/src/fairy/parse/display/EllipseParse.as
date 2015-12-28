package fairy.parse.display
{
	import flash.display.Graphics;
	
	import fairy.parse.graphics.GraphicsEllipse;
	import fairy.parse.graphics.IGraphicsFill;
	import fairy.parse.graphics.IGraphicsLineStyle;

	/**
	 * 椭圆 
	 * @author flashyiyi
	 * 
	 */
	public class EllipseParse extends ShapeParse
	{
		public var ellipse:GraphicsEllipse;
		
		public function EllipseParse(ellipse:GraphicsEllipse, line:IGraphicsLineStyle=null, fill:IGraphicsFill=null,grid9:Grid9Parse=null,reset:Boolean = false)
		{
			super(null, line, fill, grid9, reset);
			
			this.ellipse = ellipse;
		}
		/** @inheritDoc*/
		protected override function parseBaseShape(target:Graphics) : void
		{
			super.parseBaseShape(target);
			
			if (ellipse)
				ellipse.parseGraphics(target);
		}
	}
}