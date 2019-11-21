// StampMaker v.03
// Make an image based stamp
// onlyjonas, 2013-05-8

/* [Stamp] */
// image max size 100x100
image_file = "img.dat"; // [image_surface:100x100]

// slice layer height
layer_height = 0.5;

// The lower the layer height, the more layers you can use.
number_of_layers = 10; // [5:20]

// handle height
handle_height = 30;

// scale stamp (default size 10cm x 10cm)
scale = 1.0;

/* [Hidden] */
$fn = 50;
length = 100;
width = 100;
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;

module stamp() {
  // take just the part of surface we want
  difference() {
    translate([0, 0, min_layer_height]) scale([1,1,height]) surface(file=image_file, center=true, convexity=5);
    translate([0,0,-(height+min_layer_height)]) linear_extrude(height=height+min_layer_height) square([length, width], center=true);
  }
}

module handle() {
	// handle
	difference() {
		translate([0,0,-handle_height/2+1])
		cube([width, length, handle_height], center=true);
		
		translate([width/2+handle_height/8,0,-handle_height/2]) 
		rotate([0,25,0])cube([handle_height/2, width+2, handle_height/2], center=true);
		translate([-width/2-handle_height/8,0,-handle_height/2]) 
		rotate([0,-25,0])cube([handle_height/2, width+2, handle_height/2], center=true);
	}
}

scale(scale)
union() {
	translate([0,0,-stamph/2])stamp();
	handle();
};