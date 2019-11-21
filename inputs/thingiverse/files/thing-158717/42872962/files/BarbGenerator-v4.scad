// Barb generator v1.4 - Updated 12-Jun-2019
// Use customizer keyword in Thingiverse object to enable customize button
// See https://customizer.makerbot.com/docs

/* [Inputs] */

// Number of hose inputs - which is input and which is output doesn't matter but the input will be on the bottom of the print so should be the larger of the two
inputs = 1;

//  Measurement system for inputs - US in inches, Metric in mm
input_units = "US"; // [US,Metric]

// Input tubing inside diameter, e.g. 0.5 for 1/2 inch (US); 0.625 for 5/8, 0.75 for 3/4, etc; note that input is always on the bottom of the print so should be the larger unless printing a manifold
input_size = 0.625;

// Strength factor - use more than 1 for thicker walls to handle higher pressure and stronger clamping. Range: 0.9-1.5. Reduce only for I.D. greater than 0.5 inches
input_strength = 1.0;

// Input barb count - may be 3 for larger barbs, more for smaller
input_barb_count = 3;

/* [Outputs] */

// Number of hose outputs
outputs = 2;

// Measurement system for outputs
output_units = "US"; // [US,Metric]

// Output tubing inside diameter, e.g. 0.17 for 1/4 inch OD (outside diameter) vinyl tubing (US); 0.25 for 1/4 inch ID (inside diameter) (US); 0.375 for 3/8 inch ID. For a PVC pipe connector going into a female fitting, pipe sizes are in inside diameter, so the outside of a 3/4" PVC pipe is actually 1.0 inches (used with output_barb_count=0 for a smooth output)
output_size = 0.375;

// Strength factor - use more than 1 for thicker walls to handle higher pressure and stronger clamping. Range: 0.9-1.5. Reduce only for I.D. greater than 0.5 inches
output_strength = 1.0;

// Output length if barb count = 0, in multiples of diameter. Ignored if output is barbed
output_smooth_length = 1.0;

// Output barb count - may be 3 for larger barbs, 0 for smooth
output_barb_count = 3;

/* [Connector] */

// Connector type - Use inline for a single input and single output
connector_type = "vault"; // [inline,vault]

// Inline junction type - currently only round is supported
inline_junction_type = "round"; // [round,hex,none]

/* Manifold connectors */

// Vault wall thickness in mm - increase for higher pressure connections
vault_wall_thickness = 2.5;

// Add support under vault for printing. Not recommended - you'll usually get better support for vault connectors using your favorite slicer's "generate support from bed" feature.
vault_support = "no"; // [yes,no]

// Ratio of connector diameter to space allocated in vault - increase to allow more space for hose clamps, etc.
vault_connector_ratio = 1.8;

/* [Advanced] */

// Width of junction as ratio of tubing I.D.
inline_junction_width = 0.8;

// Inside diameter ratio for output
output_inside_diameter_ratio = 0.6;

// Inside diameter ratio for input
input_inside_diameter_ratio = 0.6;

make_adapter( input_units == "US" ? input_size * 25.4 : input_size, output_units == "US" ? output_size * 25.4 : output_size );

