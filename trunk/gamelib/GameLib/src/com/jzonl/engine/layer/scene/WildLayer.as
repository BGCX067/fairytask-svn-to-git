package com.jzonl.engine.layer.scene
{
	import com.jzonl.engine.GameStage;
	import com.jzonl.engine.data.Modulator;
	import com.jzonl.engine.event.LoadingEvent;
	import com.jzonl.engine.event.SceneEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * 野外场景 
	 * @author hanjy
	 */	
	public class WildLayer extends Sprite
	{
		private var model		:Modulator;
		private var modelId	:int;
		//加载器
		private var _bgLoader	:Loader	=	new Loader();
		//背景图
		private var _bgImg		:Bitmap;
		
		public function WildLayer()
		{
			model	=	Modulator.getInstance();
			super();
			initEvent();
		}
		
		/**
		 * 事件处理 
		 */
		private function initEvent():void
		{
			_bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
		}
		
		/**
		 * 加载地图 
		 * @param pId
		 * 
		 */
		public function loadMap(pId:int,fId:int):void
		{
			modelId	=	pId;
			//清理加载
			clear();
			_bgLoader.load(new URLRequest("res/map/wild/"+fId+"/"+pId+".jpg"));
		}
		
		/**
		 * 加载完毕 
		 * @param evt
		 * 
		 */
		private function onLoaded(evt:Event):void
		{
			_bgImg	=	_bgLoader.content as Bitmap;
			addChild(_bgImg);
			_bgImg.x	=	(GameStage.rootW-_bgImg.width)/2;
			_bgImg.y	=	(GameStage.rootH-_bgImg.height)/2;
			
			model.dispatchEvent(new LoadingEvent(LoadingEvent.SCENE_LOAD));
		}
		
		/**
		 * 清理野外 
		 * 
		 */
		public function clear():void
		{
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
	}
}