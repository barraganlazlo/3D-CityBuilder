package brush;

class Brush {
	var currentTilePrefab:TilePrefab;
	var currentTileInstance:Tile3D;
	var world:World;

	public function new(world:World) {
		this.world = world;
	}

	public function onSelect(x:Int, y:Int) {
		currentTilePrefab = getNewTilePrefab(x, y);
		Assert.assert(currentTilePrefab != null);
		replaceInstance(x, y, Game.instance.s3d);
	}

	public function onUnSelect(x:Int, y:Int) {
		deleteInstance();
		currentTilePrefab = null;
	}

	public function update(dt:Float, x:Int, y:Int) {
		Assert.assert(currentTileInstance != null);
		var size = currentTilePrefab.tilesize;
		if (world.isUsingBrush()) {
			var isEmpty = true;
			for (i in x...x + size) {
				for (j in y...y + size) {
					if (!world.isEmpty(i, j)) {
						isEmpty = false;
						break;
					}
				}
				if (!isEmpty)
					break;
			}
			if (isEmpty)
				createTile3D(x, y, Game.instance.s3d);
		}
		currentTileInstance.x = x + (size - 1) / 2.0;
		currentTileInstance.y = y + (size - 1) / 2.0;
	}

	public function createTile3D(x:Int, y:Int, ?parent) {
		Assert.assert(currentTilePrefab != null);
		var size = currentTilePrefab.tilesize;
		var instance = currentTilePrefab.instantiate(x + (size - 1) / 2.0, y + (size - 1) / 2.0, parent);
		trace('create : $x,$y');
		for (i in x...x + size) {
			for (j in y...y + size) {
				trace(i, j);
				trace(world.tileMap[i][j]);
				world.tileMap[i][j] = instance;
				trace(world.tileMap[i][j]);
			}
		}
	}

	function replaceInstance(x:Int, y:Int, ?parent) {
		deleteInstance();
		Assert.assert(currentTilePrefab != null);
		currentTileInstance = currentTilePrefab.instantiate(x, y, parent);
	}

	function deleteInstance() {
		if (currentTileInstance != null) {
			currentTileInstance.remove();
		}
		currentTileInstance = null;
	}

	function getNewTilePrefab(x:Int, y:Int):TilePrefab {
		return null;
	}
}
