import brush.BrushType;

class TilePrefab {
    var model :  hxd.res.Model;
    public var tilesize : Int;
    public var rotation : Float;
    var brushType :BrushType;
    public function new(model : hxd.res.Model,brushType :BrushType,rotation=0.0,tilesize=1) {
        this.model=model;
        this.tilesize=tilesize; 
        this.brushType=brushType;
        this.rotation=rotation;
    }
    public function instantiate(x = 0 ,y = 0,?parent) : Tile3D{
        var m=Game.cache.loadModel(model).toMesh();
        return new Tile3D(m,brushType,x,y,rotation,parent);
    }
}