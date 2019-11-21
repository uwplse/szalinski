// Customizable Pixel Beads Photo Panel
// preview[view:south, tilt:top];

/* [Image] */

// Picture is reduced to 20x20. You may wish to crop and resize it manually before uploading. Check "Invert Colors".
picture = [0, 0, 0, 0, 0.541, 0.525, 0.22, 0.106, 0.125, 0.275, 0.302, 0.306, 0.42, 0.298, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.329, 0.498, 0.525, 0.196, 0.227, 0.271, 0.306, 0.271, 0.243, 0.196, 0.078, 0.016, 0, 0, 0, 0, 0, 0, 0.004, 0.008, 0.525, 0.588, 0.478, 0.302, 0.369, 0.447, 0.471, 0.42, 0.337, 0.282, 0.196, 0.039, 0, 0, 0, 0, 0, 0.004, 0.004, 0.02, 0.49, 0.788, 0.631, 0.42, 0.514, 0.424, 0.349, 0.314, 0.325, 0.267, 0.184, 0.106, 0.008, 0, 0, 0, 0, 0, 0.004, 0.161, 0.737, 0.812, 0.6, 0.439, 0.271, 0.612, 0.557, 0.506, 0.396, 0.388, 0.239, 0.043, 0.02, 0, 0, 0, 0, 0.004, 0.004, 0.318, 0.769, 0.792, 0.514, 0.329, 0.765, 0.796, 0.8, 0.784, 0.588, 0.616, 0.753, 0.588, 0.106, 0, 0, 0, 0, 0, 0.004, 0.047, 0.765, 0.761, 0.333, 0.553, 0.792, 0.859, 0.89, 0.694, 0.357, 0.753, 0.867, 0.678, 0.059, 0, 0, 0, 0, 0.004, 0.004, 0.624, 0.58, 0.624, 0.271, 0.384, 0.443, 0.569, 0.533, 0.49, 0.333, 0.384, 0.604, 0.494, 0.008, 0, 0, 0, 0, 0.004, 0, 0.482, 0.776, 0.545, 0.522, 0.431, 0.42, 0.522, 0.592, 0.451, 0.306, 0.231, 0.251, 0.118, 0.035, 0.004, 0, 0, 0, 0, 0.012, 0.031, 0.463, 0.506, 0.553, 0.58, 0.596, 0.624, 0.639, 0.957, 0.733, 0.757, 0.31, 0.145, 0.482, 0.004, 0.004, 0, 0, 0.004, 0, 0.004, 0.459, 0.612, 0.576, 0.627, 0.612, 0.678, 0.635, 0.729, 0.71, 0.333, 0.455, 0.176, 0.047, 0, 0, 0, 0, 0.004, 0, 0.004, 0.004, 0.584, 0.592, 0.584, 0.627, 0.859, 0.808, 0.757, 0.733, 0.529, 0.455, 0.137, 0.008, 0, 0, 0, 0, 0, 0.004, 0.008, 0.004, 0.447, 0.643, 0.667, 0.733, 0.624, 0.51, 0.557, 0.537, 0.459, 0.306, 0.008, 0.008, 0, 0, 0, 0, 0, 0.004, 0.004, 0.004, 0.039, 0.639, 0.663, 0.733, 0.655, 0.682, 0.812, 0.71, 0.361, 0.247, 0.004, 0.004, 0, 0, 0, 0, 0, 0.004, 0.004, 0.004, 0.012, 0.541, 0.761, 0.694, 0.659, 0.541, 0.514, 0.408, 0.337, 0.031, 0.008, 0.004, 0, 0, 0, 0, 0, 0.004, 0.008, 0.004, 0.016, 0.51, 0.69, 0.71, 0.839, 0.78, 0.745, 0.651, 0.463, 0.008, 0.004, 0.004, 0, 0, 0, 0, 0, 0.008, 0.004, 0.004, 0.31, 0.518, 0.588, 0.686, 0.863, 0.863, 0.886, 0.816, 0.247, 0.008, 0.004, 0.008, 0, 0, 0, 0, 0.004, 0.004, 0.039, 0.031, 0.173, 0.525, 0.596, 0.671, 0.757, 0.788, 0.706, 0.392, 0.263, 0.651, 0.239, 0.008, 0.004, 0, 0, 0, 0.502, 0.62, 0.027, 0.031, 0.329, 0.361, 0.639, 0.631, 0.682, 0.659, 0.561, 0.533, 0.278, 0.749, 0.784, 0.745, 0.729, 0.42, 0.482, 0.553, 0.561, 0.639, 0.333, 0.204, 0.322, 0.404, 0.58, 0.569, 0.612, 0.608, 0.659, 0.498, 0.502, 0.812, 0.784, 0.608, 0.694, 0.698, 0.639, 0.569]; // [image_array:20x20]

