// A highly customizable S-Hook
// http://6brueder.wordpress.com
// October 2013
// Public Domain - Creative Commons CC0 1.0

// Inner diameter of the first ring
diameter_1              = 20;	// [1:200]

// Inner diameter of the second ring
diameter_2              = 15;	// [1:200]

// Distance between both rings
distance_type           = 1;	// [1:Manual distance,2:Closest distance]

// Only be used when "Distance Type = Manual distance"
manual_distance         = 30;	// [1:300]

// Strength of the rings, % in relation to the larger diameter
ring_strength           = 25;	// [1:100]

shape                   = 1;	// [1:S-Shape,2:3-Shape]

/* [Vents] */
vent_1_rotation         = 0;	// [-90:45]
vent_2_rotation         = 45;	// [-90:45]

// Size of the first vent in % in relation to the larger diameter
vent_1_strength         = 66;	// [1:100] 

// Size of the second vent in % in relation to the smaller diameter
vent_2_strength         = 66;	// [1:100]


// Calculations
large                   = diameter_1 > diameter_2 ? diameter_1 : diameter_2;
small                   = diameter_1 > diameter_2 ? diameter_2 : diameter_1;
ring_strength_normalized= ring_strength / 100;
global_height           = large * ring_strength_normalized;


// Distance
real_manual_distance    = manual_distance + diameter_1 / 2 + diameter_2 / 2;
closest_distance			= large / 2 + small / 2 + global_height;
distance_normalized     = distance_type == 1 ? real_manual_distance : closest_distance;


// Vents
vent_size_1             = large * (vent_1_strength / 100);
vent_size_2             = small * (vent_2_strength / 100);

shape_normalized        = shape;

vent_2_rotation_calc    = (shape_normalized == 1) ? (-vent_2_rotation + 180) : vent_2_rotation;


// Ring module
module ring(inner_diameter) {
    ring_size = inner_diameter * ring_strength_normalized;

    difference() {
        cylinder(h = global_height, r = (inner_diameter/2) + ring_size);
        translate([0,0,-0.1]) cylinder(h = global_height + 0.2, r = (inner_diameter/2));
    }
}


translate([-distance_normalized/2,0,0]) {
	difference() {
	    union() {
	        // First ring
	        ring(large);
	        
	        // Second ring
	        translate ([distance_normalized,0,0]) ring(small);
	        
	        
	        difference() {
	            // Connection bar
	            translate([0,-global_height * 1.6/2,0]) cube([distance_normalized, global_height * 1.6, global_height]);
	            
	            // The holes
	            union() {
	                translate([0,0,-0.1]) cylinder(h = global_height + 0.2, r = (large/2));
	                translate([distance_normalized,0,-0.1]) cylinder(h = global_height + 0.2, r = (small/2));
	            }
	        }
	    }
	    
	    // Vents
	    union() {
	         rotate(-vent_1_rotation) translate([-vent_size_1/2,0,-0.1]) cube([vent_size_1, large/2 + global_height + 1, global_height + 0.2]);
	
	        translate ([distance_normalized,0,0]) {
	            rotate(vent_2_rotation_calc) translate([-vent_size_2/2,0,-0.1]) cube([vent_size_2, small/2 + global_height + 1, global_height + 0.2]);
	        }
	    }
	}
}

//preview[view:east,tilt:top]
$fn = 90;