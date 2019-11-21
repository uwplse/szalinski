//!OpenSCAD


/* [Material] */
Material = "PETG";

/* [Nozzle Size] */
// Number before delimiter (can be empty)
before = "";

// (can be empty)
delimiter = ".";

// Number after delimiter (can be empty)
after = 25;

/* [Hole] */
// in mm
diameter = 6.1;

/* [Dimensions] */
// square, default = 14.85 mm
width = 14.85;

/* [Hidden] */

$fs = 0.01;
$fa = 1;

difference() {
  hull(){
    translate([width-2, 2, 0]){
      cylinder(r1=2, r2=2, h=1, center=false);
    }
    translate([2, width-2, 0]){
      cylinder(r1=2, r2=2, h=1, center=false);
    }
    translate([2, 2, 0]){
      cylinder(r1=2, r2=2, h=1, center=false);
    }
    translate([width-2, width-2, 0]){
      cylinder(r1=2, r2=2, h=1, center=false);
    }
  }

  translate([5-(15-width)/2, 5-(15-width)/2, -0.5]){
    cylinder(r1=diameter/2, r2=diameter/2, h=2, center=false);
  }
  translate([width-7.5, width-3.5, 0.5]){
    rotate([0, 0, 180]){
      // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
      linear_extrude( height=0.6, twist=0, center=false){
        text(str(Material), font = "Open Sans:style=Bold", size = 5*0.75, halign="center", valign="center");
      }

    }
  }
  translate([width-2, 1, 0.5]){
    rotate([0, 0, 90]){
      // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
      linear_extrude( height=0.6, twist=0, center=false){
        text(str(before,delimiter,after), font = "Open Sans:style=Bold", size = 5*0.75);
      }

    }
  }
}