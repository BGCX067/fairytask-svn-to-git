package com.jzonl.engine.utils.draw
{
	import com.jzonl.engine.data.BaseData;
	
	import flash.geom.Matrix;
	
	public class DrawStyle
	{
		public function DrawStyle(){}
		
		/**
		 * 获取一个线条样式
		 * 
		 * @param thickness		：表示线条的粗细，有效值为 0 到 255
		 * @param color			：线条的十六进制颜色值（例如，红色为 0xFF0000，蓝色为 0x0000FF 等）。 如果未指明值，则默认值为 0x000000（黑色）
		 * @param alpha			：表示线条颜色的 Alpha 值的数字，有效值为 0 到 1。 如果未指明值，则默认值为 1
		 * @param pixelHinting	：用于指定是否提示笔触采用完整像素的布尔值。 它同时影响曲线锚点的位置以及线条笔触大小本身。 在 pixelHinting 设置为 true 的情况下，Flash Player 将提示线条宽度采用完整像素宽度。 在 pixelHinting 设置为 false 的情况下，对于曲线和直线可能会出现脱节。
		 * @param scaleMode		：用于指定要使用哪种缩放模式的 LineScaleMode 类的值： 
		 * 							LineScaleMode.NORMAL 	-- 在缩放对象时总是缩放线条的粗细（默认值）。 
		 * 							LineScaleMode.NONE 		-- 从不缩放线条粗细。 
		 * 							LineScaleMode.VERTICAL	-- 如果仅 垂直缩放对象，则不缩放线条粗细。
		 * @param caps			：用于指定线条末端处端点类型的 CapsStyle 类的值。 有效值为：CapsStyle.NONE、CapsStyle.ROUND 和 CapsStyle.SQUARE。 如果未指示值，则 Flash 使用圆头端点。 
		 * @param joints		：JointStyle 类的值，指定用于拐角的连接外观的类型。 有效值为：JointStyle.BEVEL、JointStyle.MITER 和 JointStyle.ROUND。 如果未指示值，则 Flash 使用圆角连接。
		 * @param miterLimit	：一个表示将在哪个限制位置切断尖角的数字。 有效值的范围是 1 到 255（超出该范围的值将舍入为 1 或 255）。
		 * 
		 */		
		public static function getLineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):BaseData
		{
			var tData:BaseData	=	new BaseData();
			tData.HandleProperties("thickness",thickness);
			tData.HandleProperties("color",color);
			tData.HandleProperties("alpha",alpha);
			tData.HandleProperties("pixelHinting",pixelHinting);
			tData.HandleProperties("scaleMode",scaleMode);
			tData.HandleProperties("caps",caps);
			tData.HandleProperties("joints",joints);
			tData.HandleProperties("miterLimit",miterLimit);
			return tData;
		}
		
		/**
		 * 指定一种渐变，用于绘制线条或形状填充
		 *  
		 * @param type					：用于指定要使用哪种渐变类型的 GradientType 类的值：GradientType.LINEAR 或 GradientType.RADIAL。
		 * @param colors				：要在渐变中使用的 RGB 十六进制颜色值数组
		 * @param alphas				：colors 数组中对应颜色的 alpha 值数组
		 * @param ratios				：颜色分布比率的数组；有效值为 0 到 255
		 * @param matrix				：一个由 flash.geom.Matrix 类定义的转换矩阵。 flash.geom.Matrix 类包括 createGradientBox() 方法，通过该方法可以方便地设置矩阵，以便与 lineGradientStyle() 方法一起使用。
		 * @param spreadMethod			：于指定要使用哪种 spread 方法的 SpreadMethod 类的值： 
		 *									SpreadMethod.PAD		：填充一次
		 * 									SpreadMethod.REFLECT	：镜像溢出填充（多次）
		 * 									SpreadMethod.REPEAT 	：线性溢出填充（多次）
		 * @param interpolationMethod	：用于指定要使用哪个值的 InterpolationMethod 类的值。 
		 * 									InterpolationMethod.LINEAR_RGB
		 * 									InterpolationMethod.RGB
		 * @param focalPointRatio		：一个控制渐变的焦点位置的数字。
		 * @return 
		 * 
		 */
		public static function getGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):BaseData
		{
			var tData:BaseData	=	new BaseData();
			tData.HandleProperties("type",type);
			tData.HandleProperties("colors",colors);
			tData.HandleProperties("alphas",alphas);
			tData.HandleProperties("ratios",ratios);
			tData.HandleProperties("matrix",matrix);
			tData.HandleProperties("spreadMethod",spreadMethod);
			tData.HandleProperties("interpolationMethod",interpolationMethod);
			tData.HandleProperties("focalPointRatio",focalPointRatio);
			return tData;
		}
		
		/**
		 * 指定一种简单的单一颜色填充
		 * 
		 * @param color	:填充的颜色
		 * @param alpha	:填充的 Alpha 值
		 * @return 
		 * 
		 */		
		public static function getFillStyle(color:uint, alpha:Number = 1.0):BaseData
		{
			var tData:BaseData	=	new BaseData();
			tData.HandleProperties("color",color);
			tData.HandleProperties("alpha",alpha);
			return tData;
		}
		
		/**
		 * 指定用于绘制矩形的样式
		 *  
		 * @param x					：矩形x坐标
		 * @param y					：矩形y坐标
		 * @param width				：矩形宽度
		 * @param height			：矩形高度
		 * @return 
		 * 
		 */		
		public static function getRectStyle(x:Number, y:Number, width:Number, height:Number):BaseData
		{
			var tData:BaseData	=	new BaseData();
			tData.HandleProperties("x",x);
			tData.HandleProperties("y",y);
			tData.HandleProperties("width",width);
			tData.HandleProperties("height",height);
			return tData;
		}
		
		/**
		 * 指定用于绘制圆角矩形的样式
		 *  
		 * @param x					：矩形x坐标
		 * @param y					：矩形y坐标
		 * @param width				：矩形宽度
		 * @param height			：矩形高度
		 * @param ellipseWidth		：圆角宽
		 * @param ellipseHeight		：圆角高
		 * @return 
		 * 
		 */
		public static function getRoundRectStyle(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number = 0, ellipseHeight:Number = NaN):BaseData
		{
			var tData:BaseData	=	new BaseData();
			tData.HandleProperties("x",x);
			tData.HandleProperties("y",y);
			tData.HandleProperties("width",width);
			tData.HandleProperties("height",height);
			tData.HandleProperties("ellipseWidth",ellipseWidth);
			tData.HandleProperties("ellipseHeight",ellipseHeight);
			return tData;
		}
	}
}