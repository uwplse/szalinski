// Minkowski Sum (Dilation)Box
// Author: Akshay V. Dhamankar

// CUSTOMIZER VARIABLES

// Number of Fragments
$fn = 100;

// Box Square Size
square_size = 50;

// Minkowski Dilation Radius
circle_radius = 2;

// Wall Thickness
wall_thickness = 4;

// Box Height
extrude_len = 50;

// Tolerance
tolerance = 0.2;

// Lid Height
lid_height = 8;

// Lid depth
lid_depth = 5;

// CUSTOMIZER VARIABLES END
// Module 1: Base
module minkowski_base() 
{

difference(){
// Main base
linear_extrude(extrude_len)
{
        minkowski()
        {
            square(square_size, center=true);
            circle(circle_radius);
        }
}

translate([0,0,(extrude_len-lid_depth)])
{
    linear_extrude(extrude_len)
    {
        minkowski()
        {
            square((square_size)-(wall_thickness), center=true);
            circle(circle_radius);
        }
    }
}

translate([0,0,wall_thickness])
{
    linear_extrude(extrude_len)
    {
        minkowski()
        {
            square((square_size - (wall_thickness*2)), center=true);
            circle(2);
        }
    }
}
}
}
minkowski_base();

// Module 2: Lid

// Lid Height
//lid_height = 4;

module minkowski_lid() 
{
union()
{
    // Piece that Fits In
    translate([0,0,(extrude_len + 5)])

{
    linear_extrude(lid_depth - tolerance)
    {
        minkowski()
        {
            square(((square_size - wall_thickness)-tolerance), center=true);
            circle(circle_radius);
        }
    }
}
// Piece that Covers the Top
translate([0,0,extrude_len + 5 + (lid_depth-tolerance)])
{
//    linear_extrude(lid_height-(0.45*lid_height))
      linear_extrude(lid_height)
    {
        minkowski()
        {
            square(square_size, center=true);
            circle(circle_radius);
        }
    }
}
}
}
minkowski_lid();

