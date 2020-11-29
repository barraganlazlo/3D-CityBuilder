class Main{    
    static function main() {
        #if js
        hxd.Res.initEmbed();
        #else
        hxd.Res.initLocal();
        #end
        new Game();
    }
}