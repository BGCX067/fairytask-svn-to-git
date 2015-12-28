package com.jzonl.engine.utils.draw
{
	import com.jzonl.engine.data.BaseData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DrawAPI
	{
		
		/** 绘制三角形背景 **/
		public static function DrawTriAngleBg(spriteGraphics:Graphics,
											  p1				:Point,
											  p2				:Point,
											  p3				:Point,
											  fillStyle			:BaseData = null,
											  lineStyle			:BaseData = null,
											  lineGradientStyle	:BaseData = null):void
		{			
			var type				:String;
			var colors				:Array;
			var alphas				:Array;
			var ratios				:Array;
			var matrix				:Matrix;
			var spreadMethod		:String;
			var interpolationMethod	:String;
			var focalPointRatio		:Number;
			
			var color				:uint;
			var alpha				:Number
			
			if(lineStyle != null)
			{
				var thickness		:Number 	= lineStyle.GetProperties("thickness");
				color							= lineStyle.GetProperties("color");
				alpha							= lineStyle.GetProperties("alpha");
				var pixelHinting	:Boolean 	= lineStyle.GetProperties("pixelHinting");
				var scaleMode		:String 	= lineStyle.GetProperties("scaleMode");
				var caps			:String 	= lineStyle.GetProperties("caps");
				var joints			:String 	= lineStyle.GetProperties("joints");
				var miterLimit		:Number 	= lineStyle.GetProperties("miterLimit");
				spriteGraphics.lineStyle(thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit);
				
				if(lineGradientStyle != null)
				{
					type				=	lineGradientStyle.GetProperties("type");
					colors				=	lineGradientStyle.GetProperties("colors");
					alphas				=	lineGradientStyle.GetProperties("alphas");
					ratios				=	lineGradientStyle.GetProperties("ratios");
					matrix				=	lineGradientStyle.GetProperties("matrix");
					spreadMethod		=	lineGradientStyle.GetProperties("spreadMethod");
					interpolationMethod	=	lineGradientStyle.GetProperties("interpolationMethod");
					focalPointRatio		=	lineGradientStyle.GetProperties("focalPointRatio");
					spriteGraphics.lineGradientStyle(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
				}
			}
			
			spriteGraphics.lineStyle(NaN);
			
			if(fillStyle.CheckProperties("type"))
			{
				//渐变填充
				type				=	fillStyle.GetProperties("type");
				colors				=	fillStyle.GetProperties("colors");
				alphas				=	fillStyle.GetProperties("alphas");
				ratios				=	fillStyle.GetProperties("ratios");
				matrix				=	fillStyle.GetProperties("matrix");
				spreadMethod		=	fillStyle.GetProperties("spreadMethod");
				interpolationMethod	=	fillStyle.GetProperties("interpolationMethod");
				focalPointRatio		=	fillStyle.GetProperties("focalPointRatio");
				
				spriteGraphics.beginGradientFill(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
			}
			else
			{
				color				=	fillStyle.GetProperties("color");
				alpha				=	fillStyle.GetProperties("alpha");
				spriteGraphics.beginFill(color,alpha);
			}
			
			spriteGraphics.moveTo		(p1.x,			p1.y);
			spriteGraphics.lineTo		(p2.x,			p2.y);
			spriteGraphics.lineTo		(p3.x,			p3.y);
			
			spriteGraphics.lineStyle(NaN);
			spriteGraphics.endFill();
		}
		
		public static function	clear(__Shape:Shape):void
        {
        	__Shape.graphics.clear();
        }
		
		/**
		 * 
		 * @param spriteGraphics
		 * @param rectStyle
		 * @param fillStyle
		 * @param lineStyle
		 * @param lineGradientStyle
		 * 
		 */		
		public static function drawRect(spriteGraphics:Graphics,rectStyle:BaseData,fillStyle:BaseData,lineStyle:BaseData = null, lineGradientStyle:BaseData = null):void
		{
			var x					:Number		=	rectStyle.GetProperties("x");
			var y					:Number		=	rectStyle.GetProperties("y");
			var width				:Number		=	rectStyle.GetProperties("width");
			var height				:Number		=	rectStyle.GetProperties("height");
									
			var type				:String;
			var colors				:Array;
			var alphas				:Array;
			var ratios				:Array;
			var matrix				:Matrix;
			var spreadMethod		:String;
			var interpolationMethod	:String;
			var focalPointRatio		:Number;
			
			var color				:uint;
			var alpha				:Number
			
			if(lineStyle != null)
			{
				var thickness		:Number 	= lineStyle.GetProperties("thickness");
				color							= lineStyle.GetProperties("color");
				alpha							= lineStyle.GetProperties("alpha");
				var pixelHinting	:Boolean 	= lineStyle.GetProperties("pixelHinting");
				var scaleMode		:String 	= lineStyle.GetProperties("scaleMode");
				var caps			:String 	= lineStyle.GetProperties("caps");
				var joints			:String 	= lineStyle.GetProperties("joints");
				var miterLimit		:Number 	= lineStyle.GetProperties("miterLimit");
				spriteGraphics.lineStyle(thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit);
			
				if(lineGradientStyle != null)
				{
					type				=	lineGradientStyle.GetProperties("type");
					colors				=	lineGradientStyle.GetProperties("colors");
					alphas				=	lineGradientStyle.GetProperties("alphas");
					ratios				=	lineGradientStyle.GetProperties("ratios");
					matrix				=	lineGradientStyle.GetProperties("matrix");
					spreadMethod		=	lineGradientStyle.GetProperties("spreadMethod");
					interpolationMethod	=	lineGradientStyle.GetProperties("interpolationMethod");
					focalPointRatio		=	lineGradientStyle.GetProperties("focalPointRatio");
					spriteGraphics.lineGradientStyle(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
				}
			}
			
			spriteGraphics.drawRect(x,y,width,height);
			
			spriteGraphics.lineStyle(NaN);
			
			if(fillStyle.CheckProperties("type"))
			{
				//渐变填充
				type				=	fillStyle.GetProperties("type");
				colors				=	fillStyle.GetProperties("colors");
				alphas				=	fillStyle.GetProperties("alphas");
				ratios				=	fillStyle.GetProperties("ratios");
				matrix				=	fillStyle.GetProperties("matrix");
				spreadMethod		=	fillStyle.GetProperties("spreadMethod");
				interpolationMethod	=	fillStyle.GetProperties("interpolationMethod");
				focalPointRatio		=	fillStyle.GetProperties("focalPointRatio");
												
				spriteGraphics.beginGradientFill(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
			}
			else
			{
				color				=	fillStyle.GetProperties("color");
				alpha				=	fillStyle.GetProperties("alpha");
				spriteGraphics.beginFill(color,alpha);
			}
			
			spriteGraphics.drawRect(x,y,width,height);
			
			spriteGraphics.lineStyle(NaN);
			
			spriteGraphics.endFill();
		}
		
		/**
		 * 
		 * @param spriteGraphics
		 * @param rectStyle
		 * @param bmd
		 * 
		 */		
		public static function drawRectWithBitMapFill(spriteGraphics:Graphics,rectStyle:BaseData,bmd:DisplayObject):void
		{
			var x					:Number		=	rectStyle.GetProperties("x");
			var y					:Number		=	rectStyle.GetProperties("y");
			var width				:Number		=	rectStyle.GetProperties("width");
			var height				:Number		=	rectStyle.GetProperties("height");
			
			var bitMapData:BitmapData	=	new BitmapData(bmd.width,bmd.height,true);
			bitMapData.draw(bmd);
			
			spriteGraphics.beginBitmapFill(bitMapData,null,true)
			spriteGraphics.drawRect(0,0,width,height)
			spriteGraphics.endFill();
		}
		
		public static function drawRoundRect(spriteGraphics:Graphics,rectStyle:BaseData,fillStyle:BaseData,lineStyle:BaseData = null, lineGradientStyle:BaseData = null):void
		{
			var x					:Number		=	rectStyle.GetProperties("x");
			var y					:Number		=	rectStyle.GetProperties("y");
			var width				:Number		=	rectStyle.GetProperties("width");
			var height				:Number		=	rectStyle.GetProperties("height");
			var ellipseWidth		:Number		=	rectStyle.GetProperties("ellipseWidth");
			var ellipseHeight		:Number		=	rectStyle.GetProperties("ellipseHeight");			
						
			var type				:String;
			var colors				:Array;
			var alphas				:Array;
			var ratios				:Array;
			var matrix				:Matrix;
			var spreadMethod		:String;
			var interpolationMethod	:String;
			var focalPointRatio		:Number;
			
			var color				:uint;
			var alpha				:Number
			
			if(lineStyle != null)
			{
				var thickness		:Number 	= lineStyle.GetProperties("thickness");
				color					 		= lineStyle.GetProperties("color");
				alpha							= lineStyle.GetProperties("alpha");
				var pixelHinting	:Boolean 	= lineStyle.GetProperties("pixelHinting");
				var scaleMode		:String 	= lineStyle.GetProperties("scaleMode");
				var caps			:String 	= lineStyle.GetProperties("caps");
				var joints			:String 	= lineStyle.GetProperties("joints");
				var miterLimit		:Number 	= lineStyle.GetProperties("miterLimit");
				spriteGraphics.lineStyle(thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit);
			
				if(lineGradientStyle != null)
				{
					type				=	lineGradientStyle.GetProperties("type");
					colors				=	lineGradientStyle.GetProperties("colors");
					alphas				=	lineGradientStyle.GetProperties("alphas");
					ratios				=	lineGradientStyle.GetProperties("ratios");
					matrix				=	lineGradientStyle.GetProperties("matrix");
					spreadMethod		=	lineGradientStyle.GetProperties("spreadMethod");
					interpolationMethod	=	lineGradientStyle.GetProperties("interpolationMethod");
					focalPointRatio		=	lineGradientStyle.GetProperties("focalPointRatio");
					spriteGraphics.lineGradientStyle(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
				}
			}
			
			spriteGraphics.drawRoundRect(x,y,width,height,ellipseWidth,ellipseHeight);
			
			spriteGraphics.lineStyle(NaN);
			
			if(fillStyle.CheckProperties("type"))
			{
				//渐变填充			
				type				=	fillStyle.GetProperties("type");
				colors				=	fillStyle.GetProperties("colors");
				alphas				=	fillStyle.GetProperties("alphas");
				ratios				=	fillStyle.GetProperties("ratios");
				matrix				=	fillStyle.GetProperties("matrix");
				spreadMethod		=	fillStyle.GetProperties("spreadMethod");
				interpolationMethod	=	fillStyle.GetProperties("interpolationMethod");
				focalPointRatio		=	fillStyle.GetProperties("focalPointRatio");
						
				spriteGraphics.beginGradientFill(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
			}
			else
			{
				color				=	fillStyle.GetProperties("color");
				alpha				=	fillStyle.GetProperties("alpha");
				spriteGraphics.beginFill(color,alpha);
			}
			
			spriteGraphics.drawRoundRect(x,y,width,height,ellipseWidth,ellipseHeight);
			
			spriteGraphics.endFill();
		}
		
//		public static function setStrokes(txt:TextField,color:uint,size:uint):void
//		{
//			var glow:GlowFilter		= 	new GlowFilter();
//			glow.color 				= 	color;
////			glow.alpha 				= 	1;
//			glow.blurX 				=	2;
//			glow.blurY				= 	2;
//			glow.strength			=	10;
//			glow.quality			= 	BitmapFilterQuality.HIGH;
//			glow.
//			if(txt.filters!=null && txt.filters.length>0)
//			{
//				txt.filters.push(glow)
//			}
//			else
//			{
//				txt.filters				=	[glow];
//			}
//		}
		
		public static function getLabelBitmap(labelField:TextField):Bitmap
		{
			if(labelField == null)
			{
				return null;
			}
			var tempBitMapData:BitmapData	=	new BitmapData(labelField.width+2,labelField.textHeight+2,!labelField.background,labelField.backgroundColor);
			tempBitMapData.draw(labelField);			
			return new Bitmap(tempBitMapData);
		}
		
		public static function getStringBitmap(str:String,setObj:Object = null,tf:TextFormat=null):Bitmap
		{
			if(str == null)
			{
				return null;
			}
			
			var txt:TextField	=	new TextField();
			
			if(null!=tf)
			{
				txt.defaultTextFormat	=	tf;
			}
			
			if(setObj != null)
			{
				for(var p:String in setObj)
				{
					txt[p]	=	setObj[p];
				}
			}
			txt.htmlText	=	str;
			
			return getLabelBitmap(txt);
		}
		
		public static function	getTrueRect(val:DisplayObjectContainer = null):Rectangle
		{
			var rect		:Rectangle	=	new Rectangle(0, 0, 0, 0);
			var child		:DisplayObject;
			var tSize		:uint		=	val.numChildren;
			for(var i:int = 0; i < tSize; i ++)
			{
				child					=	val.getChildAt(i);
				rect					=	rect.union(child.getBounds(val));
			}
			return rect;
		}

		public function DrawAPI()
		{
			
		}
	}
}