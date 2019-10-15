// Ammo Case
// for Freddie
//
// All measurements should be in mm.

$fn = 64;


rows = 1;                 // Number of spaces horizontally
columns = 2;             // Number of spaces vertically


width = 12.5;             // Internal width of a space. All spaces are square.
height = 77.0;            // Total height of the case. This should probably 
                          // the total  height of the bullet + a bit.
depth = 52.0;             // Depth of the hole you drop the bullet into.

wall_thickness = 1.5;     // Thickness of the walls
outer_wall_thickness = 2.0;   // Thickness of the outer walls

hole_diameter = 9.5;      // Diameter of the hole the tip of the bullet should
                          // go through. 

rounded_corners = true;
outer_corner_radius = 5;


// NOT YET IMPLEMENTED

bottom_corners_inverted = false;  // Should the lower corners be inverted?

structural_bracing = false;        // Include structural bracing?
bracing_row_freq = 1;             // How frequently to have a brace on rows
bracing_col_freq = 1;             // How frequently to have a brace on columns


module AmmoCase () {
  h_offset = (width / 2) + outer_wall_thickness;
  
  translate([h_offset, h_offset, 0]) {
    
    union() {    
      translate([0, 0, depth / 2 + height - depth]) hollow_square_block_section(width, wall_thickness, depth, rows, columns);
        
      translate([0, 0, height - depth - wall_thickness / 2]) midplate(width, wall_thickness, hole_diameter, rows, columns);      
      
      translate([0, 0, height / 2]) casing (width, wall_thickness, outer_wall_thickness, height, rows, columns);
        
    }
  }
}


// Extruded grid
module hollow_square_block_section (internal_width, wall_thickness, height, rows, cols) {
  total_width = internal_width + wall_thickness;
  
  module hollow_square_block () {
    difference() {
      rounded_cube([total_width, total_width, height], radius = wall_thickness, center = true);
      cube([internal_width, internal_width, height + 2], center = true);
    }
  }
  
  for (row = [0:rows-1]) {
    for (col = [0:cols-1]) {
      translate([row * total_width, col * total_width, 0]) hollow_square_block();
    }
  }
}

// Flat plate with holes
module midplate (internal_width, wall_thickness, hole_diameter, rows, cols) {
  total_width = internal_width + wall_thickness;
  
  module single_midplate () {
    difference() {
      rounded_cube([total_width, total_width, wall_thickness], radius = wall_thickness, center = true);
      cylinder(wall_thickness+2, d = hole_diameter, center = true);
    }
  }
  
   for (row = [0:rows-1]) {
    for (col = [0:cols-1]) {
      translate([row * total_width, col * total_width, 0]) single_midplate();
    }
  }
}

module casing (internal_width, inner_wall_thickness, outer_wall_thickness, total_height, rows, cols) {
  total_internal_width = (internal_width + inner_wall_thickness) * rows - inner_wall_thickness;
  total_internal_length = (internal_width + inner_wall_thickness) * cols - inner_wall_thickness;
  
  external_width = total_internal_width + (outer_wall_thickness * 2);
  external_length = total_internal_length + (outer_wall_thickness * 2);
  
  inner_corner_radius = outer_corner_radius - outer_wall_thickness;
  if (inner_corner_radius < 0) {
    inner_corner_radius = outer_corner_radius;
  }
  
  translate([(external_width - internal_width) / 2 - outer_wall_thickness, (external_length - internal_width) / 2 - outer_wall_thickness, 0]) difference() {
      rounded_cube([external_width, external_length, total_height], center = true);
      rounded_cube([total_internal_width, total_internal_length, total_height + 2], radius = inner_corner_radius, center = true);
  }
}

module rounded_cube (dimensions, radius = outer_corner_radius, center = false) {
  module corner() {
    cylinder(dimensions[2], r = radius);
  }
  
  module rc_helper() {
    hull() {
      translate([radius, radius, 0]) corner();
      translate([dimensions[0]-radius, radius, 0]) corner();
    
      translate([radius, dimensions[1]-radius, 0]) corner();
      translate([dimensions[0]-radius, dimensions[1]-radius, 0]) corner();
    }
  }
  
  if (rounded_corners) {
    if (center) {
      translate([-dimensions[0]/2, -dimensions[1]/2, -dimensions[2]/2]) rc_helper();
    } else {
      rc_helper();
    }
  } else {
    cube(dimensions, center = center);
  }
}

AmmoCase();


