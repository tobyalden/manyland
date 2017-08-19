package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class NoItem extends Item
{
    // A placeholder item to use when the player's inventory is empty
    public function new(x:Int, y:Int) 
    {
        super(x, y);
        graphic = Image.createRect(16, 16);
        graphic.visible = false;
    }
}
