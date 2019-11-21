// Thingiverse File Name: Customizable_Tower_of_3D.scad
// Belfry Filename: Belfry_Tower_of_3D_Badges_v026.scad
// Author: Belfry ( John Gardner - JGPC )
// Date: 03/08/2013
// Phone: 901-366-9606
// Email: belfry6050@jgpc.net
// Web: www.thingiverse.com/belfry
// Last Update: 03/16/2013

// Project: A parametric Tower of 3D Badge Builder
// Name(potentially): Wacky Stacky - Tower of 3D Badges (how high can you stack?)

use <MCAD/boxes.scad>
use <utils/build_plate.scad>
use <write/Write.scad>


// preview[view:front]

// let's create a way to check things out
//debug_flag = true;
debug_flag = false;

// ----- start of 'customizer' user options -----

//: How Many Badges To Stack
stack_this_high = 4; //[1,2,3,4,5,6,7,8,9,10]
echo ( "stack_this_high" , stack_this_high );

//: Initial Cube Size (20 to 125mm)
initial_cube_size = 80; //[20:125]
echo ( "initial_cube_size" , initial_cube_size );

//: Custom Text on Left Side
left_side_text = "6050";
echo ( "left_side_text" , left_side_text );

//: Custom Text on Right Side
right_side_text = "T o M";
echo ( "right_side_text" , right_side_text );

//: Custom Text on Back Side
back_side_text = str("B","");
echo ( "back_side_text" , back_side_text );

//: Show Badge Count
show_badge_count=false; //[true:True,false:False]
echo ( "show_badge_count" , show_badge_count );

//: Set Rotation Direction
rotate_this_way=1; //[1:Counter-Clockwise,0:None,-1:Clockwise]
echo ( "rotate_this_way" , rotate_this_way );

//: Window Cutout Size (50 to 95%)
window_cutout_size = 75; //[50:95]
echo ( "initial_cube_size" , initial_cube_size );

//: Select the size of the stacking pylons
pylon_size = 100; //[25:200]
echo ( "pylon_size" , pylon_size );

//: Select the Z-Height Stretch Percentage
zstretch = 25; //[15:200]
echo( "zstretch" , zstretch );

//: Print Quality-used to round off the corners
polygon_count = 16;	// [4,8,12,16,20,24,28,32]
echo( "Print Quality / Polygon Count" , polygon_count );

//: Select the optimum value for your printer
print_layer_thickness = 3+0; //[0:0.30mm Thick Layers,1:0.29mm Thick Layers,2:0.28mm Thick Layers,3:0.27mm Thick Layers,4:0.26mm Thick Layers,5:0.25mm Thick Layers]
echo ( "print_layer_thickness" , print_layer_thickness );


//---[ Build Plate ]----------------------------------------------------------

//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100 + 0;
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100 + 0;

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//-------------------------------------------------






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

// define an array of print layer thickness
//layerthickness = [0.30,0.30,0.30];
layerthickness = [0.30,0.29,0.28,0.27,0.26,0.25];
echo ( "layerthickness" , layerthickness );

// print layer thickness
//layer_thickness = layerthickness[ type_of_key ];
layer_thickness = layerthickness[ print_layer_thickness ];
echo ( "layer_thickness" , layer_thickness );

// initial cube size
cubex=initial_cube_size;
cubey=initial_cube_size;
cubez=initial_cube_size*(zstretch/100);

echo ( "cubex" , cubex , "cubey" , cubey , "cubez" , cubez );

cut_size=1.25*1;
echo ( "cut_size" , cut_size );


//howthick=.75;	//	percentage
howthick=(window_cutout_size/100);	//	percentage
echo ( "howthick" , howthick );

edgehowthick=(1-((1-howthick)/2));
echo ( "edgehowthick" , edgehowthick );

cubeholex=cubex*cut_size;
cubeholey=cubey*howthick;
cubeholez=cubez*howthick;
echo ( "cubeholex" , cubeholex , "cubeholey" , cubeholey , "cubeholez" , cubeholez );

cubeholex1=cubex*howthick;
cubeholey1=cubey*cut_size;
cubeholez1=cubez*howthick;
echo ( "cubeholex1" , cubeholex1 , "cubeholey1" , cubeholey1 , "cubeholez1" , cubeholez1 );


cubeholex2=cubex*edgehowthick;
cubeholey2=cubey*edgehowthick;
cubeholez2=cubez*cut_size;
echo ( "cubeholex2" , cubeholex2 , "cubeholey2" , cubeholey2 , "cubeholez2" , cubeholez2 );


//example: roundedBox([size], radius, sidesonly);

corner_radius=(1-((1-edgehowthick)/2));
echo ( "corner_radius" , corner_radius );

// might want to make this an adjustable value
scale_factor=0.75*1;
echo ( "scale_factor" , scale_factor );

