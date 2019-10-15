// Thickness of the spacer in mm
thickness = 8; //[2:20]

// Motor size in mm (NEMA17=42, NEMA23=56)
motor_size = 42; //[42,56]

// Bolt size (NEMA17=3, NEMA23=5)
thread = 3; //[3,5]

// Size of the center cutout in mm (NEMA17=22, NEMA23=38.1)
spindle_mount = 22; //[22,38.1]

// Does the spacer need a slot?
slot = "Yes"; //[Yes,No]

// Extra clearance around center hole and bolt holes in mm (Set based on your printer's tolerances)
tolerance = 0.1; //[0:0.05:0.3]

/* {Hidden] */
chamf_cube = (((motor_size/2)/(cos(45)))-((3.5)*(cos(45))))*2;
$fn=32;

difference(){
  intersection(){
    cube([motor_size, motor_size, thickness], true);
    rotate([0,0,45]){
      cube([chamf_cube, chamf_cube, thickness], true);
    }
  }
  cylinder(d=spindle_mount+(tolerance*2), h=thickness, center=true);
  if (slot == "Yes") {
    translate([(spindle_mount/2)+tolerance, 0, 0]){
      cube([spindle_mount+(tolerance*2), spindle_mount+(tolerance*2), thickness], true);
    }
  }
  if (motor_size == 42){
    translate([15.5,15.5,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
    translate([-15.5,15.5,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
    translate([-15.5,-15.5,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
    translate([15.5,-15.5,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
  } else {
    translate([23.57,23.57,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
    translate([-23.57,23.57,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
    translate([-23.57,-23.57,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
    translate([23.57,-23.57,0]){
      cylinder(d=thread+(tolerance*2), h=thickness, center=true);
    }
  }
}
