package brush;

class BrushBuilding extends Brush {

    public function new(world : World){
        super(world);
    }
    override function getNewTilePrefab(x:Int,y:Int) {
        return Game.buildingPrefabs[Game.rand.random(Game.buildingPrefabs.length)];
    }
}