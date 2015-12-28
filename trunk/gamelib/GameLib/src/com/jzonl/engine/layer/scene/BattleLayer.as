package com.jzonl.engine.layer.scene
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 战斗层 
	 * @author hanjy
	 * 
	 */	
	public class BattleLayer extends Sprite implements ILayer
	{
		public function BattleLayer()
		{
			//TODO: implement function
			super();
		}
		
		public function show(pParent:Sprite=null):void
		{
			this.visible=true;
			/*var bmp:BitmapData	=	new BitmapData(this.width,this.height,false);
			bmp.draw(this);*/
		}
		
		public function aniShow(pType:int,pParent:Sprite=null):void
		{
			//TODO: implement function
		}
		public function hide():void
		{
			this.visible	=	false;
		}
		public function aniHide(pType:int):void
		{
			
		}
	}
}