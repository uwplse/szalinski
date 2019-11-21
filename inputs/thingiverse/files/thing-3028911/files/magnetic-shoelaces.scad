
// Written by Volksswitch <www.volksswitch.org> based on an original design by adafruit
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
//



//------------------------------------------------------------------
// User Inputs
//------------------------------------------------------------------

/*[Shoe Laces]*/
inter_lace_distance = 20;
lace_hole_diameter = 5;

/*[Block Width]*/
preferred_width_of_each_block = 16;

/*[Magnets]*/
magnet_length = 20;
magnet_width = 5;
magnet_thickness = 3;
number_of_magnet_slots = 2; //[1:2]
number_of_magnets_per_slot = 2; //[1:2]

/* [Hidden] */
num_lace_holes = 3;

block_length1 = inter_lace_distance*(num_lace_holes - 1) + 10; //block length based on interlace distance
block_length2 = number_of_magnet_slots == 1 ? //block length based on magnet length
	  magnet_length + 10
	: magnet_length*2 + 15;
block_length = max(block_length1,block_length2);

magnet_slot_offset= (number_of_magnet_slots == 1) ?
	  0
	: (block_length-magnet_length*2)/6 + magnet_length/2;

block_thickness = magnet_width + 3;
effective_magnet_thickness = magnet_thickness * number_of_magnets_per_slot;

min_magnet_hole_distance = 1.5;
min_block_width = effective_magnet_thickness+lace_hole_diameter+min_magnet_hole_distance*2;
block_width = max(preferred_width_of_each_block-1,min_block_width);
magnet_hole_distance = (block_width-effective_magnet_thickness-lace_hole_diameter)/2;
hole_centerline = block_width/2-effective_magnet_thickness-magnet_hole_distance-lace_hole_diameter/2;

$fn = 50;

