package entities;

import flash.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;

class ActiveEntity extends Entity
{
    public var velocity:Point;
    private var sprite:Spritemap;

    public function new(x:Int, y:Int)
    {
        super(x, y);
        layer = 0;
        velocity = new Point(0, 0);
    }

    public function getScreenCoordinates() {
        var realWidth = HXP.screen.width / HXP.screen.scale;
        var realHeight = HXP.screen.height / HXP.screen.scale;
        return new Point(
            Math.floor(centerX / realWidth),
            Math.floor(centerY / realHeight)
        );
    }

    public function finishInitializing()
    {
        sprite.smooth = false;
        graphic = sprite;
    }

    public override function update()
    {
        super.update();
        unstuck();
    }

    public function getPositionOnScreen()
    {
      return new Point(x % HXP.screen.width, y % HXP.screen.height);
    }

    private function unstuck()
    {
        while(collide('walls', x, y) != null)
        {
          moveBy(0, -10);
        }
    }

    private function isOnGround()
    {
        return collide("walls", x, y + 1) != null;
    }

    private function isOnCeiling()
    {
        return collide("walls", x, y - 1) != null;
    }

    private function isOnWall()
    {
        return (
          collide("walls", x - 1, y) != null ||
          collide("walls", x + 1, y) != null
        );
    }

    private function isOnRightWall()
    {
        return collide("walls", x + 1, y) != null;
    }

    private function isOnLeftWall()
    {
        return collide("walls", x - 1, y) != null;
    }
}
