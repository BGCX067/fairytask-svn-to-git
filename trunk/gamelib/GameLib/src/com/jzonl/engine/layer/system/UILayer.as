package com.jzonl.engine.layer.system
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class UILayer extends Sprite
	{
		//显示最底层
		private var _backLayer		:Sprite	=	new Sprite();
		private var _middleLayer	:Sprite	=	new Sprite();
		private var _loginLayer	:Sprite	=	new Sprite();
		private var _topLayer		:Sprite	=	new Sprite();
		private var _loadLayer		:Sprite	=	new Sprite();
		
		/**
		 * 构造函数 
		 */
		public function UILayer()
		{
			initGUI();
		}
		
		/**
		 * 初始化显示 
		 */
		private function initGUI():void
		{
			addChild(_backLayer);
			addChild(_middleLayer);
			addChild(_loginLayer);
			addChild(_topLayer);
			addChild(_loadLayer);
			mouseEnabled = false;
		}
		
		/**
		 * 添加底层UI 
		 * @param val
		 * 
		 */
		public function addBack(val:DisplayObject):void
		{
			_backLayer.addChild(val);
		}
		/**
		 * 添加中间层 
		 * 中间层只显示一个UI
		 * @param val
		 * 
		 */
		public function addMiddle(val:DisplayObject,isOnly:Boolean=true):void
		{
			if(isOnly)
			{
				while(_middleLayer.numChildren>0)
				{
					_middleLayer.removeChildAt(0);
				}
			}
			_middleLayer.addChild(val);
		}
		/**
		 * 添加中间层 
		 * 中间层只显示一个UI
		 * @param val
		 * 
		 */
		public function addLogin(val:DisplayObject):void
		{
			while(_loginLayer.numChildren>0)
			{
				_loginLayer.removeChildAt(0);
			}
			_loginLayer.addChild(val);
		}
		
		/**
		 * 清理登陆 
		 * 
		 */
		public function clearLogin():void
		{
			while(_loginLayer.numChildren>0)
			{
				_loginLayer.removeChildAt(0);
			}
			if(_loginLayer.parent)
			{
				removeChild(_loginLayer);
			}
		}
		
		/**
		 * 添加顶层 
		 * @param val
		 * 
		 */
		public function addTop(val:DisplayObject):void
		{
			_topLayer.addChild(val);
		}
		/**
		 * 添加加载层 
		 * @param val
		 * 
		 */
		public function addLoad(val:DisplayObject):void
		{
			_loadLayer.addChild(val);
		}
		
		/**
		 * 是否 显示除顶层外的UI 
		 * @param flag
		 * 
		 */
		public function visibleOther(flag:Boolean):void
		{
			_backLayer.visible		=	flag;
			_middleLayer.visible	=	flag;
		}
	}
}