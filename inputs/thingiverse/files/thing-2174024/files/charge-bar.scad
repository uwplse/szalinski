// This thing is a simplified version of the Lee MicroDisk for the
// AutoDisk Powder Measure. The original MicroDisk is currently out
// of production.
//
// Warning -- some sanding and fitting will be required.
//
// This is licensed under the creative commons+attribution license
// This was inspired by SBfarmer's design at
// http://www.thingiverse.com/thing:1257156
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2174024

/* [Main] */

// Define cavity size calcuation method
shape=0; // [0:Use Volume Method,1:Use Diameter Method]

// in mm
body_height=12.0; 

// Z axis fudge factor in mm
zff=0.125; //[-0.5:0.05:0.5]

// in mm
body_length=60.0; //[55:0.1:65]

// in mm
body_width=32.0; //[30:0.1:35]

// in mm
leg_length=2.5; //[2:0.1:3]

// in mm
pocket_depth=10.0; //[8:0.1:11]

// Powder drop bar height in mm
slide_height=6.3; //[6:0.1:6.5]

// Powder drop bar width in mm
slide_width=10.46; //[10:0.05:11]

// of first cavity in cc (only works if using volume method)
volume01=0.13; //[0.1:0.01:0.3]

// of second cavity in cc (only works if using volume method)
volume02=0.16; //[0.1:0.01:0.3]

// of first cavity in mm (only works if using diameter method)
diameter01=4.73145; //[4:0.01:10.0]

// of second cavity in mm (only works if using diameter method)
diameter02=9.265; //[4:0.01:10.0]

pi=3.141592653589793;

module half_body()
{
	difference()
	{
		union()
		{
		// Define left half of main body of structure
		intersection()
		{
			translate([15,0,0]) cube([(body_length+zff)/2,body_width,(body_height+zff)],center=true);
			translate([0,0,0])  cylinder(h=(body_height+zff),r=body_length/2,center=true,$fn=100);

		}
		// Let's grow some legs
			translate([20,-9.5,leg_length+2])  cube([5,3,10],center=true);
		}
		// Cut pocket for slide lever
		#minkowski()
		{
			translate([20,10,2]) cube([9.75,3,pocket_depth],center=true);
			cylinder(r=1);
		}
		// Hollow out inside of shell
		translate([0,0,1.5])
		minkowski()
		{
			translate([6,0,0]) cube([11,26,pocket_depth+1],center=true);
			cylinder(r=1);
		}
		// Cut slot for powder drop slide bar
		translate([0,0,slide_height/2]) cube([61,slide_width,slide_height],center=true);
	}
}

module label(text_input)
{
    text(text_input,size=3,center=false);
}
 
difference()
{
	union()
	{
		// Combind left body with right body
		half_body();
		rotate([0,0,180]) half_body();
        
		// Reinforce hollowed out shell
		translate([00,00,-02]) rotate([00,00,90]) cube([02,24,slide_height/2],center=true);
		translate([00,00,-02]) rotate([00,00,00]) cube([02,30,slide_height/2],center=true);

		translate([00,00,-02])  cylinder(h=slide_height/2,r=02,center=true,$fn=10);
		translate([12,00,-02])  cylinder(h=slide_height/2,r=02,center=true,$fn=10);
		translate([-12,00,-02]) cylinder(h=slide_height/2,r=02,center=true,$fn=10);
		translate([00,14,-02])  cylinder(h=slide_height/2,r=02,center=true,$fn=10);
		translate([00,-14,-02]) cylinder(h=slide_height/2,r=02,center=true,$fn=10);
	}
	// Let's make some cavities
    
    if(shape==0) // Use volume to calculate cavity size
	{
		// Determine cavity radius by multiplying volume in cc by 1000 to get cubic mm and soving for r
		#translate([-22,00,00])  cylinder(h=(body_height+zff+slide_height+1),r=sqrt(volume01*1000/(pi*(body_height-slide_height))),center=true,$fn=50);
        #translate([-23,13,-6]) rotate([0,180,180]) linear_extrude(1) label(str(volume01," CC"));
		#translate([+22,00,00])  cylinder(h=(body_height+zff+slide_height+1),r=sqrt(volume02*1000/(pi*(body_height-slide_height))),center=true,$fn=50);
        #translate([23,-13,-6]) rotate([0,180,0]) linear_extrude(1) label(str(volume02," CC"));
	}
	if(shape==1) // Use diameter to calculate cavity size
	{
		// Determine cavity radius by dividing diameter by 2
		#translate([-22,00,-slide_height])  cylinder(h=body_height+zff+slide_height+1,r=diameter01/2,center=false,$fn=50);
        vol01=pi*pow(diameter01/20,2)*(body_height+zff-slide_height+1)/10;
      #translate([-23,13,-6]) rotate([0,180,180]) linear_extrude(1) label(str(vol01," CC"));
		#translate([+22,00,-slide_height])  cylinder(h=body_height+zff+slide_height+1,r=diameter02/2,center=false,$fn=50);
      vol02=pi*pow(diameter02/20,2)*(body_height+zff-slide_height+1)/10;
      #translate([23,-13,-6]) rotate([0,180,0]) linear_extrude(1) label(str(vol02," CC"));
	}
}
