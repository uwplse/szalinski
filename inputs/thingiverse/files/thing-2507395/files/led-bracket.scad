//------------------------------------------------------------------
/*

Bracket for multiple LED strips

Based on https://www.thingiverse.com/thing:1308286 Thanks to deadsy, aka Jason Harris

Frank van der Hulst, 21 Nov 2017

*/
//------------------------------------------------------------------
/* [Global] */

/*[General]*/
// Width of one LED strip; 12mm for IP67 protected, 10mm for IP30
strip_width = 12;                    // [5:20]                   
// Spacing interval of strips in mm; default to the same spacing as LEDs on the strip
strip_spacing = 16.6667;             // [5:.1:50]             
// Thickness of one LED strip; 4mm is for IP67 protected, 2.5mm for IP30
strip_thickness = 4;                 // [1:.5:5]                    
// Width of bracket in mm; should be less than LED spacing, or one of the LEDs will be obscured
bracket_width = 5;				     // [2:20]			
// Thickness of the bracket wall (mm)
wall_thickness = 2;					// [1:.1:5]		
// Diameter of attachment holes (mm)
hole_diam = 2;						// [1:.5:10]			
// Size of lugs at the ends for attachment holes (mm). May be 0.
lug_size = 6;						// [0:15]					
// Number of strips for one bracket
num_strips = 4;						// [1:20]			
// Roundness of corners (mm); default is wall_thickness/4
fillet_size = .5;					// [.2:.1:2.5]
// Whether bottom lug is square to the strips or flush
bottom_shape = "square";		    	// [flush,square]
// Wire diameter (mm); May be 0. Default is 4
wire_diameter = 0;						// [0:8]			
// Whether there are holes between strips or not
holes_between_strips = "yes";		// [yes,no]

// Distance between strips
separator_thickness = strip_spacing - strip_width;		

difference() {
  bracket();
  
  if (bracket_width > hole_diam) {
	if (lug_size >= hole_diam) {
		holes();
	}
	if (holes_between_strips == "yes" && separator_thickness >= hole_diam) {
		for (str = [1:num_strips-1])
			translate([str * strip_spacing - separator_thickness/2, -epsilon, bracket_width/2])  
				rotate([-90,0,0])   
					cylinder(d=hole_diam, h=wall_thickness*13, $fn=facets(hole_diam/2));
	}
  }
}

//  color("blue") translate([strip_spacing - separator_thickness/2, -epsilon, bracket_width/2])  rotate([-90,0,0])   cylinder(d=hole_diam, h=wall_thickness*13, $fn=facets(hole_diam/2));

//------------------------------------------------------------------

module bracket() {
	// Strip separators... one less than number of strips
	dividers = [		
		for (str = [1:num_strips-1])
			for(i = [0:3]) 
				[strip_spacing*(num_strips-str) - (((i == 0) || (i == 1)) ? 0 : separator_thickness),
				((i == 1 || i == 2)) ? 0 : strip_thickness]
	];

	bottom_lug = [
		[0, strip_thickness],
		[0, 0],
		// Bottom end
		[bottom_shape == "square" ? 0 : (wire_diameter > 0 ? -wire_diameter-wall_thickness*2:0)-lug_size-wall_thickness, bottom_shape == "square" ? -lug_size : 0],
		[bottom_shape == "square" ? -wall_thickness : (wire_diameter > 0 ? -wire_diameter-wall_thickness*2:0)-lug_size-wall_thickness, bottom_shape == "square" ? -lug_size : wall_thickness],
	];
	// Cross-section of bracket
	points= concat(bottom_lug,
	[
		// Main wall, bottom end
		[-wall_thickness, wall_thickness],
		[-wall_thickness, wall_thickness + strip_thickness],
        // Top end
		[strip_spacing * num_strips - separator_thickness + wall_thickness, wall_thickness + strip_thickness],
		[strip_spacing * num_strips - separator_thickness + wall_thickness, wall_thickness],
		// Bottom end
		[lug_size + strip_spacing * num_strips - separator_thickness + wall_thickness, wall_thickness],
		[lug_size + strip_spacing * num_strips - separator_thickness + wall_thickness, 0],
		[strip_spacing * num_strips - separator_thickness, 0],
		[strip_spacing * num_strips - separator_thickness, strip_thickness],
	], dividers); 

    linear_extrude(height=bracket_width, convexity=2) {
        filleted(fillet_size) rounded(fillet_size) polygon(points=points);
    }
    
    // Wire attachment
    if (wire_diameter > 0) {
        linear_extrude(height=bracket_width, convexity=2) {
            translate([bottom_shape == "square" ? -wire_diameter/2-wall_thickness : -wire_diameter/2-wall_thickness, 
                       bottom_shape == "square" ? wall_thickness : wire_diameter/2 + wall_thickness]) {
                union() {
                    rotate(bottom_shape == "square" ? 90 : 0) polygon(points=[
                        [wire_diameter/2+wall_thickness,0],
                        [wire_diameter/2+wall_thickness,-wire_diameter/2-wall_thickness],
                        [-wire_diameter/2-wall_thickness,-wire_diameter/2-wall_thickness],[-wire_diameter/2-wall_thickness,0],
                        [-wire_diameter/2,0],[-wire_diameter/2,-wire_diameter/2],
                        [wire_diameter/2,-wire_diameter/2],[wire_diameter/2,wire_diameter/2]]);
                    difference() {
                        circle(d = wire_diameter+wall_thickness*2);
                        circle(d = wire_diameter);
                    }
                }
            }
        }
    }
}

module holes() {
  // Top hole
  translate([strip_spacing * num_strips  - separator_thickness + wall_thickness + lug_size/2,0,0]) hole();
  // Bottom hole
  if (bottom_shape == "square") {
	translate([0,-lug_size/2,0])   rotate([0,0,90]) hole();
  } else {
	translate([(wire_diameter > 0 ? -wire_diameter-wall_thickness*2:0)-wall_thickness-lug_size/2,0,0])   hole();
  }
}

module hole() {
  translate([0, -wall_thickness, bracket_width/2]) rotate([-90,0,0]) {
    cylinder(r=hole_diam/2, h=wall_thickness*3, $fn=facets(hole_diam/2));
  }
}

//------------------------------------------------------------------
// The remainder relates to filleting

// control the number of facets on cylinders
facet_epsilon = 0.01;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

// small tweak to avoid differencing artifacts
epsilon = 0.05;

//------------------------------------------------------------------
// rounded/filleted edges

module outset(d=1) {
  minkowski() {
    circle(r=d, $fn=facets(d));
    children(0);
  }
}

module inset(d=1) {
  render() inverse() outset(d=d) inverse() children(0);
}

module inverse() {
  difference() {
    square(1e5, center=true);
    children(0);
  }
}

module rounded(r=1) {
  outset(d=r) inset(d=r) children(0);
}

module filleted(r=1) {
  inset(d=r) render() outset(d=r) children(0);
}

//------------------------------------------------------------------
