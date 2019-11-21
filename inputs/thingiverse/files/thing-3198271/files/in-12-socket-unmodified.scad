// diameter of the twelve pin holes, in mm
pin_diameter = 1.016; // [1.016:0.1:3.5]

$fn = 64 * 1;

in12_height = 28 * 1; // measured on original socket, just shy of 28mm
in12_width = 22 * 1; // measured on original socket, just shy of 22mm
in12_center_hole_diameter = 0.2 * 25.4; // measured on original socket
in12_center_hole_bevel_depth = 0.1 * 25.4; // eyeballed on original socket

mounting_tab_width = in12_width / 2;
mounting_tab_length = 0.268 * 25.4;
mounting_tab_height = 0.145 * 25.4; // measured on original socket: 0.145 * 25.4
mounting_hole_diameter = 0.135 * 25.4; // measured on original socket: 0.135 * 25.4
mounting_hole_distance_from_edge = 0.165 * 25.4; // measured on original socket: 0.165 * 25.4
mounting_hole_distance_from_top = 0.165 * 25.4; // measured on original socket: 0.165 * 25.4

socket_height_below_mounting_tab = 0.13 * 25.4; // measured on original socket: 0.13 * 25.4
socket_height_above_mounting_tab = 0.1 * 25.4; // measured on original socket: 0.1 * 25.4

total_socket_height = socket_height_below_mounting_tab + mounting_tab_height + socket_height_above_mounting_tab;


// from in-12 datasheet
pin_locations = [[4, 8],   [5.75, 4.5],   [5.75, 0],  [5.75, -4.5],  [4, -8], [0, -9], 
                 [-4, -8], [-5.75, -4.5], [-5.75, 0], [-5.75, 4.5],  [-4, 8], [0, 9]];

// eyeballed
rounded_corner_diameter = 4 * 1;

// just the mounting tab that sticks off the side of the socket.  It is fully
// rounded (which gives us the correct top two corners) but the bottom corners
// are wrong.
module mounting_tab_2d_fully_rounded()
{
    minkowski()
    {
        union()
        {
            intersection()
            {
                difference()
                {

                    circle(d = in12_height + 2 * mounting_tab_length - rounded_corner_diameter);
                    circle(d = in12_height + rounded_corner_diameter);
                }
                translate([rounded_corner_diameter / 2, 0]) square([in12_width / 2 - rounded_corner_diameter, in12_height + 1]);
            }
        }
        circle(d = rounded_corner_diameter, $fn = 64);
    }
}

// the mounting tab with the rounding on the parts that touch the 
// socket body removed
module mounting_tab_2d_extended_fully_rounded()
{
    difference()
    {
        union()
        {
            mounting_tab_2d_fully_rounded();
            // fix up the bottom corners.  The bottom right corner is rounded 
            // when it should just extend straight down the side of the socket,
            // and the bottom left corner needs to have a fillet to the socket body.
            translate([-rounded_corner_diameter, 0]) 
                square([in12_width / 2 + rounded_corner_diameter, 
                        in12_height / 2 + rounded_corner_diameter / 2]);
        }
        mirror() mounting_tab_2d_fully_rounded();
        
        translate([in12_width / 2 - mounting_hole_distance_from_edge, 
                   in12_height / 2 + mounting_tab_length - mounting_hole_distance_from_top])
        circle(d = mounting_hole_diameter);
    }
}

module socket_body_2d()
{
    //color("yellow", 0.5)
    intersection()
    {
        circle(d = in12_height);
        translate([0, 0])
          square([in12_width, in12_height + 1], true);
    }
}

module socket_body() {
    union()
    {
        linear_extrude(height = socket_height_below_mounting_tab)
        socket_body_2d();

        translate([0, 0, socket_height_below_mounting_tab])
        linear_extrude(height = mounting_tab_height)
        union()
        {
            mounting_tab_2d_extended_fully_rounded();
            rotate([0, 0, 180]) mounting_tab_2d_extended_fully_rounded();
            socket_body_2d();
        }
        
        translate([0, 0, socket_height_below_mounting_tab + mounting_tab_height])
        linear_extrude(height = socket_height_above_mounting_tab)
        socket_body_2d();
    }
}

module center_hole() 
{
    union()
    {
        translate([0, 0, -0.5]) cylinder(d = in12_center_hole_diameter, h = total_socket_height + 1);
        translate([0, 0, total_socket_height - in12_center_hole_bevel_depth])
        cylinder(d1 = in12_center_hole_diameter, 
                 d2 = in12_center_hole_diameter + 2 * in12_center_hole_bevel_depth + 1, 
                 h = in12_center_hole_bevel_depth + .5);
    }
}


module pin_hole()
{
    translate([0, 0, -0.5])
    cylinder(d = pin_diameter, h = total_socket_height + 1);
}

module pin_holes() 
{
    for (pin_location = pin_locations)
    {
        translate([pin_location[0], pin_location[1], 0])
        pin_hole();
    }
}


module socket()
{
    union()
    {
        difference()
        {
            socket_body();
            pin_holes();
            center_hole();
        }
    }
}

socket();

