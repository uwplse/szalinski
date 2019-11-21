/* Customisable hook */

//preview[view:east, tilt:top diagonal]

/* All lengths in millimetres */

// Length of horizontal arm from vertical support to the centre of the holder
arm_length = 140;

// Length of vertical support
support_length = 180;

// Diameter of holder
holder_diameter = 40;

// Cut a section out of the hook?
create_cutout = "Yes"; // [Yes, No]

// Inside measurement along the top of the hook
hook_inside_top_length = 25;

// Inside measurement down the back of the hook
hook_inside_back_length = 25;

// Length of standoff to hold support from wall (set to 0 if not needed)
standoff_length = 9.5;

// Height of standoff
standoff_height = 20;

// Horizontal size - thicker is more sturdy
thickness = 15;

// Bulk - bulkier is more sturdy
bulk = 10;

// Smoothness
smoothness = 30; // [30: Rough, 60: Okay, 120: Good, 180: Very good]
$fn = smoothness;

/* Calculated values */

holder_radius = holder_diameter / 2;

holder_inside_radius = holder_radius - bulk;

hook_top_length = hook_inside_top_length + bulk;
hook_back_length = hook_inside_back_length + bulk;

triangle_length = sqrt(pow(sqrt(pow(arm_length,2)+pow(support_length-(holder_radius- bulk/2),2)),2)-pow((holder_radius- bulk/2),2));

triangle_angle = atan(arm_length/(support_length-(holder_radius- bulk/2)))+ atan((holder_radius-bulk/2)/triangle_length);

create_hook();

module create_hook() {
    translate([0,hook_back_length+bulk/2,0-bulk/2])
        difference() {
            union() {
                back_hook();
                structure();
                holder();
            }
            if (create_cutout == "Yes") {
                cutout();
            }
        }
}

module back_hook() {
    /* Hook */
    /* Back of hook */
    translate([0,0-hook_top_length,0])
        union() {
            translate([0,0,0-hook_back_length])
                rotate([0,90,0])
                    cylinder(h = thickness, r = bulk/2);
            translate([0,0-bulk/2,0-hook_back_length])
                cube([thickness, bulk, hook_back_length]);
        }      
    /* Top of hook */
    translate([0,0-hook_top_length,0])
        union() {
            translate([0,0,0])
                rotate([0,90,0])
                    cylinder(h = thickness, r = bulk/2);
            translate([0,0,0-bulk/2])
                cube([thickness, hook_top_length, bulk]);
        }    
}


module structure() {
    /* Vertical support */
    translate([0,0,0-support_length])
        union() {
            translate([0,0,0])
                rotate([0,90,0])
                    cylinder(h = thickness, r = bulk/2);
            translate([0,0-bulk/2,0])
                cube([thickness, bulk, support_length]);
        }

    /* Standoff */
    translate([0,0-standoff_length-bulk/2,0-support_length-bulk/2])    
        cube([thickness, standoff_length+bulk/2, standoff_height]);

    /* Arm */
    translate([0,0,0-bulk/2])
        cube([thickness, arm_length, bulk]);
        
    /* Triangle */
    translate([0,0,0-support_length])
        rotate([0-triangle_angle,0,0])
            translate([0,0-bulk/2,0])
                cube([thickness, bulk, triangle_length]);    
}

module holder() {
    translate([0,arm_length,0-holder_radius+bulk/2])
        rotate([0,90,0])
            difference() {
                cylinder(h = thickness, r = holder_radius);
                translate([0,0,-1])
                    cylinder(h = thickness+2, r = holder_inside_radius);
            }    
}

module cutout () {
    translate([-1,arm_length-bulk/2,0-bulk])
        cube([thickness+2, bulk, bulk*2]);    
}

