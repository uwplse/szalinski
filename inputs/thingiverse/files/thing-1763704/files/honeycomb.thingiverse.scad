// honeycomb generator
// generic library functions for parametric honeycomb creation

// 2016Sep10, v0.0.1, ls (http://www.thingiverse.com/Bushmills)
//                    initial version
// 2016Sep28, v0.0.2  circle with $fn=6 is faster than 3 rotated rectangles
//    

// use:
// honeycomb(cells wide, cells long, base plate thickness, cell size, height, wall to cell size percentage );


// *******************************************************************************************************************
// ******************************* remove this section when using this file as library *******************************
// *******************************     present only for the thingiverse customiser     *******************************
// *******************************************************************************************************************

columns=8;			// [2:255]

rows=8;         		// [2:255]

base_plate_thickness=0;	// [0:0.1:15]

cell_size=8;                    // [0.3:0.1:20]

height=10;			// [0.2:0.1:200]

fill=20;				// [1:99]

// example:
honeycomb(columns, rows, base_plate_thickness, cell_size, height, fill);

// *******************************************************************************************************************


sqrt3=sqrt(3);			
little=0.01;	// improve preview quality

// a single filled hexagon
module hexagon(l)  {
	circle(l, $fn=6);			// faster
//	for (a=[-60:60:60])  {			// previous method is slower
//		rotate([0, 0, a])
//		square([l, sqrt3*l], center=true);
//	}
}

// parametric honeycomb  
module honeycomb(x, y, base, cell, h, fill)  {
	w=cell*fill/100;						// calculate wall thickness
	echo("wall:", w);						// display (walls won't get printed when too thin)

	difference()  {
		cube([(1.5*x+0.5)*cell+w, cell*sqrt3*y+1.5*w-w/2, h]);	// rectangular plate

		translate([w-cell*2, w, base-little/2])
		linear_extrude(h+little)  {				// punch with matrix of hexagonal prisms
			for (a=[0:x/2+1], b=[0:y], c=[0:1/2:1/2])
			translate([(a+c)*3*cell-w/2, (b+c)*sqrt3*cell-w/2])
			hexagon(cell-w);
		}
	}
}
