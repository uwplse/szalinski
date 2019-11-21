// Diameter of the hose
diam = 40;

diameter = diam * 40 / 36;
// Diameter of the cable
diac = 7.5;

diacable = diac * 7.5 / 6;
// Width of the ring
width = 5;
// Recess width
recessw = 1.5;
//recess height
recessh = 1.5;

thickness = 8;
openinghose = 0.2;
openingcable = 0.25;


space = (thickness-recessh)/2;
outside = 1.1 * ((diameter+width)/2);
echo(space);

  union() {

    minkowski() {
      difference() {
        cylinder(d=diameter+width, h=thickness);
        cylinder(d=diameter-recessw, h=thickness);
        cylinder(d=diameter, h=space);
        translate([0,0,thickness-space]) cylinder(d=diameter, h=space);
        linear_extrude(height=thickness) {
          rotate([0,0,-(180*openinghose)]) pie_slice(r=outside, a=360*openinghose);
        }
      }
      cylinder(r=2,h=2);
    }

    minkowski() {
      translate([0,(diameter+width)/2+diacable/2+width/3,0])
        mirror([1,0,0])
          difference() {
            cylinder(d=diacable+width, h=thickness);
            cylinder(d=diacable, h=thickness);
            linear_extrude(height=thickness) {
              rotate([0,0,-(180*openinghose)]) pie_slice(r=2*diacable/2, a=360*openinghose);
            }
          }
      cylinder(r=0.5,h=2);
   }


}

module pie_slice(r=3.0,a=30) {
  $fn=64;
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
}
