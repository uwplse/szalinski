// Written by Volksswitch <www.volksswitch.org>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
//
// keyguard.scad would not have been possible without the generous help of the following therapists and makers:
//	Justus Reynolds, Angela Albrigo, Kerri Hindinger, Sarah Winn, Matthew Provost, Jamie Cain Nimtz, Ron VanArsdale, 
//  Michael O Daly, Duane Dominick (JDD Printing), Joanne Roybal, Melissa Hoffmann, Annette M. A. Cooprider, 
//  Ashley Larisey, Janel Comerford, Joy Hyzny
//
//
// Version History:
//
// Version 2: added support for clip-on straps as a mounting method
// Version 3: rewritten to better support portrait mode and to use cuts to create openings to the screen surface rather than defining rails
//				fixed bug in where padding appeared - put it around the grid rather than around the screen
//				increased the depth of Velcro cut-outs to 3 mm, which roughly translates to 2 mm when printed
//				cut for home button is now made at 90 deg. to not encroach on the grid on tablets with narrow borders
// Version 4: added support for circular cut-outs and the option to specify the shape of the cut-outs
//              added support for covering one or more cells
//              added support for merging a cell cut-out and the next cell cut-out
// Version 5: can print out a plug for one of the cells in the keyguard by choosing "cell cover" in the 
//				Special Actions and Settings>generate pull-down
//				can add a fudge factor to the height and width of the tablet to accommodate filaments that shrink slightly when printing
//				can add add padding around the screen to make the keyguard stronger without affecting the grid and bars to account for cases
//                 that go right up to the edge of the screen
// Version 6: can control the slope of the edges of a message/command bar
// Version 7: moved padding options to Grid Layout section of the user interface to clarify that these affect only the grid region of the screen
//              changed the width of the right border of the iPad 5th generation tablet to match width of the left border
//              made some variable value changes so that it is easier to see the choices selected in the Thingiverse Customizer
//              changed cover_home_button and cover_camera to expose_home_button and expose_camera because the original options were confusing
// Version 8: reduced the maximum slide-in tab width from 30 mm to 10 mm
//            added the ability to merge circular cells horizontally and to merge both rectangular and circular cells vertically
// Version 9: added support rounding the corners of the keyguards, when they are placed in a case, to accommodate
//            cases that have rounded corners on their openings
//            combined functionality for both grid-based and free-form keyguards into a single designer
//	          can now create cell openings that are rounded-rectangles
//            can limit the borders of a keyguard to the size of the screen for testing layouts
// Version 10: reduced some code complexity by using the hull() command on hot dogs and rounded rectangles
//             removed options to compensate for height and width shrinkage, upon testing they are too simplistic and keyguards don't 
//                do well with annealing anyway
//             changed "raised tab thickness" to "preferred raised tab thickness" because the raised tab can't be thicker than the
//                keyguard or it won't slice properly - the keyguard will be raised off the print surface by the bottoms of the four
//                raised tabs
// Version 11: added support for iPad 6th Generation, iPad Pro 11-inch, and iPad Pro 12.9 inch 3rd Generation
//             added ability to offset the screen from one side of the case toward the other
//             fixed bug that caused rounded case corners not to appear in portrait mode
//             added ability to create outside corners on hybrid and freeform keyguards
//             added ability to change the width of slide-in and raised tabs and their relative location (changed the meaning of 
//                "width" as well)
// Version 12: extended the upper end of the padding options to 100 mm after seeing a GoTalk Now 2-button layout
//             minor corrections to a couple of iPad Air 2 measurements
//             added support for swapping the camera/home button sides
//             added support for sloped sides on outer arcs
// Version 13: added support for text engraving
// Version 14: added option to control the number of facets used in circles and arcs - the original value was 360 and the default is now
//                 40 which should greatly improve rendering times and eliminate issues for laptops with limited memory
//             separated the tablet data from the statement that selects the data to use with the intent of making it easier to update
//                 and change the data in Excel
//             migrated from using Apple's statement of "active area" dimension to calculating the size of the screen based on number 
//                 of pixels and pixel size - active area dimensions seemed to overestimate the size of the screen - also assume a single
//                 value for number of vertical pixels in a screen shot and therefore a single value for pixel to mm conversion based
//                 on the stated pixel size
//             added the ability to engrave text on the bottom of the keyguard
//             added support for a separate data file to hold cut information that sits outside of the screen area, will always
//                 be measured in millimeters and will always be measured from the lower left corner of the case opening - so now 
//                 there are two files for defining cuts: one for within the screen area and one for outside of the screen
// Version 15: added support for Nova Chat 10 (does not support exposing the camera)
//             cleaned up the logic around when to cut for home and camera to account for lack of a home button or camera on the
//                 face of the tablet
//             added support for additive features like bumps, walls and ridges
//             fixed bug with height and width compensation for tight cases 
//             added support for using clip-on straps with cases
//             added support for printing clips
//             added support for hiding and exposing the status bar at the top of the screen
// Version 16: changed code to use offset() command to create rounded corners rather than cutting the corners
//			   added a small chamfer to the top edge of the keyguard to reduce the chance of injury
//             changed code to add case and screen cuts "after" adding compensation for tight cases
//			   added support for the NOVAchat 10.5 (does not support exposing the camera)
//             changed filename extension of case_cuts and screen_cuts files from .scad to .info to reduce confusion about what is the 
//                main OpenSCAD program
// Version 17: changed code that creates rounded corner slide-in tabs to use the offset() command because original code was confusing the
//                Thingiverse Customizer
//             fixed bug that prevented adding bumps, ridges and walls in the case_openings.info file
//             added acknowledgements for all those who helped bring keyguard.scad to life
// Version 18: added support for splitting the keyguard into two halves for printing on smaller 3D printers
//             put small chamfer at the top edge of all openings including the home button opening
//                  - it's only visible with large edge slopes like 90 degrees
//             separated circle from hotdog when specifying screen and case openings
//             added minimal error checking for data in screen_openings.info and case_openings.info
//             fixed bug when placing additions from case_openings.info
//             moved pedestals for clip-on straps inward slightly to account for chamfer on the outside edge of keyguard
//             fixed bug that produced a static width for the vertical clip-on strap slots
// Version 19: changed upper limits on command and message bars from 25 mm to 40 mm to support large tablets
//             fixed bug that was exposed when adding height and width compensation to the keyguard for tight fitting cases with
//                  very large corner radii
//             made all radii, including those on the outer corners of the keyguard sensitive to the value of "smoothness_of_circles_and_arcs"
//             fixed a bug that clipped the underside of a clip-on pedestal when it is adjacent to a bar
// Version 20: added support for the iPad Air 3 and the Surface Pro 4
// Version 21: fixed bug involving clip-on straps and split keyguards
//			   fixed bug where cut for vertical clip-on strap (no case) was a different depth than the horizontal strap cuts
//             updated pixel sizes of 0.960 mm/pixel to a more accurate value of 0.962 mm/pixel
//             extended the upper bound for added thickness for tight cases from 15 mm to 20 mm
// Version 22: added number of horizontal pixels to the data for each tablet to properly support portrait mode for free-form and hybrid tablets
//             fixed several bugs associated with creating portrait free-form and hybrid tablets
//             
//
//****Comment four sections for lite version

//------------------------------------------------------------------
// User Inputs
//------------------------------------------------------------------

/*[Tablet]*/
type_of_tablet = "iPad"; //[iPad,iPad2,iPad 3rd generation,iPad 4th generation,iPad 5th generation,iPad 6th generation,iPad Pro 9.7-inch,iPad Pro 10.5-inch,iPad Pro 11-inch,iPad Pro 12.9-inch 1st Generation,iPad Pro 12.9-inch 2nd Generation,iPad Pro 12.9-inch 3rd Generation,iPad mini,iPad mini 2,iPad mini 3,iPad mini 4,iPad Air,iPad Air 2,iPad Air 3,NOVAchat 10,NOVAchat 10 Plus,Surface Pro 4]
orientation = "landscape"; //[portrait,landscape]
expose_home_button = "yes"; //[yes,no]
expose_camera = "yes"; //[yes,no]
swap_camera_and_home_button = "no"; //[yes,no]

/*[Tablet Case]*/
have_a_case = "no"; //[yes,no]
height_of_opening_in_case = 150;// [100:300]
width_of_opening_in_case = 200; //[100:300]
case_opening_corner_radius = 0; //[0:30]

/*[App Layout]*/
status_bar_height = 0; //[0:10]
expose_status_bar = "no"; //[yes,no]

upper_message_bar_height = 0; //[0:40]
expose_upper_message_bar = "no"; //[yes,no]

upper_command_bar_height = 0; //[0:40]
expose_upper_command_bar = "no"; //[yes,no]

lower_message_bar_height = 0; //[0:40]
expose_lower_message_bar = "no"; //[yes,no]

lower_command_bar_height = 0; //[0:40]
expose_lower_command_bar = "no"; //[yes,no]

bar_edge_slope = 90; //[30:90]

/*[Grid Layout]*/
number_of_columns = 4;//[0:20]
number_of_rows = 3;//[0:20]
rail_width = 5; //[3:15]
preferred_rail_height = 5; //[2:15]
rail_slope = 60; //[30:90]

shape_of_opening = 1; //[1:rectangle, 2:circle, 3:rounded-rectangle]
rounded_rectangle_corner_radius = 1; //[1:20]
// example: [3, 6, 12] be sure to use brackets
cover_these_cells = [];
// example: [5, 8] merges cells 5&6 and 8&9, be sure to use brackets
merge_cells_horizontally_starting_at = [];
// example: [3, 4] merges cell 3 & the cell above and cell 4 & the cell above, be sure to use brackets
merge_cells_vertically_starting_at = [];

top_padding = 0; //[0:100]
bottom_padding = 0; //[0:100]
left_padding = 0; //[0:100]
right_padding = 0; //[0:100]

/*[Mounting Method]*/
mounting_method = "No Mount"; // [No Mount,Suction Cups,Velcro,Screw-on Straps,Clip-on Straps,Slide-in Tabs - for cases,Raised Tabs - for cases]

