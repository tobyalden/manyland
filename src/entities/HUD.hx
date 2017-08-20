package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class HUD extends Entity
{
    static private var hud:HUD;

    private var equipped:Spritemap;
    private var equippedBar:Image;
    private var text:Text;
    private var textBar:Image;
    private var allGraphics:Graphiclist;

    private var currentMessage:String;
    private var prevMessage:String;

    public function new()
    {
        super(0, 0);
        layer = -10;

        hud = this;

        equipped = new Spritemap("graphics/equipment.png", 16, 16);
        equipped.smooth = false;
        equipped.add("noitem", [0]);
        equipped.add("spellbook", [1]);
        equipped.add("heal", [2]);
        equipped.play("noitem");

        equippedBar = Image.createRect(18, 18, 0x072103);
        equippedBar.smooth = false;
        equippedBar.alpha = 0.5;

        text = new Text();
        text.smooth = false;
        text.addStyle("default", {color: 0xDAEFD7, size: 8});
        text.setTextProperty('richText', true);

        textBar = Image.createRect(1, 1, 0x072103);
        textBar.smooth = false;
        textBar.alpha = 0.5;
        textBar.scaleX = 138;
        currentMessage = "YOU SPILL OUT GASPING";
        prevMessage = "";

        allGraphics = new Graphiclist([textBar, text, equippedBar, equipped]);
        graphic = allGraphics;
    }

    static public function echo(message:String)
    {
        hud.prevMessage = hud.currentMessage;
        hud.currentMessage = message;
    }

    public function clearMessages()
    {
        prevMessage = "";
        currentMessage = "";
    }

    override public function update()
    {
        x = scene.camera.x;
        y = scene.camera.y;

        var player = cast(scene.getInstance("player"), Player);
        equipped.play(player.getEquippedItem().name);
        equipped.x = 5;
        equipped.y = 5;
        equippedBar.x = equipped.x - 1;
        equippedBar.y = equipped.y - 1;

        text.x = 10;
        text.y = HXP.height - 20;
        text.richText = (
            "<default>" + prevMessage + "\n" + currentMessage + "</default>"
        );

        textBar.x = text.x;
        if(prevMessage == "") {
            textBar.y = text.y + text.textHeight/2 - 3;
        }
        else {
            textBar.y = text.y;
        }
        textBar.scaleY = text.textHeight;

        super.update();
    }
}
