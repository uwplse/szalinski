// Customizable Parametric Handle with Grip and Guard
// Original design by Makercubed.com
// Modifications and Thingiverse  customizer formatting by George W. Poulos 

use <utils/build_plate.scad>
//preview[view:south east,tilt:top diagonal]

/*Customizer Variables*/
/* Handle Parameters */
//(mm),  Not Including the "dome" part.
Handle_Height = 100; // [10:200]
//(mm).
Handle_Top_Diameter = 30; // [10:100]
//(mm).
Handle_Neck_Diameter = 25; // [10:100]
// for Handle Guard (mm)
Guard_Diameter=35; // [0:100]
// for Handle Guard (mm). Use 0 for no tapered neck. 
Neck_Height = 5; // [0:50]
// (mm). Use 0 for no guard. 
Guard_Edge_Thickness = 5; // [0:50]

/* Hole Parameters */
// for Inside Hole
Hole_Shape=30; //[30:Circle , 3:Triangle, 4:Square, 6:Hexagon, 8:Octogon]
// (mm).  
Hole_Diameter = 7.2; 
//(mm).
Hole_Depth = 10; // [0:100]

/* Grip Parameters */
// = Number of Grip Furrows.
Grip_Elements = 12; // [0:20]
Grip_Radius = 3.0;
// = Depth of the Grip Furrow Relative to Grip Radius. 0=Smooth Handle.
Percent_Grip_Depth = 50; // [0:100]
Grip_Smoothness = 20; // [3:30]

//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/*Non customizer variables*/
Handle_Top_Radius = Handle_Top_Diameter/2;
Handle_Neck_Radius = Handle_Neck_Diameter/2;
Guard_Radius = Guard_Diameter/2;
Hole_Radius = Hole_Diameter/2;
Grip_Offset = Grip_Radius*(1-Percent_Grip_Depth/100);
Grip_Angle = atan2(Handle_Top_Radius-Handle_Neck_Radius , Handle_Height);
Grip_Height = Handle_Height+Handle_Top_Radius-Neck_Height-Guard_Edge_Thickness ;


// General Smoothness
$fn = 50 / 1 ;

module handle() {
	union() {
		translate([0,0,Handle_Height]) sphere(r=Handle_Top_Radius,center=true);
		cylinder(h=Handle_Height,r1=Handle_Neck_Radius,r2=Handle_Top_Radius);
		translate([0,0,Guard_Edge_Thickness])cylinder(h=Neck_Height,r1=Guard_Radius,r2=Handle_Neck_Radius);
		cylinder(h=Guard_Edge_Thickness,r=Guard_Radius);
	}
}

difference() {
	handle();
	union() {
		cylinder(r=Hole_Radius,h=Hole_Depth,$fn=Hole_Shape);
	// Edges
		grip();
	}
}

module grip() {
	for ( i = [0 : Grip_Elements] )
	{
	    rotate([-Grip_Angle, 0,  i * 360 / (Grip_Elements)])
	    translate([0, Handle_Neck_Radius+Grip_Offset, Neck_Height+Guard_Edge_Thickness])
	    cylinder(r=Grip_Radius,h=Grip_Height,$fn=Grip_Smoothness);
	}
}