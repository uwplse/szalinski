length=10;
thickness=2;
screw_diameter=4.2;

screw_spacer();

module screw_spacer() {
  $fn=50;
  difference() {
    cylinder(d=screw_diameter+thickness*2,h=length);
    cylinder(d=screw_diameter,h=length);
  }
}