package utils;

import flixel.FlxState;
import flixel.input.keyboard.FlxKey;

class BasicState extends FlxState
{
    override function create() {
        super.create();

        FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
        FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
    }

    override function update(elapsed) {
        super.update(elapsed);
    }

    override function destroy() {
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
        FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
        super.destroy();
    }

    public function keyPress(event:KeyboardEvent):Void
    {
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
        if (key == -1) return;
    }

    public function keyRelease(event:KeyboardEvent):Void
    {
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
		if (key == -1) return;
    }

    public function keyInt(key:FlxKey):Int
	{
		if(key != NONE) return key;
		return -1;
	}
}