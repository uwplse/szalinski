radius = 50;
wall_t = 2;
wall_h = 10;
slices = 10;

slice_angle = 360 / slices;

for (slice = [1 : slices]) {
  rotate([0, 0, slice_angle * (slice - 1)])
    translate([-wall_t / 2, 0, 0])
    cube(size = [wall_t, radius, wall_h], center=false);
}