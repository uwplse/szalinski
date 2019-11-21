// Filename: House_key_vBelfry_068.scad
// Author: Belfry ( John Gardner - JGPC )
// Date: 02/11/2013
// Phone: 901-366-9606
// Email: belfry6050@jgpc.net
// Web: www.thingiverse.com/belfry

// Project: A parametric key generator

// Supported types (so far ) - ( 5 cylinder house key and 4 cylinder padlock )


// Creates a customized key.


// use <MCAD/boxes.scad>
use <utils/build_plate.scad>
use <write/Write.scad>
//use <Write.scad>

// ----- start of 'customizer' user options -----


//: Select the TYPE OF KEY to make
type_of_key = 0; //[0:5 Cylinder House Key,1:4 Cylinder Pad Lock]
echo( "type_of_key" , type_of_key );

//: Select the KEY HEADER style to make
style_of_key = 1; //[0:Straight Header,1:Round (set by polygon count) Header]
echo ( "style_of_key" , style_of_key );

//: Print Quality-used by $fn parameter(s)
polygon_count = 5;	// [4,5,6,7,8,9,10,11,12,16,20,24,28,32]
echo( "Print Quality / Polygon Count" , polygon_count );

//: Key Cutting Code (0-9 for each cylinder) leave blank for random key
keycutcode = "";
echo ( "keycutcode" , keycutcode );

//: Custom text to print in place of the key code
custom_key_text ="";
echo ( "custom_key_text" , custom_key_text );

// ----- end of 'customizer' user options -----
dummycall();	// make sure no more stuff shows up in 'customizer' (?)


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
//keycutcode = "6644";	//	silver padlock
//keycutcode = "7755";	 //	silver padlock
//keycutcode = "9977";	//	silver padlock
//keycutcode = "3277";

//keycutcode = "19909";
//keycutcode = "33626";

//keycutcode = "";
//keycutcode = "00000"; // should create a 'blank' key???
//keycutcode = "99999"; // should create a 'bump' key???
//key_cut_code = keycutcode;	// use this for the user entered value
//key_cut_code = random_key;	// comment this line out - for 'user entered' values to work

//key_cut_code = "000007777123499999";



//----- start of program 'constant' declarations -----


// define a value for 'pi'
pi_value = 3.14159 *1;	// pi
echo ( "Pi" , pi_value );

// define a 'fudge factor' ( see best practices - http://customizer.makerbot.com/best_practices )
fudge_factor = 0 + 0.001;
echo ( "fudge_factor" , fudge_factor );

// define a maximum cylinder count
maxcylindercount = 10+0;
echo( "maxcylindercount" , maxcylindercount );

// define an array of key cylinder counts
keycylindercount = [5,4];
echo ( "keycylindercount" , keycylindercount );

// Number of Cylinders
number_cylinders = keycylindercount[ type_of_key ];
echo ( "number_cylinders" , number_cylinders );

// define an array of print layer thickness
layerthickness = [0.30,0.30];
echo ( "layerthickness" , layerthickness );

// print layer thickness
layer_thickness = layerthickness[ type_of_key ];
echo ( "layer_thickness" , layer_thickness );

// define an array of key blade lengths (x-dimension)
keybladelength = [28.50,18.50];
echo ( "keybladelength" , keybladelength );

// Length of the Blade ( shoulder to tip ) (x-dimension)
blade_length = keybladelength[ type_of_key ];
echo ( "blade_length" , blade_length );

// define an array of key blade heights (y-dimension)
keybladeheight = [8.30,7.25];
echo ( "keybladeheight" , keybladeheight );

// Height of the Blade (y-dimension)
blade_height = keybladeheight[ type_of_key ];
echo ( "blade_height" , blade_height );

// define an array of key blade widths (z-dimension)
keybladewidth = [(7*layer_thickness),(7*layer_thickness)];	//	(2.1mm)-seven layers thick at 0.3mm thickness
echo ( "keybladewidth" , keybladewidth );

