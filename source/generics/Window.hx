package generics;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Window extends FlxSpriteGroup {
    //no text or symbols, just window!
    var sprites:Array<FlxSprite> = [];
    public function new(x:Float, y:Float, width:Int, height:Int, palette:Int) {
        super(x,y,0);

        for (i in 0...width+1) {
            for (j in 0...height+1) {
                var sprite = new FlxSprite(8*i, 8*j).loadGraphic(Pathfinder.image('MENU/WINDOW'), true, 8, 8);
                var frame:Int = 21;
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
    }
}