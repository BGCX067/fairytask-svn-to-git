package com.jzonl.engine.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapAPI
	{
		/** 获取图形的非透明鼠标响应区域
		 * 
		 * @param target					原始的需要重新设置点击区域的对象
		 * @param container					承载响应区域的容器
		 * 
		 * 使用本方法要遵循以下几点
		 * 1.target必须将 container 以外所有的显示对象的 mouseChild 和 mouseEnabled 这2个属性设置为 false
		 * 2.container内不能添加任何的显示对象
		 * 3.必须将 target 的 hitArea 设置为 container
		 * 
		 */		
		public static function setHitArea(target:DisplayObjectContainer, container:Sprite):void
		{
			container.x		=	container.y				=	0;
			container.graphics.clear();
			
			var bmd				:BitmapData	=	BitmapAPI.getBitmapData(target);
			var pos				:Rectangle	=	target.getBounds(target);
			container.graphics.beginFill(0xff0000, 1);
			var col				:uint;
			for(var i:int = 0; i < bmd.width; i ++)
			{
				for(var j:int = 0; j < bmd.height; j ++)
				{
					col						=	bmd.getPixel32(i, j);
					if(col)
					{
						container.graphics.drawEllipse(i, j, 1, 1);
					}
				}
			}
			container.x						=	pos.x;
			container.y						=	pos.y;
		}
		
		/** 获取指定对象的BitmapData (主要针对 Sprite / MovieClip )**/
		public static function getBitmapData(ob:DisplayObject):BitmapData
		{
			if(!ob)
			{
				throw new Error("  **  **  不能对空对象进行操作!");
			}
			
			var rect				:Rectangle			=	ob.getBounds(ob);
			var matrix				:Matrix				=	new Matrix; 
			matrix.tx									-=	rect.topLeft.x;
			matrix.ty									-=	rect.topLeft.y;
			
			var myBitmapData		:BitmapData 		= 	new BitmapData(ob.width,ob.height,true,0);
				myBitmapData.draw(ob,matrix,null,null,new Rectangle(0, 0, ob.width, ob.height));
			return myBitmapData;
		}
		
		/** 获取指定对象的位图 (主要针对 Sprite / MovieClip )**/
		public static function getBitmap(ob:DisplayObject):Bitmap
		{
			return new Bitmap(BitmapAPI.getBitmapData(ob));
		}
		
		/** 返回鼠标点击到图片上的点的色值 **/
		public static function getClickColor(ob:DisplayObject, point:Point):uint
		{
			var bmd					:BitmapData			=	BitmapAPI.getBitmapData(ob);

			var rect				:Rectangle			=	ob.getBounds(ob);
			point.x										-=	rect.x;
			point.y										-=	rect.y;
			
			var result				:uint				=	bmd.getPixel32(point.x,point.y);
			bmd.dispose();
			return result;
		}
		
		/**	9切片拉伸位图（舞台上的或者是加载进来的位图）
		 * 
		 * @param _source				要拉伸的位图原图
		 * @param targetWidth			目标宽度
		 * @param targetHeight			目标高度
		 * @param scale9GridRectangle	9切片范围
		 * @return 						返回拉伸后的新的位图
		 * 
		 */		
		public static function scaleBitmap(	_source:Bitmap,targetWidth:Number,targetHeight:Number,
											scale9GridRectangle:Rectangle):Bitmap
		{
			/** 9切片区域配置 **/		
			var rx			:int			=	scale9GridRectangle.x;
			var ry			:int			=	scale9GridRectangle.y;
			var rw			:int			=	scale9GridRectangle.width;
			var rh			:int			=	scale9GridRectangle.height;
			
			/** 原图的宽高 **/
			var sw			:int			=	_source.width;
			var sh			:int			=	_source.height;
			
			/** 中间的宽高 **/
			var mw			:int			=	targetWidth - (sw - rw);
			if(mw < 0)
			{
				mw							=	0;
			}
			var mh			:int			=	targetHeight - (sh - rh);
			/** 下面的纵坐标 **/
			var dy			:int			=	ry + mh;
			/** 右边的坐标 **/
			var rightX		:int			=	targetWidth - (sw - rx - rw);
			
			if((rx + rw) > sw || (ry + rh) > sh || rx < 0 || ry < 0)
			{
				throw new Error("要得到的切片区域超出原图的范围，请重新设定");
			}
			
			var sp			:Sprite			=	new Sprite;

			/****  上面的3块  ****/
			var bit1		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(0,0,rx,ry));
			sp.addChild(bit1);

			var bit2		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(rx,0,rw,ry));
			bit2.x							=	rx;

			bit2.width						=	mw;
			sp.addChild(bit2);

			var bit3		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(rx + rw,0,sw - rw - rx,ry));
			bit3.x							=	rightX;
			sp.addChild(bit3);

			/****  中间的3块  ****/
			var bit4		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(0,ry,rx,rh));
			bit4.y							=	ry;
			bit4.height						=	mh;
			sp.addChild(bit4);

			var bit5		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(rx,ry,rw,rh));
			bit5.x							=	rx;
			bit5.y							=	ry;
			bit5.width						=	mw;
			bit5.height						=	mh;
			sp.addChild(bit5);

			var bit6		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(rx + rw,ry,sw - rw - rx,rh));
			bit6.x							=	rightX;
			bit6.y							=	ry;
			bit6.height						=	mh;
			sp.addChild(bit6);

			/****  下面的3块  ****/
			var bit7		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(0,ry + rh,rx,sh - ry - rh));
			bit7.y							=	dy;
			sp.addChild(bit7);

			var bit8		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(rx,ry + rh,rw,sh - ry - rh));
			bit8.x							=	rx;
			bit8.y							=	dy;
			bit8.width						=	mw;
			sp.addChild(bit8);

			var bit9		:Bitmap			=	BitmapAPI.getSliceBitmap(_source,new Rectangle(rx + rw,ry + rh,sw - rw - rx,sh - ry - rh));
			bit9.x							=	rightX;
			bit9.y							=	dy;
			sp.addChild(bit9);

			var newBitmapData	:BitmapData	=	new BitmapData(sp.width,sp.height,true,0);
			newBitmapData.draw(sp);
			var newBitmap		:Bitmap		=	new Bitmap(newBitmapData.clone());
			newBitmapData.dispose();
			newBitmapData					=	null;

			bit1							=	null;
			bit2							=	null;
			bit3							=	null;
			bit4							=	null;
			bit5							=	null;
			bit6							=	null;
			bit7							=	null;
			bit8							=	null;
			bit9							=	null;
			
			return newBitmap;
		}
		
		/** 针对位图部分截图，可以扩展成屏幕截图，方法是先将屏幕上的显示对象转换成位图，然后再调用该方法
		 * 
		 * @param _source		要截图的原图
		 * @param rect			截取区域的范围
		 * @return 				返回截图
		 * 
		 */		
		public static function getSliceBitmap(_source:Bitmap,rect:Rectangle):Bitmap
		{
			if((rect.x + rect.width) > _source.width || (rect.y + rect.height) > _source.height 
				|| rect.x < 0 || rect.y < 0)
			{
				throw new Error("要得到的切片区域超出原图的范围，请重新设定");
			}
			
			var bmp			:Bitmap			=	new Bitmap(_source.bitmapData.clone());
			var sp			:Sprite			=	new Sprite;
			bmp.x							=	-rect.x;
			bmp.y							=	-rect.y;
			sp.addChild(bmp);
			
			var tmp			:BitmapData		=	new BitmapData(rect.width,rect.height,true,0);
			tmp.draw(sp);
			var newBitmap	:Bitmap			=	new Bitmap(tmp.clone());
			tmp.dispose();
			bmp								=	null;
			sp								=	null;
			return newBitmap;
		}
	}
}