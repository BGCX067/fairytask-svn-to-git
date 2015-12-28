package com.jzonl.engine.layer.scene
{
	
	import com.jzonl.engine.layer.map.Tile;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	
	public class TileLayer extends BaseTileLayer
	{
		public function TileLayer()
		{
			super();
			TILE_WIDTH	=	403;
			TILE_HEIGHT	=	243;
		}
		
		override protected function loadTile(cols:int,rows:int):void
		{
			var key:String = cols + "_" +rows;
			if(tileFlag[key])
			{
				return;
			}
			var tile:Tile = null;
			var path:String = null;
			tileFlag[key] = true;
			tile = tileTable[key];
			if (tile != null)
			{
				tileRequestArray.push(key);
				loadQueue();
				return;
			}
			tileRequestArray.push(key);
			tile = new Tile();
			tile.onLoadedCallback = onTileLoaded;
			tile.x = cols * TILE_WIDTH;
			tile.y = rows * TILE_HEIGHT;
			tileTable[key] = tile;
			var rowStr:String	=	rows<10?"0"+rows:rows.toString();
			var colStr:String	=	cols<10?"0"+cols:cols.toString();
			path = "res/map/" + pmapId + "/" + pmapId + "_" + rowStr + "_" + colStr + ".jpg";
			tile.url = path;
			realContainer.addChild(tile);
			loadQueue();
		}
	}
}
