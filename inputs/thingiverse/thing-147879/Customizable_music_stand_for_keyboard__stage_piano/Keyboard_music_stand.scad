// Customizeable Keyboard music stand - Design by Dominik Platz 08.09.2013
// Default values are for a Fame Stage SP


// User-defined parameters
//-------------------------

keyboard_holes_distance = 430;

// lengths of plane and rods
plane_width = 430;
plane_height = 300;
keyboard_holes_length = 28.5;


rod_d = 4; // diameter of rods
rod_d_keyboard = 4; // diameter of rods into Keyboard

tilt = 15; // angle of plane tilt in °

corner_diameter = 10; // corner "sharpness"
corner_width = 10;	// corner thickness
corner_length = 30; // corner size in plane
base_width = 20;	// place for the notes
stabilize_length = 30;	// length for the support angles on the bottom


// Parameters for me
space = 10; // Distance from the rod-ends to the intersection
$fn = 30;
diagonal_rod_angle = atan(plane_width / plane_height);
diagonal_rod_length = sqrt(plane_width*plane_width/4 + plane_height*plane_height/4);
real_diagonal_rod_length = diagonal_rod_length-space*2;
real_side_rod_length = plane_height-space*2;
real_bottom_rod_length = plane_width-space*2;



// View-settings
show_rods = false;
show_corners = true;
show_base = true;

translate([0,0,corner_width])
rotate([90-tilt,0,0])
if(show_rods == true)
{
 		rods();
}

translate([0,0,corner_width])
rotate([90-tilt,0,0])
difference()
{
	union() {
		if(show_base == true)
		{
			base();
		}
		if(show_corners == true)
		{
			corners();
		}
	}
	union() 
	{
		rods();
		translate([plane_width/3,0,0])
		cube([0.1,1000,1000], center=true);
		translate([plane_width/3*2,0,0])
		cube([0.1,1000,1000], center=true);
	}
	
}

module base()
{
	// left, right arm
	for (i = [0,plane_width])
	{
	hull()
	{
		rotate([tilt,0,0])
		translate([i,-corner_width+0.5,0])
		rotate ([90,0,0])
		cylinder(h = 1, r = corner_diameter/2, center = true);

		translate([i,base_width-0.5,0])
		rotate ([90,0,0])
		cylinder(h = 1, r = corner_diameter/2, center = true);

		rotate([tilt,0,0])
		translate([i,-corner_width+0.5,25])
		rotate ([90,0,0])
		cylinder(h = 1, r = corner_diameter/2, center = true);

		translate([i,base_width-0.5,25*(1+sin(tilt))])
		rotate ([90,0,0])
		cylinder(h = 1, r = corner_diameter/2, center = true);
	}
	}	


// plattform

	hull()
	{
		for (i = [0,plane_width])
		{
			rotate([tilt,0,0])
			translate([i,-corner_width+0.5,25-corner_diameter/4])
			rotate ([90,0,0])
			cylinder(h = 1, r = corner_diameter/4, center = true);

			translate([i,base_width-0.5 + 0*base_width*sin(tilt),25*(1+sin(tilt))-corner_diameter/4])
			rotate ([90,0,0])
			cylinder(h = 1, r = corner_diameter/4, center = true);
		}
	}	

// back

	hull()
	{
		for (i = [0,plane_width])
		{
			rotate([tilt,0,0])
			translate([i,0,25])
			rotate ([90,0,0])
			cube([1,5,corner_width]) ;
		}
	}	


stabilize_angle(1);
translate([keyboard_holes_distance,0,0]) stabilize_angle(1);

// middle stabilize_angle
	translate([keyboard_holes_distance/2,0,30])
	{
		hull()
		{
			rotate([tilt,0,0])
			translate([0,-corner_width+0.5,-corner_diameter/2*(1+sin(tilt))])
			rotate ([90,0,0])
			cylinder(h = 1, r = 2.5, center = true);

			translate([0,base_width-0.5,-corner_diameter/2*(1-sin(tilt))])
			rotate ([90,0,0])
			cylinder(h = 1, r = 2.5, center = true);

			translate([0,base_width-0.5,-40])
			rotate ([90,0,0])
			cylinder(h = 1, r = 2.5, center = true);

	}

	}
}

module stabilize_angle(lenght)
{
	hull()
	{
		rotate([tilt,0,0])
		translate([0,-corner_width+0.5,-corner_diameter/2])
		rotate ([90,0,0])
		cylinder(h = 1, r = 2.5, center = true);

		translate([0,base_width-0.5,-corner_diameter/2])
		rotate ([90,0,0])
		cylinder(h = 1, r = 2.5, center = true);

		translate([0,base_width-0.5,-stabilize_length*lenght])
		rotate ([90,0,0])
		cylinder(h = 1, r = 2.5, center = true);

	}
}

