//Title: Canning Jar Lid
//Author: Alex English - ProtoParadigm
//Date: 3-13-2012
//License: GPL2

//Notes: This uses Thread Library by syvwlch (http://www.thingiverse.com/thing:8793).  This file and the thread library file need to be in the same directory, or the path below changed to reflect the location of the thread library.  The main module to be used here is cap, which creates a lid for a canning jar.  It must be passed either the reg or wide variable, to create a lid for a regular, or a wide mouth canning jar.  If printed well, and well tightened, this lid is water tight, but not air tight.  The main shape of the lid is deliberately low-poly so it is easy to grip.  This lid is suitable for use in storing dry goods, non-food small parts, etc., for storing opened canned goods in the refrigerator, and probably for use in the freezer.  Additional accessories will be released that use this lid as the base.

include <Thread_Library.scad>;

radius = 87/2; 
//reg = 71 / 2; // Regular Mouth Jar Cap Inner Radius
//wide = 87 / 2; // Wide Mouth Jar Cap Inner Radius

wall_thickness = 5;
cap_depth = 15;
ring_height = cap_depth + wall_thickness;
thread_height = 1.7;
thread_quality = 45; //~10 for draft, 45, 60,72, or 90 for higher qualities, higher numbers dramatically increase render time, and increase the poly count, wich will increase file sizes and slicing times, but will make smoother curves




module ring (rad)
{
		difference()
		{
			cylinder(r=(rad+wall_thickness), cap_depth, $fa=30);
			trapezoidThreadNegativeSpace(length=cap_depth + wall_thickness, pitch=6.35, pitchRadius=(rad-1.524), threadHeightToPitch=(1.524/6.35), profileRatio=1.66, threadAngle=30, RH=true, countersunk=0, clearance=0.1, backlash=0.1, stepsPerTurn=thread_quality); //threads and hole
		}
}

module cap(rad)
{
		translate([0,0,ring_height]) rotate([180, 0, 0]) difference()
		{
			union()
			{
				ring(rad); //Outer ring with threads
				translate([0,0,cap_depth]) cylinder(r=(rad+wall_thickness), wall_thickness, $fa=30); //top surface
				//translate([0,0,cap_depth]) rotate_extrude(convexity = 10, $fn = 100) translate([rad-7, 0, 0]) circle(r = 2, $fn = 100); //torus on underside of lid for tighter seal
			}
			translate([0, 0, ring_height]) rotate_extrude(convexity=10, $fa=1) translate([rad+wall_thickness, 0, 0]) rotate([0,0,40]) scale([wall_thickness, wall_thickness*2]) square(1, true); //chamfer on top edge
		}
}



//Main Geometry

union()
{
        difference()
    {
        //cap(wide);
        //cap(reg);
        cap(radius);
        cylinder(h=7,r=radius-3);
        
                //translate([0,0,-5])cylinder(h=20,radius-5.5);
        
    }
translate([radius+1.5,0,5])rotate([0,90,0])loop();

    
  //  cylinder(h=50,r=66/2); //gut check for jar size, comment out during normal model generation.
}


    module loop(){
       union(){
        difference(){
        translate([11,0,3.5])cylinder(h=9, r=30/2,center = true); //OD
        translate([11,0,3.5])cylinder(h=10.2, r=12/2, center = true); //ID
        }
         translate([-5,0,4])cube([20,26,8], true);
        }
    }  