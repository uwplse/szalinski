// mathgrrl customizable sock bone

////////////////////////////////////////////////////////////////////////////
// parameters //////////////////////////////////////////////////////////////

// Length from one side of the sock to the other
length = 86; 

// Width/thickness of the folded sock
width = 13; 

// parameters that the user does not get to specify
$fn = 24*1;
radius = width*(8/13);
thickness = 2*1; 
height = 10*1; 

////////////////////////////////////////////////////////////////////////////
// renders /////////////////////////////////////////////////////////////////

sockbone();

////////////////////////////////////////////////////////////////////////////
// module for clip /////////////////////////////////////////////////////////

module sockbone(){
	linear_extrude(height)
	// 2D shape of bone holder
	union(){
		difference(){
			// outer bone
			union(){
				translate([radius,0,0]) 
					circle(radius);
				translate([radius,-width/2,0]) 
					square([length-2*radius,width]);
				translate([length-radius,0,0]) 
					circle(radius);
			};
			// take away inner bone
			union(){
				translate([radius,0,0]) 
					circle(radius-thickness);
				translate([radius,-(width-2*thickness)/2,0]) 
					square([length-2*radius,width-2*thickness]);
				translate([length-radius,0,0])
					circle(radius-thickness);
			}
			// take away opening
			translate([.25*length,0,0]) 
				square(.5*length);
		}
		// rounded end caps
		translate([.25*length,width/2-thickness/2,0])
			circle(.7*thickness);
		translate([.75*length,width/2-thickness/2,0])
			circle(.7*thickness);
	}
}