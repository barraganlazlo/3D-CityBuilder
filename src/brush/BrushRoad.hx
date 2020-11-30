package brush;

class BrushRoad extends Brush {

    public function new(world : World){
        super(world);
    }
    // x y coordinates of the road;
    function getRoadId(x :Int, y :Int):UInt {
		var top = isRoad(x,y+1);
		var left = isRoad(x-1,y);
		var bot = isRoad(x,y-1);
		var right = isRoad(x+1,y);
		var side:UInt = 0;
		if (top)
			side += 1;
		if (left)
			side += 2;
		if (bot)
			side += 4;
		if (right)
			side += 8;
		return side;
    }
    public override function update(dt:Float,x:Int,y:Int) {
        var newTilePrefab=Game.roadPrefabs[getRoadId(x,y)];
        if(currentTilePrefab!=newTilePrefab){
            currentTilePrefab=newTilePrefab;
            replaceInstance(x,y);
        }
        super.update(dt,x,y);
    }
    public override function createTile3D(x:Int,y:Int,?parent) {
        super.createTile3D(x,y,parent);
        trace(getRoadId(x,y));
        //top
        if(isRoad(x,y+1))replaceTile3D(x,y+1,parent);
        //left
        if(isRoad(x-1,y))replaceTile3D(x-1,y,parent);
        //bot
        if(isRoad(x,y-1))replaceTile3D(x,y-1,parent);
        //right
        if(isRoad(x+1,y))replaceTile3D(x+1,y,parent);
    }
    function replaceTile3D(x:Int,y:Int,?parent) {
        var tilePrefab=Game.roadPrefabs[getRoadId(x,y)];
        trace("n : ",getRoadId(x,y));        
        trace("rot : ",tilePrefab.rotation);        
        world.tileMap[x][y].remove();
        world.tileMap[x][y]=tilePrefab.instantiate(x,y,parent);
    }
    override function getNewTilePrefab(x:Int,y:Int) : TilePrefab{
       return Game.roadPrefabs[getRoadId(x,y)];
    }
    inline function isRoad(x : Int, y : Int) :Bool{
       return world.gotTile(x,y) && world.tileMap[x][y].brushType==BrushType.Road;
    }
    
}