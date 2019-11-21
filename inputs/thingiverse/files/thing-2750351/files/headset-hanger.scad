// Variables
thick=4;
length=50;
width=20;
drop=20;
hole_diam=5;
ts=4;
tp=[[ts,ts],[ts,0],[0,ts]];

// Support Beams
cube([length+thick,width,thick]);
translate([0,0,thick-.01]) {
    cube([thick+.01,width,drop]);
    translate([(hole_diam*3-thick)/-2,-3*hole_diam,drop-.01])
    difference() {
        cube([hole_diam*3,width+hole_diam*6,thick]);
        translate([hole_diam*1.5,hole_diam*1.5,-.5]) {
            translate([0,width+hole_diam*3,0])
                cylinder(d=hole_diam,h=thick+1);
            cylinder(d=hole_diam,h=thick+1);
        }
    }
}


// Edges
module tri() {
    rotate([-90,0,0])
    linear_extrude(height=width)
    polygon(points=tp);
}
translate([length+thick-ts,0,thick+ts-.01]) tri();
translate([ts+thick,width,thick+ts-.01]) rotate([0,0,180]) tri();