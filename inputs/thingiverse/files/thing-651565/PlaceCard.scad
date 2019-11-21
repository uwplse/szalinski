// ************* Credits part *************

// Programmed by Fryns - January 2015

// Optimized for Customizer

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 


// ************* Declaration part *************

/* [Text] */
text="Guest Name";
font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]
font_size=8;
text_height=0.4;
text_x_offset=0;
text_y_offset=0;

/* [Size] */
Width = 75.0;
Height= 15.0;
// Total thickness without text 
Thickness = 1.6; // Total thickness without text 
// Layer thickness for fold
HingeLayer = 0.4; 
Angle=60;

/* [Band] */
// Band depth
BandRadius = 0.8; // Band depth
// Width at full depth
BandWidth = 1.0 ; // Width at full depth
// Band distance from end
BandDistance = 5; // Band distance from end 

/* [Hidden] */
Manifoldfix = 0.01;


// ************* Executable part *************
use <write/Write.scad>

Placecard();

module Placecard(){
difference(){
		Assembly();
		translate([-Width/2+BandDistance-BandWidth/2,0,Thickness])
			rotate([90,0,0])
				color("red") Band();

		translate([Width/2-BandDistance+BandWidth/2,0,Thickness])
			rotate([90,0,0])
				color("red") Band();
	}
}

module Assembly(){
 	Namelayer();
	translate([0,-1*Height,0])
		Monomer();
	translate([0,0*Height,0])
		Monomer();
	translate([0,1*Height,0])
		Monomer();
}

module Monomer(){
	translate([0,-Height/2,0])
		rotate([90,0,90])
			linear_extrude(height = Width, center = true, convexity = 10, twist = 0)
					polygon(points=[[0,Thickness],[Height,Thickness],[Height-Thickness*sin(Angle)/cos(Angle),0],[Thickness*sin(Angle)/cos(Angle),0]], paths=[[0,1,2,3]]);
}


module Namelayer(){
	translate([text_x_offset,text_y_offset,text_height/2+Thickness])
color("black") 		write(text,t=text_height,h=font_size,center=true,font=font);

	translate([-text_x_offset,-text_y_offset+Height,text_height/2+Thickness])
		rotate([0,0,180])
color("black") 		write(text,t=text_height,h=font_size,center=true,font=font);

	translate([0,0,Thickness-HingeLayer/2])
		cube(size = [Width,2*Height-Thickness,HingeLayer], center = true);

}

module Band(){
		translate([-BandWidth/2,0,0])
	linear_extrude(height = 3*Height, center = true, convexity = 10, twist = 0)
		hull() {
   		translate([BandWidth,0,0]) circle(BandRadius);
   			circle(BandRadius);
 		}
}
