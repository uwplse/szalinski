// DICE
// by peanut
// July 2014

// license:
// CC-BY-SA
// http://creativecommons.org/licenses/by-sa/4.0/

//###########################################################

dice_size = 15;

part = 1;		//[1:solid, 2:hollow 1, 3:hollow 2]

//try values between 6 and 20
number_size_divider = 10.5;

//only needed by part = hollow 2
number_perimeter_width = 0.4;

//small dice needs higher resolution
resolution = 2;		//[0:high, 1:medium, 2:low, 3:ultra low]

$fs=0.18*(resolution + 1);
$fa=360/(130/(resolution + 1));

//###########################################################

if (part == 1)
	dice(dice_size,dice_size/number_size_divider);

if (part ==2)
	intersection(){
		numbers(dice_size,dice_size/number_size_divider);
		cube(dice_size,center=true);
	}

if (part ==3)
	difference(){
		intersection(){
			numbers(dice_size,dice_size/number_size_divider);
			cube(dice_size,center=true);
		}
	numbers(dice_size,dice_size/number_size_divider-number_perimeter_width);
	}

//###########################################################

module dice(size,number_hole_r){
	difference(){
	//base
		intersection(){
			cube(size,center=true);
			sphere(r = sqrt(pow(size/2,2)*2));
		}
	numbers(size=size,number_hole_r=number_hole_r);
	}	
}

module numbers(size,number_hole_r){
hole_distance = size/4;
//one
	translate([0,0,-size/2])
		sphere(r=number_hole_r);
//two
	translate([size/2,hole_distance,-hole_distance])
		sphere(r=number_hole_r);
	translate([size/2,-hole_distance,hole_distance])
		sphere(r=number_hole_r);
//three
	translate([hole_distance,size/2,-hole_distance])
		sphere(r=number_hole_r);
	translate([0,size/2,0])
		sphere(r=number_hole_r);
	translate([-hole_distance,size/2,hole_distance])
		sphere(r=number_hole_r);
//four
	translate([hole_distance,-size/2,-hole_distance])
		sphere(r=number_hole_r);
	translate([hole_distance,-size/2,hole_distance])
		sphere(r=number_hole_r);
	translate([-hole_distance,-size/2,hole_distance])
		sphere(r=number_hole_r);
	translate([-hole_distance,-size/2,-hole_distance])
		sphere(r=number_hole_r);
//five
	translate([-size/2,0,0])
		sphere(r=number_hole_r);
	translate([-size/2,hole_distance,-hole_distance])
		sphere(r=number_hole_r);
	translate([-size/2,hole_distance,hole_distance])
		sphere(r=number_hole_r);
	translate([-size/2,-hole_distance,hole_distance])
		sphere(r=number_hole_r);
	translate([-size/2,-hole_distance,-hole_distance])
		sphere(r=number_hole_r);
//six
	translate([hole_distance,-hole_distance,size/2])
		sphere(r=number_hole_r);
	translate([hole_distance,hole_distance,size/2])
		sphere(r=number_hole_r);
	translate([0,hole_distance,size/2])
		sphere(r=number_hole_r);
	translate([-hole_distance,hole_distance,size/2])
		sphere(r=number_hole_r);
	translate([-hole_distance,-hole_distance,size/2])
		sphere(r=number_hole_r);
	translate([0,-hole_distance,size/2])
		sphere(r=number_hole_r);
}