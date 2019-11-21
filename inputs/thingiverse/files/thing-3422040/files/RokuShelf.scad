/**************************************************************************** 
Title: Roku Shelf TV Mount

Description: This script is intended to generate a shelf that can be mounted on top of a TV. The shelf is sized to support a Roku Premiere but can be customized to support other STB sizes.

Author: Ross MacDonald
Created In: 2019-02-09 

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
License Link: https://creativecommons.org/licenses/by-nc-sa/4.0/

/***************************************************************************/

// Customizable Settings

// Size of the Set top box. 
// 90 x 90 mm works great for the Roku Premiere.
shelf_width = 90;
shelf_depth = 90;

// Tab configuration - this is what clamps onto your TV
// Tab spacing is the thickness of the top of your TV
tab_spacing = 13.5;
// How far offset is the tab from the front of the shelf
first_tab_offset = -25;

// No need to modify anything below here
tab_depth = 10;
shelf_height = 3;
tab_width = 0.8 * shelf_width;
tab_height = shelf_height/4;
second_tab_offset = first_tab_offset + tab_spacing + tab_height;
tab_rounded_edge_radius = 2;
rounded_edge_radius = 10;
rounded_fudge = 1;

rounded_cube([shelf_width, 
    shelf_depth, 
    shelf_height], 
    rounded_edge_radius);

translate([0, first_tab_offset, -((tab_depth + shelf_height)/2)])
{
    rotate([-90,0,0])
    {
        rounded_cube([tab_width, 
            tab_depth, 
            tab_height], 
            tab_rounded_edge_radius);
    }
}

translate([0, first_tab_offset, -(shelf_height / 2)])
{
    rotate([-90,0,0])
    {
        cube([tab_width + tab_rounded_edge_radius, 
            tab_depth / 1.5, 
            tab_height + rounded_fudge], 
            center=true);
    }
}

translate([0, second_tab_offset, -((tab_depth + shelf_height) / 2)])
{
    rotate([-90,0,0])
    {
        rounded_cube([tab_width, 
            tab_depth, 
            tab_height], 
            tab_rounded_edge_radius);
    }
}

translate([0, second_tab_offset, -(shelf_height / 2)])
{
    rotate([-90,0,0])
    {
        cube([tab_width  + tab_rounded_edge_radius,
            tab_depth / 2,
            tab_height + rounded_fudge],
            center=true);
    }
}

// The following code was based heavily on the example here:
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#minkowski
module rounded_cube(size, radius)
{
    $fn=50;
    x = size[0]-radius;
    y = size[1]-radius;
    minkowski()
    {
        cube(size=[x,y,size[2]], center=true);
        cylinder(r=radius, center=true);
    }
}