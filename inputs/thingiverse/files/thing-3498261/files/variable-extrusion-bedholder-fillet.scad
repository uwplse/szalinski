// Aluminium extrusion variable bed mount
// by neb1, 2019, https://www.thingiverse.com/neb1/about

$fn = 30+0;

/* [Extrusion] */

// Extrusion size
EXT = 20; // [15:1515, 20:2020, 30:3030, 40:4040]
// Screw hole diameter for extrusion mount (e.g. 5.4mm for M5 screws)
EXT_hole_dia = 5.4; 

/* [Mount] */

// Bed distance measured from extrusion edge
s_distance = 10; 
// mount strength in (mm)
s_thickness = 3;
// Mount width (mm)
s_height = 15;
// Bed mount screw hole diameter (e.g. 3.5mm for M3)
s_hole_dia = 3.5; 

difference() {
    // support frame 
    minkowski() {
        translate([0,0,1])
        union() {
            cube([EXT+s_thickness-1, EXT+s_thickness-1, s_height-2]);
            translate([0, EXT, 0])
            cube([s_thickness-2, s_distance + s_height/2 - 1, s_height-2]);
        }
        sphere(r = 1);
    }
    
    // extrusion 
    translate([-5,-5,-50]) cube([EXT+5, EXT+5, 100]);
    
    // extrusion mount hole
    translate([EXT/2, EXT-5, s_height/2])
        rotate([-90,0,0])
            cylinder(d=EXT_hole_dia, h=s_thickness+10, $fn=20);
    
    // slide-in-mount
    translate([EXT-5, (EXT-EXT_hole_dia)/2, (s_height-EXT_hole_dia)/2])
        cube([s_thickness+10, EXT_hole_dia, s_height/2 + s_hole_dia]);
    
    // cutout for bedmount screw hole
    translate([0, EXT, 0])
    translate([-5, s_distance, s_height/2]) {
        rotate([0, 90, 0]) {
            cylinder(d=s_hole_dia, h=s_thickness+10, $fn=20);
        }
    }
    
}