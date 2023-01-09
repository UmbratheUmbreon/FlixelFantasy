package states;

import flixel.input.keyboard.FlxKey;

class WindowTestState extends BasicState {
    var window:Window;
    var windowTxt:WindowText;
    override function create() {
        super.create();
        window = new Window(0, 0, Std.int((FlxG.width/8)-1), Std.int((FlxG.height/8)-1));
        add(window);
        windowTxt = new WindowText(8, 8, 20, 'This is a test.', window);
        add(windowTxt);
    }

    override function update(elapsed) {
        super.update(elapsed);
        FlxG.watch.addQuick("speed", speed);
    }

    var speed:Int = 1;
    override function keyPress(event:KeyboardEvent) {
        super.keyPress(event);
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
		switch (key)
		{
            case NINE:
                if (speed > 1) speed -= 1;
            case ZERO:
                speed += 1;
			case E:
                window.enter(speed);
			default:
				//do nothin
		}
    }
}