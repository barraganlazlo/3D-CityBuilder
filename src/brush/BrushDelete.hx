package brush;

class BrushDelete extends Brush {
	public override function onSelect(x:Int, y:Int) {}

	public override function onUnSelect(x:Int, y:Int) {}

	public override function update(ft:Float, x:Int, y:Int) {
		if (world.isUsingBrush() && !world.isEmpty(x, y)) {
			var toDelete = world.tileMap[x][y];
			var size = toDelete.tilesize;
			toDelete.remove();
			for (i in x...x + size) {
				for (j in y...y + size) {
					if (world.tileMap[i][j] == toDelete)
						world.tileMap[i][j] = null;
				}
			}
		}
	}
}
