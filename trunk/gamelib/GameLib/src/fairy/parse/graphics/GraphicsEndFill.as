package fairy.parse.graphics
{
	import flash.display.Graphics;
	
	import fairy.parse.DisplayParse;
	
	public class GraphicsEndFill extends DisplayParse
	{
		/** @inheritDoc*/
		public override function parseGraphics(target:Graphics) : void
		{
			super.parseGraphics(target);
			target.endFill();
		}
	}
}