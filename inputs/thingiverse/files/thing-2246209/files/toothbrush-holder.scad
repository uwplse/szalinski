// Customizable Toothbrush Holder
// V1.0 - 2017/04/15
//
// timfou - Mitch Fournier
// http://www.thingiverse.com/thing:2246209

/*  TOOTHBRUSH SPECS:
		185-195mm (tall)
		20mm (widest)
		158-163mm (to bristles)
*/

/* [TEXT SPECS] */
// ---------------------
// Add text to stand? (Default: "yes")
add_text = "yes"; // [yes,no]
// Raised (embossed) or carved (engraved) text? (Default: "embossed")
text_type = "embossed"; // [embossed,engraved]
// Toothbrush owners (each name separated by a semicolon)
toothbrush_owners = "Luke:Leia:Darth";
// Text size (Default: 10)
text_size = 10;
// Text spacing (Default: 1.0)
text_spacing = 1.0;
// Space at the top of text (Default: 20)
text_top_margin = 20; 
// Font, available: https://fonts.google.com  (Default: "Verdana")
text_font = "Verdana";

/* [STAND SPECS] */
// ---------------------
// Number of toothbrush spots (Default: 3)
number_of_toothbrushes = 3;
// Space per slot (Default: 35)
space_per_slot = 35;
// Top circle cutout radius (Default: 11)
top_radius = 11;
// Bottom circle cutout radius (Default: 7)
bottom_radius = 7;
// Stand height (Default: 120)
height = 120;
// Top width (Default: 40)
top_width = 40; // [35:5:50]
// Base width (Default: 60)
base_width = 60; // [50:5:75]
// Arc resolution (Default: 64)
fn = 64*1;
$fn = fn;

// Customizer can't handle a string vector, so this is the workaround
names = split(":", toothbrush_owners);
//echo(names);


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//
//	Draw ***ALL THE PARTS*** (*:hide, %:ghost, #:hilite)
//
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
difference() {
	drawStand(number_of_toothbrushes);
	drawHoles(number_of_toothbrushes);
	if (text_type=="engraved") { if (add_text=="yes") { drawNames(); } }
}
if (text_type=="embossed") { if (add_text=="yes") { drawNames(); } }


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the *STAND*
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawStand(n) {
	linear_extrude(n*space_per_slot) {
		// top
		hull() {
			translate([0,height-2,0]) circle(5);
			translate([top_width,height,0]) circle(3);
		}	
		// mid
		hull() {
			translate([0,7,0]) circle(7);
			translate([0,height-2,0]) circle(5);
		}
		// lower
		hull() {
			translate([0,7,0]) circle(7);
			translate([base_width,3,0]) circle(3);
		}
		
		// upper rounded inner corner
		//    (@35mm: x=-10.88 / @50: x=-11.21 / 15 & 0.33 diff)
		hi_fudge = ((top_width-35)/15)*0.33;
		rotate([0,0,90]) 
		translate([height-10.88-hi_fudge, -10.05, 0]) // Fudges
		difference() {
			square(5);
			circle(5);
		}
		
		// lower rounded inner corner 
		//    (@50mm: y=-18.88 / @75: y=-19.55 / 25 & 0.67 diff)
		low_fudge = ((base_width-50)/25)*0.67;
		rotate([0,0,180]) 
		translate([-13.65, -18.88-low_fudge, 0]) // Fudges
		difference() {
			square(7);
			circle(7);
		}

	}
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the toothbrush *HOLES*
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawHoles(n) {
	for (i=[1:n]) {
		rotate([90,0,0]) 
		translate([top_width/2+5,space_per_slot*i-space_per_slot/2,-height-5]) 
		cylinder(height,top_radius,bottom_radius);
	}
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the slot *NAMES*
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawNames() {
	for (i=[0:len(names)-1]) {
		rotate([90,90,91.5]) 
		translate([space_per_slot*i-space_per_slot*number_of_toothbrushes+space_per_slot/2, height-text_top_margin, 6]) 
		linear_extrude(4) 
		text(names[i], 
			size=text_size, 
			spacing=text_spacing, 
			font=text_font, 
			direction="ttb");
	}
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Helpers to parse a delimited string
//   	H/T to the code heroes here:
//		https://www.thingiverse.com/groups/openscad/topic:10294
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
function substr(s, st, en, p="") =
    (st >= en || st >= len(s))
        ? p
        : substr(s, st+1, en, str(p, s[st]));

function split(h, s, p=[]) =
    let(x = search(h, s)) 
    x == []
        ? concat(p, s)
        : let(i=x[0], l=substr(s, 0, i), r=substr(s, i+1, len(s)))
                split(h, r, concat(p, l));