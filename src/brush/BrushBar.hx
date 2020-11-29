package brush;

@:uiComp("brushbar")
class BrushBar extends h2d.Flow implements h2d.domkit.Object{
    static var SRC = 
    <brushbar>
    </brushbar> 

    public function new(?parent) {
        super(parent);
        initComponent();
        enableInteractive = true;           
    }
}