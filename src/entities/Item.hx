package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class Item extends Entity
{

    private var sprite:Image;

    public function new(x:Int, y:Int) 
    {
        super(x, y);
        type = "item";
    }

    public function finishInitializing()
    {
        sprite.smooth = false;
        graphic = sprite;
    }

    public function use(player:Player)
    {
        // Override in child classes
    }
}
