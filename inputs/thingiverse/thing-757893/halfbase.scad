/**
Glass build plate holder 2-piece
**/

/* [Main] */
// Width of build plate (mm)
plate_width = 153; //[100:400]
// Length of build plate (mm)
plate_length = 236; //[100:400]
// Thickness of build plate (mm)
plate_thickness = 5; //[2:8]
/* [Extras] */
// Diameter of holes for threaded rod
hole_diameter = 7.2; //[4:10]
/* [Hidden] */
support_height = plate_thickness+hole_diameter+5;
support_diameter = plate_thickness*2.5;

union() {
  difference() {
    union() {
      cube([plate_width+4,plate_length/4,support_height]);
      translate([3,3,0])
        cylinder(r=support_diameter/2,h=support_height+1);
      translate([(plate_width+4)-3,3,0])
        cylinder(r=support_diameter/2,h=support_height+1);
    }
    translate([1.8,2,(support_height+.5)-plate_thickness])
      cube([plate_width+.4,(plate_length/4)+1,plate_thickness+4]);
    translate([plate_width/4,-.1,(support_height-plate_thickness)/2])
      rotate([270,0,0])
        cylinder(r=hole_diameter/2,h=plate_length);
    translate([plate_width-(plate_width/4),-.1,(support_height-plate_thickness)/2])
      rotate([270,0,0])
        cylinder(r=hole_diameter/2,h=plate_length);
  }
  //translate([plate_width/3,plate_length/8,(support_height-plate_thickness)-1])
  //  cylinder(r=hole_diameter/2,h=3);
  //translate([plate_width-(plate_width/3),plate_length/8,(support_height-plate_thickness)-1])
  //  cylinder(r=hole_diameter/2,h=3);
}
