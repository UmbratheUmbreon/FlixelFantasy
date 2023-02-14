package states;

import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.effects.FlxSkewedSprite;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxDirectionFlags;

class OverworldState extends BasicState {
    var level = 'World Map';
    var tilemapGfx = 'OVERWORLD';
    var tilemap:FlxTilemap;
    var startingPos:FlxPoint;
    var player:MapCharacter;
    var cameraPos:FlxPoint;
    public function new(level:String = 'World Map', startingPos:FlxPoint) {
        this.level = level;
        this.tilemapGfx = (level == 'World Map' ? 'OVERWORLD' : level.toUpperCase());
        this.startingPos = startingPos;
        super();
    }
    
    override function create() {
        super.create();

        var loader = new FlxOgmo3Loader('assets/ogmo/Flixel.ogmo', 'assets/ogmo/maps/$level.json');
        tilemap = loader.loadTilemap('assets/images/MAP/$tilemapGfx.png', 'Tiles');
        tilemap.follow();
        switch (tilemapGfx.toLowerCase()) {
            case 'overworld':
                //cannot move at all
                /*for (i in [0, 2, 3, 4, 5, 6, 7, 9, 11, 12, 15, 16, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 31, 32, 39, 41, 48, 56, 57, 58, 65, 72, 73, 74, 78, 79, 88,
                    89, 90, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124])
                    tilemap.setTileProperties(i, FlxDirectionFlags.fromBools(false, false, false, false));
                //can always move
                for (i in [1, 13, 14, 17, 22, 29, 30, 33, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 59, 60, 61, 62, 63, 64, 66, 67, 68, 69, 70, 71, 75, 76, 77,
                    80, 81, 82, 83, 84, 85, 86, 87, 91, 92, 93, 107, 108, 109, 125, 126, 127])
                    tilemap.setTileProperties(i, FlxDirectionFlags.fromBools(true, true, true, true));
                //can only move up and left
                tilemap.setTileProperties(8, FlxDirectionFlags.fromBools(true, false, true, false));
                //can only move up and right
                tilemap.setTileProperties(10, FlxDirectionFlags.fromBools(false, true, true, false));
                //can only move down and left
                for (i in [34, 40])
                    tilemap.setTileProperties(i, FlxDirectionFlags.fromBools(true, false, false, true));
                //can only move down and right
                for (i in [36, 42])
                    tilemap.setTileProperties(i, FlxDirectionFlags.fromBools(false, true, false, true));*/
        }
        add(tilemap);

        player = new MapCharacter('CECIL', startingPos.x, startingPos.y);
        player.moveCallback = () -> if (bufferedInputs.length > 0) player.move(bufferedInputs.splice(0, 1)[0]);
        add(player);

        cameraPos = FlxPoint.get(player.x + player.width/2, player.y + player.height/2);

        FlxG.camera.focusOn(cameraPos);

        FlxG.sound.playMusic(Pathfinder.sound('${tilemapGfx.toLowerCase()}', true), 0.4);
    }

    override function update(elapsed) {
        cameraPos = player.getMidpoint(cameraPos);
        FlxG.camera.focusOn(cameraPos);
        #if debug
        if (player.animation.curAnim != null) FlxG.watch.addQuick('playerAnim', player.animation.curAnim.name);
        FlxG.watch.addQuick('zoom', FlxG.camera.zoom);
        #end
    }

    var bufferedInputs:Array<String> = [];
    override function keyPress(event:KeyboardEvent) {
        super.keyPress(event);
		var eventKey:FlxKey = event.keyCode;
		switch (eventKey)
		{
			case DOWN | S:
                //check if currently moving, if not, move, otherwise push a new buffered input to be performed at the next valid time
                if (player.movementTween == null) player.move('DOWN');
                else (bufferedInputs.push('DOWN'));
            case UP | W:
                if (player.movementTween == null) player.move('UP');
                else (bufferedInputs.push('UP'));
            case LEFT | A:
                if (player.movementTween == null) player.move('LEFT');
                else (bufferedInputs.push('LEFT'));
            case RIGHT | D:
                if (player.movementTween == null) player.move('RIGHT');
                else (bufferedInputs.push('RIGHT'));
            case THREE:
                player.change();
            #if debug
            case FOUR:
                FlxG.camera.zoom /= 2;
            case FIVE:
                FlxG.camera.zoom *= 2;
            case SIX:
                FlxG.camera.zoom = 0.0625;
            case SEVEN:
                FlxG.camera.zoom = 1;
            #end
			default:
				//do nothin
		}
    }

    override function keyRelease(event:KeyboardEvent) {
        super.keyRelease(event);
		var eventKey:FlxKey = event.keyCode;
        switch (eventKey)
		{
            //stop lingering?
			case DOWN | S:
                while (bufferedInputs.contains('DOWN')) bufferedInputs.remove('DOWN');
            case UP | W:
                while (bufferedInputs.contains('UP')) bufferedInputs.remove('UP');
            case LEFT | A:
                while (bufferedInputs.contains('LEFT')) bufferedInputs.remove('LEFT');
            case RIGHT | D:
                while (bufferedInputs.contains('RIGHT')) bufferedInputs.remove('RIGHT');
			default:
				//nothin, nothin at all
		}
    }

    override function destroy() {
        cameraPos.put();
        super.destroy();
    }
}