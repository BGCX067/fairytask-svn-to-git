package com.jzonl.engine.layer.map.connection
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class MapConnection extends Object
	{
		public var lc:LocalConnection;
		public var connId:int;
		private var otherName:String;
		public static var SERVER:String = "Juzhong_MapServer";
		public static var CLIENT:String = "Juzhong_MapClient";
		public static var STATUS_HANDLER:String = "receiveStatus";
		public static var MSG_HANDLER:String = "receiveMessage";
		public static var MSG_TYPE_LOAD:int = 1;
		public static var MSG_TYPE_CLEAR:int = 2;
		
		public function MapConnection(ctype:String, cid:int)
		{
			this.connId = cid;
			this.lc = new LocalConnection();
			this.lc.client = this;
			if (ctype == SERVER)
			{
				this.otherName = CLIENT;
			}
			else
			{
				this.otherName = SERVER;
			}
			while (true)
			{
				if (this.connect(ctype + this.connId))
				{
					break;
				}
				connId++
			}
			
		}
		
		protected function statusHandler(event:StatusEvent) : void
		{
			switch(event.level)
			{
				case "status":
				{
					break;
				}
				case "error":
				{
					break;
				}
				default:
				{
					break;
					break;
				}
			}
			
		}
		
		private function connect(str:String) : Boolean
		{
			try
			{
				this.lc.connect(str);
				this.lc.addEventListener(StatusEvent.STATUS, this.statusHandler);
				return true;
			}
			catch (error:ArgumentError)
			{
				return false;
			}
			return false;
		}
		
		public function sendStatus(param1:String) : void
		{
			this.lc.send(this.otherName + this.connId, STATUS_HANDLER, param1);
		}
		
		public function sendMessage(param1:Object) : void
		{
			this.lc.send(this.otherName + this.connId, MSG_HANDLER, param1);
		}
		
		public function receiveMessage(param1:Object) : void
		{
			
		}
		
		public function receiveStatus(param1:Object) : void
		{
			
		}
		
		public function close() : void
		{
			this.lc.close();
		}
	}
}