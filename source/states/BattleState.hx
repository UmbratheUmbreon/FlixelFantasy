package states;

import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

class BattleState extends BasicState {
    var monsterBox:TextBox;
    var characterBox:TextBox;
    var battleOptionsBox:TextBox;
    var subMenuBox:TextBox;
    var selectSpr:FlxSprite;
    var bg:FlxTilemap;
    var curBg:String = 'CAVE';
    var curFormation:Int = 0;
    var characters:Array<BattleCharacter> = [];
    var monstersGfx:Array<FlxSprite> = [];
    
    public function new(bg:String = 'CAVE', formation:Int = 0) {
        curBg = bg;
        curFormation = formation;
        super();
    }

    override function create() {
        super.create();

        var loader = new FlxOgmo3Loader('assets/ogmo/Flixel.ogmo', 'assets/ogmo/battle/$curBg.json');
        bg = loader.loadTilemap('assets/images/BATTLE/BACKGROUNDS/$curBg.png', 'Battle Tiles');
        add(bg);

        var mus:String = /*Formation.getMusic(formation)*/ 'FIGHT 1';
        FlxG.sound.playMusic(Pathfinder.sound('${mus.toLowerCase()}', true), 0.8);

        monsterBox = new TextBox(0, bg.height, 11, 8, /*Formation.getMonsters(formation)*/'Mist D.  1');
        monsterBox.active = false;
        @:privateAccess {
            for (text in monsterBox.texts) {
                text.y += 4;
            }
        }
        add(monsterBox);

        characterBox = new TextBox(monsterBox.width, bg.height, 19, 8, '[[[[[[[[[[{}[[[[[[Cecil    200/ 200');
        characterBox.active = false;
        @:privateAccess {
            for (text in characterBox.texts) {
                text.y -= (text.y == characterBox.y + 8 ? 4 : 12);
            }
        }
        add(characterBox);

        var mist = new FlxSprite(8*3, 8*7).loadGraphic(Pathfinder.image('BATTLE/SUMMONS/MIST_DRAGON'));
        monstersGfx.push(mist);
        add(mist);

        var cecil = new BattleCharacter('CECIL', 8*27, 8*9);
        characters.push(cecil);
        add(cecil);
    }
}