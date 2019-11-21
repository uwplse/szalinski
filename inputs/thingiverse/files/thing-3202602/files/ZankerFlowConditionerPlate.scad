//Variables

//Diameter of Plate in mm
D = 127 ; 




Thickness = D/8; ; // Thickness of plate

//Diameter 1-5 for hole arrays from inner to outer
Diam1 = 0.141*D;//
Diam2 = 0.139*D;
Diam3 = 0.1365*D;
Diam4 = 0.110*D;
Diam5 = 0.077*D;

//Corresponding Pitch circle diameters
Pitch1 = 0.25*D;
Pitch2 = 0.56*D;
Pitch3 = 0.75*D;
Pitch4 = 0.85*D;
Pitch5 = 0.90*D;


//Build hole array
module HoleArray(){

//Inner Hole Array (1)
for (i=[1:4])  {
	translate([Pitch1/2*cos(i*(360/4)+45),Pitch1/2*sin(i*(360/4)+45),0]) cylinder(r=Diam1/2,h=Thickness+1, $fn=500);
    }

//Second Hole Array (2)
for (i=[1:4])  {
	translate([Pitch2/2*cos(i*(360/4)+18.5),Pitch2/2*sin(i*(360/4)+18.5),0]) cylinder(r=Diam2/2,h=Thickness+1, $fn=500);
    translate([Pitch2/2*cos(i*(360/4)-18.5),Pitch2/2*sin(i*(360/4)-18.5),0]) cylinder(r=Diam2/2,h=Thickness+1, $fn=500);
    }

//Third Hole Array (3)
for (i=[1:4])  {
	translate([Pitch3/2*cos(i*(360/4)+45),Pitch3/2*sin(i*(360/4)+45),0]) cylinder(r=Diam3/2,h=Thickness+1, $fn=500);
    }

//Fourth Hole Array (4)
for (i=[1:4])  {
	translate([Pitch4/2*cos(i*(90)+11.66667),Pitch4/2*sin(i*(90)+11.66667),0]) cylinder(r=Diam4/2,h=Thickness+1, $fn=500);
    translate([Pitch4/2*cos(i*(90)-11.66667),Pitch4/2*sin(i*(90)-11.66667),0]) cylinder(r=Diam4/2,h=Thickness+1, $fn=500);
    }

//Fifth / Outer hole array (5)
for (i=[1:4])  {
	translate([Pitch5/2*cos(i*90+29),Pitch4/2*sin(i*90+29),0]) cylinder(r=Diam5/2,h=Thickness+1, $fn=500);
    translate([Pitch5/2*cos(i*90-29),Pitch5/2*sin(i*90-29),0]) cylinder(r=Diam5/2,h=Thickness+1, $fn=500);
    }
}

module Plate() {
    cylinder (r=D/2, h=Thickness, $fn=500);
}

difference()    {
Plate(center=true);
translate([0,0,-.5], center = false) HoleArray(center=true);
}

//Subtract modules from one anotherv  