// Advanced Customizable Word Pen

use <MCAD/fonts.scad>

wordpen(mode=object);

/* [Word] */

// choose which part of the pen to render
object=1;//[1:All,2:Pen Only,3:Cap Only]

// the word to display on the pen
word = "Pentastic";

// generate single layer helper-tabs
helper_tabs=1;//[0:Disable,1:Enable]

/* [Cartridge] */

// the diameter of hole for the ball point tip
tip_diameter = 2.4;

// the diameter of the pen ink inner tube
inner_diameter = 3.4;

// the length of the entire pen inner (minus the ball point tip protrusion)
inner_length = 140;

/* [Body] */

// overall thickness of the pen
pen_thickness = 7;

// the lenfth of the lid
lid_length = 30;

// the gap between the pen body and pen lid
tolerance=0.2;

// the relative size of the font
font_scale = 2.1;

// the relative space between letters
font_spacing = 0.81;

/* [Hidden] */ //////////////////////////////////////////////////////////////////

top_offset=1.2*1;
font_height = pen_thickness + 1.5;
the_font = 8bit_polyfont();
x_shift = the_font[0][0] * font_spacing;
y_shift = the_font[0][1];
the_indicies = search(word,the_font[2],1,1);
word_size = len(the_indicies);
word_offset =  word_size < 8 ? (8 - word_size) / 2 : 0;
word_length = (word_size+2)*x_shift*font_scale;
pen_length = word_length > inner_length ? word_length : inner_length;
tip_radius = tip_diameter/2;
inner_radius = inner_diameter/2;
inner_thickness = pen_thickness-2.5;
lid_thickness = pen_thickness+3.2;
lid_hole = pen_thickness+tolerance*2;

module testpen() {
difference() {
wordpen();
translate([0,0,pen_thickness]) cube([300,30,pen_thickness], center=true);
}}

module wordpen(mode=1) {
	translate([-(pen_length - 30)/2,0,0]) difference() {
		union() {
			if(mode!=3) {
				translate([0,0,pen_thickness/2]) {
					pen();
					// Create the Text
					scale([font_scale,font_scale,1]) {
					for( j=[0:(word_size-1)] )
						translate([(j+top_offset+word_offset)*x_shift, -y_shift/2, -pen_thickness/2]) {
							linear_extrude(height=font_height)
								polygon(points=the_font[2][the_indicies[j]][6][0], paths=the_font[2][the_indicies[j]][6][1]);
						}
					}
					// End Pen
				}
				if(helper_tabs) {
					// Helper discs
					translate([pen_length, 0, 0]) cylinder(h=0.15, r=10);
					translate([0, -0.25, 0]) cube([5, 0.5, pen_thickness/2]);
				}
			}
			if(mode!=2) {
				lid();
			}
			if(helper_tabs) {
				translate([2, 0, 0]) cylinder(h=0.15, r=10);
			}
		}
		if(mode!=3) translate([0,0,pen_thickness/2]) {
			// Pen cut outs
			translate([8,-inner_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=inner_length-15, r=inner_thickness/2, $fn=50);
			translate([8,-inner_thickness/4,-inner_thickness/2]) cube([inner_length-15, inner_thickness/2, inner_thickness]);
			translate([8, inner_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=inner_length-15, r=inner_thickness/2, $fn=50);
			translate([-5, 0, 0]) rotate(a=[0, 90, 0]) cylinder(h=15, r=tip_radius, $fn=50);
			translate([3, 0, 0]) rotate(a=[0, 90, 0]) cylinder(h=inner_length-3, r=inner_radius, $fn=50);
               // tail
               if(pen_length > inner_length) {
			  translate([inner_length + 4,-inner_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=pen_length-inner_length-5, r=inner_thickness/2, $fn=50);
			  translate([inner_length + 4,-inner_thickness/4,-inner_thickness/2]) cube([pen_length-inner_length-5, inner_thickness/2, inner_thickness]);
			  translate([inner_length + 4, inner_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=pen_length-inner_length-5, r=inner_thickness/2, $fn=50);
               }
		}
	}
}

module pen() render() {
// Pen Tip
translate([0,-pen_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=5, r1=0, r2=pen_thickness/2, $fn=50);
if(tip_radius+0.5 < pen_thickness/3.5) {
	rotate(a=[0, 90, 0]) cylinder(h=5, r1=pen_thickness/3.5, r2 =pen_thickness/2, $fn=50);
}
else {
	rotate(a=[0, 90, 0]) cylinder(h=5, r1=tip_radius+0.5, r2 =pen_thickness/2, $fn=50);
}
translate([0, pen_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=5, r1=0, r2=pen_thickness/2, $fn=50);
// Main body
translate([5,-pen_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=pen_length-3, r=pen_thickness/2, $fn=50);
translate([5,-pen_thickness/4,-pen_thickness/2]) cube([pen_length-3, pen_thickness/2, pen_thickness]);
translate([5, pen_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=pen_length-3, r=pen_thickness/2, $fn=50);
}

module lid() translate([0,0,lid_thickness/2]) difference() {
union(){
	// Lid
	translate([-lid_length-5,-lid_thickness/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=lid_length, r=lid_thickness/2, $fn=50);
	translate([-lid_length-5,-lid_thickness/4,-lid_thickness/2]) cube([lid_length, lid_thickness/2, lid_thickness]);
	translate([-lid_length-5,lid_thickness/4],0) rotate(a=[0, 90, 0]) cylinder(h=lid_length, r=lid_thickness/2, $fn=50);
	translate([-lid_length-5,0,-lid_thickness/2]) cube([3, (lid_thickness*3/4)+1.5, lid_thickness]);
	translate([-lid_length-5,(lid_thickness*3/4)+1.5,-lid_thickness/2]) cube([lid_length, 2, lid_thickness]);
	translate([-7,(lid_thickness*3/4)+0.1,-lid_thickness/2]) rotate(a=[0, 0, 45]) cube([2, 2, lid_thickness]);
}
union(){
	// Lid cut outs
	translate([-lid_length-2,-lid_hole/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=lid_length, r=lid_hole/2, $fn=50);
	translate([-lid_length-2,-lid_hole/4,-lid_hole/2]) cube([lid_length, lid_hole/2, lid_hole]);
	translate([-lid_length-2, lid_hole/4, 0]) rotate(a=[0, 90, 0]) cylinder(h=lid_length, r=lid_hole/2, $fn=50);
}}
