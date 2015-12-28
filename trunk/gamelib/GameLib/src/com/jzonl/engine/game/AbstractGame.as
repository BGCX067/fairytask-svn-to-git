package com.jzonl.engine.game
{
	import flash.display.Sprite;
	/**
	 * 游戏抽象类 
	 * @author hanjy
	 * 
	 */	
	public class AbstractGame extends Sprite
	{
		final public function initGame():void{
			this.createCore();
		}
		public function restartGame():void{
			throw (new Error("Abstract Function restartGame"));
		}
		protected function createCore():void{
			throw (new Error("Abstract Function createCore"));
		}
		protected function createStage():void{
			throw (new Error("Abstract Function createStage"));
		}
		protected function createUI():void{
			throw (new Error("Abstract Function createUI"));
		}
		protected function loadConfig():void{
			throw (new Error("Abstract Function loadConfig"));
		}
		protected function startGame():void{
			throw (new Error("Abstract Function startGame"));
		}
	}
}