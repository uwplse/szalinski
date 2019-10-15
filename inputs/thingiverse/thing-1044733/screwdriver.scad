// Customizable screw driver stand
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
translate([-diameter/2,-diameter/2,0])
    cube([rows*(diameter-1)+1,number*(diameter-1)+1,2]); 

        
//Tubes
for (xi=[0:1:rows-1])
    for(yi=[0:1:number-1])
        translate([xi*(diameter-1),yi*(diameter-1),0])
            tube (height, diameter);
