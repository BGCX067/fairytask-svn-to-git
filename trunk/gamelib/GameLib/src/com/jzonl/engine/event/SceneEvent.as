package com.jzonl.engine.event
{
	import flash.events.Event;
	
	public class SceneEvent extends Event
	{
		public static const FirstEnterScene			:String	=	"onFirstEnterScene";			
		public static const SceneLoaded				:String	=	"onSceneLoaded";		
		public static const CastleSceneLoaded			:String	=	"onCastleSceneLoaded";
		public static const InstanceScene				:String	=	"onInstanceSceneLoaded";
		public static const CastleEntrySceneLoaded	:String	=	"onCastleEntrySceneLoaded";
		public static const CLOSETONPC				:String	=	"CLOSETONPC";
		public static const HIDEOTHERS				:String	=	"hideOthers";
		//点击场景
		public static const CLICK_SCENE				:String	=	"CLICK_SCENE";
		
		//战斗场景
		//======================================================================
		//选中人物
		public static const PlayerClick	:String		=	"onPlayerClick";
		
		// 传送
		public static const SceneTransfer	:String		=	"onSceneTransfer";
		
		public var data:Array;
		
		public function SceneEvent(type:String, pData:Array,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			data =	pData;
		}
	}
}