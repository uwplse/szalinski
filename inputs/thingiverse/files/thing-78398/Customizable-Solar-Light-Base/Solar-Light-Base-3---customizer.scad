// A Base for Solar Lights.
// By Ari M. Diacou
// http://www.thingiverse.com/thing:78398
// A 6"x1/4" landscaping nail gets hammered through the middle, and the light slides on top
// Default values are for a stand tube with an internal diameter of 7/8" for a set of Solar Lights sold by Costco


//Diameter of the male part
D=21;	
	
//Height of the male part, most pieces are around D=H 
H=21; 		

//Height of the base in mm
H2 = 2; 			

//Diameter of the base in mm
D2 = 36; 			

//How much the ribs/male part come past the given diameter D
tolerance = 0.2;	

//How far the ribs come out from the first diameter
delta=0.5;		

//Bore diameter 1/4"=6.35 mm for landscaping stake
B=6.3; 			

Resolution = 60; //internal variable for resolution of rendering
$fn=Resolution; 

number_of_ribs = 6;

rib_thickness = 3;

difference(){ 	//remove the bore from...
	union() {		//add the male part, base and ribs
		translate([0,0,H2]) cylinder(h=H, r=(D+tolerance-delta)/2);		//male part
		cylinder(h=H2, r=D2/2);													//base
		ribs(number_of_ribs);														//ribs, defined below
		}
	cylinder(h=H+H2, r=B/2); 													//the bore
	}

module ribs(n){ //creates n ribs spaced axially around the bore, extending tolerance beyond D/2
	R=D/2+tolerance;
	thickness = rib_thickness;
	if (n > 0){	//if you dont put this in, and call ribs(0), shit crashes
		for ( i = [0 : 5] ){
    			rotate( i * 360 / n, [0, 0, 1])
    			translate([-R, -thickness/2, H2]) 
			cube([R, thickness, H]);
			}
	}
}




			