// define an array of badge z-offset values (1-10)
badge_zoffset = [0,0,
calc_pylon_height(for_badge_level=1),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4)+
	calc_pylon_height(for_badge_level=5),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4)+
	calc_pylon_height(for_badge_level=5)+
	calc_pylon_height(for_badge_level=6),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4)+
	calc_pylon_height(for_badge_level=5)+
	calc_pylon_height(for_badge_level=6)+
	calc_pylon_height(for_badge_level=7),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4)+
	calc_pylon_height(for_badge_level=5)+
	calc_pylon_height(for_badge_level=6)+
	calc_pylon_height(for_badge_level=7)+
	calc_pylon_height(for_badge_level=8),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4)+
	calc_pylon_height(for_badge_level=5)+
	calc_pylon_height(for_badge_level=6)+
	calc_pylon_height(for_badge_level=7)+
	calc_pylon_height(for_badge_level=8)+
	calc_pylon_height(for_badge_level=9),

calc_pylon_height(for_badge_level=1)+
	calc_pylon_height(for_badge_level=2)+
	calc_pylon_height(for_badge_level=3)+
	calc_pylon_height(for_badge_level=4)+
	calc_pylon_height(for_badge_level=5)+
	calc_pylon_height(for_badge_level=6)+
	calc_pylon_height(for_badge_level=7)+
	calc_pylon_height(for_badge_level=8)+
	calc_pylon_height(for_badge_level=9)+
	calc_pylon_height(for_badge_level=10)

];
echo ( "badge_zoffset" , badge_zoffset );


// ---[ Start of program ]-------------------------------------------------------
echo ( "<<<<<<<<<<<<<<<<<<<  start of the program >>>>>>>>>>>>>>>>>>>>>>" );
{

// start stacking thing up!

for ( tower_count=[1:stack_this_high] )
{
	echo("tower_count",tower_count);
	make_this_badge( badge_number = tower_count );
}





			if ( debug_flag == false )
			{

			}	//	end of if - ( debug_flag == false )


			if ( debug_flag == false )
			{


			}	//	end of if - ( debug_flag == false )




} // end of program

//----------------------------------------------------------------------------

echo ("end of program" );


// ---[ End of program ]------------------------------------------------------

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

// ---[ Start of module definitions ] ---

//-------------------------------------------------------------------------

module start_with_a_cube(include_towers=true,badgecount=1)
{
echo ( "start_with_a_cube() module" );

difference()
{

union()
{
badge_top_cube();

translate([0,0,(fudge_factor-(cubez*scale_factor))])
	badge_bottom_cube();

}	//	end of union()

// ----- put the '3D' imprint on the front -----
translate([0,-((cubey/2)+(0.25*(cubey*(1-edgehowthick)))),-(cubez*0.75)+(0.50*(cubez*(1-edgehowthick)))]) write("3D",center=true,rotate=[90,0,0],h=(cubez*0.50),t=cubex*(1-edgehowthick));


if ( show_badge_count == true )
{
// ----- put the Belfry 'B' imprint on the back (or custom text)-----
translate([0,((cubey/2)+(0.25*(cubey*(1-edgehowthick)))),-(cubez*0.75)+(0.50*(cubez*(1-edgehowthick)))]) write(str(back_side_text,badgecount),center=true,rotate=[90,0,180],h=(cubez*0.50),t=cubex*(1-edgehowthick));
}	//	else if
else
{
// ----- put the Belfry 'B' imprint on the back (or custom text)-----
translate([0,((cubey/2)+(0.25*(cubey*(1-edgehowthick)))),-(cubez*0.75)+(0.50*(cubez*(1-edgehowthick)))]) write(back_side_text,center=true,rotate=[90,0,180],h=(cubez*0.50),t=cubex*(1-edgehowthick));
}	//	end of if

// ----- put the 'custom' text imprint on the left side -----
translate([-((cubey/2)+(0.25*(cubey*(1-edgehowthick)))),0,-(cubez*0.75)+(0.50*(cubez*(1-edgehowthick)))]) write(str(left_side_text),center=true,rotate=[90,0,270],h=(cubez*0.50),t=cubex*(1-edgehowthick));

// ----- put the 'custom' text imprint on the right side -----
translate([((cubey/2)+(0.25*(cubey*(1-edgehowthick)))),0,-(cubez*0.75)+(0.50*(cubez*(1-edgehowthick)))]) write(str(right_side_text),center=true,rotate=[90,0,90],h=(cubez*0.50),t=cubex*(1-edgehowthick));



}	//	end of difference()

if (include_towers == true )
{
cylinder_towers();
}	//	end if

}	//	end of module - start_with_a_cube()

//-------------------------------------------------------------------------

