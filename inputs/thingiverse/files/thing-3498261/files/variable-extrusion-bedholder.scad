// Aluminium extrusion variable bed mount
// by neb1, 2019, https://www.thingiverse.com/neb1/about

/* [Extrusion] */

// Extrusion size
EXT = 20; // [15:1515, 20:2020, 30:3030, 40:4040]
// Screw hole diameter for extrusion mount (e.g. 5.4mm for M5 screws)
EXT_hole_dia = 5.4; 

/* [Mount] */

// Bed distance measured from extrusion edge
s_distance = 15; 
// mount strength in (mm)
s_thickness = 3;
// Mount width (mm)
s_height = 15;
// Bed mount screw hole diameter (e.g. 3.5mm for M3)
s_hole_dia = 3.5; 

difference() {
    // support frame 
    cube([EXT+s_thickness, EXT+s_thickness, s_height]);
    // extrusion 
    translate([-1,-1,-50]) cube([EXT+1, EXT+1, 100]);
    
    // extrusion mount hole
    translate([EXT/2, EXT-1, s_height/2])
        rotate([-90,0,0])
            cylinder(d=EXT_hole_dia, h=s_thickness+2, $fn=20);
    
    // slide-in-mount
    translate([EXT-1, (EXT-EXT_hole_dia)/2, (s_height-EXT_hole_dia)/2])
        cube([s_thickness+2, EXT_hole_dia, s_height/2 + s_hole_dia]);
}

translate([0, EXT, 0]) {
    difference() {
        cube([s_thickness, s_distance + s_height/2, s_height]);
        
        // cutout for bedmount screw hole
        translate([-1, s_distance, s_height/2]) {
            rotate([0, 90, 0]) {
                cylinder(d=s_hole_dia, h=s_thickness+2, $fn=20);
            }
        }
    }
}