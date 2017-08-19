package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class Spellbook extends Item
{
    public function new(x:Int, y:Int) 
    {
        super(x, y);
        name = "spellbook";
        sprite = new Image("graphics/spellbook.png");
        finishInitializing();
    }

    override public function use(player:Player)
    {
        player.stopToCast();
        HXP.scene.add(new Spell(
            Math.round(player.centerX), Math.round(player.centerY),
            player.getFacing()
        ));
        HUD.echo(Std.string(Math.random()));
    }

    override public function pickUp()
    {
        HUD.echo("YOU FEEL POWER WASH OVER YOU");
        HUD.echo("PRESS X TO CAST A SPELL");
    }
}
