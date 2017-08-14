package entities;

import flash.system.System;
import com.haxepunk.utils.*;
import com.haxepunk.*;
import com.haxepunk.graphics.*;
import entities.*;

class Player extends ActiveEntity
{

  public static inline var SPEED = 1;
  public static inline var ROLL_MULTIPLIER = 2;
  public static inline var ROLL_DURATION = 20;
  public static inline var ROLL_COOLDOWN = 12;

  private var rollTimer:GameTimer;
  private var rollCooldownTimer:GameTimer;
  private var facing:String;

	public function new(x:Int, y:Int)
	{
		super(x, y);

    sprite = new Spritemap("graphics/player.png", 16, 16);
    sprite.add("down", [0, 1], 6);
    sprite.add("right", [2, 3], 6);
    sprite.add("left", [4, 5], 6);
    sprite.add("up", [6, 7], 6);
    sprite.add("roll_vertical", [8, 9, 10, 11], 6);
    sprite.add("roll_horizontal", [12, 13, 14, 15], 6);
    sprite.play("down");
    facing = "down";
    setHitbox(11, 15, -3, -1);

    rollTimer = new GameTimer(ROLL_DURATION);
    rollCooldownTimer = new GameTimer(ROLL_COOLDOWN);

		finishInitializing();
	}

  public override function update()
  {
    if(!rollTimer.isActive())
    {
      if(rollTimer.wasActive()) {
          rollCooldownTimer.reset();
      }
      if(Input.check(Key.LEFT)) {
        velocity.x = -SPEED;
        facing = "left";
      }
      else if(Input.check(Key.RIGHT)) {
        velocity.x = SPEED;
        facing = "right";
      }
      else {
        velocity.x = 0;
      }
      if(Input.check(Key.UP)) {
        velocity.y = -SPEED;
        facing = "up";
      }
      else if(Input.check(Key.DOWN)) {
        velocity.y = SPEED;
        facing = "down";
      }
      else {
        velocity.y = 0;
      }

      if(Input.check(Key.X)) {
        if(!rollCooldownTimer.isActive()) {
          rollTimer.reset();
          var singleDirectionMultipler:Float = 1;
          if(velocity.x == 0 || velocity.y == 0) {
            singleDirectionMultipler = 1.37;
          }
          velocity.x *= ROLL_MULTIPLIER * singleDirectionMultipler;
          velocity.y *= ROLL_MULTIPLIER * singleDirectionMultipler;
        }
      }
    }

    moveBy(velocity.x, velocity.y, "walls");

    if(Input.check(Key.ESCAPE)) {
      System.exit(0);
    }

    animate();

    var realWidth = HXP.screen.width / HXP.screen.scale;
    var realHeight = HXP.screen.height / HXP.screen.scale;
    scene.camera.x = centerX - realWidth/2;
    scene.camera.x = Math.floor((scene.camera.x + realWidth/2) / realWidth) * realWidth;
    scene.camera.y = centerY - realHeight/2;
    scene.camera.y = Math.floor((scene.camera.y + realHeight/2) / realHeight) * realHeight;

    super.update();
  }

  private function animate()
  {
    if(rollTimer.isActive()) {
      if(velocity.y != 0) {
        sprite.play("roll_vertical");
      }
      else {
        sprite.play("roll_horizontal");
      }
    }
    else {
      if(velocity.x != 0 || velocity.y != 0) {
        sprite.play(facing);
      }
      else {
        if(rollTimer.wasActive()) {
          sprite.play(facing);
        }
        sprite.stop();
      }
    }
  }

}
