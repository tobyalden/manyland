package scenes;

import flash.system.System;
import com.haxepunk.*;
import com.haxepunk.utils.*;
import entities.*;

class GameScene extends Scene
{

    public function new()
    {
        super();
    }

    public override function begin()
    {
        var level:Level = new Level("levels/cave.tmx");
        add(level);
        for (entity in level.entities) {
            add(entity);
        }
        add(new HUD());
    }

    public override function update()
    {
        super.update();
        GameTimer.updateAll();
        if(Input.check(Key.ESCAPE)) {
            System.exit(0);
        }
    }

}
