/*Battery dimensions in mm
CR1225 cell holder: 
 diameter=12mm 
 height=2.5mm 
 tolerance=0.5mm 
 wall thickness=2mm 

CR2032 cell holder: 
 diameter=20mm 
 height=3.2mm 
 tolerance=0.5mm 
 wall thickness=2mm 
*/

battery_diameter	=20.0;	// Diameter of battery
battery_height		=3.2;	// Thickness of battery
tolerance			=0.5;	// Make things a little looser
wall_thickness		=1.5;	// Wall thickness
wire_diameter		=1.5;	// Thickness of wire openings
extra_length		=2.0;	// Extends the open outwards to "hide" the battery a little bit
number_of_cells	=1;		// How many cells will be stacked

rotate([0,90,0])
{
	// Move to propper hieght and orientation
	translate([-battery_diameter/2-extra_length,0,-(battery_height*number_of_cells)-(wall_thickness/4)])
	{
		difference()
		{
			union()
			{
				difference()
				{
					// Main block
					cylinder(r=(battery_diameter/2)+tolerance+wall_thickness, h=battery_height*number_of_cells+(tolerance)+(2*wall_thickness),$fn=64);
					// Battery shape
					translate([0,0,wall_thickness])
						cylinder(r=(battery_diameter/2)+(tolerance/2), h=battery_height*number_of_cells+tolerance,$fn=64);
					// Square opening 
					translate([0,-((battery_diameter/2)+2+tolerance),0])
						cube([battery_diameter+10,battery_diameter*number_of_cells+5,battery_height*number_of_cells+5]);
				}
				difference()
				{
					// Square extension
					translate([0,-((battery_diameter/2)+wall_thickness+tolerance),0])
						cube([battery_diameter/2+extra_length,battery_diameter+(2*wall_thickness)+(2*tolerance),battery_height*number_of_cells+(2*wall_thickness)+tolerance]);
					// Square hole in end
					translate([0,-((battery_diameter/2))-(tolerance/2),wall_thickness])
						cube([battery_diameter+tolerance,battery_diameter+tolerance,battery_height*number_of_cells+tolerance]);
				}
			}
			// Wire holes
			translate([0,0,-1])
				cylinder(r=wire_diameter/2, h=battery_height*number_of_cells+tolerance+10,$fn=16);
			// Battery "push out" hole
			translate([-battery_diameter/2-wall_thickness-1,0,wall_thickness+(battery_height*number_of_cells/2)+tolerance/2])
				rotate([0,90,0])
					cylinder(r=battery_height/3,h=wall_thickness+1,$fn=16);
		}
	}
}



