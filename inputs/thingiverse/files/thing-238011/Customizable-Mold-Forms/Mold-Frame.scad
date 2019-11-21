/* [Global] */
// Which component would you like to see?
part = "all"; // [all:All parts,both:Both frame halves,left:Left half of frame,right:Right half of frame,base:Pattern base,sprue:Pattern base with sprue] 

/* [Mold Dimensions] */
// Mold width (mm)
width = 75; // [50:150]
// Mold height (mm)
height = 75; // [50:150]
// Mold thickness (mm)
thickness = 20; // [10:50]
// Frame wall thickness (mm)
wall = 5; // [5:25]

/* [Base and Sprue] */
// Base thickness (mm)
base = 2; // [0:10]
// Funnel opening diameter (mm)
funnel = 20; // [10:30]
// Funnel angle
angle = 60; // [45,60,75]
// Total sprue length (mm)
sprue_length = 20; // [15:100]
// Sprue neck thickness (mm)
neck_thickness = 3; // [1:10]

/* [Labels] */
// Include mold label?
mold_labels = 1; // [1:Yes,0:No]
// Include frame labels?
frame_labels = 1; // [1:Yes,0:No]

/* [Hidden] */
use<write/Write.scad>
$fn = 36;

render() {

	if ( part == "all" ) {
		translate ( [-10,-10,0] )
			left ( width, height, thickness+base, wall );
		translate ( [10,10,0] )
			right ( width, height, thickness+base, wall );
		union() {
			base ( width, height, base );
			translate ( [0,0,base] )
				sprue ( height, funnel, angle, sprue_length, neck_thickness );
		};
	} else if ( part == "both" ) {
		translate ( [-10,-10,0] )
			left ( width, height, thickness+base, wall );
		translate ( [10,10,0] )
			right ( width, height, thickness+base, wall );
	} else if ( part == "left" ) {
		left ( width, height, thickness+base, wall );
	} else if ( part == "right" ) {
		right ( width, height, thickness+base, wall );
	} else if ( part == "base" ) {
		base ( width, height, base );
	} else if ( part == "sprue" ) {
		union() {
			base ( width, height, base );
			translate ( [0,0,base] )
				sprue ( height, funnel, angle, sprue_length, neck_thickness );
		};
	};
};


module left ( width, height, thickness, wall ) {

	letter_height = 5;

	translate ( [0,0,thickness/2] )
		union() {
			difference() {
				cube( size = [width+2*wall,height+2*wall,thickness], center = true );
				translate( [wall,wall,0] )
					cube( size = [width+2*wall,height+2*wall,thickness], center = true );
				translate( [-(width+wall)/2,(height+wall)/2,-thickness/4] )
			 		cube( size = [wall,wall,thickness/2], center = true );
				translate( [(width+wall)/2,-(height+wall)/2,thickness/4] )
					cube( size = [wall,wall,thickness/2], center = true );
				if ( frame_labels ) {
					writecube( "left",where=[0,0,0],size=(width+2*wall),face="left",t=1,h=letter_height );
					writecube( str(width," x ",height," mm"),where=[0,0,0],size=(height+2*wall),face="front",t=1,h=letter_height );
				};
			};
			if ( mold_labels ) {
				writecube( str(width," x ",height," mm"),where=[0,0,0],size=height,face="front",t=1,h=letter_height );
			};
		};
};


module right ( width, height, thickness, wall ) {

	letter_height = 5;

	translate ( [0,0,thickness/2] )
		union() {
			difference() {
				cube( size = [width+2*wall,height+2*wall,thickness], center = true );								translate( [-wall,-wall,0] )
					cube( size = [width+2*wall,height+2*wall,thickness], center = true );
				translate( [(width+wall)/2,-(height+wall)/2,-thickness/4] )
			 		cube( size = [wall,wall,thickness/2], center = true );
				translate( [-(width+wall)/2,(height+wall)/2,thickness/4] )
					cube( size = [wall,wall,thickness/2], center = true );
				if ( frame_labels ) {
					writecube( "right",where=[0,0,0],size=(width+2*wall),face="right",t=1,h=letter_height );
					writecube( str(width," x ",height," mm"),where=[0,0,0],size=(height+2*wall),face="back",t=1,h=letter_height );
				};
			};
		};
};


module base ( width, height, base ) {

	letter_height = 5;

	translate( [0,0,base/2] )
		difference() {
			cube( size = [width, height, base], center = true );
			if ( frame_labels ) {
				writecube( str(width," x ",height," mm"),where=[0,0,0],face="bottom",rotate=180,size=base,t=1,h=letter_height );
			};
		};
};


module sprue ( height, funnel, angle, sprue_length, sprue_thickness ) {

	funnel_height = (funnel/2-sprue_thickness/2)*tan(angle);
	neck_length = sprue_length-funnel_height;

	difference() {
		union() {
			translate( [0, height/2 - funnel_height/2,0] )
				rotate( [-90,0,0] )
					cylinder( r1 = sprue_thickness/2, r2 = funnel/2, h = funnel_height, center = true );
			translate( [ 0, (height/2 - funnel_height - neck_length/2), 0 ] )
				rotate( [-90,0,0] )
					cylinder( r = sprue_thickness/2, h = neck_length, center = true );
		};
		translate( [0,0,-funnel/2] )
			cube( size = [width,height+1,funnel], center = true );
	};
};