module rods()
{
rotate([tilt,0,0])
translate([0,-corner_width/2,25])
{

//side_rods
translate([0,0,plane_height/2])
cylinder(h=plane_height-space*2, r = (rod_d) / 2, center = true);

translate([plane_width,0,plane_height/2])
cylinder(h=plane_height-space*2, r = (rod_d) / 2, center = true);
echo("Side rods: 2x ",plane_height-space*2,"mm");

// middle_rod
translate([plane_width/2,0,plane_height/4])
cylinder(h=plane_height/2-space*2, r = (rod_d) / 2, center = true);
echo("middle rod: 1x ",plane_height/2-space*2,"mm");

// bottom_rod
translate([plane_width/2,0,0])
rotate([0,90,0])
cylinder(h=plane_width-space*2, r = (rod_d) / 2, center = true);
echo("Bottom rod: 1x ",plane_width-space*2,"mm");


// diagonal rods
translate([0,0,plane_height])
rotate([0,-diagonal_rod_angle,0])
translate([0,0,-diagonal_rod_length/2])
cylinder(h=diagonal_rod_length-space*2, r = (rod_d) / 2, center = true);

translate([plane_width,0,plane_height])
rotate([0,diagonal_rod_angle,0])
translate([0,0,-diagonal_rod_length/2])
cylinder(h=diagonal_rod_length-space*2, r = (rod_d) / 2, center = true);
echo("Diagonal rods: 2x ",diagonal_rod_length-space*2,"mm");

echo("Total: ",(diagonal_rod_length-space*2+plane_height-space*2)*2 + plane_height/2-space*2 + plane_width-space*2,"mm");
}

// Keyboard holes
		translate([0,(keyboard_holes_length + corner_width)/2])
		rotate ([90,0,0])
		cylinder(h = keyboard_holes_length + corner_width, r = rod_d_keyboard/2, center = true);

		translate([keyboard_holes_distance,(keyboard_holes_length + corner_width)/2])
		rotate ([90,0,0])
		cylinder(h = keyboard_holes_length + corner_width, r = rod_d_keyboard/2, center = true);

}

module round_corners()
{
	translate([0,0,0])
	rotate([90,0,0])
	cylinder(r = corner_diameter / 2, h = corner_width, center = true);

	translate([0,0,plane_height])
	rotate([90,0,0])
	cylinder(r = corner_diameter / 2, h = corner_width, center = true);

	translate([plane_width,0,0])
	rotate([90,0,0])
	cylinder(r = corner_diameter / 2, h = corner_width, center = true);

	translate([plane_width,0,plane_height])
	rotate([90,0,0])
	cylinder(r = corner_diameter / 2, h = corner_width, center = true);

	translate([plane_width/2,0,plane_height/2])
	rotate([90,0,0])
	cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	
	translate([plane_width/2,0,0])
	rotate([90,0,0])
	cylinder(r = corner_diameter / 2, h = corner_width, center = true);

}

module corners()
{
rotate([tilt,0,0])
translate([0,-corner_width/2,25])
{
	translate([0,0,0])
	rotate([90,0,0])
	hull()
	{
		cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([corner_length,0,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([0,corner_length,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	}

	translate([0,0,plane_height])
	rotate([90,0,0])
	hull()
	{
		cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([corner_length*sin(diagonal_rod_angle),-corner_length*cos(diagonal_rod_angle),0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([0,-corner_length,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	}

	translate([plane_width,0,0])
	rotate([90,0,0])
	hull()
	{
		cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([-corner_length,0,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([0,corner_length,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	}

	translate([plane_width,0,plane_height])
	rotate([90,0,0])
	hull()
	{
		cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([-corner_length*sin(diagonal_rod_angle),-corner_length*cos(diagonal_rod_angle),0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([0,-corner_length,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	}

	translate([plane_width/2,0,plane_height/2])
	rotate([90,0,0])
	hull()
	{
		cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([corner_length*sin(diagonal_rod_angle),corner_length*cos(diagonal_rod_angle),0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([-corner_length*sin(diagonal_rod_angle),corner_length*cos(diagonal_rod_angle),0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([0,-corner_length,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	}
	
	translate([plane_width/2,0,0])
	rotate([90,0,0])
	hull()
	{
		cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([0,corner_length,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([-corner_length,0,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
		translate([corner_length,0,0]) cylinder(r = corner_diameter / 2, h = corner_width, center = true);
	}

}
}

