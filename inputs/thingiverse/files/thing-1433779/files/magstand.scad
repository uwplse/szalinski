/* [Magstand] */

mags = 6; // [1:100]
magsize_length = 66; // [1:200]
magsize_width = 25; // [1:200]
magsize_height = 18; // [1:200]
mag_gap = 2;

mag_inclination_deg = 15;  // [0:45]
// text_inclination_deg = 11;

holder_base_height = 1.5; // [0.5:10]

// text_side = "none";
// text_offset = 1.5;
// text_size = 10;
// text = "AR-15 5.56";

/* [Hidden] */

// Vars
complete_height = holder_base_height + magsize_height;
hole_maker = 0.01;

// Magazine slots    
maghole_points = [[0,0],[magsize_width,0],[magsize_width,magsize_length],[0,magsize_length]];

// Rotated point
maghole_point = [magsize_width,0];
maghole_point_rotated = rotate_point(maghole_point[0],maghole_point[1], -mag_inclination_deg);

// Normal inclination (-1/incl)
maghole_norm_incl = -1 / ((maghole_point_rotated[1] / maghole_point_rotated[0]));    
maghole_norm_ground_ix = -1 * (maghole_point_rotated[1] / maghole_norm_incl);

// Offset that is needed to satisfy a gap of 0
maghole_offset = maghole_norm_ground_ix + maghole_point_rotated[0];

// The y translation that is needed to satisfy the base height
move_holes_up = -1 * maghole_point_rotated[1] + holder_base_height;

// Calculate hole depth needed to have back edge completely sunken
maghole_point_upper = [magsize_width, magsize_height];
maghole_point_upper_rotated = rotate_point(magsize_width, magsize_height, - mag_inclination_deg);    
holder_height = holder_base_height + ((maghole_point_upper_rotated[0] - maghole_point_rotated[0]) * maghole_norm_incl);

/*
if(text_side == "front") { 
    // Extruded triangle platform for the text    
    translate([0, magsize_length + 4,0])
    rotate([0,-90,90])
    linear_extrude(height = magsize_length + 4, convexity = 10, twist = 0)
    polygon(points=[[0,0],[holder_height,0],[0,holder_height]]);
    
    // Text
    translate([-13, magsize_length + 4 - text_offset, complete_height/2 - text_size / 2.5])
    rotate([45,0,-90])
    linear_extrude(height = 2, convexity = 10, twist = 0)
    text(text, size = text_size);
}
*/

difference() { 
    // Magazine base
    overall_length=((mags - 1) * maghole_offset + mag_gap) + maghole_point_upper_rotated[0] + mag_gap + ((mags-1) * mag_gap);
    overall_width = magsize_length + 2 * mag_gap;
    cube([overall_length, overall_width, holder_height]);

    echo("Overall length = ", overall_length);
    echo("Overall width = ", overall_width);

    for (a =[0:mags-1]) {
        translate([(maghole_offset + mag_gap) * a + mag_gap, mag_gap, move_holes_up]) {     
              rotate([0,mag_inclination_deg,0]) {
                color("violet", 1 ) linear_extrude(height = magsize_height + hole_maker) polygon(maghole_points);
            }
        }
    }
}




function rotate_point(x, y, deg) = [x * cos(deg) - y * sin(deg), 
                               x * sin(deg) + y * cos(deg)];