//base
translate([0,10,block_width/2])
difference(){
	//base
	cube([block_length,block_thickness,block_width],center=true);

	//chamfer base corners
	translate([-block_length/2,-block_thickness/2,0])
	rotate([0,0,90])
	cylinder(h=block_width+0.01, r=1, center=true, $fn=4);

	translate([-block_length/2,block_thickness/2,0])
	rotate([0,0,90])
	cylinder(h=block_width+0.01, r=1, center=true, $fn=4);

	translate([block_length/2,-block_thickness/2,0])
	rotate([0,0,90])
	cylinder(h=block_width+0.01, r=1, center=true, $fn=4);

	translate([block_length/2,block_thickness/2,0])
	rotate([0,0,90])
	cylinder(h=block_width+0.01, r=1, center=true, $fn=4);

	translate([block_length/2,0,-block_width/2])
	rotate([0,90,90])
	cylinder(h=block_thickness+0.01, r=1, center=true, $fn=4);

	translate([-block_length/2,0,-block_width/2])
	rotate([0,90,90])
	cylinder(h=block_thickness+0.01, r=1, center=true, $fn=4);

	translate([0,block_thickness/2,-block_width/2])
	rotate([90,0,90])
	cylinder(h=block_length+0.01, r=1, center=true, $fn=4);

	translate([0,-block_thickness/2,-block_width/2])
	rotate([90,0,90])
	cylinder(h=block_length+0.01, r=1, center=true, $fn=4);

	//lace holes
	translate([0,0,hole_centerline])
	rotate([90,0,0])
	cylinder(h=block_thickness+0.01, r=lace_hole_diameter/2, center = true);
	
	translate([-inter_lace_distance,0,hole_centerline])
	rotate([90,0,0])
	cylinder(h=block_thickness+0.01, r=lace_hole_diameter/2, center = true);
	
	translate([inter_lace_distance,0,hole_centerline])
	rotate([90,0,0])
	cylinder(h=block_thickness+0.01, r=lace_hole_diameter/2, center = true);
	
	//lace hole chamfers
	translate([0,-block_thickness/2-0.01,hole_centerline])
	rotate([-90,0,0])
	cylinder(h=1, r1=lace_hole_diameter/2+2, r2=lace_hole_diameter/2, center = true);
	
	translate([0,block_thickness/2+0.01,hole_centerline])
	rotate([90,0,0])
	cylinder(h=1, r1=lace_hole_diameter/2+2, r2=lace_hole_diameter/2, center = true);
	
	translate([-inter_lace_distance,-block_thickness/2-0.01,hole_centerline])
	rotate([-90,0,0])
	cylinder(h=1, r1=lace_hole_diameter/2+2, r2=lace_hole_diameter/2, center = true);
	
	translate([-inter_lace_distance,block_thickness/2+0.01,hole_centerline])
	rotate([90,0,0])
	cylinder(h=1, r1=lace_hole_diameter/2+2, r2=lace_hole_diameter/2, center = true);
	
	translate([inter_lace_distance,-block_thickness/2-0.01,hole_centerline])
	rotate([-90,0,0])
	cylinder(h=1, r1=lace_hole_diameter/2+2, r2=lace_hole_diameter/2, center = true);
	
	translate([inter_lace_distance,block_thickness/2+0.01,hole_centerline])
	rotate([90,0,0])
	cylinder(h=1, r1=lace_hole_diameter/2+2, r2=lace_hole_diameter/2, center = true);

	//magnet slots
	translate([magnet_slot_offset,0,block_width/2-effective_magnet_thickness/2+0.01])
	cube([magnet_length,magnet_width,effective_magnet_thickness],center=true);
	
	translate([-magnet_slot_offset,0,block_width/2-effective_magnet_thickness/2+0.01])
	cube([magnet_length,magnet_width,effective_magnet_thickness],center=true);
	
	//post holes
	if (number_of_magnet_slots == 2){
		translate([0,0,block_width/2-1.5+0.01])
		cylinder(h=3,r=1,center=true);
	}
	
	translate([block_length/2 - 2.5,0,block_width/2-1.5+0.01])
	cylinder(h=3,r=1,center=true);
	
	translate([-block_length/2 + 2.5,0,block_width/2-1.5+0.01])
	cylinder(h=3,r=1,center=true);
}


//cap
translate([0,-10,.5])
union(){
	difference(){
		cube([block_length,block_thickness,1],center=true);

		//chamfers
		translate([-block_length/2,-block_thickness/2,0])
		rotate([0,0,90])
		cylinder(h=1+0.01, r=1, center=true, $fn=4);

		translate([-block_length/2,block_thickness/2,0])
		rotate([0,0,90])
		cylinder(h=1+0.01, r=1, center=true, $fn=4);

		translate([block_length/2,-block_thickness/2,0])
		rotate([0,0,90])
		cylinder(h=1+0.01, r=1, center=true, $fn=4);

		translate([block_length/2,block_thickness/2,0])
		rotate([0,0,90])
		cylinder(h=1+0.01, r=1, center=true, $fn=4);

		
		translate([block_length/2,0,-.5])
		rotate([0,90,90])
		cylinder(h=block_thickness+0.01, r=1, center=true, $fn=4);

		translate([-block_length/2,0,-.5])
		rotate([0,90,90])
		cylinder(h=block_thickness+0.01, r=1, center=true, $fn=4);

		translate([0,block_thickness/2,-.5])
		rotate([90,0,90])
		cylinder(h=block_length+0.01, r=1, center=true, $fn=4);

		translate([0,-block_thickness/2,-.5])
		rotate([90,0,90])
		cylinder(h=block_length+0.01, r=1, center=true, $fn=4);
	}

	//posts for caps
	if (number_of_magnet_slots == 2){
		translate([0,0,1.5])
		cylinder(h=2,r=.75,center=true);
	}

	translate([block_length/2 - 2.5,0,1.5])
	cylinder(h=2,r=.75,center=true);

	translate([-block_length/2 + 2.5,0,1.5])
	cylinder(h=2,r=.75,center=true);
}
