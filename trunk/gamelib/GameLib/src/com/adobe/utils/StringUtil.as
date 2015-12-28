/*
  Copyright (c) 2008, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.utils
{
	
	/**
	* 	Class that contains static utility methods for manipulating Strings.
	* 
	* 	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*	@tiptext
	*/		
	public class StringUtil
	{

		/**
		 * 忽略大小字母比较字符是否相等;
		 * @param       char1
		 * @param       char2
		 * @return
		 */
		public static function equalsIgnoreCase(char1:String,char2:String):Boolean{
			return char1.toLowerCase() == char2.toLowerCase();
		}
		
		/**
		 * 比较字符是否相等;
		 * @param       char1
		 * @param       char2
		 * @return
		 */
		public static function equals(char1:String,char2:String):Boolean{
			return char1 == char2;
		}
		
		/**
		 * 是否为URL地址
		 * @param       char
		 * @return  Boolean
		 */
		public static function isURL(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char).toLowerCase();
			var pattern:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否为Email地址;
		 * @param       char
		 * @return
		 */
		public static function isEmail(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		//是否为手机号码
		public static function isTelNumber(char:String):Boolean
		{
			if (char == null)
			{
				return false;
			}
			char = trim(char);
			var testTelReg:RegExp = /^(130|131|132|133|134|135|136|137|138|139|150|151|152|153|155|156|158|159|186|188|189)\d{8}$/;
			var result:Object = testTelReg.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否是数值字符串;
		 * @param       char
		 * @return
		 */
		public static function isNumber(char:String):Boolean{
			if(char == null) return false;
			var trimmed:String = StringUtil.trim(char);
			if (trimmed.length < char.length || char.length == 0)
				return false;
			
			return !isNaN(Number(char));
		}
		
		//是否为Double型数据;
		public static function isDouble(char:String):Boolean{
			char = trim(char);
			var pattern:RegExp = /^[-\+]?\d+(\.\d+)?$/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		//Integer;
		public static function isInteger(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[-\+]?\d+$/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		//English;
		public static function isEnglish(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[A-Za-z]+$/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		//中文;
		public static function isChinese(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[\u0391-\uFFE5]+$/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否双字节
		 * @param       char
		 * @return
		 */
		public static function isDoubleChar(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[^\x00-\xff]+$/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否含有中文字符
		 * @param       char
		 * @return
		 */
		public static function hasChineseChar(char:String):Boolean{
			if(char == null){
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /[^\x00-\xff]/; 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 注册字符;
		 * @param       char
		 * @param       len
		 * @return
		 */
		public static function hasAccountChar(char:String,len:uint=15):Boolean{
			if(char == null){
				return false;
			}
			if(len < 10){
				len = 15;
			}
			char = trim(char);
			var pattern:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,"+len+"}$", ""); 
			var result:Object = pattern.exec(char);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		
		/**
		 * 是否为空白;
		 * @param       char
		 * @return
		 */
		public static function isWhitespace(char:String):Boolean{
			switch (char){
				case "":
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;    
				default:
					return false;
			}
		}
		
		/**
		 * 获取某字符串之后的字符串
		 * @param       param1
		 * @param       param2
		 * @return
		 */
		public static function afterLast(param1:String, param2:String) : String
		{
			if (param1 == null)
			{
				return "";
			}// end if
			var _loc_3:* = param1.lastIndexOf(param2);
			if (_loc_3 == -1)
			{
				return "";
			}// end if
			_loc_3 = _loc_3 + param2.length;
			return param1.substr(_loc_3);
		}// end function
		
		/**
		 * 获取某字符串之前的字符串
		 * @param       param1
		 * @param       param2
		 * @return
		 */
		public static function beforeLast(param1:String, param2:String) : String
		{
			if (param1 == null)
			{
				return "";
			}// end if
			var _loc_3:* = param1.lastIndexOf(param2);
			if (_loc_3 == -1)
			{
				return "";
			}// end if
			return param1.substr(0, _loc_3);
		}// end function
		
		/**
		 * 从字符串中提取数字    例如 aa7882jk44   -->  788244
		 * @param       source
		 * @return
		 */
		public static function getNumbersFromString(source:String):String {
			var pattern:RegExp = /[^0-9]/g;
			return source.replace(pattern, '');
		}
		
		/**
		 * 去除标点符号(包括空格\回车\换行)
		 * @param       source
		 * @return
		 */
		public static function getLettersFromString(source:String):String {
			var pattern:RegExp = /[[:digit:]|[:punct:]|\s]/g;
			return source.replace(pattern, '');
		}
		
		/**
		 * utf16转utf8编码;
		 * @param       char
		 * @return
		 */
		public static function utf16to8(char:String):String {
			var out:Array = new Array();
			var len:uint = char.length;
			for(var i:uint=0;i<len;i++){
				var c:int = char.charCodeAt(i);
				if(c >= 0x0001 && c <= 0x007F){
					out[i] = char.charAt(i);
				} else if (c > 0x07FF) {
					out[i] = String.fromCharCode(0xE0 | ((c >> 12) & 0x0F),
						0x80 | ((c >>  6) & 0x3F),
						0x80 | ((c >>  0) & 0x3F));
				} else {
					out[i] = String.fromCharCode(0xC0 | ((c >>  6) & 0x1F),
						0x80 | ((c >>  0) & 0x3F));
				}
			}
			return out.join('');
		}
		
		/**
		 * utf8转utf16编码;
		 * @param       char
		 * @return
		 */
		public static function utf8to16(char:String):String{
			var out:Array = new Array();
			var len:uint = char.length;
			var i:uint = 0;
			var char2:int,char3:int;
			while(i<len){
				var c:int = char.charCodeAt(i++);
				switch(c >> 4){
					case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7:
						// 0xxxxxxx
						out[out.length] = char.charAt(i-1);
						break;
					case 12: case 13:
						// 110x xxxx   10xx xxxx
						char2 = char.charCodeAt(i++);
						out[out.length] = String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F));
						break;
					case 14:
						// 1110 xxxx  10xx xxxx  10xx xxxx
						char2 = char.charCodeAt(i++);
						char3 = char.charCodeAt(i++);
						out[out.length] = String.fromCharCode(((c & 0x0F) << 12) |
							((char2 & 0x3F) << 6) | ((char3 & 0x3F) << 0));
						break;
				}
			}
			return out.join('');
		}
		
		/**
		 * 添加新字符到指定位置;  
		 * @param       char        原有字符
		 * @param       value       要添加的字符
		 * @param       position    位置
		 * @return
		 */
		public static function addAt(char:String, value:String, position:int):String {
			if (position > char.length) {
				position = char.length;
			}
			var firstPart:String = char.substring(0, position);
			var secondPart:String = char.substring(position, char.length);
			return (firstPart + value + secondPart);
		}
		
		/**
		 * 替换指定位置字符;
		 * @param       char           原有字符
		 * @param       value          要添加的字符
		 * @param       beginIndex     起始位置
		 * @param       endIndex       结束位置
		 * @return
		 */
		public static function replaceAt(char:String, value:String, beginIndex:int, endIndex:int):String {
			beginIndex = Math.max(beginIndex, 0);                   
			endIndex = Math.min(endIndex, char.length);
			var firstPart:String = char.substr(0, beginIndex);
			var secondPart:String = char.substr(endIndex, char.length);
			return (firstPart + value + secondPart);
		}
		
		/**
		 * 删除指定位置字符;
		 * @param       char             原有字符
		 * @param       beginIndex       起始位置
		 * @param       endIndex         结束位置
		 * @return
		 */
		public static function removeAt(char:String, beginIndex:int, endIndex:int):String {
			return StringUtil.replaceAt(char, "", beginIndex, endIndex);
		}
		
		/**
		 * 修复双换行符;
		 * @param       char
		 * @return
		 */
		public static function fixNewlines(char:String):String {
			return char.replace(/\r\n/gm, "\n");
		}
		
		/**
		 *  动态替换字符
		 *  Substitutes "{n}" tokens within the specified string
		 *  with the respective arguments passed in.
		 *
		 *  @param str The string to make substitutions in.
		 *  This string can contain special tokens of the form
		 *  <code>{n}</code>, where <code>n</code> is a zero based index,
		 *  that will be replaced with the additional parameters
		 *  found at that index if specified.
		 *
		 *  @param rest Additional parameters that can be substituted
		 *  in the <code>str</code> parameter at each <code>{n}</code>
		 *  location, where <code>n</code> is an integer (zero based)
		 *  index value into the array of values specified.
		 *  If the first parameter is an array this array will be used as
		 *  a parameter list.
		 *  This allows reuse of this routine in other methods that want to
		 *  use the ... rest signature.
		 *  For example <pre>
		 *     public function myTracer(str:String, ... rest):void
		 *     { 
		 *         label.text += StringUtil.substitute(str, rest) + "\n";
		 *     } </pre>
		 *
		 *  @return New string with all of the <code>{n}</code> tokens
		 *  replaced with the respective arguments specified.
		 *
		 *  @example
		 *
		 *  var str:String = "here is some info '{0}' and {1}";
		 *  trace(StringUtil.substitute(str, 15.4, true));
		 *
		 *  // this will output the following string:
		 *  // "here is some info '15.4' and true"
		 */
		public static function substitute(str:String, ... rest):String
		{
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				str = str.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			return str;
		}
		
		/**
		 * 去掉相同字符  例如: aabbcdd  --> abcd
		 * Extracts all the unique characters from a source String.
		 * @param       source String to find unique characters within.
		 * @return  String containing unique characters from source String.
		 */
		public static function getUniqueCharacters(source:String):String {
			var unique:String = '';
			var i:uint        = 0;
			var char:String;
			var charLength:int = source.length;
			while (i < charLength) {
				char = source.charAt(i);
				
				if (unique.indexOf(char) == -1)
					unique += char;
				
				i++;
			}
			
			return unique;
		}
		
		/**
		 * 测试有多少项符合要求
		 * Determines if String contains search String.
		 * @param       source  source: String to search in.
		 * @param       search  String to search for.
		 * @return  Returns the frequency of the search term found in source String.
		 */
		public static function contains(source:String, search:String):uint {
			var pattern:RegExp = new RegExp(search, 'g');
			return source.match(pattern).length;
		}
		
		/**
		 * 自动生成链接  例如:  http://www.ss.com -->  <a href="http://www.ss.com" target="_blank">http://www.ss.com</a>
		 * @param       source     链接地址
		 * @param       window     浏览器窗口或 HTML 帧，其中显示 request 参数指示的文档
		 * @param       className  An optional CSS class name to add to the link. You can specify multiple classes by seperating the class names with spaces.
		 * @return
		 */
		public static function autoLink(source:String, window:String = "_blank", className:String = null):String {
			const pattern:RegExp = /\b(([\w-]+\:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/g;
			className            = (className != "" && className != null) ? ' class="' + className + '"' : '';
			window               = (window != null) ? ' target="' + window + '"' : '';
			
			return source.replace(pattern, '<a href="$1"' + window + className + '>$1</a>');
		}
		
		/**
		*	Does a case insensitive compare or two strings and returns true if
		*	they are equal.
		* 
		*	@param s1 The first string to compare.
		*
		*	@param s2 The second string to compare.
		*
		*	@returns A boolean value indicating whether the strings' values are 
		*	equal in a case sensitive compare.	
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/			
		public static function stringsAreEqual(s1:String, s2:String, 
											caseSensitive:Boolean):Boolean
		{
			if(caseSensitive)
			{
				return (s1 == s2);
			}
			else
			{
				return (s1.toUpperCase() == s2.toUpperCase());
			}
		}
		
		/**
		*	Removes whitespace from the front and the end of the specified
		*	string.
		* 
		*	@param input The String whose beginning and ending whitespace will
		*	will be removed.
		*
		*	@returns A String with whitespace removed from the begining and end	
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/			
		public static function trim(input:String):String
		{
			return StringUtil.ltrim(StringUtil.rtrim(input));
		}

		/**
		*	Removes whitespace from the front of the specified string.
		* 
		*	@param input The String whose beginning whitespace will will be removed.
		*
		*	@returns A String with whitespace removed from the begining	
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/	
		public static function ltrim(input:String):String
		{
			var size:Number = input.length;
			for(var i:Number = 0; i < size; i++)
			{
				if(input.charCodeAt(i) > 32)
				{
					return input.substring(i);
				}
			}
			return "";
		}

		/**
		*	Removes whitespace from the end of the specified string.
		* 
		*	@param input The String whose ending whitespace will will be removed.
		*
		*	@returns A String with whitespace removed from the end	
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/	
		public static function rtrim(input:String):String
		{
			var size:Number = input.length;
			for(var i:Number = size; i > 0; i--)
			{
				if(input.charCodeAt(i - 1) > 32)
				{
					return input.substring(0, i);
				}
			}

			return "";
		}

		/**
		*	Determines whether the specified string begins with the spcified prefix.
		* 
		*	@param input The string that the prefix will be checked against.
		*
		*	@param prefix The prefix that will be tested against the string.
		*
		*	@returns True if the string starts with the prefix, false if it does not.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/	
		public static function beginsWith(input:String, prefix:String):Boolean
		{			
			return (prefix == input.substring(0, prefix.length));
		}	

		/**
		*	Determines whether the specified string ends with the spcified suffix.
		* 
		*	@param input The string that the suffic will be checked against.
		*
		*	@param prefix The suffic that will be tested against the string.
		*
		*	@returns True if the string ends with the suffix, false if it does not.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/	
		public static function endsWith(input:String, suffix:String):Boolean
		{
			return (suffix == input.substring(input.length - suffix.length));
		}	

		/**
		*	Removes all instances of the remove string in the input string.
		* 
		*	@param input The string that will be checked for instances of remove
		*	string
		*
		*	@param remove The string that will be removed from the input string.
		*
		*	@returns A String with the remove string removed.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/	
		public static function remove(input:String, remove:String):String
		{
			return StringUtil.replace(input, remove, "");
		}
		
		/**
		*	Replaces all instances of the replace string in the input string
		*	with the replaceWith string.
		* 
		*	@param input The string that instances of replace string will be 
		*	replaces with removeWith string.
		*
		*	@param replace The string that will be replaced by instances of 
		*	the replaceWith string.
		*
		*	@param replaceWith The string that will replace instances of replace
		*	string.
		*
		*	@returns A new String with the replace string replaced with the 
		*	replaceWith string.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function replace(input:String, replace:String, replaceWith:String):String
		{
			return input.split(replace).join(replaceWith);
		}
		
		
		/**
		*	Specifies whether the specified string is either non-null, or contains
		*  	characters (i.e. length is greater that 0)
		* 
		*	@param s The string which is being checked for a value
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/		
		public static function stringHasValue(s:String):Boolean
		{
			//todo: this needs a unit test
			return (s != null && s.length > 0);			
		}
		
		/**
		 * 添加空行 
		 * @param str
		 * @return 
		 * 
		 */
		public static function writeLine(str:String="",isDouble:Boolean=false):String
		{
			return isDouble?str+"\r\n\r\n":str+"\r\n";
		}
	}
}