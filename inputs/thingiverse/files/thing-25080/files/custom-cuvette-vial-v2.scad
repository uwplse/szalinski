//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//This code generates a rack with round or square holes.

//CUSTOMIZER VARIABLES



//round or square holes?
hole_shape=1; //[1:Round,0:Square]
//length of edge/diameter if square/round holes (mm)
hole_size=10;
//depth of hole (mm)
hole_depth=12;
//number of rows along the x axis
rows=4;
//number of columns along the y axis
columns=3;
//space between holes (mm)
spacing=1.6;
//thickness of bottom layer (mm)
bottom_thick=1.75;


/* [Hidden] */

//set openSCAD resolution
$fa=1;
$fs=1;


//takes an appropriately sized block and removes an array of holes
difference() {
	//main body
	cube(size=[rows*(hole_size+spacing)+spacing, columns*(hole_size+spacing)+spacing, bottom_thick+hole_depth], center=false);
	//holes
	holes(hole_shape,hole_size,hole_depth,rows,columns,spacing,bottom_thick);
}



module holes(hole_shape,hole_size,hole_depth,rows,columns,spacing,bottom_thick) {
	//This module generates an array of holes with one corner at the origin
	//moves the array of holes to be alligned with a non-centered cube later
	//moves corner of array to origin, raises holes by bottom_thick
	translate([hole_size/2+spacing, hole_size/2+spacing, hole_depth/2+bottom_thick+0.5]) {
		//generating rows and columns of holes
		//columns are Y axis
		for (b=[0:columns-1]) {
			//rows are X axis
			for (i=[0:rows-1]) {
				translate([i*(hole_size+spacing), b*(hole_size+spacing), 0]) {
					//square or round holes?
					//value of 1 = circles
					if (hole_shape==1) {
						cylinder(r=hole_size/2, h=hole_depth+1, center=true);
					}
					//any value not equal to 1 generates square holes
					else {cube(size=[hole_size, hole_size, hole_depth+1], center=true);
					}
						
					
				}
			}
		}	
	}
}



