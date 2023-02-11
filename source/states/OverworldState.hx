package states;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.effects.FlxSkewedSprite;
import flixel.tile.FlxTilemap;

class OverworldState extends BasicState {
    var level = 'World Map';
    var tilemapGfx = 'OVERWORLD';
    var tilemap:FlxTilemap;
    public function new(level:String) {
        this.level = level;
        this.tilemapGfx = (level == 'World Map' ? 'OVERWORLD' : level.toUpperCase());
        super();
    }
    
    override function create() {
        super.create();

        var loader = new FlxOgmo3Loader('assets/ogmo/Flixel.ogmo', 'assets/ogmo/maps/$level.json');
        tilemap = loader.loadTilemap(Pathfinder.image('MAP/$tilemapGfx'), 'tiles');
        add(tilemap);
    }
}