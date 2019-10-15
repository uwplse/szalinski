// Thingiverse File Name: Five_Cylinder_House_Key.scad
// Author: Belfry ( John Gardner )
// Date: 08/16/2018
// Phone: 720-980-6802
// Email: belfry6050@jgpc.net
// Web: www.thingiverse.com/belfry
// Last Update: 09/01/2018
// Version: 022

// Create a customized 5 cylinder (Kwikset) house key

// external files
use <utils/build_plate.scad>
use <write/Write.scad>
//use <Write.scad>

// preview[view:south,tilt:top]

// let's create a way to check things out
//debug_flag = true;
debug_flag = false;

// ----- start of 'customizer' user options -----

//: Determines the shape of the key header
polygon_count = 6;	// [3,4,5,6,7,8,9,10,11,12,16,20,24,28,32]
echo( "Polygon Count" , polygon_count );

//: Key Cutting Code (1-7 for each cylinder) leave blank for random key
cut_depth = "";
//cut_depth = "77777";
echo( "cut_depth" , cut_depth );

//: Custom text to print in place of the key code
custom_key_text ="";
//custom_key_text ="Home ";
echo( "custom_key_text" , custom_key_text );

//: Thickness of the Blade (z-dimension)
blade_thickness = 1.9;  // [1.7,1.8,1.9,2.0,2.1]
echo( "blade_thickness" , blade_thickness );

//---[ Build Plate ]-----------------------------------

//: for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100 + 0;
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100 + 0;

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//-------------------------------------------------

module dummy_call()
{
    echo( "module: dummy_call()" );
}
dummy_call();  //  end of customizer user options???

//----- start of program 'constant' declarations -----

text_height = 0.9;

in2mm = 25.4;
echo( "in2mm" , in2mm );

// Set the Number of Cutting Steps
cutting_steps = 7; //Kwikset standard - 0.023inch:0.5842mm;
echo( "cutting_steps" , cutting_steps );

// --- cylinder definitions -----------------------

// Diameter of individual cylinder pins
key_cyl_diameter = ( 0.115 * in2mm );
echo( "key_cyl_diameter" , key_cyl_diameter );

// cylinder pin bottom diameter
cyl_pin_bot_diameter = ( 0.084 * in2mm );
echo( "cyl_pin_bot_diameter" , cyl_pin_bot_diameter );

// spacing between cylinders
cyl_spacing = ( 0.150 * in2mm );
echo( "cyl_spacing" , cyl_spacing );

// distance from the "shoulder" to the "first cut"
first_cut = ( 0.247 * in2mm );
echo( "first_cut" , first_cut );

cylinder_spacing = [ first_cut , first_cut + cyl_spacing , first_cut + ( cyl_spacing * 2 ) , first_cut + ( cyl_spacing * 3 ) , first_cut + ( cyl_spacing * 4 ) ];
echo( "cylinder_spacing" , cylinder_spacing );

// Key Cutting Codes (1-7 for each cylinder)
step_size = ( 0.023 * in2mm );
echo( "step_size" , step_size );

depth1 = ( 0.329 * in2mm );
echo( "depth1" , depth1 );

depth2 = depth1 - step_size;
echo( "depth2" , depth2 );

depth3 = depth2 - step_size;
echo( "depth3" , depth3 );

depth4 = depth3 - step_size;
echo( "depth4" , depth4 );

depth5 = depth4 - step_size;
echo( "depth5" , depth5 );

depth6 = depth5 - step_size;
echo( "depth6" , depth6 );

depth7 = depth6 - step_size;
echo( "depth7" , depth7 );

depth_array = [ depth1 , depth2 , depth3 , depth4 , depth5 , depth6 , depth7 ];
echo( "depth_array" , depth_array );

size1 = 15;
echo( "size1" , size1 );

flat_tip = ( cyl_pin_bot_diameter / 2 );
echo( "flat_tip" , flat_tip );

// define a value for 'pi'
pi_value = 3.14159 *1;	// pi
echo( "Pi" , pi_value );

//define the 'belfry B' logo
belfry_b_logo = str( "B", "" );
echo( "belfry_b_logo" , belfry_b_logo );

// Number of Cylinders
number_of_cylinders =  5;
echo( "number_of_cylinders" , number_of_cylinders );

