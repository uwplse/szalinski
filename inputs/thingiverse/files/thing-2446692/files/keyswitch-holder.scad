// Minimum Face Size
$fs = 0.3;

// Wall Thickness
wall_thickness = 1;

// Hole Diameter
hole_diameter = 5.2;
hole_radius = hole_diameter/2;

// Switch Base Size
switch_base_size = 14;

// Switch Count
switch_count = 6;

// Switch Hole Depth
switch_hole_depth = 9.5;

// Base Height
base_height = 12;

// Skirt Height
skirt_height = 2;

// Skirt Offset
skirt_offset = 6;

// Skirt Radius
skirt_radius = 2;

// Switch Spacing
switch_spacing = 6;


base_y = (switch_base_size + (wall_thickness * 2));
base_x = ((switch_base_size + (wall_thickness * 2)) * switch_count) + (switch_spacing * (switch_count - 1));
switch_padding = ((switch_base_size + (wall_thickness * 2)) - switch_base_size);

// base
module base() {
  translate([0 - (switch_padding/2), 0 - (switch_padding/2), 0]) {
    cube([base_x,base_y,base_height], false);
  }
}

// switch holes
module switch_holes() {
  for(i = [0:switch_count-1]) {
    translate([i * (switch_base_size + (wall_thickness * 2) + switch_spacing), 0, 0]) {
      cube(switch_base_size, false);
    }
  }
}

module skirt(offset, height, radius) {
  offset = (offset * 2) - (radius * 2);
  translate([0 - (switch_padding/2) - (offset/2), 0 - (switch_padding/2) - (offset/2), 0]) {
    linear_extrude(height) {
      minkowski() {
        square([base_x + offset, base_y + offset], false);
        circle(r = radius, center = true);
      }
    }
  }
}

// assembly
translate([switch_padding/2, switch_padding/2, 0]) {
  difference() {
    union() {
      translate([0, 0, skirt_height]) {
        base();
      }
      skirt(skirt_offset, skirt_height, skirt_radius);
    }
    translate([0, 0, skirt_height]) {
      switch_holes();
    }
    translate([(base_x/2) + switch_base_size/2, (base_y/2) - (switch_padding/2), skirt_height + hole_radius]) {
      rotate([0, 90, 0]) {
        cylinder(h = base_x, d = hole_diameter, center = true);
      }
    }
  }
}