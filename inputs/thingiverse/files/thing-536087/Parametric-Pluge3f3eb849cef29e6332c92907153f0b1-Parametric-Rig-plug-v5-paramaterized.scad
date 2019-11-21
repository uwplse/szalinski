///////////////////////////////////////////////////////////////////////////////
/////////////////////       Parametric Plug      /////////////////////////////
/*/////////////////////////////////////////////////////////////////////////////
date started:
date finished:
modeler:		
copyright:		N/A
comments:		Rig Plug 14mm
*//////////////////////////////////////////////////////////////////////////////
/////////////////////////// - Parameters - ////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
$fn=50; // 100
// use <boxes.scad>;
//height = 80; // [10:145]
//bottom_inner_dia = 11.5; // 11.5mm

//// the dia of the hole to plug (+/-)
bottom_inner_dia = 11.5; // [05:50]

//bottom_plug_height = 10; //10mm

// the height of the bottom most part of the plug
bottom_plug_height = 10; // [05:20]

//bottom_plug_angle_ratio = .89; //.89 amount of angle for the bottom of the plug

// the angle ratio of the slant of the top and bottom of the bottom of the plug (affects difference)
bottom_plug_angle_ratio = .89; // [.50:1]

//stem_dia = 6; // 6mm

// the dia of the stem of the plug
stem_dia = 6; // [1.5:15]

////////////// math //////// - Don't Change - //////////////// math ///////////
bottom_inner_rad1 = bottom_inner_dia/2;
bottom_inner_rad2 = (bottom_inner_dia/2)*bottom_plug_angle_ratio;
base_plug_dia = bottom_inner_dia*1.1; // 1.1
base_plug_rad = base_plug_dia/2;
base_plug_height = bottom_plug_height/1.6; // 1.6
stem_height = bottom_inner_dia*1.6;  // 1.6
stem_rad = stem_dia/2;
///////////////////////////////////////////////////////////////////////////////
//////////////////////////// - Renders - //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
bottom_plug();
base_plug();
stem();
ball();
translate([0,0,(bottom_plug_height)+(base_plug_height)]) lower_belt();
translate([0,0,(bottom_plug_height)+(base_plug_height)+(stem_height)-(stem_rad)]) upper_belt();
///////////////////////////////////////////////////////////////////////////////
///////////////////////////// - Modules - /////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
module bottom_plug()
{
	cylinder(h = bottom_plug_height, r1=bottom_inner_rad2, r2=bottom_inner_rad1);
}
///////////////////////////////////////////////////////////////////////////////
module base_plug()
{
	translate([0,0,bottom_plug_height]) cylinder(h = base_plug_height, r1=bottom_inner_rad1, r2=base_plug_rad);
}
///////////////////////////////////////////////////////////////////////////////
module stem()
{
	translate([0,0,bottom_plug_height+base_plug_height]) cylinder(h = stem_height, r1=stem_rad, r2=stem_rad);
}
///////////////////////////////////////////////////////////////////////////////
module ball()
{
	translate([0,0,bottom_plug_height+base_plug_height+stem_height]) sphere(r=stem_dia);
}
///////////////////////////////////////////////////////////////////////////////
module lower_belt()
{
	rotate_extrude()
	translate([base_plug_rad, 0, 0])
	circle(r = 1);
}
///////////////////////////////////////////////////////////////////////////////
module upper_belt()
{
	rotate_extrude()
	translate([stem_rad, -stem_rad/2, 0])
	circle(r = 1);
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////// - Echos - ///////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
echo(" -- /////////// - Echos - ////////////// --");
echo("$fn - Resolution = ",$fn,"// Resolution"); 
//echo(" = ", ); //Description
echo(" -- /////////////////////////////////////// --");
echo("bottom_inner_dia = ",bottom_inner_dia,"// the dia of the hole to plug (+/-)");
echo("bottom_plug_height = ",bottom_plug_height,"// the height of the bottom most part of the plug");
echo("bottom_plug_angle_ratio = ",bottom_plug_angle_ratio,"// the angle ratio of the slant of the top and bottom of the bottom of the plug (affects difference)");
echo(" -- /////////////////////////////////////// --");
echo("bottom_inner_rad1 * 2 = ",bottom_inner_rad1 * 2,"// top dia of the bottom plug"); 
echo("bottom_inner_rad2 * 2  = ",bottom_inner_rad2 * 2,"// bottom dia of the bottom plug");
echo("difference = ",(bottom_inner_rad1 * 2)-(bottom_inner_rad2 * 2),"// difference of the top and bottom dia of the bottom plug");
echo(" -- /////////////////////////////////////// --");
echo("bottom_inner_rad1 = ",bottom_inner_rad1,"// top radius of the bottom plug");
echo("bottom_inner_rad2 = ",bottom_inner_rad2 ,"// bottom radius of the bottom plug");
echo("difference = ",(bottom_inner_rad1)-(bottom_inner_rad2),"// difference of the top and bottom radius of the bottom plug");
echo(" -- /////////////////////////////////////// --");
echo("base_plug_dia = ",base_plug_dia,"// the dia of the middle of the plug");
echo("base_plug_rad = ",base_plug_rad,"// the radius of the middle of the plug");
echo("base_plug_height = ",base_plug_height,"// the height of the middle of the plug");
echo("stem_height = ",stem_height,"// the height of the stem of the plug");
echo("stem_dia = ",stem_dia,"// the dia of the stem of the plug");
echo("stem_rad = ",stem_rad,"// the radius of the stem of the plug");
echo(" -- /////////////////////////////////////// --");
echo("Ball diameter = ",stem_dia*2," This fits into the rig hole with a little wiggle room - 12mm");
echo("Upper Base Plug diameter = ",base_plug_rad*2," This is hidden by the upper belt - 12.65mm");
echo("Lower Belt Outer diameter = 14.58mm");
echo(" -- ////////////  Random Calculations  ///////////// --");
echo("(bottom_plug_height/1.25)*1.6 = ",(bottom_plug_height/1.25)*1.6);
echo("(bottom_plug_height)+(base_plug_height)+(stem_height)-(bottom_inner_rad1)/1.5 = ",(bottom_plug_height)+(base_plug_height)+(stem_height)-(bottom_inner_rad1)/1.5);
echo("(bottom_plug_height)+(base_plug_height)+(stem_height) = ",(bottom_plug_height)+(base_plug_height)+(stem_height));
echo(" -- /////////////////////////////////////// --");
echo("clip - ([0,0,0])  ");
echo("clip - translate([0,0,0])  ");
echo("clip - rotate([0,0,0])  ");
echo(" -- /////////////////////////////////////// --");
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////////////////////////////// - Clip_Pad - ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
//	([0,0,0])
//	translate([0,0,0]){
//	rotate([0,0,0]){
//
//  -- Golden Rule of 1.6
//
// roundedBox([width, height, depth], float radius, bool sidesonly);
// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);
// size is a vector [w, h, d]
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////