// Customizer Variables

// Distance from bottom of PCB to start of OLED hole
lcd_hole_y_offset = 8.6; // [3.0:0.1:13.0]

// Which part would you like to see?
part = "lid"; // [lid:Case Lid,base:Case Base]


print_part();

module print_part() {
    // This is just some boilerplate code to force the Thingiverse Customizer to generate both STLs.

    if (part == "lid") {
        print_lid();
    } else {
        // part == base
        print_base();
    }
}


module print_lid() {
    /* This module is an exact copy of the "Case Lid" OpenSCAD file. It has been replicated here to enable use of the
    Thingiverse Customizer */
    
    // Other things that I measured when designing this
    pcb_width = 64.2+0.2;
    pcb_depth = 27.41+0.5;

    // 59.7+0.25;
    post_offset_x = 59.6+0.25;
    post_offset_y = 23.4+0.25;

    wall_thickness = 1.9;
    inside_area_depth = 2.5;

    lcd_hole_width = 23.8;
    lcd_hole_height = 13.6;
    slope_width=2.6;
    slope_height=inside_area_depth;

    module make_holes() {
        post_height = 8;
        hole_radius = 1.7;
        translate([0, 0, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
        translate([post_offset_x, 0, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
        translate([0, post_offset_y, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
        translate([post_offset_x, post_offset_y, 0]) cylinder($fn=20, r=hole_radius,h=post_height);
    }


    module prism(l, w, h) {
           polyhedron(points=[
                   [0,0,h],           // 0    front top corner
                   [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
                   [0,l,h],           // 3    back top corner
                   [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
           ], faces=[ // points for all faces must be ordered clockwise when looking in
                   [0,2,1],    // top face
                   [3,4,5],    // base face
                   [0,1,4,3],  // h face
                   [1,2,5,4],  // w face
                   [0,3,5,2],  // hypotenuse face
           ]);
    }

    module make_LCD_carving() {
        overall_carveout_width = slope_width*2+lcd_hole_width;

        difference() {
            // The base cube
            cube([overall_carveout_width,pcb_depth+(wall_thickness*2),wall_thickness]);

            // The LCD Screen Hole (originally 8.6)
            translate([slope_width, lcd_hole_y_offset, -0.1]) cube([lcd_hole_width,lcd_hole_height,wall_thickness*2]);
        }

        // The left slope
        translate([0,0,wall_thickness]) prism(pcb_depth+wall_thickness*2,slope_width,slope_height);
        // The right slope
        translate([slope_width*2+lcd_hole_width,pcb_depth+wall_thickness*2,wall_thickness]) rotate([0,0,180]) prism(pcb_depth+wall_thickness*2,slope_width,slope_height);
    }



    difference () {
        // The actual outside "shell"
        translate([-wall_thickness,-wall_thickness,0]) 
            cube([pcb_width+(wall_thickness*2),
                pcb_depth+(wall_thickness * 2),
                wall_thickness+inside_area_depth]);

        // The "void" for the PCB to fit into
        translate([4.6,4,-0.1]) cube([23.4, pcb_depth-8, inside_area_depth+0.1]);

        // The screw holes
        translate([2.1,2,-1.1]) make_holes();
        
        // The LCD carving area
        translate([32-slope_width,-wall_thickness-0.1, -0.1]) cube([slope_width*2+lcd_hole_width, pcb_depth+(wall_thickness*2)+0.2, wall_thickness+inside_area_depth+0.2]);
    }

    translate([32-slope_width,-wall_thickness,0]) make_LCD_carving();
}


module print_base() {
    /* This module is an exact copy of the "Case Base" OpenSCAD file. It has been replicated here to enable use of the
    Thingiverse Customizer */

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

    
}





