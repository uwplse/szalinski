/* Will create a centerhole with automatic diameter and depth by default 
 * (if 'centerhole' is given). "Auto" simply means "The Right Thing Defined
 * By The Programmer I E God */

module tetrisfirkant(xy=14,z=2,centerhole=false,holedia="auto",holedep="auto") {

    zz = z/2;
    xy=xy-z;
    
    /* I wrote this starting off at polyhedras for the first time, so it
     * became upside down. This fixes it. Really, it's much nicer this way,
     * too. Look! It even comes in pink!!! */
    
    translate([zz,zz,z]) {
        
        difference() {
            polyhedron(
                points=[
                    [0,0,0],[xy,0,0],[xy,xy,0],[0,xy,0],    // 0,1,2,3
                    [0,-zz,-zz],[xy,-zz,-zz],               // 4,5
                    [xy+zz,0,-zz],[xy+zz,xy,-zz],           // 6,7
                    [xy,xy+zz,-zz],[0,xy+zz,-zz],           // 8,9
                    [-zz,xy,-zz],[-zz,0,-zz],               // 10,11

                    [0,-zz,-zz*2],[xy,-zz,-zz*2],           // 12,13
                    [xy+zz,0,-zz*2],[xy+zz,xy,-zz*2],       // 14,15
                    [xy,xy+zz,-zz*2],[0,xy+zz,-zz*2],       // 16,17
                    [-zz,xy,-zz*2],[-zz,0,-zz*2]             // 18,19
                ],

                faces=[
                    [0,2,1],[2,0,3],

                    [0,1,4],[1,5,4],[1,6,5],
                    [1,7,6],[1,2,7],[2,8,7],
                    [2,3,8],[3,9,8],[3,10,9],
                    [3,0,10],[0,11,10],[11,0,4],

                    [4,5,12],[5,13,12],[5,6,13],[6,14,13],
                    [6,15,14],[6,7,15],[7,8,15],[8,16,15],
                    [8,17,16],[8,9,17],[9,18,17],[9,10,18],
                    [10,19,18],[10,11,19],[11,12,19],[4,12,11],

                    [12,13,14],[12,14,19],
                    [19,14,15],[19,15,16],
                    [19,16,17],[19,17,18],
                ]
            );  
            if (centerhole) {
                // Assume auto everything for now
                if (holedia != "auto") {
                    echo("Hole diameter is \"auto\" for now. RTFS, please");
                }
                if (holedia != "auto") {
                    echo("Hole depth is \"auto\" for now. RTFS, please");
                }
                holedep = z/2;
                holedia = 4;
                
                translate([xy/2,xy/2,-z]) {
                    cylinder(h=holedep,d=holedia,$fn=64);
                }
            }
        }
    }
}

module tetromino(name,xy=14,z=2,centerhole=false,holedia="auto",holedep="auto") {
    if (name == "I") {
        translate([xy*0,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*0,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*0,xy*2,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*0,xy*3,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else if (name == "O") {
        translate([xy*0,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*0,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else if (name == "T") {
        translate([xy*0,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*2,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else if (name == "J") {
        translate([xy*0,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*2,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else if (name == "L") {
        translate([xy*0,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*0,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*0,xy*2,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else if (name == "S") {
        translate([xy*0,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*2,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else if (name == "Z") {
        translate([xy*0,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*1,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*1,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
        translate([xy*2,xy*0,0])
            tetrisfirkant(xy=xy,z=z,centerhole=centerhole,holedia=holedia,holedep=holedep);
    } else {
        echo("ERROR: Tetromino type \"", name, "\" is unknown");
    }
}

xy=14;

tetrisfirkant(centerhole=true);
/*
tetromino("I",centerhole=true);
translate([xy+2,0,0])
    tetromino("L",centerhole=true);
translate([xy*2+4,xy+2,0])
    tetromino("O",centerhole=true);
translate([xy*3+6,0,0])
    tetromino("J",centerhole=true);
translate([xy*3+2,xy*5+6,0])
    rotate([0,0,180])
        tetromino("T",centerhole=true);
translate([xy*2+4,xy*3+4,0])
    tetromino("S",centerhole=true);
translate([xy*4+8,xy*2+2,0])
    tetromino("Z",centerhole=true);

*/

/*
tetromino("I",centerhole=true);
tetromino("L",centerhole=true);
tetromino("O",centerhole=true);
tetromino("J",centerhole=true);
tetromino("T",centerhole=true);
tetromino("S",centerhole=true);
tetromino("Z",centerhole=true);
*/
