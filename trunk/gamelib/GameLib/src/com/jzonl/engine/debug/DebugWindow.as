package com.jzonl.engine.debug
{
	import com.jzonl.engine.date.DateFormatter;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	
	/**
	 * 例子：
	private function init():void
	{
		DebugWindow.InitDebug(GameEngine.systemSpace as Sprite);
		DebugWindow.IsVisible	=	true;
		DebugWindow.DebugCommandFun	=	onTest;
		//GameEngine.uiSpace.addChild(new NxButton().skin);
	}
	
	private function onTest(val:String):void
	{
		trace(val)
		if(val == "ok")
		{
			DebugWindow.CommandCallBack="Success!"
		}
	}
	 */	
	public class DebugWindow extends Panel
	{
		private	static	var DWin			:DebugWindow;
		private			var output			:TextField		=	new	TextField();
		private			var toolsText		:TextField		=	new	TextField();
		private			var InputCommand	:TextField;
		
		private			var	indexStart		:int			=	0;
		private			var	indexEnd		:int			=	200
		
		private			var startMoveY		:Number			=	0;
		private			var startMove		:Boolean		=	false;
		private	static	var isopen			:Boolean		=	false;
		private	static	var _outMessage		:Boolean		=	false;
				
		public			var	thisRoot		:Stage;
		public static	var	StingArr		:Array			=	new	Array();
		
		public static	var DebugCommandFun	:Function		=	null;
		
		private	function	showMessage():void
		{
			var	messageLong	:int	=	StingArr.length;
			var	tStr		:String	=	"";
			
			if(messageLong>indexEnd)
			{
				indexStart	++;
				indexEnd	++;
			}
			
			for(var i:int = indexStart ; i <messageLong ; i ++)
			{
				tStr	+=	this.getMessage(i).data;
			}
			
			if(_outMessage)
			{
				output.htmlText	=	tStr;
				output.scrollV	=	output.maxScrollV
			}
		} 
		
		public	static	function  removeDebug():void
		{
			try
			{
				DebugWindow.DWin.stage.removeEventListener(KeyboardEvent.KEY_DOWN,DebugWindow.DWin.onKeyDownHandle);
			}
			catch(e:*)
			{
				
			}
			
			try
			{
				DebugWindow.DWin.stage.removeEventListener(MouseEvent.MOUSE_MOVE	,DebugWindow.DWin.onMouseMoveHandle)
			}
			catch(e:*)
			{
				
			}
			
			try
			{
				DebugWindow.DWin.stage.removeEventListener(MouseEvent.MOUSE_UP	,DebugWindow.DWin.stopOfDrag)
			}
			catch(e:*)
			{
				
			}
			try
			{
				DebugWindow.DWin.removePanel();
			}
			catch(e:*)
			{
				
			}
			
		}
		
		public	static	function  set outMessage(t:Boolean):void
		{
			_outMessage	=	t;
		}
		
		public	static	function  get outMessage():Boolean
		{
			return _outMessage;
		}
		
		public	static	function  set enabled(t:Boolean):void
		{
//			DebugWindow.DWin.visible = t;
			if(t)
			{
				DebugWindow.DWin.stage.addEventListener(KeyboardEvent.KEY_DOWN,DebugWindow.DWin.onKeyDownHandle);
				DebugWindow.isopen	=	true;
				DebugWindow.outMessage	=	true;
			}
			else
			{
				DebugWindow.isopen	=	false;
				DebugWindow.DWin.stage.removeEventListener(KeyboardEvent.KEY_DOWN,DebugWindow.DWin.onKeyDownHandle);
				DebugWindow.outMessage	=	false;
			}
		}
		
		public	static	function  get enabled():Boolean
		{
			return	DebugWindow.isopen;
		}
		
		public	static	function	saveMessage(__type:String,__data:String):void
		{
			StingArr.push({type:__type,data:__data});
			DebugWindow.DWin.showMessage();
		}
		
		private	function	getMessage(index:Number):Object
		{
			return StingArr[index];
		}
		
		public function DebugWindow(space:Sprite)
		{			
			if ( DWin == null )
	   		{
	   			super(200,120,"Debug:");
	   			InitDate(space);	   			
	   		}
	   		else
	   		{
	   			throw new Error( "Only one ModelLocator instance should be instantiated" );
	   		}			
		}		
		
		public static function InitDebug(space:Sprite):DebugWindow
		{
			if ( DWin == null )
			{
				DWin = new DebugWindow(space);
			}
			return DWin;
		}
	   	
	   	public function InitDate(space:Sprite):void
	   	{
	   		this.haveTop	=	true;
	   		this.thisRoot	=	space.stage;
	   		this.thisRoot.addChild(this);
	   		this.candrag	=	false;
	   		this.visible 	= 	false;	   		
	   	}  
	   	
	   		
	   	
	   	protected	override function LoadSkin()		:void
	   	{
	   		super	.LoadSkin();
	   		this.addChild(output);
	   		output.wordWrap		=	true;
	   		output.multiline	=	true;	
	   		
	   		toolsText.selectable = false;
	   		//toolsText.mouseEnabled = false;
	   		var str:String = "<font color='#ffff00' face='Verdana' size='12'>" + 
	   				"<a href='event:4'>Input Command</a> | " +
	   				"<a href='event:0'>Clear All</a> | " +
	   				"<a href='event:1'>Copy All</a> | " +
	   				"<a href='event:2'>History</a> | " +
	   				"<a href='event:3'>Hide</a>" +
	   				"</font>";
	   		toolsText.htmlText = str;
	   		toolsText.width = toolsText.textWidth + 6;
	   		toolsText.x = this.width - toolsText.width - 5;
	   		toolsText.y = 2;
	   		toolsText.addEventListener(TextEvent.LINK,doTextLink);
	   		this.addChild(toolsText);
	   		
			this.contextMenu	=	output.contextMenu	=	new ContextMenu();
			output.contextMenu.hideBuiltInItems()
			var item:ContextMenuItem = new ContextMenuItem("Clear All");
			output.contextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, ClearHandler);
			
			item = new ContextMenuItem("Copy All")
			output.contextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, CopyHandler);	
			
			item = new ContextMenuItem("History")
			output.contextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, HistoryHandler);
			
			item = new ContextMenuItem("Hide")
			output.contextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, HideHandler);
			
			
			thisRoot.addEventListener(MouseEvent.MOUSE_MOVE	,onMouseMoveHandle)
			thisRoot.addEventListener(MouseEvent.MOUSE_UP	,stopOfDrag)
	   	}
	   	
	   	private function doTextLink(e:TextEvent):void
	   	{
	   		switch(e.text)
	   		{
	   			case "0":
	   				this.ClearHandler();
	   				break;
	   			case "1":
	   				this.CopyHandler();
	   				break;
	   			case "2":
	   				this.HistoryHandler();
	   				break;
	   			case "3":
	   				this.HideHandler();
	   				break;
	   			case "4":
	   				this.showInputCommand();
	   				break;
	   		}
	   	}
	   	
	   	
	   	public	override function	onMouseDownHandle(e:MouseEvent):void
		{
			super.onMouseDownHandle(e);			
			startMove	=	true;
			startMoveY	=	this.stage.mouseY;
		}
		
		public	function	stopOfDrag(e:MouseEvent):void
		{
			startMove	=	false;
			/*if(this.y>this.thisRoot.stage.stageHeight)
			{
				this.y
			}*/
			if(this.y<=0)
			{
				this.y	=	0
				this.SetSzie(this.thisRoot.stage.stageWidth-2,this.thisRoot.stage.stageHeight);
			}
			if(this.y >=	this.thisRoot.stage.stageHeight - 50)
			{
				this.y	=	this.thisRoot.stage.stageHeight - 50;
				this.SetSzie(this.thisRoot.stage.stageWidth-2,50);
			}
			else
			{
				onStageReSizeHandle(null);
			}
		}	
		
		public	function	onMouseMoveHandle(e:MouseEvent):void
		{
			if(startMove)
			{
				var h:Number	=	this.thisRoot.stage.mouseY-startMoveY;
				this.y	+=h;
				this.SetSzie(this.thisRoot.stage.stageWidth-2,this.height-h);				
				startMoveY		=	this.thisRoot.stage.mouseY;
			}
		}
		
		/**
		 * 是否显示 
		 * @return 
		 * 
		 */
		public static function get isShow():Boolean
		{
			return DWin.visible;
		}
		
	   	private function onKeyDownHandle(e:KeyboardEvent):void
	   	{
	   		if(e.keyCode == 120)
	   		{
	   			this.visible = !this.visible;
	   			this.y	=	this.thisRoot.stage.stageHeight - 150;
				this.SetSzie(this.thisRoot.stage.stageWidth-2,150);
	   		}
	   	}
	   	
	   	private function ClearHandler(e:ContextMenuEvent = null):void
	   	{
	   		output.htmlText	=	"";
	   		var	messageLong	:int	=	StingArr.length;
	   		indexStart	=	messageLong;
	   		indexEnd	=	messageLong+200;
	   		showMessage()
	   	}
	   	
	   	private function CopyHandler(e:ContextMenuEvent = null):void
	   	{
	   		var tStr:String	=	"";
	   		var	temp:String	=	"";
	   		var	messageLong	:int	=	StingArr.length;
	   		
	   		var keyword:String	=	"size=\"12\" face=\"Verdana\">";
	   		for(var i:int = 0 ; i <messageLong ; i ++)
			{
				temp	=	this.getMessage(i).data;
				temp 	= 	temp.substring(temp.indexOf(keyword) + keyword.length,temp.lastIndexOf("</font>"));
				temp 	=	temp.replace("<I>","");
				temp 	=	temp.replace("</I>","");
				temp 	=	temp.replace("<br>","\r");
//				trace(tStr);
				tStr	+=	temp;				
			}
			System.setClipboard(tStr);
	   	}
	   	
	   	private function HistoryHandler(e:ContextMenuEvent = null):void
	   	{
	   		output.htmlText	=	"";
	   		var	messageLong	:int	=	StingArr.length;
	   		indexStart	=	messageLong-200;
	   		if(indexStart<0)
	   		{
	   			indexStart = 0;
	   		}
	   		indexEnd	=	messageLong;
	   		showMessage()
	   	}
	   	
	   	private function HideHandler(e:ContextMenuEvent = null):void
	   	{
	   		this.visible	=	false;
	   	}
	   	
	   	private function showInputCommand(e:ContextMenuEvent = null):void
	   	{
	   		if(InputCommand == null)
	   		{
		   		InputCommand			=	new TextField();
		   		InputCommand.type		=	TextFieldType.INPUT;
		   		InputCommand.background	=	true;
		   		InputCommand.border		=	true;
		   		InputCommand.x			=	60
		   		InputCommand.y			=	1;
		   		InputCommand.width		=	120
		   		InputCommand.height		=	18
		   		InputCommand.text		=	""
		   		
		   		stage.focus				=	InputCommand;
		   		
		   		InputCommand.addEventListener(KeyboardEvent.KEY_DOWN,onCmdKeyDown);
		   		
		   		var str:String = "<font color='#ffff00' face='Verdana' size='12'>" + 
		   				"<a href='event:4'>Close input</a> | " +
		   				"<a href='event:0'>Clear All</a> | " +
		   				"<a href='event:1'>Copy All</a> | " +
		   				"<a href='event:2'>History</a> | " +
		   				"<a href='event:3'>Hide</a>" +
		   				"</font>";
		   		toolsText.htmlText = str;
		   		toolsText.width = toolsText.textWidth + 6;
	   			toolsText.x = this.width - toolsText.width - 5;
		   		this.addChild(InputCommand);
	   		}
	   		else
	   		{
	   			hideInputCommand()
	   		}
	   	}
	   	
	   	private function hideInputCommand():void
	   	{
	   		InputCommand.removeEventListener(KeyboardEvent.KEY_DOWN,onCmdKeyDown);
			this.removeChild(InputCommand);
			InputCommand	=	null;
			var str:String = "<font color='#ffff00' face='Verdana' size='12'>" + 
   			"<a href='event:4'>Input Command</a> | " +
   			"<a href='event:0'>Clear All</a> | " +
   			"<a href='event:1'>Copy All</a> | " +
   			"<a href='event:2'>History</a> | " +
   			"<a href='event:3'>Hide</a>" +
   			"</font>";
   			toolsText.htmlText = str;
   			toolsText.width = toolsText.textWidth + 6;
	   		toolsText.x = this.width - toolsText.width - 5;
	   	}
	   	
