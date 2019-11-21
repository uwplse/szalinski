// Thingiverse File Name: Customizable_Safe_House_Padlock_key.scad
// Belfry Filename: House_key_vBelfry_088.scad
// Author: Belfry ( John Gardner - JGPC )
// Date: 02/11/2013
// Phone: 901-366-9606
// Email: belfry6050@jgpc.net
// Web: www.thingiverse.com/belfry
// Last Update: 03/04/2013

// Project: A parametric key generator

// Supported types (so far ) - ( 5 cylinder house key , 4 cylinder padlock , 7 cylinder safe key )


// Creates a customized key (house,padlock,safe).


// use <MCAD/boxes.scad>
use <utils/build_plate.scad>
use <write/Write.scad>
//use <Write.scad>


// preview[view:south,tilt:top]

// let's create a way to check things out
//debug_flag = true;
debug_flag = false;

// ----- start of 'customizer' user options -----


//: Select the TYPE OF KEY to make
type_of_key = 0; //[0:5 Cylinder House Key,1:4 Cylinder Pad Lock,2:7 Cylinder Safe Key]
echo( "type_of_key" , type_of_key );

//: Select the KEY HEADER style to make
style_of_key = 1; //[0:Straight Header,1:Round (set by polygon count) Header]
echo ( "style_of_key" , style_of_key );

//: Print Quality-used by $fn parameter(s)
polygon_count = 6;	// [4:4 - No Text,5,6,7,8,9,10,11,12,16,20,24,28,32]
echo( "Print Quality / Polygon Count" , polygon_count );

//: Key Cutting Code (0-9 for each cylinder) leave blank for random key
keycutcode = "";
echo ( "keycutcode" , keycutcode );

//: Custom text to print in place of the key code
custom_key_text ="";
echo ( "custom_key_text" , custom_key_text );

//: Select the optimum value for your printer
print_layer_thickness = 1; //[0:0.30mm Thick Layers,1:0.29mm Thick Layers,2:0.28mm Thick Layers,3:0.27mm Thick Layers,4:0.26mm Thick Layers,5:0.25mm Thick Layers]
echo ( "print_layer_thickness" , print_layer_thickness );

//: Select the Number of Cutting Steps to use
cutting_steps = 7; //[7:Kwikset Standard (use only 0 to 6 for key_cut_code) 0.023inch/0.5842mm,10:10 Steps (use 0 to 9 for key_cut_code)];
echo ( "cutting_steps" , cutting_steps );

//: Adjust the height of the key ( -0.5mm to +0.5mm )
adjust_height = 0; // [-50:50]
//adjust_height = -26; // [-50:50]
echo ( "adjust_height" , adjust_height );


//---[ Build Plate ]----------------------------------------------------------

//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100 + 0;
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100 + 0;

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//-------------------------------------------------



// Key Cutting Code (0-9 for each cylinder)

//keycutcode = "8866";	//	silver padlock


//----- start of program 'constant' declarations -----


// define a value for 'pi'
pi_value = 3.14159 *1;	// pi
echo ( "Pi" , pi_value );

//define the 'belfry B' logo
belfry_b_logo = str( "B", "" );
echo ( "belfry_b_logo" , belfry_b_logo );

// define a 'fudge factor' ( see best practices - http://customizer.makerbot.com/best_practices )
fudge_factor = 0 + 0.001;
echo ( "fudge_factor" , fudge_factor );

// define a maximum cylinder count
maxcylindercount = 10+0;
echo( "maxcylindercount" , maxcylindercount );

// define an array of key cylinder counts
keycylindercount = [5,4,7];
echo ( "keycylindercount" , keycylindercount );

// Number of Cylinders
number_cylinders = keycylindercount[ type_of_key ];
echo ( "number_cylinders" , number_cylinders );

// define an array of print layer thickness
//layerthickness = [0.30,0.30,0.30];
layerthickness = [0.30,0.29,0.28,0.27,0.26,0.25];
echo ( "layerthickness" , layerthickness );

// print layer thickness
//layer_thickness = layerthickness[ type_of_key ];
layer_thickness = layerthickness[ print_layer_thickness ];
echo ( "layer_thickness" , layer_thickness );

// define an array of key blade lengths (x-dimension)
keybladelength = [29.00,18.50,13.00];
echo ( "keybladelength" , keybladelength );

// Length of the Blade ( shoulder to tip ) (x-dimension)
blade_length = keybladelength[ type_of_key ];
echo ( "blade_length" , blade_length );

// define an array of key blade heights (y-dimension)
keybladeheight = [8.35,7.25,9.50];	//	0.329inches -- 8.3566mm
//keybladeheight = [8.15,7.25,9.50];	//	0.329inches
echo ( "keybladeheight" , keybladeheight );

// Height of the Blade (y-dimension)
blade_height = keybladeheight[ type_of_key ] + (adjust_height/100);
echo ( "blade_height" , blade_height );

