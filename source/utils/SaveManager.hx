package utils;

import flixel.util.FlxSave;

class SaveManager {
	public static var config:Map<String, Dynamic> = [
        //Name, Value
		"windowColor" => 0xff000084,
		"battleSpeed" => 3,
		"battleMessageSpeed" => 3,
		"battleType" => "active"
	];

	public static var genericData:Map<String, Dynamic> = [
		"partyOrder" => 0,
		"playTime" => 0,
		"leaderHP" => "0/0"
	];

	public static var inventory:Map<Int, Array<Int>> = [
		//starts with nothing. (256 and 257 refer to sort and trash respectively)
		0 => [255, 0],
		1 => [255, 0],
		2 => [255, 0],
		3 => [255, 0],
		4 => [255, 0],
		5 => [255, 0],
		6 => [255, 0],
		7 => [255, 0],
		8 => [255, 0],
		9 => [255, 0],
		10 => [255, 0],
		11 => [255, 0],
		12 => [255, 0],
		13 => [255, 0],
		14 => [255, 0],
		15 => [255, 0],
		16 => [255, 0],
		17 => [255, 0],
		18 => [255, 0],
		19 => [255, 0],
		20 => [255, 0],
		21 => [255, 0],
		22 => [255, 0],
		23 => [255, 0],
		24 => [255, 0],
		25 => [255, 0],
		26 => [255, 0],
		27 => [255, 0],
		28 => [255, 0],
		29 => [255, 0],
		30 => [255, 0],
		31 => [255, 0],
		32 => [255, 0],
		33 => [255, 0],
		34 => [255, 0],
		35 => [255, 0],
		36 => [255, 0],
		37 => [255, 0],
		38 => [255, 0],
		39 => [255, 0],
		40 => [255, 0],
		41 => [255, 0],
		42 => [255, 0],
		43 => [255, 0],
		44 => [255, 0],
		45 => [255, 0],
		46 => [256, 0], //-Sort-
		47 => [257, 0]  //Trash Can
	];

	public static function save(save:Int = 0)
	{
		var save:FlxSave = new FlxSave();
		save.bind('srm$save');
		save.data.config = config;
		save.data.genericData = genericData;
		save.data.inventory = inventory;
		save.flush();
	}

	public static function load(save:Int = 0)
	{
		var save:FlxSave = new FlxSave();
		save.bind('srm$save');

		if (save != null) {
			if(save.data.config != null)
			{
				var savedMap:Map<String, Dynamic> = save.data.config;
				for (name => value in savedMap)
					config.set(name, value);
			}
			if(save.data.genericData != null)
			{
				var savedMap:Map<String, Dynamic> = save.data.genericData;
				for (name => value in savedMap)
					genericData.set(name, value);
			}
			if(save.data.inventory != null)
			{
				var savedMap:Map<Int, Array<Int>> = save.data.inventory;
				for (slot => item in savedMap)
					inventory.set(slot, item);
			}
		}

		if (FlxG.save.data.volume != null) FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null) FlxG.sound.muted = FlxG.save.data.mute;
	}

	public static function exists(save:Int = 0):Bool
	{
		var save:FlxSave = new FlxSave();
		save.bind('srm$save');
		return save == null;
	}

	public static function get(save:Int = 0, key:Dynamic, map:String = 'config'):Dynamic
	{
		var save:FlxSave = new FlxSave();
		save.bind('srm$save');
		switch (map.toLowerCase()) {
			case 'config':
				if (save != null && save.data.config != null) {
					return save.data.config.get(key);
				}
			case 'generic':
				if (save != null && save.data.genericData != null) {
					return save.data.genericData.get(key);
				}
			case 'inventory':
				if (save != null && save.data.inventory != null) {
					return save.data.inventory.get(key);
				}
		}
		return null;
	}
}
