// Size of the hole for the nut (flat-to-flat)
nutSize = 5.5; 

// Diameter for the screw hole
holeSize = 3.1; 

// Rotation for the nut
nutRotation = 90; 

// Length of the T-Nut
length = 10; 

// Number of Rows and Columns of T-Nuts
rows = 5;
columns = 10;

// Adjustment for height of nut inside T-Nut
depthChange = 0; 

/* {Hidden} */

// definitions for the hexagonal nut shape
module box(w,h,d) {
	scale ([w,h,d]) cube(1, true);
}
module hexagon(height, depth) 
{
	boxWidth=height/1.75;
	
	union()
	{
		box(boxWidth, height, depth);
		rotate([0,0,60]) box(boxWidth, height, depth);
		rotate([0,0,-60]) box(boxWidth, height, depth);
	}
}

module nut()
{
	rotate([180,0,0]) 
	difference() 
	{
		translate([-5.25, -length/2, 0]) rotate([270,0,0]) linear_extrude(height=length) polygon([ [0,0], [10.5, 0], [10.5, 1.4], [7.75, 3.9], [2.75, 3.9], [0, 1.4] ]);
		translate([0,0,-1.2]) cylinder(d=holeSize, h=1.25, $fn=100);
		
		hull()
		{
			translate([0,0.3,-5+depthChange]) rotate([0,0,nutRotation]) hexagon(nutSize, 8.0);
			translate([0,-0.3,-5+depthChange]) rotate([0,0,nutRotation]) hexagon(nutSize, 8.0);
		}
	}
}

for(x=[1:columns]) for(y=[1:rows])
{
	translate([x*13, y*(length + 2), 0]) nut();
}

//translate([-6, -7.5, 0]) cube([120, 120, 1]);
//nut();