/*[Velcro Info]*/
velcro_size = 1; // [1:10mm -3/8 in- Dots, 2:16mm -5/8 in- Dots, 3:20mm -3/4 in- Dots, 4:3/8 in Squares, 5:5/8 in Squares, 6:3/4 in Squares]

/*[Clip-op Straps Info]*/
clip_width=20; //[15:30]
distance_between_clip_on_straps=60; //[20:120]
//- not for cases
include_vertical_strap = "no"; // [yes,no]
case_width = 220; //[200:400]
case_thickness = 15; //[5:40]
clip_bottom_length = 35; //[15:45]
case_to_screen_depth = 5; // [1:10]
unequal_left_side_of_case = 0; //[0:50]

/*[Slide-in Tabs Info]*/
slide_in_tab_thickness = 2; // [1:5]
slide_in_tab_length = 5; // [2:10]
slide_in_tab_width=20; // [10:30]
distance_between_slide_in_tabs=60; //[20:120]

/*[Raised Tabs Info]*/
raised_tab_height=5; // [2:30]
raised_tab_length=10; // [3:30]
raised_tab_width=20; // [10:30]
preferred_raised_tab_thickness=3; // [2:5]
distance_between_raised_tabs=60; //[20:120]



//********* 1. Comment the following lines for the lite version **********
/*[Free-form and Hybrid Keyguard Openings]*/
//set if grid rows or columns set to 0
free_form_keyguard_thickness = 5; //[3:10]
//px = pixels, mm = millimeters
unit_of_measure = "px"; //[px,mm]
//which corner is (0,0)?
starting_corner_for_measurements = "upper-left"; //[upper-left, lower-left]
//*********** stop commenting here *************


/*[Special Actions and Settings]*/
generate = "keyguard"; //[keyguard,first half of keyguard,second half of keyguard, clip,cell cover]
height_compensation_for_tight_cases = 0; //[0:20]
width_compensation_for_tight_cases = 0; //[0:20]
unequal_left_side_of_case_opening = 0; //[0:50]
unequal_bottom_side_of_case_opening = 0; //[0:50]
smoothness_of_circles_and_arcs = 40; //[5:360]
split_line = 0; //[-100:100]
trim_to_screen = "no"; //[yes,no]



/*[Hidden]*/
//Tablet Parameters -- 0:Tablet Width, 1:Tablet Height, 2:Tablet Thickness, 3:Screen Width, 4:Scree Height, 
//                     5:Right Border Width, 6:Left Border Width, 7:Bottom Border Height, 8:Top Border Height, 
//                     9:Distance from edge to Home Button, 10:Home Button diameter, 11:Distance from edge to Camera, 12:Camera diameter,
//                    13:Conversion Factors (# vertical pixels,	# horizontal pixesl, pixel size (mm))
iPad_data = [242.900,189.700,13.400,197.042,147.782,22.929,22.929,20.959,20.959,11.600,11.200,10.400,2.500,[768,1024,0.1924]];
iPad2_data = [241.300,185.800,8.800,197.042,147.782,22.129,22.129,19.009,19.009,10.800,11.300,11.100,3.000,[768,1024,0.1924]];
iPad3rdgeneration_data = [241.300,185.800,9.410,196.608,147.456,22.346,22.346,19.172,19.172,10.800,11.300,11.100,3.000,[1536,2048,0.0962]];
iPad4thgeneration_data = [241.300,185.800,9.400,196.608,147.456,22.346,22.346,19.172,19.172,10.800,11.300,11.100,3.000,[1536,2048,0.0962]];
iPad5thgeneration_data = [240.000,169.470,6.100,196.608,147.456,21.696,21.696,11.007,11.007,10.100,14.600,11.100,3.000,[1536,2048,0.0962]];
iPad6thgeneration_data = [240.000,169.470,6.100,196.608,147.456,21.696,21.696,11.007,11.007,10.100,14.600,11.100,3.000,[1536,2048,0.0962]];
iPadPro97inch_data = [240.000,169.470,6.100,196.608,147.456,21.696,21.696,11.007,11.007,10.100,14.600,11.100,3.000,[1536,2048,0.0962]];
iPadPro105inch_data = [250.590,174.080,6.100,213.504,160.128,18.543,18.543,6.976,6.976,8.960,14.600,9.200,3.000,[1668,2224,0.0962]];
iPadPro11inch_data = [247.640,178.520,5.953,229.248,160.128,9.196,9.196,9.196,9.196,0.000,0.000,4.370,3.090,[1668,2388,0.0962]];
iPadPro129inch1stGeneration_data = [305.690,220.580,6.900,262.272,196.608,21.709,21.709,11.986,11.986,10.100,14.600,11.100,3.000,[2048,2732,0.0962]];
iPadPro129inch2ndGeneration_data = [305.690,220.580,6.900,262.272,196.608,21.709,21.709,11.986,11.986,10.100,14.600,11.200,3.500,[2048,2732,0.0962]];
iPadPro129inch3rdGeneration_data = [280.660,214.990,5.908,262.272,196.608,9.194,9.194,9.191,9.191,0.000,0.000,4.370,3.230,[2048,2732,0.0962]];
iPadmini_data = [200.100,134.700,7.200,159.568,119.676,20.266,20.266,7.512,7.512,9.600,10.000,10.700,2.500,[768,1024,0.1558]];
iPadmini2_data = [200.100,134.700,7.500,159.539,119.654,20.280,20.280,7.523,7.523,9.600,10.000,10.700,2.500,[1536,2048,0.0779]];
iPadmini3_data = [200.100,134.700,7.500,159.539,119.654,20.280,20.280,7.523,7.523,9.600,10.000,10.700,2.500,[1536,2048,0.0779]];
iPadmini4_data = [203.160,134.750,6.100,159.539,119.654,21.810,21.810,7.548,7.548,9.510,10.600,10.500,4.000,[1536,2048,0.0779]];
iPadAir_data = [240.000,169.500,7.500,196.608,147.456,21.696,21.696,11.022,11.022,10.100,10.700,11.100,3.000,[1536,2048,0.0962]];
iPadAir2_data = [240.000,169.470,6.100,196.608,147.456,21.696,21.696,11.007,11.007,10.100,14.600,11.070,2.450,[1536,2048,0.0962]];
iPadAir3_data = [250.590,174.080,6.100,213.504,160.128,18.543,18.543,6.976,6.976,8.960,14.600,9.620,2.450,[1668,2224,0.0962]];
novachat10_data = [256.540,175.260,9.652,218.100,136.000,19.220,19.220,19.630,19.630,0.000,0.000,0.000,0.000,[768,1024,0.1700]];
novachat10_plus_data = [254.200,155.300,8.2,217.714,136.071,18.243,18.243,9.614,9.614,0.000,0.000,0.000,0.000,[1200,1920,0.1134]];
surface_pro_4_data = [292,201,8.5,258,172,17,17,14.5,14.5,0,0,0,0,[1824,2736,0.0943]];


tablet_params = 
    (type_of_tablet=="iPad")? iPad_data
  : (type_of_tablet=="iPad2")? iPad2_data
  : (type_of_tablet=="iPad 3rd generation")? iPad3rdgeneration_data
  : (type_of_tablet=="iPad 4th generation")? iPad4thgeneration_data
  : (type_of_tablet=="iPad 5th generation")? iPad5thgeneration_data
  : (type_of_tablet=="iPad 6th generation")? iPad6thgeneration_data
  : (type_of_tablet=="iPad Pro 9.7-inch")? iPadPro97inch_data
  : (type_of_tablet=="iPad Pro 10.5-inch")? iPadPro105inch_data
  : (type_of_tablet=="iPad Pro 11-inch")? iPadPro11inch_data
  : (type_of_tablet=="iPad Pro 12.9-inch 1st Generation")? iPadPro129inch1stGeneration_data
  : (type_of_tablet=="iPad Pro 12.9-inch 2nd Generation")? iPadPro129inch2ndGeneration_data
  : (type_of_tablet=="iPad Pro 12.9-inch 3rd Generation")? iPadPro129inch3rdGeneration_data
  : (type_of_tablet=="iPad mini")? iPadmini_data
  : (type_of_tablet=="iPad mini 2")? iPadmini2_data
  : (type_of_tablet=="iPad mini 3")? iPadmini3_data
  : (type_of_tablet=="iPad mini 4")? iPadmini4_data
  : (type_of_tablet=="iPad Air")? iPadAir_data
  : (type_of_tablet=="iPad Air 2")? iPadAir2_data
  : (type_of_tablet=="iPad Air 3")? iPadAir3_data
  : (type_of_tablet=="NOVAchat 10")? novachat10_data
  : (type_of_tablet=="NOVAchat 10")? novachat10_plus_data
  : surface_pro_4_data;
              
// Tablet variables
tablet_width = tablet_params[0];
tablet_height = tablet_params[1];
tablet_x0 = -tablet_width/2;
tablet_y0 = -tablet_height/2;
tablet_thickness = tablet_params[2];
right_border_width = tablet_params[5];
left_border_width = tablet_params[6];
top_border_height = tablet_params[8];
bottom_border_height = tablet_params[7];

home_button_diameter = tablet_params[10];
home_button_radius = home_button_diameter/2;
distance_from_edge_to_home_button = tablet_params[9];

camera_diameter = tablet_params[12];
camera_radius = camera_diameter/2;
distance_from_edge_to_camera = tablet_params[11];

// Screen variables (sensitive to orientation)
screen_width = (orientation=="landscape") ? tablet_params[3] : tablet_params[4];
screen_height = (orientation=="landscape") ? tablet_params[4] : tablet_params[3];
screen_x0 = (orientation=="landscape") ? tablet_x0 + left_border_width : tablet_y0 + bottom_border_height;
screen_y0 = (orientation=="landscape") ? tablet_y0 + bottom_border_height : tablet_x0 + right_border_width;

