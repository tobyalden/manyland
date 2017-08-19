package entities;

import com.haxepunk.*;

class Spellbook extends Item
{
    public function new(x:Int, y:Int) 
    {
        super(x, y);
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
}
