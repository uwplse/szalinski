include <write/Write.scad>

/**
 * A name tag that can easily be clipped to the neck of your bottle.
 * Copyright (C) 2013 Roland Hieber <rohieb+bottleclip@rohieb.name>
 *
 * This file was modified by obelix <christian@loelkes.com> for the
 * OHM2013-Logo. If you wish to use other logos please use the original
 * file. All other parameters were not modified.
 *
 * Version of the modification: 1.0
 *
 * See examples.scad for examples on how to use this module.
 *
 * The contents of this file are licenced under CC-BY-SA 3.0 Unported.
 * See https://creativecommons.org/licenses/by-sa/3.0/deed for the
 * licensing terms.
 */

/**
 * Creates one instance of a bottle clip name tag. The default values are
 * suitable for 0.5l Club Mate bottles (and similar bottles). By default, logo
 * and text are placed on the name tag so they both share half the height. In this
 * version the logo is fixed.
 *
 * Parameters:
 * ru: the radius on the upper side of the clip
 * rl: the radius on the lower side of the clip
 * ht: the height of the clip
 * width: the thickness of the wall. Values near 2.5 usually result in a good
 *	clippiness for PLA prints.
 * name: the name that is printed on your name tag. For the default ru/rt/ht
 *	values, this string should not exceed 18 characters to fit on the name tag.
 * font: the path to a font for Write.scad.
 */

/* [Global] */

// Name on the first tag
name1 = "Foo"; // Name

// Name on the second tag
name2 = ""; // Name

// Size first tag
type1 = "mate"; // [mate:Club-Mate,longneck:Longneck]

// Size second tag
type2 = "mate"; // [mate:Club-Mate,longneck:Longneck]

// Font
font = 3; // [1:Letters,2:BlackRose,3:Orbitron,4:Knewave,5:Braille]


/* [Hidden] */

$fn = 100;
if(font == 1) { generate("write/Letters.dxf");}
if(font == 2) { generate("write/BlackRose.dxf");}
if(font == 3) { generate("write/orbitron.dxf");}
if(font == 4) { generate("write/knewave.dxf");}
if(font == 5) { generate("write/braille.dxf");}


module generate(font) {
	if( name1 != "") {
		if(type1 == "mate") { 
			echo("Creating normal mate tag with nick: ", name1);
			bottle_clip(13,17.5,26,2.5,name1,font); 
		}
		if(type1 == "longneck") { 
			bottle_clip(13,15,26,2.5,name1, font); 
			echo("Creating longneck tag with nick: ", name1);
	
		}
	}
	if( name2 != "") {
		if(type2 == "mate") { 
			rotate([0,0,180])translate([-15,0,0])bottle_clip(13,17.5,26,2.5,name2,font); 
			echo("Creating normal mate tag with nick: ", name2);
		}
		if(type2 == "longneck") { 
			rotate([0,0,180])translate([-15,0,0])bottle_clip(13,15,26,2.5,name2, font); 
			echo("Creating longneck tag with nick: ", name2);
		}
	}
}

module bottle_clip(ru=13, rl=17.5, ht=26, width=2.5, name=name1, font="write/orbitron.dxf") {

	e=100;  // should be big enough, used for the outer boundary of the text/logo
	r_diff = rl-ru;
	text_pos = 18;
	
	difference() {
		rotate([0,0,-45]) 
			union() {
				cylinder(r1=rl+width, r2=ru+width, h=ht);
				writecylinder(name, [0,0,0], rl+0.5, ht/13*7, h=ht/13*4, t=max(rl,ru), font=font);
				translate([0,0,text_pos])
					rotate([0,-90,90])
						31C3_mate(10,0.6,1.5+ru+text_pos*(r_diff)/ht,7,asin(r_diff/ht)); 
			}
		// inner cylinder which is substracted
		translate([0,0,-1])
			cylinder(r1=rl, r2=ru, h=ht+2);
		// outer cylinder which is substracted, so the text and the logo end
		// somewhere on the outside ;-)
		difference () {
			cylinder(r1=rl+e, r2=ru+e, h=ht);
			translate([0,0,-1])
				// Note: bottom edges of characters are hard to print when character
				// depth is > 0.7
				cylinder(r1=rl+width+0.7, r2=ru+width+0.7, h=ht+2);
		}
		// finally, substract a cube as a gap so we can clip it to the bottle
		translate([0,0,-1]) cube([50,50,50]);
	}
}

/**
 * Creates one instance of a bottle clip name tag suitable for 0.33l longneck
 * bottles (like fritz cola, etc.). All parameters are passed to the module
 * bottle_clip(), see there for their documentation.
 */
//module bottle_clip_longneck(name="", width=2.5, font="write/orbitron.dxf") {
//	bottle_clip(name=name, ru=13, rl=15, ht=26, width=width, font=font);
//}

/**
 * The Steinie-Tag has been removed since it does not support logos.
**/

// Generate the 31C3 Logo

rad=20;
thick = 2;

//31C3_cylinder(100,5,200,50);

module 31C3_mate(height, wall, rad, extrude=2, incl=10) {
	length = (height+wall) * 2.4 ;

	angle = asin(0.5*(height+wall)/rad);
	//echo(angle);

	translate([0,0,0])rotate([0,0,0]) {
		rotate([-angle*2.4,0,0])translate([0,0,rad-extrude/2])rotate([0,incl,0])31C3_3(height, wall, extrude);
		rotate([-angle,0,0])translate([0,0,rad-extrude/2])rotate([0,incl,0])31C3_1(height, wall, extrude);
		rotate([angle*0.4,0,0])translate([0,0,rad-extrude/2])rotate([0,incl,0])31C3_C(height, wall, extrude);
		rotate([angle*2.4,0,0])translate([0,0,rad-extrude/2])rotate([0,incl,0])31C3_3(height, wall, extrude);
	}
}

module 31C3(height, wall, extrude=2) {
	translate([0,(height+wall)*2.4,0])31C3_3(height, wall, extrude);
	translate([0,(height+wall)*1.7,0])31C3_1(height, wall, extrude);
	translate([0,height+wall,0])31C3_C(height, wall, extrude);
	31C3_3(height, wall, extrude);
}

module 31C3_logo (size, wall, extrude) {
	open_ring(size,wall*2,size*0.75, extrude);
	translate([-wall,wall*2,0])cube([wall*2,size*1.2,extrude]);
}

module 31C3_3(height, wall, extrude) {
	open_ring(height/2,wall*2,height*0.5*0.75, extrude);
	translate([-wall,-height/4,0])cube([wall*2,height*0.75,extrude]);
}

module 31C3_1(height, wall, extrude) {
	rotate([0,0,90])translate([0,0,extrude/2])cube([wall*2,height,extrude], center=true);
}

module 31C3_C(height, wall, extrude) {
	rotate([0,0,180])open_ring(height/2,wall*2,height*0.5*0.75, extrude);
}

module open_ring(rad, wall, gap, extrude=2) {
	difference() {
		ring(rad,wall, extrude);
		translate([-gap/2,0,-1])cube([gap,rad+1,extrude+2]);
	}
}

module ring(rad, wall, extrude=2) {
	difference() {
		cylinder(r=rad,h=extrude);
		translate([0,0,-1])cylinder(r=rad-wall,h=extrude+2);
	}
}

/*
Size Mate 13 17.5
Size Longneck 13 15
Size Cola Cola 1L 15 25
*/
