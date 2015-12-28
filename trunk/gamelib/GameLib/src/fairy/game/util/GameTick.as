package fairy.game.util
{
	import fairy.util.Tick;
	
	public class GameTick extends Tick
	{
		static private var _instance:Tick;
		static public function get instance():Tick
		{
			if (!_instance)
				_instance = new Tick();
			
			return _instance;
		}
	}
}