// define an array of 5 cylinder key blade layers thick
5cylkeybladelayers = [7,7,7,7,8,8];
echo ( "5cylkeybladelayers" , 5cylkeybladelayers );

// 5 cylinder key blade layers thick
5cyl_key_blade_layers = 5cylkeybladelayers[ print_layer_thickness ];
echo ( "5cyl_key_blade_layers" , 5cyl_key_blade_layers );

// define an array of key blade widths (z-dimension)
keybladewidth = [(5cyl_key_blade_layers*layer_thickness),(7*layer_thickness),0];	//	(2.1mm)-seven layers thick at 0.3mm thickness
echo ( "keybladewidth" , keybladewidth );

// Width of the Blade (z-dimension)
blade_width = keybladewidth[ type_of_key ];
echo ( "blade_width" , blade_width );


// define an array of height/size values for printing text
texthsize = [6.0,4.5,5.0];
echo( "texthsize" , texthsize );

// Height/Size of printed text ( 'write.scad' value ) 
text_h_size = texthsize[ type_of_key ];
echo ( "text_h_size" , text_h_size );



// --- front slot definitions------------------------------------

// define an array of front slot heights
frontslotheight = [1.60,0.00,0.00];
echo ( "frontslotheight" , frontslotheight );

// define an array of front slot y offset values
frontslotyoffset = [0.60,0.00,0.00];
echo ( "frontslotyoffset" , frontslotyoffset );

// define an array of 5 cylinder - front slot layers thick values
5cylfrontslotlayers = [3,3,3,3,4,4];
echo ( "5cylfrontslotlayers" , 5cylfrontslotlayers );

// 5 cylinder key - front slot layers thick
5cyl_front_slot_layers = 5cylfrontslotlayers[ print_layer_thickness ];
echo ( "5cyl_front_slot_layers" , 5cyl_front_slot_layers );

// define an array of front slot z offset values
frontslotzoffset = [(5cyl_front_slot_layers*layer_thickness),0.00,0.00];	//	0.90mm-at 0.30mm
echo ( "frontslotzoffset" , frontslotzoffset );


// Key Front Side Slot Height
key_fslot_height = frontslotheight[ type_of_key ];
echo ( "key_fslot_height" , key_fslot_height );

// Key Front Side Slot Y Offset
key_fslot_yoffset = frontslotyoffset[ type_of_key ];
echo ( "key_fslot_yoffset" , key_fslot_yoffset );

// Key Front Side Slot Z Offset
key_fslot_zoffset = frontslotzoffset[ type_of_key ];
echo ( "key_fslot_zoffset" , key_fslot_zoffset );


// --- back slot definitions------------------------------------

// define an array of back slot heights
backslotheight = [1.35,1.35,0.00];
echo ( "backslotheight" , backslotheight );

// define an array of back slot y offset values
backslotyoffset = [key_fslot_yoffset+key_fslot_height+0.50,1.00,0.00];
echo ( "backslotyoffset" , backslotyoffset );

// define an array of 5 cylinder - back slot layers thick values
5cylbackslotlayers = [2,3,3,3,3,3];
echo ( "5cylbackslotlayers" , 5cylbackslotlayers );

// 5 cylinder key - back slot layers thick
5cyl_back_slot_layers = 5cylbackslotlayers[ print_layer_thickness ];
echo ( "5cyl_back_slot_layers" , 5cyl_back_slot_layers );


// define an array of back slot z offset values
backslotzoffset = [-(5cyl_back_slot_layers*layer_thickness),-(2*layer_thickness),0.00];	// 0.60mm - at 0.30mm
echo ( "backslotzoffset" , backslotzoffset );

// define an array of back slot angle cut values
backslotangle = [210,210,0.00];
echo ( "backslotangle" , backslotangle );


// Key Back Side Slot Height
key_bslot_height = backslotheight[ type_of_key ];
echo ( "key_bslot_height" , key_bslot_height );

// Key Back Side Slot Y Offset
key_bslot_yoffset = backslotyoffset[ type_of_key ];
echo ( "key_bslot_yoffset" , key_bslot_yoffset );

// Key Back Side Slot Z Offset
key_bslot_zoffset = backslotzoffset[ type_of_key ];
echo ( "key_bslot_zoffset" , key_bslot_zoffset );

// Key Back Side Angle Value
key_bslot_angle = backslotangle[ type_of_key ];
echo ( "key_bslot_angle" , key_bslot_angle );


// --- top slot definitions------------------------------------

// define an array of top slot heights
topslotheight = [3.25,3.50,0.00];
echo ( "topslotheight" , topslotheight );

// define an array of 5 cylinder - top slot layers thick values
5cyltopslotlayers = [4,4,5,5,5,5];
echo ( "5cyltopslotlayers" , 5cyltopslotlayers );

