// Version 1.2



// Tile sizes of 25 are standard for most open tile bases
tilewidth = 25;
tiledepth = 25;

// Tile height is the height of each indiviual tile stone
tileheight = 3;
// Base height is the height from chamfer to table
baseheight = 5;

// Gap defines the space between each tile stone
gap = 1;



// Use cols and rows to define simple stone layouts
cols = 2;
rows = 2;

// Use a tileset of vectors to define a unique layout shape
tileset = [];
//tileset = [[0,0],[0,1],[0,2],[1,2],[2,2],[2,1],[2,0]];



// Cutouts uf you want to remove the top(bottom? and keep your bases clean
cutouts = true;
// The distance of the walls on the inside, 1.2 will work great with most 0.4 printer nozzles
wallsize = 1.2;
// Topsize ironically is the part that prints against the bed
topsize = 1;



// Use threadholes if you want to connect your tilesets together
threadholes = 2; // [0:0,1:1,2:2,3:3,4:4]
threadholesize = 0.75;











module pyramid(w,d,h,ch) {
    
    difference(){
    polyhedron(
    points=[
        [0,0,0],
        [w,0,0],
        [w,d,0],
        [0,d,0],
        [w*0.5,d*0.5,h]
    ],
    faces=[
        [0,1,2,3],
        [0,4,1],
        [1,4,2],
        [2,4,3],
        [3,4,0]
    ]
    );
    translate([0,0,ch])
    cube([w,d,h]);
    }
}

//rotate([180,0,0])
//translate([0,-50,-5])
//pyramid(50,50,25,5);


module newtile(w,d,h,g,b){
    hg = g*0.5;
    difference(){
        polyhedron
        (points = [
            [hg, hg, 0], // 0
            [w-hg, hg, 0], // 1
            [w-hg, d-hg, 0], // 2
            [hg, d-hg, 0], // 3
        
            [hg, hg, h], // 4
            [w-hg, hg, h], // 5
            [w-hg, d-hg, h], // 6
            [hg, d-hg, h], // 7
        
            [0, 0, h+hg], // 8
            [w, 0, h+hg], // 9
            [w, d, h+hg], // 10
            [0, d, h+hg], // 11
        
            [0, 0, h+b+hg], // 12
            [w, 0, h+b+hg], // 13
            [w, d, h+b+hg], // 14
            [0, d, h+b+hg] // 15
        ], 
        faces = [
            [0,1,2,3],
            [0,4,5,1],
            [1,5,6,2],
            [2,6,7,3],
            [3,7,4,0],
            [4,8,9,5],
            [5,9,10,6],
            [6,10,11,7],
            [7,11,8,4],
            [8,12,13,9],
            [9,13,14,10],
            [10,14,15,11],
            [11,15,12,8],
            [12,15,14,13]
        ]);
        if(cutouts) {
            translate([wallsize+hg,wallsize+hg,topsize])
            cube([w-g-wallsize*2,d-g-wallsize*2,h]);
             
            translate([wallsize,wallsize,h+g])
            cube([w-wallsize*2,d-wallsize*2,h+b+hg+topsize]);
        }
        if(threadholes>0){
            threadcount = threadholes+1;
            for(i=[1:threadholes]) {
                translate([w*0.5,d*(i/threadcount),h+hg+b*0.5])
                rotate([90,0,90])
                cylinder(
                    r1=threadholesize,
                    r2=threadholesize,
                    h=w,
                    $fn=8,
                    center=true
                );
                translate([w*(i/threadcount),d*0.5,h+hg+b*0.5])
                rotate([90,0,0])
                cylinder(
                    r1=threadholesize,
                    r2=threadholesize,
                    h=d,
                    $fn=8,
                    center=true
                );
            }
        }
    }
}

module tilegroup(p=[]) {
    if(len(p)==0)
        for(i = [0:cols*rows-1]) {
            tileat((i%cols),floor(i/cols));
        }
    else 
        for(i = [0:len(p)-1]) {
            tileat(p[i][0],p[i][1]);
        }
}

module tileat(x,y) {
    translate([tilewidth*x,tiledepth*y,0])
    newtile(
        tilewidth,
        tiledepth,
        tileheight,
        gap,
        baseheight
    );
}

tilegroup(tileset);