module make_adapter( input_diameter, output_diameter )
{

if (connector_type == "inline" && inputs == 1 && outputs == 1)
{
  union() {
      junction_height = 4;
      input_barb( input_diameter );
      junction( input_diameter, output_diameter, junction_height );
      output_barb( input_diameter, output_diameter, junction_height );
  }
}
if (connector_type == "vault" || inputs > 1 || outputs > 1)
{
  center_width = max(inputs * input_diameter * vault_connector_ratio, outputs * output_diameter * vault_connector_ratio);
  center_height = max(input_diameter * vault_connector_ratio, output_diameter * vault_connector_ratio);
  junction_height = 4;
  center_empty_input = center_width - input_diameter * vault_connector_ratio * inputs;
  center_empty_output = center_width - output_diameter * vault_connector_ratio * outputs;
  union() {
       //input_barb( input_diameter );
       for (i = [1:inputs]) 
	    {
		   translate( [center_empty_input / 2 + input_diameter * vault_connector_ratio / 2 + input_diameter * (i-1) * vault_connector_ratio,0,0] ) input_barb( input_diameter );
	    }
		 //echo( "inputs=", inputs, "; input_diameter=", input_diameter, "; outputs=", outputs, "; output_diameter=", output_diameter );
		 //echo( "center_width=", center_width, "; by input=", inputs * input_diameter * vault_connector_ratio, "; by output=", outputs * output_diameter * vault_connector_ratio, "; center_empty_input=", center_empty_input, "; center_empty_output=", center_empty_output );
		 difference()
		 {
			translate([-vault_wall_thickness,-vault_wall_thickness,0]) vault( input_diameter, junction_height, center_width, center_height, center_height, vault_wall_thickness, output_diameter, center_empty_output );
			for (i = [1:inputs]) 
			{
				// Make holes in the vault for input entry
      		translate( [center_empty_input / 2 + input_diameter * vault_connector_ratio / 2 + input_diameter * (i-1) * vault_connector_ratio,0,input_diameter * input_barb_count * 0.9 - center_height / 3] ) cylinder( r=input_diameter * input_inside_diameter_ratio / 2, h=center_height, $fn=60 );
			}
			for (i = [1:outputs]) 
			{
				// Make holes in the vault for output egress
      		translate( [center_empty_output / 2 + output_diameter * vault_connector_ratio / 2 + output_diameter * (i-1) * vault_connector_ratio,0,input_diameter * junction_height * 0.9 + center_height / 2] ) cylinder( r=output_diameter * output_inside_diameter_ratio / 2, h=center_height, $fn=60 );
			}
		 } // end vault with holes
       //output_barb( input_diameter, output_diameter, 12 );
	    for (i = [1:outputs]) 
		 {
			translate( [center_empty_output / 2 + output_diameter * vault_connector_ratio / 2 + output_diameter * (i-1) * vault_connector_ratio,0,-output_diameter * output_inside_diameter_ratio / 2] ) output_barb( input_diameter, output_diameter, center_height + 2 * vault_wall_thickness );
		 }
     }
 } // end if vault
} // end module make_adapter

/****
module tometric( unit_type, value )
{
  if (unit_type == "US") value * 25.4;
  else value;
}
***/

module barbnotch( inside_diameter )
{
  // Generate a single barb notch
  cylinder( h = inside_diameter * 1.0, r1 = inside_diameter * 0.85 / 2, r2 = inside_diameter * 1.16 / 2, $fa = 0.5, $fs = 0.5 );
}

module solidbarbstack( inside_diameter, count )
{
    // Generate a stack of barbs for specified count
    // The height of each barb is [inside_diameter]
    // and the total height of the stack is
    // (count - 1) * (inside_diameter * 0.9) + inside_diameter
    union() {
      barbnotch( inside_diameter );
		for (i=[2:count]) 
		{
			translate([0,0,(i-1) * inside_diameter * 0.9]) barbnotch( inside_diameter );
		}
		/***
		if (count > 1) translate([0,0,1 * inside_diameter * 0.9]) barbnotch( inside_diameter );
		if (count > 2) translate([0,0,2 * inside_diameter * 0.9]) barbnotch( inside_diameter );
		***/
    }
}

module barb( inside_diameter, count, strength_factor )
{
  // Generate specified number of barbs
  // with a single hollow center removal
  if (count > 0)
    difference() {
        solidbarbstack( inside_diameter, count );
    translate([0,0,-0.3]) cylinder( h = inside_diameter * (count + 1), r = inside_diameter * (0.75 - (strength_factor - 1.0)) / 2, $fa = 0.5, $fs = 0.5, $fn=60 );
  }
  else
      difference() {
        cylinder( h = inside_diameter * output_smooth_length, r = 
inside_diameter / 2, $fn=60 );
    translate([0,0,-0.3]) cylinder( h = inside_diameter * output_smooth_length + 0.6, r = inside_diameter * (0.75 - (strength_factor - 1.0)) / 2, $fa = 0.5, $fs = 0.5, $fn=60 );
          //echo( "difference h=", (2*inside_diameter), "r=", inside_diameter/2, "; ir=", inside_diameter * (0.75 - (strength_factor - 1.0)) / 2 );
    }
}

module input_barb( input_diameter )
{
  barb( input_diameter, input_barb_count, input_strength );
}