// 5 cylinder key - top slot layers thick
5cyl_top_slot_layers = 5cyltopslotlayers[ print_layer_thickness ];
echo ( "5cyl_top_slot_layers" , 5cyl_top_slot_layers );

// define an array of top slot z offset values
topslotzoffset = [(5cyl_top_slot_layers*layer_thickness),(3*layer_thickness),0.00];	//	1.20mm-at 0.30mm
echo ( "topslotzoffset" , topslotzoffset );


// Key Top Slot Height
key_tslot_height = topslotheight[ type_of_key ] + (adjust_height/100);
echo ( "key_tslot_height" , key_tslot_height );

// Key Top Slot Z Offset
key_tslot_zoffset = topslotzoffset[ type_of_key ];
echo ( "key_tslot_zoffset" , key_tslot_zoffset );

// define an array of top slot angle cut values
topslotangle = [30,30,0.00];
echo ( "topslotangle" , topslotangle );

// Key Top Slot Angle Value
key_tslot_angle = topslotangle[ type_of_key ];
echo ( "key_tslot_angle" , key_tslot_angle );


// --- tip of key definitions - top ------------------------------------

// define an array of tip of the key - top angle rotation values
keytiptopangle = [45,50,0.00];
echo ( "keytiptopangle" , keytiptopangle );

// key tip - top angle rotation value
key_tip_topangle = keytiptopangle[ type_of_key ];
echo ( "key_tip_topangle" , key_tip_topangle );

// define an array of tip of the key - top y offset values
//keytiptopyoffset = [key_bslot_yoffset,(blade_height-key_tslot_height),0.00];
keytiptopyoffset = [key_fslot_yoffset+key_fslot_height,(blade_height-key_tslot_height),0.00];
echo( "keytiptopyoffset" , keytiptopyoffset );

// key tip - top y offset value
key_tip_topyoffset = keytiptopyoffset[ type_of_key ];
echo ( "key_tip_topyoffset" , key_tip_topyoffset );


// --- tip of key definitions - bottom ------------------------------------

// define an array of tip of the key - bottom angle rotation values
keytipbotangle = [225,225,0.00];
echo ( "keytipbotangle" , keytipbotangle );

// key tip - bottom angle rotation value
key_tip_botangle = keytipbotangle[ type_of_key ];
echo ( "key_tip_botangle" , key_tip_botangle );

// define an array of tip of the key - bottom y offset values
keytipbotyoffset = [key_bslot_yoffset,(blade_height/2),0.00];
echo( "keytipbotyoffset" , keytipbotyoffset );

// key tip - bottom y offset value
key_tip_botyoffset = keytipbotyoffset[ type_of_key ];
echo ( "key_tip_botyoffset" , key_tip_botyoffset );


// --- cylinder definitions --------------------------------------

// define an array of 1st cylinder offset values
firstcyloffset = [6.2738,5.00,0.00];	//	0.247inches(6.2738mm)
echo ( "firstcyloffset" , firstcyloffset );


//: Offset to 1st Cylinder ( shoulder to center )
first_offset = firstcyloffset[ type_of_key ];
echo ( "first_offset" , first_offset );


// define an array of distance between cylinder values
cylseparation = [3.81,3.00,0.00];	//	0.150inches(3.81mm)
echo ( "cylseparation" , cylseparation );


// Distance Between Cylinders ( center to center )
cylinder_separation = cylseparation[ type_of_key ];
echo ( "cylinder_separation" , cylinder_separation );

// define an array of diameter of cylinder pin values
cyldiameter = [2.921,1.00,0.00];	//	0.115inches(2.921mm)
echo ( "cyldiameter" , cyldiameter );

// Diameter of individual cylinder pins
key_cyl_diameter = cyldiameter[ type_of_key ];
echo ( "key_cyl_diameter" , key_cyl_diameter );

// define an array of cylinder pin bottom diameters
cylpinbotdiameter = [0.5,1.0,1.0];
echo ( "cylpinbotdiameter" , cylpinbotdiameter );

// cylinder pin bottom diameter
cyl_pin_bot_diameter = cylpinbotdiameter[ type_of_key ];
echo ( "cyl_pin_bot_diameter" , cyl_pin_bot_diameter );



// set the 'long' side of the top slot triangle value
tslot_long_side = (blade_width - key_tslot_zoffset);
echo ( "tslot_long_side" , tslot_long_side );

// calculate the short side of the top slot triangle
tslot_short_side = tslot_long_side * tan(30);
echo ( "tslot_short_side" , tslot_short_side );

// calculate the hypotenuse side of the top slot triangle
tslot_hypotenuse_side = sqrt(pow(tslot_long_side,2) + pow(tslot_short_side,2));
echo ( "tslot_hypotenuse_side" , tslot_hypotenuse_side );
 

