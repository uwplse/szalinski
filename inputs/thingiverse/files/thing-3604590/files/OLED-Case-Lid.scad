// Customizer Variables

// Distance from bottom of PCB to start of OLED hole
lcd_hole_y_offset = 8.6; // [3.0:0.1:13.0]



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




