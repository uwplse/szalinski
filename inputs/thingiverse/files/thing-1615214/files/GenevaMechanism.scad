// Geneva Mechanism by Karl Helness, May 2016

// This program creates a geneva mechanism.
// The mecanism consists of a "geneva" wheel and a "moon" wheel, which, when mounted on the base plate
// can be exercised.

// The program can be animated in preview mode (use FPS = 25 and Steps = 100),
// and you may create stl files of the various parts
// Use What flag to set the mode of operation

// do you want to model?
What = "assembled";	// [moon wheel,geneva wheel,base,assembled,all parts]

/*[Dimensions]*/

// Slits in the geneva wheel, program is tuned for 7, but you may experiment
no_slits = 7;	// [6:9]

// Center distance between wheels
wheel_base = 25;	// [25:50]

// Radius of upper moon wheel (tune to wheel base)
moon_wheel_upper_radius = 9;	// [9:20]

// Radius of lower moon wheel (base) (tune to upper radius)
moon_wheel_base_radius = 18; // [18:30]

// Total height of upper and lower moon wheel
moon_wheel_height = 4;	// [2:8]

// Distance of moon wheel peg from rim of the moon wheel
peg_position = 7;	// [6:7]

/*[Printer Tolerances]*/

// Tolerance between base plate pegs and geneva/moon wheel
hub_tolerance = 0.2;

// Tolerance between moon wheel peg and geneva wheel sprockets
peg_tolerance = 0.15;

// Tolerance between moon wheel and geneva wheel sliding surfaces
wheel_tolerance = 0.25;

/*[Hidden]*/

// Radius of moon wheel peg
peg_radius = 3;

// Height of moon wheel peg
peg_height = 10;

// Heigth of the sprocket wheel (not including the base of the wheel)
geneva_wheel_height = 2;

// Distance between base moon wheel and geneva base wheel
base_tolerance = 2;

// Radius of hub for geneva and moon wheels
hub_radius = 3;

// Thickness of the plate on which the mechanism is mounted
base_plate_thickness = 2;

geneva_wheel_base_height = moon_wheel_height;	// Make the two the same height

slit_angle = 360/no_slits;			// Angle betwen slits in the geneva wheel

// This is the diameter of the shape used to make the cutout in the moon wheel
// Lots of math...
/*
// For testing
d = wheel_base * sin(slit_angle/2);
echo(d=d);
x = d - peg_radius;
echo(x=x);
y = x < moon_wheel_upper_radius ? sqrt(pow(moon_wheel_upper_radius,2) - pow(x,2)) : 0;
echo(y=y);
*/
// "upper" means as displayed in the assembled construction
geneva_upper_wheel_radius = wheel_base*cos(slit_angle/2)
	- (wheel_base * sin(slit_angle/2) - peg_radius < moon_wheel_upper_radius ?
		sqrt(pow(moon_wheel_upper_radius,2) - pow(wheel_base * sin(slit_angle/2) - peg_radius,2)) : 0);

//echo(geneva_upper_wheel_radius=geneva_upper_wheel_radius);
		
// This is the radius of the base wheel for the geneva wheel
geneva_base_wheel_radius = wheel_base-moon_wheel_base_radius - base_tolerance;

$fn = 48; // resolution

module geneva_mechanism()
{
	echo(What);
	if (What == "assembled") the_whole_thing();										// Display the assembled construction
	if (What == "animate") the_whole_thing($t);										// Animate, use menu item view>animate
	if (What == "base") base();																		// Display base
	if (What == "moon_wheel") moon_wheel();												// Display moon wheel
	if (What == "geneva_wheel") rotate([180,0,0]) geneva_wheel();	// Display geneva wheel
	if (What == "all parts") all_parts();													// Display all parts
}

// This module displays the tree parts (for printing)
module all_parts()
{
	translate([max(moon_wheel_base_radius,geneva_upper_wheel_radius)+wheel_base/2+4,0]) rotate([0,0,90]) base();
	translate([0,geneva_upper_wheel_radius+2,geneva_wheel_base_height])
		rotate([180,0,0]) geneva_wheel();
	translate([0,-moon_wheel_base_radius-2,0]) moon_wheel();
}

