$fn=40;

// Outer diameter at the tip. Max 8. 
tip_diameter = 6;

// Length of the thin tip part. Set to 0 for no tip.
tip_length = 50;

// Length of the cone part.
cone_length = 40;

// Diameter at the end of the cone.
cone_diameter = 10;

// An attachment that fits into a DustBuster[tm]
module dustbuster_outline(off, height) {
  width = 153;
  length = 514;
  half_outline = [
          [100, width/2],
          [length/2-120, width/2-3],
          [length/2-100, width/2-4],
          [length/2-80, width/2-11],
          [length/2-50, width/2-26],
          [length/2-20, 32],
          [length/2, 10],
          [length/2, 0],
          [length/2-2, -10],
          [length/2-5, -20],
          [length/2-8, -25],
          [length/2-13, -28],
          [length/2-20, -32],
          [length/2-100, -57],
          [80, -width/2+3],
          [30, -width/2]
    ];
  other_half = [for (i = [len(half_outline)-1:-1:0]) [-half_outline[i][0], half_outline[i][1]]];
  outline = concat(half_outline, other_half);
  linear_extrude(height)
    offset(off)
    union() {
      polygon(outline);
    }
}

module dustbuster_half_hull() {
  hull() {
    translate([60, 82, -10])
      cylinder(r=10, h=20);
    translate([158, -10, -10])
      intersection() {
        cylinder(d=200, h=20, $fn=50);
        translate([0,0,-50])
          cube(100);
      }
    translate([260, 4, -10])
      cylinder(d=70, h=20);
    translate([258, -20, -10])
      cylinder(d=60, h=20);
    translate([62, 105, -10])
      intersection() {
        cylinder(d=400, h=20, $fn=50);
        translate([-10,-200,0])
          cube([200, 100, 200]);
    }
    translate([52, -87, -10])
      cylinder(r=10, h=20);
  }
}

module image() {
translate([-18,1.5,0])
 surface(file = "DustBuster 1.png", center = true,
      convexity = 5);
module dustbuster_half() {
  difference() {
    dustbuster_half_hull();
    scale([.95, .9, 1.1])
      dustbuster_half_hull();
  }
}
}

module dustbuster() {
dustbuster_half();
  translate([40,0,0])
mirror() dustbuster_half();
translate([-60, 82, -10])
cube([130, 10, 20]);
translate([-10, -97, -10])
  cube([60, 10, 10]);
}

module straight_attachment(len) {
  scale([47/564, 47/564, 1])
    difference() {
      dustbuster_outline(18, len);
      translate([0,0,-1])
        dustbuster_outline(0, len+2);
    }
}

module round_attachment_outline(outline, len, radius) {
    hull() {
  scale([47/564, 47/564, 1])
      dustbuster_outline(outline, 1);
      translate([0,0,len])
        cylinder(r=radius, h=1);
    }
}

module round_attachment(length, radius) {
  difference() {
    round_attachment_outline(18, length, radius);
    translate([0,0,-0.1])
    round_attachment_outline(0, length+0.22, radius-2);
  }
}

module pointy_attachment() {
  straight_attachment(35);
  translate([0,0,35])
    round_attachment(cone_length, cone_diameter);
  if (tip_length > 0) {
    translate([0,0,35+cone_length])
      difference() {
        cylinder(r1=cone_diameter, d2=tip_diameter, h=tip_length);
        translate([0,0,-0.1])
          cylinder(r1=cone_diameter-2, d2=tip_diameter/1.5, h=tip_length+0.2);
      }
    }
  }
  
  pointy_attachment();