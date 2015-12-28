package fairy.operation.effect
{
	import fairy.operation.IOper;

	/**
	 * 效果接口
	 * @author flashyiyi
	 * 
	 */
	public interface IEffect extends IOper
	{
		/**
		 * 目标
		 * @return 
		 * 
		 */
		function get target():*;
		function set target(v:*):void
	}
}