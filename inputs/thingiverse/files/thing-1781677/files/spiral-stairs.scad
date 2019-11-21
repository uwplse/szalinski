/*
  Spiral Staircase
*/

/* [Step Settings] */
//total revolutions
revolutions = 3.5;
//radius
radius = 100;
//segments per turn
segments = 13;
//height of segments
height = 40;
//central column radius
column = 10;


module triangle(y = 100, angle = 60, h = 10) {
  x = y*tan(angle/2);

  for (i = [-1, 1]) {
    translate([i*x/2, -y/2, 0])
    mirror([1-i, 0, 0])
    difference() {
      cube([x, y, h], center = true);
      rotate([0, 0, angle/2])
        translate([x/2, 0, 0])
        cube([x, 2*y, h*1.01], center = true);
    }
  }
}

module step(h = 10, r = 100, segments = 6, clr = "gray") {

  $fn = 36;
  angle = 360/segments;
  
  intersection() {
    color(clr)
    cylinder(r = r, h = h);
    color(clr)
    triangle(y = r, angle = angle, h = h);
  }
  
}

module spiral(rev = 4, r = 100, h = 40, segments = 12, column = 10) {
  colors = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"];
  angle = 360/segments;
  total = rev * segments;
  for(i = [0:total-1]) {
    rotate([0, 0, angle*i])
      translate([0, 0, (h+.01)/2*i])
      step(h = h, r = r, segments = segments, clr = colors[i%7]);
  }
  color("silver")
    cylinder(r = column, h = rev*h*segments/2 + (.01 * total));
}
spiral(rev = revolutions, r = radius, h = height, segments = segments, column = column);
