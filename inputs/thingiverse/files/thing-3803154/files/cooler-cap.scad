// Outside diameter of the pipe
od=18;
// Inside diameter of the pope
id=13;
// Height of the cap
h=15;
// Wall thickness (diameter of the cap will equl to the outside diameter of the pipe plus all thicknes).
thickness=2;
// Attach hole diametew
attach_d=4;

$fn=64;

pipe_cap(od=od, id=id, h=h, thickness=thickness, attach_d=attach_d);

module pipe_cap(od, id, h, thickness, attach_d) {
  translate([0,0,(h+thickness)/2]) union() {
    difference() {
      cylinder(d=od + 2 * thickness, h=h+thickness, center=true);
      translate([0,0, thickness]) cylinder(d=od, h=h+thickness, center=true);
    }
    translate([0,0,+0.5]) cylinder(d=id, h=h+thickness-1, center=true);

    translate([0,0,-h/2]) difference() {
      hull() {
        translate([(od +  2 * thickness + attach_d)/2,0,0]) cylinder(d=attach_d+2*thickness, h=thickness, center=true);
        cylinder(d=od + 2 * thickness, h=thickness, center=true);
      }
      translate([(od +  2 * thickness + attach_d)/2,0,- 0]) cylinder(d=attach_d, h=thickness+1, center=true);
    }
  }
}