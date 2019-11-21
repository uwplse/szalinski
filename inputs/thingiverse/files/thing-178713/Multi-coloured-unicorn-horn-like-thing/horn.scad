INCHES = 25.4;

// Number of colors
NUMBER = 5; // [2:5]

// Diameter of the base shape
DIAMETER = 60; // [10:200]

// Height of the object
HEIGHT = 120; // [20:300]

// Twist in degress
TWIST = 180; // [0:720]

// Relative displacement of base shapes
DISTANCE = 0.7; // [0:1]

// Scale of the tip relative to the base
SCALE = 5/8; // [0:2]

// Should the object be hollow?
HOLLOW = false; // [true, false]

// If not hollow, What color should the inside have?
INSIDE_COLOR = 1; // [0:5]

module baseshape(size) {
 circle(size/2);
* rotate([0,0,45]) square(size, center=true);
* rotate([0,0,45]) pentagon(size/2);
}


COLORS = ["White", "Red", "Green", "Blue", "Yellow", "Black", "Pink"];
NUM_COLORS = 8;
ITEM = -1;
use <MCAD/regular_shapes.scad>


module base(neg = false) {
  if (neg) {
    difference() {
      translate([DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
      translate([-DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
    }
  }
  else {
    translate([-DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
  }
}

module baseitem(n) {
  rotate([0,0,n*360/NUMBER]) translate([DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
}

module newbase(n) {
  difference() {
    baseitem(n);
    for (i=[0:NUMBER-1]) {
      if (i!=n) baseitem(i);
    }
  }
}

module smoother() {
  hull() {
    sphere(r=10);
    translate([0,0,54.5]) sphere(r=4);
  }
}

module extrudepart() {
    linear_extrude(height=HEIGHT, twist=TWIST, scale=[SCALE, SCALE], convexity=3) child();
}

module basepart(item) {
    extrudepart() baseitem(item);
    translate([0,0,HEIGHT]) rotate([0,0,TWIST])
     scale(SCALE) rotate([0,0,item*360/NUMBER])
      translate([DIAMETER/2*DISTANCE,0]) 
       sphere(DIAMETER/2);
}
    
module part(item) {
    color(COLORS[item%NUM_COLORS]) {
        render() difference() {
            basepart(item);
            for (i=[0:NUMBER-1]) if (i!=item) basepart(i);
        }
        if (!HOLLOW && INSIDE_COLOR == item) inside();
    }
}

module inside() {
    extrudepart() for (i=[1:NUMBER-1], j=[0:i-1]) {
        intersection() {baseitem(i); baseitem(j);}
    }
}

module horn(item) {
  if (item == -1) {
      for (x=[0:NUMBER-1]) part(x);
      if (!HOLLOW) color(COLORS[INSIDE_COLOR]) inside();
  }
  else {
      part(item);
  }
}

horn(ITEM);
