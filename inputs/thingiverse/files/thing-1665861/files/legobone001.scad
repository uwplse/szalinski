/*      
Customizable freeform-2-hole LEGO Technic Connector Bone
Jens Henrik Sandell
July 2016
Updated December 2016

Created by forking the thing:629875
        Customizable Curved LEGO Technic Beam
        Steve Medwin
        January 2015
*/
$fn=20*1.0;
// preview[view:north east, tilt:top]

// constants
width = 7.3*1.0; // beam width
height = 7.8*1.0; // beam height
hole = 5.0/2; // hole diameter
counter = 6.1/2; // countersink diameter
depth = 0.85*1.0; // countersink depth
pitch = 8.0*1.0; // distance between holes

// user parameters
// distance between holes =
Distance1 = 50; // [20:100]
// width of knuckle and ends =
Knuckle = 10; // [8:16]

// calculations
// create beam
difference()
{
	union(){
		cylinder(h=height, r=Knuckle/2);
		translate([0,-width/2,0]) cube([Distance1,width,height]);
		translate([Distance1,0,0]) cylinder(h=height,r=Knuckle/2);
	}
	for (i=[0:1]) {
		translate([i*Distance1,0,0]) {
			translate([0,0,-2])
			cylinder(h=height+4, r=hole);
                
			translate([0,0,-0.01])
			cylinder(h=depth+0.01, r=counter);      
                
			translate([0,0,height-depth])
			cylinder(h=depth+0.01, r=counter);
                
			translate([0,0,depth])
			cylinder(h=(counter - hole), r1=counter, r2=hole);           
		}    
	}
}

