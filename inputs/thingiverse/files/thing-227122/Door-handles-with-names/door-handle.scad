

/* Project to generate door handles for 3D printing
*/

/* [Global] */

// Define the type of handle required
//
// Type of doorhandle required
handle_type = "l";	// [l:L-shaped,r:Round]

// Define whether or not screw holes are required
//
// Is a vertical securing screw required?
vertical_screw = "y"; // [y:Yes,n:No]

// Is a horizontal securing screw required?
horizontal_screw = "y"; // [y:Yes,n:No]

// Length of the side of the square operating shaft
shaft_side= 8;

// Depth of the square hole into the handle
shaft_depth= 20;

// Diameter of the hole needed for the securing screws
screw_diameter= 3;

// Offset for screw hole from end of connector
screw_offset= 10;

// Diameter of the connector between the handle and the shaft
connector_diameter = 20;

// Length of the connector between the handle and the shaft
connector_length = 15;

// Height of text
text_height = 15;

// Thickness of text
text_thickness = 3;

// Text to be embossed
text_data = "Bathroom";


// Variables specific to the round doorhandle
//
// Diameter of the round door handle
round_diameter = 70;

// Height of the handle
round_height = 30;


// Variables specific to the L shaped door handle
//

// Total length of the handle
l_length = 180;

// Width of the handle at the start
l_start_height = 35;

// Width of the handle at the end
l_finish_height = 20;

// Thickness of the handle
l_thickness = 8;

// Select whether or not handle ends are rounded
l_rounded = "n"; // [y:Yes,n:No]

/* [Hidden] */

// Margin to ensure that cut-outs penetrate through surfaces
margin = 1;	

// Calculate other values as needed
//
round_offset = connector_length + round_height/2;
l_offset = connector_length + margin;
l_angle = atan((l_start_height-l_finish_height)/(2*l_length));
connector_radius = connector_diameter / 2;
shaft_offset = shaft_side/ 2;
screw_length = connector_diameter / 2 + margin;
screw_radius = screw_diameter/ 2;

use <Write.scad>

difference() {

	union () {

		// Check for the type of handle required
		//
		if (handle_type  == "l") {

			// Draw the flat handle
			//
			if (l_rounded == "y") {

				// Draw flat handle with rounded ends
				//
				hull() {
					translate([l_offset,0,0])
						rotate(a=90,v=[0,1,0])
							cylinder(h=l_thickness,r=l_start_height/2);

					translate([l_offset,l_length-(l_finish_height/2),0])
						rotate(a=90,v=[0,1,0])
							cylinder(h=l_thickness,r=l_finish_height/2);

				} // End hull
				writecube(text=text_data, where=[l_offset+(l_thickness/2),(-l_start_height*0.5)+(l_length/2),0], size=[l_thickness,l_length,l_start_height], face="right", h=text_height, t=text_thickness);

			}
			else 
			{
				// Draw flat handle with square corners
				//
				difference() {
					translate([l_offset,-l_start_height*0.5,-l_start_height*0.5])
						cube(size=[l_thickness,l_length,l_start_height]);

					translate([l_offset,-l_start_height*0.5,l_start_height*0.5])
						rotate(a=-l_angle,v=[l_offset,0,0])
							cube(size=[l_thickness,l_length*1.5,l_start_height]);

					translate([l_offset,-l_start_height*0.5,-l_start_height*1.5])
						rotate(a=l_angle,v=[l_offset,0,0])
							cube(size=[l_thickness,l_length*1.5,l_start_height]);

				} // End difference
				writecube(text=text_data, where=[l_offset+(l_thickness/2),(-l_start_height*0.5)+(l_length/2),0], size=[l_thickness,l_length,l_start_height], face="right", h=text_height, t=text_thickness);

			} // End if

			// Draw the cylindrical connector
			//
			rotate(a=90,v=[0,1,0])
				cylinder(h=l_offset,r=connector_radius);

		} // End if handle_type  == l

		if (handle_type  == "r") {

			// Draw the round handle
			//
			translate([round_offset,0,0])
				resize(newsize=[round_height,round_diameter,round_diameter]) {
					sphere(r = 10);
					writesphere(text=text_data, where=[0,0,0], radius=10, east=90, h=text_height, t=text_thickness);
			}

			// Draw the cylindrical connector
			//
			rotate(a=90,v=[0,1,0])
				cylinder(h=round_offset,r=connector_radius);

		} // End if handle_type  == "r"



	} // End union

	// Draw the cout-out for the square shaft
	//
	translate([-margin,-shaft_offset,shaft_offset])
		rotate(a=90,v=[0,1,0])
			cube(size=[shaft_side,shaft_side,shaft_depth+margin]);

	// Draw the horizontal cylindrical screw hole
	//
	if (horizontal_screw == "y")
		translate([screw_offset,0,0])
			rotate(a=90,v=[1,0,0])
				cylinder(h=screw_length,r=screw_radius);

	// Draw the vertical cylindrical screw hole
	//
	if (vertical_screw == "y")
		translate([screw_offset,0,0])
			rotate(a=180,v=[1,0,0])
				cylinder(h=screw_length,r=screw_radius);

} // End difference


