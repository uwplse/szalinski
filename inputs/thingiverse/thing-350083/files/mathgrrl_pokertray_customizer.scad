// mathgrrl customizable poker chip rack

////////////////////////////////////////////////////////////////////////////
// parameters //////////////////////////////////////////////////////////////

// Diameter of one poker chip (in millimeters)
Chip_Diameter = 20; 

// Thickness of one poker chip (in millimeters)
Chip_Thickness = 3.35; 

// Number of chips you want in each row of the rack
Number_of_Chips = 20;

// Number of rows you want in the rack
Number_of_Rows = 3;

// Thickness of the rack itself
Rack_Thickness = 2; 

// Enter a tolerance (more if your chips are too tight, less if they are too loose)
Fudge = 1;

// Parameters invisible to the user
$fn = 96*1;						
radius = Chip_Diameter/2 + Fudge;
height = Chip_Thickness*Number_of_Chips + Fudge;
thickness = Rack_Thickness*1;
rows = Number_of_Rows*1;
shift = 2*1; 		// to make clean holes and/or holes with edges

////////////////////////////////////////////////////////////////////////////
// renders /////////////////////////////////////////////////////////////////

for (i = [1:1:rows]){
	translate([0,(i-1)*(2*radius+thickness),0]) chipstack();
}

////////////////////////////////////////////////////////////////////////////
// module for holding one stack of chips ///////////////////////////////////

module chipstack(){
	// shift down to platform
	translate([0,0,-.5])
		difference(){
			// outside cylinder
			translate([0,0,radius+thickness]) 
				rotate(90,[0,1,0]) 
					cylinder(h=height+2*thickness,r=radius+thickness);
			// take away chip cylinder
			translate([thickness,0,radius+thickness]) 
				rotate(90,[0,1,0]) 
					cylinder(h=height,r=radius);
			// take away thumb cylinder
			translate([-shift,0,radius+thickness]) 
				rotate(90,[0,1,0]) 
					cylinder(h=height+2*thickness+2*shift,r=radius-3*thickness);
			// take away top
			translate([-shift,-.5*(height+2*shift),radius+thickness])
				cube(height+2*thickness+2*shift);
			// flatten bottom
			translate([-shift,-5,-10+.5])
				cube([height+2*thickness+2*shift,10,10]);
		}
}


