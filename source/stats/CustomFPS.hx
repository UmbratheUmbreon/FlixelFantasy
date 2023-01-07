package stats;

import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;

class CustomFPS extends TextField {
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000) {
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(null, 4, color);
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	@:noCompletion
	private override function __enterFrame(deltaTime:Float):Void {
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
			times.shift();

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount)
			text = "FPS: " + currentFPS;

		cacheCount = currentCount;
	}
}

class CustomMEM extends TextField {
	private var memPeak:Float = 0;
	private var memPeakDisplayStr:String = ' MB';

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000) {
		super();

		x = inX;
		y = inY;

		selectable = false;

		defaultTextFormat = new TextFormat(null, 4, inCol);

		text = "";

		addEventListener(Event.ENTER_FRAME, onEnter);

		width = 100;
		height = 23;
	}

	private function onEnter(_) {
		final arr:Array<Any> = Util.getMemUsage();
		final mem:Float = cast arr[0];
		final memDisplayStr:String = cast arr[1];
		switch (memPeakDisplayStr) {
			case " MB":
				switch (memDisplayStr) {
					case " MB":
						if (mem > memPeak) memPeak = mem;
					case " GB":
						memPeak = mem;
						memPeakDisplayStr = " GB";
				}
			case " GB":
				switch (memDisplayStr) {
					case " GB":
						if (mem > memPeak) memPeak = mem;
				}
		}
		if (visible)
			text = "MEM: " + mem + memDisplayStr + " | " + memPeak + memPeakDisplayStr;
	}
}