// increment size for a 7 step (kwikset) cylinder
7step_cyl_increment_size = 0.5842+0;	//	increment size for a 7 step (kwikset) cylinder (0.023inches)
echo ( "7step_cyl_increment_size" , 7step_cyl_increment_size );

// increment size for a 10 step cylinder
10step_cyl_increment_size = (( key_tslot_height + tslot_short_side )/9);
echo ( "10step_cyl_increment_size" , 10step_cyl_increment_size );

// define an array of pin step height values 
pinstepheight = [ 0,0,0,0,0,0,0,7step_cyl_increment_size ,0,0,10step_cyl_increment_size ];
echo ( "pinstepheight" , pinstepheight );

// define an array of number of STEP values to use for each key type
numberofsteps = [cutting_steps,10,10];
echo ("numberofsteps" , numberofsteps );

// Number of pin STEPs
number_of_steps = numberofsteps[type_of_key];
echo ("number_of_steps" , number_of_steps);


// Number Lookup Array
number_lookup = str( "0123456789" , "" );
echo( "number_lookup" ,  number_lookup );

// Array of random key pin STEP values - 0 to (number_of_steps-1) for each cylinder
random_key_array = rands( 0 , (number_of_steps - .01), maxcylindercount + 1 );
//random_key_array = rands( 0 , 9.9 , number_cylinders + 1 );
echo( "random_key_array" , random_key_array );

// 10 'charcter' random number
random_key = str( floor( random_key_array[1] ) , floor( random_key_array[2] ) , floor( random_key_array[3] ) , floor( random_key_array[4] ) , floor( random_key_array[5] ) , floor( random_key_array[6] ) , floor( random_key_array[7] ) , floor( random_key_array[8] ) , floor( random_key_array[9] ) , floor( random_key_array[10] ) );
echo ( "random_key: " , random_key );


// Key Cutting Code (0-9 for each cylinder)
key_cut_code = str(keycutcode,random_key);	// random_key used if keycutcode is blank
echo ( "key_cut_code" , key_cut_code );


//	define an array of maximum cut depth values
maxcutdepth = [(key_tslot_height+tslot_short_side),(key_tslot_height+tslot_short_side),0];	//	array of maximum cut depths
echo ( "maxcutdepth" , maxcutdepth );

// 'maximum cut depth' for a cylinder
max_cut_depth = maxcutdepth[ type_of_key ];
echo ( "max_cut_depth" , max_cut_depth );

 
// define an array of cylinder pin STEP values
pinstep = [ pinstepheight[ cutting_steps ] , (key_tslot_height / 10) ,0.00];	// 0.023inch steps(0.5842mm)
echo ( "pinstep" , pinstep );

// Cylinder pin STEP value
pin_step = pinstep[ type_of_key ];
echo( "pin_step" , pin_step );

// define an array of straight key header lengths
straightlength = [27,22,0.00];	// mm
echo ( "straightlength" , straightlength );

// define the straight key length
straight_length = straightlength[ type_of_key ];
echo ( "straight_length" , straight_length );


//short_side = ( ( blade_width - key_tslot_yoffset ) / tan(60) );
//echo ( "short side" , short_side );

// define an array of how many layers thick to print the text
layersthick = [3,3,3];	//	number of layers thick
echo ( "layersthick" , layersthick );

// number of layers thick ( for printed text )
layers_thick = layersthick[ type_of_key ];
echo ( "layers_thick" , layers_thick );

// define an array of text separation values (mm)
textseparation = [4.0,3.5,3.8];	//	distance between text (mm)
echo ( "textseparation" , textseparation );

// distance between characters (mm)
text_separation = textseparation[ type_of_key ];
echo ( "text_separation" , text_separation );

// define an array of key ring hole radius values (mm)
keyringradius = [4.5,4.0,4.0];	//	radius of the hole (mm)
echo ( "keyringradius" , keyringradius );

// radius for the key ring hole
key_ring_radius = keyringradius[ type_of_key ];
echo ( "key_ring_radius" , key_ring_radius );

// define an array of key head diameter values (mm)
keyheaddiameter = [26,20,0];	//	diameter of the key head
echo ( "keyheaddiameter" , keyheaddiameter );

// diameter for the key head
key_head_diameter = keyheaddiameter[ type_of_key ];
echo ( "key_head_diameter" , key_head_diameter );






// ----- set up definitions for the 'safe' type of key ---------------------

safe_key_polygon_count=(128*1);	//	let's see if a higher number helps out with the print
echo ( "safe_key_polygon_count" , safe_key_polygon_count );

safe_key_outer_diameter=(9.95*1);	//	outer diameter of the key cylinder ( I measure it at 9.55mm
echo ( "safe_key_outer_diameter" , safe_key_outer_diameter );

safe_key_inner_diameter=(safe_key_outer_diameter-1.0);	//	inner diameter of the key cylinder ( I measure it at 8.05mm
echo ( "safe_key_inner_diameter" , safe_key_inner_diameter );