// Case variables
case_opening_width = (orientation=="landscape") ? width_of_opening_in_case : height_of_opening_in_case;
case_opening_height = (orientation=="landscape") ? height_of_opening_in_case : width_of_opening_in_case;

	// Case offset adjustments
	case_to_left_screen_dist = (orientation=="landscape") ? (case_opening_width-screen_width)/2 : (case_opening_height-screen_width)/2;
	case_to_bottom_screen_dist = (orientation=="landscape") ? (case_opening_height-screen_height)/2 : (case_opening_width-screen_height)/2;
	
	case_uneven_left = (orientation=="landscape") ? unequal_left_side_of_case_opening: unequal_bottom_side_of_case_opening;
	case_uneven_bottom = (orientation=="landscape") ? unequal_bottom_side_of_case_opening : unequal_left_side_of_case_opening;
	
	case_x0_offset_portrait = (case_uneven_left > 0) ? case_uneven_left - case_to_bottom_screen_dist : 0;
	case_x0_offset_landscape = (case_uneven_left > 0) ? case_uneven_left - case_to_left_screen_dist : 0;
	case_y0_offset_portrait = (case_uneven_bottom > 0) ? case_uneven_bottom - case_to_left_screen_dist : 0;
	case_y0_offset_landscape = (case_uneven_bottom > 0) ? case_uneven_bottom - case_to_bottom_screen_dist : 0;

case_x0 = (orientation=="landscape") ? -case_opening_width/2 - case_x0_offset_landscape : -case_opening_width/2 + case_x0_offset_portrait;
case_y0 = (orientation=="landscape") ? -case_opening_height/2 - case_y0_offset_landscape : -case_opening_height/2 - case_y0_offset_portrait;

//********* 2. Comment the following lines for the lite version **********
//Get data from screen_cuts.info and case_cuts.info
include <screen_openings.info>;
include <case_openings.info>;

cf = tablet_params[13];
screen_height_px = (orientation=="landscape") ? cf[0] : cf[1];
screen_width_px = (orientation=="landscape") ? cf[1] : cf[0];
conversion_factor =  cf[2];

screen_height_mm = (orientation=="landscape") ? screen_height : screen_width;
screen_width_mm	= (orientation=="landscape") ? screen_width : screen_height;
//*********** stop commenting here *************


//Grid variables
grid_width = screen_width - left_padding - right_padding;
grid_height = screen_height - status_bar_height - upper_message_bar_height - upper_command_bar_height - top_padding - bottom_padding - lower_message_bar_height - lower_command_bar_height;
grid_x0 = screen_x0 + left_padding;
grid_y0 = screen_y0 + bottom_padding + lower_message_bar_height + lower_command_bar_height;

shape_of_cut = 
	  (shape_of_opening==1)? "rectangle"
	: (shape_of_opening==2)? "circle"
	: "rounded-rectangle";

//misc variables
ipad_fillet = 10; //radius of iPad corner
fudge = 0.05;
chamfer_size=1.5;
$fn=smoothness_of_circles_and_arcs;


tan_rail_slope=tan(rail_slope);
max_rail_height= (number_of_columns > 0 || number_of_rows > 0) ? rail_width/2*tan_rail_slope : free_form_keyguard_thickness;
rail_height = (number_of_columns>0 && number_of_rows>0) ? min(max_rail_height,preferred_rail_height) : free_form_keyguard_thickness;
raised_tab_thickness = min(rail_height-chamfer_size/2,preferred_raised_tab_thickness);
echo(rail_height=rail_height,max_rail_height=max_rail_height);


velcro_diameter = 
    (velcro_size==1)? 10
  : (velcro_size==2)? 16
  : (velcro_size==3)? 20
  : (velcro_size==4)? 10
  : (velcro_size==5)? 16
  : 20;
  
strap_cut_to_depth = 9.25 - 3.1 - 3.5; // length of bolt - thickness of acrylic mount - height of nut
  
// ----------------------Main-----------------------------
if (generate=="keyguard" || generate=="first half of keyguard" || generate=="second half of keyguard"){
	difference(){
		union(){
			difference(){
				union(){
					difference(){
						if (trim_to_screen == "yes"){
							translate([screen_x0,screen_y0,-rail_height/2])
							cube([screen_width,screen_height,rail_height]);
						}
						else{
							final_rotation = (orientation=="landscape") ? [0,0,0] : [0,0,-90];
							rotate(final_rotation)
							difference(){
								//-- base object: tablet body slab or case opening
								base_keyguard();

								//-- items to cut away
								//home button and camera are cut for both case and no_case configurations
								home_camera();
								
								//add cuts for certain non-case mounting points
								if (have_a_case=="no"){
									//add cuts for suction cups, velcro, clip-on straps and screw-on straps
									if (mounting_method ){
										//mounting points
										mounting_points();
									}
								}
							}
						}
						//cut bars and grid cells
						bars();
						if (number_of_columns>0 && number_of_rows>0){
							cells();
						}
					}
					final_rotation = (orientation=="landscape") ? [0,0,0] : [0,0,-90];
					rotate(final_rotation)
					tight_case(); //adding thickness to walls if case is tight


//********* 3. Comment the following lines for the lite version **********				
					//add bumps, walls, and ridges
					if (len(screen_openings)>0){
						adding_plastic(screen_openings,"screen");
					}
					if (have_a_case=="yes"){
						if (len(case_openings)>0){
							adding_plastic(case_openings,"case");
						}
					}
//*********** stop commenting here *************

				}
//********* 4. Comment the following lines for the lite version **********				
				//cut screen and case openings
				if (len(screen_openings)>0){
					cut_screen_openings(screen_openings);
				}
				if (have_a_case=="yes"){
					if (len(case_openings)>0){
						cut_case_openings(case_openings);
					}
				}
//*********** stop commenting here *************
			}
		
			final_rotation = (orientation=="landscape") ? [0,0,0] : [0,0,-90];
			rotate(final_rotation)
			//add case mounting features
			if (have_a_case=="yes"){
				case_mounts();
			}
		}
			
		final_rotation = (orientation=="landscape") ? [0,0,0] : [0,0,-90];
		rotate(final_rotation)
		//final cut of slots for clip-on straps
		if (have_a_case=="yes" && mounting_method=="Clip-on Straps"){
			clip_on_straps();
		}
		if (generate=="first half of keyguard" || generate=="second half of keyguard"){
			split_keyguard();
		}
	}
}
else if (generate=="clip"){
	if (unequal_left_side_of_case == 0){
		clip_reach = (have_a_case=="no")? 6 : (case_width-case_opening_width)/2+5;
echo(clip_reach=clip_reach);
		create_clip(clip_reach);
	}
	else{  //if unequal_left_side_of_case>0 then assume that there is a case
		clip_reach_left = unequal_left_side_of_case + 5;
echo(clip_reach_left=clip_reach_left);

		clip_reach_right = case_width-case_opening_width-unequal_left_side_of_case+5;
echo(clip_reach_right=clip_reach_right);

		//left side clip
		translate([-35,0,clip_width])
		rotate([0,180,0])
		translate([0,case_thickness/2+10,0])
		create_clip(clip_reach_left);
		
		//right side clip
		translate([0,-case_thickness/2-10,0])
		create_clip(clip_reach_right);
	}
}
else{
	create_cell_cover();
}

// ---------------------Modules----------------------------

module split_keyguard(){
	if (orientation=="landscape"){
		if (split_line==0 && number_of_rows > 0 && number_of_columns > 0){
			grid_offset = grid_x0 - tablet_x0 + tablet_width/2;
			odd_num_columns = number_of_columns/2 - floor(number_of_columns/2) > 0;
			cell_width=grid_width/number_of_columns;
			cut_line = (odd_num_columns) ? 
				(number_of_columns/2 + 0.5)*cell_width :
				(number_of_columns/2)*cell_width;
				
			split_x0 = (generate=="first half of keyguard")?
				grid_offset+cut_line:
				grid_offset+cut_line-(tablet_width*2);
			translate([split_x0,0,0])
			cube([tablet_width*2,tablet_height*2,rail_height*20],center=true);
		}
		else{
			split_x0 = (generate=="first half of keyguard")?
						(tablet_width*2)/2 + split_line:
						-(tablet_width*2)/2 + split_line;
			translate([split_x0,0,0])
			cube([tablet_width*2,tablet_height*2,rail_height*20],center=true);
		}
	}
	else{
		if (split_line==0 && number_of_rows > 0 && number_of_columns > 0){
			grid_offset = grid_y0 - tablet_y0 + 2.5;
			odd_num_rows = number_of_rows/2 - floor(number_of_rows/2) > 0;
			cell_height=grid_height/number_of_rows;
			cut_line = (odd_num_rows) ? 
				(number_of_rows/2 + 0.5)*cell_height :
				(number_of_rows/2)*cell_height;
			split_y0 = (generate=="first half of keyguard")?
				grid_y0-tablet_x0+cut_line+tablet_width/2:
				grid_y0-tablet_x0+cut_line-3*tablet_width/2;
			translate([0,split_y0,0])
			cube([tablet_height*2,tablet_width*2,100],center=true);
		}
		else{
			split_y0 = (generate=="first half of keyguard")?
						(tablet_width*2)/2 + split_line:
						-(tablet_width*2)/2 + split_line;
			translate([0,split_y0,0])
			cube([tablet_height*2,tablet_width*2,100],center=true);
		}
	}
}

module case_mounts() {
	//add mounting points for cases
	if (mounting_method=="Slide-in Tabs - for cases"){
		difference(){
			add_slide_in_tabs();
		}
	}
	else if (mounting_method=="Raised Tabs - for cases"){
		difference(){
			add_raised_tabs();
			round_corners("raised tabs",raised_tab_height-rail_height/2,raised_tab_thickness,raised_tab_length-raised_tab_height,raised_tab_width,distance_between_raised_tabs);	
		}
	}
	else if (mounting_method=="Clip-on Straps"){
		//build pedestals for later clip-on strap slots, assumes a case
		x0 = case_x0;
		y0 = case_y0;
		height_offset = case_opening_height;
		width_offset = case_opening_width;
		pedestal_width = clip_width + 10;
		
		translate([x0+4.2, y0+height_offset/2-distance_between_clip_on_straps/2-pedestal_width/2, rail_height/2])
		linear_extrude(height=case_to_screen_depth - rail_height,scale=.8)
		square([7,pedestal_width],center=true);
		
		translate([x0+4.2, y0+height_offset/2+distance_between_clip_on_straps/2+pedestal_width/2, rail_height/2])
		linear_extrude(height=case_to_screen_depth - rail_height,scale=.8)
		square([7,pedestal_width],center=true);
		
		translate([x0+width_offset - 7+2.8, y0+height_offset/2-distance_between_clip_on_straps/2-pedestal_width/2, rail_height/2])
		linear_extrude(height=case_to_screen_depth - rail_height,scale=.8)
		square([7,pedestal_width],center=true);
		
		translate([x0+width_offset - 7+2.8, y0+height_offset/2+distance_between_clip_on_straps/2+pedestal_width/2, rail_height/2])
		linear_extrude(height=case_to_screen_depth - rail_height,scale=.8)
		square([7,pedestal_width],center=true);
		
	}
	else {
		//No Mount option
	}
}

