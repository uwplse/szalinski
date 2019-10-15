thickness = 10;
gap = 15;
length = 90;
lip_length = 5;

difference(){
  cube([gap + thickness * 2, length, thickness]);

  translate([thickness, thickness, 0])
  cube([gap, length - 2 * thickness, thickness]);

  translate([thickness, thickness, 0])
  cube([gap - lip_length, length, thickness]);

}
