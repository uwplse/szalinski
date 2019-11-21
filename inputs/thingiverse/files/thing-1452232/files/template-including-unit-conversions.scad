//	based off of:
//	Thingiverse Customizer Template v1.2 by MakerBlock
//  which can be found here:
//	http://www.thingiverse.com/thing:44090

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES
/* [Adjusting the block] */
//by having the /*[name of what you want shown]*/ you can make the drop down menu

//	This section is displays the box options
//	Measurement of box on the X axis
x_measurement = 5;	//	[1,5,10,15,20,25]
//	This creates a drop down box of numbered options

//	Measurement of box on the Y axis
y_measurement = 5;	//	[1:small, 5:medium small, 10:medium, ,15:medium large, 20:large, 25:extra large]
//	This creates a drop down box of text options with numerical values

//	Measurement of box on the Z axis
z_measurement = 5;	//	[1:25]
//	This creates a slider with a minimum and maximum

/* [Misc Demonstrations] */
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

//	This option will not appear due to the *1
hidden_option = 100*1;

//	This option will also not appear
//	another_hidden_option = 101;

/* [Adjusting the build plate] */
//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//as a bonus I also want to show my unit conversion option
/* [Unit adjustment] */
//Here are they units you deisgn in
units_entered = 10;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//and this is the unit the file is out put in, the default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]
//CUSTOMIZER VARIABLES END

//this allows you to just multiply the units in here by this factor to adjust size, in the example case, cm to mm
unit_conversion_factor = units_entered*desired_units_for_output;

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//	This is the cube we've customized!
translate([0,0,z_measurement/2*unit_conversion_factor]) cube([x_measurement, y_measurement, z_measurement]*unit_conversion_factor, center=true);