safe_key_outer_radius=(safe_key_outer_diameter/2);	//	outer radius of the key cylinder
echo ( "safe_key_outer_radius" , safe_key_outer_radius );

safe_key_inner_radius=(safe_key_inner_diameter/2);	//	inner radius of the key cylinder
echo ( "safe_key_inner_radius" , safe_key_inner_radius );

cylinder_pin_offset=((9.75/2)+0.3);
echo ( "cylinder_pin_offset" , cylinder_pin_offset );

safe_pin_xoffset = [0,cylinder_pin_offset,cylinder_pin_offset,0,0,-cylinder_pin_offset,-cylinder_pin_offset,0];
echo ( "safe_pin_xoffset" , safe_pin_xoffset );

safe_pin_yoffset = [0,0,0,-cylinder_pin_offset,-cylinder_pin_offset,0,0,cylinder_pin_offset];
echo ( "safe_pin_yoffset" , safe_pin_yoffset );

cylinder_z_rotation = [0,45,0,45,0,45,0,45];
echo ( "cylinder_z_rotation" , cylinder_z_rotation );

safe_key_pin_height = 5+0;
echo ( "safe_key_pin_height" , safe_key_pin_height );

safe_key_pin_radius = 1+0;
echo ( "safe_key_pin_radius" , safe_key_pin_radius );

safe_key_shoulder_height = 5+0;
echo ( "safe_key_shoulder_height" , safe_key_shoulder_height );





// ---[ Start of program ]-------------------------------------------------------
echo ( "start of the program" );
{

difference()
{
union()
{

create_key_blade();

			if ( debug_flag == false )
			{
create_key_shoulder();
create_key_header();

			}	//	end of if - ( debug_flag == false )

}	//	end of union

			if ( debug_flag == false )
			{

create_key_ringhole();

create_belfry_B();

			}	//	end of if - ( debug_flag == false )

} // end of difference



} // end of program

//----------------------------------------------------------------------------

echo ("end of program" );


// ---[ End of program ]------------------------------------------------------

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

// ---[ Start of module definitions ] ---

// ----- cut the main key slots (millings/grooves) module ---------------------
module cut_slots()
{
echo ( "cut the main key slots module" );

// ----- front slot setup -----
echo ( "front slot setup" );
front_slot();


// ----- back slot setup -----
echo ( "back slot setup" );
back_slot();


// ----- top slot setup -----
echo ( "top slot setup" );
top_slot();

}	//	end of module


// ----- front slot setup module ---------------------------------------------
module front_slot()
{
echo ( "front slot setup module" );
translate([-1,key_fslot_yoffset,key_fslot_zoffset]) cube( [ blade_length + 2 , key_fslot_height , blade_width ] );
}	//	end of module

// ----- back slot setup module ----------------------------------------------
module back_slot()
{
echo ( "back slot setup module" );

//	set length of short cube
short_cube = ( blade_width *2 );
echo ( "short_cube" , short_cube );

// calculate the short side
short_side_offset = ( short_cube * sin(30) );
echo ( "short_side_offset" , short_side_offset );

// calculate the long side
long_side_offset = ( short_cube * cos(30) );
echo ( "long_side_offset" , long_side_offset );

translate([-1,key_bslot_yoffset,key_bslot_zoffset])
{
union()
{

cube( [ blade_length + 2 , key_bslot_height , blade_width ] );

if ( key_bslot_angle != 0 )
{
//translate([0,key_bslot_height,blade_width]) rotate( [key_bslot_angle,0,0] ) cube( [ blade_length + 2 , key_bslot_height , blade_width * 2 ] );

translate([0,key_bslot_height,blade_width]) rotate( [key_bslot_angle,0,0] ) cube( [ blade_length + 2 , key_bslot_height , short_cube ] );

//translate([0,short_side_offset,-long_side_offset]) cube( [ blade_length + 2 , key_bslot_height , blade_width ] );

}	//	end of if
}	// end of union
}	// end of translate

}	//	end of module


// ----- top slot setup module ------------------------------------------------
module top_slot()
{
echo ( "top slot setup module" );
translate( [-1,blade_height-key_tslot_height,key_tslot_zoffset] )
{
union()
{

rotate( [key_tslot_angle,0,0] ) cube( [ blade_length + 2 , blade_height , blade_width * 2 ] );
cube( [ blade_length + 2 , blade_height  , blade_width * 2 ] );

}	// end of union
}	// end of translate
}	// end of module


// ----- cut off the tip of the blade -------------------------------------------
module cut_the_tip()
{
echo ( "cut off the tip of the blade module" );
union()
{
translate( [blade_length,key_tip_topyoffset,-1] ) rotate( [0,0,key_tip_topangle] ) cube( blade_height *1.5 );

translate( [blade_length+1,key_tip_botyoffset+1,-1] ) rotate( [0,0,key_tip_botangle] ) cube( blade_height );
}	// end of union
}	//	end of module


