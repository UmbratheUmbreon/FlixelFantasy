package states;

import flixel.input.keyboard.FlxKey;

//the enter thingamabob broke when i optimized how windows are generated but whatever
class WindowTestState extends BasicState {
    var window:TextBox;
    override function create() {
        super.create();
        window = new TextBox(0, 0, Std.int((FlxG.width/8)-1), Std.int((FlxG.height/8)-1), 'This is a test.');
        add(window);
    }

    override function update(elapsed) {
        super.update(elapsed);
        FlxG.watch.addQuick("speed", speed);
    }

    var speed:Float = 1;
    override function keyPress(event:KeyboardEvent) {
        super.keyPress(event);
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
		switch (key)
		{
            case SIX:
                speed -= speed/2;
            case SEVEN:
                speed += speed;
			case E:
                window.enter(speed);
            case Q:
                window.exit(speed);
			default:
				//do nothin
		}
    }
}