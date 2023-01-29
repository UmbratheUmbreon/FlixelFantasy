package generics;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

class TextBox extends FlxTypedSpriteGroup<FlxSprite> {
    var sprites:Array<FlxSprite> = [];
    var _width:Int;
    var _height:Int;
    var texts:Array<FlxSprite> = [];
    var _x:Float = 0;
    var _y:Float = 0;
    public var text:String = '';
    var fieldWidth:Int = 1;
    public function new(x:Float, y:Float, __width:Int, __height:Int, _text:String, ?palette:Int = 255) {
        super(x,y,0);
        _width = __width;
        _height = __height;
        text = _text;
        fieldWidth = _width - 2;

        for (i in 0...__width+1) {
            for (j in 0...__height+1) {
                var sprite = new FlxSprite(8*i, 8*j).loadGraphic(Pathfinder.image('MENU/WINDOW'), true, 8, 8);
                var frame:Int = 255;
                //top left
                if (sprite.x == 0 && sprite.y == 0) frame = 16;
                //top looping
                if (sprite.y == 0 && sprite.x > 0 && sprite.x < __width*8) frame = 17;
                //top right
                if (sprite.y == 0 && sprite.x == __width*8) frame = 18;
                //left looping
                if (sprite.x == 0 && sprite.y > 0 && sprite.y < __height*8) frame = 11;
                //right looping
                if (sprite.x == __width*8 && sprite.y > 0 && sprite.y < __height*8) frame = 12;
                //bottom right
                if (sprite.x == __width*8 && sprite.y == __height*8) frame = 15;
                //bottom left
                if (sprite.x == 0 && sprite.y == __height*8) frame = 13;
                //bottom looping
                if (sprite.y == __height*8 && sprite.x > 0 && sprite.x < __width*8) frame = 14;
                switch(frame) {
                    case 255:
                        if (sprite.x == 8 && sprite.y == 8) {
                            sprite.setGraphicSize((__width*8)-8, (__height*8)-8);
                            sprite.updateHitbox();
                        } else {
                            remove(sprite, true);
                            sprite.destroy();
                            continue;
                        }
                    case 14 | 17:
                        if (sprite.x == 8) {
                            sprite.setGraphicSize((__width*8)-8, 8);
                            sprite.updateHitbox();
                        } else {
                            remove(sprite, true);
                            sprite.destroy();
                            continue;
                        }
                    case 11 | 12:
                        if (sprite.y == 8) {
                            sprite.setGraphicSize(8, (__height*8)-8);
                            sprite.updateHitbox();
                        } else {
                            remove(sprite, true);
                            sprite.destroy();
                            continue;
                        }
                }
                sprite.animation.add('anim', [frame], 24);
                sprite.animation.play('anim', true);
                sprites.push(sprite);
                sprite.active = false;
                add(sprite);
            }
        }
        changeText(text);

        setPalette(palette);
    }

