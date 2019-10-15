// Created by G. Robinson 21/09/2016
// Licence: creative commons - attribution

/* [Part Selection] */

// Select the part to generate
part = "all"; // [A:Part A,B:Part B,all:All]

/* [Spool Dimensions] */

// Diameter of the spool flanges, mm
flange_outer_diameter = 80; //mm
// Diameter of the core around which the cable is wrapped, mm
hub_outer_diameter = 40; //mm
// Diameter of the hole through the center of the spool hub, mm
hub_inner_diameter = 25; //mm
// Overall width of the spool (outside), mm
spool_width = 20; //mm
// Flange cutouts save material, maybe not time!
use_flange_cutouts = 0; //[0:No,1:Yes]

/* [Advanced Parameters] */

// Diameter of the cable hole in both flange and hub, mm
cable_hole_diameter = 3;
// Thickness of the flanges, mm
flange_thickness = 1;
// Thickness of the hub and web structures, mm
structure_thickness = 1;
// Depth of the locating socket in the B part, mm
socket_depth = 3;
// Radial clearance allowed between the locating boss and socket, mm
socket_clearance = 0.5; //mm on radius
// Number of webs to use in hub and flange
web_count = 5; //[3:2:15]
// Web thickness for flange, mm
flange_web_thickness = 5;

/* [Hidden] */

socketod = (hub_inner_diameter + hub_outer_diameter)/2*1;
recessdepth = spool_width-flange_thickness-socket_depth-structure_thickness;

if (part == "A")
{
    partA();
}
else if (part == "B")
{
    partB();
}
else if (part == "all")
{
    partA();
    translate([flange_outer_diameter+5,0,0]) { 
        partB(); 
    }
}

// geometry - hub half
module partA() {
difference() {
    union() {
        cylinder(flange_thickness, flange_outer_diameter/2, flange_outer_diameter/2, false);
        cylinder(spool_width - flange_thickness, hub_outer_diameter/2, hub_outer_diameter/2, false);
    }
    translate([0,0,spool_width-flange_thickness-socket_depth]) {
        cylinder(socket_depth, socketod/2, socketod/2, false);
    }
    cylinder(spool_width, hub_inner_diameter/2, hub_inner_diameter/2, false);
    translate([0,0,flange_thickness+(cable_hole_diameter*1)]) {
        rotate([-90,0,0]) { 
            cylinder(flange_outer_diameter,cable_hole_diameter/2,cable_hole_diameter/2,false);
        }
    }
    if ((hub_outer_diameter-hub_inner_diameter)/2-structure_thickness*2>=max(cable_hole_diameter,3))
    {
        difference() {
            cylinder(recessdepth,hub_outer_diameter/2-structure_thickness, hub_outer_diameter/2-structure_thickness,false);
            cylinder(recessdepth,hub_inner_diameter/2+structure_thickness, hub_inner_diameter/2+structure_thickness,false);
            for (i=[0:web_count-1]) {
                rotate([0,0,180/web_count*i]) {
                    cube([flange_outer_diameter,structure_thickness,recessdepth*2],true);
                }
            }
        }
    }
    if (use_flange_cutouts == 1)
    {
        flangeCutoutSolid();  
    }
}
}

// geometry - face half
module partB() {
    difference() {
        union() {
            cylinder(flange_thickness, flange_outer_diameter/2, flange_outer_diameter/2, false);
            cylinder(socket_depth+flange_thickness, socketod/2-socket_clearance, socketod/2-socket_clearance, false);
        }
        cylinder(spool_width, hub_inner_diameter/2, hub_inner_diameter/2, false);
        translate([flange_outer_diameter/2-(cable_hole_diameter*1),0,0]) {
            cylinder(flange_thickness,cable_hole_diameter/2,cable_hole_diameter/2,false);
        }
        if (use_flange_cutouts == 1)
        {
            flangeCutoutSolid();   
        }
    }
}

module flangeCutoutSolid() {
    difference() {
        cylinder(flange_thickness,flange_outer_diameter/2-flange_web_thickness, flange_outer_diameter/2-flange_web_thickness,false);
        cylinder(flange_thickness,hub_outer_diameter/2+flange_web_thickness, hub_outer_diameter/2+flange_web_thickness,false);
        for (i=[0:web_count-1]) {
            rotate([0,0,180/web_count*i]) {
                cube([flange_outer_diameter,flange_web_thickness,flange_thickness*2],true);
            }
        }    
    }
}