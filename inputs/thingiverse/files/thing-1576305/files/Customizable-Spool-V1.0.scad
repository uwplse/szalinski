/* [Basics] */
// Diameter of the reel
full_diameter = 80;
// Diameter of the hole through the centre of the reel
hole_diameter = 10;
// Diameter of the rod that materials are wound on to.
winding_diameter = hole_diameter + 8;  // allows 4mm for keyways and keys
// The distance between the two plates
winding_width = 15;
// Thickness of the outer rim on each half of the reel
outer_rim = 5;
// Thickness of the inner rim on each half of the reel
inner_rim = 2;
// Thickness of the plates on each end of the reel
plate_thickness = 1;
// Diameter of holes for retaining spooled material can be set to zero if not required (must be smaller than the outer rim!)
through_hole_diameter = 1.5;

/* [Advanced] */
// Number of arms supporting the outer rim
arms = 3;
// The number of degrees making up each arm
arm_arc = 15;
// Number of keyways loking the two halves together (should be an odd number if through holse are required)
keyways = 3;
// Distance between interference fit surfaces
interference = 0.15;
// Space between the two halves of the reel
inter_piece_gap = 2;
// Distance from plate for the holes on the centre axle
reel_hole_edge_offset = 1;
// The radius of the filet on the radial arms of each plate
sector_filet_radius = 3;

// Constants
// Fudge factor for avoiding vertex/line/plane intersections
$fn=50 * 1;
d = 0.1 / 10;

// Radii
full_radius = full_diameter / 2;
hole_radius = hole_diameter / 2;
winding_radius = winding_diameter / 2;
half_arm = arm_arc / 2;
through_hole_radius = through_hole_diameter / 2;
mid_plate_rim_radius = full_radius - outer_rim / 2;

// Iterators
function divide_circle(divisions) = [0:360/divisions:359];
keyway_angles = divide_circle(keyways);
arm_angles = divide_circle(arms);

// Angles
keyway_angle = 360 / keyways;
arm_angle = 360 / arms;

// Functions
// Scaled sine for full radius
function s(theta, scale_factor=1) = full_radius * sin(theta) * scale_factor;
// Scaled cosine for full radius
function c(theta, scale_factor=1) = full_radius * cos(theta) * scale_factor;
// Scaled point for full radius
function p(theta, scale_factor=1) = [s(theta, scale_factor), c(theta, scale_factor)];
    

// Builds and extrudes a single plate
module plate() {
    // Defines the region between the inner and outer rim
    module inner(fudge=0) {
        difference() {
            circle(r=full_radius - outer_rim + fudge);
            circle(r=winding_radius + inner_rim - fudge);
        }
    }
    // Defines a through hole for the rim
    module through_hole() {
        translate([0, mid_plate_rim_radius, 0])
            circle(r=through_hole_radius);
    }
    
    module arms() {
        // Arms with outer radius
        difference() {
            inner(3 * d);
            // Radiused space between arms
            offset(r=sector_filet_radius) offset(r=-sector_filet_radius)
                // Space between arms
                difference() {
                    inner(2 * d);
                    // Build arms
                    intersection() {
                        inner(d);
                        for (a=arm_angles) {
                            polygon([[0, 0], p(a - half_arm, 2), p(a + half_arm, 2)]);
                        }
                    }
                }
        }
    }
    
    linear_extrude(height=plate_thickness)
    union() {
        difference() {
            // Outer perimiter
            circle(r=full_radius);
            // Hole perimiter
            circle(r=hole_radius);
            // Spokes cut out
            inner();
            // Through holes
            for (a=arm_angles) {
                rotate([0, 0, a])
                    through_hole();
                rotate([0, 0, a + arm_angle / 2])
                    through_hole();
            }
        }
        // Arms
        arms();
    }
}

//plate();

module centre_tube(inner) {
    mid_dia = (hole_radius + winding_radius) / 2;
    key_x_section = (winding_radius - hole_radius) / 3;
    half_x = key_x_section / 2;
    quarter_x = key_x_section / 4;
    
    fit = interference / 2;
    large_radius = inner ? mid_dia - fit : winding_radius;
    small_radius = inner ? hole_radius : mid_dia + fit;
    
    module through_hole() {
        translate([0, 0, 0])
            rotate([90, 0, 0])
                cylinder(h=large_radius + 1, r=through_hole_radius);
    }
    
    union() {
        difference() {
            // Outer surface
            cylinder(h=winding_width, r=large_radius);
            // Inner surface
            translate([0, 0, -1]) 
                cylinder(h=winding_width + 2, r=small_radius);
            if (inner) {
                // Remove key ways from outside surface
                for (a=keyway_angles) {
                    rotate([0, 0, a])
                        translate([-half_x - fit / 2, large_radius - 3 * quarter_x - fit / 2, -1])
                            cube([key_x_section + fit, key_x_section + fit, winding_width + 2]);
                }
                // Add the bevel to aid locating the keys in the keyways
                b = (large_radius - small_radius) / 2;
                translate([0, 0, winding_width - b + 2 * d])
                    rotate_extrude(convexity=10)
                        translate([-large_radius - 2 * d, 0, 0])
                            polygon([[0, 0], [0, b], [b, b]]);
            }
            // Remove threading hole from top and bottom
            translate([0, 0, winding_width - reel_hole_edge_offset])
                through_hole();
            translate([0, 0, reel_hole_edge_offset])
                through_hole();
        }
        if (!inner) {
            // Add keys to inside surface
            for (a=keyway_angles) {
                rotate([0, 0, a])
                    translate([-half_x + fit / 2, small_radius - 3 * quarter_x + fit / 2, 0])
                        cube([key_x_section - fit, key_x_section - fit, winding_width]);
            }
        }
    }
}
// centre_tube();

module half_reel(inner) {
    union() {
        plate();
        translate([0, 0, plate_thickness - d]) 
            centre_tube(inner);
    }
}

// Build the two halves of the reel
union() {
    half_reel(true);
    translate([full_diameter + inter_piece_gap, 0, 0]) 
        half_reel(false);
}
