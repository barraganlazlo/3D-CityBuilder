import brush.*;

class Game extends hxd.App {
	public static var instance : Game;
	public static var rand : hxd.Rand;
	public static var buildingPrefabs : Array<TilePrefab>;
	public static var roadPrefabs : haxe.ds.Vector<TilePrefab>;
	public static var cache:h3d.prim.ModelCache;
	public static var world:World;
	public static var camOffset=20;

	override function init() {
		instance=this;
		rand=hxd.Rand.create();
		loadModels();
		world = new World(128);
		initUi();
		initLight();
		initCamera();
	}
	override function update(dt:Float) {
		world.update(dt);
	}

	inline function loadModels() {
		cache = new h3d.prim.ModelCache();
		buildingPrefabs = [
			new TilePrefab(hxd.Res.meshes.fbx.buildings._1,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._2,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._3,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._4,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._5,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._6,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._7,Skyscraper,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._8,Shop,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._9,Shop,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._10,Shop,0,2),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._11,Cinema,0,4),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._12,House),
			new TilePrefab(hxd.Res.meshes.fbx.buildings._13,House)
		];

		//bit mask using uint
		//top=1 left=2 bot=4 right=8
		//none =0 total combinaisons possibles =16
		roadPrefabs= new haxe.ds.Vector<TilePrefab>(16);

		//no neighbors
		roadPrefabs[0]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_0,Road);
		 
		//top
		roadPrefabs[1]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_1,Road); 
		
		//left
		roadPrefabs[2]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_1,Road,90);

		//top + left
		roadPrefabs[3]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_2_turn,Road); 
		
		//bot
		roadPrefabs[4]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_1,Road,180);

		//bot + top
		roadPrefabs[5]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_2,Road); 

		//bot + left 
		roadPrefabs[6]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_2_turn,Road,90);
		
		//bot + left + top 
		roadPrefabs[7]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_3,Road); 

		//right
		roadPrefabs[8]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_1,Road,270);

		//right + top
		roadPrefabs[9]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_2_turn,Road,270);
		
		//right + left
		roadPrefabs[10]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_2,Road,90);

		//right + left + top
		roadPrefabs[11]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_3,Road,270);

		//right + bot
		roadPrefabs[12]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_2_turn,Road,180);

		//right + bot + top
		roadPrefabs[13]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_3,Road,180);

		//right + bot + left
		roadPrefabs[14]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_3,Road,90);

		//right + bot + left + top
		roadPrefabs[15]=new TilePrefab(hxd.Res.meshes.fbx.roads.road_4,Road);
		
		//end roads
	}

	inline function initCamera() {
		s3d.camera.target.set(world.size / 2, world.size / 2, 0);
		s3d.camera.pos.set(world.size/2 + camOffset, world.size/2 + camOffset, 20);
		new GodCameraController(s3d).loadFromCamera();
	}

	inline function initUi(){
        var style = new h2d.domkit.Style();
        style.load(hxd.Res.css.style);
        var bar= new BrushBar(s2d); 
        var btns=[
            new BrushButton(hxd.Res.sprites.road.toTile(),Road,bar),
            new BrushButton(hxd.Res.sprites.house.toTile(),House,bar),
            new BrushButton(hxd.Res.sprites.cinema.toTile(),Cinema,bar),
            new BrushButton(hxd.Res.sprites.shop.toTile(),Shop,bar),
            new BrushButton(hxd.Res.sprites.skyscraper.toTile(),Skyscraper,bar)
        ];
        style.addObject(bar);
        style.allowInspect = true;
    }

	inline function initLight() {
		var light = new h3d.scene.fwd.DirLight(new h3d.Vector(-0.5, -0.5, -1), s3d);
		light.color = new h3d.Vector(0.74, 0.74, 0.74);
		light.enableSpecular = true;
		s3d.lightSystem.ambientLight.set(0.74, 0.74, 0.74);
	}
}
