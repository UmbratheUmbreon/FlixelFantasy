package generics;

import flixel.FlxSprite;

class BattleCharacter extends FlxSprite {
    public var character:String;
    public function new(character:String, x:Float, y:Float)
    {
        super(x, y);
        this.character = character;
        loadGraphic(Pathfinder.image('BATTLE/CHARACTERS/$character'), true, 16, 24);
        animation.add('idle', [11], 12, true);
        animation.add('walk', [11, 13], 12, true);
        animation.add('attackR', [4, 13], 12, true);
        animation.add('attackL', [6, 5], 12, true);
        animation.add('parry', [12], 12, true);
        animation.add('chant', [9, 10], 12, true);
        animation.add('cast', [8], 12, true);
        animation.add('cheer', [11, 8], 12, true);
        animation.add('hit', [7], 12, true);
        animation.add('injured', [3], 12, true);
        animation.play('idle', true);
    }
}