//!OpenSCAD
//thickness of the blocks
side_width = 5;
//defines the height of the two axis
Height = 5;
//defines the length of the other two axis
length2 = 40;
//length of the center finder main axis
center_length = 50;
// difines the offset you need to mark a line
offset_pencil = 1;

difference() {
  union(){
    translate([(side_width * -1), 0, 0]){
      cube([side_width, length2, Height], center=false);
    }
    translate([0,0,0]){
    rotate([0, 0, 90]){
      cube([side_width, length2, Height], center=false);
    }
    }
    translate([0,offset_pencil,0]){
    rotate([0, 0, 45]){
      cube([side_width, center_length, 2], center=false);
    }
}
  }

  cube([side_width, length2, Height], center=false);
}