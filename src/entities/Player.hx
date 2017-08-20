package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;
import com.haxepunk.utils.*;
import entities.*;

class Player extends ActiveEntity
{

    public static inline var SPEED = 1;
    public static inline var ROLL_MULTIPLIER = 2;
    public static inline var ROLL_DURATION = 20;
    public static inline var CAST_DURATION = 20;

    private var facing:String;
    private var rollTimer:GameTimer;
    private var castDurationTimer:GameTimer;

    private var inventory:Array<Item>;
    private var equippedItem:Int;

    public function new(x:Int, y:Int)
    {
        Data.load('manyland');
        var saveX:Int = Data.read('playerX', x);
        var saveY:Int = Data.read('playerY', y);
        super(saveX, saveY);
        layer = 0;
        name = "player";

        sprite = new Spritemap("graphics/player.png", 16, 25);
        sprite.add("down", [0, 1], 6);
        sprite.add("right", [2, 3], 6);
        sprite.add("left", [4, 5], 6);
        sprite.add("up", [6, 7], 6);
        sprite.add("roll_vertical", [8, 9, 10, 11], 6);
        sprite.add("roll_horizontal", [12, 13, 14, 15], 6);
        sprite.add("fall", [16, 17, 18, 19], 3, false);
        sprite.add("death", [20]);
        sprite.add("cast_down", [21]);
        sprite.add("cast_right", [22]);
        sprite.add("cast_left", [23]);
        sprite.add("cast_up", [24]);
        sprite.play("down");
        setHitbox(11, 15, -3, -11);

        facing = "down";
        rollTimer = new GameTimer(ROLL_DURATION);
        castDurationTimer = new GameTimer(CAST_DURATION);

        inventory = [new NoItem()];
        equippedItem = 0;

        finishInitializing();
    }

    public override function update()
    {
        var inControl = !(
            rollTimer.isActive() || castDurationTimer.isActive()
        );
        if(inControl) {
            movement();
            if(Input.pressed(Key.A)) {
                prevItem();
            }
            if(Input.pressed(Key.S)) {
                nextItem();
            }
        }
        moveBy(velocity.x, velocity.y, "walls");
        handleCollisions();
        setCamera();
        animate();
        super.update();
    }

    private function prevItem()
    {
        equippedItem -= 1;
        if(equippedItem < 0) {
            equippedItem = inventory.length - 1;
        }
    }

    private function nextItem()
    {
        equippedItem += 1;
        if(equippedItem >= inventory.length) {
            equippedItem = 0;
        }
    }

    private function movement()
    {
        if(!rollTimer.isActive())
        {
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

            if(Input.pressed(Key.Z)) {
                roll();
            }
        }

        if(Input.pressed(Key.X)) {
            useItem();
        }

    }

    private function roll()
    {
        rollTimer.reset();
        var singleDirectionMultipler:Float = 1;
        if(velocity.x == 0 && velocity.y == 0) {
            setVelocityToFacing();
        }
        if(velocity.x == 0 || velocity.y == 0) {
            singleDirectionMultipler = 1.37;
        }
        velocity.x *= ROLL_MULTIPLIER * singleDirectionMultipler;
        velocity.y *= ROLL_MULTIPLIER * singleDirectionMultipler;
    }

    private function setVelocityToFacing()
    {
        if(facing == "left") {
            velocity.x = -SPEED;
        }
        else if(facing == "right") {
            velocity.x = SPEED;
        }
        else if(facing == "down") {
            velocity.y = SPEED;
        }
        else if(facing == "up") {
            velocity.y = -SPEED;
        }
    }

    private function handleCollisions()
    {
        var _item = collide("item", x, y);
        if(_item != null) {
            if(inventory[0].name == "noitem") {
                inventory.pop();
            }
            var item = cast(_item, Item);
            inventory.push(item);
            equippedItem = inventory.length - 1;
            item.pickUp();
            scene.remove(item);
        }
    }

    private function setCamera()
    {
        var realWidth = HXP.screen.width / HXP.screen.scale;
        var realHeight = HXP.screen.height / HXP.screen.scale;
        scene.camera.x = centerX - realWidth/2;
        scene.camera.x = (
            Math.floor(
                (scene.camera.x + realWidth/2) / realWidth
            ) * realWidth
        );
        scene.camera.y = centerY - realHeight/2;
        scene.camera.y = (
            Math.floor(
                (scene.camera.y + realHeight/2) / realHeight
            ) * realHeight
        );
    }

    private function useItem()
    {
        inventory[equippedItem].use(this);
    }

    public function stopToCast()
    {
        velocity.x = 0;
        velocity.y = 0;
        castDurationTimer.reset();
    }

    public function isShadowVisible()
    {
        return rollTimer.isActive();
    }

    public function getFacing()
    {
        return facing;
    }

    public function getEquippedItem()
    {
        return inventory[equippedItem];
    }

    public function getRollTimer()
    {
        return rollTimer;
    }

    private function animate()
    {
        if(castDurationTimer.isActive()) {
          sprite.play("cast_" + facing);
        }
        else if(rollTimer.isActive()) {
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