// Length of the Blade ( shoulder to tip ) (x-dimension)
blade_length = 29.3;
echo( "blade_length" , blade_length );

// Width of the Blade (y-dimension)
blade_width = ( 0.335 * in2mm );
echo( "blade_width" , blade_width );

// Height/Size of printed text ( 'write.scad' value ) 
text_h_size = 6.0;
echo( "text_h_size" , text_h_size );

// --- front slot definitions -------------------

// Key Front Side Slot Width
key_fslot_width = 1.60;
echo( "key_fslot_width" , key_fslot_width );

// Key Front Side Slot Y Offset
key_fslot_yoffset = 0.60;
echo( "key_fslot_yoffset" , key_fslot_yoffset );

// Key Front Side Slot Z Offset
key_fslot_zoffset = 0.60;
echo( "key_fslot_zoffset" , key_fslot_zoffset );

// --- back slot definitions --------------------

// Key Back Side Slot Width
key_bslot_width = 1.35;
echo( "key_bslot_width" , key_bslot_width );

// Key Back Side Slot Y Offset
key_bslot_yoffset = key_fslot_yoffset+key_fslot_width+0.60;
echo( "key_bslot_yoffset" , key_bslot_yoffset );

// Key Back Side Slot Z Offset
key_bslot_zoffset = -0.6;
echo( "key_bslot_zoffset" , key_bslot_zoffset );

// Key Back Side Angle Value
key_bslot_angle = 210;
echo( "key_bslot_angle" , key_bslot_angle );

// --- top slot definitions -----------------

// Key Top Slot Width
key_tslot_width = 3.25;
echo( "key_tslot_width" , key_tslot_width );

// Key Top Slot Z Offset
key_tslot_zoffset = 1.0;
echo( "key_tslot_zoffset" , key_tslot_zoffset );

// Key Top Slot Angle Value
key_tslot_angle = 30;
echo( "key_tslot_angle" , key_tslot_angle );

// --- tip of key definitions - top -----------

// key tip - top angle rotation value
key_tip_topangle = 45;
echo( "key_tip_topangle" , key_tip_topangle );

// key tip - top y offset value
key_tip_topyoffset = key_fslot_yoffset+key_fslot_width;
echo( "key_tip_topyoffset" , key_tip_topyoffset );

// --- tip of key definitions - bottom --------

// key tip - bottom angle rotation value
key_tip_botangle = 225;
echo( "key_tip_botangle" , key_tip_botangle );

// key tip - bottom y offset value
key_tip_botyoffset = key_bslot_yoffset;
echo( "key_tip_botyoffset" , key_tip_botyoffset );

// set the 'long' side of the top slot triangle value
tslot_long_side = (blade_thickness - key_tslot_zoffset);
echo( "tslot_long_side" , tslot_long_side );

// calculate the short side of the top slot triangle
tslot_short_side = tslot_long_side * tan(30);
echo( "tslot_short_side" , tslot_short_side );

// calculate the hypotenuse side of the top slot triangle
tslot_hypotenuse_side = sqrt(pow(tslot_long_side,2) + pow(tslot_short_side,2));
echo( "tslot_hypotenuse_side" , tslot_hypotenuse_side );

// Number Lookup Array
number_lookup = str( "0123456789" , "" );
echo( "number_lookup" ,  number_lookup );

// Array of random key pin STEP values - 1 to (cutting_steps+1) for each cylinder
random_key_array = rands( 1 , (cutting_steps+1) , number_of_cylinders );
echo( "random_key_array" , random_key_array );

// 5 'character' random number
random_key = str( floor( random_key_array[0] ) , floor( random_key_array[1] ) , floor( random_key_array[2] ) , floor( random_key_array[3] ) , floor( random_key_array[4] ) );
echo( "random_key: " , random_key );

// Key Cutting Code (1-7 for each cylinder)
key_cut_code = str(cut_depth,random_key);	// random_key used if cut_depth is blank
// random_key used if cut_depth is blank
echo( "key_cut_code" , key_cut_code );

// distance between characters (mm)
text_separation = 4.0;
echo( "text_separation" , text_separation );

// radius for the key ring hole
key_ring_radius = 4.5;
echo( "key_ring_radius" , key_ring_radius );

// diameter for the key head
key_head_diameter = 26;
echo( "key_head_diameter" , key_head_diameter );



