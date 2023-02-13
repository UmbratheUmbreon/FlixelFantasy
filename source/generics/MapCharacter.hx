package generics;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class MapCharacter extends FlxSprite {
    public function new(character:String, x:Float, y:Float) {
        super(x, y);
        loadGraphic(Pathfinder.image('MAP/CHARACTERS/$character'), true, 16, 16);
        resetAnimations();
        animation.play('idleDOWN', true);

        animation.callback = function(name:String, frameNumber:Int, frameIndex:Int) {
            //hehe
            if (name == 'walkDOWN' || name == 'walkUP') {
                if (frameNumber == 0) flipX = false;
                else flipX = true;
            }
        }
    }

    public function move(direction:String) {
        //it was working when i started testing but then stopped working even though i never changed it
        //weird.
        animation.play('walk${direction.toUpperCase()}', true);
        switch(direction.toLowerCase()) {
            case 'left':
                FlxTween.tween(this, {x: this.x - 16}, 0.5/*, {onComplete: _ -> animation.play('idle${direction.toUpperCase()}', true)}*/);
            case 'right':
                FlxTween.tween(this, {x: this.x + 16}, 0.5/*, {onComplete: _ -> animation.play('idle${direction.toUpperCase()}', true)}*/);
            case 'up':
                FlxTween.tween(this, {y: this.y - 16}, 0.5/*, {onComplete: _ -> animation.play('idle${direction.toUpperCase()}', true)}*/);
            case 'down':
                FlxTween.tween(this, {y: this.y + 16}, 0.5/*, {onComplete: _ -> animation.play('idle${direction.toUpperCase()}', true)}*/);
        }
    }

    var changeIndex:Int = 0;
    public function change() {
        var characters = SaveManager.get(0, "partyNames", "generic");
        changeIndex++;
        while (characters[changeIndex] == null || characters[changeIndex].length < 1) {
            changeIndex++;
            if (changeIndex > characters.length-1) changeIndex = 0;
        }
        loadGraphic(Pathfinder.image('MAP/CHARACTERS/${characters[changeIndex]}'), true, 16, 16);
        resetAnimations();
    }

    function resetAnimations() {
        animation.destroyAnimations();
        animation.add('idleDOWN', [0], 12, true);
        animation.add('idleUP', [1], 12, true);
        animation.add('idleLEFT', [2], 12, true);
        animation.add('idleRIGHT', [2], 12, true, true);
        animation.add('nodHead', [0,4], 12, true);
        animation.add('headDown', [4], 12, true);
        animation.add('letsGo', [5], 12, true);
        animation.add('wave', [5,6], 12, true);
        animation.add('down', [7], 12, true);
        animation.add('walkLEFT', [2,3], 12, true);
        animation.add('walkRIGHT', [2,3], 12, true, true);
        animation.add('walkDOWN', [0,0], 12, true);
        animation.add('walkUP', [1,1], 12, true);
    }
}