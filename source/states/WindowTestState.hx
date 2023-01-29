package states;

import flixel.input.keyboard.FlxKey;

//the enter thingamabob broke when i optimized how windows are generated but whatever
class WindowTestState extends BasicState {
    var window:TextBox;
    override function create() {
        super.create();
        window = new TextBox(0, 0, Std.int((FlxG.width/8)-1), Std.int((FlxG.height/8)-1), "My name is Yoshikage Kira. I'm 33 years old. My house is in the northeast section of Morioh, where all the villas are, and I am not married. I work as an employee for the Kame Yu department stores, and I get home every day by 8 PM at the latest. I don't smoke, but I occasionally drink. I'm in bed by 11 PM, and make sure I get eight hours of sleep, no matter what. After havin");
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