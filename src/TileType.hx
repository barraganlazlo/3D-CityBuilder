class TileType {
    var model : hxd.res.Model; 
    var offset : h3d.Vector;
    public function new(model : hxd.res.Model,?offset : h3d.Vector) {
        this.model=model;
        offset==null? this.offset=offset : this.offset=new h3d.Vector(0);
    }
    public inline function instantiate() :  h3d.scene.Object {
        var m = Game.instance.cache.loadModel(model);
        m.x+=offset.x;
        m.y+=offset.y;
        m.z+=offset.z;
        return m;
    }
}