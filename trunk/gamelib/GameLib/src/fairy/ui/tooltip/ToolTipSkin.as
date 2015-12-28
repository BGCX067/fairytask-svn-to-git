package fairy.ui.tooltip
{
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	
	import fairy.skin.ArowSkin;
	import fairy.ui.ToolTipSprite;
	import fairy.ui.controls.GText;
	import fairy.ui.layout.Padding;
	import fairy.util.core.ClassFactory;
	import fairy.util.easing.TweenUtil;
	
	/**
	 * IToolTipSkin的默认实现
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class ToolTipSkin extends GText implements IToolTipSkin
	{
		public static var defaultSkin:ClassFactory = new ClassFactory(ArowSkin);
		
		public function ToolTipSkin(skin:*=null)
		{
			if (!skin)
				skin = defaultSkin;
				
			super(skin);
		
			this.enabledAutoLayout(new Padding(2,2,2,2));
		}
		
		/** @inheritDoc*/
		public function show(target:DisplayObject):void
		{
			var toolTipSprite:ToolTipSprite = this.parent as ToolTipSprite;
			toolTipSprite.x = toolTipSprite.parent.mouseX + 10;
			toolTipSprite.y = toolTipSprite.parent.mouseY + 10;
			toolTipSprite.blendMode = BlendMode.LAYER;
			
			TweenUtil.removeTween(toolTipSprite);
			TweenUtil.from(toolTipSprite,100,{alpha:0.0,y:"10"}).update();
		}
		
		/** @inheritDoc*/
		public function positionTo(target:DisplayObject):void
		{
			TweenUtil.removeTween(toolTipSprite);
			var toolTipSprite:ToolTipSprite = this.parent as ToolTipSprite;
			toolTipSprite.x = toolTipSprite.parent.mouseX + 10;
			toolTipSprite.y = toolTipSprite.parent.mouseY + 10;
		}
	}
}