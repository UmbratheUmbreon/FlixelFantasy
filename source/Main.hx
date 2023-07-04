package;

import cpp.vm.Gc;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	final game = {
		width: 256,
		height: 224,
		initial_state: states.TitleState,
		framerate: 60,
		skip_splash: true,
		fullscreen: false
	}

	public static function main():Void
		Lib.current.addChild(new Main());

	public function new()
	{
		super();

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private inline function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
			removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}

	private inline function setupGame():Void
	{
		addChild(new FlxGame(game.width, game.height, game.initial_state, game.framerate, game.framerate, game.skip_splash, game.fullscreen));

		Gc.enable(true);
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];
		FlxG.save.bind('srm0');
		FlxG.mouse.visible = false;
		FlxG.scaleMode = new flixel.system.scaleModes.PixelPerfectScaleMode();
		flixel.FlxSprite.defaultAntialiasing = false;
		SaveManager.load();
		Gc.run(true);
	}
}
