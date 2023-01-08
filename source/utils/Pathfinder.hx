package utils;

import flixel.graphics.FlxGraphic;
import openfl.Assets as OpenFlAssets;
import openfl.utils.AssetType;

class Pathfinder {
    inline public static final SOUND_EXT = #if web "mp3" #else "ogg" #end;

    public static inline function image(key:String):FlxGraphic
    {
        final path = 'assets/images/$key.png';
		if (OpenFlAssets.exists(path, IMAGE)) return FlxG.bitmap.add(path, false, path);
		return null;
    }

    public static inline function sound(key:String, ?music:Bool = false)
    {
        final library:String = music ? 'music' : 'sounds';
        return 'assets/$library/$key.$SOUND_EXT'; //mfw i overcomplicate this
    }

    public static inline function exists(key:String, type:AssetType):Bool
    {
        if (OpenFlAssets.exists(key, type)) return true;
        return false;
    }
}