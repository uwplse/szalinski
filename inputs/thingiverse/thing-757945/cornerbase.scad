/**
Glass build plate holder 4-piece
**/

/* [Main] */
// Width of build plate (mm)
plate_width = 153; //[100:400]
// Length of build plate (mm)
plate_length = 236; //[100:400]
// Thickness of build plate (mm), may want to set this to slightly less than actual thickness
plate_thickness = 5; //[2:8]
// Side of support to print, 2 of each side required for full support
side = "left"; //[left, right]
/* [Extras] */
// Diameter of holes for threaded rod
hole_diameter = 7; //[4:10]
/* [Hidden] */
support_height = plate_thickness+(hole_diameter*2)+5;
support_diameter = plate_thickness*2;

cornerbase();

module cornerbase() {
  difference() {
    union() {
      cube([plate_length/4,plate_width/4,support_height]);
      if (side == "left") {
        translate([plate_thickness*0.2,plate_thickness*0.2,0])
          cylinder(r=support_diameter/2,h=support_height);
      } else if (side == "right") {
        translate([(plate_length/4)-(plate_thickness*0.2),plate_thickness*0.2,0])
          cylinder(r=support_diameter/2,h=support_height);
      } else {
        echo("WARNING: No Support column created, must specify left or right side!");
      }
    }
    translate([-0.1,-0.1,support_height-plate_thickness])
      cube([(plate_length/4)+1,(plate_width/4)+1,plate_thickness+1]);
    translate([plate_length/8,-0.1,(support_height-plate_thickness)/2+(hole_diameter/2)])
      rotate([270,0,0])
        cylinder(r=hole_diameter/2,h=plate_length);
    translate([-0.1,plate_width/8,(support_height-plate_thickness)/2-(hole_diameter/2)])
      rotate([0,90,0])
        cylinder(r=hole_diameter/2,h=plate_length);
  }
}