module add_slide_in_tabs() {
	left_slide_in_tab_offset = case_x0-slide_in_tab_length;
	
	translate([left_slide_in_tab_offset+slide_in_tab_length,case_y0+case_opening_height/2-distance_between_slide_in_tabs/2-slide_in_tab_width/2,-rail_height/2])
	create_slide_in_tab("left");
	
	translate([left_slide_in_tab_offset+slide_in_tab_length,case_y0+case_opening_height/2+distance_between_slide_in_tabs/2+slide_in_tab_width/2,-rail_height/2])
	create_slide_in_tab("left");
	
	right_slide_in_tab_offset = case_x0+case_opening_width;
	
	translate([right_slide_in_tab_offset,case_y0+case_opening_height/2-distance_between_slide_in_tabs/2-slide_in_tab_width/2,-rail_height/2])
	create_slide_in_tab("right");
	
	translate([right_slide_in_tab_offset,case_y0+case_opening_height/2+distance_between_slide_in_tabs/2+slide_in_tab_width/2,-rail_height/2])
	create_slide_in_tab("right");
}

module create_slide_in_tab(side){
	x1_offset = (side=="left") ? slide_in_tab_length/2: -slide_in_tab_length/2;
	x2_offset = (side=="left") ? -slide_in_tab_length/2+2 : slide_in_tab_length/2-2;
	
	translate([x2_offset,0,0])
	linear_extrude(height = slide_in_tab_thickness)
	difference(){
		offset(r=2)
		square([slide_in_tab_length,slide_in_tab_width-4],center=true);
		
		translate([x1_offset,0,0])
		square([4,slide_in_tab_width+2],center=true);
	}
}

module add_raised_tabs() {
	a1 = raised_tab_thickness;
	b1 = rail_height;
	c1 = b1 - a1;
	d1 = raised_tab_height;
	e1 = raised_tab_length;
	f1 = d1 - a1 - c1;
	g1 = d1 - b1 + a1;
	h1 = g1 + a1;
	
	left_raised_tab_offset = case_x0;
	
		translate([left_raised_tab_offset,case_y0+case_opening_height/2-distance_between_raised_tabs/2-raised_tab_width,rail_height-raised_tab_thickness-rail_height/2-chamfer_size/2])
        rotate([-90,180,0])
		linear_extrude(height = raised_tab_width)
		polygon(points=[[0,a1],[0,0],[d1,g1],[e1,g1],[e1,h1],[d1,h1]]);
	
		translate([left_raised_tab_offset,case_y0+case_opening_height/2+distance_between_raised_tabs/2,rail_height-raised_tab_thickness-rail_height/2-chamfer_size/2])
        rotate([-90,180,0])
		linear_extrude(height = raised_tab_width)
		polygon(points=[[0,a1],[0,0],[d1,g1],[e1,g1],[e1,h1],[d1,h1]]);

	right_raised_tab_offset = case_x0+case_opening_width-raised_tab_thickness;

		translate([right_raised_tab_offset+raised_tab_thickness,case_y0+case_opening_height/2-distance_between_raised_tabs/2,rail_height-raised_tab_thickness-rail_height/2-chamfer_size/2])
        rotate([90,0,0])
		linear_extrude(height = raised_tab_width)
		polygon(points=[[0,a1],[0,0],[d1,g1],[e1,g1],[e1,h1],[d1,h1]]);
		
		translate([right_raised_tab_offset+raised_tab_thickness,case_y0+case_opening_height/2+distance_between_raised_tabs/2+raised_tab_width,rail_height-raised_tab_thickness-rail_height/2-chamfer_size/2])
        rotate([90,0,0])
		linear_extrude(height = raised_tab_width)
		polygon(points=[[0,a1],[0,0],[d1,g1],[e1,g1],[e1,h1],[d1,h1]]);
}

module round_corners(corner_type, tab_height,tab_thickness,tab_length,tab_width,distance_between_tabs) {
	if (corner_type=="raised tabs"){ 
		left_side_tab_offset = case_x0- raised_tab_height - (raised_tab_length-raised_tab_height)+tab_length/2;
		right_side_tab_offset = case_x0+case_opening_width + raised_tab_height+tab_length/2;
		  
		tab_thickness = raised_tab_thickness;
		tab_base = -rail_height/2+tab_thickness/2+raised_tab_height-chamfer_size/2;

		translate([left_side_tab_offset,case_y0+case_opening_height/2-distance_between_tabs/2-tab_width+tab_length/2,tab_base])
		create_cutting_tool(180, tab_length, tab_thickness+fudge*2, 90, "rt");
		translate([left_side_tab_offset,case_y0+case_opening_height/2-distance_between_tabs/2-tab_length/2,tab_base])
		create_cutting_tool(90, tab_length, tab_thickness+fudge*2, 90, "rt");
		
		
		translate([left_side_tab_offset,case_y0+case_opening_height/2+distance_between_tabs/2+tab_length/2,tab_base])
		create_cutting_tool(180, tab_length, tab_thickness+fudge*2, 90, "rt");
		translate([left_side_tab_offset,case_y0+case_opening_height/2+distance_between_tabs/2+tab_width-tab_length/2,tab_base])
		create_cutting_tool(90, tab_length, tab_thickness+fudge*2, 90, "rt");
		
		
		translate([right_side_tab_offset,case_y0+case_opening_height/2-distance_between_tabs/2-tab_width+tab_length/2,tab_base])
		create_cutting_tool(-90, tab_length,tab_thickness+fudge*2, 90, "rt");
		translate([right_side_tab_offset,case_y0+case_opening_height/2-distance_between_tabs/2-tab_length/2,tab_base])
		create_cutting_tool(0, tab_length,tab_thickness+fudge*2, 90, "rt");
		
		
		translate([right_side_tab_offset,case_y0+case_opening_height/2+distance_between_tabs/2+tab_length/2,tab_base])
		create_cutting_tool(-90, tab_length, tab_thickness+fudge*2, 90, "rt");
		translate([right_side_tab_offset,case_y0+case_opening_height/2+distance_between_tabs/2+tab_width-tab_length/2,tab_base])
		create_cutting_tool(0, tab_length, tab_thickness+fudge*2, 90, "rt");
	}
	else { //case
		translate([case_x0+tab_length/2,case_y0+tab_length/2,0])
		create_cutting_tool(180, tab_length, tab_thickness,90, "case");	
		
		translate([case_x0+tab_length/2,case_y0+case_opening_height-tab_length/2,0])
		create_cutting_tool(90, tab_length, tab_thickness,90, "case");
		
		translate([case_x0+case_opening_width-tab_length/2,case_y0+tab_length/2,0])
		create_cutting_tool(-90, tab_length, tab_thickness,90, "case");	
		
		translate([case_x0+case_opening_width-tab_length/2,case_y0+case_opening_height-tab_length/2,0])
		create_cutting_tool(0, tab_length, tab_thickness,90, "case");
	}
}

module create_cutting_tool(rotation,diameter,thickness,slope,type){
	rotate([0,0,rotation])
	difference(){
		translate([0,0,-thickness/2-fudge/2])
		cube(size=[diameter/2+fudge*2,diameter/2+fudge*2,thickness+fudge]);
		intersection(){
			cylinder(h=thickness+fudge*4,r1=diameter/2,r2=diameter/2-(thickness/tan(slope)),center=true);
			if (type=="oa"){ //outer arcs are chamfered
				chamfer_circle_radius1 = diameter/2+(tan(45)*(thickness-1));
				chamfer_circle_radius2 = diameter/2-1;
				cylinder(h=thickness+fudge*4,r1=chamfer_circle_radius1,r2=chamfer_circle_radius2,center=true);
			}
		}
	}
}

module home_camera(){
	// deal with home button
	if (expose_home_button=="yes" && home_button_diameter > 0){
		if (swap_camera_and_home_button == "no"){
			translate([tablet_x0+tablet_width-distance_from_edge_to_home_button,tablet_y0+tablet_height/2,0])
			circular_cutter(home_button_radius*2,90);
		}
		else {
			translate([tablet_x0+distance_from_edge_to_home_button,tablet_y0+tablet_height/2,0])
			circular_cutter(home_button_radius*2,90);
		}
	}
	//deal with camera
	if (expose_camera=="yes" && camera_diameter > 0){
		if (swap_camera_and_home_button == "no"){
			translate([tablet_x0+distance_from_edge_to_camera,tablet_y0+tablet_height/2,0])
			circular_cutter((camera_radius+1)*2,45);
		}
		else {
			translate([tablet_x0+tablet_width-distance_from_edge_to_camera,tablet_y0+tablet_height/2,0])
			circular_cutter((camera_radius+1)*2,45);
		}
	}
}

module mounting_points(){
	if (mounting_method=="Suction Cups"){
		suction_cups();
	}
	else if (mounting_method=="Velcro"){
		velcro();
	}
	else if (mounting_method=="Screw-on Straps"){
		screw_on_straps();
	}
	else if (mounting_method=="Clip-on Straps"){
		clip_on_straps();
	}
	else {
		//No Mount option
	}
}

module suction_cups(){
	translate([tablet_x0+left_border_width/2, tablet_y0+tablet_height/2 + 40, 0])
	cylinder(h=rail_height*3, d=7.5, center=true);
	translate([tablet_x0+left_border_width/2, tablet_y0+tablet_height/2 + 40-5, 0])
	cylinder(h=rail_height*3, d=4.5, center=true);
	
	translate([tablet_x0+left_border_width/2, tablet_y0+tablet_height/2 - 40, 0])
	cylinder(h=rail_height*3, d=7.5, center=true);
	translate([tablet_x0+left_border_width/2, tablet_y0+tablet_height/2 - 40+5, 0])
	cylinder(h=rail_height*3, d=4.5, center=true);
	
