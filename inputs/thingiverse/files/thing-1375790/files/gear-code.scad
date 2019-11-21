use <MCAD/involute_gears.scad>

00_build_plate = 0; //[0:Replicator 2,1:Replicator,3:Thing-o-Matic]

01_number_of_teeth = 53;

//Controls the size of the teeth (and hence the size of the gear)
02_circular_pitch =  180;

//Controls the shape of the teeth
03_pressure_angle = 21;

//The gap between the root between teeth and the teeth point on a meshing gear
04_clearance = 1;

//the thickness of the gear plate
05_gear_thickness = 8;

//the thickness of the gear at the rim (including the teeth)
06_rim_thickness = 9;

//radial distance from the root of the teeth to the inside of the rim
07_rim_width = 3;

//the thickness of the section around the bore
08_hub_thickness = 8;


09_hub_diameter = 5;

//size of the hole in the middle
10_bore_diameter = 5;


//the number of circular holes to cut in the gear plate
11_circles = 0;

//the space between this the back of this gears teeth and the front of its meshing gear's teeth when the gear is correctly spaced from it
12_backlash = .5;

//for making helical gears
13_twist = 0;

//the number of facets in one side of the involute tooth shape. If this is omitted it will be 1/4 of $fn. If $fn is not set, it will be 5.
14_involute_facets = 20;




//top gear settings
21_number_of_teeth = 9;

//Controls the size of the teeth (and hence the size of the gear)
22_circular_pitch =  300;

//Controls the shape of the teeth
23_pressure_angle = 21;

//The gap between the root between teeth and the teeth point on a meshing gear
24_clearance = 1;

//the thickness of the gear plate
25_gear_thickness = 20;

//the thickness of the gear at the rim (including the teeth)
26_rim_thickness = 13;

//radial distance from the root of the teeth to the inside of the rim
27_rim_width = 5;

//the thickness of the section around the bore
28_hub_thickness = 20;


29_hub_diameter = 5;

//size of the hole in the middle
20_bore_diameter = 5;


//the number of circular holes to cut in the gear plate
21_circles = 0;

//the space between this the back of this gears teeth and the front of its meshing gear's teeth when the gear is correctly spaced from it
22_backlash = .5;

//for making helical gears
23_twist = 0;

//the number of facets in one side of the involute tooth shape. If this is omitted it will be 1/4 of $fn. If $fn is not set, it will be 5.
24_involute_facets = 20;




//create gears

gear(	number_of_teeth = 01_number_of_teeth,
		circular_pitch =  02_circular_pitch,
		pressure_angle = 03_pressure_angle,
		clearance = 04_clearance,
		gear_thickness = 05_gear_thickness,
		rim_thickness = 06_rim_thickness,
		rim_width = 07_rim_width,
		hub_thickness = 08_hub_thickness,
		hub_diameter = 09_hub_diameter,
		bore_diameter = 10_bore_diameter,
		circles = 11_circles,
		backlash = 12_backlash,
		twist = 13_twist,
		involute_facets = 14_involute_facets
);
/*

translate([0,0,-.5]){
	if(00_build_plate == 0){
		%cube([285,153,1],center = true);
	}
	if(00_build_plate == 1){
		%cube([225,145,1],center = true);
	}
	if(00_build_plate == 3){
		%cube([120,120,1],center = true);
	}

}

*/


translate([0,0,08_hub_thickness-1]){

gear(	number_of_teeth = 21_number_of_teeth,
		circular_pitch =  22_circular_pitch,
		pressure_angle = 23_pressure_angle,
		clearance = 24_clearance,
		gear_thickness = 25_gear_thickness,
		rim_thickness = 26_rim_thickness,
		rim_width = 27_rim_width,
		hub_thickness = 28_hub_thickness,
		hub_diameter = 29_hub_diameter,
		bore_diameter = 20_bore_diameter,
		circles = 21_circles,
		backlash = 22_backlash,
		twist = 23_twist,
		involute_facets = 24_involute_facets
);

}

