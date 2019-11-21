
// lenght of knob
length = 24;

// bottom (outer) diameter of knob
bottomDiameter = 15;

// top (outer) diameter of knob
topDiameter = 7.5;

// wall thickness
thickness = 2;

/** some better quality than default */
$fn=50;

module knob() {
  union() {
    difference() {
      cylinder (r1=bottomDiameter/2, r2=topDiameter/2, h=length);
      translate ([0,0,-0.1]) cylinder (r1=bottomDiameter/2-thickness, r2=topDiameter/2-thickness, h=length+0.2);
    }
    rotate_extrude (convexity = 10) translate ([-bottomDiameter/2+thickness/2,0,0]) circle (d=thickness);
    translate ([0,0,length]) rotate_extrude (convexity = 10) translate ([-topDiameter/2+thickness/2,0,0]) circle (d=thickness);
  }
}

knob();
