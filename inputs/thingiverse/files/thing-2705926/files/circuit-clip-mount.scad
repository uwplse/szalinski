board_width = 52;
board_length = 68;
board_thickness = 1;

base_thickness = 2;
wall_thickness = 2;

camfer_thickness = 1;

standoff_height = 5;

clip_width = 10;
clip_thickness = 1.5;

hole_offset_length = 15;
hole_offset_width = 15;
hole_radius = 2;

difference() {
    union() {
        cube([board_length, board_width+2*wall_thickness, base_thickness]);
        all_clips();
    }
    holes();
}

module board_clip() {
    translate([clip_width,0.01,0.01])
        rotate([0,-90,0])
            linear_extrude(height=clip_width)
                polygon(points=[[0,wall_thickness+camfer_thickness],
                            [base_thickness,wall_thickness+camfer_thickness],
                            [base_thickness+camfer_thickness, wall_thickness],
                            [base_thickness+standoff_height-2*clip_thickness,wall_thickness],
                            [base_thickness+standoff_height-clip_thickness,wall_thickness+clip_thickness],
                            [base_thickness+standoff_height,wall_thickness],
                            [base_thickness+standoff_height+board_thickness,wall_thickness],
                            [base_thickness+standoff_height+board_thickness+clip_thickness,wall_thickness+clip_thickness],
                            [base_thickness+standoff_height+board_thickness+2*clip_thickness,wall_thickness],
                            [base_thickness+standoff_height+board_thickness+2*clip_thickness,0],
                            [0,0]]);
}

module all_clips() {
    translate([0.01,0,0])
        board_clip();
    translate([board_length-clip_width-.01,0,0])
        board_clip();
    translate([clip_width-0.01,board_width+2*wall_thickness,0])
        rotate([0,0,180])
            board_clip();
    translate([board_length-.01,board_width+2*wall_thickness,0])
        rotate([0,0,180])
            board_clip();
}

module holes() {
    translate([hole_offset_length, hole_offset_width, -0.5*base_thickness])
        cylinder(r=hole_radius, h=base_thickness*2, $fn=16);
    translate([board_length-hole_offset_length, hole_offset_width, -0.5*base_thickness])
        cylinder(r=hole_radius, h=base_thickness*2, $fn=16);
    translate([hole_offset_length, board_width+2*wall_thickness-hole_offset_width, -0.5*base_thickness])
        cylinder(r=hole_radius, h=base_thickness*2, $fn=16);
    translate([board_length-hole_offset_length, board_width+2*wall_thickness-hole_offset_width, -0.5*base_thickness])
        cylinder(r=hole_radius, h=base_thickness*2, $fn=16);
}