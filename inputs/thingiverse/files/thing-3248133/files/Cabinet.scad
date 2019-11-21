// Customizable parts bin
// by Brian Blankenship 
// 

NUMBER_DRAWERS = 5; // [1:1:15] 
CABINET_COLLUMNS = 1; // [1:1:8]

DRAWER_HEIGHT = 25;  
DRAWER_WIDTH = 100; // adjustable from ~30-200 
CABINET_DEPTH = 80;  // adjustable from ~50-200


HEIGHT = NUMBER_DRAWERS * (DRAWER_HEIGHT + 4) + 2;
WIDTH = DRAWER_WIDTH * CABINET_COLLUMNS;


$fn=90;

// main cabinet
difference() {
    
    // additions
    union() {
        cube([(NUMBER_DRAWERS * (DRAWER_HEIGHT + 4)) + 2,DRAWER_WIDTH * CABINET_COLLUMNS, CABINET_DEPTH]);

            // Bottom nubs for stacking
            translate([.2,5,5]) sphere(1.4);
            translate([.2,5,CABINET_DEPTH-5]) sphere(1.4);
            translate([.2,WIDTH-5,5]) sphere(1.4);
            translate([.2,WIDTH-5,CABINET_DEPTH-5]) sphere(1.4);
            } 
           
    union() {
        for (COLLUMN = [0:CABINET_COLLUMNS-1]) {
            for (DRAWER = [0:NUMBER_DRAWERS-1]) {
                // drawer cut outs
                translate([((DRAWER_HEIGHT + 2) * DRAWER) + (DRAWER + 1) * 2, 2 + (DRAWER_WIDTH * COLLUMN), 2]) cube([DRAWER_HEIGHT + 2, (DRAWER_WIDTH) - 4,CABINET_DEPTH + 2]);
            }
            
        }
        
        
        // diamond holes in left/right sides
        for (HOLE = [7:10:(CABINET_DEPTH - 10)]) {

            for (DRAWER = [0:NUMBER_DRAWERS-1]) {
                // right side diamond holes
                translate([((DRAWER_HEIGHT + 2 ) * DRAWER) + (DRAWER + 1) * 2 + 5, -1, HOLE]) rotate([0,45,0]) cube([4,4,4]);
                translate([((DRAWER_HEIGHT + 2 ) * DRAWER) + (DRAWER + 1) * 2 + 12, -1,HOLE + 5]) rotate([0,45,0]) cube([4,4,4]);
                translate([((DRAWER_HEIGHT + 2 ) * DRAWER) + (DRAWER + 1) * 2 + 19, -1, HOLE]) rotate([0,45,0]) cube([4,4,4]);
                // left side diamond holes
                translate([((DRAWER_HEIGHT + 2 ) * DRAWER) + (DRAWER + 1) * 2 + 5, DRAWER_WIDTH * CABINET_COLLUMNS -3, HOLE ]) rotate([0,45,0]) cube([4,4,4]);
                translate([((DRAWER_HEIGHT + 2 ) * DRAWER) + (DRAWER + 1) * 2 + 12, DRAWER_WIDTH * CABINET_COLLUMNS - 3, HOLE + 5]) rotate([0,45,0]) cube([4,4,4]);
                translate([((DRAWER_HEIGHT + 2 ) * DRAWER) + (DRAWER + 1) * 2 + 19, DRAWER_WIDTH * CABINET_COLLUMNS - 3, HOLE])     rotate([0,45,0]) cube([4,4,4]);
            }
        }

        // Top indentions for stacking
        translate([HEIGHT,5,5]) sphere(1.5);
        translate([HEIGHT,5,CABINET_DEPTH-5]) sphere(1.5);
        translate([HEIGHT,WIDTH-5,5]) sphere(1.5);
        translate([HEIGHT,WIDTH-5,CABINET_DEPTH-5]) sphere(1.55);

    }
    
}

for (COLLUMN = [0:CABINET_COLLUMNS-1]) {
    // bottom nubs to keep drawers in
    for (NUB = [0:NUMBER_DRAWERS -1]) {
        translate([((DRAWER_HEIGHT + 2) * NUB) + (NUB + 1) * 2, (DRAWER_WIDTH / 2) + (DRAWER_WIDTH * COLLUMN), CABINET_DEPTH -2]) sphere(1.2);
    }

    // top nubs to keep drawers in
    for (NUB = [1:NUMBER_DRAWERS]) {
        translate([((DRAWER_HEIGHT + 2) * NUB) + (NUB) * 2 - .2, (DRAWER_WIDTH / 5)  + (DRAWER_WIDTH * COLLUMN), CABINET_DEPTH -4]) sphere(2.2);
        translate([((DRAWER_HEIGHT + 2) * NUB) + (NUB) * 2 - .2, (DRAWER_WIDTH / 5) * 4 + (DRAWER_WIDTH * COLLUMN), CABINET_DEPTH -4]) sphere(2.2);
    }
}




