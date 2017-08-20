package entities;

import com.haxepunk.tmx.*;
import com.haxepunk.Entity;
import com.haxepunk.graphics.*;

class Level extends TmxEntity
{

    public static inline var PLAYER = 17;
    public static inline var SPELLBOOK = 18;
    public static inline var SAVE_POINT = 19;

    public var entities:Array<Entity>;

    public function new(filename:String)
    {
        super(filename);
        layer = 2;
        entities = new Array<Entity>();
        loadGraphic("graphics/tiles.png", ["main"]);
        loadMask("collision_mask", "walls");
        map = TmxMap.loadFromFile(filename);
        for(entity in map.getObjectGroup("entities").objects)
        {
            if(entity.gid == PLAYER)
            {
                entities.push(new Player(entity.x, entity.y));
                entities.push(new Shadow(entity.x, entity.y));
            }
            if(entity.gid == SPELLBOOK)
            {
                entities.push(new Spellbook(entity.x, entity.y));
            }
            if(entity.gid == SAVE_POINT)
            {
                entities.push(new SavePoint(entity.x, entity.y));
            }
        }
    }

    override public function loadGraphic(
        tileset:String, layerNames:Array<String>, skip:Array<Int> = null
    )
    {
        // We override this to set tilemap.smooth to false below
        var gid:Int, layer:TmxLayer;
        for (name in layerNames)
        {
            if (map.layers.exists(name) == false)
            {
                continue;
            }
            layer = map.layers.get(name);
            var spacing = map.getTileMapSpacing(name);

            var tilemap = new Tilemap(
                tileset, map.fullWidth, map.fullHeight, map.tileWidth,
                map.tileHeight, spacing, spacing
            );
            tilemap.smooth = false;

            // Loop through tile layer ids
            for (row in 0...layer.height)
            {
                for (col in 0...layer.width)
                {
                    gid = layer.tileGIDs[row][col] - 1;
                    if (gid < 0) continue;
                    if (skip == null || Lambda.has(skip, gid) == false)
                    {
                        tilemap.setTile(col, row, gid);
                    }
                }
            }
            addGraphic(tilemap);
        }
    }

}
