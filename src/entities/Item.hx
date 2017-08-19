package entities;

import com.haxepunk.*;

class Item extends Entity
{
    public function new(x:Int, y:Int) 
    {
        super(x, y);
    }

    public function use(player:Player)
    {
        // Override in child classes
    }
}
