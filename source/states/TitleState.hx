package states;

import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

class TitleState extends BasicState
{
	var bgGraphic:FlxSprite;
	override public function create()
	{
		super.create();

		bgGraphic = new FlxSprite(0,0).loadGraphic(Pathfinder.image('TITLE'));
		bgGraphic.alpha = 0;
		bgGraphic.active = false;
		add(bgGraphic);

		//music crashes lol
		if(FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Pathfinder.sound('prelude', true), 0.4);
			FlxG.sound.music.fadeIn(3, 0.4, 1);
			//FlxG.sound.music.loopTime = 39395;
			//FlxG.sound.music.endTime = 11836;
		}

		new FlxTimer().start(0.05, function(tmr:FlxTimer) {
			if (bgGraphic.alpha < 1) {
				bgGraphic.alpha += 0.1;
				tmr.reset(0.05);
			}
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	override function keyPress(event:KeyboardEvent)
	{
		super.keyPress(event);
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
		switch (key)
		{
			case ENTER | SPACE:
				/*if (!SaveManager.exists(0) && !SaveManager.exists(1) && !SaveManager.exists(2) && !SaveManager.exists(3))
					BasicState.swapState(new states.OverworldState(), FADE);
				else*/
					BasicState.swapState(new states.SaveState(), FADE);
			#if debug
			case S:
				if (FlxG.keys.pressed.SEVEN) {
					SaveManager.save(0);
				} else if (FlxG.keys.pressed.EIGHT) {
					SaveManager.save(1);
				} else if (FlxG.keys.pressed.NINE) {
					SaveManager.save(2);
				} else if (FlxG.keys.pressed.ZERO) {
					SaveManager.save(3);
				}
			case E:
				if (FlxG.keys.pressed.SEVEN) {
					SaveManager.erase(0);
				} else if (FlxG.keys.pressed.EIGHT) {
					SaveManager.erase(1);
				} else if (FlxG.keys.pressed.NINE) {
					SaveManager.erase(2);
				} else if (FlxG.keys.pressed.ZERO) {
					SaveManager.erase(3);
				}
			case F10:
				BasicState.swapState(new states.WindowTestState(), BOX);
			case F11:
				BasicState.swapState(new OverworldState('World Map', FlxPoint.get(42*16, 56*16)), BOX);
			case F9:
				BasicState.swapState(new BattleState(), BOX);
			#end
			default:
				//do nothin
		}
	}
}
