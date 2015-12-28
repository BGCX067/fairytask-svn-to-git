package com.jzonl.engine.layer.scene
{
	import flash.display.Sprite;

	public interface ILayer
	{
		function show(pParent:Sprite=null):void;
		function aniShow(pType:int,pParent:Sprite=null):void;
		function hide():void;
		function aniHide(pType:int):void;
	}
}