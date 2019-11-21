/*
*	Parametric Straight Track for OS Railway System
*
*	Author: Timo Novak
*	Date: 2017-04-02
*
*	License: Creative Commons - Attribution - Non-Commercial 
*/

track_type = 1; //[0:Straight,1:Curve]

/* [Straight Track Only] */
//in mm
track_length = 100;

/* [Curved Track Only] */
//in degrees
curve_angle = 30;
//in mm
curve_radius = 300;

/* [Hidden] */

gauge = 32; //track gauge in mm
tie_length = 50;
tie_width = 6;
tie_width_connector = 9; //connector tie width
tie_height = 2;
tie_height_connector = 3;
tie_spacing_default = 15; //tie spacing, is being rounded for fitting

rail_foot = 6; //bottom rail width
rail_foot_height = 1; //height of rail foot
rail_head = 2; //top rail width
rail_height = 7; //overall rail height

rail_shift = gauge*.5+rail_head*.5; 	//translation of rails in x direction

in_dot_y = 5.15; //y depth of the inner connector dot
out_dot_y = 4.85; //y depth of the outer connector dot

in_dot_arc_l = in_dot_y*180/(PI*(curve_radius-rail_shift)); //arc angle of inner dot, left

arc_length = PI/180*curve_angle*curve_radius;

$fn = 48;

if(track_type == 0)
straight_track(track_length);
else
curved_track(curve_radius,curve_angle);

//straight track
module straight_track(length)
{
	//checking if piece is long enough
	if(length >= in_dot_y+tie_width_connector){
		
		//creating both connectors
		difference(){
			connector();
			info_text();
		}
		translate([0,length,0])
		rotate([0,0,180])
		connector();
	
		//creating left rail
		translate([-rail_shift,0,0])
		rail_straight(length-in_dot_y);
	
		//creating right rail
		translate([rail_shift,in_dot_y,0])
		rail_straight(length-in_dot_y);
	
		//creating ties
		track_ties();
	}
	else 
	{
		echo("ERROR: TRACK LENGTH TOO SHORT");
	}
}

//curved track
module curved_track(radius, angle)
{
	//radius of left rail, for module curved_rail
	left_radius = radius-rail_shift;
	//radius of right rail, for module curved_rail
	right_radius = radius+rail_shift;
	
	if(curve_radius < 100)
		echo("ERROR: CURVE RADIUS TOO SMALL");
	else if(arc_length < in_dot_y+tie_width_connector)
		echo("ERROR: TRACK LENGTH TOO SHORT");
	else if(curve_angle >180 && curve_angle < 360)
		echo("ERROR: ANGLE TOO LARGE");
	else if(curve_angle < 360){
		//left rail
		difference(){
			union(){
				difference(){
					translate([-rail_shift,0,0])
					curved_rail(left_radius, angle-in_dot_arc_l);
					translate([-curve_radius,0,0])
					rotate([0,0,curve_angle])
					translate([curve_radius,0,0])
					rotate([0,0,180])
					connector_dot_inner();
				}
				//right rail
				difference(){
					translate([rail_shift,0,0])
					curved_rail(right_radius,30);
					connector_dot_inner();
				}
			}
			curved_rail_boolean(curve_radius,curve_angle);
		}
		//ties
		track_ties_curved(radius, 0,angle);
		
		//connector ties
		difference(){
			connector();
			info_text_1();
		}
		translate([-curve_radius,0,0])
		rotate([0,0,curve_angle])
		translate([curve_radius,0,0])
		rotate([0,0,180])
		difference(){
			connector();
			info_text_2();
		}

	}
	else if(curve_angle >= 360)//angle is >= 360°
	{
		//inner rail
		translate([-rail_shift,0,0])
		curved_rail(left_radius, 360);
	
		//outer rail
		translate([rail_shift,0,0])
		curved_rail(right_radius,360);
		
		//ties
		track_ties_360();
	}
}

//info text for first connector, containing radius
module info_text_1()
{
	string = str("R",round(curve_radius));
	scale([-1,1,1])
	translate([0,2,-.5])
	linear_extrude(1)
	text(text = string, halign = "center", size = tie_width_connector-4); 
}

module info_text_2()
{
	string = str(round(curve_angle),"°");
	scale([-1,1,1])
	translate([0,2,-.5])
	linear_extrude(1)
	text(text = string, halign = "center", size = tie_width_connector-4); 
}

//A curved rail, end := end angle
module curved_rail(radius, end)
{
    translate([-radius,0,0])
    rotate_extrude($fn = 400) 
    translate([radius,0,0])
    rail_profile();
	
}

//boolean element to remove rail circle
module curved_rail_boolean(radius,end)
{
	translate([-radius,0,0])
	rotate([0,0,end])
	translate([-5*radius,0,0])
	cube([10*radius,radius*10,20]);
	
