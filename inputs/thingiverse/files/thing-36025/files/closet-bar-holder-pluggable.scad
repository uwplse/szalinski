/* [General] */

// Thickness of bar (add some tolerance)
bar_thickness = 20; // [5:30]
// back thickness of holder around bar
holder_bottom_thickness = 12; // [5:20]
// front thickness of holder around bar
holder_top_thickness = 5; // [0:20]
// thickness of base plate
base_thickness = 3; // [2:5]

/* [Plug] */

plug_depth = 10;
plug_thickness = 5;
// distance inbetween plugs
plug_distance = 26;
// offset location from vertical center
plugs_offset = -15;

/* [Hidden] */

// slight overlap / fudge factor
o = 0.01;
// distance between parts on plate
distance = 6;
bar_radius = bar_thickness/2;
plug_radius = plug_thickness/2;
base_width = bar_thickness+holder_bottom_thickness*2;
base_height = base_width*1.75;
$fa = 5;
$fs = 1;
// from https://github.com/elmom/MCAD/blob/master/boxes.scad
include <MCAD/boxes.scad>

base();
translate([0,0,base_thickness-o]) holder();

translate([0,base_width/2+plug_radius*2+distance,0]) {
  plug();
  translate([plug_radius*4+distance,0,0]) plug();
}

// this is the piece that sticks out to holds the bar
// we will be extruding this
module wall_mold() {
  polygon(points=[[0,0],[0,10],[holder_top_thickness,10],[holder_bottom_thickness,0]]);
}
module holder() {
  difference()
  {
    // this is a circle extrusion of the wall_mold()
    rotate_extrude(convexity = 10) translate([bar_radius, 0, 0]) wall_mold();
    // we only want the bottom 1/2 so lets take take away the top half
    translate([base_width/2,0,15/2-0.1]) cube([base_width,base_width,15],center=true);
  }
  // Here is the "straight" extrusions for the wall_mold()
  translate([-o,bar_radius,0]) rotate([90,0,90])
    linear_extrude( height=bar_radius+2) wall_mold();
  translate([bar_radius+2-o,-bar_radius,0]) rotate([90,0,-90]) 
    linear_extrude(height=bar_radius+2) wall_mold();
}
module base() {
  difference()
  {
     translate([0,0,base_thickness/2]) roundedBox([base_height,base_width, base_thickness], base_width/2, true);
     translate([plugs_offset,0,0]) {
      //
      rotate([180,0,0]) translate([0,0,-base_thickness]) {
        translate([plug_distance/2+plug_radius,0,0]) plug(true);
        translate([-plug_distance/2-plug_radius,0,0]) plug(true);
      }
    }
  }
}
module plug(remove=false) {
  if(remove) {
    translate([0,0,-base_thickness]) cylinder(base_thickness*2,plug_radius*3,plug_radius);
  } else {
    cylinder(base_thickness,plug_radius*2,plug_radius);
  }
  translate([0,0,base_thickness-o])
    cylinder(plug_depth+o,plug_radius,plug_radius);
}