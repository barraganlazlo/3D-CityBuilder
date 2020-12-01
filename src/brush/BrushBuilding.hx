package brush;

class BrushBuilding extends Brush {

    var prefabIndexes : Array<Int>;
    
    public function new(prefabIndexes: Array<Int>,world : World){
        super(world);
        this.prefabIndexes=prefabIndexes;
    }

    override function getNewTilePrefab(x:Int,y:Int) {
        var id=prefabIndexes[Game.rand.random(prefabIndexes.length)];
        return Game.buildingPrefabs[id];
    }

    public override function createTile3D(x:Int,y:Int,?parent) {
        super.createTile3D(x,y,parent);
        var newTilePrefab=getNewTilePrefab(x,y);
        if( currentTilePrefab!=newTilePrefab)
        {
            currentTilePrefab=newTilePrefab;
            replaceInstance(x,y,parent);
        }
    }
}