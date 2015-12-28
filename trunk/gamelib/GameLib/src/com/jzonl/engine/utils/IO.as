package com.jzonl.engine.utils
{
	import com.jzonl.engine.debug.DebugWindow;
	import com.jzonl.engine.utils.DateFormatter;
	
	import flash.utils.describeType;

	/**
	 * 使用方法：
	 * 1、静态方法		IO.traceln(...argc):void
	 * @author Hanjy
	 */
	public class IO
	{
		private static var _io:IO=null;

		/**
		 *
		 */
		public function IO()
		{

		}

		/**
		 *
		 * @return
		 */
		public static function get io():IO
		{
			if (_io == null)
			{
				_io=new IO();
			}
			return _io;
		}

		/**
		 * 输出字符串，并加上输出时间
		 * 支持空格输出，逗号输出
		 */
		public static function traceln(... argc):void
		{
			io.traceln(argc)
		}

		/**
		 *
		 * @param val
		 */
		public function traceln(val:Array):void
		{
			if (!DebugWindow.enabled)
			{
				return;
			}
			var sSize:int=val.length;
			var s:String="";
			if (sSize < 1)
			{
				trace("");
				return;
			}
			for (var i:int=0; i < sSize; i++)
			{
				s+=val[i] + " ";
			}
			s=DateFormatter.DateFormat(new Date(), "[YYYY-MM-DD HH:NN:SS:X]") + ":" + s;
			trace(s);
		}

		/**
		 * 在调试面板上输出普通信息
		 */
		public static function traceMessage(... argc):void
		{
			io.traceMessage(argc);
		}

		/**
		 *
		 * @param val
		 */
		public function traceMessage(val:Array):void
		{
			if (!DebugWindow.enabled)
			{
				return;
			}

			IO.traceln(val);
			var sSize:int=val.length;
			var s:String="";
			if (sSize < 1)
			{
				trace("");
				return;
			}
			for (var i:int=0; i < sSize; i++)
			{
				s+=val[i] + " ";
			}

			s='<font color="#000000" size="12" face="Verdana">' + DateFormatter.DateFormat(new Date(), "[YYYY-MM-DD HH:NN:SS:X]") + ":" + s + "<br></font>";
			DebugWindow.saveMessage("Message", s)
		}

		/**
		 * 在调试面板上输出日志信息
		 */
		public static function traceLog(... argc):void
		{
			io.traceLog(argc);
		}

		/**
		 *
		 * @param val
		 */
		public function traceLog(val:Array):void
		{
			if (!DebugWindow.enabled)
			{
				return;
			}
			IO.traceln(val);
			var sSize:int=val.length;
			var s:String="";
			if (sSize < 1)
			{
				trace("");
				return;
			}
			for (var i:int=0; i < sSize; i++)
			{
				s+=val[i] + " ";
			}
			s='<font color="#999999" size="12" face="Verdana">' + DateFormatter.DateFormat(new Date(), "[YYYY-MM-DD HH:NN:SS:X]") + "Log:<I>" + s + "</I><br></font>";
			DebugWindow.saveMessage("Log", s)
		}

		/**
		 * 在调试面板上输出错误信息
		 */
		public static function traceError(... argc):void
		{
			io.traceError(argc);
		}

		/**
		 *
		 * @param val
		 */
		public function traceError(val:Array):void
		{
			if (!DebugWindow.enabled)
			{
				return;
			}

			IO.traceln(val);
			var sSize:int=val.length;
			var s:String="";
			if (sSize < 1)
			{
				trace("s=", s)
				trace("");
				return;
			}

			for (var i:int=0; i < sSize; i++)
			{
				s+=val[i] + " ";
			}
			s='<font color="#FF0000" size="12" face="Verdana">' + DateFormatter.DateFormat(new Date(), "[YYYY-MM-DD HH:NN:SS:X]") + "Error:" + s + "<br></font>";
			DebugWindow.saveMessage("Error", s);
		}

		/**
		 * obj To String()
		 *
		 * 使用方法：IO.traceln(IO.toString(obj))
		 */
		public static function toString(data:Object):String
		{
			//IO.traceln("data",data is Object);
			if (data == null)
			{
				return "null";
			}
			var str:String="";
			var isObj:Boolean=(typeof(data) == "object") && describeType(data).@name != "Array";
			var isArr:Boolean=describeType(data).@name == "Array";
			var s1:String="";
			var s2:String="";

			if ((!isObj) && (!isArr))
			{
				if (describeType(data).@name == "String")
				{
					str='"' + data.toString() + '"';
				}
				else
				{
					str+=data.toString();
				}
				if (str.split(" ").join("") == "}")
				{
					str="Null!"
				}
				return str;
			}
			else if (isObj)
			{
				var strobj:String="";
				strobj+="{";
				for (var p:String in data)
				{
					strobj+=p + ":";
					strobj+=IO.toString(data[p]) + ",";
				}
				strobj=strobj.substr(0, strobj.length - 1);
				strobj+="}";

				if (strobj.split(" ").join("") == "}")
				{
					strobj="Null!"
				}
				str+=strobj;

				return strobj;
			}
			else
			{
				var strarr:String="";
				strarr+="[";
				for (var i:int=0; i < data.length; i++)
				{
					strarr+=IO.toString(data[i]) + ",";
				}
				strarr=strarr.substr(0, strarr.length - 1);
				strarr+="]";
				str+=strarr;
				return strarr;
			}
		}
	}
}