panel_shape = 1; // [0:Square, 1:Circle]

// Border width relative to unit pixel size.
border_width = 1;

// Image thickness relative to unit pixel size.
thickness = 0.5;

/* [Pixels] */

// Circular and octangular pixels are slower to generate than diamonds.
pixel_shape = 4; // [4:Diamond, 8:Octagon, 16:Circle]

// Orientation of strands connecting pixels.
orientation = 1; // [0:Horizontal, 1:Vertical]

// The proportion of each pixel's width reserved for the support grid.
grid_size = 0.3;

// The proportion of each pixel's width used to represent variation between white and black pixel values. Pixel size and grid size do not necessarily have to add up to one; sums >1 allow overlap between neighboring strands, while values <1 ensure there is always a gap.
pixel_size = 0.7;

// Elongation is applied to pixel size along strands; it can yield more continuous shapes. Set to 0 to prevent overlap.
pixel_elongation = 1;

/* [Hidden] */

width = 20;
height = 20;
size = width * height;

function px(i) = i % width;
function py(i) = floor(i / width);
function pv(i) = (pixel_size * picture[i]) + grid_size;
function flipy(y) = height - 1 - y;

union() {
	
	intersection() {
		Image();
		Shape();
	}
	
	Border();
}


module Border() {
	difference() {
		Shape(border_width);
		translate([0, 0, -thickness/2]) scale([1, 1, 2]) Shape(0);
	}
}

// The image is clipped to this shape.
module Shape(padding=0) {
	if (panel_shape == 0) {
		translate([-padding, -padding, 0])
		cube([width-1+(padding*2), height-1+(padding*2), thickness]);
	}
	else {
		translate([(width-1)/2, (height-1)/2, 0])
		scale([width-1+(padding*2), height-1+(padding*2), 1])
		cylinder(r=0.5, h=thickness, $fn=30);
	}
}

// The image module combines the actual bitmap pixels with the support grid.
module Image() {
	union() {
		Bitmap();
		Grid(orientation);
	}
}

// The grid module defines a sequence of uniform size rectangular strips,
// intended as supports to ensure the bitmap pixels are located correctly.
// The boolean vertical parameter determines the strip orientation.
module Grid(vertical) {
	if (vertical == 1) {
		for (i = [0 : width - 1]) {
			translate([i - (grid_size/2), 0, 0])
			linear_extrude(height=thickness)
			square([grid_size, height-1]);
			//cube([grid_size, height-1, thickness]);
		}
	}
	else if (vertical == 0) {
		for (i = [0 : height - 1]) {
			translate([0, flipy(i) - (grid_size/2), 0])
			linear_extrude(height=thickness)
			square([width-1, grid_size]);
			//cube([width-1, grid_size, thickness]);
		}
	}
}

// The bitmap module iterates through every element in the picture array
// and uses the pixel module to draw a pixel object at each bitmap location.
// Pixel size is scaled in one dimension according to brightness.
// (Size may also be scaled in perpendicular direction along strands if elongation is nonzero.)
// (Bonus idea: instead of iterating through the picture array, let the user
// draw a path with a draw_polygon widget, then sample the bitmap at path point,
// and connect pixels with segments from drawn path instead of uniform grid.)
module Bitmap() {
	for (i = [0 : size-1]) {
		assign(x = px(i), y = flipy(py(i)), v = pv(i)) {
			Pixel(x, y,
					(orientation == 0 ? 1 + (pixel_elongation * v) : v),
					(orientation == 1  ? 1 + (pixel_elongation * v) : v));
		}
	}
}

// The pixel module places a "pixel" shape centered at coordinates x, y.
// The pixel is scaled to width and height given by w, h.
module Pixel(x, y, w, h) {
	translate([x, y, 0])
	scale([w, h, 1])
	linear_extrude(height=thickness)
	// pixel is created with unit diameter to facilitate easy scaling
	circle(r=0.5, center=true, $fn = pixel_shape);
}