//	   	public static function set CommandCallBack(val:String):void
//	   	{
//	   		var s:String	=	'<font color="#00CCCC" size="12" face="Verdana">'+DateFormatter.DateFormat(new Date(),"|--[YYYY-MM-DD HH:NN:SS]")+":\Command Back->"+val+"<br></font>";
//			
//			DebugWindow.saveMessage("Command",s);
//	   	}
	   	
	   	private function onCmdKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{
				if(InputCommand.text	==	"")
				{
					return;
				}
				
				var s:String	=	'<font color="#0000FF" size="12" face="Verdana">'+DateFormatter.DateFormat(new Date(),"[YYYY-MM-DD HH:NN:SS]")+":\Command->"+InputCommand.text+"<br></font>";
			
				DebugWindow.saveMessage("Command",s)
				
				if(DebugCommandFun == null)
				{
//					DebugWindow.CommandCallBack	=	"Error:DebugCommandCallBack is null!";
					DebugWindow.saveMessage("Command",
						'<font color="#00CCCC" size="12" face="Verdana">'+
						DateFormatter.DateFormat(new Date(),
							"|--[YYYY-MM-DD HH:NN:SS]")+":\Command Back->"+
							"Error:DebugCommandCallBack is null!"+
							"<br></font>");
				}
				else
				{
					DebugCommandFun.call(this,InputCommand.text);
				}
				
				if(InputCommand.text == "close")
				{
					hideInputCommand()
				}
				else
				{				
					InputCommand.text	=	"";
				}				
			}
		}
	   		   	
	   	public	override function	SetSzie(__w:Number,__h:Number):void
	   	{	   		
	   		super.SetSzie(__w,__h);
	   		output.x			=	this.x+5;
	   		output.y			=	25;
	   		output.width		=	__w-10;
	   		output.height		=	__h	-	output.y-5;
	   		output.background	=	true;
	   		
	   		this.toolsText.x = __w - this.toolsText.width - 5;
	   		this.toolsText.y = 2;
	   	}
	   	
		public	override function onStageReSizeHandle(e:Event):void
		{
			this.SetSzie(this.stage.stageWidth-2,this.height);
			this.x=0;
			this.y=this.stage.stageHeight-this.height;
			//this.y=this.stage.stageHeight-200
			//IO.traceln(this.width,this.stage.stageWidth,this.stage.width,this.stage.x);
			
			//this.width		=	this.stage.stageWidth;
			//IO.traceln("s:",(this.stage.stageWidth	-	this.stage.width)*.5);
			//this.x				=	0;
			//this.y				 =	0;
			//this.width			=	this.stage.stageWidth;
			
			//this.scale9Grid	=	new	Rectangle(this.x+2,this.y+2,this.width-4,this.height-4)
		}
	}
}