module output_barb( input_diameter, output_diameter, jheight )
{
  // Total height of a barb stack is
  // 0.9 * diameter for each barb overlapping
  // the one above, plus diameter for the topmost;
  // i.e. (D * 0.9 * (count-1)) + D
  input_total_height = (input_barb_count - 1) * 0.9 * input_diameter + input_diameter;
  output_total_height = (output_barb_count - 1) * 0.9 * output_diameter + output_diameter;
  if (output_barb_count == 0) {
      //output_total_height = -4.0 * output_diameter;
      //echo( "jheight=", jheight, "; out-total=", output_total_height, "; in-total=", input_total_height );
    translate( [0,0,input_total_height + jheight] )      barb( output_diameter, output_barb_count, output_strength );
  }
  else {
  translate( [0,0,input_total_height + output_total_height + jheight] ) rotate([0,180,0]) barb( output_diameter, output_barb_count, output_strength );
  }
}

module junction( input_diameter, output_diameter, jheight )
{
  junction_diameter_ratio = (inline_junction_type == "none") ? 1.1 : 1.6;
  lower_junction_diameter_ratio = (inline_junction_type == "none") ? 1.1 : 1.4;
  max_dia = max( input_diameter, output_diameter );
  r1a = max_dia * lower_junction_diameter_ratio / 2;
  r2a = max_dia * junction_diameter_ratio / 2;
  r1b = input_diameter / 2;
  r2b = output_diameter / 2;
  input_total_height = (input_barb_count - 1) * 0.9 * input_diameter + input_diameter;
  {
  //echo( "Junction jheight=", jheight, "; input_dia=", input_diameter, "; output_dia=", output_diameter, "; max_dia=", max_dia, r1a, r2a, r1b, r2b );
  translate( [0,0,input_total_height] ) difference() {
	cylinder( r1 = r1a, r2 = r2a, h = 5, $fa = 0.5, $fs = 0.5 );
	cylinder( r1 = r1b, r2 = r2b, h = (jheight + 1), $fa = 0.5, $fs = 0.5 );
  }
  }
}

module vault( input_diameter, jheight, center_width, center_depth, center_vheight, wall_thickness, output_diameter, center_empty_output )
{
  outside_width = center_width + 2 * wall_thickness;
  outside_depth = center_depth + 2 * wall_thickness;
  outside_vheight = center_vheight + 2 * wall_thickness;
  input_total_height = (input_barb_count - 1) * 0.9 * input_diameter + input_diameter;
  vault_base = input_total_height;
  {
    translate( [0, -outside_depth / 2 + wall_thickness, vault_base - wall_thickness] ) union()
	 {
	   difference() 
      {
        // Start with a solid cube comprising the outside of the vault
        cube( [outside_width,outside_depth,outside_vheight] );
		// Subtract the bottom 2/3 as a cube along with conical sections leading up to the output openings
        union()
        {
            for (i=[1:outputs])
            {
                hull()
                {
                    // Make a hull using the bottom 2/3 of the vault inside wall
                    // and a short cylinder congruent with the bottom of each output
                    translate( [wall_thickness,wall_thickness,wall_thickness] ) cube( [center_width, center_depth, center_vheight * 2 / 3] );
                    translate( [center_empty_output / 2 + output_diameter * vault_connector_ratio / 2 + output_diameter * (i-1) * vault_connector_ratio + wall_thickness, outside_depth / 2, wall_thickness + center_vheight ] ) cylinder( r=output_diameter * 1.25 * output_inside_diameter_ratio / 2, h=0.1, $fn = 60 );
                }
            }
       }
      }
	   // Add supports if requested (not recommended)
		if (vault_support == "yes")
	   {
		  support_leg_width = center_width / 4;
		  support_leg_thickness = wall_thickness / 2;
		  translate([outside_width-support_leg_width,outside_depth-support_leg_thickness,wall_thickness-vault_base]) cube([support_leg_width, support_leg_thickness, vault_base]);
		  translate([outside_width-support_leg_width,0, wall_thickness-vault_base]) cube([support_leg_width, center_depth + wall_thickness*2, 0.6]);
		  translate([0,outside_depth-support_leg_thickness,wall_thickness-vault_base]) cube([support_leg_width,support_leg_thickness, vault_base]);
		  translate([outside_width-support_leg_width,0,wall_thickness-vault_base]) cube([support_leg_width,support_leg_thickness, vault_base]);
		  translate([0,0, wall_thickness-vault_base]) cube([support_leg_width, center_depth + wall_thickness*2, 0.6]);

		  translate([0,0,wall_thickness-vault_base]) cube([support_leg_width, support_leg_thickness, vault_base]);
		}
    }
  }
}
