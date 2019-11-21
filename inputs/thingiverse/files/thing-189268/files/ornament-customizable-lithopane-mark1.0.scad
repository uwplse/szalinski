//Ornament-Customizable Lithopane by Mark G. Peeters 
//http://www.thingiverse.com/thing:189268
//version 1.0 has a 13mm hole for most tiny lights
//if you are using openSCAD then you are cool! You can get DAT files for local use using this tool
//http://customizer.makerbot.com/image_surface
// i used the nice code for adjusting layers from here:
//http://www.thingiverse.com/thing:74322

// preview[view:north, tilt:bottom diagonal]
//
//
/* [Image] */

// Load a 100x100 pixel image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox! *** ALSO IF YOU HAVE LETTERS IN YOUR IMAGE make sure to reverse the image before uploading so the letters are not backwards.
image_file = "image-surface.dat"; // [image_surface:100x100]

/* [Adjustments] */

//NOTE: ALL units are in millimeters (mm)
diameter = 70;// [50:100]

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.1;

// The lower the layer height, the more layers you can use.
number_of_layers = 12; // [5:30]

//Thickness of sphere (2mm is fine) you picked
shellthick = 2; //[1:4]

/* [Hidden] */

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;
maxheight = height+min_layer_height;


union() {  //union 1

// trim surface to circle & scale to hieght
  difference() { //diff 1
  translate([0, 0, min_layer_height]) scale([(diameter/100),(diameter/100),height]) surface(file=image_file, center=true, convexity=5); //litosurface
  union() {  //union tube and bottom to trim surface
  translate([0,0,-(maxheight)]) linear_extrude(height=maxheight) circle(diameter, center=true);//cutting bottom off surface
  difference() {  //diff make tube
                translate([0, 0, -7]) cylinder(maxheight+15,r= diameter); //outside
                translate([0, 0, -9]) cylinder(maxheight+18,r= (diameter/2)); //inside
               } //end diff make tube
            } //end union tube and bottom to trim surface
               } //end diff 1
// the surface is now trimmed 

//make frame wall shell thickness
difference() {  //diff make frame tube
                 cylinder(maxheight,r= (diameter/2)+shellthick); //outside
                 cylinder(maxheight+1,r= (diameter/2.02)); //inside
                } //end diff make frame tube
//end make frame wall

//make half sphere back half   sphere(2, $fn=100)
translate([0, 0, maxheight])  difference() {     //diff make sphere back
             sphere((diameter/2)+shellthick, $fn=100); //outside shell
            sphere((diameter/2)); //inside cutout
             translate([0, 0, -(diameter)]) cylinder(diameter,r= (diameter/2)+5);//trim bottom half 
              // make hole shape for holiday light string style bulb
             rotate ([-80,0,0]) translate([0, -5, 0])  union() {  //complete hole
             translate([0, 0, 0]) cylinder(60,r= 6.5);//light hole
             hull() {
             translate([-15, 2, 0]) cylinder(60,r= 2.5);//sideways hole left
             translate([0, -5, 0])  cylinder(60,r= 2);//sideways slot left
                      }   
             hull() {
             translate([15, 2, 0]) cylinder(60,r= 2.5);//sideways hole right
             translate([0, -5, 0])  cylinder(60,r= 2);//sideways slot right
                      } 
                       }  //end complete hole
       }//end diff make sphere back

} //final union 1
