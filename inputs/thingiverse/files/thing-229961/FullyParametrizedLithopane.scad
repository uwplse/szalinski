/* 
 * Based on Customizable Lithopane http://www.thingiverse.com/thing:78719
 * 
 * Switched to customizer's higher resolution image input (150 x 150 pixels)
 * Fully parametrized dimensions of lithopane based on thickness and size
 *
 */

// preview[view:south, tilt:top]

/* [Image] */

// Load a square image, simple photos work best. Will be scaled to 150x150 pixels. Make sure to click the Invert Colors checkbox!
image_file = "image5.dat"; // [image_surface:150x150]

/* [Adjustments] */

// Overall thickness/height of lithophane
height = 2;
// Overall length/width of lithophane in mm
size = 81;

//Layer you will be slicing at
layer_height = 0.01;

//Minimum height for bottom layer in mm (recommended at least 0.2)
bottom_padding = 0.4;

// lithophane border in mm
lithophane_border = 2;

/* [Hidden] */
resolution=150;
s=0.01;

difference(){
 union() {
  difference() {
    translate([0, 0, bottom_padding]) scale([(size-lithophane_border+1)/resolution,(size-lithophane_border+1)/resolution,height-bottom_padding]) surface(file=image_file, center=true, convexity=5);

  } // d
 
  linear_extrude(height=height){
    difference(){
      square([size, size], center=true);
      square([size-lithophane_border-s, size-lithophane_border-s], center=true);
    } // d
  } // le
} // u

translate([0,0,-(height)]) linear_extrude(height=height) square([size+s, size+s], center=true);

} //d