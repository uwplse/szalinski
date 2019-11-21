/* [PrintOptions] */
// preview[view:south east, tilt:bottom diagonal]

// splits the cable holder into 2 parts for printing if your machine doesn't do well with printing tight tolerances
show_seperate = "no"; // [yes, no]

/* [Basic] */
// is the diameter of the cable in mm to be held by the cable holder
cable_diameter = 5;
// sets the distance between the holding tabs in mm
table_thickness = 19.5;
// controls the distance between moving parts of the cable holder
tolerance = 0.5;


/* [Table_tabs] */
// adjusts the length of the tabs in mm that will hold the cable holder on to the table
tab_length = 15;
// adjusts how thick the tabs that hold the cable holder to the table should be in mm
tab_thickness = 3;

/* [Table_grip] */
// adjusts the triangular grip protrusion height in mm
grip_height = 1;
// adjusts the base width of the triangular grip protrusion in mm
grip_width = 4;

/* [Thumbwheels] */
//controls how tall the end thumbwheels should be in mm
thumbwheel_height = 5;

/* [Advanced] */
// is confusing name, just play with it and see what it does
retainer_factor = 6; // [3, 4, 5, 6, 7, 8, 9, 10]
// is another one to play around with.  Choose values between 0 and 2
plane_cut_factor = 1;
// is the quality of the cylinders
$fn = 50;

/* [Advanced_neck] */
// is the thickness of the inner rotating cuff in mm
neck_thickness = 2;

/* [Advanced_holder] */
// controls the overall thickness of the outer holder in mm
holder_thickness = 4;

/* [Hidden] */
barrel_lift_factor = 1/retainer_factor;
barrel_thickness = holder_thickness/2;

holder_height = 2*tab_thickness + table_thickness;
holder_diameter = cable_diameter + 2*neck_thickness + 2*tolerance + 2*holder_thickness;
plane_cut_depth = plane_cut_factor*(cable_diameter/2 + neck_thickness);

preview_tab = "";

rotate([0,90,0]) difference()
{

	// main holder barrels and tabs
	union()
	{
		// inner barrel
		
		if(show_seperate == "no")
		{
			InnerBarrel();
		}
		else
		{
			translate([0, holder_diameter + 5, 0]) 
			difference()
			{
				InnerBarrel();
				// cable notch
				translate([0, -cable_diameter/2, -0.5]) cube([holder_diameter/2 + 0.5, cable_diameter, thumbwheel_height + tolerance + holder_height + tolerance + thumbwheel_height + 1]);
				// plane slice
				translate([plane_cut_depth, -(holder_diameter + 1)/2, -0.5]) cube([holder_diameter/2 + 0.5, holder_diameter + 1, thumbwheel_height + tolerance + holder_height + tolerance + thumbwheel_height + 1]);
			}
		}
		
		// outer holder barrel
		highlight("Advanced_holder") difference()
		{
			// main body of the holder
			translate([0,0, thumbwheel_height + tolerance]) cylinder(r = holder_diameter/2, h = holder_height);
			
			// tolerance for neck
			translate([0,0,thumbwheel_height + tolerance + -0.5]) cylinder(r = cable_diameter/2 + neck_thickness + tolerance, h = holder_height + 1);
			// tolerance for the barrel
			translate([0,0, thumbwheel_height + tolerance + barrel_lift_factor*holder_height-tolerance]) cylinder(r = cable_diameter/2 + neck_thickness + barrel_thickness + tolerance, h = holder_height*(1-2*barrel_lift_factor) + 2*tolerance);
		}
		
		// main body holder
		union()
		{
			// upper tab
			highlight("Table_tabs") translate([-tab_length - holder_diameter/2, -holder_diameter/2, thumbwheel_height + tolerance + holder_height - tab_thickness]) cube([tab_length + 0.1, holder_diameter, tab_thickness]);
			// lower tab
			highlight("Table_tabs")translate([-tab_length - holder_diameter/2, -holder_diameter/2, thumbwheel_height + tolerance]) cube([tab_length + 0.1, holder_diameter, tab_thickness]);
			// lower grip
			highlight("Table_grip") translate([-tab_length - holder_diameter/2, holder_diameter/2,  thumbwheel_height + tolerance + tab_thickness]) rotate([90, 0, 0]) linear_extrude(height = holder_diameter, convexity = 10) polygon(points = [[0,0], [grip_width/2,grip_height], [grip_width,0], [grip_width,-0.1], [0,-0.1]]);
			
			// body block to  cylinder
			highlight("Advanced_holder") difference()
			{
				// main body block
				translate([-holder_diameter/2, -holder_diameter/2, thumbwheel_height + tolerance]) cube([holder_diameter/2, holder_diameter, holder_height]);
				// cylinder cut
				translate([0,0, thumbwheel_height + tolerance - 0.1]) cylinder(r = holder_diameter/2, h = holder_height + 1);
			}
		}
	}

	// cable notch
	translate([0, -cable_diameter/2, -0.5]) cube([holder_diameter/2 + 0.5, cable_diameter, thumbwheel_height + tolerance + holder_height + tolerance + thumbwheel_height + 1]);
	// plane slice
	translate([plane_cut_depth, -(holder_diameter + 1)/2, -0.5]) cube([holder_diameter/2 + 0.5, holder_diameter + 1, thumbwheel_height + tolerance + holder_height + tolerance + thumbwheel_height + 1]);
}

module InnerBarrel()
{
	difference()
		{
			union()
			{
				// top thumbwheel
				highlight("Thumbwheels") translate([0,0, thumbwheel_height + tolerance + holder_height+tolerance]) cylinder(r = holder_diameter/2, h = thumbwheel_height);
				// bottom thumbwheel
				highlight("Thumbwheels") cylinder(r = holder_diameter/2, h = thumbwheel_height);
				// retaining barrel
				translate([0,0, thumbwheel_height + tolerance + barrel_lift_factor*holder_height]) cylinder(r = cable_diameter/2 + neck_thickness + barrel_thickness, h = holder_height*(1-2*barrel_lift_factor));
				// the main barrel, or the "neck"
				highlight("Advanced_neck") cylinder(r = cable_diameter/2 + neck_thickness, h =thumbwheel_height + tolerance +  holder_height + tolerance + thumbwheel_height);
			}

			// The hole for the cable to go through
			translate([0,0,-.5]) cylinder(r = cable_diameter/2, h = thumbwheel_height + tolerance + holder_height + tolerance + thumbwheel_height + 1);
		}
}

module highlight(this_tab)
{
	if(preview_tab == this_tab)
	{
		color("red") child(0);
	}
	else
	{	
		child(0);
	}
}