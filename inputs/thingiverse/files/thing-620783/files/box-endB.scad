//copyright 2015 Richard Swika
//All Rights Reserved
//Rev. Orig - Jan 2, 2015 - 
//Use anytime you need a small hollow box of specific dimensions and wall thickness. 
//Initially designed as pasta box ends to help prevent spills; slip over the end of the existing box.
//Can also make a hollow beam or rectangular tube.
//Rev. A - Jan 6, 2016 - changed slider bars to input boxes for a better user expierence in Customizer
//per user requests - thanks to Philip Brechler for feedback
//Rev B - March 25, 2016 - Updated to work with customizer

/* [Dimensions] */

//Inside length, X axis (mm)?
length = 71;

//Inside width, Y axis (mm)?
width = 36;

//Inside height, Z axis (mm)?
height = 25;

//Thickness of walls (mm)?
wall_thickness = 1;

//Thickness of end (mm)?
end_thickness = 1;


module box_end(){
	translate([0,0,height/2])
	difference(){
		cube([length+2*wall_thickness,width+2*wall_thickness,height+end_thickness],center=true);
		translate([0,0,end_thickness-0.02]) cube([length,width,height+1],center=true);
	}
}

box_end();