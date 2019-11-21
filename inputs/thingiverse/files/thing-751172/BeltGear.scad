/* [Global] */

// Tooth size of belt
tb=1;

// Number of teeth on wheel
tn=20;

// Width of belt (add a bit)
b=6;

// diameter of motor axis
hd=5;

/* [Hidden] */

u=2*tb*tn;
r=u/PI/2;
a=360/tn;

$fn=64;

difference() {
  union() {
    cylinder(2.01,r+2.0,r);

    translate([0,0,2])
    difference() {
      cylinder(b,r,r);
      for (x = [0 : tn-1]) {
        rotate([0,0,x*a]) translate([r-tb,-tb/2,-0.1]) cube([tb*2,tb,b+0.2]);
      }
    }

    translate([0,0,b+1.99]) cylinder(2.01,r,r+2);
    translate([0,0,b+3.99]) cylinder(hd,hd/2+2,hd/2+2);
  }

  translate([0,0,b+4+hd/2]) rotate([0,90,0]) cylinder(hd/2+3,1.4,1.4);
  translate([0,0,-0.01]) cylinder(b+hd+4.1,hd/2,hd/2);
}


