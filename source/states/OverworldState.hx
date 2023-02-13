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
        add(player);

        cameraPos = FlxPoint.get(player.x + player.width/2, player.y + player.height/2);

        FlxG.camera.focusOn(cameraPos);

        FlxG.sound.playMusic(Pathfinder.sound('${tilemapGfx.toLowerCase()}', true), 0.4);
    }

    override function update(elapsed) {
        cameraPos = player.getMidpoint(cameraPos);
        FlxG.camera.focusOn(cameraPos);
    }

    override function keyPress(event:KeyboardEvent) {
        super.keyPress(event);
		var eventKey:FlxKey = event.keyCode;
		switch (eventKey)
		{
			case DOWN | S:
				player.move('DOWN');
            case UP | W:
                player.move('UP');
            case LEFT | A:
                player.move('LEFT');
            case RIGHT | D:
                player.move('RIGHT');
            case THREE:
                player.change();
			default:
				//do nothin
		}
    }

    override function destroy() {
        cameraPos.put();
        super.destroy();
    }
}