// Width of the Blade (z-dimension)
blade_width = keybladewidth[ type_of_key ];
echo ( "blade_width" , blade_width );


// define an array of height/size values for printing text
texthsize = [5.5,4.5];
echo( "texthsize" , texthsize );

// Height/Size of printed text ( 'write.scad' value ) 
text_h_size = texthsize[ type_of_key ];
echo ( "text_h_size" , text_h_size );

// Number Lookup Array
number_lookup = str( "0123456789" , "" );
echo( "number_lookup" ,  number_lookup );


// Array of random key pin STEP values ( 0 to 9.9 for each cylinder )
random_key_array = rands( 0 , 9.9 , maxcylindercount + 1 );
//random_key_array = rands( 0 , 9.9 , number_cylinders + 1 );
echo( "random_key_array" , random_key_array );

// 10 'charcter' random number
random_key = str( floor( random_key_array[1] ) , floor( random_key_array[2] ) , floor( random_key_array[3] ) , floor( random_key_array[4] ) , floor( random_key_array[5] ) , floor( random_key_array[6] ) , floor( random_key_array[7] ) , floor( random_key_array[8] ) , floor( random_key_array[9] ) , floor( random_key_array[10] ) );
echo ( "random_key: " , random_key );


// Key Cutting Code (0-9 for each cylinder)
key_cut_code = str(keycutcode,random_key);	// random_key used if keycutcode is blank
echo ( "key_cut_code" , key_cut_code );



// --- front slot definitions------------------------------------

// define an array of front slot heights
frontslotheight = [1.65,0.00];
echo ( "frontslotheight" , frontslotheight );

// define an array of front slot y offset values
frontslotyoffset = [0.60,0.00];
echo ( "frontslotyoffset" , frontslotyoffset );

// define an array of front slot z offset values
frontslotzoffset = [(3*layer_thickness),0.00];	//	0.90mm-at 0.30mm
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
backslotheight = [1.35,1.35];
echo ( "backslotheight" , backslotheight );

// define an array of back slot y offset values
backslotyoffset = [2.75,1.00];
echo ( "backslotyoffset" , backslotyoffset );

// define an array of back slot z offset values
backslotzoffset = [-(2*layer_thickness),-(2*layer_thickness)];	// 0.60mm - at 0.30mm
echo ( "backslotzoffset" , backslotzoffset );

// define an array of back slot angle cut values
backslotangle = [210,210];
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
topslotheight = [3.50,3.50];
echo ( "topslotheight" , topslotheight );

// define an array of top slot z offset values
topslotzoffset = [(4*layer_thickness),(3*layer_thickness)];	//	1.20mm-at 0.30mm
echo ( "topslotzoffset" , topslotzoffset );


// Key Top Slot Height
key_tslot_height = topslotheight[ type_of_key ];
echo ( "key_tslot_height" , key_tslot_height );

// Key Top Slot Z Offset
key_tslot_zoffset = topslotzoffset[ type_of_key ];
echo ( "key_tslot_zoffset" , key_tslot_zoffset );

// define an array of top slot angle cut values
topslotangle = [30,30];
echo ( "topslotangle" , topslotangle );

// Key Top Slot Angle Value
key_tslot_angle = topslotangle[ type_of_key ];
echo ( "key_tslot_angle" , key_tslot_angle );


// --- tip of key definitions - top ------------------------------------

// define an array of tip of the key - top angle rotation values
keytiptopangle = [58,50];
echo ( "keytiptopangle" , keytiptopangle );

// key tip - top angle rotation value
key_tip_topangle = keytiptopangle[ type_of_key ];
echo ( "key_tip_topangle" , key_tip_topangle );

// define an array of tip of the key - top y offset values
keytiptopyoffset = [(key_bslot_yoffset+key_bslot_height),(blade_height-key_tslot_height)];
echo( "keytiptopyoffset" , keytiptopyoffset );

