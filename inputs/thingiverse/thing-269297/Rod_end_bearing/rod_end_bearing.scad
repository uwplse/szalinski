//Rod end bearing
//Author: Nikolaj Goodger
//Date: 11/03/2014

//Parameters
//Ball hole diameter
d1=5; 
//Rod hole diameter 
d2=5;  
//Ball diameter
d3=15; 
//Outer edge width
ew=3; 
//End length
l1=25; 
//Rod hole depth
l2=10; 
//End width
w1=10; 
//Thickness
T=10; 
//Tolerance
tol=0.3; 

//Model
difference(){
	sphere(r=d3/2, $fn=50); 
	cylinder(r=d1/2,h=d3+1,$fn=40,center=true);
	rotate([180,0,0])
		translate([0,0,T/2])
			cylinder(r=(2*ew+d3)/2,h=d3/2,$fn=40,center=false);
	translate([0,0,T/2])
		cylinder(r=(2*ew+d3)/2,h=d3/2,$fn=40,center=false);
}
difference(){

	cylinder(r=(2*ew+d3)/2,h=T,$fn=40,center=true);
	sphere(r=d3/2+tol, $fn=50); 
}
rotate([0,90,0])
{
	difference(){
			translate([0,0,-l1/2])
				cube(size=[T,w1,l1],center=true);
		sphere(r=d3/2+tol+1, $fn=50); 
		translate([0,0,-l1])
		cylinder(r=d2/2,h=l2,$fn=40,center=false);

	}
}

