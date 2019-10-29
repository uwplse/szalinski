// Wrench Hanger.
// Inspired by:
//     https://www.thingiverse.com/thing:2490206
// Unfortunately, it was too small for my wrenches. :-(

/* [General Asthetics] */

// Wrench Spacing (On Center)
w_oc = 18;

/* [Wrench Set Info] */

// Number of Wrenches
wrenches = 10;

// Largest Wrench neck thickness (just below full-boxed end)
largest_wrench_neck_thickness = 8;
// Outside diameter of the largest wrench boxed end.
largest_wrench_box_end_od = 40;

// thinnest_wrench_neck_thickness Wrench body (thickest portion of the body -- since this one is probably short)
thinnest_wrench_neck_thickness = 4.5;
smallest_wrench_box_end_od = 12;

// Wrench Step Size (How much space to add for each wrench in the series up to the largest_wrench_neck_thickness)
wrench_size_step = 1;

/* [Mount Holes] */

// Mounting hole specs;
mount_diameter = 6.5;
mount_oc = 26.5;

// Slew to use for calculating mount hole positions. (Used for mount holes after the first set.)
mount_slew = 1; 

// Force the mount points to advance this many wrench slots from the first available candidate.
mount_advance = 1;


/* [Hidden] */
$fn = 50;


first_mount_candidate = ((mount_diameter - thinnest_wrench_neck_thickness) / wrench_size_step) + 1 + mount_advance;
first_mount_location = (first_mount_candidate * w_oc) - (w_oc / 2);

// Calculate the slope of the outer line.
y_slope = (largest_wrench_box_end_od - smallest_wrench_box_end_od) / (wrenches * w_oc);

rotate([-90, 0, 0])
difference() {
    hull() {
        intersection() {
            union() {
                // Initial box-end recesses at the top
                hull() {
                    rotate([0, 90, 0]) 
                        translate([-smallest_wrench_box_end_od/ 2, 
                                        -smallest_wrench_box_end_od / 2, 
                                        0]) 
                            cylinder(d = smallest_wrench_box_end_od, h = 0.01);

                    rotate([0, 90, 0]) 
                        translate([-largest_wrench_box_end_od / 2, -largest_wrench_box_end_od / 2, (wrenches * w_oc) - 0.01]) 
                            cylinder(smallest_wrench_box_end_od, d = largest_wrench_box_end_od, h = 0.01);
                }
                
                // Shifted a bit lower to cause it to look 'bulky'.
                translate([0, 0, -mount_oc / 2]) hull() {
                    rotate([0, 90, 0]) 
                        translate([-smallest_wrench_box_end_od/ 2, -smallest_wrench_box_end_od / 2, 0]) 
                            cylinder(d = smallest_wrench_box_end_od, h = 0.01);

                    rotate([0, 90, 0]) 
                        translate([-largest_wrench_box_end_od / 2, -largest_wrench_box_end_od / 2, (wrenches * w_oc) - 0.01]) 
                            cylinder(smallest_wrench_box_end_od, d = largest_wrench_box_end_od, h = 0.01);
                }
                
                translate([0, 0, -(mount_oc) - 5]) 
                    cube([wrenches * w_oc, 2, mount_oc + 10]);
            }
            
            translate([0, -largest_wrench_box_end_od, -mount_oc- 5]) 
                cube([wrenches * w_oc, 2 + largest_wrench_box_end_od, mount_oc + 10]);
        }
        
    }
        
    // Cut out wrench handles
    for ( i = [1 : wrenches]) {
        echo ("Calculating Wrench Position", i);
        this_step = min(thinnest_wrench_neck_thickness + ((i - 1) * wrench_size_step), largest_wrench_neck_thickness);
        echo ("   width: ",  this_step);

        if (i == first_mount_candidate) {
            echo("    first Mount Location", first_mount_location);
             translate([(i * w_oc) - (w_oc / 2), -largest_wrench_box_end_od / 2, 0]) rotate([-90, 0, 0]) cylinder(d = mount_diameter, h = largest_wrench_box_end_od + 5);
             translate([(i * w_oc) - (w_oc / 2), -largest_wrench_box_end_od / 2, -mount_oc]) rotate([-90, 0, 0]) cylinder(d = mount_diameter, h = largest_wrench_box_end_od + 5);
        }
        
        if (i > first_mount_candidate) {
            slot_center = (i * w_oc) - (w_oc / 2);
            
            left_candidate = slot_center - (this_step / 2) + ((mount_diameter - mount_slew) / 2);
            right_candidate = slot_center + (this_step / 2) - ((mount_diameter + mount_slew) / 2);
            
            for (mc = [first_mount_location + mount_oc :  mount_oc : right_candidate]) {
                if (mc >= left_candidate && mc <= right_candidate) {
                    echo("   Mount Location Confirmed: ", mc);
                     translate([(i * w_oc) - (w_oc / 2), -largest_wrench_box_end_od / 2, 0]) rotate([-90, 0, 0]) cylinder(d = mount_diameter, h = largest_wrench_box_end_od + 5);
                     translate([(i * w_oc) - (w_oc / 2), -largest_wrench_box_end_od / 2, -mount_oc]) rotate([-90, 0, 0]) cylinder(d = mount_diameter, h = largest_wrench_box_end_od + 5);
                }
            }
        }
        
        // location along the x -axis as a percentage.
        current_percentage = ((i * w_oc) - (w_oc / 2) - (this_step / 2)) / ((wrenches  * w_oc) + (2 * largest_wrench_neck_thickness));
        
        step_y_offset = ((largest_wrench_box_end_od - smallest_wrench_box_end_od) * current_percentage);
        
        x_center = (i * w_oc - (w_oc / 2));
        x_left = x_center - (this_step / 2);
        x_right = x_center + (this_step / 2);
        
        // Cutout for the wrench handle
        mirror([0, 1, 0]) {
            // Rounded left side.
            difference() {
                translate([x_left - 2, (y_slope * (x_left - 2)) + smallest_wrench_box_end_od - 2, -mount_oc - 5])
                    cube([2, 3, largest_wrench_box_end_od]);
                translate([x_left - 2, (y_slope * (x_left - 2)) + smallest_wrench_box_end_od - 2, -mount_oc - 5]) 
                    cylinder(d = 4, h = largest_wrench_box_end_od);
            }
            // Rounded right side.
            difference() {
                translate([x_right, (y_slope * (x_right+ 2)) + smallest_wrench_box_end_od - 2, -mount_oc - 5]) 
                    cube([2, 3, largest_wrench_box_end_od]);
                translate([x_right + 2, (y_slope * (x_right+ 2)) + smallest_wrench_box_end_od - 2, -mount_oc - 5]) 
                    cylinder(d = 4, h = largest_wrench_box_end_od);
            }
            
            // the slot
            translate([x_left, 0, -mount_oc - 5])
                cube([this_step, (y_slope * x_right) + smallest_wrench_box_end_od, largest_wrench_box_end_od]);
        }
    }
    
    // Make room for the boxed ends
    hull() {
        rotate([0, 90, 0]) 
            translate([-smallest_wrench_box_end_od/ 1.25, -smallest_wrench_box_end_od / 2, 0]) 
                cylinder(d = smallest_wrench_box_end_od, h = 0.01);

        rotate([0, 90, 0]) 
            translate([-largest_wrench_box_end_od / 2, -largest_wrench_box_end_od / 2, (wrenches * w_oc) - 0.01]) 
                cylinder(d = largest_wrench_box_end_od, h = 0.01);
    }
}  