// This module creates the geneva wheel
module geneva_wheel()
{
  difference()
	{
    union()
		{
			// Make the base part of the wheel
			// To avoid flickering in preview mode, we cut the top off the base part a bit
			color("violet")
				cylinder(h=geneva_wheel_base_height-geneva_wheel_height/2,r=geneva_base_wheel_radius);
			
      color("green") 
			translate([0,0,geneva_wheel_base_height/2+wheel_tolerance])
				linear_extrude(geneva_wheel_height) difference()
				{
					// Make the base for the geneva wheel
					circle(r=geneva_upper_wheel_radius);
					// Make cutouts for the moon wheel
					for (i=[slit_angle/2:slit_angle:360])
						rotate([0,0,i]) color("orange")
							translate([-wheel_base,0,0]) circle(r=moon_wheel_upper_radius+wheel_tolerance);
					// Make the slits
					for (i=[0:slit_angle:360]) color("red")
						rotate([0,0,i])
							translate([-geneva_upper_wheel_radius,-peg_radius-peg_tolerance/2,0])
								union()
								{
									square([geneva_upper_wheel_radius-wheel_base+geneva_base_wheel_radius
										+1.5*peg_position-peg_radius+peg_tolerance,2*peg_radius+peg_tolerance]);
									translate([geneva_upper_wheel_radius-wheel_base+geneva_base_wheel_radius
										+1.5*peg_position-peg_radius+peg_tolerance,peg_radius+peg_tolerance/2,0])
											circle(r=peg_radius+peg_tolerance/2);
								}
				}
    }
		// Watermark the construction
		rotate([180,0,slit_angle/2])
			translate([-geneva_base_wheel_radius,0,geneva_wheel_height-geneva_wheel_base_height])
				rotate([0,0,90]) linear_extrude(geneva_wheel_height+1) text("kmh",size=3,halign="center");
		// Make the hub hole
    translate([0,0,-geneva_wheel_height]) linear_extrude(5*geneva_wheel_height)
			circle(r=peg_radius+hub_tolerance);
  }
}

// This module creates the moon wheel
module moon_wheel()
{
  difference()
	{
    union()
		{
			// The two moon wheels fused together
			color("orange")
				difference()
				{
					translate([0,0,moon_wheel_height/4])
						cylinder(r=moon_wheel_upper_radius,h=3*moon_wheel_height/4);
					translate([wheel_base,0,moon_wheel_height/4])
						cylinder(r=geneva_upper_wheel_radius, h=moon_wheel_height);
				}
			color("maroon") cylinder(r=moon_wheel_base_radius,h=moon_wheel_height/2);
			
			// The peg that activates the geneva wheel
			color("cyan") translate([moon_wheel_base_radius-peg_position,0,moon_wheel_height/4])
				cylinder(r=peg_radius,h=3*moon_wheel_height/4);
		}
		// Make the hub hole
		translate([0,0,-moon_wheel_height/4])
			cylinder(r=peg_radius + hub_tolerance, h=moon_wheel_height*3);
  }
}

// This is a base on which the mechanism can be attached
module base()
{
	color("grey") translate([-wheel_base,-wheel_base/2,0]) union()
	{
		// Base plate, rounded corners
		translate([2,2,0]) minkowski()
		{
			cube([2*wheel_base-4,wheel_base-4,base_plate_thickness/2]);
			cylinder(h=base_plate_thickness/2,r=2);
		}
		// Peg for moon wheel
		translate([wheel_base/2,wheel_base/2,0])
			cylinder(h=base_plate_thickness+moon_wheel_height+1,r=hub_radius);
			// Elevate a bit
		*translate([wheel_base/2,wheel_base/2,0])
			cylinder(h=base_plate_thickness+1,r=hub_radius+1);
		
		// Peg for geneva wheel
		translate([3*wheel_base/2,wheel_base/2,0])
			cylinder(h=base_plate_thickness+moon_wheel_height+1,r=hub_radius);
		*translate([3*wheel_base/2,wheel_base/2,0])
			cylinder(h=base_plate_thickness+1,r=hub_radius+1);
	}
}

// This is for display only, don't try to print this!
// If invoked with $t, like this: the_whole_thing($t), it will do animation (use menu item view>animate)
module the_whole_thing(t=0)
{
	moon_wheel_angle =t*360;
	
	/*
	// For testing
	echo(moon_wheel_angle=moon_wheel_angle);
	h = (moon_wheel_base_radius-peg_position)*sin(moon_wheel_angle);
	echo(h=h);
	y = (moon_wheel_base_radius-peg_position)*cos(moon_wheel_angle);
	echo(y=y);
	z = wheel_base-y;
	echo(z=z);
	echo(slit_angle=slit_angle);
	*/
	
	// This is (the negative) angle between the geneva wheel hub and the peg on the moon wheel
	geneva_angle = atan((moon_wheel_base_radius-peg_position)*sin(moon_wheel_angle)/
			(wheel_base-(moon_wheel_base_radius-peg_position)*cos(moon_wheel_angle)));
	//echo(geneva_angle=geneva_angle);
	//echo(moon_wheel_angle=moon_wheel_angle);
	// If the peg is not meshing, the geneva wheel shall not move
	geneva_wheel_angle = geneva_angle > slit_angle/2 || geneva_angle < -slit_angle/2
		|| moon_wheel_angle > 45 && moon_wheel_angle < 315 ? slit_angle/2 : geneva_angle;
	//echo(geneva_wheel_angle=geneva_wheel_angle);

	// The base
	base();
	// The moon wheel
  translate([-wheel_base/2,0,base_plate_thickness]) rotate([0,0,moon_wheel_angle]) moon_wheel();
	// For the assembly display, the geneva wheel is rotated 180 degrees around the x-axis
  translate([wheel_base/2,0,base_plate_thickness]) rotate([0,0,-geneva_wheel_angle]) geneva_wheel();
}
	
geneva_mechanism();
