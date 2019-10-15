// SMD strip feeder cartridge for OpenPnP
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

// Length of the SMD tape
tape_length = 185;
// Width of the SMD tape
tape_width = 8;
// height of the SMD strip (Eg 1.0, 1.7)
tape_height = 1;
// The number of tapes used to create the cartridge.
number_of_tapes= 7;
// Force generation of a center spar [0:1]
force_centre_spar = 1;
// A small amount of clearance to add to tape size (Eg. 0.2)
slackness = 0.2;
// Render as single part [0:1]
showFit=0;

module fillet(r, h)
{
	eta = 0.1;
    translate([r / 2, r / 2, 0])
    {
        difference()
        {
            cube([r + eta, r + eta, h], center = true);
            translate([r/2, r/2, 0]) cylinder(r = r, h = h + 1, center = true, $fn=180);
        }
    }
}


module all_in_one_plate (len=185,trays=15, tapeW=8, tapeH=1, slack=0.2)
{
	// Make some slack around the tape
	tapeW = tapeW + slack*2;
	tapeH = tapeH+slack;
	
	difference ()
	{
		union ()
		{
			// 3mm betrween tapes
			cube ([3+trays*(tapeW+3), len, tapeH+1]);
			for (n=[0:trays])
			{
				translate ([1+(n*(tapeW+3)), 3, tapeH]) cube ([1, len-6, 2]);
			}
		}
		
		for (n=[0:trays-1])
		{
			// top slot  0.6 mm >-< 0.6mm
			translate ([3.6+(n*(tapeW+3)), 2, -0.01]) cube ([tapeW-1.2, len-4, tapeH+1]);
			// Tape slot
			translate ([3+(n*(tapeW+3)), -0.01, 1]) cube ([tapeW, len-2, tapeH+1]);
		}
	}
}

module all_in_one_base (len=185,trays=15, tapeW=8, slack=0.2)
{
	tapeW = tapeW + slack*2;

	offset = (len-20)/4;
	difference ()
	{
		
		cube ([3+trays*(tapeW+3), len, 1.6]);
		for (n=[0:trays])
		{
			translate ([1+(n*(tapeW+3)), 2, 0.5]) cube ([1, len-4, 2]);
			if (len > 29)
			{
				translate ([5+(n*(tapeW+3)), 4, 0]) cube ([tapeW-4, offset, 2]);
				translate ([5+(n*(tapeW+3)), offset+8, 0]) cube ([tapeW-4, offset, 2]);
				translate ([5+(n*(tapeW+3)), 2*offset+12, 0]) cube ([tapeW-4, offset, 2]);
				translate ([5+(n*(tapeW+3)), 3*offset+16, 0]) cube ([tapeW-4, offset, 2]);
			}
		}
	}
	if (len > 29)
	{
		for (n=[0:trays-1])
		{
			for (c=[0:3])
			{
				fr = (tapeW-5)/4;
				mv = (c*offset+4*(c+1));
				translate ([5+(n*(tapeW+3)), mv, 0.8]) fillet (fr,1.6);
				translate ([1+(n*(tapeW+3)+tapeW), mv, 0.8]) rotate ([0,0,90])fillet (fr,1.6);
				translate ([5+(n*(tapeW+3)), mv+offset, 0.8]) rotate ([0,0,-90]) fillet (fr,1.6);
				translate ([1+(n*(tapeW+3)+tapeW), mv+offset, 0.8]) rotate ([0,0,180])fillet (fr,1.6);
				if (tapeW > 8 || (force_centre_spar && tapeW > 6))
				{
					lf = 5+(n*(tapeW+3))+(tapeW-4)/2-((tapeW-5)/10);
					rf = lf + (tapeW-6)/5;
					translate ([lf, mv, 0]) cube ([(tapeW-5)/5, offset, 1.6]);
					translate ([lf, mv, 0.8]) rotate ([0,0,90]) fillet (fr,1.6);
					translate ([lf, mv+offset, 0.8]) rotate ([0,0,180])fillet (fr,1.6);
					
					translate ([rf, mv, 0.8]) fillet (fr,1.6);
					translate ([rf, mv+offset, 0.8]) rotate ([0,0,-90])fillet (fr,1.6);
				}
			}
		}
	}
}

//==================================================================


all_in_one_plate (tape_length, number_of_tapes, tape_width, tape_height, slackness);
if (showFit)
{
	translate ([(number_of_tapes * (tape_width+3+(slackness * 2)))+3,0,tape_height+2.6]) rotate ([0,180,0])  all_in_one_base (tape_length, number_of_tapes, tape_width, slackness);
}
else
{	translate ([(number_of_tapes * (tape_width+3) + 8),0,0]) all_in_one_base (tape_length, number_of_tapes, tape_width, slackness);
}