// key tip - top y offset value
key_tip_topyoffset = keytiptopyoffset[ type_of_key ];
echo ( "key_tip_topyoffset" , key_tip_topyoffset );


// --- tip of key definitions - bottom ------------------------------------

// define an array of tip of the key - bottom angle rotation values
keytipbotangle = [225,225];
echo ( "keytipbotangle" , keytipbotangle );

// key tip - bottom angle rotation value
key_tip_botangle = keytipbotangle[ type_of_key ];
echo ( "key_tip_botangle" , key_tip_botangle );

// define an array of tip of the key - bottom y offset values
keytipbotyoffset = [key_bslot_yoffset,(blade_height/2)];
echo( "keytipbotyoffset" , keytipbotyoffset );

// key tip - bottom y offset value
key_tip_botyoffset = keytipbotyoffset[ type_of_key ];
echo ( "key_tip_botyoffset" , key_tip_botyoffset );


// --- cylinder definitions --------------------------------------

// define an array of 1st cylinder offset values
firstcyloffset = [6.00,5.00];
echo ( "firstcyloffset" , firstcyloffset );


//: Offset to 1st Cylinder ( shoulder to center )
first_offset = firstcyloffset[ type_of_key ];
echo ( "first_offset" , first_offset );


// define an array of distance between cylinder values
cylseparation = [4.00,3.00];
echo ( "cylseparation" , cylseparation );


// Distance Between Cylinders ( center to center )
cylinder_separation = cylseparation[ type_of_key ];
echo ( "cylinder_separation" , cylinder_separation );

// define an array of width of cylinder pin values
cylwidth = [2.00,1.00];
echo ( "cylwidth" , cylwidth );


// Width of individual cylinder pins
key_cyl_width = cylwidth[ type_of_key ];
echo ( "key_cyl_width" , key_cyl_width );


// define an array of cylinder pin STEP values
pinstep = [(key_tslot_height / 10), (key_tslot_height / 10) ];
echo ( "pinstep" , pinstep );


// Cylinder pin STEP value
pin_step = pinstep[ type_of_key ];
echo( "pin_step" , pin_step );


// define an array of straight key header lengths
straightlength = [27,22];	// mm
echo ( "straightlength" , straightlength );

// define the straight key length
straight_length = straightlength[ type_of_key ];
echo ( "straight_length" , straight_length );


//short_side = ( ( blade_width - key_tslot_yoffset ) / tan(60) );
//echo ( "short side" , short_side );

// define an array of how many layers thick to print the text
layersthick = [3,3];	//	number of layers thick
echo ( "layersthick" , layersthick );

// number of layers thick ( for printed text )
layers_thick = layersthick[ type_of_key ];
echo ( "layers_thick" , layers_thick );

// define an array of text separation values (mm)
textseparation = [3.8,3.5];	//	distance between text (mm)
echo ( "textseparation" , textseparation );

// distance between characters (mm)
text_separation = textseparation[ type_of_key ];
echo ( "text_separation" , text_separation );

// define an array of key ring hole radius values (mm)
keyringradius = [4.5,4.0];	//	radius of the hole (mm)
echo ( "keyringradius" , keyringradius );

// radius for the key ring hole
key_ring_radius = keyringradius[ type_of_key ];
echo ( "key_ring_radius" , key_ring_radius );

// define an array of key head diameter values (mm)
keyheaddiameter = [25,20];	//	diameter of the key head
echo ( "keyheaddiameter" , keyheaddiameter );

// diameter for the key head
key_head_diameter = keyheaddiameter[ type_of_key ];
echo ( "key_head_diameter" , key_head_diameter );


