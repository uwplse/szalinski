width = 20;
height = 20;
depth = 20;
wall_thickness = 1;
difference() {
  cube([width, depth, height], center=true);

  translate([0, 0, wall_thickness]){
    cube([(width - 2 * wall_thickness), (depth - 2 * wall_thickness), height], center=true);
  }
}