package fairy.game.layer.position
{
	import flash.geom.Point;
	
	import fairy.game.layer.GameLayer;

	public interface IPositionManager
	{
		function transform(p:Point):Point
		function untransform(p:Point):Point;
	}
}