// ************* Credits part *************

// "Simple Name Sign"Programmed by Fryns - March 2014

// Optimized for Customizer with 4 lines of names only - for more lines please refer to original below

// Based on "Any Name Sign" by Fryns, published	on Thingiverse 11-Mar-2014 (thing:269405)

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 

// ************* Declaration part *************

// preview[view:south, tilt:top]

/* [Names] */
font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]

name1="Simple Name Sign";
name2="Optimized for Customizer";
name3="based on Any Name Sign";
name4="by Fryns";

//Height of name above center of base
yname1=15;
yname2 =5;
yname3=-5;
yname4 =-15;

letter_size=7 ;

letter_depth=1;


/* [Base] */
// Width of base
basex=150;			// Width of base
// Height of base
basey=60;			// Height of base
// Thickness of base
base_depth=2;

/* [Border] */
borderwidth=2;
// Radius of corner circle quarter 
borderradius=8;
// Distance from edge
borderdistance=5;	// Distance from edge

border_depth=1;

/* [Holes] */
//number of holes - choose 0,2 or 4
holes=4; 			// [0,2,4]
holediameter=3;
countersink=2;




// ************* Executable part *************
use <write/Write.scad>	// remember to download write.scad and fonts

assembly();


// ************* Module part *************

module assembly() {
	color("black") writing();
	color("black")	border();
	if (holes==2) base2holes();
	else {
		if (holes==4) base4holes();
		else base();
	}
}

module writing(){
	translate([0,yname1,base_depth+letter_depth/2])
		write(name1,t=letter_depth,h=letter_size,center=true,font=font);
	translate([0,yname2,base_depth+letter_depth/2])
		write(name2,t=letter_depth,h=letter_size,center=true,font=font);
	translate([0,yname3,base_depth+letter_depth/2])
		write(name3,t=letter_depth,h=letter_size,center=true,font=font);
	translate([0,yname4,base_depth+letter_depth/2])
		write(name4,t=letter_depth,h=letter_size,center=true,font=font);}

module base2holes() {
	difference(){
		base();
		translate([-(basex/2-borderdistance*2-borderwidth-countersink-holediameter),0,0])
			hole();
		translate([(basex/2-borderdistance*2-borderwidth-countersink-holediameter),(0),0])
			hole();
	}
}

module base4holes() {
	difference(){
		base();
		translate([(basex/2-borderdistance),(basey/2-borderdistance),0])
			hole();
		translate([(basex/2-borderdistance),-(basey/2-borderdistance),0])
			hole();
		translate([-(basex/2-borderdistance),(basey/2-borderdistance),0])
			hole();
		translate([-(basex/2-borderdistance),-(basey/2-borderdistance),0])
			hole();
	}
}

module base(){
	translate([0,0,base_depth/2])
		cube(size = [basex,basey,base_depth], center = true);
}

module border(){
	translate([0,0,base_depth+border_depth/2])
	linear_extrude(height = border_depth, center = true, convexity = 10, twist = 0){
		translate([0,basey/2-borderdistance,0])
			square ([basex-borderdistance*2-borderradius*2+borderwidth*2,borderwidth],center = true);
		translate([0,-(basey/2-borderdistance),0])
			square ([basex-borderdistance*2-borderradius*2+borderwidth*2,borderwidth],center = true);
		translate([basex/2-borderdistance,0,0])
			square ([borderwidth, basey-borderdistance*2-borderradius*2+borderwidth*2,],center = true);
		translate([-(basex/2-borderdistance),0,0])
			square ([borderwidth, basey-borderdistance*2-borderradius*2+borderwidth*2,],center = true);

		translate([-(basex/2-borderdistance),-(basey/2-borderdistance),0])
			rotate(a=[0,0,0])
				quarter();
		translate([(basex/2-borderdistance),(basey/2-borderdistance),0])
			rotate(a=[0,0,180])
				quarter();
		translate([(basex/2-borderdistance),-(basey/2-borderdistance),0])
			rotate(a=[0,0,90])
				quarter();
		translate([-(basex/2-borderdistance),(basey/2-borderdistance),0])
			rotate(a=[0,0,270])
				quarter();
	}
}

module quarter(){
	intersection() {
		difference(){
			circle(r = borderradius, center=true, $fn=50);
			circle(r = borderradius-borderwidth, center=true, $fn=50);
		}
		square ([borderradius+1, borderradius+1],center = false);
	}
}

module hole(){
	translate([0,0,base_depth/2])
		cylinder(h = base_depth+0.1, r = holediameter/2, $fn=50, center = true);
	translate([0,0,base_depth-countersink])
		cylinder(h = countersink+0.1, r1 = holediameter/2, r2 = (holediameter+2*countersink)/2, $fn=50, center = false);
}