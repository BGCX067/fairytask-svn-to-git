package com.jzonl.engine.event
{
	import flash.events.Event;
	
	public class LogicEvent extends Event
	{
		//服务器配置
		public static const SERVERINIT			:String	=	"onServerInit";
		//资源加载完毕
		public static const RESLOADED				:String	=	"onResLoaded";
		//开始加载登陆
		public static const ENTERLOGIN			:String	=	"ENTERLOGIN";
		//引擎初始化完毕
		public static const INIT_COMPLETE			:String	=	"onEngineInitComplete";
		public static const CONNECT_SUCCESS		:String	=	"onServerConneted";
		public static const LOGIN_COMPLETE		:String	=	"onLoginComplete";
		public static const LOADING_BACKGROUND	:String	=	"loadingBackground";
		public static const TIPBOXES_OK			:String =   "onTipboxesOk";
		public static const TIPBOXES_CANCEL		:String	=	"onTipboxesCancel";
		public static const TIPBOXES_IGNORE		:String	=	"onTipboxesIgnore";
		//玩家
		public static const CHARACTOR_SELECT		:String	=	"playerClick";
		//场景
		public static const SCENE_SWITCH			:String	=	"scene_switch";
		//玩家信息已经收到
		public static const USERLOADED			:String	=	"userLoaded";
		//客户端数据发送完毕
		public static const DATA_READY			:String	=	"dataReady";
		
		public var obj		:Object	=	null;
		
		public function LogicEvent(type:String, _fromTarget:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			obj	=	_fromTarget;
		}
	}
}