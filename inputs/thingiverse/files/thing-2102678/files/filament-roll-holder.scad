/* https://www.thingiverse.com/thing:2102678 */

// Current part display
part = "both"; // [both:Both, holder:Holder, rod:Rod]

// Should we offset the mount part?
mount_center_offset = 0; // [-50:50]

// Thickness (Y-wise) of the arms
arm_thickness = 12;
// Width (X-wise) of the arms
arm_width     = 16;

// Maximum width of a roll to fit between the arms
roll_width = 80;
// Maximum diameter of a roll to account for
roll_diameter = 200;
// The biggest roll center hole to account for
roll_hole_diameter = 60;

// Support rod diameter
rod_diameter = 7.5;

// How far down will the slanted support reach?
// 0.0 disables it, 1.0 will reach all the way down.
mount_support_height_ratio = 0.5;

/* [Hidden] */

rod_support_thickness = 4;
rod_clearance = 8; // Extra width on the rod

// 2020 aluminum bar
bar_width = 20 + 1;
bar_center_width = 6; // The center hole

base_height = 8;     // The "floor" between the arms
mount_thickness = 5; // The thickness of the prongs
mount_height = 16;

// Screw hole
mount_hole_diameter  = 4.0 + 0.75;
// Screw well
mount_hole_well = 8.0;


clearance_margin = 25;
minimum_clearance = (roll_diameter + roll_hole_diameter)/2 + clearance_margin;

output_part();

// Creates two mirrored arms with the given distance, height and thickness
module holder_arms(arm_separation, arm_width, arm_thickness, arm_height) {
    module single_arm() {
        translate([arm_separation/2, 0])
            cube([arm_thickness, arm_height, arm_width]);
    }
    union() {
        mirror() single_arm();
                 single_arm();
    }
}

// Roll holder
module roll_holder() {
    difference() {
        holder_arms(roll_width, arm_width, arm_thickness, minimum_clearance);
        
        r_d = rod_diameter + 0.5; // Adjust fit a bit
        
        // Left cube slot
        translate([-roll_width/2-arm_thickness - 1, minimum_clearance-r_d, (arm_width-r_d)/2])
            cube([arm_thickness+2, r_d, r_d]);
        
        // Right cylinder slot
        hull() {
            
            translate([roll_width/2-1, minimum_clearance, (arm_width-r_d)/2])
                cube([arm_thickness+2, r_d, r_d]);
            translate([roll_width/2-1, minimum_clearance-(r_d/2), (arm_width)/2])
                rotate([0, 90,0]) cylinder(d=r_d, h=arm_thickness+2);
        }
    }
    
    mount_bot_w = bar_width + mount_thickness*2;
    mount_bot_hull_h = mount_height * mount_support_height_ratio;
    // Bottom structure
    difference() {
        union() {
            hull() {
                // Center base "floor"
                translate([0, base_height/2, arm_width/2])
                    cube([roll_width + arm_thickness*2, base_height, arm_width], center=true);
                // The end piece for slanted supports
                translate([-mount_bot_w/2 + mount_center_offset, -mount_bot_hull_h, 0])
                    cube([mount_bot_w, mount_bot_hull_h, arm_width]);
            }
            
            // Full-size end piece for prongs
            translate([-mount_bot_w/2 + mount_center_offset, -mount_height, 0])
                    cube([mount_bot_w, mount_height, arm_width]);
        }
        
        // Remove 2020 (fudged a bit for clean previews)
        translate([-bar_width/2 + mount_center_offset, -bar_width-1, -1])
                cube([bar_width, bar_width+1, arm_width+2]);
    }
    
    translate([mount_center_offset, 0]) {
        // Center plug for mount
        translate([-bar_center_width/2, -bar_center_width])
            cube([bar_center_width, bar_center_width, arm_width]);
        
        // Mount lip
        translate([0,0, arm_width]) {
            lip_w1 = mount_bot_w;
            lip_w2 = bar_width;
            lip_l  = 15;
            difference() {
                hull() {
                    // Base
                    translate([-lip_w1/2, 0, -arm_width]) cube([lip_w1, base_height, arm_width]);
                    // End
                    translate([-lip_w2/2, 0, lip_l-1]) cube([lip_w2, base_height, 1]);
                }
                // Screw hole
                translate([0, base_height, lip_l/2]) rotate([90,0,0]) {
                    cylinder(d=mount_hole_diameter, h=base_height+1, $fn=12);
                    translate([0,0,-1]) cylinder(d=mount_hole_well, h=3+1, $fn=12);
                }
            }
        }
    }
}

module roll_rod() {
    // Make the slot fit better
    spacing = 0.5;
    p_h = rod_diameter - spacing;
    // Center piece
    translate([-spacing, -p_h/2])
        cube([arm_thickness+spacing, rod_diameter, p_h]);
    
    // Back prong
    translate([-rod_support_thickness-spacing, -p_h/2])
            cube([rod_support_thickness, p_h*2, p_h]);
    // Front prong
    translate([arm_thickness, -p_h/2])
            cube([rod_support_thickness, p_h*2, p_h]);
    
    // Handle
    handle_w = 25;
    translate([-handle_w-spacing-rod_support_thickness, -p_h/2]) difference() {
        cube([handle_w, p_h*2, p_h]);
        translate([handle_w/2, p_h*2+6, -1]) cylinder(d=25, h=p_h+2);
    }
    
    // Cyl
    translate([arm_thickness, 0, p_h/2])
        rotate([0,90,0]) cylinder(d=p_h, h=roll_width + arm_thickness + rod_clearance, $fn=16);
}
//part="rod";
module output_part() {
    if (part == "both") {
        roll_holder();
        
        translate([0, minimum_clearance-(rod_diameter/2) + 1, (arm_width)/2])
            translate([-roll_width/2 - arm_thickness, 0,0]) rotate([180,0,0])
            translate([0,0,-rod_diameter/2]) color("red") roll_rod();
    } else if (part == "holder") {
        roll_holder();
    } else if (part == "rod") {
        roll_rod();
    }
}