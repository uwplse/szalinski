//!OpenSCAD

part = "spatular";//[Mixing bowl,Spatular]
/*[Mixing bowl]*/
length2 = 20;
width = 20;
height = 5;
/*[spatular]*/
spatular_length = 20;
spatular_width = 10;
grabber_length = 50;
spatular_height = 2;
//defines the angle of the top part of the spatular
angle = 355;
if (part == "Mixing bowl") {
  difference() {
    translate([0, 0, -0.5]){
      cube([(length2 + 1), (width + 1), (height + 1)], center=true);
    }

    cube([length2, width, height], center=true);
  }
} else {
  union(){
    difference() {
      cube([spatular_length, spatular_width, spatular_height], center=false);

      rotate([0, angle, 0]){
        translate([0, 0, (spatular_height * -1)]){
          cube([(spatular_length + 20), spatular_width, spatular_height], center=false);
        }
      }
    }
    translate([(grabber_length * -1), (spatular_width / 4), 0]){
      cube([grabber_length, 5, spatular_height], center=false);
    }
  }
}
