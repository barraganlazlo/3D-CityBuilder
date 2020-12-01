import brush.*;

class World {
	public var ground:h3d.scene.Mesh;
	public var interactive:h3d.scene.Interactive;

	public var tileMap:haxe.ds.Vector<haxe.ds.Vector<Tile3D>>;
	public var size:Int;

	// Brush
	var brushes:Map<BrushType, Brush>;
	var currentBrush:Brush;
	var selectedBrushType:BrushType;

	// Input
	public var currentX:Int;
	public var currentY:Int;
	public var pushing = -1;

	public function new(worldsize:Int) {
		size = worldsize;

		// init Cube used to create Ground
		var cube = new h3d.prim.Cube();
		cube.unindex(); // unindex the faces to create hard edges normals
		cube.addNormals(); // add face normals
		cube.addUVs(); // add texture coordinates

		// init Ground
		ground = new h3d.scene.Mesh(cube, Game.instance.s3d);
		ground.material.color.setColor(0x99ff79);
		ground.scaleX = size;
		ground.scaleY = size;
		ground.z = -1;

		// init Interractive
		interactive = new h3d.scene.Interactive(ground.getCollider(), Game.instance.s3d);
		interactive.enableRightButton = false;
		interactive.propagateEvents=true;
		interactive.cursor = Default;
		interactive.onMove = handleEvent;
		interactive.onPush = handleEvent;
		interactive.onRelease = handleEvent;
		// init TileMap
		tileMap = new haxe.ds.Vector(size);
		for (i in 0...size) {
			tileMap[i] = new haxe.ds.Vector(size);
		}

		// init Brushes
		currentBrush = null;
		brushes = new Map<BrushType, Brush>();
		for (value in Type.allEnums(BrushType)) {
			if (value == BrushType.Road || value == BrushType.None || value == BrushType.Delete)
				continue;
			var array = [
				for (t in 0...Game.buildingPrefabs.length)
					if (Game.buildingPrefabs[t].brushType == value) t
			];
			brushes[value] = new BrushBuilding(array, this);
		}

		brushes[BrushType.Road] = new BrushRoad(this);
		brushes[BrushType.Delete] = new BrushDelete(this);
		brushes[BrushType.None] = null;
	}

	public function update(dt:Float) {
		if (currentBrush != null)
			currentBrush.update(dt, currentX, currentY);
	}

	function handleEvent(e:hxd.Event) {
		switch (e.kind) {
			case EPush:
				pushing = e.button;
			case ERelease:
				pushing = -1;
			case EReleaseOutside:
				pushing = -1;
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
		if (currentBrush != null)
			currentBrush.onUnSelect(currentX, currentY);
		currentBrush = brushes[selectedBrushType];
		if (currentBrush != null)
			currentBrush.onSelect(currentX, currentY);
	}

	// utils

	public inline function sizeX():Int {
		return tileMap.length;
	}

	public function sizeY():Int {
		return tileMap[0].length;
	}
	public function isInBounds(x:Int, y:Int):Bool {
		return x > 0 && x < sizeX() && y > 0 && y < sizeY();
	}
	// return true if x and y in bounds and tile is null
	public function isEmpty(x:Int, y:Int):Bool {
		return  isInBounds(x,y) && tileMap[x][y] == null;
	}
	// return true if x and y in bounds and tile is not null
	public function isOccupied(x:Int, y:Int):Bool {
		return isInBounds(x,y)&& tileMap[x][y] != null;
	}
	// return true si le bouton 0 (click gauche est appuyé)
	public function isUsingBrush(): Bool{
		return pushing==0;
	}
}
