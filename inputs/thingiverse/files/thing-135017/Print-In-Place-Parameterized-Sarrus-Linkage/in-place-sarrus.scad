//Print-in-place Modular Sarrus Linkage
//Created by Jon Hollander, 8/16/13

use <MCAD/regular_shapes.scad>

//User Parameters
linkage_length = 80;
linkage_width = 30;
linkage_height = 30;
link_thickness = 5;

number_of_linkage_arms = 2;//[2,4] 
hinge_spacing = 1;
hinge_length = 5.5;

n_x=floor(linkage_width/12);
n_y=floor(linkage_height/12);


//Draw Sarrus Linkage
sarrus_linkage();

module sarrus_linkage(){
	base_plate();
	side_plate_x1();
	side_plate_x2();
	top_plate();
	side_plate_y1();
	side_plate_y2();

	base_w = linkage_width-2*hinge_length;
	base_h=linkage_height-2*hinge_length;		

	if(number_of_linkage_arms == 4){
		mirror([1,0,0]){
			side_plate_x1();
			side_plate_x2();
		}
		mirror([0,1,0]){
			side_plate_y1();
			side_plate_y2();
		}
		
		translate([-base_w/2-hinge_length,0,0])
			hinge_pair(n_y);
		translate([0,-base_h/2-hinge_length,0]) rotate([0,0,90])
			hinge_pair(n_x);
	}
}

module base_plate(){
	base_w=linkage_width-2*hinge_length;
	base_h=linkage_height-2*hinge_length;
	//echo(base_w);
	truss(base_w, base_h, link_thickness);
	translate([linkage_width/2,0,0]){
		hinge_pair(n_y);
		//#cube([hinge_length,1,1],center=true);		
	}
	translate([0,linkage_height/2,0]) rotate([0,0,90]){
		hinge_pair(n_x);		
	}

}

module side_plate_x1(){
	base_w=linkage_length/2-2*hinge_length;
	base_h=linkage_height-2*hinge_length;
	
	translate([(linkage_width+linkage_length/2)/2,0,0]){	
		side_plate_x(base_w, base_h);	
		translate([base_w/2+hinge_length,0,0]) {
			hinge_pair(n_y);		
		}	
	}
}

module side_plate_x2(){
	base_w=linkage_length/2-2*hinge_length;
	base_h=linkage_height-2*hinge_length;
	
	translate([(linkage_width+3*linkage_length/2)/2,0,0]){	
		side_plate_x(base_w, base_h);			
		translate([base_w/2+hinge_length,0,0])
			single_hinge(n_y);
	}
}

module side_plate_x(w,h){
	truss(w, h, link_thickness);		
}

module top_plate(){
	base_w=linkage_width-2*hinge_length;
	base_h=linkage_height-2*hinge_length;
	translate([linkage_width+linkage_length,0,0]){
		truss(base_w, base_h, link_thickness);
		
		translate([-base_w/2-hinge_length,0,0]) rotate([0,0,180])
			single_hinge(n_y);		
		translate([0,linkage_height/2,0]) rotate([0,0,90]){
			single_hinge(n_x);		
		}
		if(number_of_linkage_arms == 4){
			translate([base_w/2+hinge_length,0,0]) rotate([0,0,180]) mirror([1,0,0]) single_hinge(n_y);
			translate([0,-linkage_height/2,0]) rotate([0,0,90]) mirror([1,0,0]) single_hinge(n_x);

		}
	}

	

}

module side_plate_y1(){
	base_h=linkage_length/2-2*hinge_length;
	base_w=linkage_width-2*hinge_length;
	
	translate([0,(linkage_height+linkage_length/2)/2,0]){	
		side_plate_y(base_w, base_h);	
		translate([0,base_h/2+hinge_length,0]) rotate([0,0,90]){
			hinge_pair(n_x);		
		}	
	}
}

module side_plate_y2(){
	base_h=linkage_length/2-2*hinge_length;
	base_w=linkage_width-2*hinge_length;
	
