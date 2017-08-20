package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class Shadow extends ActiveEntity
{
  	public function new(x:Int, y:Int)
  	{
      super(x, y);
      layer = 2;
      sprite = new Spritemap("graphics/shadow.png", 16, 25);
      sprite.add("roll", [0, 1, 2, 1, 0], 16, false);
      sprite.play("roll");
      setHitbox(11, 15, -3, -11);
      finishInitializing();
    }

    override public function update()
    {
        var player = cast(HXP.scene.getInstance("player"), Player);
        x = player.x;
        y = player.y;
        visible = player.isShadowVisible();
        if(player.getRollTimer().count == Player.ROLL_DURATION) {
            sprite.play("roll", true);
        }
        super.update();
    }
}
