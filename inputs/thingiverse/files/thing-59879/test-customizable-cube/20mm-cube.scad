cube_size_width = 20; // [10:50]
cube_size_length = 20; // [10:50]
cube_size_height = 10; // [10:50]

// ignore this variable!
// foo=1;

// don't turn functions into params!
function BEZ03(u) = pow((1-u), 3);


difference() {
  union() {
    translate([0, 0, cube_size/2]) cube([cube_size_width,cube_size_length,cube_size_height], center=true);
    if (show_wheels == "yes") {
      translate([0, 0, cube_size/2]) rotate([0, 90, 0]) {
        cylinder(r=cube_size/2, h=cube_size+(wheel_thickness*2), center=true);
      }
    }
  }
  translate([0, 0, cube_size-hole_depth]) cylinder(r=hole_radius, h=hole_depth);
}          
        