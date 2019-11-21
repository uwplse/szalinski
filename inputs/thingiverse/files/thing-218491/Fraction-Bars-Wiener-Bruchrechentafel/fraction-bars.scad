
///////////////////////////////////////////////////////////
//                                                       //
//                     FRACTION BARS                     //
//                                                       //
//              Wiener Bruchrechentafel (1904)           //
//                                                       //
///////////////////////////////////////////////////////////
//                                                       //
//     Parametric Model for OpenSCAD version 2013.06     //
//                  (c) bitcraftlab 2014                 //
//                                                       //
///////////////////////////////////////////////////////////

// Educational tool for teaching fractions to the Blind.
// Original design dates back to 1910 or earlier.

// See: Alexander Mell's "Der Blindenunterricht. Vorträge über Wesen, Methode und Ziel des Unterrichtes 
// in der Blindenschule." (Image on Page 112)
// >>> https://archive.org/stream/derblindenunterr00alex#page/112/mode/1up

// Idea to recreate the design for 3D printing by Golan Levin >>> @golan
// Discovery of original design + OpenSCAD model by Martin Schneider >>> @bitcraftlab
// This model is released under CC-BY-SA.


///////////// PARAMS ////////////////////////////////////// 


/* [Bars] */

// >>> Number of Fraction Bars >>>
bars = 10;  // [1:20]

// >>> Relative BorderSize [0 .. 1]
border_amount = 0.0;

// >>> Try to add Spacing between Bars
bar_spacing = 0.0;


/* [Frame] */

// >>> Width of the Frame
width =  10.0;

// >>> Length of the Frame
length = 14.14;

// >>> Height of the Frame
height = 0.6;

// >>> Roundness of outer Frame Edge [0 .. 1] 
rounding = 1.0;


/* [Details] */

// >>> Minimum Thickness of the Model
min_thickness = 0.2;     

// >>> Gaps between Parts of the Model
tiny_gap = 0.05;         

// >>> Fraction Bar Detail
bar_resolution = 16;

// >>> Frame Border Detail
border_resolution = 16;


/* [Hidden] */

// Part selection does not work in the Thingiverse Customizer App :-(

// >>> Select Parts to Print
parts = "All"; // [Frame,Bars,All]

bar_color = "CornFlowerBlue";
frame_color = "White";


///////////// DEPENDENT VARS //////////////////////////////

// make sure there is always room for the bars
max_border = height - tiny_gap - min_thickness;

// interpolate between valid border sizes
border =  min_thickness + border_amount * (max_border - min_thickness);

// let's assume uniform thickness for all the frame borders (including the bottom)
zgap = border;
xgap = border;

// maximize the radius within the limits imposed by the parameters
min_radius_by_thickness =  tiny_gap + min_thickness;
max_radius_by_length =  (length - (bars + 2) *  min_thickness - bars * bar_spacing ) / (bars + 1) / 2 ;
max_radius_by_height = height - zgap;
max_radius = min(max_radius_by_height, max_radius_by_length);
radius = max(min_radius_by_thickness, max_radius);

ygap = border + radius;

// since we will use a three-fold minkowski multiplication to round off 
// the outer edges the rounding radius must be smaller than 
// 1/3 of the frame height. It should also be smaller than the frame border

max_rounding = min(height / 3 - 0.000001, border);
border_rounding = max_rounding * rounding;

// inner dimensions of the frame
bar_width = width - 2 * xgap ;
bar_length = length - 2 * ygap;

// output computed values
echo("BORDER", border);
echo("RADIUS", radius);


///////////// MODULES /////////////////////////////////////

module fraction_bar_toy() {

	// flip the y-axis
	mirror([0, 1, 0])

	// center the design ontop of the xy-planr
	translate([-width/2, -length/2, height])
 
	// rotate the xz-plane to the xy-plane
	rotate([0, 90, 0]) {

		if(parts == "Bars" || parts == "All" ) color(bar_color) fraction_bars();
		if(parts == "Frame" || parts == "All" ) color(frame_color) frame();

	}

}

// create an assembly of fraction bars
module fraction_bars() {

    // reduce bar radius and width by a tiny gap
    fbar_width  = bar_width - tiny_gap;
    fbar_radius = radius - tiny_gap;
    fbar_length = bar_length ;

     dy = fbar_length / bars ;
	for(i = [1:bars]) {
          translate([0, ygap + (i-1) * dy, xgap + tiny_gap ]) {
			fraction_bar(w = fbar_width, r = fbar_radius, fractions = i);
		}
	}

}

// create the frame with grooves for the fraction bars
module frame() {
	difference() {
		frame_box();
    		grooves();
	}
}

// create a simple box, possibly with rounded corners
module frame_box() {
	if(rounding > 0) {
		rounded_cube([height, length, width], d = border_rounding, $fn = border_resolution);
	} else {
		cube([height, length, width]);
	}
}



// create the grooves to hold the fraction bars
module grooves() {
	dy = bar_length / bars ;
	for(i = [1:bars+1]) {
        translate([0, ygap + (i-1) * dy, xgap]) {
			cylinder(h = bar_width, r = radius, $fn = bar_resolution);
		}
	}
}



///////////// SUBMODULES //////////////////////////////////

// compose a fraction bar from scaled cylinder slices
module fraction_bar(w, r, fractions) {

    dx = 1.0 / fractions;
    gap = tiny_gap / w;

    scale([r, r, w]) {
		for(i = [0:fractions-1]) {
			cylinder_slice(x1 = dx * i, x2 = dx * (i + 1) - gap);
		}
    }
}

// a slice of the unit cylinder with radius 1.0
module cylinder_slice(x1, x2) {
    dx = x2 - x1;
    translate([0, 0, x1]) {
		cylinder(h = dx, r = 1.0, $fn = bar_resolution);
	}
}

// create a cube with rounded corners 
module rounded_cube(dims, d, $fn = 8) {

	// this may be a bit computationally expensive ...
	minkowski() {
		cube([dims[0] -d*3, dims[1] - d*3, dims[2] - d*3 ] );
	     translate([d/2, d/2, d/2]) cylinder(r = d/2, h = d, center = true);
    		translate([d/2, d/2, d/2]) rotate([0, 90, 0]) cylinder(r = d/2, h = d, center = true);
 		translate([d/2, d/2, d/2]) rotate([90, 0, 0]) cylinder(r = d/2, h = d, center = true);
	}

}

///////////// BUILD ///////////////////////////////////////

fraction_bar_toy();








