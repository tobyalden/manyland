import com.haxepunk.Engine;
import com.haxepunk.HXP;
import scenes.*;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.scene = new GameScene();
		HXP.screen.scale = 2;
	}

	public static function main() { new Main(); }

}
