package utils;

import flixel.graphics.FlxGraphic;
import openfl.Assets as OpenFlAssets;
import openfl.media.Sound;

class Pathfinder {
    public static inline function image(key:String):FlxGraphic
    {
        final path = 'assets/images/$key.png';
		if (OpenFlAssets.exists(path, IMAGE)) return FlxG.bitmap.add(path, false, path);
		return null;
    }

    public static inline function sound(key:String, ?music:Bool = false):Null<Sound>
    {
        final library:String = music ? 'music' : 'sounds';
        return OpenFlAssets.getSound('assets/$library/$key.ogg');
    }
}