// ----- cylinder cutting loop --------------------------------------------------- 
module cut_cylinders( total_cylinders = 1 )
{
echo ( "start of cylinder cutting loop for" , total_cylinders , "cylinders" );
for ( cyl_loop = [1 : total_cylinders] )
{

	echo(str("cylinder:" , cyl_loop , " - key_cut_code:" , key_cut_code[cyl_loop-1]));

	pin_position( what_str_digit = key_cut_code[cyl_loop-1] , what_cyl = cyl_loop );


}  // end of loop

}	// end of module


// --- Create Master Teeth Objects ------------------------------------------
module create_master_teeth(tooth_number=1,tooth_step=0)
{

echo ( "create_master_teeth" , tooth_number , tooth_step );

difference()
{

translate([(first_offset) + ((tooth_number-1)*cylinder_separation),blade_height-cylinder_separation,-1]) rotate( [0 , 0 , 45] )cube([blade_height,blade_height,blade_width+2]);

translate([(first_offset) + ((tooth_number-1)*cylinder_separation)-blade_height,-min(tooth_step,max_cut_depth),-1]) cube([blade_height*2,blade_height,blade_width+2]);

}	//	end of difference
}	//	end of module


// --- Set the position of a cylinder pin ---------------------------------------------
module pin_position( what_str_digit = "0" , what_cyl = 1 )
{

echo( "Cylinder: " , what_cyl , "Digit: " , what_str_digit );

//for ( value_lookup = [0:9] )
for ( value_lookup = [1:9] )
{

if ( what_str_digit == number_lookup[value_lookup] )
{
echo( "match found: " , value_lookup , what_str_digit );

create_master_teeth(tooth_number=what_cyl,tooth_step=(value_lookup*pin_step));


}	// end of if

}	// end of for loop

}	// end of module


//-------------------------------------------------------------------------
module straight_key_header( sheader_length = 25 , sheader_text = "0123456789" )
{
echo ( "sheader_length" , sheader_length );
echo ( "sheader_text" , sheader_text );

translate([(-1*sheader_length)+fudge_factor,0,0])
{
union()
{

// ----- basic straight key head setup -----
cube( [ sheader_length , blade_height  , blade_width ] );	// main key header


// ----- print the text ------------------------------------------------------

for ( sdigit_loop = [0:number_cylinders-1] )
{
	echo ( "sdigit_loop" , sdigit_loop , "text" , sheader_text[sdigit_loop] );

	translate([(text_separation+(text_separation*sdigit_loop)),1,blade_width-fudge_factor]) write(sheader_text[sdigit_loop],h=text_h_size,t=(layer_thickness*layers_thick));

}	//	end of for loop

}	//	end of union

}	// end of translate

}	// end of module


//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
module round_key_header( rheader_diameter = 25 , rheader_text = "0123456789" )
{
echo ( "rheader_diameter" , rheader_diameter );
echo ( "rheader_text" , rheader_text );

if ( type_of_key <= 1 )
{
translate([(-1*rheader_diameter)+fudge_factor,0,0])
{

translate([(rheader_diameter/2),(blade_height/2),0]) cylinder( h=blade_width , r=rheader_diameter/2 , center = false , $fn=polygon_count);	//	round header for key


if ( polygon_count > 4 )
{

// let's rotate the text
rotate([0,0,90]) union()
{


// ----- add the 'key code' ------------------------------------------------------
for ( rdigit_loop = [0:number_cylinders-1] )
{
	echo ( "rdigit_loop" , rdigit_loop , "text" , rheader_text[rdigit_loop] );

//	translate([(text_separation*(rdigit_loop+1))+(blade_height/2)-(rheader_diameter	

translate([(text_separation*rdigit_loop)+(blade_height/2)-(rheader_diameter/2)+(text_h_size/2),-(rheader_diameter/2)-(text_h_size),blade_width-fudge_factor]) write(rheader_text[rdigit_loop],h=text_h_size,t=(layer_thickness*layers_thick));

}	//	end of for loop

}	// end of translate

}	//	end of union

}	//	end of polygon_count

}	//	end of if - ( type_of_key <= 1 )

}	// end of module



// ----- create text to be printed module-----------------------------------------------
module create_text( text_to_print="Belfry 6050" )
{

echo ( "text_to_print" , text_to_print );

write(text_to_print,h=text_h_size,t=(layer_thickness*layers_thick));

}	//	end of module



//----- 5 cylinder house key shoulder ------------------------------------------
module five_cyl_housekey_shoulder()
{
echo ( "5 cylinder house key shoulder" );

translate([fudge_factor-blade_height,-(blade_height*0.25),0])
cube([blade_height,(blade_height*1.5),blade_width]);
}

//----- 4 cylinder padlock key shoulder ----------------------------------------
module four_cyl_padlock_shoulder()
{
echo ( "4 cylinder padlock key shoulder" );

translate([fudge_factor-blade_height,0,0])
cube([blade_height,(blade_height*1.25),blade_width]);
}

