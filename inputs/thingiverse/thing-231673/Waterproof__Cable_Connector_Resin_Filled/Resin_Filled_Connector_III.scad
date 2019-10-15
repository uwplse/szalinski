/* [Basics] */

// Which piece would you like to print?
parts = "both"; // [shell_only:Connector Shell,spacer_only:Spacers,both:Connector and Spacers]

// Outside diameter of the cable? (5 to 25mm)
cable_size = 10; // [5:25]

// How much room inside for wire splicing?
splice_size = 2.2; // [1.8:Slim (x1.8),2.2:Standard (x2.2),3.0:Large (x3.0),4.0:Oversize (x4.0)]

// What length should the shell of the connector be?
length = 4; // [2:Short (x2.0),4:Standard (x4.0),6:Long (x6.0),8:Oversize (x8.0)]

// How long are the end flanges? (1 to 20mm)
flange = 10; // [1:20]

/* [Extras] */

// Quality to generate STL? (number of facets per circle)
$fn = 30; // [0:Default (0),30:Medium (30),60:High (60),120:Super High (120)]

// Tolerance to add around the cable?
cable_tolerance = 1; // [0:Exact Fit (zero tolerance),0.5:Close Fit (0.5mm all round),1:Standard Fit (1mm),4:Loose Fit (2mm)]

// What is the wall thickness? (mm)
thickness = 1.5; 

// =================================================

shell_IR = (cable_size/2+cable_tolerance)*splice_size;
shell_OR = shell_IR+thickness;
shell_length = (cable_size+cable_tolerance*2)*length;
shell_half = shell_length/2;
flange_IR = cable_size*0.75+cable_tolerance;
flange_OR = flange_IR+thickness;
flange_length = shell_length+shell_OR*2+flange*2;  
flange_half = flange_length/2; 
hole_IR = cable_size*0.5+cable_tolerance;
smooth_IR = shell_OR*0.58;
spacer_IR = flange_IR;

//===================================================

print_part();

module print_part() 
{
	if (parts == "shell_only") 
	{
		Shell();
	} 
	else if (parts == "spacer_only") 
	{
		Spacers();
	} 
	else if (parts == "both") 
	{
		Both();
	} 
	else 
	{
		Both();
	}
}

module Both() 
{
	Shell();
	translate([ shell_OR, -(shell_OR+thickness)*2, -flange_OR]) Spacer1();
	translate([-shell_OR, -(shell_OR+thickness)*2, -flange_OR]) Spacer1();
	translate([ shell_OR,  (shell_OR+thickness)*2, -flange_OR]) Spacer2();
	translate([-shell_OR,  (shell_OR+thickness)*2, -flange_OR]) Spacer2();
}

module Spacers() 
{
	translate([ shell_OR, -(shell_OR + thickness*2), -flange_OR]) Spacer1();
	translate([-shell_OR, -(shell_OR + thickness*2), -flange_OR]) Spacer1();
	translate([ shell_OR,  (shell_OR + thickness*2), -flange_OR]) Spacer2();
	translate([-shell_OR,  (shell_OR + thickness*2), -flange_OR]) Spacer2();
}

module Spacer1() 
{
	rotate(a=[0,-90,0])
	{
		// Spacer 1 - round inside
		difference()
		{
			union()
			{
				translate([0, -shell_OR, shell_OR*0.75]) cube(size = [thickness,shell_OR*2,thickness*2], center=false);
				translate([0, -spacer_IR, 0]) cube(size = [thickness,spacer_IR*2,shell_OR*0.75], center=false);
				rotate([0,90,0]) cylinder(thickness, spacer_IR, spacer_IR);
			}
			union()
			{		
				translate([-1, -(spacer_IR-thickness*2), 0]) cube(size = [thickness+2,(spacer_IR-thickness*2)*2,shell_OR*75+thickness*2+1], center=false);
				translate([-1, 0, 0]) rotate([0,90,0]) cylinder(thickness+2, spacer_IR-thickness*2, spacer_IR-thickness*2);
			}
		}	
	}
}

module Spacer2() 
{
	rotate(a=[0,-90,0])
	{
		// Spacer 2 - cross inside
		union()
		{
			translate([0, -shell_OR, shell_OR*0.75]) cube(size = [thickness,shell_OR*2,thickness*2], center=false);
			translate([0, -thickness, -spacer_IR]) cube(size = [thickness,thickness*2,shell_OR*0.75+spacer_IR], center=false);
			translate([0, -(spacer_IR+thickness), -thickness]) cube(size = [thickness,spacer_IR*2+thickness*2,thickness*2], center=false);				
		}	
	}
}

module Shell() {
	difference()
	{
		difference()
		{
			union()
			{
				// form the outside shell
				translate ([-shell_half,0,0]) rotate([0,90,0]) cylinder(shell_length, shell_OR, shell_OR);
				translate ([-flange_half,0,0]) rotate([0,90,0]) cylinder(flange_length, flange_OR, flange_OR);
				translate ([-shell_half,0,0]) sphere(shell_OR);
				translate ([ shell_half,0,0]) sphere(shell_OR);
				
				// Add a small ridge on the end to hold the tape
				translate ([-flange_half,0,0]) rotate([0,90,0]) cylinder(thickness, flange_OR+thickness/2, flange_OR+thickness/2);
				translate ([flange_half-thickness,0,0]) rotate([0,90,0]) cylinder(thickness, flange_OR+thickness/2, flange_OR+thickness/2);
			}
			// flatten the bottom
			translate ([-(flange_half+1),-shell_OR,-(shell_OR+1)]) cube(size = [(flange_length+2),shell_OR*2,(shell_OR-flange_OR+1)], center = false);	
		}

		difference()
		{
			union()
			{
				// cut out the centre shell
				translate ([-shell_half,0,0]) rotate([0,90,0]) cylinder(shell_length, shell_IR, shell_IR);
				translate ([-shell_half,0,0]) sphere(shell_IR);
				translate ([ shell_half,0,0]) sphere(shell_IR);

				// cut out the inside of the flange
				translate ([-(flange_half-thickness),0,0]) rotate([0,90,0]) cylinder(flange_length-thickness*2, flange_IR, flange_IR);

				// take off the top
				translate ([-(shell_half+shell_OR),-shell_OR,shell_OR*0.75]) cube(size = [(shell_length+shell_OR*2),shell_OR*2,shell_OR], center = false);	

				// smooth around the top edge
				translate ([-shell_half,-smooth_IR,0]) cube(size = [(shell_length),smooth_IR*2,shell_OR], center = false);
				translate ([-shell_half,0,0]) cylinder(shell_OR, smooth_IR, smooth_IR);
				translate ([ shell_half,0,0]) cylinder(shell_OR, smooth_IR, smooth_IR);

				// take out the final hole for the cable to pass through (end to end)
				translate ([-(flange_half+1),0,0]) rotate([0,90,0]) cylinder(flange_length+2, hole_IR,hole_IR);
			}
			// flatten the bottom of the inside
			translate ([-(flange_half+1),-shell_IR,-(shell_IR+1)]) cube(size = [(flange_length+2),shell_IR*2,(shell_IR-flange_IR+1)], center = false);	
		}
	}
}


