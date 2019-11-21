/*
 * Examples for bottle clip name tags.
 * Copyright (C) 2013 Roland Hieber <rohieb+bottleclip@rohieb.name>
 *
 * Original: http://www.thingiverse.com/thing:38861
 * Adaptation inspired by http://www.thingiverse.com/thing:650387
 *
 * Adapted for thingiverse/Maker Bot customizer in 2015 by Jason Peper <trublu@c-peper.de>
 *
 * The contents of this file are licenced under CC-BY-SA 3.0 Unported.
 * See https://creativecommons.org/licenses/by-sa/3.0/deed for the
 * licensing terms.
 */

/* [Global] */

// Name on the first tag
name1 = "Jason"; // Name

// Size first tag
type1 = "steini"; // [mate:Club-Mate,longneck:Longneck,steini:steini]

name2 = "Jason";

type2 = "longneck"; // [mate:Club-Mate,longneck:Longneck,steini:steini]

// Logo
logo = "Club_mate_logo.dxf"; // [Club_mate_logo.dxf:Club Mate,stratum0-lowres:Stratum 0,Backspace_Icon.dxf:Backspace]

/* [Hidden] */

$fn = 100;

generate(logo);

module generate(logo) {
	if( name1 != "") {
		if(type1 == "mate") { 
			echo("Creating normal mate tag with nick: ", name1, logo);
			bottle_clip(name=name1,logo=logo); 
		}
		if(type1 == "longneck") { 
			bottle_clip_longneck(name=name1,logo=logo); 
			echo("Creating longneck tag with nick: ", name1);
		}
		if(type1 == "steini") { 
			bottle_clip_steinie(name=name1,logo=logo); 
			echo("Creating longneck tag with nick: ", name1);
		}
	}
	if( name2 != "") {
		if(type2 == "mate") { 
			rotate([0,0,180])translate([-15,0,0])bottle_clip(name=name2,logo=logo); 
			echo("Creating normal mate tag with nick: ", name2);
		}
		if(type2 == "longneck") { 
			rotate([0,0,180])translate([-15,0,0])bottle_clip_longneck(name=name2,logo=logo); 
			echo("Creating longneck tag with nick: ", name2);
		}
		if(type2 == "steini") { 
			rotate([0,0,180])translate([-15,0,0])bottle_clip_steinie(name=name2,logo=logo); 
			echo("Creating longneck tag with nick: ", name2);
		}
	}
}

//FROM <bottle-clip.scad>:
/**
 * A name tag that can easily be clipped to the neck of your bottle.
 * Copyright (C) 2013 Roland Hieber <rohieb+bottleclip@rohieb.name>
 *
 * See examples.scad for examples on how to use this module.
 *
 * The contents of this file are licenced under CC-BY-SA 3.0 Unported.
 * See https://creativecommons.org/licenses/by-sa/3.0/deed for the
 * licensing terms.
 */

include <write/Write.scad>

/**
 * Creates one instance of a bottle clip name tag. The default values are
 * suitable for 0.5l Club Mate bottles (and similar bottles). By default, logo
 * and text are placed on the name tag so they both share half the height. If
 * there is no logo, the text uses the total height instead.
 * Parameters:
 * ru: the radius on the upper side of the clip
 * rl: the radius on the lower side of the clip
 * ht: the height of the clip
 * width: the thickness of the wall. Values near 2.5 usually result in a good
 *	clippiness for PLA prints.
 * name: the name that is printed on your name tag. For the default ru/rt/ht
 *	values, this string should not exceed 18 characters to fit on the name tag.
 * logo: the path to a DXF file representing a logo that should be put above
 *	the name. Logo files should be no larger than 50 units in height and should
 *	be centered on the point (25,25). Also all units in the DXF file should be
 *	in mm. This parameter can be empty; in this case, the text uses the total
 *	height of the name tag.
 * font: the path to a font for Write.scad.
 */
module bottle_clip(ru=13, rl=17.5, ht=26, width=2.5, name="",
		logo="thing-logos/stratum0-lowres.dxf", font="write/orbitron.dxf") {

	e=100;  // should be big enough, used for the outer boundary of the text/logo

	difference() {
		rotate([0,0,-45]) union() {
			// main cylinder
			cylinder(r1=rl+width, r2=ru+width, h=ht);
			// text and logo
			if(logo == "") {
				writecylinder(name, [0,0,3], rl+0.5, ht/13*7, h=ht/13*8, t=max(rl,ru),
					font=font);
			} else {
				writecylinder(name, [0,0,0], rl+0.5, ht/13*7, h=ht/13*4, t=max(rl,ru),
					font=font);
				translate([0,0,ht*3/4-0.1])
					rotate([90,0,0])
					scale([ht/100,ht/100,1])
					translate([-25,-25,0.5])
					linear_extrude(height=max(ru,rl)*2)
					import(logo);
			}
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
module bottle_clip_longneck(name="", width=2.5,
		logo="thing-logos/stratum0-lowres.dxf", font="write/orbitron.dxf") {
	bottle_clip(name=name, ru=13, rl=15, ht=26, width=width, logo=logo,
		font=font);
}

/**
 * Creates one instance of a bottle clip name tag suitable for 0.33l DIN 6199
 * beer bottles (also known as "Steinie", "Stubbi", "Knolle", etc.). Because of
 * reasons, there is no logo, but all other parameters are passed to the module
 * bottle_clip(), see there for their documentation.
 */
module bottle_clip_steinie(name="", width=2.5, font="write/orbitron.dxf") {
	bottle_clip(name=name, ru=13, rl=17.5, ht=13, width=width, logo="",
		font=font);
}

