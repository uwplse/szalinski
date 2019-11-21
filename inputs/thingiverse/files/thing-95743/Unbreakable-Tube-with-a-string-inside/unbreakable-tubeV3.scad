/////////////////////////////////////////////////////////////////////////////////////////////
// Unbreakable Tube, Version 3
//
// Copyright (C) 2013  Lochner, Juergen
// http://www.thingiverse.com/Ablapo/designs
//
// This program is free software. It is 
// licensed under the Attribution - Creative Commons license.
// http://creativecommons.org/licenses/by/3.0/
//////////////////////////////////////////////////////////////////////////////////////////////



// Choose object to print
print_object=1;  // [1:Plate,2:Tube_Element,3:End_Pat,4:End_Mat]

// Clearance:
cl=0.2 ;

// Element's height:
e_height=30;

// Tube's radius:
e_radius=8;

// Cone's slope
c_slope=9;

// Tube's minimum thickness:
c_base=1.4;

// Details:
$fn=88+0;

// Cone height:
c_height=3+0;		

// String hole radius:
c_hole=1.5+0;

// spacing of the internal top cone cut:
c_hut=1.5+0;

// Slope of inner top cone:
sangle=1.5;

// Split parts for demonstration? 
debug=  false; // [true,false]



///////////////////////////////////////////////////////////////////////////////////
// no longer used parts:
///////////////////////////////////////////////////////////////////////////////////
module invert(height= 12){
	difference(){
		cylinder(h=height,r=e_radius, $fn=120);
		translate([0,0, +0.001]) cylinder(h=height, r1=e_radius-c_base-height/c_slope + cl, r2=e_radius-c_base+cl);
		translate([0,0, -0.001]) cylinder(h=height, r2=e_radius-c_base-height/c_slope + cl, r1=e_radius-c_base+cl);
	}
}

module cone_uturn (height=6){
	difference(){
		cylinder(h=height  , r2=e_radius-c_base-height/c_slope ,r1=e_radius-c_base );
		
	
		translate([0,0, height-0.75])difference(){
			translate([0,0,0])rotate([90,0,0])rotate_extrude(convexity = 10,$fn=12) translate([3, 0, 0]) circle(r = c_hole);
			translate([0,0,+10]) cube([20,20,20],center=true); 
		}
 		translate([3,0,height-1])rotate([ 0,0,0])cylinder (h=10.1,r=c_hole, $fn=22);
		translate([-3,0,height-1])rotate([ 0,0,0]) cylinder (h=10.1,r=c_hole, $fn=22); 
		translate([4.4,0,height-3])rotate([ 0,0,360/4/2])cylinder (h=10.1,r=c_hole/sin(45), $fn=4);
		translate([-4.4,0,height-3])rotate([ 0,0,360/4/2])cylinder (h=10.1,r=c_hole/sin(45), $fn=4);
	}
}

module cone_openend(height=5){
	 difference(){
		cylinder(h=height  , r2=e_radius-c_base-height /c_slope ,r1=e_radius-c_base );
		translate([2.5,0,0])  cylinder (h=40.1,r=c_hole,center=true,$fn=22);
		translate([-2.5,0,0]) cylinder (h=40.1,r=c_hole,center=true,$fn=22);
	}
}

///////////////////////////////////////////////////////////////////////////////////
// Version 3 parts:
///////////////////////////////////////////////////////////////////////////////////

module element(height=10){
	bocohi=c_height+1; 										// bottom cone cut height
	i_rad=e_radius-c_base-bocohi/c_slope+cl;			// inner tube radius
	

 	difference(){
		union(){
			cylinder(h=height, r=e_radius, $fn=120);
			translate([0,0,height]) cylinder(h=c_height, r2=e_radius-c_base-c_height/c_slope, r1=e_radius-c_base );
		}	
		// cut internal bottom connection cone
		translate([0,0,-0.01]) cylinder(h=bocohi, r2=i_rad, r1=e_radius-c_base+cl,$fn=120); 

		// cut center tube cylinder
		cylinder(h=height+ c_height+0.01 -(i_rad-c_hole)*sangle -c_hut, r=i_rad);

		// cut internal top cone
		translate([0,0,height+c_height -(i_rad-c_hole)*sangle - c_hut ])
		cylinder(h=(i_rad-c_hole)*sangle, r1=i_rad, r2=c_hole);

		// cut center string hole
		translate([0,0,-0.1]) cylinder(h=height+c_height+0.3 , r =c_hole);

		if (debug==true) translate([0,-e_radius,-0.1])cube([e_radius*2,e_radius*2,e_height*2+c_height*2] ); 		// debug
	}
}

module end_pat (height=8){
 	difference(){
		union(){
			cylinder(h=height-c_height, r=e_radius, $fn=120);
			translate([0,0,height-c_height]) cylinder(h=c_height, r2=e_radius-c_base-c_height/c_slope, r1=e_radius-c_base );
		}	
		translate([ 2.5,0,0]) cylinder (h=40.1,r=c_hole,center=true,$fn=22);
		translate([-2.5,0,0]) cylinder (h=40.1,r=c_hole,center=true,$fn=22);
		if (debug==true) translate([0,-e_radius,-0.1])cube([e_radius*2,e_radius*2,e_height*2+c_height*2] ); 		// debug
	}
}

module end_mat(height= 10){ 							// height=4-8(bottom stability) + c_height (connect, retention)+extra length
	stability=4; // height of bottom
	
	difference(){
		cylinder(h=height,r=e_radius, $fn=120);			// body
		translate([0,0,height-c_height-1   +0.01]) cylinder(h=c_height+1, r1=e_radius-c_base-(c_height+1)/c_slope + cl, r2=e_radius-c_base+cl);
  		translate([0,0, stability+0.001]) cylinder(h=height-stability, r =e_radius-c_base-(c_height+1)/c_slope + cl );
		translate([2.5,0,0])  cylinder (h=40.1,r=c_hole,center=true,$fn=22);
		translate([-2.5,0,0]) cylinder (h=40.1,r=c_hole,center=true,$fn=22);
		if (debug==true) translate([0,-e_radius,-0.1])cube([e_radius*2,e_radius*2,e_height*2+c_height*2] ); 		// debug
	}
}


///////////////////////////////////////////////////////////////////////////////////
// Part selection:
///////////////////////////////////////////////////////////////////////////////////

module plate(){
	translate([0,0,0]) end_pat();
	translate([e_radius*2.2,0,0]) element(e_height);
	translate([e_radius*2.2/2,e_radius*2.2,0]) end_mat();
}

if (print_object==1) plate();
if (print_object==3) end_pat();
if (print_object==2) element(e_height);
if (print_object==4) end_mat();