// ---[ Start of program ]--------------------------------
echo( "start of the program ===============" );
{
    create_a_key_blank();
    
    translate(([-(key_head_diameter/2),(blade_width/2),0]))
    rotate([0,0,90])
    difference()
    {
        union()
        {
            // create a key header
            create_key_header( header_diameter=key_head_diameter );
            create_key_shoulder();
        }	//	end of union
        create_key_ringhole();
        create_belfry_B();
    } // end of difference
} // ---[ end of program ] --------------------------------
echo( "end of program ===============" );

// ---[ End of program ]-------------------------------

// ---[ Start of module definitions ] ---

// ----- create a key blank object
module create_a_key_blank()
{
    echo( "module: create_a_key_blank()" );
    difference()
    {
        // ----- main blade setup -----
        echo( "main blade setup" );
        cube( [ blade_length , blade_width , blade_thickness ] );	// main key blade


       // ----- cut the main key slots -----
        echo( "cut the main key slots" );
        cut_slots()

         // ----- cut off the tip of the blade -----
        echo( "cut off the tip of the blade" );
        cut_the_tip();
    
        // ----- cylinder cutting loop -------------
        echo( "start cutting" , number_of_cylinders , "cylinders" );
        cut_cylinders( total_cylinders = number_of_cylinders );

    } // end of difference
}

// ----- cylinder cutting loop --------------------------------------------------- 
module cut_cylinders( total_cylinders = 1 )
{
    echo( "module: cut_cylinders()" );
    echo( "start of cylinder cutting loop for" , total_cylinders , "cylinders" );
    for ( cyl_loop = [1 : total_cylinders] )
    {
        echo(str("cylinder:" , cyl_loop , " - key_cut_code:" , key_cut_code[cyl_loop-1]));
        cut_a_cylinder( cylinder_number = cyl_loop , cutter_depth = key_cut_code[cyl_loop-1] );
    }  // end of for loop
}	// end of module

// ----- cut a cylinder
module cut_a_cylinder( cylinder_number = 1 , cutter_depth = "1" )
{
    echo( "module: cut_a_cylinder()" );   
    echo( "cylinder_number" , cylinder_number );
    echo( "cutter_depth" , cutter_depth );

    if ( ( cylinder_number >= 1 )  && ( cylinder_number <= number_of_cylinders ) )
    {
        if ( cutter_depth == "1" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(1);
        }
        
        if ( cutter_depth == "2" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(2);
        }
       
        if ( cutter_depth == "3" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(3);
        }
       
        if ( cutter_depth == "4" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(4);
        }
       
        if ( cutter_depth == "5" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(5);
        }
       
        if ( cutter_depth == "6" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(6);
        }
       
        if ( cutter_depth == "7" )
        {
            translate([cylinder_spacing[cylinder_number-1],0,0])
            create_depth_cut(7);
        }
    }
}

// ----- create a cutter for the key
module create_depth_cut( cut_depth = 1 )
{
    echo( "module: create_depth_cut()" );
    echo( "cut_depth" , cut_depth );

    if ( ( cut_depth >= 1 ) && ( cut_depth <=7 ) )
    {
        translate([0,depth_array[cut_depth-1],0])
        {
            translate([0,-flat_tip,0])
            difference()
            {
                translate([0,0,-1])
                rotate([0,0,45])
                cube([size1,size1,size1/3]);

                translate([-size1/2,-(size1-flat_tip),-size1/2])
                cube(size1);
            }  // end of difference
        }  // end of translate
    };  // end of if
}

// ----- cut the main key slots (millings/grooves) module ---------------------
module cut_slots()
{
    echo( "module: cut_slots()" );

    // ----- front slot setup -----
    echo( "front slot setup" );
    front_slot();

    // ----- back slot setup -----
    echo( "back slot setup" );
    back_slot();

    // ----- top slot setup -----
    echo( "top slot setup" );
    top_slot();

}	//	end of module

// ----- front slot setup module ---------------------------------------------
module front_slot()
{
    echo( "module: front_slot()" );
    translate([-1,key_fslot_yoffset,key_fslot_zoffset]) 
    cube( [ blade_length + 2 , key_fslot_width , blade_thickness ] );
}	//	end of module

