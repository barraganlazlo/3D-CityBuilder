package brush;

class Brush {    

    var currentTilePrefab : TilePrefab;
    var currentTileInstance : Tile3D;
    var world :World;
    public function new(world :World){
        this.world=world;
    }
    public function onSelect(x:Int,y:Int) {
        currentTilePrefab=getNewTilePrefab(x,y);
        replaceInstance(x,y, Game.instance.s3d);
    }
    public function onUnSelect(x:Int,y:Int) {
        deleteInstance();
        currentTilePrefab=null;
    }
    public function createTile3D(x:Int,y:Int,?parent) {
        if (currentTilePrefab == null)
			return;
        world.tileMap[x][y]=currentTilePrefab.instantiate(x, y,parent);
    }
    public function update(dt:Float,x:Int,y:Int) {
        currentTileInstance.x=x;
        currentTileInstance.y=y;
    }
    function replaceInstance(x:Int,y:Int, ?parent){    
        if(currentTileInstance!=null){
            currentTileInstance.remove();
        }
        currentTileInstance=currentTilePrefab.instantiate(x,y,parent);        
    }
    function deleteInstance(){    
        if(currentTileInstance!=null){
            currentTileInstance.remove();
        }
        currentTileInstance=null;        
    }
    function getNewTilePrefab(x:Int,y:Int) : TilePrefab { return null;}
}