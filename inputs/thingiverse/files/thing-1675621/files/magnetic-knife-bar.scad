/////////////////////////////////////////////////////////////////////
//                                                                           
// File: magnetic_knife_bar.scad                                              
// Author: Stephan Mueller                                                 
// Date: 2016-07-16                                                        
// Description: Customizable magnetic knife bar
//                                                                          
/////////////////////////////////////////////////////////////////////

// Customizer Settings: //

/* [Options] */

//length of the knife bar
length = 160; // [50:1:500]

//width of the knife bar
width = 25; // [10:1:100]

//diameter of the magnet + offset
magnet_diameter = 10.4; // [5:0.1:20]

//height of the magnet + offset
magnet_height = 5.2; // [2:0.1:20]

//offset between magnets
offset = 5; // [1:0.1:50]

//corner radius
corner_radius = 5; // [0:1:50]

//create screw mounts
screw_mounts = "no"; // [yes, no]

//screw diameter
screw_diameter = 3.2; // [1:0.1:10]

//screw head diameter
screw_head_diameter = 6; // [1:0.2:20]

// Static Settings: //

/* [Hidden] */

wall = magnet_height + 1;
$fn = 100;

number_of_magnets = floor((length-((screw_mounts=="yes" ? 2 : 0)*(screw_head_diameter+1))) / (magnet_diameter+offset));
first_offset = (length - (number_of_magnets*(magnet_diameter+offset)) + offset) / 2;

// preview[view:south, tilt:top]


module magnetic_knife_bar(){
    difference(){
        roundCube(length, width, wall, corner_radius);
        for (i = [0:1:(number_of_magnets-1)]){
            translate([first_offset + magnet_diameter/2 + i*magnet_diameter + i*offset, width/2, (wall - magnet_height)]) cylinder(h=magnet_height + 0.1, r=magnet_diameter/2);
        }
        if (screw_mounts=="yes"){
            translate([screw_head_diameter/2 + 1, width/2, wall-1.9]) cylinder(2, r=screw_diameter/2);
            translate([screw_head_diameter/2 + 1, width/2, -0.1]) cylinder(wall - 1.9, r=screw_head_diameter/2);
            translate([length - screw_head_diameter/2 - 1, width/2, wall-1.9]) cylinder(2, r=screw_diameter/2);
            translate([length - screw_head_diameter/2 - 1, width/2, -0.1]) cylinder(wall - 1.9, r=screw_head_diameter/2);
        }
    }
    
}

module roundCube(x, y, z, r = 1){
    r = max(0.01, r);
    hull(){
        translate([r, r, 0]) cylinder(r=r, h=z);
        translate([r, y-r, 0]) cylinder(r=r, h=z);
        translate([x-r, r, 0]) cylinder(r=r, h=z);
        translate([x-r, y-r, 0]) cylinder(r=r, h=z);
    }
}

magnetic_knife_bar();