// ----- back slot setup module ----------------------------------------------
module back_slot()
{
    echo( "module: back_slot()" );

    //	set length of short cube
    short_cube = ( blade_thickness *2 );
    echo( "short_cube" , short_cube );

    // calculate the short side
    short_side_offset = ( short_cube * sin(30) );
    echo( "short_side_offset" , short_side_offset );

    // calculate the long side
    long_side_offset = ( short_cube * cos(30) );
    echo( "long_side_offset" , long_side_offset );

    translate([-1,key_bslot_yoffset,key_bslot_zoffset])
    {
        union()
        {
            cube( [ blade_length + 2 , key_bslot_width , blade_thickness ] );
            translate([0,key_bslot_width,blade_thickness])
            {
                rotate( [key_bslot_angle,0,0] ) 
                cube( [ blade_length + 2 , key_bslot_width , short_cube ] );
            }  // end of translate
        }	// end of union
    }	// end of translate
}	//	end of module

// ----- top slot setup module ------------------------------------------------
module top_slot()
{
    echo( "module: top_slot()" );
    translate( [-1,blade_width-key_tslot_width,key_tslot_zoffset] )
    {
        union()
        {
            rotate( [key_tslot_angle,0,0] ) cube( [ blade_length + 2 , blade_width , blade_thickness * 2 ] );
            cube( [ blade_length + 2 , blade_width  , blade_thickness * 2 ] );
        }	// end of union
    }	// end of translate
}	// end of module


// ----- cut off the tip of the blade -------------------------------------------
module cut_the_tip()
{
    echo( "module: cut_the_tip()" );
    echo( "cut off the tip of the blade module" );
    union()
    {
        translate( [blade_length,key_tip_topyoffset,-1] )
            rotate( [0,0,key_tip_topangle] )
            cube( blade_width *1.5 );

        translate( [blade_length+0,key_tip_botyoffset+1,-1] )
            rotate( [0,0,key_tip_botangle] )
            cube( blade_width );
    }	// end of union
}	//	end of module

// ----- key header -------------------
module create_key_header( header_diameter = 25 )
{
    echo( "module: create_key_header()" );
    echo( "header_diameter" , header_diameter );

    rotate([0,0,90])
    cylinder( h=blade_thickness , r=header_diameter/2 , center = false , $fn=polygon_count);	// header for key

    translate([-( (number_of_cylinders * text_separation ) / 2 ),-(text_h_size),blade_thickness])
    if (len(custom_key_text)==0)
    {
        key_header_text( header_text = key_cut_code );
    }
    else
    {
        key_header_text( header_text = custom_key_text );
    }
}  //  end of module

// ----- key header text ---------------
module key_header_text( header_text = "0123456789" )
{
    echo( "module: key_header_text()" );
    echo( "header_text" , header_text );
    
    if ( polygon_count >= 6 )
    {
        // ----- add the 'key code' -----
        for ( rdigit_loop = [0:number_of_cylinders-1] )
        {
            echo( "rdigit_loop" , rdigit_loop , "text" , header_text[rdigit_loop] );
            translate([(text_separation*rdigit_loop),0,0]) 
            write(header_text[rdigit_loop],h=text_h_size,t=text_height);
        }  //  end of for loop
    }
}  //  end of module

//----- create a 'shoulder' for the key --------------
module create_key_shoulder()
{
    echo( "module: create_key_shoulder()" );

    translate([-((blade_width*1.5)/2),-(key_head_diameter/2),0])
    cube([(blade_width*1.5),blade_width,blade_thickness]);
}	//	end of module

//------- put a hole in the key header for a key chain ring ----------------
module create_key_ringhole()
{
    echo( "module: create_key_ringhole()" );

    //create_key_ring_hole();
    translate([0,key_ring_radius+1,0]) 
    rotate([0,0,90])
    cylinder( h=blade_thickness*3 , r=key_ring_radius , center = true , $fn=polygon_count);	
}	//	end of module


//----- create the Belfry 'B' on the back of the key ----------------------
module create_belfry_B()
{
    echo( "module: create_belfry_b()" );

    // print the Belfry 'B' on the back
    translate([2.5,-10,text_height-0.001]) 
    rotate([0,180,0]) 
    write(belfry_b_logo,h=10,t=text_height);
}	//	end of module

//-------------------------------------------------------