//----- 7 cylinder safe key shoulder ----------------------------------------
module seven_cyl_safe_shoulder()
{
echo ( "7 cylinder safe key shoulder" );

translate([0,0,0])
cylinder(r1=safe_key_outer_radius*1.5,r2=safe_key_outer_radius,h=safe_key_shoulder_height,$fn=safe_key_polygon_count);

}



//----- create a 'key blade' ------------------------------------------------------
module create_key_blade()
{

echo ( "start of the create_key_blade module" );

if ( type_of_key <= 1 )
{

echo ( "start of the difference function" );
difference()
{

// ----- main blade setup -----
echo ( "main blade setup" );
cube( [ blade_length , blade_height , blade_width ] );	// main key blade

// ----- cut the main key slots -----
echo ( "cut the main key slots" );
cut_slots()

// ----- cut off the tip of the blade -----
echo ( "cut off the tip of the blade" );
cut_the_tip();

// ----- cylinder cutting loop --------------------------------------------------- 
echo ( "start cutting" , number_cylinders , "cylinders" );
cut_cylinders( total_cylinders = number_cylinders );

} // end of difference


}	//	end of if - ( type_of_key <= 1 )

if ( type_of_key == 2 )
{

safe_key_blade();

}	//	end of if - ( type_of_key == 2 )

}	//	end of module


//----- create a 'shoulder' for the key ------------------------------------------
module create_key_shoulder()
{
echo ( "start of create_key_shoulder module" );

if ( style_of_key > 0 )
{
	if ( type_of_key == 0 )
		five_cyl_housekey_shoulder();

	if ( type_of_key == 1 )
		four_cyl_padlock_shoulder();

}	//	end of if

if ( type_of_key == 2 )
	seven_cyl_safe_shoulder();

}	//	end of module


//------- create the cylinder used to cut a hole in the key ----------------
module create_key_ring_hole()
{
echo( "key_ring_radius for cylinder" , key_ring_radius );
if ( style_of_key > 0 )
{
	// create the cylinder used for cutting a hole for a key ring
	cylinder( h=blade_width*3 , r=key_ring_radius , center = true , $fn=polygon_count);	//	hole for key ring

}	//	end of if
}	//	end of module


//------ create a key header object ----------------------------------------
module create_key_header()
{

if ( type_of_key < 2 )
{

if ( style_of_key == 0 )
{
// create a basic 'straight' key header
straight_key_header(sheader_length=straight_length,sheader_text=str(custom_key_text,key_cut_code));
}	// end of if

if ( style_of_key == 1 )
{
// create a 'round' key header
round_key_header(rheader_diameter=key_head_diameter,rheader_text=str(custom_key_text,key_cut_code));
}	// end of if


}	//	end of if - ( type_of_key < 2 )


//	create a 'safe' key (round) header
if ( type_of_key == 2 )
{
safe_key_round_header();
}

}	//	end of module


//-------------------------------------------------------------------------
//------- put a hole in the key header for a key chain ring ----------------
module create_key_ringhole()
{
if ( style_of_key > 0 )
{
if ( polygon_count == 5 )
{

	if ( type_of_key == 0 )
{
	translate([(-1*(key_head_diameter))+(key_ring_radius*2)-2,(blade_height/2),0]) create_key_ring_hole();
}
else
{
	translate([((-1*(key_head_diameter))+ key_ring_radius + 2 ),(blade_height/2),0]) create_key_ring_hole();

}	//	end of if
}
else
{
	translate([((-1*(key_head_diameter))+ key_ring_radius + 2 ),(blade_height/2),0]) create_key_ring_hole();

}	//	end of if

}	//	end of if


}	//	end of module

