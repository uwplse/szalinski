//Length of the arm, ball center to ball center, in milimeters.
length = 100;
//Do you want a nut trap? 
nut_trap = "yes";//[no,yes]
//Do you want to use two bolts or just one? (for longer arms, two bolts work better.)
bolt_holes = "two";//[one,two]
//What size of bolt do you want?
bolt_type = "1/4";//[M4,M5,M6,M8,8,10,1/4]

// The hexagon subroutine is from Catarina Mota's GPL OprnSCAD Shapes Library
// Full version available at http://svn.clifford.at/openscad/trunk/libraries/shapes.scad

module hexagon(size, height) {
  boxWidth = size/1.75; // 1.75 is ~ sqrt(3)
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module makeBoltHole() {
	if ("M4" == bolt_type )
	{
		cylinder(r= 2.05 , h=shell_thickness);
	}
	if ("M5" == bolt_type )
	{
                cylinder(r= 2.55 , h=shell_thickness);
        }
	if ("M6" == bolt_type )
	{
                cylinder(r= 3.05 , h=shell_thickness);
        }
	if ("M8" == bolt_type )
	{
                cylinder(r= 4.05 , h=shell_thickness);
        }
	if ("8" == bolt_type )
	{
                cylinder(r= 2.15 , h=shell_thickness);
        }
	if ("10" == bolt_type )
	{
                cylinder(r= 2.45 , h=shell_thickness);
        }
	if ("1/4" == bolt_type )
	{
                cylinder(r= 3.25 , h=shell_thickness);
        }

	if("yes" == nut_trap)
	{
		if ("M4" == bolt_type )
		{
			translate([0,0,28]) hexagon( 7.1 , 30 );
		}
		if ("M5" == bolt_type )
		{
			translate([0,0,28]) hexagon( 8.1 , 30 );
		}
		if ("M6" == bolt_type )
		{
			translate([0,0,28]) hexagon( 10.1 , 30 );
		}
		if ("M8" == bolt_type )
		{
			translate([0,0,28]) hexagon( 13.1 , 30 );
		}
		if ("8" == bolt_type )
		{
			translate([0,0,28]) hexagon( 8.8 , 30 );
		}
		if ("10" == bolt_type )
		{
			translate([0,0,28]) hexagon( 9.6 , 30 );
		}
		if ("1/4" == bolt_type )
		{
			translate([0,0,28]) hexagon( 11.2 , 30 );
		}
	}
}

ball_radius = 12.7; // The ball you're attaching to.
arm_width = 20;
shell_thickness = ball_radius+5.3; 
opening_slot = 12;

translate([0,0,17])
rotate(a=[180,0,0])
{
	difference()
	{
		union()
		{	
			//Outer shells at ends
			translate([-1*(length/2),0,0]) sphere(shell_thickness, center=true);
			translate([(length/2),0,0]) sphere(shell_thickness, center=true);
			//Connecting arm
			translate([0,0,(shell_thickness)/2]) rotate([45,0,0]) cube([length,arm_width,arm_width], center=true);
		}
		union()
		{
			//Interior hollows
			translate([-1*(length/2),0,0]) sphere(ball_radius, center=true);
			translate([(length/2),0,0]) sphere(ball_radius, center=true);
			//Shave off the top
			translate([0,0,27])  cube([length*2,100,20], center=true);
			//Shave off the bottom
			translate([0,0,-8])  cube([length*2,100,20], center=true);
			//Screw hole
			if ("one" == bolt_holes ) 
			{
				makeBoltHole();
			}
			else
			{
				translate([(length/2) - shell_thickness,0,0]) makeBoltHole();
				translate([(length/-2) + shell_thickness,0,0]) makeBoltHole();
			}
			//Exterior lip parts
			union()
			{
				translate([-1*((length/2) + 15),0,0]) cube([20,40,opening_slot], center=true);
				translate([-1*((length/2) +  5),shell_thickness*1.5,0]) rotate([90,0,0]) cylinder(r=opening_slot/2, h=shell_thickness*3);
			}
			union()
			{
				translate([1*((length/2) + 15),0,0]) cube([20,40,opening_slot], center=true);
				translate([1*((length/2) +  5),shell_thickness*1.5,0]) rotate([90,0,0]) cylinder(r=opening_slot/2, h=shell_thickness*3);
			}
		}
	}
}
