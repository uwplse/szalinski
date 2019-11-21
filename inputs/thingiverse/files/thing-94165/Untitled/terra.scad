//	Thingiverse Customizer Template v1.2 by MakerBlock
//	http://www.thingiverse.com/thing:44090
//	v1.2 now includes the Build Plate library as well

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

//	Diameter of the base
base_diameter = 100;

//	Thickness of the base
base_height = 2;

//	Wall Thickness
wall_thickness = 2;

// Height
height = 20;

// Bottom Diameter
bottom_diameter = 95;

// Top Diameter
top_diameter = 90;


//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

top_radius = top_diameter / 2;
bottom_radius = bottom_diameter / 2;
base_radius = base_diameter / 2;

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

cylinder(base_height, base_radius, base_radius);

difference() { translate([0,0,base_height]) cylinder(height,bottom_radius, top_radius);  translate([0,0,base_height]) cylinder(height + 1,bottom_radius - wall_thickness, top_radius - wall_thickness); }