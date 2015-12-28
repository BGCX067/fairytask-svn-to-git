package com.jzonl.engine.debug
{
	import com.jzonl.engine.data.BaseData;
	import com.jzonl.engine.utils.draw.DrawAPI;
	import com.jzonl.engine.utils.draw.DrawStyle;
	
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class Panel extends Sprite
	{
		//主背景
		public	var	PanelBG		:Sprite		=	new	Sprite();
		private	var bgShape		:Shape		=	new	Shape();
		//top背景
		public	var	PanelTopBG	:Sprite		=	new	Sprite();
		private	var topBgShape	:Shape		=	new	Shape();
		
		//内容(顶层)		
		public	var	PanelBox	:Sprite		=	new	Sprite();
		
		public	var	PanelTitle	:TextField	=	new	TextField();
		
		public	var defaultW	:uint		=	200;
		public	var defaultH	:uint		=	160;
		
		public	var	haveTop		:Boolean	=	false;
				
		public	var	candrag		:Boolean	=	false;
		
		public function  Panel(...argc):void
		{
			if(argc.length>0)
			{
				initPanel(argc[0],argc[1],argc[2]);
			}
			super();
		}
		
		public function removeEvent():void
		{
			try
			{
				this.stage		.removeEventListener(Event.RESIZE			,onStageReSizeHandle);
			}
			catch(e:*)
			{
				
			}
			try
			{
				this.PanelTopBG	.removeEventListener(MouseEvent.MOUSE_DOWN	,onMouseDownHandle)
			}
			catch(e:*)
			{
				
			}
			try
			{
				this.PanelTopBG	.removeEventListener(MouseEvent.MOUSE_UP	,onMouseUpHandle)
			}
			catch(e:*)
			{
				
			}
			try
			{
				this.removeEventListener(Event.ADDED_TO_STAGE	,init);
			}
			catch(e:*)
			{
				
			}
		}
				
		public function  initPanel(_w:uint,_h:uint,title:String="Title"):void
		{
			defaultW		=	_w;
			defaultH		=	_h;
			PanelTitle.text	=	title;
			PanelTitle.mouseEnabled	=	false;
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public	function	SetSzie(__w:Number,__h:Number):void
		{
			drawPanel(__w,__h)
		}
		
		private function	AddEvent():void
		{
			//this.PanelTopBG.addEventListener(MouseEvent.MOUSE_MOVE	,onMouseMoveHandle)
			this.PanelTopBG.addEventListener(MouseEvent.MOUSE_DOWN	,onMouseDownHandle)
			this.PanelTopBG.addEventListener(MouseEvent.MOUSE_UP	,onMouseUpHandle)
		}
				
		public	function	onMouseDownHandle(e:MouseEvent):void
		{
			if(candrag)
			{
				this.startDrag();
			}			
		}
		
		public	function	onMouseUpHandle(e:MouseEvent):void
		{
			if(candrag)
			{
				var tmc:MovieClip	=	this as MovieClip;
				tmc.stopDrag();
			}			
		}
		
		public	function  removePanel():void
		{
			try
			{
				this.PanelTopBG.removeEventListener(MouseEvent.MOUSE_DOWN	,onMouseDownHandle)
			}
			catch(e:*)
			{
				
			}
			
			try
			{
				this.PanelTopBG.removeEventListener(MouseEvent.MOUSE_UP	,onMouseUpHandle)
			}
			catch(e:*)
			{
				
			}
			try
			{
				
			}
			catch(e:*)
			{
				this.parent.removeChild(this);
			}
		}
		
		private	function init(e:Event)	:void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);			
			this.stage.addEventListener(Event.RESIZE,onStageReSizeHandle);
			this.hide();
			this.addChild(PanelBG);
			this.addChild(PanelTopBG);
			this.addChild(PanelTitle);
			this.addChild(PanelBox);
			PanelTitle.x	=	2;
			PanelTitle.y	=	2;
			LoadSkin();
			LoadStyle();
			AddEvent();	
			onStageReSizeHandle(null);		
			this.show();
			intComplete();
		}
		
		/**使对象显示*/
		public	function	show():void
		{
			this.visible	=	true;
		}
		
		/**使对象隐藏*/
		public	function	hide():void
		{
			this.visible	=	false;
		}
		
		protected	function intComplete():void
		{
			
		}
		
		protected	function LoadSkin()		:void
		{
			try
			{			
				this.PanelBG.addChild(bgShape);
				this.PanelTopBG.addChild(topBgShape);
				drawPanel(defaultW,defaultH);
			}
			catch(e:*)
			{
				this.PanelBG.addChild(bgShape);
				this.PanelTopBG.addChild(topBgShape);
				drawPanel(defaultW,defaultH);
			}
		}
		
		private	function drawPanel(__w:Number,__h:Number)	:void
		{
			var matrix		:Matrix;
			
			
			DrawAPI.clear(bgShape);
			DrawAPI.clear(topBgShape);
			
			//drawAPI.StartDrawRect(0,0,__w		,__h	,1,0xCAC5B9,bgShape);
			DrawAPI.drawRect(bgShape.graphics,
				DrawStyle.getRectStyle(0,0,__w,__h),
				DrawStyle.getFillStyle(0x556B75,1));
			//bgShape.alpha	=	.5;
			
			if(haveTop)
			{				
				topBgShape.x	=	1;
				topBgShape.y	=	1;
				
				matrix 	= 	new Matrix();
				matrix.createGradientBox(__w-2, 20);
				
				var	tRectStyle	:BaseData	=	DrawStyle.getRoundRectStyle(0,0,__w-2,20,0);
				var tLineStyle	:BaseData	=	DrawStyle.getLineStyle(1,0,1,true,LineScaleMode.NONE);
				
				DrawAPI.drawRoundRect(topBgShape.graphics,tRectStyle,
				DrawStyle.getGradientStyle(GradientType.LINEAR,
					[0x141A29,0x504443],[0.8,0.8],[0,255],matrix),tLineStyle,
				DrawStyle.getGradientStyle(GradientType.LINEAR,
					[0x504443,0x504443-0x000033],[0.8,0.8],[0,255],matrix))
			}
			else
			{
				DrawAPI.drawRect(topBgShape.graphics,
					DrawStyle.getRectStyle(1,1,__w-2,20),
					DrawStyle.getFillStyle(0xCAC5B9,1));
				topBgShape	.alpha	=	0;
			}						
						
		}
		
		private	function LoadStyle()	:void
		{
			var tf:TextFormat		=	new	TextFormat();
			
			tf.color				=	0xffffff;
			tf.size					=	12;
			tf.font					=	"Verdana";
			
			PanelTitle.setTextFormat(tf);
			PanelTitle.autoSize		=	"left";
			PanelTitle.selectable	=	false;
		}
		
		public	function onStageReSizeHandle(e:Event):void{}
	}
}