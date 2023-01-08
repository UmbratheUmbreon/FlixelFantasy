package states;

import flixel.tweens.FlxTween;

class SaveState extends BasicState {
    var windowArray:Array<Window> = [];
    var newGameWindow:Window;
    override function create() {
        super.create();
        for (i in 0...4) {
            var window = new Window(0, 0, Std.int((FlxG.width/8)-1), 6, 0);
            windowArray.push(window);
            window.ID = i;
            FlxTween.tween(window, {y: ((window.height*i)-8*i)+3*8}, 1);
        }
        var count = windowArray.length-1;
        for (i in 0...windowArray.length) {
            add(windowArray[count--]);
        }
        newGameWindow = new Window(0,0, 20, 4, 0);
        add(newGameWindow);
    }

    override function update(elapsed) {
        super.update(elapsed);
    }
}