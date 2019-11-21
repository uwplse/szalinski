// Customizable mud guard (for bikes)
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// licensed under the Creative Commons - Attribution license. 
//
// Remix of Fender mud guard for mtb 
// https://www.thingiverse.com/thing:1235562
// by stefano22
// https://www.thingiverse.com/stefano22/about
// licensed under the Creative Commons - Attribution license. 
//
// First revision 24 September 2017
// Second rev.  26 September 2017, corrected tangent-point computation

mudguard_length = 190; // [150:500]
mudguard_diameter = 50;    // [30:100]
mudguard_thickness = 1.5;   // [0.5:0.1:2.0]
mounting_hole_distance = 75; // [50:100]
drill_diameter = 5.2;          // [3.0:0.1:7.0]

MudGuard();

module MudGuard() {
  eps = 0.001;
  corner_radius = 2;
  extra_width = 4;           // "margin", distance from holes to edge
  mount_depth = drill_diameter + 2*extra_width;
  r = mudguard_diameter/2;
  
  // distance along curved shell from center to mounting hole
  hole_x = r*PI/2 + mounting_hole_distance - r;
  mount_width = 2*hole_x + drill_diameter + 2*extra_width;
    
  difference() {
    union() {
      // The actual mud guard
      translate([0, mount_depth/2 - eps])
        MainMudGuard(length = mudguard_length - mount_depth/2 + eps,
                        max_width = 2*hole_x);
      // The piece that attaches to the bike
      RoundBox(mount_width, mount_depth, mudguard_thickness, corner_radius, $fn=24);
    }
    MountingHoles(hole_x);
  }
}


// The actual mud guard
module MainMudGuard(length, max_width) {
  // Constructed from circles of radius r, 
  // with a center-to-center distance of (dist_x, dist_y)
  // Circles are used for the round ending and the fillets
  r = min(mudguard_diameter, max_width)/2;
  dist_x = min(3*r, max_width);
  dist_y = length - 2*r;
  dist = sqrt(dist_x*dist_x + dist_y*dist_y);
  
  // Compute the tangent points
  beta = atan2(dist_y, dist_x);
  gamma = acos(2*r/dist);
  alpha = gamma - beta;
  dx = r*cos(alpha);
  dy = r*sin(alpha);
  
  difference() {
    union() {
      linear_extrude(height=mudguard_thickness)
        polygon([[0, length], // end of mudguard
                 [dx, length - r + dy], // tangent point of first circle
                 [dist_x - dx, r - dy], // tangent point of second circle
                 [dist_x, 0], // base of mud guard
                 [-dist_x, 0], // and so on... (symmetric)
                 [-dist_x + dx, r - dy],
                 [-dx, length - r + dy]]);
      // Circular end
      translate([0, dist_y + r])
        difference() {
          cylinder(r=r, h=mudguard_thickness, $fn=120);
          // remove the part beyond the tangent point
          translate([-r, -r])
            cube([2*r, r+dy, mudguard_thickness]);
        }
    }
    
    // Fillets
    for (x=[-1, +1])
      translate([x*dist_x, r])
        difference() {
          cylinder(r=r, h=mudguard_thickness, $fn=120);
          // remove the part beyond the tangent point
          translate([-r, -dy])
              cube([2*r, r+dy, mudguard_thickness]);
        }
  }
}

// The piece with that attaches to the bike
module Mount() {
  r = mudguard_diameter/2; 
  hole_x = PI*r/2 + mounting_hole_distance - r;
  extra_width = 4;           // "margin", distance from holes to edge
  width = 2*(hole_x + drill_diameter/2 + extra_width);
  min_depth = 0; //25.4;
  depth = max(drill_diameter+2*extra_width, min_depth);
  corner_radius = 2;
  
  difference() {
    union() {
      RoundBox(width, depth, mudguard_thickness, corner_radius);
      translate([-7.5, 0]) {
        cube([15, 17, mudguard_thickness]);
        translate([0, 15])
          cube([15, 2, 15+mudguard_thickness]);
        translate([0, 13])
          cube([15, 4, 4]);
      }
    }
    MountingHoles(hole_x);
  }
}

module MountingHoles(hole_x) {
  // center
  cylinder(d=drill_diameter, h=mudguard_thickness);
  
  // sides
  for (x=[-1, +1])
    translate([x*hole_x, 0])
      cylinder(d=drill_diameter, h=mudguard_thickness);
}

// Box with rounded corners (in the xy-plane)
module RoundBox(w, d, h, r) {
  // rounded corners
  for (x=[-0.5, +0.5], y=[-0.5,+0.5])
    translate([x*(w - 2*r), y*(d - 2*r)])
      cylinder(r=r, h=h);
  // fill in the hull
  translate([-w/2 + r, -d/2])
    cube([w - 2*r, d, h]);
  translate([-w/2, -d/2 + r])
    cube([w, d - 2*r, h]);
}
