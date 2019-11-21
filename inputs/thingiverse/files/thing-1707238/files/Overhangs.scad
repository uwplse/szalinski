num_holes = 6;
gap_width = 2;
hole_width = 3;

module overhangs() {
  echo(str("Doing ", num_holes, " holes from ", hole_width, " to ", num_holes * hole_width, " mm"));
  length = (num_holes + 1) * gap_width
    + (num_holes * (num_holes + 1)) / 2 * hole_width;
  difference() {
    union() {
      difference() {
        cube([length, 5, 9]);
        
        translate([1, 1, -1])
          cube([length - 2, 3, 11]);
        for (i = [1:num_holes]) {
          translate([i*gap_width+(i*(i-1))/2*hole_width, -1, 3.5])
            cube([i*hole_width, 3, 3]);
        }
        for (i = [1:num_holes]) {
          translate([i*gap_width+i*hole_width/2+(i*(i-1))/2*hole_width, 3, 6.5-(i*hole_width/2)])
            rotate([-90, 0, 0])
              cylinder(d=i*hole_width, h=4, $fn=40);
        }
      }
      cube([length, 5, 1]);
      translate([0, 0, 8])
        cube([length, 5, 1]);
    }
    for (i = [1:num_holes]) {
      translate([i*gap_width+(i+i*(i-1))/2*hole_width, 0.2, .3])
        rotate([90,0,0])
          linear_extrude(height = 0.5)
            text(text=str(i*hole_width), size=3, halign="center", font="Liberation Sans");
    }
  }
}

overhangs();
