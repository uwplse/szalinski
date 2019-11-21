// arnsteio, 2017
//(1/4)  inch = 6.35 millimeters
//(5/16) inch = 7.9375 millimeters
//(3/8)  inch = 9.525mm
//(7/16) inch = 11.1125 millimeters
//(1/2)  inch = 12.7 millimeters

// You can change these:
shot_diameter=9.5; // [6.35, 7.94, 9.5, 11.11, 12.7]
rubber_diameter=8;

// probably not these:
/* [Hidden] */
pouch_thickness=1.4; //(0.6 is too thin, as is 1. 1.2 is possibly OK)
error = 0.01;
$fn=150;

//include <../openscad_doctest.scad>;


module side(w,h,t) // Submodule to make one net side
{
    difference()
    {
    hull()
        {
        cube([w+2*t,t,t], center=true);
        translate([0, 0, h]) rotate([90,0,0]) scale([1,1,0.3]) sphere(r=rubber_diameter*0.9);
        }
       translate([0, 0, h]) rotate([90,0,0])
        {
        cylinder(t*6,d1=rubber_diameter*1.5, d2=rubber_diameter*0.3, center=true);
        cylinder(t*6,d=rubber_diameter*1.0, center=true);
        cylinder(t*6,d1=rubber_diameter*0.3, d2=rubber_diameter*1.5, center=true);
        }
    
    }
}
module shot_cage(diameter)
{
    difference()
    {
    union()
        {
        cube([diameter+pouch_thickness*2,diameter+pouch_thickness*2,pouch_thickness],center=true);
        cylinder(diameter*0.4,d=diameter, center=true);
        }
	union()
        {
		translate([0,0,diameter*0.45])sphere(d=diameter);
        translate([0,0,-diameter-pouch_thickness*0.2])cube(diameter*2, center=true);
        }
    }
}


module build()
	{
     translate ([0,-shot_diameter/2-pouch_thickness/2,pouch_thickness/2]) rotate([6,0,0]) side(shot_diameter, shot_diameter*2, pouch_thickness);
     translate ([0,shot_diameter/2+pouch_thickness/2,pouch_thickness/2]) rotate([-6,0,0]) side(shot_diameter, shot_diameter*2, pouch_thickness);
     shot_cage(shot_diameter);
	}

build();



