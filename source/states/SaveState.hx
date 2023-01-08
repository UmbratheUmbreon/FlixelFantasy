package states;

import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class SaveState extends BasicState
{
    var windowArray:Array<Window> = [];
    var windowTxtArray:Array<WindowText> = [];
    var newGameWindow:Window;
    var newGameCecil:SaveCharacter;
    var newGameTxt:WindowText;
    var characterArray:Array<SaveCharacter> = [];
    var curSelected:Int = 0;

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
        newGameWindow.active = false;
        add(newGameWindow);

        newGameCecil = new SaveCharacter(14*8, 5, 'CECIL');
        newGameCecil.visible = false;
        newGameCecil.active = false;
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
        newGameTxt.active = false;
        add(newGameTxt);

        for (i in 0...5) {
            var chara = new SaveCharacter((8*15) + (24*i), 0, 'CECIL');
            chara.visible = false;
            chara.active = false;
            characterArray.push(chara);
            add(chara);
        }
    }

    override function update(elapsed) {
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0) {
        FlxG.sound.play(Pathfinder.sound('menuSelect', false), 1);
        curSelected += change;
        if (curSelected < 0) curSelected = 4;
        if (curSelected > 4) curSelected = 0;
        newGameCecil.visible = false;
        for (character in characterArray) {
            character.visible = false;
        }
        switch (curSelected) {
            case 0:
                newGameCecil.visible = true;
                return;
            default:
                //make them change to the save party when save structure is finalized
                for (character in characterArray) {
                    character.y = windowArray[curSelected-1].y + 8*2;
                }
        }
        for (character in characterArray) {
            character.visible = true;
        }
    }

    override function keyPress(event:KeyboardEvent) {
        super.keyPress(event);
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
		switch (key)
		{
			case DOWN | S:
				changeSelection(1);
            case UP | W:
                changeSelection(-1);
			default:
				//do nothin
		}
    }
}

class SaveCharacter extends FlxSprite
{
    public function new(x:Float, y:Float, name:String) {
        super(x, y);

        change(name);
    }

    public function change(name:String)
    {
        loadGraphic(Pathfinder.image('BATTLE/CHARACTERS/$name'), true, 16, 24);
        animation.add('idle', [0], 24);
        animation.play('idle');
    }
}