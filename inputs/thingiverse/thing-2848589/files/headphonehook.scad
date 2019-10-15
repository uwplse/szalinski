// Design of a hook for headphones to go over cubicle wall
wall_thickness = 4;  // How thick to make the part
cube_wall = 27;  // Width of the cubicle wall + a bit extra (about 1mm)
total_height = 70;  // Height of the hook from top to bottom
hook_height = 18;  // How far up the headphone holding hook (plus a bit more for rounded edge)
hook_length = 40; // Headset band is 24mm, give extra room
width = 20;  

rounding_size = hook_length / 4;  // Rounding of the top of the headphone hook

$fn = 24;

union() {
    // Main inside wall
    cube([wall_thickness, total_height + wall_thickness, width]);
    
    // Hook bottom
    cube([hook_length + (2*wall_thickness), wall_thickness, width]);
    
    // Top of cube wall
    translate([-(cube_wall + wall_thickness), total_height, 0]) {
        cube([cube_wall + (2*wall_thickness), wall_thickness, width]);
    };
    
    // Cube outside wall hook
    translate([-(cube_wall+wall_thickness), total_height/2, 0]) {
        cube([wall_thickness, total_height/2 + wall_thickness, width]);
    };
    
    // Hook for headset
    translate([hook_length + wall_thickness, 0, 0]) {
        cube([wall_thickness, hook_height+wall_thickness, width]);
    };
    
    // Inside rounding
    translate([wall_thickness + rounding_size -.1, wall_thickness + rounding_size -.1, 0]) {
        rounding(180);
    };
    
    // Outside rounding
    translate([hook_length - rounding_size + wall_thickness+.1, wall_thickness + rounding_size -.1, 0]) {
        rounding(270);
    };
    
    // Rounding of headset hook
    translate([hook_length + wall_thickness + (.5 * wall_thickness), hook_height + wall_thickness, width/2]) {
        cylinder(h=width, r=wall_thickness/2, center=true);
    };
};

module rounding(spin) {
    rotate(a=spin, v=[0, 0, 1]) {
        difference() {
            cube([rounding_size,rounding_size, width]);
            translate([0, 0, -width]) {
                cylinder(h=width*3, r=rounding_size);
            };
        };
    };
};    