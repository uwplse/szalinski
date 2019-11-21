// Customizable clip for identifying filaments
// V1.0 - 2019/04/01
//
// Original by timfou - Mitch Fournier
// Modified by Carsten Stokholm

// Number of clips to print (Default: 1)
number = 1;
// Text to show on the clips (Separate each with a semicolon)
clip_text = "Pirate Black";
// Filament type on the back
clip_filament_text = "PLA";  //PLA,ABS,PVA....
// Size of filament text 
clip_filament_text_size = 4;
// Clip length (Default: 80mm)
clip_length = 80; 
// Clip width (Default: 15mm)
clip_width = 15; // [4:1:20]
// Clip material thickness (Default: 2mm)
clip_thickness = 2; // [2:0.5:10]
// Distance between clip arms (Default: 3.5mm)
clip_opening = 3.5; // [1:0.5:14]
// Text extruded height (Default: 1mm)
text_extrusion = 1; // [0.5:0.5:4]
// Font to use, Font, available: fonts.google.com (Default: "Arial")
text_font = "Arial";
// Text font size (Default: 6mm)
text_size = 6; // [1:1:15]
// Size of the text character on the back side (Default: 11mm)
text_size_back = 8; // [1:1:35]
// Spacing between letters (Default: 1.0)
text_spacing = 1.0; // [0:0.1:3]
// Text bubble border width (Default: 1mm)
text_bubble_width = 1; // [0:0.5:4]
// Interior protrusion height of the short arm nubs (Default: 0.5mm)
nub_height_l = 0.75; // [0:0.5:3]
// Number of short arm nubs (Default: 3)
number_of_nubs_l = 3; // [0:1:5]
// Interior protrusion height of the long arm nubs (Default: 0.5mm)
nub_height_r = 0.75; // [0:0.5:3]
// Number of long arm nubs (Default: 2)
number_of_nubs_r = 2; // [0:1:5]
// Offset the nubs? (Default: 1.5mm)
nub_offset = 1.5; // [1.5, 0]
// Arc segments (Default: 32, but 4 and 6 are nice)
fn = 32; // [4:2:32]
$fn = fn;

total_clip_thickness = 2*clip_thickness + clip_opening + text_extrusion;
names = split(":", clip_text);

// ==========================
//  Draw the clip
// ==========================
for (i =[0:1:number-1]) {
	translate([(total_clip_thickness+3)*i,10*i,0]) {
		linear_extrude(clip_width) {
			drawClip(clip_thickness, clip_length, clip_opening);
			drawCorner(clip_thickness+1, clip_length-clip_thickness-1, 0, 90);
			drawCorner(clip_thickness+clip_opening-1, clip_length-clip_thickness-1, 0, 0);
			drawNubs(clip_thickness, clip_length, clip_width, nub_height_l, number_of_nubs_l, nub_height_r, number_of_nubs_r);
		}
		drawText(i,clip_thickness, clip_length, clip_opening, clip_width);
	}
}

// Debug size check
//%translate([clip_thickness,0,clip_width+1]) square([clip_opening,clip_length]);


// --------------------------
//  Draw the clip shape
// --------------------------
module drawClip (T,L,O) {
    // Short arm
    hull() {
        translate([0.5*T, L-0.5*T, 0]) circle(0.5*T);
        translate([0.5*T, 0.5*L,   0]) circle(0.5*T);
    }
    // Header
    hull() {
        translate([0.5*T,   L-0.5*T, 0]) circle(0.5*T);
        translate([1.5*T+O, L-0.5*T, 0]) circle(0.5*T);
    }
    // Long arm
    hull() {
        translate([1.5*T+O, L-0.5*T, 0]) circle(0.5*T);
        translate([1.5*T+O, 0.5*T,   0]) circle(0.5*T);
    }
}

// --------------------------
//  Draw the inner corners
// --------------------------
module drawCorner(X,Y,Z,A) {
    translate([X,Y,Z]) 
    rotate([0,0,A]) 
    difference() {
        square(1);
        circle(1);
    }
}

// --------------------------
//  Draw the clip nubs
// --------------------------
module drawNubs(T,L,W,Hl,Nl,Hr,Nr) {
    // L: short arm nubs
    for (i =[1:1:Nl])
        hull() {
            translate([T-1, 0.5*L+i*3-1, 0]) circle(1);
            translate([T+Hl-0.5, 0.5*L+i*3-1, 0]) circle(0.5);
        }
        
    // R: long arm nubs
    for (i =[1:1:Nr])
        hull() {
            translate([T+clip_opening-Hr+0.5, 0.5*L+i*3-1+nub_offset, 0]) circle(0.5);
            translate([T+clip_opening+1, 0.5*L+i*3-1+nub_offset, 0]) circle(1);
        }
}

// --------------------------
//  Draw the clip text
// --------------------------
module drawText(i,T,L,O,W) {
	// The main text outline bubble
	color("white") 
    translate([T*2+O, T/2+2, W/2]) 
    rotate([90,0,90]) 
    linear_extrude(0.5*text_extrusion) 
    minkowski() {
        text(names[i], 
			size=text_size, 
			font=text_font, 
			spacing=text_spacing,
			halign="left", 
			valign="center");
        circle(text_bubble_width/2);
    }

	// The main text
    translate([T*2+O, T/2+2, W/2]) 
    rotate([90,0,90]) 
    linear_extrude(text_extrusion) 
    text(names[i], 
		size=text_size, 
		font=text_font,
		spacing=text_spacing,	
		halign="left", 
		valign="center");

	// Filament text
    translate([T*2+3, L-7, W/2]) 
    rotate([90,90 ,90]) 
    linear_extrude(text_extrusion) 
    text(clip_filament_text, 
		size=clip_filament_text_size, 
		font=text_font,
		spacing=text_spacing,	
		halign="center", 
		valign="left");






	// The backside outline bubble
	color("white") 
    translate([0, L-10, W/2]) 
    rotate([90,0,-90]) 
    linear_extrude(0.5*text_extrusion) 
        minkowski() {
        text(clip_filament_text, 
			size=text_size_back, 
			font=text_font, 
			spacing=text_spacing,
			halign="left", 
			valign="center");
        circle(text_bubble_width/2);
    }	
	// The backside initial
	translate([0, L-10, W/2]) 
     rotate([90,0,-90]) 
    linear_extrude(text_extrusion) 
    text(clip_filament_text, 
    	size=text_size_back, 
		font=text_font,
		spacing=text_spacing,	
		halign="left", 
		valign="center");
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