package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class Heal extends Item
{
    public function new(x:Int, y:Int) 
    {
        super(x, y);
        name = "heal";
        sprite = new Image("graphics/heal.png");
        finishInitializing();
    }

    override public function use(player:Player)
    {
        player.stopToCast();
        HUD.echo("YOU FEEL BETTER");
    }

    override public function pickUp()
    {
        HUD.echo("PRESS X TO HEAL");
    }
}
