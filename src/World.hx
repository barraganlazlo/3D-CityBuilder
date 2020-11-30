import brush.*;

class World {
	public var ground:h3d.scene.Mesh;
	public var interactive:h3d.scene.Interactive;

	
	public var tileMap:haxe.ds.Vector<haxe.ds.Vector<Tile3D>>;
	public var currentTile:Tile3D;
	public var currentTilePrefab:TilePrefab;
	public var size:Int;

    //Brush
    var brushes : Map<BrushType,Brush>;
    var currentBrush : Brush;
    var selectedBrushType:BrushType;

    //Input 
    public var currentX:Int;
	public var currentY:Int;
	public var pushing = false;

    
	public function new(worldsize:Int) {
        size = worldsize;
        
        //init Cube used to create Ground
		var cube = new h3d.prim.Cube();
		cube.unindex(); // unindex the faces to create hard edges normals
		cube.addNormals(); // add face normals
		cube.addUVs(); // add texture coordinates

        //init Ground
		ground = new h3d.scene.Mesh(cube, Game.instance.s3d);
		ground.material.color.setColor(0x99ff79);
		ground.scaleX = size;
		ground.scaleY = size;
        ground.z = -1;
        
        //init Interractive
		interactive = new h3d.scene.Interactive(ground.getCollider(), Game.instance.s3d);
		interactive.enableRightButton = false;
		interactive.cursor = Default;
		interactive.onMove = handleEvent;
		interactive.onPush = handleEvent;
        interactive.onRelease = handleEvent;
        currentTilePrefab = null;
        
        //init TileMap
		tileMap = new haxe.ds.Vector(size);
		for (i in 0...size) {
			tileMap[i] = new haxe.ds.Vector(size);
        }
        
        //init Brushes
        currentBrush=null;
        brushes = new Map<BrushType,Brush>();
        brushes[BrushType.Road]= new BrushRoad(this);
        brushes[BrushType.Building]= new BrushBuilding(this);
        brushes[BrushType.None]= null;
	}
    public function update(dt:Float) {
        if(currentBrush==null) return;
        currentBrush.update(dt,currentX,currentY);
        if (pushing && isCurrentPosEmpty())
			currentBrush.createTile3D(currentX,currentY,Game.instance.s3d);
    }
	function handleEvent(e:hxd.Event) {
		switch (e.kind) {
			case EPush:
				pushing = true;
			case ERelease:
                pushing = false;
            case EMove:
                currentX = Math.round(e.relX);
		        currentY = Math.round(e.relY);
			default:
        }
	}

	public function setBrushType(newtype:BrushType) {
		if (newtype == selectedBrushType)
			return;
		selectedBrushType = newtype;
        trace('set brush type : $selectedBrushType');
        if(currentBrush!=null)
		    currentBrush.onUnSelect(currentX,currentY);
        currentBrush=brushes[selectedBrushType];
        if(currentBrush!=null)
		    currentBrush.onSelect(currentX,currentY);
	}

    //utils
	public inline function isCurrentPosEmpty() : Bool {
		return tileMap[currentX][currentY] == null;
	}
    public inline function sizeX() : Int {
        return tileMap.length;
    }
    public function sizeY() : Int {
        return tileMap[0].length;
    }
    //return true if x and y in bounds and tile is not null
    public function gotTile(x: Int,y :Int) :Bool{
        var b=false;
        if(x>0 && x<sizeX() && y>0 && y<sizeY() && tileMap[x][y]!=null) 
            b=true;
        return b;
    }
	
}
