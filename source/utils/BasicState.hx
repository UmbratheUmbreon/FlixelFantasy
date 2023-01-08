package utils;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

enum TransitionType {
    FADE;
    BLUR;
    BOX;
}

class BasicState extends FlxState
{
    private static var storedType:TransitionType = FADE;
    override function create() {
        super.create();

        openSubState(new TransitionSubstate(0.4, false, storedType));
        storedType = FADE;

        FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
        FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
    }

    override function update(elapsed) {
        super.update(elapsed);
    }

    override function destroy() {
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
        FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
        super.destroy();
    }

    public static function swapState(state:FlxState, type:TransitionType) {
        storedType = type;
        switch (type) {
            case FADE:
                FlxG.state.openSubState(new TransitionSubstate(0.4, true, type));
                TransitionSubstate.finishCallback = function() {
                    FlxG.switchState(state);
                }
            case BLUR:
                FlxG.switchState(state);
            default:
                FlxG.state.openSubState(new TransitionSubstate(0.4, true, type));
                TransitionSubstate.finishCallback = function() {
                    FlxG.switchState(state);
                }
        }
    }

    public function keyPress(event:KeyboardEvent):Void
    {
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
        if (key == -1) return;
    }

    public function keyRelease(event:KeyboardEvent):Void
    {
		var eventKey:FlxKey = event.keyCode;
		var key:Int = keyInt(eventKey);
		if (key == -1) return;
    }

    public function keyInt(key:FlxKey):Int
	{
		if(key != NONE) return key;
		return -1;
	}
}

//note to self, does not appear to work
class TransitionSubstate extends FlxSubState {
	public static var finishCallback:Void->Void;
	var isTransIn:Bool = false;

	public function new(duration:Float, isTransIn:Bool, type:TransitionType) {
		super();

		this.isTransIn = isTransIn;
        switch (type) {
            case FADE:
                var sprite = new FlxSprite(0,0).makeGraphic(256, 224, 0xff000000);
                add(sprite);
                sprite.alpha = (isTransIn ? 0 : 1);
                new FlxTimer().start(duration/10, function(tmr:FlxTimer) {
                    if (isTransIn) {
                        if (sprite.alpha < 1) {
                            sprite.alpha += 0.1;
                            tmr.reset(duration/10);
                        }
                        sprite.kill();
                        close();
                    } else {
                        if (sprite.alpha > 0) {
                            sprite.alpha -= 0.1;
                            tmr.reset(duration/10);
                        }
                        sprite.kill();
                        close();
                    }
                });
            case BLUR:
                //this one is probably the most complex so ill save it for later
                close();
            default:
                if (isTransIn) {
                    var top = new FlxSprite(0,-112).makeGraphic(256, 112, 0xff000000);
                    add(top);
                    var left = new FlxSprite(-128,0).makeGraphic(128, 224, 0xff000000);
                    add(left);
                    var right = new FlxSprite(256,0).makeGraphic(128, 224, 0xff000000);
                    add(right);
                    var bottom = new FlxSprite(0,224).makeGraphic(256, 112, 0xff000000);
                    add(bottom);
                    FlxTween.tween(top, {y: 0}, duration, {
                        onComplete: function(twn:FlxTween)
                        {
                            top.kill();
                            left.kill();
                            right.kill();
                            bottom.kill();
                            close();
                        }
                    });
                    FlxTween.tween(left, {x: 0}, duration);
                    FlxTween.tween(right, {x: 128}, duration);
                    FlxTween.tween(bottom, {y: 112}, duration);
                } else {
                    var top = new FlxSprite(0,0).makeGraphic(256, 112, 0xff000000);
                    add(top);
                    var left = new FlxSprite(0,0).makeGraphic(128, 224, 0xff000000);
                    add(left);
                    var right = new FlxSprite(128,0).makeGraphic(128, 224, 0xff000000);
                    add(right);
                    var bottom = new FlxSprite(0,112).makeGraphic(256, 112, 0xff000000);
                    add(bottom);
                    FlxTween.tween(top, {y: -112}, duration, {
                        onComplete: function(twn:FlxTween)
                        {
                            top.kill();
                            left.kill();
                            right.kill();
                            bottom.kill();
                            close();
                        }
                    });
                    FlxTween.tween(left, {x: -128}, duration);
                    FlxTween.tween(right, {x: 256}, duration);
                    FlxTween.tween(bottom, {y: 224}, duration);
                }
        }
	}

	override function destroy() {
        if (finishCallback != null) {
            finishCallback();
            finishCallback = null;
        }
		super.destroy();
	}
}