import brush.*;
import h3d.Vector;

class Game extends hxd.App {
    public static var instance : Game;
    public var tiletypes =new Map<String,TileType>();
    public var cache : h3d.prim.ModelCache;
    public var world : World;
    public inline static final world_size =128;
    public inline static final camera_height =40;
    override function init() {
        instance=this;
        loadModels();
        world= new World();
        initUi();
        initLight();
        initCamera();
    }
    inline function loadModels(){
        cache=new h3d.prim.ModelCache();
        tiletypes["Building 13"] = new TileType(hxd.Res.meshes.fbx.buildings._1);
        tiletypes["Building 23"] = new TileType(hxd.Res.meshes.fbx.buildings._2);
        tiletypes["Road"] = new TileType(hxd.Res.meshes.fbx.roads.road,new Vector(0.05,0,0,0));
        tiletypes["Road Center"] = new TileType(hxd.Res.meshes.fbx.roads.road_center,new Vector(0.05,0,0,0));
    }
    inline function initCamera(){
        s3d.camera.target.set(world_size/2, world_size/2, 0);
        s3d.camera.pos.set(world_size, world_size, camera_height);
        new GodCameraController(s3d).loadFromCamera();
    }
    inline function initUi(){
        var style = new h2d.domkit.Style();
        style.load(hxd.Res.css.style);
        var bar= new BrushBar(s2d); 
        var btns=[
            new BrushButton(hxd.Res.sprites.road.toTile(),Road,bar),
            new BrushButton(hxd.Res.sprites.house.toTile(),Building,bar)
        ];
        style.addObject(bar);
        style.allowInspect = true;
    }
    inline function initLight() {
        var light = new h3d.scene.fwd.DirLight(new Vector(-0.5, -0.5, -1), s3d);
        light.color = new Vector(0.74,0.74,0.74);
        light.enableSpecular = true;
        s3d.lightSystem.ambientLight.set(0.74, 0.74, 0.74); 
    }
}