package fairy.skin
{
	import flash.display.Sprite;
	
	import fairy.parse.DisplayParse;
	import fairy.parse.display.Grid9Parse;
	import fairy.parse.graphics.GraphicsFill;
	import fairy.parse.graphics.GraphicsLineStyle;
	import fairy.parse.graphics.GraphicsRect;
	
	/**
	 * 方框
	 * @author flashyiyi
	 * 
	 */
	public class BoxSkin extends Sprite
	{
		public function BoxSkin(width:Number=100,height:Number=100,radius:Number = 0,borderColor:uint = 0,borderThickness:Number=1,fillColor:uint = 0xFFFFFF)
		{
			DisplayParse.create([new GraphicsLineStyle(borderThickness,borderColor),
								new GraphicsFill(fillColor),
								new GraphicsRect(0,0,width,height,radius,radius,radius,radius),
								new Grid9Parse(radius,radius,width-radius*2,height-radius*2)]).parse(this);
		}
	}
}