//----- create the Belfry 'B' on the back of the key ----------------------
module create_belfry_B()
{

//----- straight key headers -----
//	straight key header - ( style_of_key == 0 ) 

if ( style_of_key == 0 )	//	straight key header
{

	translate([-15,0.75,(layer_thickness*3)]) rotate([0,180,270])
{

// print the Belfry 'B' on the back

	if (type_of_key == 0 )	//	5 cyl house key
{
		write(belfry_b_logo,h=10,t=layer_thickness*4);
}	//	end of if

	if (type_of_key == 1)	//	4 cyl padlock
{
		write(belfry_b_logo,h=9,t=layer_thickness*4);
}	//	end of if

}	//	end of translate

}	//	end of if - ( style_of_key == 0 )




//----- round key headers -----
//	round key header - ( style_of_key == 1 ) 
if ( style_of_key == 1 )	//	round key header
{

	if ( type_of_key == 0 )	//	5 cyl house key
{
// print the Belfry 'B' on the back
		translate([-2.5,7,(layer_thickness*3)]) rotate([0,180,90]) write(belfry_b_logo,h=10,t=(layer_thickness*4));

}	// end of if - type_of_key



	if ( type_of_key == 1 )	//	4 cyl padlock
{
// print the Belfry 'B' on the back
		translate([-0.75,6,(layer_thickness*3)]) rotate([0,180,90]) write(belfry_b_logo,h=8,t=(layer_thickness*4));
}	//	end of if - ( type_of_key == 1 )



}	//	end of if - ( round key headers )



//----- safe key shoulder -----
if ( type_of_key == 2 ) // 7 cyl safe key
{
// print the Belfry 'B' on the bottom / back of the 'shoulder'
		translate([2.5,-5,(layer_thickness*3)]) rotate([180,0,180]) write(belfry_b_logo,h=10,t=(layer_thickness*4));

// print the Belfry 'B' on the top of the 'shoulder'
		translate([-1.5,-3,safe_key_shoulder_height-(layer_thickness*3)]) rotate([0,0,0]) write(belfry_b_logo,h=6.0,t=(layer_thickness*4));

}	//	end of if - ( type_of_key == 2 )




}	//	end of module




//----- Create a cylinder for a 'safe' key -------------------------------

module safe_key_blade()
{

translate([0,0,(safe_key_shoulder_height-fudge_factor)])
{

union()
{
difference()
{
translate([0,safe_key_inner_radius+0.50,(blade_length-1)/2]) cube([1.2,2.5,blade_length-1],center=true);
translate([0,safe_key_inner_radius+1.50+fudge_factor,(blade_length-5)]) cube([2,3.0,4.0],center=true);
}	//	end of difference()
}	//	end of union

difference()
{
cylinder( h=blade_length,r=safe_key_outer_radius,$fn=safe_key_polygon_count);

translate([0,0,-1]) cylinder( h=blade_length+2,r=safe_key_inner_radius,$fn=safe_key_polygon_count);

echo ("blade_length" , blade_length );

// cut out some test cylinders

// time to cut out the key slots
// looking at the cut end - guide pointing up - go clockwise from the top

for ( safe_cylinder_count = [1:7] )
{
echo ( "safe_cylinder_count" , safe_cylinder_count );


//  cut a safe key cylinder pin
cut_safe_key_pin( what_safe_cyl = safe_cylinder_count , what_safe_digit = key_cut_code[safe_cylinder_count-1] );


}	//	end of for - safe_cylinder_count


}	//	end of difference

}	//	end of translate




if ( custom_key_text == "" )
{
// reverse the order of the numbers - to match the cylinders from the top
writecylinder(h=6.0,text=str(key_cut_code[6],key_cut_code[5],key_cut_code[4],key_cut_code[3],key_cut_code[2],key_cut_code[1],key_cut_code[0]),where=[0,0,9],radius=(safe_key_outer_radius),height=blade_length,rotate=0,center=true,space=1.0);
}
else
{
writecylinder(h=6.0,text=custom_key_text,where=[0,0,9],radius=(safe_key_outer_radius),height=blade_length,rotate=0,center=true,space=1.0);
}



}	//	end of module - safe_key_blade()


//-------------------------------------------------------------------------


// --- Cut a safe key cylinder pin -----------------------------------------
module cut_safe_key_pin( what_safe_cyl = 1 , what_safe_digit = "0" )
{

echo( "Safe Cylinder Digit: " , what_safe_digit );
echo( "Safe Cylinder:" , what_safe_cyl , "Cylinder Digit: " , what_safe_digit );

for ( safe_value_lookup = [1:9] )
{

if ( what_safe_digit == number_lookup[safe_value_lookup] )
{
echo( "safe key cylinder match found: " , safe_value_lookup , what_safe_digit , what_safe_cyl );


//  cut a safe key cylinder pin
//rotate([0,0,cylinder_z_rotation[what_safe_cyl]]) translate([safe_pin_xoffset[what_safe_cyl],safe_pin_yoffset[what_safe_cyl],blade_length-(layer_thickness*safe_value_lookup)]) cylinder( h=safe_key_pin_height,r=safe_key_pin_radius,$fn=safe_key_polygon_count);

// make cuts using a cube instead of a cylinder
rotate([0,0,cylinder_z_rotation[what_safe_cyl]]) translate([safe_pin_xoffset[what_safe_cyl],safe_pin_yoffset[what_safe_cyl],((safe_key_pin_height/2)+blade_length)-(layer_thickness*safe_value_lookup)]) cube( [safe_key_pin_radius*2,safe_key_pin_radius*2,safe_key_pin_height] , center=true);


}	// end of if

}	// end of for loop

}	// end of module

//-------------------------------------------------------------------------


//----- Create a 'round' header for a 'safe' key -------------------------------

module safe_key_round_header()
{
cylinder( h=(blade_length/6),r=safe_key_outer_radius*2.5,$fn=polygon_count);

}

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------