	scale([1,-1,1])
	translate([-7.5*radius,0,0])
	cube([10*radius,radius*10,20]);
}

//Rail profile, 2D
module rail_profile()
{
		translate([0,rail_foot_height*.5+2,0])
		square([rail_foot,rail_foot_height],center = true); //Bottom
		translate([0,rail_height*.5+2,0])
		square([rail_head,rail_height],center = true); //Top
}

//creates ties for track piece, except connector ties
module track_ties_curved()
{
	tie_w_diff = tie_width_connector-tie_width;
	//difference between connector tie width an normal tie width
	
	no_ties = round((arc_length-2*tie_w_diff)/tie_spacing_default); //number of ties except connector ties


	if(no_ties > 1){
			tie_spacing = (arc_length-tie_width-2*tie_w_diff)/no_ties;

		tie_start = tie_width*.5 + tie_spacing;
		tie_end = arc_length-tie_start+.1;

		for(i = [tie_start:tie_spacing:tie_end])
		{
			zrot = (i+tie_w_diff)*180/(PI*curve_radius);
			translate([-curve_radius,0,0])
			rotate([0,0,zrot])
			translate([curve_radius,0,0])
			tie();
		}
	}
}

//creates ties for circle (angle = 360°)
module track_ties_360()
{
	no_ties = round(2*PI*curve_radius/tie_spacing_default); //number of ties except connector ties

	if(no_ties > 1){
			tie_spacing = 2*PI*curve_radius/no_ties;

		tie_start = 0;
		tie_end = 2*PI*curve_radius+.1;

		for(i = [tie_start:tie_spacing:tie_end])
		{
			zrot = i*180/(PI*curve_radius);
			translate([-curve_radius,0,0])
			rotate([0,0,zrot])
			translate([curve_radius,0,0])
			tie();
		}
	}
}

//creates a text to be written in a connector tie, containing the length
module info_text()
{
	string = str("L",round(track_length));
	scale([-1,1,1])
	translate([0,2,-.5])
	linear_extrude(1)
	text(text = string, halign = "center", size = tie_width_connector-4); 
}
//creates ties for track piece, except connector ties
module track_ties()
{
	tie_w_diff = tie_width_connector-tie_width;
	//difference between connector tie width an normal tie width
	
	no_ties = round((track_length-2*tie_w_diff)/tie_spacing_default); //number of ties except connector ties
	
	if(no_ties > 0){
		tie_spacing = (track_length-tie_width-2*tie_w_diff)/no_ties;

		tie_start = tie_width*.5 + tie_spacing;
		tie_end = track_length-tie_start+.1;

		for(i = [tie_start:tie_spacing:tie_end])
		{
			translate([0,i+tie_w_diff,0])
			tie();
		}
	}
}

/////////
// start connector version 2017-04-02c
/////////
module connector()
{
	difference()
	{
		union(){
			connector_tie();
			connector_slope();
			scale([-1,1,1])
			connector_slope();
		}
	connector_dot_inner();
	}
	connector_dot_outer();
	dot_slope();
	translate([-rail_shift,-out_dot_y,0])
	rail_straight(out_dot_y);
}

//slope on connector dot
module dot_slope()
{
	intersection()
	{
		scale([1,1,10])
		connector_dot_outer();
		scale([1,-1,1])
		connector_slope();
	}
}

//slope for connector ties
module connector_slope()
{
	translate([-tie_length*.5,0,3])
	rotate([0,-16,0])
	scale([1,1,-1])
	cube([8,tie_width_connector,2.5],center = false);
}

//Connector
module connector_tie()
{
	translate([0,tie_width_connector*.5,0])
	scale([1,tie_width_connector/tie_width,tie_height_connector/tie_height])
	tie();
}

//connector piece to be subtracted from connector tie
module connector_dot_inner()
{
	translate([rail_shift,in_dot_y*.5,0])
	difference(){
		translate([0,0,-.1])
		cylinder(d = 8, h = 10);
		translate([-5,in_dot_y/2,-.1])
		cube([10,4,11], center = false);
	}
}

//connector piece to be added to connector tie
module connector_dot_outer()
{
	translate([-rail_shift,-out_dot_y*.5,0])
	difference(){
		cylinder(d = 7.6, h = 3);
		translate([-5,-out_dot_y*.5-4,-.1])
		cube([10,4,11], center = false);
	}
}
/////////
// end connector version 2017-04-02
/////////

//Straight Rail piece
module rail_straight(length)
{
	translate([0,length*.5,2])
	scale([1,length,1])
	{
		translate([0,0,.5])
		cube([6,1,1],center = true); //Bottom
		translate([0,0,3.5])
		cube([2,1,7],center = true); //Top
	}
}

//A standard tie
module tie()
{
	translate([0,0,1])
	cube([tie_length,tie_width,tie_height],center = true);
}
