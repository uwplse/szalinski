//	Thingiverse Customizer Template v1.2 by MakerBlock
//	http://www.thingiverse.com/thing:44090
//	v1.2 now includes the Build Plate library as well
//	v1.3 now has the cube sitting on the build platform - check out the source to see how!

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

//	This section is displays the box options
//	Measurement of box on the X axis
x_measurement = 10;	//	[5,10,20,25]

//	Measurement of box on the Y axis
y_measurement = 10;	//	[5:small, 10:medium, 20:large, 25:extra large]

//	Measurement of box on the Z axis
z_measurement = 10;	//	[5:25]

//	This section demonstrates how we can create various options

text_box = 10;

//	This is the explanation text
another_text_box = 10;

//	This creates a drop down box of numbered options
number_drop_down_box = 1;	//	[0,1,2,3,4,5,6,7,8,9,10]

//	This creates a drop down box of text options
text_drop_down_box = "yes";	//	[yes,no,maybe]

//	This creates a drop down box of text options with numerical values
labeled_drop_down_box = 5;	//	[1:small, 5:medium, 10:large, 50:supersized]

//	This creates a slider with a minimum and maximum
numerical_slider = 1;	//	[0:10]

//	This option will not appear
hidden_option = 100*1;

//	This option will also not appear
//	another_hidden_option = 101;

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//	This is the cube we've customized!
translate([0,0,z_measurement/2]) cube([x_measurement, y_measurement, z_measurement], center=true);
