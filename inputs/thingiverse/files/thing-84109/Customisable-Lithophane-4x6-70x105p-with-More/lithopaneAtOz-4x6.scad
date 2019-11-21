/* 
 * Based on Customizable Lithopane http://www.thingiverse.com/thing:74322
 * 
 * Added ability to remove hook hole and specify border sizes
 * Fixed X/Y size to match surface() returned size and added smidgen to difference.
 *
 */

// preview[view:south, tilt:top]

/* [Image] */

// Load a 70x105 pixel image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox!
image_file = "image-surface4x6.dat"; // [image_surface:70x105]

/* [Adjustments] */
// Set both hole values to zero for no hole
hole_diameter = 4;
hole_border = 2;
// Zero for no border
lithophane_border = 3;
// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;

// The lower the layer height, the more layers you can use.
number_of_layers = 12; // [5:20]

/* [Hidden] */
s=0.01;
length = 69; // surface() produces a n-1 object
width = 104;  // bug in surface drops last line

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;
height_borderless=height/2;
union() {
	
  // take just the part of surface we want
  difference() {
    translate([0, 0, min_layer_height]) scale([1,1,height]) surface(file=image_file, center=true, convexity=5);
	// -
    translate([0,0,-(height+min_layer_height)]) linear_extrude(height=height+min_layer_height) square([length+s, width+s], center=true);
  } // d
  linear_extrude(height=layer_height*2) square([length+lithophane_border, width+lithophane_border], center=true);
  
//render()
  linear_extrude(height=( (lithophane_border>0) ? height+min_layer_height : height_borderless+min_layer_height)){
	  difference(){
		
		union(){
	      square([length+lithophane_border, width+lithophane_border], center=true);
		  translate([0, width/2+hole_radius+lithophane_border/2+s, 0])
		    circle(r=hole_radius+ hole_border,$fn=24);
		} // u
		// -
		
	    union(){
	      square([length, width], center=true);
		  translate([0, width/2+hole_radius+lithophane_border/2+s, 0])
	        circle(r=hole_radius,$fn=8);
	    } // u
	  } // d
  } // le
} // u


