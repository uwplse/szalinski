// ########### Parameters ###########
/* [Text] */
//What text would you like displayed?
text = "Board Game text";
//What font would you like to use?
font = "Arial";
//What size should the text be?
size = 8;

/* [Plate] */
//In mm, how wide should the plate be?
width = 133;
//In mm, how long should the plate be?
length = 34.5;
//In mm, how high should the layer without text be?
first_layer = 1.5;
//In mm, how high should the layer with text be?
second_layer = 1.5;
height = first_layer + second_layer;

/* [Hidden] */
// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

// ########## Project Space #########
difference() {
	cube([width, length, height]);
	translate([width / 2, length / 2, first_layer]){
		linear_extrude(height){
			text(
				text,
				size = size, 
				font = font,
				valign = "center",
				halign = "center");
		}
	}
}
