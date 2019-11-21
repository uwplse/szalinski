/*
Create a tube socket for 3D printing
By: Dave Borghuis / zeno4ever
Version : 1.2
Date : 22-01-2012
For sugestions email me at : zeno4ever@gmail.com

22-01-12 Added Notch option/parameters
18-01-12 Initial version
30-01-12 Make script better for use in Customizer (by Makerbot)

Usage : at least change the Socket dimensions and pin size. The rest of the 
parameter can be changed to, this defaults should be reasonable.

All $r is radius, you can enter diameter/2 

Current parameters are for a octal base tube socket
*/

//All sizes in mm
socket_hight = 15 ;
socket_radius = 17;

pin_radius = 1.5;

//How many holes
pin_numbers = 8; //[1:32]

//Distance from center
pin_distance = 8.5 ; 

//Enable center hole, 0 to disable hole & notch
center_radius = 4; 
//0 to disable
notch_size = 2;
notch_position =  112.5; //[1:360]
notch_distance = center_radius;

//Resolution of model
$fs = 0.01*1; 

// Create Tube Socet 
difference() {
	//Create footer
	union() {
		hull() {
	  		translate([77/2,0,0]) cylinder(5,10/2,10/2);
      		translate([0,0,0]) cylinder(5,socket_radius,socket_radius);
	  		translate([-77/2,0,0]) cylinder(5,10/2,10/2);	
		}
		translate([0,0,5]) cylinder(socket_hight-5 , socket_radius, socket_radius);
	}
	//Create all holes
	for (i = [0:pin_numbers-1]) { //create holes
		//echo(360*i/6, sin(360*i/6)*80, cos(360*i/6)*80);
		translate([sin(360*i/pin_numbers)*pin_distance, cos(360*i/pin_numbers)*pin_distance, 0 ])
		cylinder(socket_hight*2, pin_radius,pin_radius); 
	}

	//Exaple if you want to put a pin at some 'random' position
	//replace the 90 in next line for the position
	//translate([sin(90)*pin_distance, cos(90)*pin_distance, 0 ]) cylinder(socket_hight, pin_radius,pin_radius); 
	
	//Create center hole/notch
	if (center_radius>0) { //if centerhole 
		if (notch_size!=0) //and notch {
			rotate(a=[0,0,notch_position])
			union() {
				cylinder(socket_hight*2,center_radius,center_radius); //Center pin
				translate([notch_distance,0, 0 ]) cube(size=[notch_size,notch_size,socket_hight*2], center=true); //Notch
				} 
		} else {
			cylinder(socket_hight*2,center_radius,center_radius); //Only center pin
	}


	//holes in the footer
	translate([77/2,0,0]) cylinder(socket_hight*2,2,2); 
	translate([-77/2,0,0]) cylinder(socket_hight*2,2,2); 	
}