    override function update(elapsed) {
        x = Math.round(x);
        y = Math.round(y);
        super.update(elapsed);
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
                for (text in texts) {
                    text.replaceColor(0xff000084, ((save != null && save.data.config != null) ? save.data.config.get("windowColor") : 0xff000037), false);
                }
            case 1:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffa3a3a3, 0xff424242, false);
                    sprite.replaceColor(0xffffffff, 0xff7b7b7b, false);
                }
                for (text in texts) {
                    text.replaceColor(0xffa3a3a3, 0xff424242, false);
                    text.replaceColor(0xffffffff, 0xff7b7b7b, false);
                }
            case 2:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffa3a3a3, 0xff00a500, false);
                    sprite.replaceColor(0xffffffff, 0xffffde00, false);
                }
                for (text in texts) {
                    text.replaceColor(0xffa3a3a3, 0xff00a500, false);
                    text.replaceColor(0xffffffff, 0xffffde00, false);
                }
            case 3:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffa3a3a3, 0xffff3a84, false);
                    sprite.replaceColor(0xffffffff, 0xffff9c5a, false);
                }
                for (text in texts) {
                    text.replaceColor(0xffa3a3a3, 0xffff3a84, false);
                    text.replaceColor(0xffffffff, 0xffff9c5a, false);
                }
            case 4:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff000084, 0xff000037, false);
                }
                for (text in texts) {
                    text.replaceColor(0xff000084, 0xff000037, false);
                }
            case 254:
                for (sprite in sprites) {
                    sprite.replaceColor(((save != null && save.data.config != null) ? save.data.config.get("windowColor") : 0xff000037), 0xff000084, false);
                }
                for (text in texts) {
                    text.replaceColor(((save != null && save.data.config != null) ? save.data.config.get("windowColor") : 0xff000037), 0xff000084, false);
                }
            case 253:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff424242, 0xffa3a3a3, false);
                    sprite.replaceColor(0xff7b7b7b, 0xffffffff, false);
                }
                for (text in texts) {
                    text.replaceColor(0xff424242, 0xffa3a3a3, false);
                    text.replaceColor(0xff7b7b7b, 0xffffffff, false);
                }
            case 252:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff00a500, 0xffa3a3a3, false);
                    sprite.replaceColor(0xffffde00, 0xffffffff, false);
                }
                for (text in texts) {
                    text.replaceColor(0xff00a500, 0xffa3a3a3, false);
                    text.replaceColor(0xffffde00, 0xffffffff, false);
                }
            case 251:
                for (sprite in sprites) {
                    sprite.replaceColor(0xffff3a84, 0xffa3a3a3, false);
                    sprite.replaceColor(0xffff9c5a, 0xffffffff, false);
                }
                for (text in texts) {
                    text.replaceColor(0xffff3a84, 0xffa3a3a3, false);
                    text.replaceColor(0xffff9c5a, 0xffffffff, false);
                }
            case 250:
                for (sprite in sprites) {
                    sprite.replaceColor(0xff000037, 0xff000084, false);
                }
                for (text in texts) {
                    text.replaceColor(0xff000037, 0xff000084, false);
                }
        }
    }

    public function changeText(newText:String) {
        for (text in texts) {
            text.kill();
            texts.remove(text);
            text.destroy();
        }
        
        text = newText;
        var yInc:Int = 0;
        var xInc:Int = 0;
        for (i in 0...newText.length) {
            var text = new FlxSprite((8*xInc) + 8, (16*yInc) + 8).loadGraphic(Pathfinder.image('MENU/WINDOW'), true, 8, 8);
            var frame:Int = WindowText.charMap.get(newText.charAt(i));
            text.animation.add('anim', [frame], 24);
            text.animation.play('anim', true);
            texts.push(text);
            text.active = false;
            add(text);
            xInc++;
            if (xInc == fieldWidth) {
                xInc = 0;
                yInc++;
            }
        }
    }

    public var enterCallback:Void->Void = null;
    public function enter(speed:Float = 1) {
        for (sprite in sprites) {
            if (sprite.y != 0 && sprite.y < (_height-1)*8) {
                final ogScale = sprite.scale.y;
                final ogY = sprite.y;
                sprite.scale.y = 0.0001;
                sprite.y = (-sprite.height/2)+8;
                FlxTween.tween(sprite, {"scale.y": ogScale, y: ogY}, 0.5 / speed);
            } else if (sprite.y != 0 && sprite.y >= (_height-1)*8) {
                final ogY = sprite.y;
                sprite.y = 8;
                FlxTween.tween(sprite, {y: ogY}, 0.5 / speed);
            }
        }
        for (text in texts) {
            final ogScale = text.scale.y;
            final ogY = text.y;
            final delayer = (text.y/8);
            text.scale.y = 0.0001;
            text.y = (-text.height/2)+8;
            FlxTween.tween(text, {"scale.y": ogScale, y: ogY}, 0.5 / speed, {startDelay: (((0.01 / speed)/_height) * delayer)});
        }
        new FlxTimer().start(0.5 / speed, _ -> if(enterCallback != null) enterCallback());
    }

    public var exitCallback:Void->Void = null;
    public function exit(speed:Float = 1) {
        for (sprite in sprites) {
            if (sprite.y != 0 && sprite.y < (_height-1)*8) {
                FlxTween.tween(sprite, {"scale.y": 0.0001, y: (-sprite.height/2)+8}, 0.5 / speed);
            } else if (sprite.y != 0 && sprite.y >= (_height-1)*8) {
                FlxTween.tween(sprite, {y: 8}, 0.5 / speed);
            }
        }
        for (text in texts) {
            final delayer = Math.min(-((text.y/8)-_height), 0); 
            FlxTween.tween(text, {"scale.y": 0.0001, y: ((-text.height/2)+8) * delayer}, 0.5 / speed, {startDelay: (((0.15 / speed)/_height) * delayer)});
        }
        if (exitCallback == null) exitCallback = () -> visible = false;
        new FlxTimer().start(0.5 / speed, _ -> if(exitCallback != null) exitCallback());
    }
}