	translate([0,(linkage_height+3*linkage_length/2)/2,0]){	
		side_plate_y(base_w, base_h);	
		translate([0,base_h/2+hinge_length,0]) rotate([0,0,90]){
			single_hinge(n_x);		
		}	
	}
}

module side_plate_y(w,h){
	truss(w, h, link_thickness);
		
		
}

//Note that length of hinge arm is l+r, so need to subtract r from hinge_length to get correct length hinges.

module hinge_pair(n){
	hhinge(n,space=1.38,clear=hinge_spacing,r=0.5*link_thickness,l=hinge_length-link_thickness/2,pin = false );
	rotate(180,[0,0,1]) hhinge( n,space=1.38,clear=hinge_spacing,r=0.5*link_thickness,l=hinge_length-link_thickness/2,pin = false );
}

module single_hinge(n){
	rotate(180,[0,0,1]) hhinge(n,space=1.38,clear=hinge_spacing,r=0.5*link_thickness,l=hinge_length-link_thickness/2,pin = false );
}

module truss(base_w,base_h,base_t){
	x0 = base_w/2;
	y0 = base_h/2;

	x1 =.9*x0;
	y1 =.9*y0;

	d=.1*x0/sqrt(2);

	difference(){
		cube([base_w, base_h, base_t], center=true);
		translate([0,0,-base_t/2-1]){ 
			linear_extrude(height=link_thickness+2) polygon([[-x1+d,-y1],[x1-d,-y1],[0,-d]]);
			linear_extrude(height=link_thickness+2) polygon([[-x1+d,y1],[x1-d,y1],[0,d]]);
			linear_extrude(height=link_thickness+2) 	polygon([[-x1,-y1+d],[-x1,y1-d],[-d,0]]);
			linear_extrude(height=link_thickness+2) 	polygon([[x1,-y1+d],[x1,y1-d],[d,0]]);
		}
	}	
}

//Uses Basic Hinge by mrule - http://www.thingiverse.com/thing:5922

/**
michael rule
openscad script for sparkfun polygonal pieces
GPL/CC non-commercial share alike etc.
**/

//basic clip piece
module nub(h=2,k=5,r=10,r1=5,l=1.2)
	difference() {
		union() {
			cylinder(k,r1,0,$fn=30);
			translate([0,0,-h]) { 
				cylinder(r=r,h=h,$fn=30);
				translate([0,-r,0]) cube([r+l,2*r,h]);
				translate([-r,0,0]) #cube([r,r,h]);
			}
		}
		translate([0,0,-h]) cylinder(k,r1,0,$fn=30);
	}

//stack of like facing clips
module rack(n=5,space=4,clear=0.4,r=5,l=2)
	for (i=[1:n]) translate([0,0,(2*clear+2*space)*i]) nub(h=space,k=2.5,r=r,r1=r-1,l=l);

//two mirrored stacks make a hinge
module hinge(n=2,space=4,clear=0.0,r=5,l=2,pin=false){
	translate([0,0,-0.5*clear])  
		rack(n,space,clear,r,l);
	translate([0,0,1.5*clear+space]) 
		mirror([0,0,1]) rack(n,space,clear,r,l);
	if(pin) translate([-r,r-0.4,-(clear+space)*n*2+space+clear*1.5]) 
		cube([1.6,0.4,(clear+space)*n*4-space-clear*2]);
}

/**

 hhinge 	: basic horizontal hinge piece
 
 variable	description
 n  		: number of clips ( doubled )
 space 	: width of and space between clips
 clear 	: additional spacing between clips for clearance
 r 		: radius of clip ( half the height )
 l 		: length of that little square bit coming off the back for connecting hinge to objects
 pin 		: if true, a small piece will be added at the bottom, which helps hold the hinge together while printing 
*/
module hhinge(n=3,space=1.38,clear=0.4,r=0.5*5.6,l=0.4*5.6,pin=true)
	rotate(270,[1,0,0]) hinge(n,space,clear,r,l,pin);

//basic demo
//hhinge();

////example mating
//hhinge( pin = false );
//rotate(180,[0,0,1]) hhinge( pin = false );



