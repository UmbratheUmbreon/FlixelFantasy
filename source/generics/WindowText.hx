package generics;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxSave;

class WindowText extends FlxTypedSpriteGroup<FlxSprite> {
    //just the text and symbols!
    public static var charMap:Map<String, Int> = [
        " " => 255,
        "A" => 66,
        "B" => 67,
        "C" => 68,
        "D" => 69,
        "E" => 70,
        "F" => 71,
        "G" => 72,
        "H" => 73,
        "I" => 74,
        "J" => 75,
        "K" => 76,
        "L" => 77,
        "M" => 78,
        "N" => 79,
        "O" => 80,
        "P" => 81,
        "Q" => 82,
        "R" => 83,
        "S" => 84,
        "T" => 85,
        "U" => 86,
        "V" => 87,
        "W" => 88,
        "X" => 89,
        "Y" => 90,
        "Z" => 91,
        "a" => 92,
        "b" => 93,
        "c" => 94,
        "d" => 95,
        "e" => 96,
        "f" => 97,
        "g" => 98,
        "h" => 99,
        "i" => 100,
        "j" => 101,
        "k" => 102,
        "l" => 103,
        "m" => 104,
        "n" => 105,
        "o" => 106,
        "p" => 107,
        "q" => 108,
        "r" => 109,
        "s" => 110,
        "t" => 111,
        "u" => 112,
        "v" => 113,
        "w" => 114,
        "x" => 115,
        "y" => 116,
        "z" => 117,
        "0" => 128,
        "1" => 129,
        "2" => 130,
        "3" => 131,
        "4" => 132,
        "5" => 133,
        "6" => 134,
        "7" => 135,
        "8" => 136,
        "9" => 137,
        "'" => 192,
        "." => 193,
        "-" => 194,
        "_" => 195,
        "!" => 196,
        "?" => 197,
        "%" => 198,
        "/" => 199,
        ":" => 200,
        "," => 201,
        "{" => 119,
        "}" => 120,
        "[" => 202
    ];
    var sprites:Array<FlxSprite> = [];
    var _x:Float = 0;
    var _y:Float = 0;
    var window:Window;
    public var text:String = '';
    var fieldWidth:Int = 1;
    public function new(x:Float, y:Float, _fieldWidth:Int, _text:String, _window:Window, ?palette:Int = 255) {
        super(x,y,0);
        _x = x;
        _y = y;
        window = _window;
        text = _text;
        fieldWidth = _fieldWidth;

        var yInc:Int = 0;
        var xInc:Int = 0;
        for (i in 0..._text.length) {
            var sprite = new FlxSprite(8*xInc, 16*yInc).loadGraphic(Pathfinder.image('MENU/WINDOW'), true, 8, 8);
            var frame:Int = charMap.get(_text.charAt(i));
            if (frame == 255) {
                remove(sprite, true);
                sprite.destroy();
                xInc++;
                if (xInc == _fieldWidth) {
                    xInc = 0;
                    yInc++;
                }
                continue;
            }
            sprite.animation.add('anim', [frame], 24);
            sprite.animation.play('anim', true);
            sprites.push(sprite);
            sprite.active = false;
            add(sprite);
            xInc++;
            if (xInc == _fieldWidth) {
                xInc = 0;
                yInc++;
            }
        }

        setPalette(palette);
    }

    override function update(elapsed) {
        super.update(elapsed);

        x = Math.round(window.x + _x);
        y = Math.round(window.y + _y);
    }

    public function setPalette(palette:Int, ?_save:Int = 0) {
        if (palette == 255) return;
        var save:FlxSave = new FlxSave();
		save.bind('srm$_save');
        switch (palette) {
            case 0:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff000084, ((save != null && save.data.config != null) ? save.data.config.get("windowColor") : 0xff000037), false);
                }
            case 1:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffa3a3a3, 0xff424242, false);
                    sprite.replaceColor(0xffffffff, 0xff7b7b7b, false);
                }
            case 2:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffa3a3a3, 0xff00a500, false);
                    sprite.replaceColor(0xffffffff, 0xffffde00, false);
                }
            case 3:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffa3a3a3, 0xffff3a84, false);
                    sprite.replaceColor(0xffffffff, 0xffff9c5a, false);
                }
            case 4:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff000084, 0xff000037, false);
                }
            case 254:
                for (sprite in sprites) {
                    sprite.replaceColor(((save != null && save.data.config != null) ? save.data.config.get("windowColor") : 0xff000037), 0xff000084, false);
                }
            case 253:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff424242, 0xffa3a3a3, false);
                    sprite.replaceColor(0xff7b7b7b, 0xffffffff, false);
                }
            case 252:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff00a500, 0xffa3a3a3, false);
                    sprite.replaceColor(0xffffde00, 0xffffffff, false);
                }
            case 251:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffff3a84, 0xffa3a3a3, false);
                    sprite.replaceColor(0xffff9c5a, 0xffffffff, false);
                }
            case 250:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff000037, 0xff000084, false);
                }
        }
    }

    public function changeText(newText:String) {
        for (sprite in sprites) {
            sprite.kill();
            sprites.remove(sprite);
            sprite.destroy();
        }
        
        text = newText;
        var yInc:Int = 0;
        var xInc:Int = 0;
        for (i in 0...newText.length) {
            var sprite = new FlxSprite(8*xInc, 16*yInc).loadGraphic(Pathfinder.image('MENU/WINDOW'), true, 8, 8);
            var frame:Int = charMap.get(newText.charAt(i));
            sprite.animation.add('anim', [frame], 24);
            sprite.animation.play('anim', true);
            sprites.push(sprite);
            sprite.active = false;
            add(sprite);
            xInc++;
            if (xInc == fieldWidth) {
                xInc = 0;
                yInc++;
            }
        }
    }
}