package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import stats.CustomFPS;
#if debug
import stats.CustomFPS.CustomMEM;
#end

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

		fpsCounter = new CustomFPS(2, 3, 0xFFFFFF);
		addChild(fpsCounter);

		#if debug
		ramCount = new CustomMEM(2, 6, 0xffffff);
		addChild(ramCount);
		#end

		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];
		FlxG.save.bind('srm1');
		FlxG.mouse.visible = false;
	}

	public static var fpsCounter:CustomFPS;
	public static var ramCount:CustomMEM;

	inline public static function toggleFPS(fpsEnabled:Bool):Void
		fpsCounter.visible = fpsEnabled;

	inline public static function toggleMEM(memEnabled:Bool):Void
		ramCount.visible = memEnabled;
}
