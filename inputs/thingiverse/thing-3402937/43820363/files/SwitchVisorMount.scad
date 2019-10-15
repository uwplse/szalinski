// Nintendo Switch mount for car visor

$fn=50;
width=30;   // [7:1:50]
 
// right side
    union() {
        translate([0,42,0]) cube([9,103,1.5]);
        translate([0,143.5,0]) cube([9,3,20]);
        translate([1,42,1.5]) cube([7,35,3]); 
        translate([0,42,3]) cube([9,35,2]);
        translate([3,2,0]) cube([4,40,7]);
        translate([5,2,0]) cylinder(r=2,h=7);
        translate([5,0,0]) cube([width,4,7]);
        translate([width+3,2,0]) cube([4,28,7]);
        translate([width+5,2,0]) cylinder(r=2,h=7);
        translate([width+5,30,0]) cylinder(r=2,h=7);
    }


// left side
    union() {
        translate([width*2+10,42,0]) cube([9,103,1.5]);
        translate([width*2+10,143.5 ,0]) cube([9,3,20]);
        translate([width*2+11,42,1.5]) cube([7,35,3]); 
        translate([width*2+10,42,3]) cube([9,35,2]);
        translate([width*2+12,2,0]) cube([4,40,7]);
        translate([width*2+14,2,0]) cylinder(r=2,h=7);
        
        translate([width+14,0,0]) cube([width,4,7]);
        translate([width+12,2,0]) cube([4,28,7]);
        translate([width+14,2,0]) cylinder(r=2,h=7);
        translate([width+14,30,0]) cylinder(r=2,h=7);
    }
