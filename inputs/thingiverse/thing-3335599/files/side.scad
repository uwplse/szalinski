include <../hextile/symkeys.scad>

width=36;
height=42+4;
depth=8;

edge=width/sqrt(3);

difference() {
  cube([depth,edge,height]);
  translate([-width/2+teeth,edge/2,0])
    hextile(width, teeth);
  translate([width/2-teeth+depth,edge/2,0])
    hextile(width);
}
