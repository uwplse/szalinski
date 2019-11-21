// parametric T-Slot nuts for OpenBuilds V-Slot

holeDiameter = 4.8; // diameter of nut hole
nutLength = 10; // overall length of nut
rows = 4; // number of rows of nuts to make
columns = 3; // number of columns of nuts to make

module nut()
{
	rotate([180,0,0]) 
	difference() 
	{
		translate([-5.25, -nutLength/2, 0]) rotate([270,0,0]) linear_extrude(height=nutLength) polygon([ [0,0], [10.5, 0], [10.5, 1.4], [7.75, 3.9], [2.75, 3.9], [0, 1.4] ]);
		translate([0,0,-1.2]) cylinder(r=holeDiameter/2, h=10, $fn=100, center=true
       );
		
	}
}

for(x=[0:(rows-1)]) for(y=[0:(columns-1)])
{
	translate([x*13, y*(nutLength + 2), 0]) nut();
}

*translate([-6, -7.5, 0]) cube([120, 120, 1]);