	translate([tablet_x0+tablet_width-right_border_width/2, tablet_y0+tablet_height/2 + 40, 0])
	cylinder(h=rail_height*3, d=7.5, center=true);
	translate([tablet_x0+tablet_width-right_border_width/2, tablet_y0+tablet_height/2 + 40-5, 0])
	cylinder(h=rail_height*3, d=4.5, center=true);
	
	translate([tablet_x0+tablet_width-right_border_width/2, tablet_y0+tablet_height/2 - 40, 0])
	cylinder(h=rail_height*3, d=7.5, center=true);
	translate([tablet_x0+tablet_width-right_border_width/2, tablet_y0+tablet_height/2 - 40+5, 0])
	cylinder(h=rail_height*3, d=4.5, center=true);
	
	translate([tablet_x0+left_border_width/2-5,tablet_y0+tablet_height/2 + 30.5,-rail_height/2+2])
	cube(size=[10,15,rail_height]);
	
	translate([tablet_x0+left_border_width/2-5,tablet_y0+tablet_height/2 - 45.5,-rail_height/2+2])
	cube(size=[10,15,rail_height]);

	translate([tablet_x0+tablet_width-15,tablet_y0+tablet_height/2 + 30.5,-rail_height/2+2])
	cube(size=[10,15,rail_height]);
	
	translate([tablet_x0+tablet_width-15,tablet_y0+tablet_height/2 - 45.5,-rail_height/2+2])
	cube(size=[10,15,rail_height]);
}

module velcro(){
	//create recessed shapes on the bottom of the surround to mount velcro
	
	if (mounting_method=="Velcro"){
		if (velcro_size<=3){ //round velcros
			translate([tablet_x0+velcro_diameter/2+1, tablet_y0+tablet_height/2 + 30, -rail_height/2+.5])
			cylinder(h=2.5, d=velcro_diameter, center=true);
			
			translate([tablet_x0++velcro_diameter/2+1, tablet_y0+tablet_height/2 - 30, -rail_height/2+.5])
			cylinder(h=2.5, d=velcro_diameter, center=true);
			
			translate([tablet_x0+tablet_width-velcro_diameter/2-1, tablet_y0+tablet_height/2 + 30, -rail_height/2+.5])
			cylinder(h=2.5, d=velcro_diameter, center=true);
			
			translate([tablet_x0+tablet_width-velcro_diameter/2-1, tablet_y0+tablet_height/2 - 30, -rail_height/2+.5])
			cylinder(h=2.5, d=velcro_diameter, center=true);
		}
		else{ //square velcros
			translate([tablet_x0+velcro_diameter/2+1, tablet_y0+tablet_height/2 + 30, -rail_height/2+.5])
			cube(size=[velcro_diameter,velcro_diameter,2.5],center=true);
			
			translate([tablet_x0+velcro_diameter/2+1, tablet_y0+tablet_height/2 - 30, -rail_height/2+.5])
			cube(size=[velcro_diameter,velcro_diameter,2.5],center=true);
			
			translate([tablet_x0+tablet_width-velcro_diameter/2-1, tablet_y0+tablet_height/2 + 30, -rail_height/2+.5])
			cube(size=[velcro_diameter,velcro_diameter,2.5],center=true);
			
			translate([tablet_x0+tablet_width-velcro_diameter/2-1, tablet_y0+tablet_height/2 - 30, -rail_height/2+.5])
			cube(size=[velcro_diameter,velcro_diameter,2.5],center=true);
		}
	}
}

module screw_on_straps(){
	//drill holes for screw-on straps and cut slots if needed for thick keyguards
	if (strap_cut_to_depth<rail_height) {  //cuts slot and flanges (the cylinders) for Keyguard AT's acrylic tabs
		translate([tablet_x0-1,tablet_y0+tablet_height/2 + 34.5,-rail_height/2+strap_cut_to_depth])
		cube(size=[12,11,rail_height]);
		translate([tablet_x0-1,tablet_y0+tablet_height/2 + 34.5,-rail_height/2+strap_cut_to_depth])
		cylinder(h=rail_height,d=7,$fn=3);
		translate([tablet_x0-1,tablet_y0+tablet_height/2 + 45.5,-rail_height/2+strap_cut_to_depth])
		cylinder(h=rail_height,d=7,$fn=3);
		
		translate([tablet_x0-1,tablet_y0+tablet_height/2 - 45.5,-rail_height/2+strap_cut_to_depth])
		cube(size=[12,11,rail_height]);
		translate([tablet_x0-1,tablet_y0+tablet_height/2 - 45.5,-rail_height/2+strap_cut_to_depth])
		cylinder(h=rail_height,d=7,$fn=3);
		translate([tablet_x0-1,tablet_y0+tablet_height/2 - 34.5,-rail_height/2+strap_cut_to_depth])
		cylinder(h=rail_height,d=7,$fn=3);

		translate([tablet_x0+tablet_width-11,tablet_y0+tablet_height/2 + 34.5,-rail_height/2+strap_cut_to_depth])
		cube(size=[12,11,rail_height]);
		translate([tablet_x0+tablet_width,tablet_y0+tablet_height/2 + 34.5,-rail_height/2+strap_cut_to_depth])
		rotate([0,0,180])
		cylinder(h=rail_height,d=7,$fn=3);
		translate([tablet_x0+tablet_width,tablet_y0+tablet_height/2 + 45.5,-rail_height/2+strap_cut_to_depth])
		rotate([0,0,180])
		cylinder(h=rail_height,d=7,$fn=3);
		
		translate([tablet_x0+tablet_width-11,tablet_y0+tablet_height/2 - 45.5,-rail_height/2+strap_cut_to_depth])
		cube(size=[12,11,rail_height]);
		translate([tablet_x0+tablet_width,tablet_y0+tablet_height/2 - 45.5,-rail_height/2+strap_cut_to_depth])
		rotate([0,0,180])
		cylinder(h=rail_height,d=7,$fn=3);
		translate([tablet_x0+tablet_width,tablet_y0+tablet_height/2 - 34.5,-rail_height/2+strap_cut_to_depth])
		rotate([0,0,180])
		cylinder(h=rail_height,d=7,$fn=3);
	}
	//cut holes for screw
	translate([tablet_x0+5.5, tablet_y0+tablet_height/2 + 40, -rail_height/2])
	cylinder(h=rail_height*3, d=6, center=true);
	
	translate([tablet_x0+5.5, tablet_y0+tablet_height/2 - 40, -rail_height/2])
	cylinder(h=rail_height*3, d=6, center=true);
	
	translate([tablet_x0+tablet_width-5.5, tablet_y0+tablet_height/2 + 40, -rail_height/2])
	cylinder(h=rail_height*3, d=6, center=true);
	
	translate([tablet_x0+tablet_width-5.5, tablet_y0+tablet_height/2 - 40, -rail_height/2])
	cylinder(h=rail_height*3, d=6, center=true);
}

module clip_on_straps(){
	//create recesses on the top of the surround to mount clips
	fudge = 0.05;
	x0 = (have_a_case=="no") ? tablet_x0 : case_x0;
	y0 = (have_a_case=="no") ? tablet_y0 : case_y0;
	height_offset = (have_a_case=="no") ? tablet_height : case_opening_height;
	width_offset = (have_a_case=="no") ? tablet_width : case_opening_width;
	
	keyguard_height = (number_of_columns > 0 && number_of_rows > 0) ? rail_height : free_form_keyguard_thickness;
	keyguard_pedestal_height = (have_a_case=="no")? 0 : max(case_to_screen_depth - keyguard_height,0);
	vertical_offset = keyguard_height/2 + keyguard_pedestal_height-3+fudge; // bottom of cut
	
	slot_half = (clip_width+2)/2;
	pedestal_half = (clip_width+10)/2;
	
	translate([x0 + 2, y0+height_offset/2-distance_between_clip_on_straps/2+slot_half-pedestal_half, vertical_offset])
	rotate([90,0,0])
	linear_extrude(height = clip_width + 2)
	polygon(points=[[0,0],[3,0],[4,3],[1,3]]);
	
	translate([x0 + 2, y0+height_offset/2+distance_between_clip_on_straps/2+slot_half+pedestal_half, vertical_offset])
	rotate([90,0,0])
	linear_extrude(height = clip_width + 2)
	polygon(points=[[0,0],[3,0],[4,3],[1,3]]);
	
	translate([x0+width_offset - 5, y0+height_offset/2-distance_between_clip_on_straps/2+slot_half-pedestal_half, vertical_offset])
	rotate([90,0,0])
	linear_extrude(height = clip_width + 2)
	polygon(points=[[0,0],[3,0],[2,3],[-1,3]]);
	
	translate([x0+width_offset - 5, y0+height_offset/2+distance_between_clip_on_straps/2+slot_half+pedestal_half, vertical_offset])
	rotate([90,0,0])
	linear_extrude(height = clip_width + 2)
	polygon(points=[[0,0],[3,0],[2,3],[-1,3]]);
	
	if (have_a_case=="no" && include_vertical_strap == "yes"){
		translate([x0+width_offset/2-(clip_width + 2)/2, y0+2, vertical_offset])
		rotate([90,0,90])
		linear_extrude(height = clip_width + 2)
		polygon(points=[[0,0],[3,0],[4,3],[1,3]]);
		
		translate([x0+width_offset/2+(clip_width + 2)/2, y0+height_offset-2, vertical_offset])
		rotate([90,0,-90])
		linear_extrude(height = clip_width + 2)
		polygon(points=[[0,0],[3,0],[4,3],[1,3]]);
	}
}

module bars(){
	// creates upper and lower command and message bars - will be part of a difference function
		
	//status bar
	if(expose_status_bar=="yes" && status_bar_height > 0) {
		translate([screen_x0+screen_width/2,screen_y0+screen_height-status_bar_height/2,0])
		rectangular_cutter(screen_width,status_bar_height,90,90,90,90);
	}

	//upper message bar
	if(expose_upper_message_bar=="yes" && upper_message_bar_height > 0) {
		translate([screen_x0+screen_width/2,screen_y0+screen_height-status_bar_height-upper_message_bar_height/2,0])
		rectangular_cutter(screen_width,upper_message_bar_height,90,bar_edge_slope,90,90);
	}

