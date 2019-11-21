// ************* Credits part *************

// "Nametag" Programmed by Myoilu - August 2016

// Optimized for Customizer with 4 lines of names only - for more lines please refer to original below

// Based on "Simple Name Sign"Programmed by Fryns - March 2014 (thing:273099)

// Based on "Any Name Sign" by Fryns, published	on Thingiverse 11-Mar-2014 (thing:269405)

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 

// ************* Declaration part *************

// preview[view:south, tilt:top]

/* [Names] */
font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]

name1="Put your name here";
name2="...or not";
name3="I'm a sign";
name4="not a cop";

//Height of each line above center of base
yname1=13;
yname2 =4;
yname3=-5;
yname4 =-14;

letter_size=6;

letter_depth=2;


/* [Hidden] */
// Width of base
basex=125;			// Width of base
// Height of base
basey=40;			// Height of base
// Thickness of base
base_depth=5.55;

// ************* Executable part *************
use <write/Write.scad>	// remember to download write.scad and fonts

assembly();


// ************* Module part *************

module assembly() {
	color("black") writing();
    base();
}

module writing(){
	translate([0,yname1,base_depth+letter_depth/2])
		write(name1,t=letter_depth,h=letter_size,center=true,font=font);
	translate([0,yname2,base_depth+letter_depth/2])
		write(name2,t=letter_depth,h=letter_size,center=true,font=font);
	translate([0,yname3,base_depth+letter_depth/2])
		write(name3,t=letter_depth,h=letter_size,center=true,font=font);
	translate([0,yname4,base_depth+letter_depth/2])
		write(name4,t=letter_depth,h=letter_size,center=true,font=font);
    }

module base(){
	translate([0,0,base_depth/2])
		cube(size = [basex,basey,base_depth], center = true);
}