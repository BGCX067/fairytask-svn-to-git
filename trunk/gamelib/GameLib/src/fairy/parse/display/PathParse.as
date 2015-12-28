package fairy.parse.display
{
	import flash.display.Graphics;
	
	import fairy.parse.graphics.GraphicsPath;
	import fairy.parse.graphics.IGraphicsFill;
	import fairy.parse.graphics.IGraphicsLineStyle;
	
	/**
	 * 线条
	 * @author flashyiyi
	 * 
	 */
	public class PathParse extends ShapeParse
	{
		/**
		 * 点的数组 
		 */
		public var points:Array;
		
		public function PathParse(points:Array, line:IGraphicsLineStyle=null, fill:IGraphicsFill=null,grid9:Grid9Parse=null, reset:Boolean=false)
		{
			super(null, line, fill, grid9,reset);
			
			this.points = points;
		}
		/** @inheritDoc*/
		protected override function parseBaseShape(target:Graphics) : void
		{
			super.parseBaseShape(target);
			
			if (points)
				new GraphicsPath(points).parseGraphics(target);
		}
	}
}