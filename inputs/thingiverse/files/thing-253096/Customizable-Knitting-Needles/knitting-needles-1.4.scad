//Created by Ari M. Diacou, February 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

//Resolution, higher is smoother.
$fn=30; 
//Length of the needle in mm, tip+shaft.
Length=80; 
//Diameter of the needle in mm.
Diameter=4; 
//Angle that the tip makes.
Angle=20; 
//Of the tip - higher is sharper.
sharpness=4; 
//1=circular, 2=double pointed, 3=straight with butt.
needle_type=3; 
//Each needle produces 2 halves.
number_of_needles=2;
//The bore width that you will insert the filiment to make circular needles.
Wire_Width=2.7; 
//Do you want to slice the needles in half (to make it easier to print on a fused filiment fabricator)?
slice="false";//[true,false] 

/* HIDDEN */
e=0+.01; //Epsilon, a very small number used for ensuring water-tightness.
h=Angle/2;//Half angle. The equations required extensive use of the half angle.
D=Diameter;
R=D/(2*sharpness);//Radius of the sphere that dulls the tip
a=(D/2)*(cos(h)/sin(h))-R/sin(h); //The distance from the shaft/tip interface to the center of the rounding sphere placed on the tip.
L=Length-a-R; //Length of the shaft

if(slice=="true"){
	if(needle_type==1)	lineup(number_of_needles, D*1.2) prepare() circular_needle();
	if(needle_type==2)	lineup(number_of_needles, D*1.2) prepare() dp_needle();
	if(needle_type==3)	lineup(number_of_needles, D*2) prepare() straight_needle();
	}
if(slice=="false"){
	if(needle_type==1)	lineup(number_of_needles/2, D*1.2) prepare2() circular_needle();
	if(needle_type==2)	lineup(number_of_needles/2, D*1.2) prepare2() dp_needle();
	if(needle_type==3)	lineup(number_of_needles/2, D*2.05) prepare2() straight_needle();
	}

module shaft(){
	cylinder(h=L, r=D/2);
	}

module tip(){
	union(){
		translate([0,0,a])
			sphere(R);
		cylinder(h=a+R*sin(h),r1=D/2,r2=R*cos(h));
		}
	}

module back_tip(){ //a tip with a borehole in it to make a circular needle
	difference(){
		tip();
		translate([0,0,e]) cylinder(a+R/sin(h), r=Wire_Width/2);
		}
	}

module circular_needle(){ //a circular needle meant for inserting filiment into the back.
	union(){
		shaft();
		translate([0,0,L-e]) tip();
		translate([0,0,e]) mirror([0,0,1]) back_tip();
		}
	}

module straight_needle(){ //a straight needle with a bump at the end
	union(){
		shaft();
		translate([0,0,L-e]) tip();
		translate([0,0,e]) mirror([0,0,1]) cylinder(h=D/4,r=D);
		}
	}

module dp_needle(){ //a double pointed needle
	union(){
		shaft();
		translate([0,0,L-e]) tip();
		translate([0,0,e]) mirror([0,0,1]) tip();
		}
	}

module lineup(num, space) { //lines up 'num' things with 'space' between the centers of object child(0). Lined up on the y axis on either side of the xz plane.
   for (i = [-num : num-1])
     translate([ 0, space*(i+.5), 0 ]) child(0);
 }

module prepare(){ //Rotates from z-hat direction to x-hat direction, and deletes half
	difference(){
		rotate([0,90,0])	
			translate([0,0,-L/2]) 
				child(0);
		translate([0,0,-D/2-e])
			cube([L+2*(a+R+e),2*(D+e),D+e],center=true);
		}
	}	

module prepare2(){ //just rotation
		rotate([0,90,0])	
			translate([0,0,-Length/2]) 
				child(0);
	}