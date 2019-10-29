// What radius do you want your posts to be (remember diameter is 2x the radius)?
post_radius    = 5;
// How tall do you want your posts to be?
post_height    = 90;
// How wide do you want the base to be? (This must be at least 2 times the radius.  Customizer will auto-adjust if it is not.)
base_width     = 7;
// How thick do you want the holder wall to be?
holder_wall_thickness = 2;

// Do you want two posts?
two_posts   = 1; // [1:Yes, 0:No]
// Make posts flat on one side. (Removes half of the post split down the middle.)
split_posts = 0; // [1:Yes, 0:No]
// Do you want to create the holder?
with_holder = 1; // [1:Yes, 0:No]
// Increase holder hole radius by? [mm]
wiggle_room = 0.1;
// Do you want the top of the posts to be curved?
curved_top  = 1; // [1:Yes, 0:No]

module alignment_post(post_radius = 5, post_height = 70, base_width = 15, curved_top = 1, split_posts = 0, y_offset = 0) {
    extra_offset = curved_top  == 1 ? 0 : post_radius * 10;
    split_cube   = split_posts == 1 ? [base_width / 2 + 0.2, base_width + 0.2, post_height + 0.2] : [0,0,0];

    translate([0, y_offset, 0])
        difference() {
            union() {
                difference() {
                    translate([base_width/2, base_width/2, 0.5])
                        cylinder(
                            h = post_height -0.5,
                            r = post_radius
                        );
                    translate([-post_height/2, base_width/2, post_height + extra_offset])
                    rotate([0,90,0])
                            cylinder(
                                h = post_height,
                                r = post_radius
                            );
                }
                translate([0, 0, 0])
                    cube([base_width, base_width, base_width]);
            }
            translate([base_width/2 - 0.1, -0.1, -0.1])
                cube(split_cube);
        }
}

$fn=50;
actual_base_width           = post_radius * 2 < base_width ? base_width : post_radius * 2;
holder_distance_from_post   = 20;
distance_between_post_bases = 5;
holder_margin               = 2;

module alignment_post_holder(post_radius = 5, post_height = 70, base_width = 15, wall_thickness = 2, two_posts = 1) {
    slot_thickness     = base_width / 2 > 10 ? base_width / 2 : base_width;
    total_height       = base_width * 2 + slot_thickness;
    total_x_margin     = holder_margin * 2;
    total_y_margin     = two_posts == 1 ? holder_margin * 4 : holder_margin * 2;
    total_width        = two_posts == 1 ? base_width * 2 + distance_between_post_bases + total_y_margin : base_width + total_y_margin;

    wall_x = wall_thickness;
    wall_y = total_width;
    wall_z = total_height;

    wall_x_offset = base_width + holder_distance_from_post + base_width + total_x_margin;
    wall_y_offset = 0;
    wall_z_offset = 0;

    slot_x = base_width + total_x_margin;
    slot_y = total_width;
    slot_z = slot_thickness;

    slot_x_offset = base_width + holder_distance_from_post;
    slot_y_offset = 0;
    slot_z_offset = base_width;
    
    union() {
        translate([wall_x_offset, wall_y_offset, wall_z_offset])
            cube([wall_x, wall_y, wall_z]);

        translate([slot_x_offset, slot_y_offset, slot_z_offset])
            cube([slot_x, slot_y, slot_z]);
    }
}

alignment_post(post_radius, post_height, actual_base_width, curved_top, split_posts,  0);

if(two_posts == 1) {
    alignment_post(post_radius, post_height, actual_base_width, curved_top,  split_posts, actual_base_width + distance_between_post_bases);
}

if(with_holder == 1) {
    post_1_x_offset = actual_base_width + holder_distance_from_post + holder_margin;
    post_1_y_offset = holder_margin;
    post_1_z_offset = 0;

    post_2_x_offset = actual_base_width + holder_distance_from_post + holder_margin;
    post_2_y_offset = holder_margin * 2;
    post_2_z_offset = 0;
    
    radius_scale =  (post_radius + wiggle_room) / post_radius;
    

    difference() {
        alignment_post_holder(post_radius * radius_scale, post_height, actual_base_width + wiggle_room, holder_wall_thickness, two_posts);
        {
            translate([post_1_x_offset, post_1_y_offset, post_1_z_offset])
                alignment_post(post_radius * radius_scale, post_height, actual_base_width + wiggle_room, curved_top, split_posts,  0);
            if(two_posts == 1) {
                translate([post_2_x_offset, post_2_y_offset, post_2_z_offset])
                    alignment_post(post_radius * radius_scale, post_height, actual_base_width, curved_top, split_posts, actual_base_width + distance_between_post_bases + holder_margin);
            }
        }
    }
}
