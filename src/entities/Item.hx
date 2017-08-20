package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class Item extends Entity
{

    private var sprite:Image;

    public static function getFromName(name:String):Item
    {
        if(name == "noitem") {
            return new NoItem(0, 0);
        }
        if(name == "spellbook") {
            return new Spellbook(0, 0);
        }
        if(name == "heal") {
            return new Heal(0, 0);
        }
        return null;
    }

    public function new(x:Int, y:Int) 
    {
        super(x, y);
        type = "item";
        setHitbox(16, 16);
    }

    override public function update()
    {
        var player = cast(scene.getInstance("player"), Player);
        if(player.getInventoryAsString().indexOf(name) != -1) {
            scene.remove(this);
        }
        super.update();
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

    public function pickUp()
    {
        // Override in child classes
    }

    public function getSprite()
    {
        return sprite;
    }
}
