package data;

enum SpellSetType {
    WHITE;
    BLACK;
    SUMMON;
    NINJA;
}

class SpellSet {
    public var spells:Array<Int> = [];
    public var startingSpells:Array<Int> = [];
    public var learnedSpells:Array<Array<Int>> = [];
    public var setType:SpellSetType;

    public function new(starting:Array<Int>, learned:Array<Array<Int>>, type:SpellSetType) {
        this.startingSpells = starting;
        this.learnedSpells = learned;
        this.setType = type;
        for (spell in startingSpells) spells.push(spell);
    }

    public function addSpell(spell:Int) {
        spells.push(spell);
    }
    
    public function removeSpell(spell:Int) {
        spells.remove(spell);
    }

    public function init(_save:Int = 0, character:String, type:SpellSetType) {
        if (SaveManager.exists(_save)) {
            spells = SaveManager.get(_save, '${character}${type}Spells', "generic");
        }
    }
}