	//upper command bar
	if(expose_upper_command_bar=="yes" && upper_command_bar_height > 0) {
		translate([screen_x0+screen_width/2,screen_y0+screen_height-status_bar_height-upper_message_bar_height-upper_command_bar_height/2,0])
		rectangular_cutter(screen_width,upper_command_bar_height,bar_edge_slope,90,90,90);
	}
		
	//lower message bar
	if(expose_lower_message_bar=="yes" && lower_message_bar_height > 0) {
		translate([screen_x0+screen_width/2,screen_y0+lower_command_bar_height+lower_message_bar_height/2,0])
		rectangular_cutter(screen_width,lower_message_bar_height,90,bar_edge_slope,90,90);
	}
		
	//lower command bar
	if(expose_lower_command_bar=="yes" && lower_command_bar_height > 0) {
		translate([screen_x0+screen_width/2,screen_y0+lower_command_bar_height/2,0])
		rectangular_cutter(screen_width,lower_command_bar_height,bar_edge_slope,90,90,90);
	}
}

module cells(){
	cell_width=grid_width/number_of_columns;
	cell_height=grid_height/number_of_rows;

	for (i = [0:number_of_rows-1]){
		for (j = [0:number_of_columns-1]){
			current_cell = j+1+i*number_of_columns;
			if (!search(current_cell,cover_these_cells)){
				cell_x0 = grid_x0 + j*cell_width + cell_width/2;
				cell_y0 = grid_y0 + i*cell_height + cell_height/2;
				
				if (shape_of_cut=="rectangle"){
					if ((search(current_cell,merge_cells_horizontally_starting_at))&&(j!=number_of_columns-1)){
						translate([cell_x0+cell_width/2,cell_y0,0])
						rectangular_cutter(2*cell_width-rail_width,cell_height-rail_width,rail_slope,rail_slope,rail_slope,rail_slope);
					}
					if((search(current_cell,merge_cells_vertically_starting_at))&&(i!=number_of_rows-1)){
						translate([cell_x0,cell_y0+cell_height/2,0])
						rectangular_cutter(cell_width-rail_width,2*cell_height-rail_width,rail_slope,rail_slope,rail_slope,rail_slope);
					}
					//clean up center pyramid if a cell is in both horizontal and vertical merge and next cell is also in the vertical merge
					if((search(current_cell,merge_cells_horizontally_starting_at))&&(search(current_cell,merge_cells_vertically_starting_at))&&(search(current_cell+1,merge_cells_vertically_starting_at))){
						translate([cell_x0+cell_width/2,cell_y0+cell_height/2,0])
						rectangular_cutter(cell_width-rail_width,2*cell_height-rail_width,rail_slope,rail_slope,rail_slope,rail_slope);
					}
					//basic, no-merge cell cut these two statements will have no impact if cell has been merged
					translate([cell_x0,cell_y0,0])
					rectangular_cutter(cell_width-rail_width,cell_height-rail_width,rail_slope,rail_slope,rail_slope,rail_slope);
				}
				else if (shape_of_cut=="circle") {
					min_cell_dimension = min(cell_width,cell_height);
					circle_diameter = min_cell_dimension - rail_width;
					if ((search(current_cell,merge_cells_horizontally_starting_at))&&(j!=number_of_columns-1)){
						translate([cell_x0+cell_width/2,cell_y0,0])
						hotdog_cutter(cell_width+circle_diameter,circle_diameter,rail_slope);
					}
					if((search(current_cell,merge_cells_vertically_starting_at))&&(i!=number_of_rows-1)){
						translate([cell_x0,cell_y0+cell_height/2,0])
						hotdog_cutter(circle_diameter,cell_height+circle_diameter,rail_slope);
					}
					//clean up center pyramid if a cell is in both horizontal and vertical merge and next cell is also in the vertical merge
					if((search(current_cell,merge_cells_horizontally_starting_at))&&(search(current_cell,merge_cells_vertically_starting_at))&&(search(current_cell+1,merge_cells_vertically_starting_at))){
						translate([cell_x0+cell_width/2,cell_y0+cell_height/2,0])
						rectangular_cutter(cell_height,cell_width,90,90,rail_slope,rail_slope);
						translate([cell_x0+cell_width/2,cell_y0+cell_height/2,0])
						rectangular_cutter(cell_width,cell_height,rail_slope,rail_slope,90,90);
					}
					//these two statements will have no impact if cell has been merged
					translate([cell_x0,cell_y0,0])
					hotdog_cutter(circle_diameter,circle_diameter,rail_slope);
				}
				else{
				//rounded rectangle
					if ((search(current_cell,merge_cells_horizontally_starting_at))&&(j!=number_of_columns-1)){
						translate([cell_x0+cell_width/2,cell_y0,0])
						rounded_rectangular_cutter(2*cell_width-rail_width,cell_height-rail_width,rail_slope,rounded_rectangle_corner_radius);	
					}
					if((search(current_cell,merge_cells_vertically_starting_at))&&(i!=number_of_rows-1)){
						translate([cell_x0,cell_y0+cell_height/2,0])
						rounded_rectangular_cutter(cell_width-rail_width,2*cell_height-rail_width,rail_slope,rounded_rectangle_corner_radius);	
					}
					//clean up center pyramid if a cell is in both horizontal and vertical merge and next cell is also in the vertical merge
					if((search(current_cell,merge_cells_horizontally_starting_at))&&(search(current_cell,merge_cells_vertically_starting_at))&&(search(current_cell+1,merge_cells_vertically_starting_at))){
						translate([cell_x0+cell_width/2,cell_y0+cell_height/2,0])
						rectangular_cutter(cell_width-rail_width,2*cell_height-rail_width,rail_slope,rail_slope,rail_slope,rail_slope);
					}
					//basic, no-merge cell cut these two statements will have no impact if cell has been merged
					translate([cell_x0,cell_y0,0])
					rounded_rectangular_cutter(cell_width-rail_width,cell_height-rail_width,rail_slope,rounded_rectangle_corner_radius);
				}
			}
		}
	}
}

module rectangular_cutter(hole_width,hole_height,top_slope,bottom_slope,left_slope,right_slope){
	r_c(hole_width,hole_height,top_slope,bottom_slope,left_slope,right_slope,rail_height);
	translate([0,0,rail_height/2-fudge*2])
	r_c(hole_width,hole_height,45,45,45,45,1);
}

module r_c(hole_width,hole_height,top_slope,bottom_slope,left_slope,right_slope,cut_height){
	kt=cut_height + 0.01;
	hw=hole_width;
	hh=hole_height;

	lxo = kt/tan(left_slope); //left x offset
	rxo = kt/tan(right_slope);
	tyo = kt/tan(top_slope);
	byo = kt/tan(bottom_slope);

	A_x = -hw/2; A_y = -hh/2;
	B_x = hw/2; B_y = -hh/2;
	C_x = hw/2; C_y = hh/2;
	D_x = -hw/2; D_y = hh/2;

	E_x = D_x - lxo; E_y = D_y + tyo;
	F_x = A_x - lxo; F_y = A_y - byo;
	G_x = B_x + rxo; G_y = B_y - byo;
	H_x = C_x + rxo; H_y = C_y + tyo;

	CubePoints = [
	  [A_x, A_y, -kt/2],  //0
	  [B_x, B_y, -kt/2],  //1
	  [C_x, C_y, -kt/2],  //2
	  [D_x, D_y, -kt/2],  //3
	  [F_x, F_y, kt/2],  //4
	  [G_x, G_y, kt/2],  //5
	  [H_x, H_y, kt/2],  //6
	  [E_x, E_y, kt/2]]; //7
	  
	CubeFaces = [
	  [0,1,2,3],  // bottom
	  [4,5,1,0],  // front
	  [7,6,5,4],  // top
	  [5,6,2,1],  // right
	  [6,7,3,2],  // back
	  [7,4,0,3]]; // left
	  
	polyhedron( CubePoints, CubeFaces );
}

module hotdog_cutter(cut_width,cut_height,slope){
	if (cut_width > cut_height){
		//circles at either end, cut_height in diameter
		hull(){
			translate([-cut_width/2 + cut_height/2, 0, 0])
			c_c(cut_height,slope,rail_height);
			translate([cut_width/2 - cut_height/2, 0, 0])
			c_c(cut_height,slope,rail_height);
		}
		hull(){
			translate([-cut_width/2 + cut_height/2, 0, rail_height/2-fudge*2])
			c_c(cut_height,45,1);
			translate([cut_width/2 - cut_height/2, 0, rail_height/2-fudge*2])
			c_c(cut_height,45,1);
		}
	}
	else{
		//circles at either end, cut_width in diameter
		hull(){
			translate([0,cut_height/2 - cut_width/2 , 0])
			c_c(cut_width,slope,rail_height);
			translate([0,cut_width/2 - cut_height/2, 0])
			c_c(cut_width,slope,rail_height);
		}
		hull(){
			translate([0,cut_height/2 - cut_width/2 , rail_height/2-fudge*2])
			c_c(cut_width,45,1);
			translate([0,cut_width/2 - cut_height/2, rail_height/2-fudge*2])
			c_c(cut_width,45,1);
		}
	}
}

module circular_cutter(circle_diameter,slope){
	c_c(circle_diameter,slope,rail_height);
	translate([0,0,rail_height/2-fudge*2])
	c_c(circle_diameter,45,1);
}

module c_c(circle_diameter,slope,cut_height){
	cell_cutter_height = cut_height + 0.01;
	cell_cutter_bottom = circle_diameter;
	tan_slope = tan(slope);
	cell_cutter_top = cell_cutter_bottom+(2*cell_cutter_height/tan_slope);

	cc_scale=cell_cutter_top/cell_cutter_bottom;
	
	linear_extrude(height=cell_cutter_height, scale=[cc_scale,cc_scale], center=true)
	circle(d=cell_cutter_bottom);
}

module rounded_rectangular_cutter(cut_width,cut_height,slope,corner_radius){
	//verify that the value of corner_radius isn't greater than the length of a side of the cell
	min_cell_dimension = min(cut_width,cut_height);
	cr = (min_cell_dimension>=corner_radius*2) ? corner_radius : (min_cell_dimension - 1)/2;
	
