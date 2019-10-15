// Width of the clamp
width=23.5;
// Length of the clamp
length=40;
// Thickness of the clamp
thickness=3.8;
// Wall thickness
material=3;

difference() {
  cube([width+2*material, length, thickness+2*material],true);
  cube([width, length+1, thickness],true);
  translate([0,0,material]) cube([width-2*material, length+1, thickness+2*material],true);
}
