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
    //dont wanna clone the state just for the "saving" part, so...
    //0 = load, 1 = save (maybe 2 will be delete if i ever get around to that)
    public static var mode:Int = 0;

    override function create() {
        super.create();
        for (i in 0...4) {
            var window = new Window(0, 3*8, Std.int((FlxG.width/8)-1), 6);
            windowArray.push(window);
            window.setPalette(0, i);
            FlxTween.tween(window, {y: ((window.height*i)-8*i)+3*8}, 0.8);
        }
        trace ('Save1  ' + (SaveManager.exists(0) ? SaveManager.get(0, "playHours", "generic") + ':' +  SaveManager.get(0, "playMinutes", "generic") + "     " + SaveManager.get(0, "leaderHP", "generic") : "Empty"));
        for (i in 0...4) {
            var text = new WindowText(8, 
                8*3, 
                13, 
                'Save${i+1}  ' + (SaveManager.exists(i) ? SaveManager.get(i, "playHours", "generic") + ':' +  SaveManager.get(i, "playMinutes", "generic") + "     " + SaveManager.get(i, "leaderHP", "generic") : "Empty"), 
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
        //yo can anyone find any reason why all the windows inherit the first save's colour?
        //i cant find any reason why
        //newGameWindow.setPalette(4);
        add(newGameWindow);

        newGameCecil = new SaveCharacter(14*8, 5, 'CECIL');
        newGameCecil.visible = false;
        newGameCecil.active = false;
        add(newGameCecil);

        new FlxTimer().start(0.8, function(tmr:FlxTimer) {
            changeSelection(mode);
        });

        newGameTxt = new WindowText(24, 16, 10, (mode == 0 ? "New Game" : "Save"), newGameWindow);
        newGameTxt.active = false;
        //newGameTxt.setPalette(4);
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
        final min = (mode == 0 ? 0 : 1);
        final max = 4;
        if (curSelected < min) curSelected = max;
        if (curSelected > max) curSelected = min;
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
                for (i in 0...characterArray.length) {
                    characterArray[i].y = windowArray[curSelected-1].y + 8*2;
                    characterArray[i].visible = true;
                    characterArray[i].change(SaveManager.exists(curSelected-1) ? SaveManager.get(curSelected-1, "partyNames", "generic")[i] : 'CECIL');
                    if (windowTxtArray[curSelected-1].text.indexOf("Empty") != -1) {
                        if (i != 0) characterArray[i].visible = false;
                    }
                }
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
            case BACKSPACE | ESCAPE:
                if (mode == 1) {
                    FlxG.sound.play(Pathfinder.sound('menuSelect', false), 1);
                    newGameTxt.changeText("Cancelled.");
                    //insert return to prev state
                }
			default:
				//do nothin
		}
    }

    override function destroy() {
        mode = 0;
        super.destroy();
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
        if (name == '' || name == null) {
            visible = false;
            return;
        }
        loadGraphic(Pathfinder.image('BATTLE/CHARACTERS/$name'), true, 16, 24);
        animation.add('idle', [0], 24);
        animation.play('idle');
    }
}