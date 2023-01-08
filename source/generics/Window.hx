package generics;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxSave;

class Window extends FlxTypedSpriteGroup<FlxSprite> {
    //no text or symbols, just window!
    var sprites:Array<FlxSprite> = [];
    public function new(x:Float, y:Float, width:Int, height:Int, ?palette:Int = 255) {
        super(x,y,0);

        for (i in 0...width+1) {
            for (j in 0...height+1) {
                var sprite = new FlxSprite(8*i, 8*j).loadGraphic(Pathfinder.image('MENU/WINDOW'), true, 8, 8);
                var frame:Int = 255;
                //top left
                if (sprite.x == 0 && sprite.y == 0) frame = 16;
                //top looping
                if (sprite.y == 0 && sprite.x > 0 && sprite.x < width*8) frame = 17;
                //top right
                if (sprite.y == 0 && sprite.x == width*8) frame = 18;
                //left looping
                if (sprite.x == 0 && sprite.y > 0 && sprite.y < height*8) frame = 11;
                //right looping
                if (sprite.x == width*8 && sprite.y > 0 && sprite.y < height*8) frame = 12;
                //bottom right
                if (sprite.x == width*8 && sprite.y == height*8) frame = 15;
                //bottom left
                if (sprite.x == 0 && sprite.y == height*8) frame = 13;
                //bottom looping
                if (sprite.y == height*8 && sprite.x > 0 && sprite.x < width*8) frame = 14;
                sprite.animation.add('anim', [frame], 24);
                sprite.animation.play('anim', true);
                sprites.push(sprite);
                add(sprite);
            }
        }

        setPalette(palette);
    }

    override function update(elapsed) {
        x = Math.round(x);
        y = Math.round(y);
        /*for (sprite in sprites) {
            sprite.x = Math.round(sprite.x);
            sprite.y = Math.round(sprite.y);
        }*/
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
        }
    }
}