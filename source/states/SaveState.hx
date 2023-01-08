package states;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class SaveState extends BasicState
{
    var windowArray:Array<Window> = [];
    var windowTxtArray:Array<WindowText> = [];
    var newGameWindow:Window;
    var newGameCecil:SaveCharacter;
    var newGameTxt:WindowText;
    override function create() {
        super.create();
        for (i in 0...4) {
            var window = new Window(0, 0, Std.int((FlxG.width/8)-1), 6);
            windowArray.push(window);
            window.setPalette(0, i);
            FlxTween.tween(window, {y: ((window.height*i)-8*i)+3*8}, 0.8);
        }
        for (i in 0...4) {
            var text = new WindowText(8, 
                8*3, 
                13, 
                'Save${i+1}  ' + (SaveManager.exists(i) ? SaveManager.get(i, "playTime", "generic") + "     " + SaveManager.get(i, "leaderHP", "generic") : "Empty"), 
                windowArray[i]);
            windowTxtArray.push(text);
            text.setPalette(0, i);
        }
        var count = windowArray.length;
        for (i in 0...windowArray.length) {
            count--;
            add(windowArray[count]);
            add(windowTxtArray[count]);
        }

        newGameWindow = new Window(0,0, 18, 3);
        add(newGameWindow);

        newGameCecil = new SaveCharacter(14*8, 5, 'CECIL');
        newGameCecil.visible = false;
        add(newGameCecil);

        new FlxTimer().start(0.8, function(tmr:FlxTimer) {
            newGameCecil.visible = true;
            for (window in windowArray) {
                window.active = false;
            }
            for (text in windowTxtArray) {
                text.active = false;
            }
        });

        newGameTxt = new WindowText(24, 16, 8, "New Game", newGameWindow);
        add(newGameTxt);
    }

    override function update(elapsed) {
        super.update(elapsed);
    }
}

class SaveCharacter extends FlxSprite
{
    public function new(x:Float, y:Float, name:String) {
        super(x, y);

        loadGraphic(Pathfinder.image('BATTLE/CHARACTERS/$name'), true, 16, 24);
        animation.add('idle', [0], 24);
        animation.play('idle');
    }
}