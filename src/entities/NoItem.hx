package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class NoItem extends Item
{
    // A placeholder item to use when the player's inventory is empty
    public function new(x:Int, y:Int) 
    {
        super(x, y);
        name = "noitem";
        sprite = new Image("graphics/empty.png");
        finishInitializing();
    }
}
