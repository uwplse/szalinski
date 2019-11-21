// Height of the container in millimeters
container_height = 80; //[20:200]

// Inside diameter of the container in millimeters
inside_diameter = 60; //[10:300]

// Number of sides for design
num_sides = 8; //[4:32]

// Detail and smoothness
resolution = 512; //[32:1024]

// Roundness of corners
roundness = 10; //[0:30]

// The wall thickness in millimeters
thickness = 1; //[0.4:0.1:4]

// The amount of twist
twistiness = 90; //[0:360]


module twisty_container() {
  inside_r = inside_diameter / 2 - roundness + thickness;
  outside_r = inside_r + thickness;
  
  // bottom
  linear_extrude(height = thickness) {
    offset(r = roundness) {
      
      circle(inside_r + 0.1, $fn=num_sides);
    }
  }
  
  // container body
  linear_extrude(height = container_height, twist = twistiness, slices = resolution) {
    difference() {
      offset(r = roundness) {
        circle(outside_r, $fn=num_sides);
      }
      offset(r = roundness - thickness) {
        circle(inside_r, $fn=num_sides);
      }
    }
  }
}

twisty_container();