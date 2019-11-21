/*
* Filename: fan40mm_frame.scad
* Created by: Anhtien Nguyen
* Date: 27-Jun-2018
* Description: 40mm fan holder
*/
// outer frame width
o_width=50; 
// outer frame length
o_length=50;
// frame thickness, keep this for 40mm fan
thick = 10; 
// keep this for 40mm fan
fan_size = 40; 
 // reduce this to make it tighter
clearance = 0.25;
// M3 diameter
hole_size = 3; 
// hole distance from edge
hole_dist = 3; 
// bracket length, if zeroed then 4 holes are provided
bracket = 20;

printFrame($fn=32);

module printFrame() {
    difference()
    {
        // print the base plate
        drawBasePlate([o_width,o_length,thick], 3);

        // punch 4 holes at the corners if bracket not used
        if (bracket == 0) {
            translate([(-o_width/2)+hole_dist, (-o_length/2)+hole_dist, thick/2])
            cylinder(r=hole_size/2, h=thick+2,center=true); 
                translate([(o_width/2)-hole_dist, (o_length/2)-hole_dist, thick/2])
            cylinder(r=hole_size/2, h=thick+2,center=true); 

                translate([(-o_width/2)+hole_dist, (o_length/2)-hole_dist, thick/2])
            cylinder(r=hole_size/2, h=thick+2,center=true); 

                translate([(o_width/2)-hole_dist, (-o_length/2)+hole_dist, thick/2])
            cylinder(r=hole_size/2, h=thick+2,center=true); 
        }
        //  cut the 40mm square (with clearance) in the middle
        translate([0,0,thick/2])
        cube([fan_size,fan_size,thick+2], center=true);
    }
    // add brackets at 2 sides
    if (bracket >0)
    {
        translate([-fan_size/2-1,0,thick+bracket/2])
        cube([2,fan_size+2,bracket],center=true);
        translate([fan_size/2+1,0,thick+bracket/2])
        cube([2,fan_size+2,bracket],center=true);
    }
}

module drawBasePlate(dim, radius)
{
	wid = dim[0];
	len = dim[1];
	ht = dim[2];

	linear_extrude(height=ht)
	hull()
	{
		translate([(-wid/2)+radius, (-len/2)+radius, 0]) circle(r=radius);
		translate([(wid/2)-radius, (-len/2)+radius, 0]) circle(r=radius);
		translate([(-wid/2)+radius, (len/2)-radius, 0]) circle(r=radius);
		translate([(wid/2)-radius, (len/2)-radius, 0]) circle(r=radius);
	}
}
