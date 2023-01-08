package utils;

import flixel.math.FlxMath;

/**
 * Class containing useful functions to be reused across the different states.
 */
class Util
{
	inline public static function getMemUsage():Array<Any>
	{
		var mem:Float = Math.abs(untyped __global__.__hxcpp_gc_used_bytes() / 1024 / 1024);
		var memDisplayStr:String = ' MB';
		if (mem > 1024) {
			memDisplayStr = ' GB';
			mem /= 1024;
		}
		return [FlxMath.roundDecimal(mem, 2), memDisplayStr];
	}

	public static var resW:Float = 1;
	public static var resH:Float = 1;
	public static inline final baseW:Int = 256;
	public static inline final baseH:Int = 224;

	// finds multiplier for positionings, zoom, etc
	inline public static function resetResolutionScaling(w:Int = 256, h:Int = 224)
	{
		resW = w / baseW;
		resH = h / baseH;
	}

	inline public static function clamp(value:Float, min:Float, max:Float):Float {
		return Math.max(min, Math.min(max, value));
	}
}
