package states;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class TitleState extends BasicState
{
	var bgGraphic:FlxSprite;
	override public function create()
	{
		super.create();

		bgGraphic = new FlxSprite(0,0).loadGraphic(Pathfinder.image('TITLE'));
		bgGraphic.alpha = 0;
		add(bgGraphic);

		//music crashes lol
		/*FlxG.sound.music.loadEmbedded(Pathfinder.sound('prelude', true));
		FlxG.sound.music.fadeIn(3, 0.4, 1);
		FlxG.sound.music.loopTime = 39395;
		FlxG.sound.music.endTime = 11836;*/

		new FlxTimer().start(0.2, function(tmr:FlxTimer) {
			if (bgGraphic.alpha < 1) {
				bgGraphic.alpha += 0.1;
				tmr.reset(0.2);
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
		switch (event.keyCode)
		{
			default:
				FlxG.switchState(new states.SaveState());
		}
	}
}
