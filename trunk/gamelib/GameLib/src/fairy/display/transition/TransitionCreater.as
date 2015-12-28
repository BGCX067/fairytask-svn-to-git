package fairy.display.transition
{
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import fairy.display.GBase;
	import fairy.display.game.BackgroundLayer;
	import fairy.display.movieclip.GScriptMovieClip;
	import fairy.display.transfer.GBitmapEffect;
	import fairy.display.transfer.effect.DissolveHandler;
	import fairy.display.transfer.effect.MosaicHandler;
	import fairy.display.transfer.effect.SegmentHandler;
	import fairy.display.transfer.effect.ThresholdHandler;
	import fairy.display.transition.maskmovie.DissolveMaskHandler;
	import fairy.display.transition.maskmovie.GradientAlphaMaskHandler;
	import fairy.display.transition.maskmovie.ShutterDirectMaskHandler;
	import fairy.display.transition.maskmovie.ShutterMaskHandler;
	import fairy.ui.controls.GImage;
	import fairy.util.RandomUtil;
	import fairy.util.easing.Circ;
	
	/**
	 * 创建几个模板Transition对象，执行createTo方法便可应用到舞台上
	 * 
	 * @author flashyiyi
	 * 
	 */
	public final class TransitionCreater
	{
		/**差异值渐变 */
		public static function threshold(switchHandler:*,target:DisplayObject):TransitionTransferLayer
		{
			return new TransitionTransferLayer(switchHandler,new GBitmapEffect(target,new ThresholdHandler()));
		}
		/**溶解渐变 */
		public static function dissolve(switchHandler:*,target:DisplayObject):TransitionTransferLayer
		{
			return new TransitionTransferLayer(switchHandler,new GBitmapEffect(target,new DissolveHandler(getTimer())));
		}
		/**切割渐变 */
		public static function segment(switchHandler:*,target:DisplayObject,type:int = 0):TransitionTransferLayer
		{
			return new TransitionTransferLayer(switchHandler,new GBitmapEffect(target,new SegmentHandler(type)))
		}
		/**马赛克渐变 */
		public static function mosaic(switchHandler:*,target:DisplayObject):TransitionObjectLayer
		{
			return new TransitionObjectLayer(switchHandler,new GBitmapEffect(target,new MosaicHandler()),target,500,500);
		}
		/**过渡渐变 */
		public static function fade(switchHandler:*,target:DisplayObject):TransitionCacheLayer
		{
			return new TransitionCacheLayer(switchHandler,target);
		}
		/**滑动渐变 */
		public static function move(switchHandler:*,target:DisplayObject,direction:int = 0):TransitionCacheLayer
		{
			return new TransitionCacheLayer(switchHandler,target,1000,{x:600 * ((direction % 2 == 0)? 1 : -1),y:450 * ((int(direction / 2) == 0)? 1 : -1),ease:Circ.easeIn});
		}
		/**方格渐变 */
		public static function dissolveMask(switchHandler:*,target:DisplayObject):TransitionMaskLayer
		{
			return new TransitionScriptMaskLayer(switchHandler,target,new DissolveMaskHandler(20));
		}
		/**百叶窗渐变 */
		public static function shutterMask(switchHandler:*,target:DisplayObject):TransitionMaskLayer
		{
			return new TransitionScriptMaskLayer(switchHandler,target,new ShutterMaskHandler());
		}
		/**百叶窗打开渐变 */
		public static function shutterMask2(switchHandler:*,target:DisplayObject,direction:int = 0):TransitionMaskLayer
		{
			return new TransitionScriptMaskLayer(switchHandler,target,new ShutterDirectMaskHandler(50,direction),null,40);
		}
		/**方向性过度渐变 */
		public static function gradientAlphaMask(switchHandler:*,target:DisplayObject,angle:Number = 0):TransitionMaskLayer
		{
			return new TransitionScriptMaskLayer(switchHandler,target,new GradientAlphaMaskHandler(angle));
		}
		/**白屏过渡渐变 */
		public static function simple(switchHandler:*,target:DisplayObject):TransitionSimpleLayer
		{
			return new TransitionSimpleLayer(switchHandler,target.width,target.height,0xFFFFFF,BlendMode.NORMAL);
		}
		/**变亮过渡渐变 */
		public static function add(switchHandler:*,target:DisplayObject):TransitionSimpleLayer
		{
			return new TransitionSimpleLayer(switchHandler,target.width,target.height,0xFFFFFF,BlendMode.ADD);
		}
		/**变暗过渡渐变 */
		public static function subtract(switchHandler:*,target:DisplayObject):TransitionSimpleLayer
		{
			return new TransitionSimpleLayer(switchHandler,target.width,target.height,0xFFFFFF,BlendMode.SUBTRACT);
		}
	}
}