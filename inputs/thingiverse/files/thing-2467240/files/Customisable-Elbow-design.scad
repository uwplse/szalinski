// Customisable corner joint for 3 tubes / cylinders by MattKi
// Last updated 04/08/2017
//-------------------------------------------------------------------

height = 41; // length of the cylinders
hole_diameter = 24.5; // the diameter of the hole
wall_thickness = 1.6; // the cylinder wall thickness
brace_thickness = 2; // the thickness of joins between cylinders
use_ribs = true; // do you want ribs on the inside of the cylinders?
rib_count = 6; // the number of internal ribs on the cylinders
rib_width = 1.2; // the width of the internal ribs
rib_depth = 1; // how deep are the internal ribs

//-------------------------------------------------------------------

module tube_main(){
    translate([0,0,height/2+(hole_diameter+wall_thickness)/2]) union(){
        difference(){
            cylinder(h=height, d=hole_diameter+wall_thickness, $fn=144,center=true);
            cylinder(h=height+0.001, d=hole_diameter, $fn=144,center=true);
        }
        for (x=[0:rib_count]){
            rotate([0,0,(360/rib_count)*x]) ribs();
        }
    }
}

module ribs(){
    if (use_ribs){
        translate([0,(hole_diameter-rib_depth)/2,0]) cube([rib_width,rib_depth,height],center=true);
    }
}

module brace(){
    difference(){
        rotate([0,0,45]) cube([height,height,brace_thickness],center=true);
        translate([0,-height*0.5,0]) cube([height*2,height,brace_thickness+0.002],center=true);
        translate([height*0.5,0,0]) cube([height,height*2,brace_thickness+0.002],center=true);
    }
}

cube([hole_diameter+wall_thickness,hole_diameter+wall_thickness,hole_diameter+wall_thickness],center=true);
tube_main();
rotate([-90,0,0]) tube_main();
rotate([0,90,0]) tube_main();
translate([0,(hole_diameter+wall_thickness)/2,(hole_diameter+wall_thickness)/2]) rotate([0,90,0]) brace();
rotate([0,0,-90]) translate([0,(hole_diameter+wall_thickness)/2,(hole_diameter+wall_thickness)/2]) rotate([0,90,0]) brace();
rotate([0,90,0]) translate([0,(hole_diameter+wall_thickness)/2,(hole_diameter+wall_thickness)/2]) rotate([0,90,0]) brace();