// ---[ Start of program ]-------------------------------------------------------
echo ( "start of the program" );
{

difference()
{
union()
{

create_key_blade();
create_key_shoulder();
create_key_header();

}	//	end of union

create_key_ringhole();

create_belfry_B();

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
translate([-1,key_bslot_yoffset,key_bslot_zoffset])
{
union()
{

cube( [ blade_length + 2 , key_bslot_height , blade_width ] );

if ( key_bslot_angle != 0 )
{
translate([0,key_bslot_height,blade_width]) rotate( [key_bslot_angle,0,0] ) cube( [ blade_length + 2 , key_bslot_height , blade_width * 2 ] );
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
translate( [blade_length,key_tip_topyoffset,-1] ) rotate( [0,0,key_tip_topangle] ) cube( blade_height );
translate( [blade_length,key_tip_botyoffset,-1] ) rotate( [0,0,key_tip_botangle] ) cube( blade_height );
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


// --- Key Cylinder Cutout ---------------------------------------------------
module key_cyl_cutout( cylinder_number = 1 )
{
echo ("Key Cylinder Cutout Shape for Cylinder:" , cylinder_number );

union()
{
translate([(first_offset-(key_cyl_width/2)) + ((cylinder_number-1)*cylinder_separation) ,blade_height,-1]) cube([key_cyl_width,blade_height,blade_width+2 ]);

translate([(first_offset-(key_cyl_width/2)) + ((cylinder_number-1)*cylinder_separation),blade_height,-1]) rotate( [0 , 0 , 45] )cube([blade_height,blade_height,blade_width+2]);

translate([(first_offset+(key_cyl_width/2)) + ((cylinder_number-1)*cylinder_separation),blade_height,-1]) rotate( [0 , 0 , 45] )cube([blade_height,blade_height,blade_width+2]);

} // end of union
}


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

translate([0,(-1*(value_lookup*pin_step)),0]) key_cyl_cutout(cylinder_number=what_cyl);

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

	translate([(text_separation*(rdigit_loop+1))+(blade_height/2)-(rheader_diameter/2),-(rheader_diameter/2)-(text_h_size),blade_width-fudge_factor]) write(rheader_text[rdigit_loop],h=text_h_size,t=(layer_thickness*layers_thick));

}	//	end of for loop

}	// end of translate

}	//	end of union

}	//	end of polygon_count

}	// end of module



// ----- create text to be printed module-----------------------------------------------
module create_text( text_to_print="Belfry 6050" )
{

echo ( "text_to_print" , text_to_print );

write(text_to_print,h=text_h_size,t=(layer_thickness*layers_thick));

}	//	end of module

//----- dummycall module -------------------------------------------------------
module dummycall()
{
echo ( "dummycall" );
}


//----- 5 cylinder house key shoulder ------------------------------------------
module five_cyl_housekey_shoulder()
{
translate([fudge_factor-blade_height,-(blade_height*0.25),0])
cube([blade_height,(blade_height*1.5),blade_width]);
}

//----- 4 cylinder padlock key shoulder ----------------------------------------
module four_cyl_padlock_shoulder()
{
translate([fudge_factor-blade_height,0,0])
cube([blade_height,(blade_height*1.25),blade_width]);
}



//----- create a 'key blade' ------------------------------------------------------
module create_key_blade()
{

echo ( "start of the create_key_blade module" );

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

	translate([-15,0.5,(layer_thickness*3)]) rotate([0,180,270])
{

// print the Belfry 'B' on the back

	if (type_of_key == 0 )	//	5 cyl house key
{
		write("B",h=11,t=layer_thickness*4);
}	//	end of if

	if (type_of_key == 1)	//	4 cyl padlock
{
		write("B",h=10,t=layer_thickness*4);
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
		translate([-1.25,7,(layer_thickness*3)]) rotate([0,180,90]) write("B",h=11,t=(layer_thickness*4));

}	// end of if - type_of_key



	if ( type_of_key == 1 )	//	4 cyl padlock
{
// print the Belfry 'B' on the back
		translate([-0.75,6,(layer_thickness*3)]) rotate([0,180,90]) write("B",h=8,t=(layer_thickness*4));
}	//	end of if - ( type_of_key == 1 )



}	//	end of if - ( round key headers )



}	//	end of module





//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------

