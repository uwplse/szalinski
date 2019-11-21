/**
 * A labelling system for IKEA Trofast containers. Customizable text.
 *
 * Author: Joseph Paul <joseph@sehrgute.software>
 * License: Public Domain
 */


/* [Tag Dimensions] */

// Material thickness of the entire tag
thickness = 2; // [1:10]
// Lenght of the tag (keep <130mm for the short side and <230mm for the long side of your Trofast)
length = 100; // [10:230]
// Width of the entire Tag
width = 20; // [10:230]


/* [Caption] */

// The text written on the tag
subject = "ERFINDERGARDEN";
// Font size for the text
font_size = 8; // [2:128]
// Font Family (all google fonts are supported, see https:\/\/fonts.google.com)
font_family = "Open Sans";

hinge_space = 10;
hinge_height = 10;

module tag()
{
	union() {
		cube([length, thickness, width]);
		translate([0, 0, width - thickness])
		cube([length, hinge_space + 2*thickness, thickness]);
		translate([0, hinge_space + thickness, width - thickness - hinge_height])
		cube([length, thickness, hinge_height]);
	}
}

module caption()
{
	text(subject, font=font_family, size=font_size, valign="center", halign="center");
}

difference() {
	tag();
	translate([length/2, thickness+1, width/2])
	rotate([90, 0, 0])
	linear_extrude(thickness+2)
	caption();
}
