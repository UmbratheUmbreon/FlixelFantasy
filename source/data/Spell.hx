package data;

class Spell {
    public var name:String;
    public var effect:Int = 0;
    public var target:Int = 0;
    public var power:Int = 0;
    public var accuracy:Int = 0;
    public var delay:Int = 0;
    public var cost:Int = 0;
    public var reflects:Bool = true;
    public var hitBoss:Bool = true;
    public var impact:Bool = true;
    public var damage:Bool = true;
    public var sound:String;
    public var palette:Int = 0;
    public var sprites:Int = 0;
    public var sequence:Int = 0;
    public var effects:Int = 0;
    public var elements:Int = 0;
    public var type:SpellSet.SpellSetType;

    public function new(id:Int) {
        switch (id) {
            case 0:
                //dummy so i can test lol
                this.name = 'Hold';
                this.effect = 7;
                this.target = 5;
                this.power = 0;
                this.accuracy = 85;
                this.delay = 1;
                this.cost = 5;
                this.reflects = true;
                this.hitBoss = false;
                this.impact = false;
                this.damage = false;
                this.sound = 'paralyze';
                this.palette = 19;
                this.sprites = 16;
                this.sequence = 35;
                this.effects = 0;
                this.elements = 13;
                this.type = WHITE;
        }
    }
}