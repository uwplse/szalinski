///////////////////////////////////////////////////////////////////////////
// Spiked Spiral Generator for Rings, Vases, Bracelets, Earings V1.3 
//
// Copyright (C) 2013 Author: Lochner, Juergen
// Email: aabblapo@googlemail.com
// www.thingiverse.com/Ablapo
//
// Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//
// You are free: 
// 1. to Share - to copy, distribute and transmit the work
// 2. to Remix - to adapt the work
//
// Under the following conditions:
// 1. Attribution - You must attribute "Spiked Spiral Generator for Rings, Vases, Bracelets, Earings" to Ablapo with link.
// 2. Noncommercial - You may not use this work for commercial purposes without the author's permission. 
///////////////////////////////////////////////////////////////////////////
//
// Set your parameters:

// Select Object:
sel_object=1; 		// [1:Spiral, 2:Spikes]

// Number of spikes:
n=3; 		  			// [2:100]

// Element's width:
width=11; 				// [1:100]

// Element's inner radius:
li=10;					// [1:80]

// Spike length as percentage of central radius:
peakp= 254;				//[1:400]

// Cut spike tip percentage:
rsp = 55; 			// [0:100]

// Curved details:
sli=88;  				// [3:200]

// Rotation angle:
rotangle= 17; 		// [0:80]


// Radial wall parameter:
wall = 1;				// [0.3,0.5,0.8,1,1.5,2]

// Mirroring (changes width):
mirr=1;				// [0:off,1:on]

// Additional mirrored stacks (Spiral mode only):
stacks=3;				// [1:12]

// Cut stretch elements: 
stretch=0;			// [0:no, 1:yes]

// Stretch element's resize factor:
strfa=0.3 ;

// Spikes per stretch elements:
sln=1; 				// [1:10] 

// center ring size percentage (0 = off):
center_ring=44   ;		//[0:100]

tw= tan(rotangle )*width/li*45;	// twist for linear extrusion
la=li+peakp*li/100;					// radius of body
bh=sin(180/n)*la;					// basehalf of cutting triangle
no=bh/tan(180/n)-li;				// hight of cutting triangle
scal=(la-li)/no+0.1  ;				// scaling factor to adjust triangle hight to circle


// quadratic solution for sle - stretch element length  
pi=3.1415*1;
qcc=3*n*wall;										// Minimum Distance of stretch elements
qsa=13/9-n*n/pi/pi;								// a
qsb=-4/3*li-n*qcc/pi/pi; 						// b
qsc=li*li-qcc*qcc/4/pi/pi; 					// c 
sle=(-qsb-sqrt(qsb*qsb-4*qsa*qsc))/2/qsa *strfa;  // height of stretch element



// Triangle defined by half of it's base and by it's normal (gleichschenkliches Dreieck)
module gsd(basehalf=1, normal=2){
	polygon(
		points=[[ normal,0],[0,basehalf ],[0,-basehalf ]], 
		paths=[ [0,1,2] ] 
	);
}

//for (i=[1:1:n]) rotate([0,0,360/n*i]) translate([ -li-no,0]) gsd(bh,no);

module spike_mode(){
	difference(){
		difference(){
			linear_extrude(height = width, center = false, convexity = 10, twist = tw, slices = sli )
			difference(){
				circle(r= la-(la-li)*rsp/100,center=false,$fn=sli);
				for (i=[0:1:n-1]) rotate([0,0,360/n*i]) {
						translate([ -li-no*scal,0]) gsd(bh*scal,no*scal);
					if (stretch==1 &&   sle >=0 && i%sln==0) translate([ -li+sle-sle/3 ,0]) rotate([0,0,180])gsd(sle ,sle );
					if (stretch==1 &&  sle <0 && i%sln==0 ) translate([ -li-sle+sle/3 ,0]) rotate([0,0,180])gsd(-sle,-sle);

					if (i==0 && center_ring>=1) {
					 	translate([-la/2, 0])  square ([la, wall],center=true);
						circle(r=(li-wall*2)*center_ring/100+wall, $fn=sli);
					}
				}
			}
			if (sel_object==2){
				linear_extrude(height = width+0.01, center = false, convexity = 10, twist = -tw, slices = sli )
				for (i=[1:1:n]) rotate([0,0,360/n*i]) translate([ -li-no*scal-0.01,0]) gsd(bh*scal,no*scal);
			}
		}
	}
}


module spiral_mode(){
	difference(){
 
		linear_extrude(height = width, center = false, convexity = 10, twist = tw, slices = sli )
		difference(){
			circle(r= la-(la-li)*rsp/100 ,center=true,$fn=sli);
			for (i=[0:1:n-1]) rotate([0,0,360/n*i]) {
			translate([ -li-no*scal,0]) gsd(bh*scal,no*scal);
			if (stretch==1 && sle >=0 && i%sln==0) translate([ -li+sle-sle/3 ,0]) rotate([0,0,180])gsd(sle ,sle );
			if (stretch==1 && sle <0 && i%sln==0 ) translate([ -li-sle+sle/3 ,0]) rotate([0,0,180])gsd(-sle,-sle);
			 
			if (i==0 && center_ring>=1) {
			 	translate([-la/2, 0])  square ([la, wall],center=true);
				circle(r=(li-wall*2)*center_ring/100+wall, $fn=sli);
			}
			}
		}
	}
}

if (sel_object==2) {
	spike_mode();
	if (mirr==1) mirror([0,0,1])	spike_mode();
	}
if (sel_object==1) {
  spiral_mode();
	if (mirr==1) for (za=[1:1:stacks  ])	 {
	if (za%2 ==1) translate([0,0,-(width-0.01)* (za-1 ) ])mirror([0,0,1]) spiral_mode();
	if (za%2 ==0) translate([0,0,-(width-0.01)*(za  )])spiral_mode();
	}
}

