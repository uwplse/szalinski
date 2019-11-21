// diameter of the inner hole
inner = 3;
// depth of the inner hole
h_in = 4;
// diameter of the outer hole
outer = 17.5;
// depth of the outer hole
h_out = 6;
// rounding of the outer hole
rounding = 0.25;

// inset of the current handle
inset = 1.5;
// diameter of the current handle
pin = 5.0;
// length of the current handle
plen = 10;

// diameter of the center plug
plug = 10;
// depth of the center plug
h_plug = 4;
// sides of the center plug x 2
sides = 3;

difference() {
  union() {
    translate([0,0,rounding])
    minkowski() {
      cylinder(r=outer/2-rounding, h=h_out-rounding*2, $fn=32);
      sphere(rounding);
    }
    cylinder(r=inner/2, h=h_out+h_in, $fn=16);
  }
  translate([outer/2-inset, 0, 0])
    cylinder(r=pin/2, h=plen, $fn=16);
  rotate([0,0,30])
    cylinder(r=plug/2, h=h_plug, $fn=sides);
  rotate([0,0,-30])
  cylinder(r=plug/2, h=h_plug, $fn=sides);
}