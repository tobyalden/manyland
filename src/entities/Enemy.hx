package entities;

import flash.system.System;
import com.haxepunk.utils.*;
import com.haxepunk.*;
import com.haxepunk.graphics.*;
import entities.*;

class Enemy extends ActiveEntity
{

    public static inline var SPEED = 1;
    public static inline var WANDER_DURATION = 12;

    private var wanderTimer:GameTimer;
    private var facing:Int;

    public function new(x:Int, y:Int)
    {
        super(x, y);

        sprite = new Spritemap("graphics/player.png", 16, 16);
        sprite.add("wander_vertical", [8, 9, 10, 11], 6);
        sprite.add("wander_horizontal", [12, 13, 14, 15], 6);
        sprite.play("wander_vertical");
        facing = 0;
        setHitbox(11, 15, -3, -1);

        wanderTimer = new GameTimer(WANDER_DURATION);

        finishInitializing();
    }

    public override function update()
    {
        if(!wanderTimer.isActive()) {
            pickRandomFacing();
            wanderTimer.reset();
        }

        moveBy(velocity.x, velocity.y, "walls");


        animate();

        super.update();
    }

    private function pickRandomFacing()
    {
        facing = HXP.rand(6);

        if(facing == 0) {
            velocity.x = -SPEED;
        }
        else if(facing == 1) {
            velocity.x = SPEED;
        }
        else if(facing == 2) {
            velocity.y = SPEED;
        }
        else if(facing == 3) {
            velocity.y = -SPEED;
        }
        else if(facing == 4) {
            velocity.y = 0;
        }
        else if(facing == 5) {
            velocity.x = 0;
        }
    }

    private function animate()
    {
        if(facing % 2 == 0) {
            sprite.play("wander_vertical");
        }
        else {
            sprite.play("wander_horizontal");
        }
    }

}
