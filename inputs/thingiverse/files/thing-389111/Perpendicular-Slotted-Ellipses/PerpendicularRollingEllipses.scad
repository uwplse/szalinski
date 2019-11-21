

//Variables for customizer
// preview[view:south, tilt:top diagonal]

//The (typically larger) diameter of an ellipse (mm)
major_diameter = 25; //[10:100]

//When 1000, minor dia=major dia. (ratio*1000)
minor_diameter_ratio = 1000; //[500:1414.2] 

//Thickness of the material (mm)
thickness = 1; //[1,2,5]

//How to orient the ellipses
Display = "3D"; //[3D, Flat]

/* [Animation] */
//Time step
time = 0; //[0:100]

/* [Hidden] */
//Detail ($fn)
$fn=100; 

$t = time / 100;
if(Display == "3D")
	PerpendicularRollingEllipses(majorDia = major_diameter, minorDia = major_diameter*minor_diameter_ratio / 1000, thickness = thickness, cut=false);
else
	PerpendicularRollingEllipses(majorDia = major_diameter, minorDia = major_diameter*minor_diameter_ratio / 1000, thickness = thickness, cut=true);


//Limit: sqrt(2)*a <= b, or separation between centers becomes complex (not a real solution)

//Interesting objects:
//1. Rolls in two directions; b=sqrt(2)*a; no displacement between centers
//PerpendicularRollingEllipses(majorDia = 2 * inch, minorDia = 2*sqrt(2)*inch, thickness = 1);
//2. b == a; circle (not ellipse); Displacement=sqrt(2)*radius
//PerpendicularRollingEllipses(majorDia = 2 * inch, minorDia = 2*inch, thickness = 1);
//3. b < a
//PerpendicularRollingEllipses(majorDia = 2 * inch, minorDia = 1.2*inch, thickness = 1);



module PerpendicularRollingEllipses(
majorDia = 2 * inch,
minorDia = 2*inch,
thickness = 3,
cut = false
)
{
	
	//From "How Round is Your Circle"
	//Chapter 13 "Finding Some Equilibrium"
	//Page 35 of 44
	
	//separation (mm) = sqrt(4a^2 - 2b^2)

	assign(a=majorDia / 2, b = minorDia / 2)
	{
		assign(separation = sqrt(4*pow(a,2) - 2*pow(b, 2)))
		{
			//assign(minorDia = 2*b)
			{
				echo("Separation: ", separation);
				echo("Major radius: ",a);
				echo("Minor radius: ",b);
				echo("Slot depth: ", a - separation/2);
				echo("Slot fraction of radius: ", (a - separation/2)/a);
				
				
				
				if(cut)
				{
					translate([0, b+1, 0])
					SlottedEllipse(a, b, separation, thickness);
					
					translate([0, -b-1, 0])
					SlottedEllipse(a, b, separation, thickness);
				}
				else
				{
					rotate([360*$t,-cos(720*$t)*atan2(a, separation+a),0])
					{
						translate([-separation/2, 0, -thickness/2])
						linear_extrude(height=thickness)
						SlottedEllipse(a, b, separation, thickness);
					
						translate([separation/2, 0 , 0])
						rotate([90,0,180])
						translate([0, 0, -thickness/2])
						linear_extrude(height=thickness)
						SlottedEllipse(a, b, separation, thickness);
					}
				}
				*cube([7.439, 5, 5], center=true);
			}
		}
	}
	
}

module SlottedEllipse(major = 1*inch, minor = 0.5*inch, separation=0.25 * inch, thickness = 3)
{
	difference()
	{
		Ellipse(major, minor);
		//circle(r=separation-major);
		//circle(r=1);
		
		rotate([0,0,-90])
		translate([0, major/2 + separation / 2, 0])
		square([thickness, major], center=true);
	}
}

module Ellipse(major = 1*inch, minor = 0.5*inch)
{
	scale([1, minor/major, 1])
	circle(major);
}



include <MCAD/units.scad>