// SMD strip feeder V3 cartridge for OpenPnP
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

// Width of the SMD tape
tape_width = 8;
// A small amount of clearance to add to tape size (Eg. 0.2)
slackness = 0.0;
// Render as single part [0:1]
showFit=0;
// wall thickness
thickness=3.0;
// Top thickness
topThickness = 1.2;
// Strip length
stripLength = 80;

$fn=90;

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


module channel (clen=80, tapeW=8, slack=0.2)
{
	// Make some slack around the tape
	tapeW = tapeW + slack*2;
	
	difference ()
	{
		union ()
		{
			cube ([clen, (thickness*2)+tapeW, 10+topThickness]);	
		}
		translate ([-0.1,thickness,thickness]) cube ([clen+1,tapeW,10-thickness]);
		translate ([-0.1,thickness+1,thickness]) cube ([clen+1,tapeW-2,10+topThickness]);
		// Now the holes for tape
		holes = (clen-8) / 4;
		for (n=[0:holes])
		{
			translate ([4+n*4, thickness+1.2,10+thickness-thickness*1.5]) cylinder (d=2, h=thickness*2);
		}
		// Holes for mounting & spring
		translate ([5,thickness+tapeW/2, -1.0])	cylinder (d=3, h=thickness*2);
		translate ([5,thickness+tapeW/2, thickness-1]) cylinder (d2=6, d1=3, h=1.1);
		
		translate ([clen-5,thickness+tapeW/2, -1.0])	cylinder (d=3, h=thickness*2);
		translate ([clen-5,thickness+tapeW/2, thickness-1]) cylinder (d2=6, d1=3, h=1.1);
		
		translate ([clen/2, thickness+tapeW-1.2, 10+topThickness]) rotate ([0,90,0]) fillet (r=2, h=clen+1);
		
		translate ([clen/2, thickness+1.2, 10+topThickness]) rotate ([180,90,0]) fillet (r=2, h=clen+1);
	}
}

module platform (clen=100, tapeW=8, slack=0.2)
{
	difference ()
	{
		union ()
		{
			cube ([clen, tapeW-slackness*2, 2.0]);
			translate ([-2, -thickness, 0]) cube ([2, tapeW+thickness*2, 2]);
		}
		translate ([-2, tapeW/2, 2]) rotate ([-90,0,0]) fillet (r=2, h=tapeW+thickness*3);
	}	
}


//==================================================================

channel (stripLength, tape_width, slackness);
translate ([-1,2+tape_width+thickness*2,0]) platform (stripLength, tape_width, slackness);
