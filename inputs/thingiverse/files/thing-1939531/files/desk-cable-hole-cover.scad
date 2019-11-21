/*
Author: Kevin Lutzer
Date Created: Oct 8 2016 
Description: A part to protect a hole in a desk meant for threading cables through.
*/

///////////////////////////////////////////////// Parameter /////////////////////////////////////////////////

// The thickness of the cyclinder that will slide into the desk hole
hole_cover_wall_thickness = 5;
// Diameter of the hole in the desk
hole_diameter = 45;
// The depth of the whole in the desk
hole_height = 18.5;

// The height of the cover from the base of the desk to the top of the cover
desk_cover_height = 3; 
// The thickness of the desk cover
desk_cover_thickness = 5;


///////////////////////////////////////////////// Prototypes /////////////////////////////////////////////////
union()
{
    difference(){
        cylinder(hole_height + desk_cover_height, d1 = hole_diameter, d2 = hole_diameter, 0, $fn=50 );
        cylinder(hole_height + desk_cover_height, d1 = (hole_diameter-hole_cover_wall_thickness), d2 = (hole_diameter-hole_cover_wall_thickness), 0, $fn=50);
    }
    translate([0,0,hole_height]){
        difference(){
            cylinder(desk_cover_height, d1 = (hole_diameter+desk_cover_thickness), d2 = (hole_diameter), 0, $fn=50);
            cylinder(desk_cover_height, d1 = hole_diameter, d2 = hole_diameter, 0, $fn=50);    
        }
        
    }
}
////////////////////////////////////////////////// modules //////////////////////////////////////////////////

