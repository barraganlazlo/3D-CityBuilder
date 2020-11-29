import brush.BrushType;

class World {
    var selectedBrushType :BrushType;
     
    public var ground : h3d.scene.Mesh;
    public var interactive : h3d.scene.Interactive;
    public var currentMesh : h3d.scene.Mesh;
    public function new (){
        var cube = new h3d.prim.Cube();                
        cube.unindex();// unindex the faces to create hard edges normals
        cube.addNormals();// add face normals
        cube.addUVs(); // add texture coordinates

        ground = new h3d.scene.Mesh(cube,Game.instance.s3d);
        ground.material.color.setColor(0x99ff79);
        ground.scaleX=128;
        ground.scaleY=128;
        interactive=new h3d.scene.Interactive(ground.getCollider(), Game.instance.s3d);
        interactive.cursor=Default;
        interactive.onMove= function(e:hxd.Event) onMove(e);
        currentMesh=null;
    }
    dynamic function onMove(e:hxd.Event){
    }
    public function setBrushType(newtype:BrushType){
        if(newtype==selectedBrushType) return;
        selectedBrushType=newtype;
        updateCurrentMesh();        
    }
    function updateCurrentMesh(){
        // switch(selectedBrushType){
        //     case Building:
        // }
    }
    
}