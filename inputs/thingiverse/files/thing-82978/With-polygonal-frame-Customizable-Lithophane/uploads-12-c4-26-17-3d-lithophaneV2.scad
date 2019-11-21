// preview[view:south, tilt:top]

// Lithophane V2 with different frame types
// Original script made by Makerbot (http://www.thingiverse.com/thing:74322)
// Modified by Carlosgs (http://carlosgs.es)


/* [Image] */

// Load a 150x150 pixel image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox!
image_file = "image-surface.dat"; // [image_surface:150x150]

/* [Adjustments] */

hole_diameter = 10;

image_angle = 0; // [0:360]

frame_side_number = 6; // [3:50]

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;

// The lower the layer height, the more layers you can use.
number_of_layers = 15; // [5:20]

/* [Hidden] */

length = 100;
width = 100;
// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;

union() {
  // take just the part of surface we want
intersection() {
  difference() {
    rotate([0,0,image_angle]) translate([0, 0, min_layer_height]) scale([100/150,100/150,height]) surface(file=image_file, center=true, convexity=5);
    translate([0,0,-(height+min_layer_height)]) linear_extrude(height=height+min_layer_height) square([length, width], center=true);
  }
    rotate([0,0,90])
      cylinder(r=length/2,h=height*2,$fn=frame_side_number);
}
  //linear_extrude(height=layer_height*2) square([length+4, width+4], center=true);
  linear_extrude(height=layer_height*2)
    rotate([0,0,90])
      circle(r=(length+4)/2, center=true, $fn=frame_side_number);

  linear_extrude(height=height+min_layer_height){
	  difference(){
		union(){
	     rotate([0,0,90])
          circle(r=(length+4)/2, center=true, $fn=frame_side_number);
		  translate([0, width/2+hole_radius+2, 0])
		    circle(r=hole_radius+5);
		}
	    union(){
	     rotate([0,0,90])
          circle(r=length/2, center=true, $fn=frame_side_number);
		  translate([0, width/2+hole_radius+2, 0])
	        circle(r=hole_radius);
	    }
	  }
  }
}
