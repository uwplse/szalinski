use <utils/build_plate.scad>

// preview[view:south, tilt:top]

//Maximum size of the cookie cutter in mm
cookie_cutter_dimension = 130; //[50:130]
wall_thickness = 1.6; //[1.6:Thicker,.8:Thinner]
height = 15; //[15:Short,30:Tall]

// Load a 100x100 pixel image.(images will be stretched to fit). Note that this is kind of finicky, your image should be white on black (or use the invert checkbox) and should be just a silhouette with no internal shapes. For instance an image with a black background and a white circle will work, but an image with another black circle inside of the white one won't. See the thing page for examples of images that will work and ones that won't. One other thing, if you blur your image slightly you will get smoother outlines.
image_file = ""; // [image_surface:50x50]

//Select the grey level to use as the cookie cutter. The swatch shown in the preview shows you what color you are using.
grey_level = 128; //[1:256]


//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic]

/* [Hidden] */
// What layer height will you slice this at?  The thinner the better.
layer_height = 1;

// The lower the layer height, the more layers you can use.
number_of_layers = 256;
length = 130;
width = 130;

image_height = layer_height*number_of_layers;
preview_tab = "final";

translate([0,0,-1])
build_plate(build_plate_selector);

if(preview_tab != "final" ){	
	translate([0,0,-1])
		color([grey_level/256,grey_level/256,grey_level/256])
			square([cookie_cutter_dimension/2,cookie_cutter_dimension/2]);
}
cookie_cutter();

  // take just the part of surface we want
module shape(){
projection(cut = true)
translate([0,0,-(.5+grey_level)])
    scale([cookie_cutter_dimension/50,cookie_cutter_dimension/50,image_height]) surface(file=image_file, center=true, convexity=5);
}

module outset(dist){

		minkowski(){
			shape();
			circle(r=dist);
		}

	
}

module cookie_cutter (){

		translate([0,0,wall_thickness/2])
			linear_extrude(height=height)
				difference(){
					outset(wall_thickness);
					shape();
				}
		linear_extrude(height=wall_thickness)
			difference(){
				outset(5);
				shape();
			}

}