	//circles at four corners, corner_radius * 2 in diameter
	corner_diameter = 2 * cr;
	
	hull(){
		translate([-cut_width/2 + cr, cut_height/2 - cr, 0])
		c_c(corner_diameter,slope,rail_height);
		
		translate([-cut_width/2 + cr, -cut_height/2 + cr, 0])
		c_c(corner_diameter,slope,rail_height);
		
		translate([cut_width/2 - cr, cut_height/2 - cr, 0])
		c_c(corner_diameter,slope,rail_height);
		
		translate([cut_width/2 - cr, -cut_height/2 + cr, 0])
		c_c(corner_diameter,slope,rail_height);
	}
	hull(){
		translate([-cut_width/2 + cr, cut_height/2 - cr, rail_height/2-fudge*2])
		c_c(corner_diameter,45,1);
		
		translate([-cut_width/2 + cr, -cut_height/2 + cr, rail_height/2-fudge*2])
		c_c(corner_diameter,45,1);
		
		translate([cut_width/2 - cr, cut_height/2 - cr, rail_height/2-fudge*2])
		c_c(corner_diameter,45,1);
		
		translate([cut_width/2 - cr, -cut_height/2 + cr, rail_height/2-fudge*2])
		c_c(corner_diameter,45,1);
	}
}

module create_cell_cover(){
	cell_width=grid_width/number_of_columns - rail_width;
	cell_height=grid_height/number_of_rows - rail_width;
	min_cell_dimension = min(cell_width,cell_height);
	circle_diameter = min_cell_dimension - rail_width;
	
	rotate([180,0,0])
	difference(){
		if (shape_of_cut=="rectangle"){
			rectangular_cutter(cell_width,cell_height,rail_slope,rail_slope,rail_slope,rail_slope);
		}
		else if (shape_of_cut=="circle"){
			circular_cutter(circle_diameter,rail_slope);
		}
		else{ //rounded-rectangle
			rounded_rectangular_cutter(cell_width,cell_height,rail_slope,rounded_rectangle_corner_radius);
		}
		if (mounting_method=="Velcro") {
			translate([0, 0, -rail_height/2])
			if (velcro_size<=3){ //round velcros
				cylinder(h=2.5, d=velcro_diameter, center=true);
			}
			else{ //square velcros
				cube(size=[velcro_diameter,velcro_diameter,2.5],center=true);
			}
		}
	}
}

module cut_screen_openings(screen_openings){
	for(i = [0 : len(screen_openings)-1]){
		opening = screen_openings[i]; //0:ID, 1:x, 2:y, 3:width,  4:height, 5:shape, 6:top slope, 7:bottom slope, 8:left slope, 9:right slope, 10:corner_radius, 11:other
		
		// validate_data(opening);
		
		opening_ID = opening[0];
		opening_x = opening[1];
		opening_y = opening[2];
		opening_width = opening[3];
		opening_height = opening[4];
		opening_shape = opening[5];
		opening_top_slope = opening[6];
		opening_bottom_slope = opening[7];
		opening_left_slope = opening[8];
		opening_right_slope = opening[9];
		case_opening_corner_radius = opening[10];
		opening_other = opening[11];

		opening_width_mm = (unit_of_measure=="px") ? opening_width * conversion_factor : opening_width;
		opening_height_mm = (unit_of_measure=="px") ? opening_height * conversion_factor : opening_height;
		opening_x_mm = (unit_of_measure=="px") ? opening_x * conversion_factor : opening_x;
		opening_corner_radius_mm = (unit_of_measure=="px") ? case_opening_corner_radius * conversion_factor : case_opening_corner_radius;

		if (starting_corner_for_measurements == "upper-left"){
			opening_y_mm = (unit_of_measure=="px") ? (screen_height_px - opening_y) * conversion_factor : (screen_height - opening_y);
			translate([screen_x0+opening_x_mm,screen_y0+opening_y_mm,0])
			cut_opening(opening_ID, opening_width_mm, opening_height_mm, opening_shape, opening_top_slope, opening_bottom_slope, opening_left_slope, opening_right_slope, opening_corner_radius_mm, opening_other);
		}
		else{
			opening_y_mm = (unit_of_measure=="px") ? opening_y * conversion_factor : opening_y;
			
			translate([screen_x0+opening_x_mm,screen_y0+opening_y_mm,0])
			cut_opening(opening_ID, opening_width_mm, opening_height_mm, opening_shape, opening_top_slope, opening_bottom_slope, opening_left_slope, opening_right_slope, opening_corner_radius_mm, opening_other);
		}
	}
}
 
module cut_case_openings(case_openings){

	for(i = [0 : len(case_openings)-1]){
		opening = case_openings[i]; //0:ID, 1:x, 2:y, 3:width,  4:height, 5:shape, 6:top slope, 7:bottom slope, 8:left slope, 9:right slope, 10:corner_radius, 11:other
		// validate_data(opening);
		
		opening_ID = opening[0];
		opening_x = opening[1];
		opening_y = opening[2];
		opening_width = opening[3];
		opening_height = opening[4];
		opening_shape = opening[5];
		opening_top_slope = opening[6];
		opening_bottom_slope = opening[7];
		opening_left_slope = opening[8];
		opening_right_slope = opening[9];
		case_opening_corner_radius = opening[10];
		opening_other = opening[11];
		
		opening_width_mm = opening_width;
		opening_height_mm = opening_height;
		opening_x_mm = opening_x;
		opening_y_mm = opening_y;
		opening_corner_radius_mm = case_opening_corner_radius;
		
		mode_adjusted_case_x0 = (orientation == "landscape") ? case_x0 : case_y0;
		mode_adjusted_case_y0 = (orientation == "landscape") ? case_y0 : case_x0;
		
		translate([mode_adjusted_case_x0+opening_x_mm,mode_adjusted_case_y0+opening_y_mm,0])
		cut_opening(opening_ID, opening_width_mm, opening_height_mm, opening_shape, opening_top_slope, opening_bottom_slope, opening_left_slope, opening_right_slope, opening_corner_radius_mm, opening_other);
	}
}

module cut_opening(ID, cut_width, cut_height, shape, top_slope, bottom_slope, left_slope, right_slope, corner_radius, other){
		if (shape=="r"){
			if (cut_width > 0 && cut_height > 0){
				translate([cut_width/2,cut_height/2,0])
				rectangular_cutter(cut_width,cut_height,top_slope,bottom_slope,left_slope,right_slope);
			}
		}
		else if (shape=="c"){
			if (cut_width > 0){
				translate([0,0,0])
				circular_cutter(cut_width,top_slope);
			}
		}
		else if (shape=="hd"){
			if (cut_width > 0 && cut_height > 0){
				translate([0,0,0])
				hotdog_cutter(cut_width,cut_height,top_slope);
			}
		}
		else if (shape=="rr"){
			if (cut_width > 0 && cut_height > 0){
				translate([cut_width/2,cut_height/2,0])
				rounded_rectangular_cutter(cut_width,cut_height,top_slope,corner_radius);
			}
		}	
		else if (shape=="oa1"){
			if (corner_radius > 0){
				translate([-corner_radius,-corner_radius,0])
				create_cutting_tool(0, corner_radius*2, rail_height+0.05, top_slope, "oa");
			}
		}
		else if (shape=="oa2"){
			if (corner_radius > 0){
				translate([-corner_radius,corner_radius,0])
				create_cutting_tool(-90, corner_radius*2, rail_height+0.05, top_slope, "oa");	
			}
		}
		else if (shape=="oa3"){
			if (corner_radius > 0){
				translate([corner_radius,corner_radius,0])
				create_cutting_tool(180, corner_radius*2, rail_height+0.05, top_slope, "oa");
			}
		}
		else if (shape=="oa4"){
			if (corner_radius > 0){
				translate([corner_radius,-corner_radius,0])
				create_cutting_tool(90, corner_radius*2, rail_height+0.05, top_slope, "oa");	
			}
		}
		else if (shape=="ttext"){
			if (cut_height > 0){
				translate([0,0,rail_height/3])
				rotate([0,0,top_slope])
				linear_extrude(height=rail_height/2 + 1)
				text(str(other),size=cut_height,valign="bottom");
			}
		}
		else if (shape=="btext"){
			if (cut_height > 0){
				translate([0,0,-rail_height/3])
				rotate([0,180,0])
				rotate([0,0,top_slope])
				linear_extrude(height=rail_height/2 + 1)
				text(str(other),size=cut_height,valign="bottom");
			}
		}
	
}

module adding_plastic(additions,where){
	for(i = [0 : len(additions)-1]){
		addition = additions[i]; //0:ID, 1:x, 2:y, 3:width,  4:height, 5:shape, 6:top slope, 7:bottom slope, 8:left slope, 9:right slope, 10:corner_radius, 11:other
		
		// validate_data(addition);
		
		addition_ID = addition[0];
		addition_x = addition[1];
		addition_y = addition[2];
		addition_width = addition[3];
		addition_height = addition[4];
		addition_shape = addition[5];
		addition_top_slope = addition[6];
		addition_bottom_slope = addition[7];
		addition_left_slope = addition[8];
		addition_right_slope = addition[9];
		addition_corner_radius = addition[10];
		addition_other = addition[11];
		
		mode_adjusted_case_x0 = (orientation == "landscape") ? case_x0 : case_y0;
		mode_adjusted_case_y0 = (orientation == "landscape") ? case_y0 : case_x0;

		x0 = (where=="screen") ? screen_x0 : mode_adjusted_case_x0;
		y0 = (where=="screen") ? screen_y0 : mode_adjusted_case_y0;
		
		
		if (addition_shape == "bump" || addition_shape == "wall" || addition_shape == "hridge" || addition_shape == "vridge") {
		
			addition_width_mm = (unit_of_measure=="px" && where=="screen") ? addition_width * conversion_factor : addition_width;
			addition_height_mm = (unit_of_measure=="px" && where=="screen") ? addition_height * conversion_factor : addition_height;
			addition_x_mm = (unit_of_measure=="px" && where=="screen") ? addition_x * conversion_factor : addition_x;
			addition_corner_radius_mm = (unit_of_measure=="px" && where=="screen") ? addition_corner_radius * conversion_factor : addition_corner_radius;

			if (starting_corner_for_measurements == "upper-left" && where=="screen"){
				addition_y_mm = (unit_of_measure=="px") ? (screen_height_px - addition_y) * conversion_factor : (screen_height - addition_y);
				translate([x0+addition_x_mm,y0+addition_y_mm,rail_height/2])
				place_addition(addition_ID, addition_width_mm, addition_height_mm, addition_shape, addition_top_slope, addition_bottom_slope, addition_left_slope, addition_right_slope, addition_corner_radius_mm, addition_other);
			}
			else{
				addition_y_mm = (unit_of_measure=="px" && where=="screen") ? addition_y * conversion_factor : addition_y;
				
				translate([x0+addition_x_mm,y0+addition_y_mm,rail_height/2])
				place_addition(addition_ID, addition_width_mm, addition_height_mm, addition_shape, addition_top_slope, addition_bottom_slope, addition_left_slope, addition_right_slope, addition_corner_radius_mm, addition_other);
			}
		}
	}
}

