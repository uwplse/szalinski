// number of pegs
clip_count = 12; // [1:60]

// Width of one peg
clip_width = 8;

// Length of the pegs
clip_length = 30;

// Thickness of the peg walls 
clip_wall = 1.2;

// Height
clip_height = 4;
clip_distance = 3.5;

// Space between the pegs.
gap = 0.2;

rod_diameter = 14.5; 
rod_wall = 2.5; // thickness of the rod clip wall

// Opening angle of the rod clip
alpha = 130; // [0.0:180.0]


$fn = 32;

// calculated
l = clip_count*clip_width + (clip_count-1)*(clip_distance + gap); // total length

// echo information
echo("total length is: ", l);


union() {

    // clips
    translate([0.5*clip_width, 0.5*rod_diameter + rod_wall, 0])
    for (i = [0:clip_count-1]) {
        dx = i*(clip_width+clip_distance+gap);
        
        translate([dx,0,0])
        difference() {
            
            // clip base
            union() {
                // clip shape
                translate([-0.5*clip_width,0,0])
                cube([clip_width, clip_length - 0.5*clip_width, clip_height]);                
                translate([0,clip_length - 0.5*clip_width,0]) 
                cylinder(h=clip_height, d=clip_width);
                
                // teeth
                translate([-0.5*clip_width, clip_length - 0.5*clip_width - 0.5*clip_distance, 0]) 
                cylinder(h=clip_height, d=clip_distance);
                translate([0.5*clip_width, clip_length - 0.5*clip_width - 0.5*clip_distance, 0]) 
                cylinder(h=clip_height, d=clip_distance);
                translate([-0.5*clip_width,0.5*(clip_length - 0.5*clip_width), 0]) 
                cylinder(h=clip_height, d=clip_distance);
                translate([0.5*clip_width,0.5*(clip_length - 0.5*clip_width), 0]) 
                cylinder(h=clip_height, d=clip_distance);
                
            }
            
            // clip inner pocket
            union() {
                translate([-0.5*clip_width+clip_wall,0,0])
                cube([clip_width-2*clip_wall, clip_length - 0.5*clip_width, clip_height]);
                
                translate([0,clip_length - 0.5*clip_width,0]) 
                cylinder(h=clip_height, d=clip_width-2*clip_wall);
            }
        }
    }

    // rod clip
    translate([0, 0, 0.5*rod_diameter+rod_wall])
    rotate([0, 90, 0])
    difference() {
        union() {
            // outer rod                
            cylinder(h=l, d=rod_diameter+2*rod_wall);                
            cube([0.5*rod_diameter + rod_wall, 0.5*rod_diameter + rod_wall, l]);
        }
        // rod hole
        cylinder(h=l, d=(rod_diameter));
        
        // opening
        linear_extrude(height=l) {
        polygon([
            [0,0],
            [-cos(0.5*alpha)*(0.5*rod_diameter + rod_wall),sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)],
            [-(0.5*rod_diameter + rod_wall),sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)],
            [-(0.5*rod_diameter + rod_wall),-sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)],
            [-cos(0.5*alpha)*(0.5*rod_diameter + rod_wall),-sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)]
            ]);
        }
    }
}

