//
// manfrotto 484rc2 quick plate replacement, with variable width
//
// Copyright 2013-2014 Sébastien Roy (roys@iro.umontreal.ca)
// Licence: public domain
// 

/* [General] */

// Extra width on one side
extra_left=120; // [0:150] 

// Extra width on the other side
extra_right=80; // [0:150]

/* [Left Hole] */

left_hole_style="standard"; // [standard,3/8 tap, 1/4 tap,prosilica,custom,none]
// (used if style is "custom")
left_hole_diameter=20;
left_hole_x_offset=0;
left_hole_y_offset=0;

/* [Middle Hole] */

middle_hole_style="standard"; // [standard,3/8 tap,1/4 tap,prosilica,customm,none]
// (used if style is "custom")
middle_hole_diameter=20;
middle_hole_x_offset=0;
middle_hole_y_offset=0;

/* [Right Hole] */

right_hole_style="standard"; // [standard,3/8 tap,1/4 tap,prosilica,custom,none]
// (used if style is "custom")
right_hole_diameter=20;
right_hole_x_offset=0;
right_hole_y_offset=0;




// to stop customizer
module nop() { }

length = 2; //[1:32]
width = 2; //[1:32]
type = 9.6; //[9.6:Brick, 3.2:Tile, 19.2:Double Brick]
flat = 0; //[0:No, 1.9:Yes]
/* [Hidden] */

//
// General dimensions of the plate
//
// "largeur" determines how well the plate will attach to the head.
// "profondeur" is the width of the plate. 
//
largeur=42.6;
largeurtop=37.5;
profondeur=52.3;
hauteur=9.8;


//
// un solide "tappered" en x,
// de dimension largeur x prodondeur x hauteur
//
module tappered(largeur=30,largeurtop=20,profondeur=40,hauteur=10,head=2,base=3) {
      off=(largeur-largeurtop)/2;
	translate([0,profondeur,0])
	rotate([90,0,0])
	linear_extrude(height=profondeur)
		polygon(points=[
			[0,0],
			[largeur,0],
			[largeur,base],
			[largeurtop+off,hauteur-head],
			[largeurtop+off,hauteur],
			[off,hauteur],
			[off,hauteur-head],
			[0,base]
		]);
}

//
// solid plate
//
module m_base(extra1=0,extra2=0) {
	translate([0,-extra2,0]) tappered(largeur,largeurtop,profondeur+extra1+extra2,hauteur);
}


//
// inside material to remove from plate
//
module m_interieur(extra1=0,extra2=0) {
	translate([4,3,-1]) tappered(largeur-8,largeurtop-6,profondeur-6,hauteur-3,0,0);
	translate([4,profondeur,-1]) tappered(largeur-8,largeurtop-6,extra1-3,hauteur-3,0,0);
	translate([4,0*profondeur-extra2+3,-1]) tappered(largeur-8,largeurtop-6,extra2-3,hauteur-3,0,0);
}

//
// side material to be removed from the plate
//
module m_notch(extra1=0) {
	w=3;
	translate([-5,-5,-4]) cube([largeur-17.6+5,10+extra1,hauteur]);
}

//
// one hole in the plate. r is the radius,
// pos is the (x,y) position on the plate (leave z at 0).
// the (0,0) position is the center of the plate.
//
module m_trou(r=5,pos=[0,0,0]) {
	translate([largeur/2,profondeur/2,0]+pos) cylinder(h=hauteur*2,r=r,$fn=64);
}

module m_trou_counter(r=5,rr=16/2,hh=1,pos=[0,0,0]) {
	translate([largeur/2,profondeur/2,0]+pos) cylinder(h=hauteur*2,r=r,$fn=64);
	translate([largeur/2,profondeur/2,0]+pos) cylinder(h=hauteur-4+hh,r=rr,$fn=64);
}



module m_holes(style="standard",offset=[0,0,0],dia) {
	if( style=="standard" ) {
		m_trou_counter(10/2,16/2,1,offset);
	} else if( style=="3/8 tap" ) {
		m_trou(5/16*25.4/2,offset);
	} else if( style=="1/4 tap" ) {
		m_trou(13/64*25.4/2,offset);
	} else if( style=="prosilica" ) {
		m_trou(1.7,[-9,-13,0]+offset);
		m_trou(1.7,[-9,13,0]+offset);
	} else if( style=="custom" ) {
		m_trou(dia/2,offset);
	}
}

//
// position the following model to make it printable
// this is set for up=z-axis printing (ex: mendelmax)
// Change it for your printer...
//
module m_printable() {
	translate([-largeur/2,profondeur/2,hauteur])
	rotate([180,0,0])
	child(0);
};


//
// Basic complete plate, without holes
//
module m_manfrotto484() {
	difference() {
		m_base(extra_left,extra_right);
		m_interieur(extra_left,extra_right);
		m_notch(0);
		translate([0,profondeur,0]) m_notch(0/*extraprof*/);
/*
		if( extra_left>20 ) {		
			m_trou(r=5,pos=[0,extra_left,0]);
		}
		if( extra_right>20 ) {		
			m_trou(r=5,pos=[0,-extra_right,0]);
		}
*/
	}
}

//
// example of a plate with 4 holes.
// Change as needed.
//
module m_manfrotto484_generic() {
	difference() {
		m_manfrotto484();
		m_holes(middle_hole_style,[middle_hole_x_offset,middle_hole_y_offset,0],middle_hole_diameter);
		if( extra_left>20 ) m_holes(left_hole_style,[left_hole_x_offset,left_hole_y_offset+extra_left,0],left_hole_diameter);
		if( extra_right>20 ) m_holes(right_hole_style,[right_hole_x_offset,right_hole_y_offset-extra_right,0],right_hole_diameter);
		//m_trou(2.5,[10,0,0]);
		//m_trou(2.5,[0,15,0]);
		//m_trou(2.5,[0,-15,0]);
	}
}

//
// plate made for Allied/Prosilica GC650 (and similar cameras)
// the holes separation is 26mm.
//
module m_manfrotto484_prosilica() {
	difference() {
		m_manfrotto484();
		m_trou(1.7,[-9,-13,0]);
		m_trou(1.7,[-9,13,0]);
	}
}


m_printable()  m_manfrotto484_generic();





