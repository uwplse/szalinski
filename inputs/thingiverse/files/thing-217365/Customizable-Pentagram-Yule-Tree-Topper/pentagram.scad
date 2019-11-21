//Customizable Pentagram Yule Tree Topper
//Created by Ari M. Diacou, January 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:south, tilt:top diagonal]
//The length of one of the sides of the star
length=5;
//The thickness of one of the sides of the star
thickness=.1;
//The height of one of the sides of the star
height=.4;
//The diameter of the hole for the tree topper
hole=.3;

/* HIDDEN */
angle=36+0;
phi=(1+sqrt(5))/2;
a=length/(2*phi+1);
r=length*cos(angle)/((4*phi+2)*sin(angle));

module side(){
	mirror([0,1,0]){
		difference(){
			cube([length,thickness,height]);
			rotate([0,0,angle]) 
				cube([thickness/sin(angle),thickness,height]);
			translate([length,0,0]) 	
				mirror([1,0,0]){
					rotate([0,0,angle]) 
						cube([thickness/sin(angle),thickness,height]);
					}
			}
		}
	}

difference(){
	for(i=[1:5]){
	   rotate([0,0,i*2*angle]) 
			translate([-length/2,r,0]) 
				side();
		}
	translate([0,r+thickness/100,height/2])
		rotate([90,0,0])
			cylinder(r=hole/2,h=length, $fn=20);
	}
