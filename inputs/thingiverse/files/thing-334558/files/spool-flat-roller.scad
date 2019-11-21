//Flat spool roller, by John Stäck 2014
//Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

//Intended for 3D printer filament spools (or other spools of similar dimensions), to lay flat on the
//roller. Works well with warped or damaged spools. Can be adapted for various size bearings, but
//designed for skateboard/inline (608) bearings.

/* [Settings] */
//Part to make
part = "hub"; // [hub:Hub,track:Track,spacer:Large spacer,smallspacer:Small spacer,all:All parts(demo)]


//Size of outer rim of hub. Whatever seems reasonable for balance.
main_diameter = 110;

//Thickness of bottom part of track
track_thickness = 1.0;

//Clearance between track and bearing
track_clearance = 1.0;

//Height of rim around track
rim_height = 1.5;

//Width of rim around track
rim_width = 1.5;

//Number of spokes for the track. Works well enough without for most sizes.
track_spokes = 0; //[0:8]

//Number of spokes for hub and spacer parts
spokes=3; //[0:8]

//Number of bearings on hub. Best if it is equal to or a divisor of the number of spokes for better stiffness
bearings=3; //[0:8]

//Wall thickness for the hub and spacer parts
wall_thickness=2;

//Diameter of inner hub, to fit spool
hub_diameter=14;

//Height of inner hub and spacer
hub_height=10;

//Spacer diameter. For less than about 30mm, use the small spacer.
spacer_diameter=55;

//Clearance between hub and inner hole in spacer
spacer_clearance=0.5;

//Circle resolution
$fn=72;



/* [Bearing] */
bearing_axle=8;
bearing_width=7;
bearing_diameter=22;
bearing_washer=11.5;


spacer_height=hub_height;

wall_height=bearing_diameter/2+bearing_axle/2+wall_thickness;

hub_radius=hub_diameter/2;

track_width = bearing_width+track_clearance;

inner_radius = main_diameter/2;
track_radius = inner_radius + track_width/2 + rim_width;
outer_radius = inner_radius + track_width + rim_width*2;

//Uses snap pins from http://www.thingiverse.com/thing:10541 by tbuser
use <pins/pins.scad>


module hub()
{

	//Rim
	difference() {
		cylinder(r=inner_radius,h=wall_height);
		translate([0,0,-1]) cylinder(r=inner_radius-wall_thickness,h=wall_height+2);
	}


	//Center hub
	difference() {
		cylinder(r=hub_radius,h=hub_height+wall_height);
		translate([0,0,-1]) cylinder(r=hub_radius-wall_thickness,h=hub_height+wall_height+2);
	}

	//Bearing pins
	for(v=[0:360/bearings:359])
		rotate([0,0,v])
		{
			//Pin
			translate([inner_radius+rim_width,0,bearing_axle/2-0.5])
				rotate([90,0,90]) pin(h=bearing_width+5,r=bearing_axle/2-0.1);

			//Bearing washer
			difference()
			{
				translate([inner_radius,0,bearing_axle/2-0.5])
					rotate([90,0,90]) cylinder(h=rim_width,r=11.5/2);
				translate([inner_radius-10,-10,-5]) cube([20,20,5]);
			}	
		}

	//Spokes
	for(v=[0:360/spokes:359])
		rotate([0,0,v])
		{
			//Spoke
			translate([hub_radius-0.1,-wall_thickness/2,0])
				cube([inner_radius-hub_radius+0.2,wall_thickness,wall_height]);
	
		}



}

module track()
{


	difference()
	{
		//Track base
		cylinder(r=outer_radius, h=track_thickness+rim_height);

		//Center hole
		translate([0,0,-1]) cylinder(r=inner_radius, h=track_thickness+rim_height+2);

		//Cut out the track
		translate([0,0,track_thickness])
		{
			difference()
			{
				cylinder(r=track_radius+track_width/2, h=rim_height+1);
				translate([0,0,-1]) cylinder(r=track_radius-track_width/2, h=rim_height+2);
			}
		}
	
	}
	if(track_spokes>0) for(v=[0:360/track_spokes:359])
	{
		rotate([0,0,v])
			translate([0,-track_width/2,0])
				cube([track_radius-track_width/2,track_width,track_thickness]);
	}
}

module spacer(diameter)
{
	//Inner cylinder
	difference()
	{
		cylinder(r=hub_radius+wall_thickness+spacer_clearance,h=spacer_height);
		translate([0,0,-1]) cylinder(r=hub_radius+spacer_clearance,h=spacer_height+2);
	}

	//Outer cylinder
	difference()
	{
		cylinder(r=diameter/2,h=spacer_height);
		translate([0,0,-1]) cylinder(r=diameter/2-wall_thickness,h=spacer_height+2);
	}

	for(v=[0:360/spokes:359])
		rotate([0,0,v])
		{
			//Spoke
			translate([hub_radius+spacer_clearance,-wall_thickness/2,0])
				cube([diameter/2-(hub_radius+spacer_clearance),wall_thickness,spacer_height]);
		}
}

//Solid spacer for smaller diameters
module smallspacer(diameter)
{
	difference()
	{
		cylinder(r=diameter/2+spacer_clearance,h=spacer_height);
		translate([0,0,-1]) cylinder(r=hub_radius+spacer_clearance,h=spacer_height+2);
	}
}

if(part=="hub")
	hub();
else if(part=="track")
	track();
else if(part=="spacer")
	spacer(spacer_diameter);
else if(part=="smallspacer")
	smallspacer(spacer_diameter);
else if(part=="all")
{
	track();

	translate([0,0,10]) hub();
	translate([0,0,50]) spacer(spacer_diameter);
	translate([0,0,80]) smallspacer(spacer_diameter);
}
else
	hub();
