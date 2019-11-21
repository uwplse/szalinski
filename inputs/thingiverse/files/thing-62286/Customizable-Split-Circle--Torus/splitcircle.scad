//Anthony Weber
//agweber@indiana.edu
//March 15, 2013

//build platform replicator2
//--284mm long
//--154mm wide
//--152mm tall

//From origin to center of ring
radius = 90; //

//Thickness is the diameter of the circle
thickness = 6; //

//Build support for nib? 1 == true
addSupport = 1; //[0:1]


//Fine tuning Y, bring circles closer
closeY = 0; //[0:20]

//Fine tuning X, bring circles closer
closeX = 0; //[0:20]

//Fine tuning, nib support thickness
supportThickness = 0.2;

//Show platform, 1 == true
showPlatform = 0; //[0:1]

//Platform X
platformX = 284;
//Platform Y
platformY = 154;

translate([radius/3 - closeX,radius/3 + closeY,0])
	wheelquarter(radius,thickness,addSupport);
rotate([0,0,180]) translate([radius/3 - closeX,radius/3 + closeY,0])
	wheelquarter(radius,thickness,addSupport);


module wheelquarter(wheelRadius=120, wheelThickness=6, support=1) {
	added=wheelRadius+wheelThickness/2;
	barSpacing = 10; //centimeter between the wheel bars
	difference() {
		union() {
			translate([0,0,wheelThickness/2])
				rotate_extrude() { //donut shape
				  translate([wheelRadius,0,0]) circle(r=wheelThickness/2);
				}
		}
		//Two cubes for halving the donut (could be one, I know)
		color("red") cube([added,added,wheelThickness]);
		translate([-added,0,0])color("red") cube([added,added,wheelThickness]);

		translate([-wheelRadius,0.5,wheelThickness/2]) //anti-nib
			rotate([90,0,0]) scale([0.25,0.25,1])
				cylinder(r=wheelThickness,h=wheelThickness/2+0.5);
	}
	translate([wheelRadius,wheelThickness/2,wheelThickness/2]) //nib
		rotate([90,0,0]) scale([0.25,0.25,1])
			cylinder(r=wheelThickness,h=wheelThickness/2);
	//Nib support.. thin cube underneath it could easily be cut off
	if (support != 0) {
		translate([wheelRadius-supportThickness/2,wheelThickness/2*0.2,0])
			color("white") cube([supportThickness,wheelThickness/2*0.8,wheelThickness/4]);
	}
}

//build platform
if (showPlatform != 0) {
	translate([-platformX/2,-platformY/2,-1])
		color("gray") cube([platformX,platformY,0.9]);
}