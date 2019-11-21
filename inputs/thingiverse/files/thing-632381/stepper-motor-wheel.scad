/* [Global] */

// Motor Axis diameter
mr=5;

// Motor screw diameter
screw=3;

// Inner diameter
idi=15;

// Outer diamerer
odi=20;

// inner width
iw=5;

// outer width
ow=2;

// rotaion marker
marker=1; // [0,1]

/* [Hidden] */

$fs = 0.05;

difference(){
  difference(){
    difference(){
      union(){
        cylinder(ow*0.4,odi/2,odi/2);
        translate([0,0,ow*0.4]) cylinder(ow*0.6,odi/2,idi/2);
        translate([0,0,ow]) cylinder(iw,idi/2,idi/2);
        translate([0,0,ow+iw]) cylinder(ow*0.60,idi/2,odi/2);
        translate([0,0,ow+iw+ow*0.60]) cylinder(ow*0.40,odi/2,odi/2);
        translate([0,0,2*ow+iw]) cylinder(2*screw ,mr/2+screw,mr/2+screw);
      }
      // Motor Axis
      translate([0,0,-0.5])
      cylinder(2*ow+iw+2*screw+1,mr/2,mr/2);
    }
    // Screw hole
    translate([0,0,2*ow+iw+screw])
    rotate([0,90,0])
    cylinder(mr/2+screw, screw/2*0.9, screw/2);
  }

  // Marker
  if (marker==1) {
    translate([0,0,-ow*0.25])
    rotate([0,90,0])
    cylinder(odi/2+0.5,odi/20,odi/20);
  }
}