module place_addition(ID, addition_width, addition_height, shape, top_slope, bottom_slope, left_slope, right_slope, corner_radius, other){
	if (shape=="bump"){
		if(addition_width>0){
			difference(){
				sphere(d=addition_width,$fn=40);
				translate([0,0,-addition_width])
				cube([addition_width*2, addition_width*2,addition_width*2],center=true);
			}
		}
	}
	else if (shape=="wall"){
		if(addition_height>0 && addition_width>0 && corner_radius>0){
			translate([addition_width/2,addition_height/2,(rail_height+corner_radius)/2-rail_height])
			difference(){
				cube([addition_width,addition_height,rail_height+corner_radius],center=true);
				cube([addition_width-rail_width/4,addition_height-rail_width/4,rail_height+corner_radius+2],center=true);
			}
		}
	}
	else if (shape=="hridge"){
		if(addition_width>0 && corner_radius>0){
			translate([addition_width/2,rail_width/16,(rail_height+corner_radius)/2-rail_height])
			cube([addition_width,rail_width/8,rail_height+corner_radius],center=true);
		}
	}	
	else if (shape=="vridge"){
		if(addition_height>0 && corner_radius>0){
			translate([rail_width/16,addition_height/2,(rail_height+corner_radius)/2-rail_height])
			cube([rail_width/8,addition_height,rail_height+corner_radius],center=true);
		}
	}	
}

module validate_data(opening);{	
//known values: screen_height_px, screen_width_px, screen_height_mm, screen_width_mm	

	// opening_ID = opening[0];
	// opening_x = opening[1];
	// opening_y = opening[2];
	// opening_width = opening[3];
	// opening_height = opening[4];
	// opening_shape = opening[5];
	// opening_top_slope = opening[6];
	// opening_bottom_slope = opening[7];
	// opening_left_slope = opening[8];
	// opening_right_slope = opening[9];
}

module tight_case(){
	//add case padding for cases that extend to the edge of the screen
	if (have_a_case=="yes" && (height_compensation_for_tight_cases>0 || width_compensation_for_tight_cases>0)) {
		difference(){
			if (orientation=="landscape"){
				difference(){
					cube([screen_width+2, screen_height+2, rail_height], center=true);
					cube([screen_width-width_compensation_for_tight_cases, screen_height-height_compensation_for_tight_cases, rail_height*2+0.01], center=true);
					case_opening_trimmer();
				}
			}
			else{
				difference(){
					cube([screen_height+2, screen_width+2, rail_height], center=true);
					cube([screen_height-width_compensation_for_tight_cases, screen_width-height_compensation_for_tight_cases, rail_height+0.01], center=true);
					case_opening_trimmer();
				}
			}
			translate([case_x0+case_opening_width/2,case_y0+case_opening_height/2,0])
			half_outer_chamfer(rail_height,case_opening_height,case_opening_width,case_opening_corner_radius);
		}
	}
}

module case_opening_trimmer(){
	difference(){
		cube([tablet_width,tablet_height,rail_height+fudge],center=true);
			
		translate([0,0,-(rail_height+fudge)/2])
		linear_extrude(height=rail_height+fudge) 
		shape(case_opening_width,case_opening_height,case_opening_corner_radius,0);
	}
}

module create_clip(clip_reach){
	// base_thickness = 5;
	base_thickness = 4;
	clip_thickness = 3;
	keyguard_thick = (number_of_columns > 0 && number_of_rows > 0) ? rail_height : free_form_keyguard_thickness;
	case_thick = (have_a_case=="no")? tablet_thickness+keyguard_thick : case_thickness+max(keyguard_thick-case_to_screen_depth,0);
	fudge = 0.05;
	slot_to_case_edge_distance = clip_reach - clip_thickness;
	strap_cut = min(15,clip_width-4);

	difference(){
		union(){
		//base leg
		translate([-clip_bottom_length,-base_thickness,0])
		cube([clip_bottom_length+clip_thickness,base_thickness,clip_width]);

		//vertical leg
		translate([0,0,0])
		cube([clip_thickness,case_thick,clip_width]);

		//reach leg
		translate([-clip_reach,case_thick,0])
		cube([clip_reach+clip_thickness,clip_thickness,clip_width]);

		//spur
		translate([-clip_reach,case_thick,0])
		linear_extrude(height = clip_width)
		polygon(points=[[0,0],[1,-2],[3,-2],[2,0]]);
		}

		//chamfers for short edges of reach leg
		translate([clip_thickness-2,case_thick+clip_thickness-2,-fudge])
		linear_extrude(height = clip_width + fudge*2)
		polygon(points=[[0,2.1],[2.1,2.1],[2.1,0]]);
		translate([-clip_reach-fudge,case_thick+clip_thickness-2,-fudge])
		linear_extrude(height = clip_width + fudge*2)
		polygon(points=[[0,0],[0,2.1],[2.1,2.1]]);

		//chamfers for vertical leg
		translate([1,-base_thickness-fudge,2])
		rotate([-90,0,0])
		linear_extrude(height = base_thickness+case_thick+clip_thickness + fudge*2)
		polygon(points=[[0,2.1],[2.1,2.1],[2.1,0]]);
		translate([1,-base_thickness-fudge,clip_width+fudge])
		rotate([-90,0,0])
		linear_extrude(height = base_thickness+case_thick+clip_thickness + fudge*2)
		polygon(points=[[0,0],[2.1,0],[2.1,2.1]]);

		//chamfers for long edges of reach leg
		translate([-clip_reach,case_thick+clip_thickness-2,2-fudge])
		rotate([0,90,0])
		linear_extrude(height = clip_reach+clip_thickness + fudge*2)
		polygon(points=[[0,2.1],[2.1,2.1],[2.1,0]]);
		translate([clip_thickness,case_thick+clip_thickness+fudge,clip_width-2])
		rotate([0,-90,0])
		linear_extrude(height = clip_reach+clip_thickness + fudge*2)
		polygon(points=[[0,0],[2.1,0],[2.1,-2.1]]);
		
		//recess for bumper
		if (clip_bottom_length>=30){
			translate([-15+clip_thickness,-base_thickness+1,clip_width/2])
			rotate([90,0,0])
			cylinder(d=11,h=1.05);
		}

		//slots for strap
		translate([-clip_bottom_length+7.5-fudge,0,clip_width/2])
		union(){
			translate([0,-5,0])
			cube([15,2,strap_cut],center=true);
			
			translate([0,0,0])
			cube([15,2,strap_cut],center=true);
			
			translate([-2.5,-3,0])
			cube([5,6,strap_cut],center=true);
			
			translate([5,-3,0])
			cube([5,6,strap_cut],center=true);
		}
	}
}

// module base_keyguard(){
	// if (have_a_case=="no"){
		// difference(){
			// translate([0,0,-rail_height/2])
			// linear_extrude(height=rail_height) 
			// shape(tablet_width,tablet_height,ipad_fillet,0);
			
			// half_outer_chamfer(rail_height,tablet_height,tablet_width,ipad_fillet);
		// }
	// }
	// else{
		// difference(){
			// translate([case_x0+case_opening_width/2,case_y0+case_opening_height/2,-rail_height/2])
			// linear_extrude(height=rail_height) 
			// shape(case_opening_width,case_opening_height,case_opening_corner_radius,0);
			
			// translate([case_x0+case_opening_width/2,case_y0+case_opening_height/2,0])
			// half_outer_chamfer(rail_height,case_opening_height,case_opening_width,case_opening_corner_radius);
		// }
	// }
// }

module base_keyguard(){
	if (have_a_case=="no"){
		difference(){
			translate([0,0,-rail_height/2])
			linear_extrude(height=rail_height) 
			shape(tablet_width,tablet_height,ipad_fillet,0);
			
			half_outer_chamfer(rail_height,tablet_height,tablet_width,ipad_fillet);
		}
	}
	else{
		difference(){
			translate([case_x0+case_opening_width/2,case_y0+case_opening_height/2,-rail_height/2])
			linear_extrude(height=rail_height) 
			shape(case_opening_width,case_opening_height,case_opening_corner_radius,0);
			
			translate([case_x0+case_opening_width/2,case_y0+case_opening_height/2,0])
			half_outer_chamfer(rail_height,case_opening_height,case_opening_width,case_opening_corner_radius);
		}
	}
}

module half_outer_chamfer(extrusion_height,keyguard_height,keyguard_width,corner_radius){
    translate([0,0,extrusion_height/2+fudge])
    difference(){
        translate([0,0,-chamfer_size/2])
        linear_extrude(height=chamfer_size)
        shape(keyguard_width,keyguard_height,corner_radius,fudge);
        
        translate([0,0,-chamfer_size/2-fudge])
        hull(){
            linear_extrude(height = fudge)
            shape(keyguard_width,keyguard_height,corner_radius,fudge);
            
            translate([0,0,chamfer_size+fudge])
            linear_extrude(height=fudge)
            offset(delta=-chamfer_size)
            shape(keyguard_width,keyguard_height,corner_radius,fudge);
        }
    }
}

module shape(shape_width,shape_height,corner_radius,fudge){
	offset(r=corner_radius)
	square([shape_width+fudge-corner_radius*2,shape_height+fudge-corner_radius*2],center=true);
}

