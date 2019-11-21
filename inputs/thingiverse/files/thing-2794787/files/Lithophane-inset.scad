// Lithophane inset for Sonogram picture frame 
// by György Balássy 2018 (http://gyorgybalassy.wordpress.com)
// https://www.thingiverse.com/thing:2794787

// Original model: keychain-Customizable Lithopane by Mark G. Peeters 
// http://www.thingiverse.com/thing:308109
// version 1.3 

// Use this tool to convert your image files to DAT:
// http://customizer.makerbot.com/image_surface

// preview[view:south, tilt:top]
//
//
/* [Image] */

// Load a 100x100 pixel image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox! *** ALSO IF YOU HAVE LETTERS IN YOUR IMAGE make sure to reverse the image before uploading so the letters are not backwards.
image_file = "my_image.dat"; // [image_surface:100x100]

/* [Adjustments] */

// What layer height will you slice this at? The thinner the better.
layer_height = 0.1;

// Use plastic color opacity to set this. The lower the layer height, the more layers you can use.
number_of_layers = 16; // [5:30]

/* [Hidden] */

border_width = 1.5;
border_thick = 2.2;
tag_size = 41.5 - 2 * border_width;

// Base will always be 2 layers thick.
min_layer_height = layer_height*2;
height = layer_height*number_of_layers;
maxheight = height+min_layer_height;

$fa = 1;   // Default minimum facet angle.
$fs = 1;   // Default minimum facet size.

// Make litho and trim bottom and sides
difference() {
  translate([0, 0, min_layer_height]) 
    scale([(tag_size/100),(tag_size/100),height]) 
      surface(file=image_file, center=true, convexity=5); //litosurface moved up min_layer_height
  translate([0,0,-(maxheight)]) 
    linear_extrude(height=maxheight) 
      square(tag_size, center=true); //cutting bottom off surface

  // make tube to trim lith.
  difference() {
    translate([0, 0, -7]) 
      cylinder(maxheight+15,r= tag_size);     // Outside
    translate([0, 0, -9]) 
      cylinder(maxheight+18,r= (tag_size/2)); // Inside
  }
}

// Add border.
difference() {
  cylinder(border_thick,r= (tag_size/2)+border_width); // Outside
  cylinder(border_thick+1,r= (tag_size/2.02));         // Inside
}
