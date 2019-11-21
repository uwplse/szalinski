// Chainmail Bracelet
// Pasutx 23.2.2013

use <utils/build_plate.scad>

//: The total length of the bracelet in mm:  
Length= 200;	// [30:300]
//: Number of links next to each other:  
Width= 2;	// [2:6]
//: The number of degrees to rotate object to fit long objects on build platform  
Rotation=45;	// [0,27,45]
//: strength of rings in mm  
Thickness=2; // [2,2.5,3]
//: sideways separation between rings  
Separation=0.66;  // [0.5,0.66,1,1.5,2]
//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// Calulate number of links
Scale=1.1*1;
maxx = round(Length/Scale/6.2-1.5);
maxy = Width;
Xw=Thickness;  		// width of vertical elements in x direction
Yw=Thickness;   		// width of vertical elements in y direction

// Main program
// The translate operation puts the bracelet in the middle of the build platform
 Bracelet();

module Bracelet()
{
	rotate([0,0,Rotation]) translate([-0.5*Length+3.5,Width*-0.5*(5*Yw+4*Separation),0])  scale([Scale,Scale,Scale]) 
		union()
		{
			band();
			clasp("left");
			translate([(maxx-1)*7+6,maxy*4*(Yw+Separation)+2*Yw+Separation,0])
				rotate([0,0,180])
					clasp("right");
		}
}

module clasp(Type)
{
	difference()
	{	
		// base
		translate([-9,Yw+Separation,0]) 
			cube(size=[11,maxy*4*(Separation+Yw)-Separation,3],center=false);
		// slit	
		if (Type=="left")	
		{
			translate([-1.5,Yw+Separation-0.1,-0.1]) 
				scale([1,1,1.1]) rotate([-90,180,0]) 
					linear_extrude(height = (maxy)*(4*Separation+4*Yw)-Separation-3, center = false, convexity = 3)
						polygon(points=[[-0.5,0],[3,0],[4,1.5],[3,3],[-0.5,3],[0.5,1.5]] );
			translate([-1.5,Yw+Separation-0.1,-0.1]) 
				scale([1,1,1.1]) rotate([-90,180,0]) 
					linear_extrude(height = (maxy)*(4*Separation+4*Yw)-Separation-3, center = false, convexity = 3)
						polygon(points=[[5.2,3],[6.2,1.5],[5.2,0],[8,0],[8,3],[0,3]] );
		}
		else // (Type=="right")	
		{
			translate([-1.5,Yw+Separation-0.1,-0.1]) 
				scale([1.2,1,1.1]) rotate([-90,180,0]) 
					linear_extrude(height = (maxy)*(4*Separation+4*Yw)-Separation-3, center = false, convexity = 3)
						polygon(points=[[0,0],[3,0],[2,1.5],[3,3],[0,3],[-1,1.5]] );
			translate([-1.5,Yw+Separation-0.1,-0.1]) 
				scale([1.2,1,1.1]) rotate([-90,180,0]) 
					linear_extrude(height = (maxy)*(4*Separation+4*Yw)-Separation-3, center = false, convexity = 3)
						polygon(points=[[5,0],[4,1.5],[5,3],[20,3],[20,0]] );
		}
		// shorten for counter piece
		translate([-10,0,-0.1]) 
			cube(size=[10,Yw+Separation-0.1+3+Separation,5],center=false);	
	}
}


module band()
{
	for (y = [0:maxy-1])
	{
		for (x = [0:maxx-1]) 
		{
			// right leaning links
			if (x!=maxx-1)
			{
				if (y!=0)
					translate([x*7,y*(4*Separation+4*Yw),0]) link();
				else
					translate([x*7,y*(4*Separation+4*Yw),0]) half_link();
			}
			// left leaning links
			if (x!=0)
			{
				if (y!=maxy-1)
					translate([x*7+6,y*(4*Separation+4*Yw)+(5*Separation+6*Yw),0]) rotate([0,0,180]) link(); 	
				else
					translate([x*7+6,y*(4*Separation+4*Yw)+(5*Separation+6*Yw),0]) rotate([0,0,180]) half_link();
			}
		}
	}
}

module link()
{
	difference()
	{
		translate([2.1,0,0]) rotate([0,-40,0]) translate([-Xw,0,0]) 
			cube(size=[13,4*Yw+3*Separation,Xw],center=false);
		// through holes
		translate([0,0,0.26]) rotate([0,-40,0]) translate([Yw,Yw,-2.5*Xw]) 
			cube(size=[8,2*Yw+3*Separation,10],center=false);
		translate([0,Yw,1.2]) 
			cube(size=[12,2*Yw+3*Separation,5],center=false);
		// remove bottom
		translate([-1,-1,-4]) cube(size=[10,20,4],center=false);
		translate([-9.75,-1,-1]) cube(size=[10,20,5],center=false);
		// remove top
		translate([-1,-1,7.6]) cube(size=[13,20,4],center=false);
		translate([9.2,-1,-1]) cube(size=[10,20,15],center=false);
	}
}



module half_link()
{
	translate([0,Yw+Separation,0]) difference()
	{
		translate([2.1,0,0]) rotate([0,-40,0]) translate([-Xw,0,0]) 
			cube(size=[13,3*Yw+2*Separation,Xw],center=false);
		// through holes
		translate([0,0,0.26]) rotate([0,-40,0]) translate([Yw,Yw,-2.5*Xw]) 
			cube(size=[8,1*Yw+2*Separation,10],center=false);
		translate([0,Yw,1.2]) 
			cube(size=[12,1*Yw+2*Separation,5],center=false);
		// remove bottom
		translate([-1,-1,-4]) cube(size=[10,20,4],center=false);
		translate([-9.75,-1,-1]) cube(size=[10,20,5],center=false);
		// remove top
		translate([-1,-1,7.6]) cube(size=[13,20,4],center=false);
		translate([9.2,-1,-1]) cube(size=[10,20,15],center=false);
	}
}

