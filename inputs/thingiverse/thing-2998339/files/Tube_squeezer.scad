//!OpenSCAD

slot_length = 60;
slot_width = 1.5;
general_height = 4;
rim_width = 10;

union(){
  difference() {
    cube([(slot_width + rim_width * 2), (slot_length + rim_width * 2), general_height], center=true);

    cube([slot_width, slot_length, general_height], center=true);
  }
  translate([0, (slot_length / 2 + rim_width), 0]){
    difference() {
      cylinder(r1=(rim_width + slot_width / 2), r2=(rim_width + slot_width / 2), h=general_height, center=true);

      translate([-50, -100, -50]){
        cube([100, 100, 100], center=false);
      }
    }
  }
  translate([0, ((slot_length / 2 + rim_width) * -1), 0]){
    mirror([0,1,0]){
      difference() {
        cylinder(r1=(rim_width + slot_width / 2), r2=(rim_width + slot_width / 2), h=general_height, center=true);

        translate([-50, -100, -50]){
          cube([100, 100, 100], center=false);
        }
      }
    }
  }
}