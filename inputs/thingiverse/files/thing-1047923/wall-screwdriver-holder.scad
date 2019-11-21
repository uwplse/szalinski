// Customizable screw driver stand top
// Created by Kjell Kernen
// Date 30.9.2015

/*[Pattern Parameters]*/
// of screw drivers:
rows=3;       // [2:5]

// of screw drivers per row:
number=4;     // [2:6]

// of the stand in mm:
height=30;    // [15:50]

// of the screw driver tubes in mm:
inner_diameter=14;  // [10:40]

// in mm:
hole_diameter=7;  // [4:10]

/*[Hidden]*/
diameter = inner_diameter+1;
/* Modules */

module tube(height,width)
{
	difference()
	{
		cylinder(r=(width/2),    h=height);	
		translate([0,0,-1])
           cylinder(r=(width/2 -1), h=height+2);
	}
}

// Drawing starts here ********************************************

//Base
difference()
{
    translate([-diameter/2,-diameter/2,0])
        cube([rows*(diameter-1)+1,number*(diameter-1)+1,2]);
    for (xi=[0:1:rows-1])
        for(yi=[0:1:number-1])
            translate([xi*(diameter-1),yi*(diameter-1),-1])
                cylinder( d2=inner_diameter, d1=hole_diameter, h=3.5);
}    

//Wall
difference()
{
    translate([-diameter/2-1,-diameter/2,0])
        cube([2,number*(diameter-1)+1,height+15]);
    union()
    {
        translate([-diameter/2-2, diameter/2, height + 7.5]) 
            rotate([0,90,0])
                cylinder(h=4, d=4);
        translate([-diameter/2-2, diameter/2 +((diameter-1)*(number-2)) , height + 7.5]) 
            rotate([0,90,0])
                cylinder(h=4, d=4);
    }
}    

//Tubes
for (xi=[0:1:rows-1])
    for(yi=[0:1:number-1])
        translate([xi*(diameter-1),yi*(diameter-1),0])
            tube (height, diameter);
