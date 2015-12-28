package fairy.game.layer
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import fairy.community.sort.DepthSortUtil;
	import fairy.display.bitmap.IBitmapDataDrawer;
	import fairy.events.TickEvent;
	import fairy.game.layer.camera.ICamera;
	import fairy.game.layer.collision.ICollisionManager;
	import fairy.game.layer.position.IPositionManager;
	import fairy.game.layer.sort.ISortManager;
	import fairy.game.layer.sort.SortPriorityManager;
	import fairy.game.layer.sort.SortYManager;
	import fairy.game.util.GameTick;
	import fairy.util.Tick;
	import fairy.util.Util;
	
	public class GameLayer extends Sprite implements IBitmapDataDrawer
	{
		/**
		 * 是否是位图引擎
		 */
		public var isBitmapEngine:Boolean;
		/**
		 * 是否禁止自身增删对象，在使用BoxGridCamera时需要设置为true，以便将屏幕对象管理交给摄像机
		 */
		public var disableAddChild:Boolean;
		
		public var children:Array = [];
		public var childrenDict:Dictionary = new Dictionary(true);
		public var childrenInScreen:Array = [];
		public var childrenInScreenDict:Dictionary = new Dictionary(true);
		
		public var camera:ICamera;
		public var collision:ICollisionManager;
		public var position:IPositionManager;
		public var sort:ISortManager;
		public function GameLayer()
		{
			super();
			GameTick.instance.addEventListener(TickEvent.TICK,tickHandler);
		}
		
		public function destory():void
		{
			GameTick.instance.removeEventListener(TickEvent.TICK,tickHandler);
		}
		
		public function addObject(v:*):void
		{
			if (!isBitmapEngine && !disableAddChild && v is DisplayObject)
				this.addChild(DisplayObject(v));
			
			children.push(v);
			childrenDict[v] = true;
			if (!disableAddChild)
			{
				childrenInScreen.push(v);
				childrenInScreenDict[v] = true;
			}
			
			if (camera)
				camera.refreshItem(v);
		}
		
		public function removeObject(v:*):void
		{
			if (!isBitmapEngine && !disableAddChild && v is DisplayObject && (v as DisplayObject).parent == this)
				this.removeChild(DisplayObject(v));
			
			var index:int = children.indexOf(v);
			if (index != -1)
				children.splice(index, 1);
			delete childrenDict[v];
			
			if (!disableAddChild)
			{
				index = childrenInScreen.indexOf(v);
				if (index != -1)
					childrenInScreen.splice(index, 1);
				delete childrenInScreenDict[v];
			}
			if (camera)
				camera.removeItem(v);
		}
		
		public function setObjectPosition(obj:DisplayObject,p:Point):void
		{
			if (position)
				p = position.transform(p);
			
			obj.x = p.x;
			obj.y = p.y;
		}
		
		public function getObjectPosition(obj:DisplayObject):Point
		{
			var p:Point = new Point(obj.x,obj.y);
			if (position)
				p = position.untransform(p);
			
			return p;
		}
		
		public function drawToBitmapData(target:BitmapData,offest:Point):void
		{
			if (isBitmapEngine)
			{
				for each (var child:* in this.childrenInScreen)
				{
					if (child is IBitmapDataDrawer)
					{
						(child as IBitmapDataDrawer).drawToBitmapData(target,new Point(this.x + offest.x,this.y + offest.y));
					}
					else if (child is Bitmap)
					{
						if ((child as Bitmap).visible)
						{
							var bitmapData:BitmapData = (child as Bitmap).bitmapData;
							if (bitmapData)
								target.copyPixels(bitmapData,bitmapData.rect,new Point(child.x + this.x + offest.x,child.y  + this.y + offest.y),null,null,bitmapData.transparent);
						}
					}
					else if (child is DisplayObject)
					{
						var disObj:DisplayObject = child as DisplayObject;
						if (disObj.visible)
						{
							var m:Matrix = disObj.transform.matrix;
							var c:ColorTransform = disObj.transform.colorTransform;
							m.tx += this.x + offest.x;
							m.ty += this.y + offest.y;
							target.draw(disObj,m,c);
						}
					}
				}
			}
		}
		
		public function getBitmapUnderMouse(mouseX:Number,mouseY:Number):Array
		{
			var result:Array = [];
			if (isBitmapEngine)
			{
				for each (var child:* in this.childrenInScreen)
				{
					if (child is IBitmapDataDrawer)
					{
						var list:Array = (child as IBitmapDataDrawer).getBitmapUnderMouse(mouseX,mouseY);
						if (list)
							result.push.apply(null,list);
					}
				}
			}
			return result;
		}
		
		protected function tickHandler(event:TickEvent):void
		{
			if (camera)
				camera.render();
			
			if (sort)
				sort.sortAll();
			
			if (collision)
				collision.collideAll();
		}
		
		
	}
}