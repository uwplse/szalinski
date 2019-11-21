// Quality settings
$fs=0.2;
$fa=2;

// Make sure you set the size of these holes a larger by a few tenths 
// of a mm than the size of the screw.
screw_size = 5;
screw_head_size = 9;
countersunk_head = true;
support_thickness = 4;
// Distance between the back of the accessory holder and the backplate.
distance_from_backplate = 30;
wall_thickness = 3.5;
backplate_thickness = 7;
// If you use an end cap, 39 mm is more or less the minimal height, 
// otherwise the accessory won't slide in completely.
height = 39;

// These are the parameters that are dictated by the Dyson accessory
// dimensions. Normally, you shouldn't need to change them, only tweak
// them in case they don't work out for you for some reason.
inner_radius = 18.3;
outer_radius = inner_radius + wall_thickness;
connector_width = 27.5;
connector_height = 17.5;
groove_depth = 2;
groove_length = 42;
lock_notch_radius = 7.2;
lock_notch_depth = 2;
lock_notch_offset = 20;
unlock_button_radius = 9;
backplate_offset = backplate_thickness / 2 + outer_radius + distance_from_backplate;

// Here you define your Dyson accessory holder by combining elements.

// The center part of the holder,
difference() {
    holder(
        backplate_width = 75, 
        screw_position = -12.5, 
        with_support = false, 
        with_end_cap = true
    );
}

// then a lateral support towards the left
translate([-27.5, 0, 0])
lateral_support(distance = 55, rounding_radius = 4);

// and a left accessory holder
translate([-55, 0, 0]) 
rotate([0, 180, 0]) {
    holder(
        backplate_width = 35.5, 
        screw_position = -12.5, 
        with_support = true,
        locking = false
    );
}

// ...and a lateral support towards the right
translate([27.5, 0, 0])
lateral_support(distance = 55, rounding_radius = 4);

// and finally the right accessory holder
translate([55, 0, 0])
rotate([0, 180, 0]) {
    holder(
        backplate_width = 35.5, 
        screw_position = -12.5, 
        with_support = true,
        locking = false
    );
}

/*******************************************************
  The section below contains the definition of the elements 
  of a Dyson accessory holder:
   - holder
   - lateral_support (between holders)
   - backplate_screw_hole
 *******************************************************/

/* Generate an accessory holder, center of the bounding cylinder is [0,0,0]
   Parameters: 
     backplate_width: width of a backplate to screw it in a wall  
     screw_position: distance from center, do not pass this parameter
                     if you want no screw hole
     with_support: generate the support towards a backplate (by 
                   using lateral supports, you can have a holder
                   without support towards the back plate
     with_end_cap: cover the top end with a 1.5 mm cap
     extend_screw_hole: depending on the vertical postion of the
                            screw hole, you might need an extra hole 
                            in the front of the holder
     locking: if used upside down, you don't need or want it to lock 
              (gravity will keep it in place)
   
 */
module holder(backplate_width = 0, screw_position, with_support = true, with_end_cap = false, extend_screw_hole = false, locking = true) {
    difference() {
        union() {
            cylinder(height, outer_radius, outer_radius, true);
            if (with_support) {
                support();
            }
        }
        
        // central opening where the accessory slides in
        cylinder(height + 0.1, inner_radius, inner_radius, true);
        
        // Chamfered inner edge
        translate([0, 0, -height / 2 - 0.05]) 
        cylinder(1, inner_radius + 0.5, inner_radius);
        
        // There is a rigde on the side of the accessory, create 
        // a slot for it to slide in.
        slot();

        // hole for lock notch
        translate([0, -outer_radius - lock_notch_depth, -height / 2 + lock_notch_offset])
        rotate([-90, 0, 0])
        cylinder(10, lock_notch_radius, lock_notch_radius);
        
        // hole for unlock button
        translate([0, -outer_radius - 1, -height /2])
        rotate([-90, 0, 0])
        cylinder(10, unlock_button_radius, unlock_button_radius);
    
        // cutout if we don't want locking
        if (!locking) {
            translate([0, -outer_radius, -height / 4])
            cube([lock_notch_radius * 2, outer_radius, height / 2], true);
        }

        // hole for screw
        if (screw_position != undef) {
            translate([0, outer_radius - 10, screw_position])
            rotate([90, 0, 0])
            
            cylinder(extend_screw_hole ? 100 : 20, screw_head_size / 2, screw_head_size / 2, true);
        }
    }
    if (with_end_cap) {
        translate([0, 0, height / 2 - 1.5])
        cylinder(1.5, outer_radius - 0.1, outer_radius - 0.1);
    }
    if (backplate_width > 0) {
       backplate(width = backplate_width, screw_position = screw_position); 
    }
}

