// Washer
//
// By Tertzoid
//
// Version 0.0.2  January 2nd 2013
//
// Bright Washers are dimensioned in BS4320: 1968/
// Based on info from : http://www.roymech.co.uk/Useful_Tables/Screws/Hex_Screws.htm
//

include <write/Write.scad>
//use <write.scad>


washer_sides = 128;

// Free mode
freemode = "no"; // [yes,no]

// Inner diameter
free_id=6.6; // [0:200]
// Outer diameter
free_od=12; // [0:200]
// height
free_height=1.2; // [0:100]

// Tolerance
tolerance=0.25;  // [0:1]


// Washer M
sizeM=6.0; // [2,3,4,5,6,8,10,12,16,20,24]


i_id=sizeM*1.1;
i_od=sizeM*2.0;
i_height=sizeM*0.2;

// Engrave size
//engrave = "no"; // [yes,no]


///////////////////////////////////////////////////
// Multiple Washer Build Functions

// Build plate width
build_size_width = 1; // [1,5,10]
// Build plate depth
build_size_depth = 1; // [1,5,10]
build_space_between_washer = 1;

if(freemode=="yes") 
{
 washer_array_gen(free_id+tolerance,free_od-tolerance,free_height);
} else 
{
 washer_array_gen(i_id+tolerance,i_od-tolerance,i_height);
}





///////////////////////////////////////////////////
// General Library modules
module washer_gen(id,od,height) {
	$fn = washer_sides;
		difference () {
			cylinder(r = od/2, h = height);	
			translate([0,0,-height*2]) cylinder(r = id/2, h = height*4);	
         writecylinder(str(sizeM),[0,0,0],(id-tolerance),height-0.5,h=sizeM/3,face="top");
	}
}

module washer_array_gen(id,od,height) {
	max_width_count = build_size_width;
	max_depth_count = build_size_depth;
	
	for (x = [0:max_width_count-1]) {
		for (y = [0:max_depth_count-1]) {

				translate([x*(od+build_space_between_washer),y*(od+build_space_between_washer),0]) washer_gen(id,od,height);
		
		}
	}
}