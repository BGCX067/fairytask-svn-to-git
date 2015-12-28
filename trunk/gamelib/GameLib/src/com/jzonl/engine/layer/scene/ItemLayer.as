package com.jzonl.engine.layer.scene
{
	
	import com.jzonl.engine.data.BaseData;
	import com.jzonl.engine.data.Modulator;
	import com.jzonl.engine.event.SceneEvent;
	import com.jzonl.engine.utils.IO;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ItemLayer extends Sprite
	{
		protected var model		:Modulator;
		
		private var _topLayer		:Sprite;
		private var _frontLayer	:Sprite;
		private var _midLayer		:Sprite;
		private var _backLayer		:Sprite;
		//数据
		public var data			:BaseData;
		public var playerId		:String	=	"";
		
		public function ItemLayer()
		{
			model	=	Modulator.getInstance();
			data	=	new BaseData();
			_backLayer = new Sprite();
			_midLayer = new Sprite();
			_frontLayer = new Sprite();
			_topLayer = new Sprite();
			_midLayer.mouseEnabled = false;
			addChild(_backLayer);
			addChild(_midLayer);
			addChild(_frontLayer);
			addChild(_topLayer);
			_frontLayer.mouseEnabled = false;
			_frontLayer.mouseChildren = false;
			_topLayer.mouseEnabled = false;
			_topLayer.mouseChildren = false;
			mouseEnabled = false;
			
			//点击事件
			addEventListener(MouseEvent.CLICK,onItemClick);
			
		}
		
		/**
		 * 人物层点击事件 
		 * @param evt
		 * 
		 */
		private function onItemClick(evt:MouseEvent):void
		{
			model.sendSceneEvent(SceneEvent.PlayerClick,[evt.target]);
		}
		
		public function get midLayer() : Sprite
		{
			return _midLayer;
		}
		public function addMid(param1:*) : void
		{
			var isTop:Boolean = false;
			var idx:int = 0;
			var proObj:DisplayObject = null;
			if (!_midLayer.contains(param1))
			{
				isTop = false;
				idx = 0;
				while (idx < _midLayer.numChildren)
				{
					proObj = _midLayer.getChildAt(idx) as DisplayObject;
					if (param1.y < proObj.y)
					{
						_midLayer.addChildAt(param1, idx);
						isTop = true;
						break;
					}
					idx++;
				}
				if(!isTop)
				{
					_midLayer.addChild(param1);
				}
				//IO.traceLog("成功添加显示在中间层:",param1.Name);
			}
		}
		
		public function setVisible(val:Boolean):void
		{
			_backLayer.visible	=	val;
			_midLayer.visible	=	val;
			_frontLayer.visible	=	val;
		}
		
		/**
		 * 取得场景对象
		 * 
		 */
		public function getChar(pid:String):*
		{
			if(data.CheckProperties(pid))
			{
				return data.GetProperties(pid);
			}
			return null;
		}
		
		public function addBack(param1:DisplayObject) : void
		{
			_backLayer.addChild(param1);
		}
		public function removeBack(param1:DisplayObject) : void
		{
			if (_backLayer.contains(param1))
			{
				_backLayer.removeChild(param1);
			}
		}
		public function removeMid(param1:DisplayObject) : void
		{
			if (_midLayer.contains(param1))
			{
				_midLayer.removeChild(param1);
			}
		}
		public function addFront(param1:DisplayObject) : void
		{
			_frontLayer.addChild(param1);
		}
		public function clearAll() : void
		{
			clearMid();
			clearFront();
			clearBack();
			//data.clearProperties();
		}
		
		/**
		 * 加入顶层用来指示 
		 * @param val
		 * 
		 */
		public function addTop(val:DisplayObject):void
		{
			_topLayer.addChild(val);
		}
		
		public function clearMid() : void
		{
			var tmpItem:*;
			//IO.traceLog("清理中间====================:",_midLayer.numChildren);
			var midCount	:int	=	_midLayer.numChildren;
			
			while(midCount>0)
			{
				midCount--;
				tmpItem	=	_midLayer.getChildAt(midCount);
				if(String(tmpItem.id)!=playerId)
				{
					tmpItem.parent.removeChild(tmpItem);
					//IO.traceLog("清理场景====================:",tmpItem.id,tmpItem.Name);
				}
			}
			/*
			while (_midLayer.numChildren > 1)
			{
				tmpItem	=	_midLayer.getChildAt(0);
				if(String(tmpItem.id)!=playerId)
				{
					//_midLayer.removeChildAt(0);
					tmpItem.parent.removeChild(tmpItem);
					IO.traceLog("清理场景====================:",tmpItem.id,tmpItem.Name);
				}
				else
				{
					IO.traceLog("交换人物====================:",tmpItem.id);
					_midLayer.swapChildrenAt(0,_midLayer.numChildren-1);
				}
			}*/
		}
		public function clearFront() : void
		{
			var tmpItem:*;
			while (_frontLayer.numChildren > 0)
			{
				tmpItem = _frontLayer.removeChildAt(0);
				IO.traceLog("清理场景====================:",tmpItem.id);
			}
		}
		public function clearBack() : void
		{
			var tmpItem:*;
			while (_backLayer.numChildren > 0)
			{
				tmpItem = _backLayer.removeChildAt(0);
				IO.traceLog("清理场景====================:",tmpItem.id);
			}
		}
	}
}
