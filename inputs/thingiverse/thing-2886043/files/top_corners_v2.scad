//Variables

// Thickness of the Board
board_thickness = 17.5;  //[1:30]

// Size of the cube to bound the object.  This is the Height, Width, and Depth.
cube_size = 50;

// Wall Thickness.  This is the wall thickness.
wall_thickness = 2.5;


// Object Assembly.  Object is built upside down, then rotated for proper print orientation.

translate([0,0,cube_size]) rotate([180,0,0]) difference(){
union(){
difference() {
    cube(size=cube_size);
    translate([wall_thickness, wall_thickness, wall_thickness]) cube(size=cube_size);
}
translate([0,0,wall_thickness+board_thickness]) cube([cube_size, cube_size,wall_thickness]);
translate([wall_thickness+board_thickness,board_thickness+wall_thickness,wall_thickness+board_thickness]) cube([wall_thickness, cube_size-wall_thickness-board_thickness,cube_size-(board_thickness+wall_thickness)]);
translate([board_thickness+wall_thickness,wall_thickness+board_thickness,wall_thickness+board_thickness]) cube([cube_size-wall_thickness-board_thickness, wall_thickness, cube_size-(board_thickness+wall_thickness)]);
}
translate([board_thickness+2*wall_thickness,2*wall_thickness+board_thickness,0]) cube(size=cube_size);
}