// ----- bottom portion of the badge -----
module badge_bottom_cube()
{

difference()
{

roundedBox( [cubex,cubey,(cubez*0.50)] , cubex*(1-(corner_radius)) , true , $fn=polygon_count );

translate( [0,0,fudge_factor-((cubez*(1-edgehowthick))*0.50)] )
	cube([cubeholex2,cubeholey2,(cubez*0.50)],center=true);

}	//	end of difference

// ----- create the 3D center pedastal cube -----
translate([0,0,(cubez*0.25)+((cubez*(1-edgehowthick))/2)-fudge_factor])
	roundedBox( [((cubex*edgehowthick)*0.50),((cubey*edgehowthick)*0.50),(cubez*(1-edgehowthick))] , ((cubex*edgehowthick)*0.50)*(1-(corner_radius)) , true , $fn=polygon_count );

translate([0,0,(cubez*0.25)+((cubez*(1-edgehowthick))*1.5)-(fudge_factor*2)]) write("3D",center=true,t=(cubez*(1-edgehowthick)),h=(((cubey*edgehowthick)*0.50)*0.70));

}	//	end of module - badge_bottom_cube()

//-------------------------------------------------------------------------

// ----- top portion of the badge -----
module badge_top_cube()
{
echo ("module badge_top_cube()");

difference()
{

roundedBox([cubex,cubey,cubez], cubex*(1-(corner_radius)), true , $fn=polygon_count);

// cut out the holes through the sides (x,y axis) of the cube
translate([0,0,0]) cube( [cubeholex,cubeholey,cubeholez] , center=true );
translate([0,0,0]) cube( [cubeholex1,cubeholey1,cubeholez1] , center=true );

// cut the hole through the z-axis of the cube
cube([cubeholex2,cubeholey2,cubeholez2],center=true );

}	//	end of difference

}	//	end of module - badge_top_cube()

//-------------------------------------------------------------------------

// ----- cylinder tower for stacking badges -----
module cylinder_tower()
{
echo ("module cylinder_tower()");

echo( "radius" , cubex*(1-(corner_radius))*scale_factor );

	cylinder(h=(cubez*(pylon_size/100))+(2*fudge_factor),r=((cubex*(1-(corner_radius)))*scale_factor),center=false,$fn=polygon_count);

}	//	end of module - cylinder_tower()



//-------------------------------------------------------------------------
// ----- cylinder towers for stacking badges -----
module cylinder_towers()
{
echo ("module cylinder_towers()");

echo( "radius" , cubex*(1-(corner_radius)) );

tower_radius = ((cubex*(1-(corner_radius)))*scale_factor);
echo ( "tower_radius" , tower_radius );

tower_offset = (cubex*(scale_factor/2))-tower_radius;
echo ( "tower_offset" , tower_offset );

tower_z_offset = (cubez/2)-cubez-fudge_factor;
echo ("tower_z_offset" , tower_z_offset );

//difference()
{

union()
{
translate([tower_offset,tower_offset,tower_z_offset])
	cylinder_tower();

translate([tower_offset,-tower_offset,tower_z_offset])
	cylinder_tower();

translate([-tower_offset,tower_offset,tower_z_offset])
	cylinder_tower();

translate([-tower_offset,-tower_offset,tower_z_offset])
	cylinder_tower();

}	//	end of union

}	//	end of difference()

}	//	end of module - cylinder_towers()


//-------------------------------------------------------------------------
module make_this_badge( badge_number = 1 )
{
echo ( "start make_this_badge module" , badge_number );


translate([0,0,move_2_zero(what_badge=badge_number)])	//	move bottom to zero z-axis

translate([0,0,badge_zoffset[badge_number]])	// move to the top of the pylons

rotate([0,0,(90*rotate_this_way)*(badge_number-1)])
	scale(pow(scale_factor,badge_number-1)) 
	start_with_a_cube(include_towers=(stack_this_high>=badge_number+1),badgecount=badge_number);

}	//	end of module - make_this_cube()


//-------------------------------------------------------------------------

//Declaration of  function move_2_zero
function move_2_zero(what_badge) = (cubez*pow(scale_factor,what_badge-1))-fudge_factor;

echo("Move_2_zero ", move_2_zero(what_badge=1));
//echo("Move_2_zero ", move_2_zero(what_badge=2));
//echo("Move_2_zero ", move_2_zero(what_badge=3));
//echo("Move_2_zero ", move_2_zero(what_badge=4));
//echo("Move_2_zero ", move_2_zero(what_badge=5));


//-------------------------------------------------------------------------
//Declaration of  function calc_pylon_height
function calc_pylon_height(for_badge_level=1) = ((pow(scale_factor , for_badge_level-1)*(cubez/2))+(pow(scale_factor,for_badge_level-1)*(cubez*(pylon_size/100))))-
fudge_factor;

echo( "calc_pylon_height " , calc_pylon_height(for_badge_level=1) , "for_badge_level" , 1);

//-------------------------------------------------------------------------

//-------------------------------------------------------------------------

//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------





