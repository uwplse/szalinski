//Title: Universal Hook
//Author: Kevin Lin
//Date: 2016-9-18
//License: Creative Commons - Share Alike - Attribution

//Usage: Alter parameters based on measurement of items. Hook is divided into 3 sections: top, center, bottom. Top and bottom both include 2 curved sections (inner and outer), which have variables responsible for altering angle and radius of the curve. Credits to Alex English for his Wedge module.

//Number of facets used to generate an arc
$fn = 100;

//////////////////////////////////PARAMETERS/////////////////////////////////////

//GLOBAL

//Global Extrusion height
hook_thickness = 3;
//Global Hook Width
hook_width = 4;

//TOP

//top inner curve radius
top_inner_radius = 5;
//top inner curve angle
top_inner_angle = 90;

//top outer curve radius
top_outer_radius = 5;
//top outer curve angle
top_outer_angle = 160;

//top bar length
top_length = 0;


//CENTER

//center bar length
center_length = 25;


//BOTTOM

//bottom inner curve radius
bottom_inner_radius = 10;
//bottom inner curve angle
bottom_inner_angle = 133;

//bottom outer curve radius
bottom_outer_radius = 7;
//bottom outer curve angle
bottom_outer_angle = 110;

//bottom bar length
bottom_length = 10;


//////////////////////Wedge Module from Alex English/////////////////////////////

//Title: Wedge Module
//Author: Alex English - ProtoParadigm
//Date: 1/4/2013
//License: Creative Commons - Share Alike - Attribution

//Usage: Include in your other .scad projects and call wedge with arguments for the height of the wedge, the radius of the wedge, and the angle of the wedge in degrees.  The resulting wedge will be placed with the point at the origin, extending into the z axis, with the angle starting at the x axis and extending counter-clockwise as per the right-hand rule.

//Updated: 1/12/2013 - Increased dimensions of wedge to be revoved when angle is more than 180 as per suggestion from kitwallace.

module wedge_180(h, r, d)
{
	rotate(d) difference()
	{
		rotate(180-d) difference()
		{
			cylinder(h = h, r = r);
			translate([-(r+1), 0, -1]) cube([r*2+2, r+1, h+2]);
		}
		translate([-(r+1), 0, -1]) cube([r*2+2, r+1, h+2]);
	}
}

module wedge(h, r, d)
{
	if(d <= 180)
		wedge_180(h, r, d);
	else
		rotate(d) difference()
		{
			cylinder(h = h, r = r);
			translate([0, 0, -1]) wedge_180(h+2, r+1, 360-d);
		}
}

//Example: wedge(10, 20, 145); //would create a wedge 10 high, with a radius of 20, and an angle of 33 degrees.


///////////////////////////////////////////////////////////////////////////////////


module curved_section(thickness, width, radius, angle) {
    translate([-radius-width/2,0,0])
    difference() {
        wedge(thickness,radius+width,angle);
        translate([0,0,0])wedge(thickness,radius,angle);
    }
}


//Top inner curve
rotate([0,0,0]) translate([0,center_length/2])
curved_section(hook_thickness,hook_width,top_inner_radius,top_inner_angle);

//Top bar
translate([-top_inner_radius-hook_width/2-sin(top_inner_angle-90)*top_inner_radius,center_length/2+sin(top_inner_angle)*top_inner_radius,0]) rotate([0,0,top_inner_angle])
cube([hook_width,top_length,hook_thickness]);


//Top outer curve
translate([-top_inner_radius-hook_width/2-sin(top_inner_angle-90)*top_inner_radius-sin(top_inner_angle)*top_length, center_length/2+sin(top_inner_angle)*top_inner_radius-sin(top_inner_angle-90)*top_length,
            0]) 

rotate([0,0,top_inner_angle]) 

translate([hook_width/2,0])
curved_section(hook_thickness,hook_width,top_outer_radius,top_outer_angle);


//Center bar
translate([0,0,hook_thickness/2])cube([hook_width,center_length,hook_thickness],center=true);


//Bottom inner curve
translate([0,-center_length/2]) rotate([0,0,180]) 
curved_section(hook_thickness,hook_width,bottom_inner_radius,bottom_inner_angle);

//Bottom bar
translate([bottom_inner_radius+hook_width/2+sin(bottom_inner_angle-90)*bottom_inner_radius,-center_length/2-sin(bottom_inner_angle)*bottom_inner_radius,0]) rotate([0,0,bottom_inner_angle]) 
translate([-hook_width,-bottom_length,0])
cube([hook_width,bottom_length,hook_thickness]);



//Bottom outer curve
translate([bottom_inner_radius+hook_width/2+sin(bottom_inner_angle-90)*bottom_inner_radius,-center_length/2-sin(bottom_inner_angle)*bottom_inner_radius,0]) rotate([0,0,bottom_inner_angle]) 
translate([-hook_width/2,-bottom_length,0])
rotate([0,0,180]) 
curved_section(hook_thickness,hook_width,bottom_outer_radius,bottom_outer_angle);


