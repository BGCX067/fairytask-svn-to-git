package fairy.game.util
{
	import fairy.operation.Oper;
	import fairy.operation.TweenOper;
	import fairy.operation.effect.IEffect;
	import fairy.util.ReflectUtil;
	import fairy.util.easing.TweenEvent;

	public class GameTweenOper extends TweenOper implements IEffect
	{
		public function GameTweenOper(target:*=null,duration:int=100,params:Object=null,invert:Boolean = false,clearTarget:* = 0,immediately:Boolean = false)
		{
			super(target,duration,params,invert,clearTarget,immediately);
		}
		
		/** @inheritDoc*/
		public override function execute() : void
		{
			if (_target is String)
				_target = ReflectUtil.eval(_target);
			
			if (clearTarget is Boolean)
				GameTweenUtil.removeTween(_target,clearTarget);
			else if (clearTarget >= 0)
				GameTweenUtil.removeTween(_target,clearTarget == 1);
			
			tween = new GameTweenUtil(_target,duration,params);
			tween.addEventListener(TweenEvent.TWEEN_END,result);
			
			if (invert && updateWhenInvent)
				tween.update();//执行update确认属性
		}
	}
}