// Values are for TomTom Start 60

// Height of device, measured where bracket will be placed.
device_height=101.5;

// Depth of device; measured near border of device.
device_depth=9;

// Bracket height, must correspond to latch space at bar. 10 is a reasonable value.
height=10;

// Hook in front of the device.
hook_length=7;


/* [Hidden] */
// Values for Xperia Active
// device_height=55;
// device_depth=16;
// hook_length=7;

// no changes below this line
// --------------------------
// device independent, must fit connector
thickness=2;


// convert to object internal values
width=device_height-2*thickness;
depth=device_depth-2*thickness;

module arm () {
// main beam
cube([width/2, thickness, height]);

// first corner

difference() {
  difference() {
    translate([width/2,-thickness,0])cylinder(r=2*thickness, h=height, $fn=60);
    translate([width/2,-thickness,0])cylinder(r=thickness, h=height, $fn=60);
  }
  union() {
    translate([width/2-2*thickness,-3*thickness,0])cube([2*thickness,3*thickness, height]);
    translate([width/2,-3*thickness,0])cube([2*thickness,2*thickness, height]);
  }
};

// short beam
translate([width/2+thickness,-thickness-depth,0])cube([thickness,depth,height]);

// second corner
difference() {
  difference() {
    translate([width/2,-thickness-depth,0])cylinder(r=2*thickness, h=height, $fn=60);
    translate([width/2,-thickness-depth,0])cylinder(r=thickness, h=height, $fn=60);
  }
  union() {
    translate([width/2-2*thickness,-3*thickness-depth,0])cube([2*thickness,4*thickness, height]);
    translate([width/2-thickness,-thickness-depth,0])cube([2*thickness,2*thickness, height]);
  }
};

// make end hook and move in place
translate([width/2-hook_length,-thickness*2-depth,0])
  linear_extrude(height=height)polygon(points=[[0,0],[hook_length,0],[hook_length,-thickness],[0,-thickness/2]]);

// do not change, this is the connector part
fixation_outer_width=37;
fixation_inner_width=20.4;
fixation_inner_depth=6.1;
fixation_outer_depth=fixation_inner_depth+2;

difference () {
 difference () {
  difference () {
    cube([fixation_outer_width/2, fixation_outer_depth, height]);
    cube([fixation_inner_width/2, fixation_inner_depth, height]);
   }
   translate([fixation_outer_width/2,thickness+2,0])cylinder(r=2, h=height, $fn=60);
 }
 translate([fixation_outer_width/2-sqrt(2),sqrt(2)*2,0])rotate(45)cube([10,10,height]);
};
};
// end module arm

arm();
mirror() arm();