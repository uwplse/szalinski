// Mount for holding phone reliably under the D7 build plate, for taking
// pictures of the UV display in an attempt to create a mask.
// See https://www.facebook.com/groups/287910088208745/permalink/528854347447650/

/* Phone dimensions */
// Length of phone in mm
phone_x=147.0; // [50.0:1.0:200.0]
// Width of phone in mm
phone_y=72.0; // [30.0:1.0:75.0]
// Phone thickness in mm
phone_z=8.0; // [1.0:0.2:20.0]
// Height above phone back, clear of switches
phone_lower_hold_z=2.0; // [00:0.1:10.0]
// Height below phone face, clear of switches
phone_upper_hold_z=3.0; // [0.0:0.1:10.0]

// camera center position, distance from end of phone
camera_x=21.0; // [0.0:1.0:150.0]

// gap above phone below plate
extension_z=10.0; // [0.0:1.0:20.0]

// Width of the shell holding underneath the phone
phone_hold=5; // [0.0:1.0:10.0]
// Width of the holding block on each side - measured from the outside of the bracket. Needs to be enough to reach past any curve in the phone corners
hold_depth=20; // [0.0:1.0:40.0]
// Thickness of the shell
thickness=1.2; // [0.1:0.1:3.0]

module break() {};

// Plate dimensions
plate_x=134.0;
plate_y=75.0;
plate_z=6.0;
carriage_x=44.0; // central...

depth=(plate_y-phone_y)/2+phone_hold;

module corner(s, h) {
  linear_extrude(height=h)
  polygon([[0,0],[s,0],[0,s]]);
}

// Assumes phone is smaller than the bracket
module bracket() {
  // back panel - plate
  translate([0,0,extension_z+phone_z+thickness])
  cube([plate_x+thickness*2,thickness,plate_z+thickness*2]);
  // top left plate cover
  translate([0,-depth,extension_z+plate_z+phone_z+thickness*2])
  cube([(plate_x-carriage_x)/2,depth+thickness,thickness]);
  // top right plate cover
  translate([plate_x+thickness*2-(plate_x-carriage_x)/2,-depth,extension_z+plate_z+phone_z+thickness*2])
  cube([(plate_x-carriage_x)/2,depth+thickness,thickness]);
  // left plate edge
  translate([0,-depth,extension_z+phone_z+thickness])
  cube([thickness,depth+thickness,plate_z+thickness*2]);
  // right plate edge
  translate([plate_x+thickness*2-thickness,-depth,extension_z+phone_z+thickness])
  cube([thickness,depth+thickness,plate_z+thickness*2]);
  // under plate
  translate([0,-depth,extension_z+phone_z+thickness])
  cube([plate_x+thickness*2,depth+thickness,thickness]);
  
  // back panel - phone and extension
  translate([plate_x/2+thickness-camera_x-thickness,0,0])
  cube([plate_x/2+thickness+camera_x+thickness,thickness,extension_z+phone_z+thickness*2]);
  
  // over phone
  translate([plate_x/2+thickness-camera_x-thickness,-depth,phone_z+thickness])
  cube([plate_x/2+thickness+camera_x+thickness,depth+thickness,thickness]);
  // under phone
  translate([plate_x/2+thickness-camera_x-thickness,-depth,0])
  cube([plate_x/2+thickness+camera_x+thickness,depth+thickness,thickness]);
  // phone end stop
  translate([plate_x/2+thickness-camera_x-thickness,-hold_depth,0])
  cube([thickness,hold_depth+thickness,phone_z+thickness*2]);
  translate([plate_x/2+thickness-camera_x,0,0])
  rotate(a=-90,v=[0,0,1]) corner(s=hold_depth,h=thickness);
  translate([plate_x/2+thickness-camera_x,0,phone_z+thickness])
  rotate(a=-90,v=[0,0,1]) corner(s=hold_depth,h=thickness);
  // phone edge fill - two bands, upper and lower leaving a channel to prevent
  // side buttons being pressed.
  translate([plate_x/2+thickness-camera_x-thickness,-(plate_y-phone_y)/2,0])
  cube([plate_x/2+thickness+camera_x+thickness,(plate_y-phone_y)/2+thickness,phone_lower_hold_z+thickness]);
  translate([plate_x/2+thickness-camera_x-thickness,-(plate_y-phone_y)/2,phone_z-phone_upper_hold_z+thickness])
  cube([plate_x/2+thickness+camera_x+thickness,(plate_y-phone_y)/2+thickness,phone_upper_hold_z+thickness]);
}

//bracket();

translate([0,thickness,0])
rotate(a=-90,v=[1,0,0]) translate([0,-thickness,0]) bracket();
translate([0,-thickness,0])
mirror([0,1,0])
rotate(a=-90,v=[1,0,0]) translate([0,-thickness,0]) bracket();