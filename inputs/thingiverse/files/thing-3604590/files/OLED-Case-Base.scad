wall_thickness = 1.9;

// Related to the "nut slot" posts
nut_width = 5.5;
nut_height = 2.5;
nut_post_width = nut_width + 2.3;
nut_hole_height = nut_height + 1.2;
nut_hole_width = nut_width + 0.4;

nut_hole_depth = (nut_post_width-nut_width)/2 + nut_width;

nut_post_height = nut_hole_height + 2;




// The actual case interior
pcb_width = 64.2+0.2;
pcb_depth = 27.41+0.5;

post_offset_x = 59.6+0.25;
post_offset_y = 23.4+0.25;
//interior_standoff = 2.9+nut_post_height;
interior_standoff = 1.2+nut_post_height;

main_case_height = interior_standoff + 3.4; // The external height of the case 


module make_nut_post(holes=true) {
    translate([-nut_post_width/2, -nut_post_width/2,0])
    difference () {
        // The actual post
        cube([nut_post_width, nut_post_width, nut_post_height]);
        if(holes) {
            // The hole for the nut
            translate([(nut_post_width-nut_hole_width)/2, -wall_thickness, (nut_post_height-nut_hole_height)/2]) cube([nut_hole_width, nut_post_width, nut_hole_height]);
        }
    }    
}


module make_nut_posts(holes=true) {
    translate([2.1,2,-wall_thickness]) {
        translate([0, 0, 0]) make_nut_post(holes);
        translate([post_offset_x, 0, 0]) make_nut_post(holes);
        translate([0, post_offset_y, 0]) rotate([0,0,180]) make_nut_post(holes);
        translate([post_offset_x, post_offset_y, 0]) rotate([0,0,180]) make_nut_post(holes);
    }
}


module make_holes() {
    post_height = main_case_height*2;
    hole_radius = 1.7;
    translate([0, 0, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
    translate([post_offset_x, 0, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
    translate([0, post_offset_y, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
    translate([post_offset_x, post_offset_y, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
}

difference() {
    make_nut_posts();
    translate([2.1,2,-wall_thickness-0.1]) make_holes();
}

difference () {
    translate([-wall_thickness,-wall_thickness,-wall_thickness]) cube([pcb_width+(wall_thickness*2),pcb_depth+(wall_thickness*2)-0.26,main_case_height+wall_thickness]);
    cube([pcb_width,pcb_depth,main_case_height+wall_thickness]);
    // The screw holes
    translate([2.1,2,-wall_thickness-0.1]) make_holes();
    // Boot switch hole
    translate([pcb_width-1.6-2,7.6,-wall_thickness-0.1]) cube([2,2,7+wall_thickness]);
    // microUSB hole
    translate([pcb_width-0.1,13.7,interior_standoff-3]) cube([wall_thickness+0.2,9,4]);
    
    #make_nut_posts(false);
    
}

translate([5.2,0,0]) cube([22.9, 1.6, interior_standoff]);
translate([5.2,pcb_depth-1.6,0]) cube([37.4, 1.6, interior_standoff]);
translate([22,0,0]) cube([1,pcb_depth,interior_standoff]);
translate([54,0,0]) cube([4,1.6,interior_standoff]);



