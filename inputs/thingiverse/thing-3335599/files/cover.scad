include <../hextile/symkeys.scad>

width=36;
outer=32;
inner=7.25;
pin=20;

difference() {
  hextile(width,2);
  translate([0,0,1])
  cylinder(r=outer/2+0.2,h=pin);
}
cylinder(r=inner/2-0.2,h=pin,$fn=32);
