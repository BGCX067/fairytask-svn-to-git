package fairy.fileformat.swf.tag
{
	import fairy.fileformat.swf.SWFDecoder;
	import fairy.util.data.ByteArrayReader;

	/**
	 * FLASH的内部Metadata
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class MetadataTag extends Tag
	{
		/** @inheritDoc*/
		public override function get type() : int
		{
			return 77;
		}
		
		public var metadata:XML;
		/** @inheritDoc*/
		public override function read() : void
		{
			var bytesReader:ByteArrayReader = new ByteArrayReader(bytes);
			var text:String = SWFDecoder.readString(bytes);
			metadata = new XML(text);
		}
	}
}