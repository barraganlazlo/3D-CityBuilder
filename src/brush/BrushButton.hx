package brush;

@:uiComp("brushbutton")
class BrushButton extends h2d.Flow implements h2d.domkit.Object {

    static var SRC = 
    <brushbutton>   
        <bitmap id="image" src={tile}/>
    </brushbutton>

    var type : BrushType;
    
    public function new(tile:h2d.Tile,type : BrushType,?parent) {
        super(parent);
        initComponent();
        enableInteractive = true;
        this.type=type;
        interactive.onClick = function (e:hxd.Event) {
            trace(type);
            Game.instance.world.setBrushType(type);
        }
    }
}
