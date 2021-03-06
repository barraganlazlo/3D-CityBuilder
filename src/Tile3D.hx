import brush.BrushType;

class Tile3D extends h3d.scene.Object{
    var mesh : h3d.scene.Mesh;
    public var brushType : BrushType;
    public var tilesize : Int;
    public function new(mesh : h3d.scene.Mesh, brushType :BrushType,tilesize : Int,x=0.0,y=0.0,rotation=0.0, ?parent) {
        super(parent);
        this.brushType=brushType;
        this.tilesize=tilesize;
        this.x=x;        
        this.y=y;
        this.z=0;
        this.addChild(mesh);
        this.mesh=mesh;
        mesh.x=0;        
        mesh.y=0;
        mesh.z=0;
        mesh.setRotation(0,0,hxd.Math.degToRad(rotation));
    }
}