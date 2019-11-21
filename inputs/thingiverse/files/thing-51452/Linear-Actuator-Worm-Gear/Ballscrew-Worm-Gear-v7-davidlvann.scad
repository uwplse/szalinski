// Ballscrew "worm gear"

// Number of teeth = reduction ratio (number of turns of screw to turn gear once)
num_teeth = 90;
// Center Hole Type - Default is 7/16" Hex
center_hole = 1; // [ 0:No Hole, 1:Hex, 2:Round ]
// Center Hole Dimension - If hex, use "across flats" standard
hole_diam = 11.1125;
// Flange?
flange = 1; // [ 1:Yes,  0:No ]
// Flange Thickness (adds to total thickness)
flange_thickness = 6.0138;
// Flange Diameter
flange_diam = 40;
// Add a screw?
set_screw = 1; // [ 1:Yes, 0:No ]
set_screw_diameter = 3;
// Gear Added Thickness (added to ball screw OD to find gear thickness)
gear_added_thickness = 2;
// Ball Screw OD = default gear thickness
ball_screw_OD = 16.5862;
// Screw Root Diameter ("excluding" height of threads)
screw_root_diam = 14.2748;
// Lead = distance traveled by one thread, one rotation apart
lead = 8.49;
// Number of starts (independent threads on screw)
starts = 2;
// Ball Diameter = size of "teeth"
ball_diam = 3.175;

// Calculated and/or renamed parameters
gear_root_diam = num_teeth * lead / starts / PI;
OD = gear_root_diam + ball_screw_OD;
thickness = ball_screw_OD + gear_added_thickness;
lead_angle = atan( lead / (PI * (screw_root_diam + ball_diam)) );

// Trim the gear diameter to eliminate thin edges and overhangs
trim = 4;
// Slop is added to several calculations to improve fit and counteract shrinkage
slop = 0.05;
// Percent Shrink - Increase hole size by this percentage
shrink = 0.08;
circ_rad = hole_diam/2 / cos(PI/20) * (1 + shrink);
hex_rad =  hole_diam / sqrt(3) * (1 + shrink);

if(flange == 1)
{	echo("Total thickness: ", thickness + flange_thickness ); }
else
{	echo("Total thickness: ", thickness ); }

echo("Outer diam: ", OD - trim*2);
echo("Lead angle: ", lead_angle);
echo("Desired round hole diam: ", hole_diam);
echo("Desired hex hole corner-to-corner: ", hole_diam*2/sqrt(3));
echo("Compensated round hole diam: ", 2*circ_rad);
echo("Compensated hex hole corner-to-corner*: ", 2*hex_rad);

module worm_gear()
{
difference()
{
	union()
	{
		rotate_extrude($fn = num_teeth)
		difference()
		{	
		square( [ gear_root_diam/2 - trim, thickness] );
		
		translate( [ gear_root_diam/2, thickness/2 ] )
		circle( r = ball_screw_OD/2 + slop, $fn = 60 );
		}
		for( i = [0:num_teeth-1] )
		rotate( [ 0, 0, i*360/num_teeth ] )
		translate( [ gear_root_diam/2, 0, thickness/2 ])
		circular_groove(ball_diam, screw_root_diam + slop, lead_angle, trim);
		
		// Adds a flange to increase contact area
		if( flange == 1 )
		{
			translate( [ 0, 0, thickness ] )
			cylinder( r = flange_diam/2, h = flange_thickness );
		}
	}
	
	// Cut out set screw hole
	if( set_screw == 1 )
	{
		translate([0,0, thickness+flange_thickness/2] )
		rotate( [ 90, 0, 0 ] )
		cylinder( r = set_screw_diameter/2 / cos(PI/12), 
				h = flange_diam/2, $fn = 12 );
	}

	// Hex shaft hole
	if( center_hole == 1)
	cylinder( r = hex_rad, h = 2*thickness + flange_thickness, $fn = 6 );

	// Round hole
	if( center_hole == 2)
	cylinder( r = circ_rad, h = 2*thickness + flange_thickness, $fn = 20);
	
	// Diagnostic cutouts for printing
	//translate( [ 0, -OD/2, thickness/2 ] )
	//cube( [ OD, OD, OD ] );

	//cube( [ OD, OD, OD ] );

	//cylinder( r = (OD - ball_screw_OD)/2 - 2, h = thickness + 1, $fn = floor(num_grooves));
}
}

module circular_groove(ball_diam, root_diam, lead_angle, trim)
{
	n = 60;
	
	rotate( [ 90 - lead_angle, 0, 0 ] )
	difference()
	{
		rotate_extrude($fn = n)
		translate( [ (root_diam + ball_diam )/2 / cos(PI/n), 0 ] )
		difference()
		{
			circle( r = ball_diam/2, $fn = 8 );
			
			translate( [ 0, -ball_diam/2, 0 ] )
			square( [ 2*ball_diam, 2*ball_diam ] );
		}
		
		translate( [ -trim, -root_diam, -ball_diam ] )
		cube( [ 2*root_diam, 2*root_diam, 2*ball_diam] );
	}
}

//circular_groove(ball_diam, ball_screw_OD, lead_angle, trim);
worm_gear();

//%cylinder( r = 6.4158, h = 30, $fn = 24);