/* Create a support between two adjacent accessory holders. This saves
   some material as compared to a support to a back plate. You might 
   also forego of the backplate entirely for this section of the tool 
   holder.
 */
module lateral_support(distance, rounding_radius = 4) {
    bounding_box_width = (outer_radius / (outer_radius + rounding_radius)) * (rounding_radius + support_thickness / 2) * 2;

    rounding_box_length = distance + rounding_radius * 2 - sqrt(pow(outer_radius + rounding_radius, 2) - pow(support_thickness / 2 + rounding_radius, 2)) * 2;

    difference() {
        cube([distance, bounding_box_width , height], true);
        
        translate([0, (support_thickness + 30) / 2, -height / 2 - 0.05])
        linear_extrude(height = height + 0.1) {
            rounded_rectangle(rounding_box_length, 30, rounding_radius); 
        }
        translate([0, -(support_thickness + 30) / 2, -height / 2 - 0.05])
        linear_extrude(height = height + 0.1) {
            rounded_rectangle(rounding_box_length, 30, rounding_radius); 
        }
        
        translate([distance /2, 0, 0])
        cylinder(height + 0.1, outer_radius, outer_radius, true);
        translate([-distance /2, 0, 0])
        cylinder(height + 0.1, outer_radius, outer_radius, true);
    }    
}

/* Generate extra screw holes in the back plate
 */
module backplate_screw_hole() {
    translate([0, backplate_offset, 0])
    union() {
        rotate([90, 0, 0])
        cylinder(100, screw_size / 2, screw_size / 2, true);
        if (countersunk_head) {
            translate([0, -backplate_thickness / 2 - 0.01, 0])
            rotate([-90, 0, 0])
            cylinder(screw_head_size / 2, screw_head_size / 2, 0);
        }
    }
}

/******************************************************
  Below are some 2nd-level modules that are used in the 
  modules above, but shouldn't be called directly
 ******************************************************/

module backplate(width, screw_position) {
    difference() {
        translate([0, backplate_offset, 0])
        cube([width, backplate_thickness, height], true); 

        if (screw_position != undef) {
            translate([0, 0, screw_position])
            backplate_screw_hole();
        }
    }
}

module slot() {
    translate([0, 0, groove_length - height / 2 - 25.01])
    difference() {
        cube([(inner_radius + groove_depth) * 2, 20, groove_length - 5], true);
        
        rounding_cube(1);
        rounding_cube(-1);
    }
}

module rounding_cube(orientation) {
    rounding_cube_height = groove_length;
    translate([-40, orientation * (rounding_cube_height + 2.6) / 2, rounding_cube_height / 2 + 2.5])
    rotate([orientation * 1, 0, 0])
    translate([0, 0, -rounding_cube_height / 2])
    rotate([0, 90, 0])
    linear_extrude(height = (inner_radius + groove_depth) * 4) {
        rounded_rectangle(rounding_cube_height, rounding_cube_height, 5);
    }    
}

module support() {
    support_offset = (connector_width + support_thickness) / 2;
    support_cube_depth = distance_from_backplate + outer_radius - 1.99;
    translate([support_offset, support_cube_depth / 2 + 2, -(height - height) / 2])
    cube([support_thickness, support_cube_depth, height], true);

    translate([-support_offset, support_cube_depth / 2 + 2, -(height - height) / 2])
    cube([support_thickness, support_cube_depth, height], true);
}

module rounded_rectangle(x, y, r) {
    x1 = x / 2 - r;
    y1 = y / 2 - r;
    offset(r = r)
    polygon([[x1, y1], [x1, -y1], [-x1, -y1], [-x1, y1]]);
}
