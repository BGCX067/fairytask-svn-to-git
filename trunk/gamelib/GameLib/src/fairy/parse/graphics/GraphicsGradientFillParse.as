package fairy.parse.graphics
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import fairy.parse.DisplayParse;

	public class GraphicsGradientFillParse extends DisplayParse implements IGraphicsFill
	{
		public var type:String;
		public var colors:Array;
		public var alpha:Array;
		public var ratios:Array;
		public var matrix:Matrix=null;
		public var spreadMethod:String="pad";
		public var interpolationMethod:String="rgb";
		public var focalPointRatio:Number=0;
		
		public function GraphicsGradientFillParse(type:String,colors:Array,alpha:Array,ratios:Array,matrix:Matrix=null,spreadMethod:String="pad",interpolationMethod:String="rgb",focalPointRatio:Number=0)
		{
			this.type = type;
			this.colors = colors;
			this.alpha = alpha;
			this.ratios = ratios;
			this.matrix = matrix;
			this.spreadMethod = spreadMethod;
			this.interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
		}
		/** @inheritDoc*/
		public override function parseGraphics(target:Graphics) : void
		{
			super.parseGraphics(target);
			target.beginGradientFill(type,colors,alpha,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
		}
	}
}