include <threads.scad>

// Filter basket inner diameter
filter_diameter = 58.8;
filter_radius = filter_diameter / 2;

// Base above the blade
base_height = 22;
spindle_diameter = 12;
depth = 5;

// Optional Screw Hole
has_screw_hole = 1;

// To insert a screw in the top... may not be necessary
screw_diameter = 5.05;
screw_length = 19.7;

// Lower threads
thread_pitch = 2.8;
thread_length = base_height - depth;
thread_size = 2;

has_blades = false;

// Blade section of the leveler
blade_height = 6;
blade_overlap = 5;
blade_top_width = 5;
blade_width = filter_radius - 
              blade_overlap - 
              blade_top_width;

// Curve for Blade
cp1 = [-blade_overlap, 0];
cp2 = [blade_width - 10, 1];
cp3 = [blade_width - 5, blade_height];
cp4 = [blade_width, blade_height];

// Top
wall_gap = 0.3;      // Gap between the base and the top
wall_thickness = 4;  // Good thickness to sit on top of the filter
column_wall_thickness = 2;
bottom_gap = 0;      // Minimum amount of the blade to have exposed (Top slides up)
top_thickness = 2;

// Lower Section
inner_radius = filter_radius + wall_gap;
outer_radius = inner_radius + wall_thickness;
bottom_cylinder_height = base_height + top_thickness + 
                            blade_height - bottom_gap;

// Ring height
lower_ring_height = depth + thread_pitch * 2;
top_height = bottom_cylinder_height - lower_ring_height;
                            
$fn = 130;

function bezier_coordinate(t, n0, n1, n2, n3) = n0 * pow((1 - t), 3) + 3 * n1 * t * pow((1 - t), 2) + 3 * n2 * pow(t, 2) * (1 - t) + n3 * pow(t, 3);

function bezier_point(t, p0, p1, p2, p3) = 
    [
        bezier_coordinate(t, p0[0], p1[0], p2[0], p3[0]),
        bezier_coordinate(t, p0[1], p1[1], p2[1], p3[1])
    ];

function bezier_curve(t_step, p0, p1, p2, p3) = [for(t = [0: t_step: 1 + t_step]) bezier_point(t, p0, p1, p2, p3)];

points = concat(bezier_curve(0.05, cp1, cp2, cp3, cp4), 
        // Bevel
        [[filter_radius - 0.8, blade_height], 
         [filter_radius - 0.2, blade_height - 0.3], 
         [filter_radius,       blade_height - 0.8], 
         [filter_radius,       0],
         [-blade_overlap,      0]]);
  
module blade(x_pos, y_pos, angle) {
  translate([x_pos, y_pos, 0])
    rotate([-90, 0, angle])
      linear_extrude(filter_radius) {
        polygon(points);
      }  
}

module fillet_cylinder(height, diameter, radius = 1) {
  translate([0, 0, height - radius])
    rotate_extrude(convexity=10)
      translate([diameter - radius, 0, 0]) {
        difference() {
          square([radius, radius], center=1);
          circle(r=radius);
        }
      }
}

module wedge(angle = 0) {
  rotate([0, 0, angle])
    translate([0, filter_radius, 0])
      rotate([90, 0, 0])
        linear_extrude(height = filter_diameter)
            polygon(points = [[0,0], [0, -blade_height], [filter_radius, 0]], 
                    paths = [[0, 1, 2, 0]],
                    convexity = 3);
}

module base() {
    union() {
      intersection() {
        if (has_blades) {
          union() {
            blade(filter_radius - blade_overlap, filter_radius, 180);
            blade(-filter_radius + blade_overlap, -filter_radius, 0);
            blade(filter_radius, -filter_radius + blade_overlap, 90);
            blade(-filter_radius, filter_radius - blade_overlap, -90);
          }
        } else {
          // Create Wedge
          wedge(0);
          wedge(180);
        }
        
        // Slice off the edges
        translate([0, 0, -blade_height])
          cylinder(h=blade_height, r = filter_radius);
      }
      
    // Create the base section above the blade
    cylinder(h=base_height, r = filter_radius);    
          
    translate([0, 0, base_height - thread_length])
      metric_thread(diameter=filter_diameter + thread_size, 
                     pitch=thread_pitch, length=thread_length,
                     thread_size=thread_size, groove=false,
                     internal=false, n_starts=2);
  }
}

module slot(angle) {
  rotate([0,0,angle])
    translate([inner_radius - 0.1, -(slot_width / 2), 0])
      cube([slot_depth + 0.1, 
            slot_width, 
            bottom_cylinder_height - top_thickness]);
}

module top(offset = 0) {
  translate([0, 0, offset]) {
    difference() {
     // Create the outside bottom cylinder 
     cylinder(h = top_height, 
              r = outer_radius);

      fillet_cylinder(top_height, outer_radius, 2);
                 
      // Remove the inner section of the bottom
      cylinder(h = top_height - top_thickness, 
               r = inner_radius);
      
      metric_thread(diameter=inner_radius * 2 + thread_size, 
                     pitch=thread_pitch, 
                     length=top_height - top_thickness,
                     thread_size=thread_size, groove=false,
                     internal=true, n_starts=2);

    }
  }
}

module ring(offset = 0) {
  translate([0, 0, offset]) {
    difference() {
     // Create the outside bottom cylinder 
     cylinder(h = lower_ring_height, 
              r = outer_radius);
                 
      // Remove the inner section of the bottom
      cylinder(h = lower_ring_height, 
               r = inner_radius);
      rotate([0, 180, 0])
        fillet_cylinder(0, outer_radius);

      metric_thread(diameter=inner_radius * 2 + thread_size, 
                     pitch=thread_pitch, 
                     length=lower_ring_height,
                     thread_size=thread_size, groove=false,
                     internal=true, n_starts=2);

    }
  }
}

shift = 5;

intersection() {
  union() {
    base();
    ring(shift);
    top(shift + lower_ring_height);
  }
  
  //translate([0, -40,0])
    //cube([80,80,150], center=true);
}

