package entities;

import com.haxepunk.*;
import com.haxepunk.graphics.*;

class HUD extends Entity
{
    static private var hud:HUD;

    private var text:Text;
    private var textBar:Image;
    //private var textDropshadow:Text;
    //private var textDropshadow2:Text;
    //private var textDropshadow3:Text;
    //private var textDropshadow4:Text;
    private var allGraphics:Graphiclist;

    private var currentMessage:String;
    private var prevMessage:String;

    public function new()
    {
        super(0, 0);
        layer = -10;

        hud = this;

        text = new Text();
        text.addStyle("default", {color: 0xDAEFD7, size: 8});
        text.setTextProperty('richText', true);
        text.smooth = false;

        textBar = Image.createRect(1, 1, 0x072103);
        textBar.alpha = 0.5;
        textBar.scaleX = 100;

        //textDropshadow = new Text();
        //textDropshadow.addStyle(
            //"default", {color: 0x072103, size: 8}
        //);
        //textDropshadow.setTextProperty('richText', true);
        //textDropshadow.smooth = false;
        //textDropshadow.x = text.x + 1;

        //textDropshadow2 = new Text();
        //textDropshadow2.addStyle(
            //"default", {color: 0x072103, size: 8}
        //);
        //textDropshadow2.setTextProperty('richText', true);
        //textDropshadow2.smooth = false;
        //textDropshadow2.x = text.x - 1;

        //textDropshadow3 = new Text();
        //textDropshadow3.addStyle(
            //"default", {color: 0x072103, size: 8}
        //);
        //textDropshadow3.setTextProperty('richText', true);
        //textDropshadow3.smooth = false;
        //textDropshadow3.y = text.y + 1;

        //textDropshadow4 = new Text();
        //textDropshadow4.addStyle(
            //"default", {color: 0x072103, size: 8}
        //);
        //textDropshadow4.setTextProperty('richText', true);
        //textDropshadow4.smooth = false;
        //textDropshadow4.y = text.y - 1;

        currentMessage = "YOU SPILL OUT GASPING";
        prevMessage = "";

        allGraphics = new Graphiclist([
            //textDropshadow4, textDropshadow3, textDropshadow2, textDropshadow,
            textBar, text
        ]);
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
        var player = scene.getInstance("player");
        x = scene.camera.x + 10;
        y = scene.camera.y + HXP.height - 20;
        text.richText = (
            "<default>" + prevMessage + "\n" + currentMessage + "</default>"
        );
        textBar.scaleY = text.textHeight;
        if(prevMessage == "") {
            textBar.y = text.textHeight/2 - 3;
        }
        else {
            textBar.y = 0;
        }
        //textDropshadow.richText = (
            //"<default>" + prevMessage + "\n" + currentMessage + "</default>"
        //);
        //textDropshadow2.richText = (
            //"<default>" + prevMessage + "\n" + currentMessage + "</default>"
        //);
        //textDropshadow3.richText = (
            //"<default>" + prevMessage + "\n" + currentMessage + "</default>"
        //);
        //textDropshadow4.richText = (
            //"<default>" + prevMessage + "\n" + currentMessage + "</default>"
        //);
        super.update();
    }
}
