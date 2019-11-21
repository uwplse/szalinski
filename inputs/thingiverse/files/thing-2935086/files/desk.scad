/* Options */
width = 50; // [1:100]
height = 30; // [1:100]
depth = 25; // [1:100]

/* Hidden */ 

desk(width,height,depth);

module desk(width,height,depth) {
    module top(width,height,depth) {
        hull() {
            sphere(1);
            translate([width,0,0]) sphere(1);
            translate([width,0,depth]) sphere(1);
            translate([0,0,depth]) sphere(1);
        }
    }

    module legs(width,height,depth) {
        cube([2,height,4]);
        translate([width-2,0,0]) cube([2,height-1,4]);
        translate([width-2,0,depth-4]) cube([2,height-1,4]);
        translate([0,0,depth-4]) cube([2,height-1,4]);
    }
    
    module bracing(width,height,depth,bracedSections) {
            translate([2,0,2]) rotate([-90,0,0]) cube([width-4,2,4]);
            translate([2,0,depth]) rotate([-90,0,0]) cube([width-4,2,4]);
            translate([2,height-8,2]) rotate([-90,0,0]) cube([width-4,2,4]);
            translate([2,0,depth-4]) rotate([-90,90,0]) cube([depth-8,2,4]);
            translate([width,0,depth-4]) rotate([-90,90,0]) cube([depth-8,2,4]);
            for (i = [1:1:bracedSections-1]) {
                translate([((width*i)/bracedSections+1),0,depth]) rotate([-90,90,0]) cube([depth-2,2,4]);
            }
     }

     union() {
        color("BurlyWood") top(width,height,depth);
        color("Khaki") bracing(width,height,depth,3);
        color("Tan") legs(width,height,depth);
     }
}