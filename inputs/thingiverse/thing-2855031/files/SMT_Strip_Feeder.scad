// SMT drag strip feeder V4 cartridge for OpenPnP
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

// Width of the SMD tape
tape_width = 8;
// A small amount of clearance to add to tape size (Eg. 0.25)
slackness = 0.25;
// Render as single part [0:1]
showFit=0;
// wall thickness
thickness=1.25;
// Spring thickness 
springThickness=1.25;
// cartridge length
clen = 60;
// pick window size default 10 for 8mm
psize = 10;
// Cartridge Height
cheight = 8;
// What to render [0:Both, 1:Springs, 2:Channels]
part_type=0;	// [0:1:2]
// Number of parts/feeders to render
part_count= 15;
$fn=90;

for (n=[0:part_count-1])
{
	if (part_type == 0 || part_type == 2)
	{
		translate([0,n*(tape_width+(slackness+thickness)*2+4), 0]) channel (tape_width, slackness);
	}
	if (part_type == 0 || part_type == 1)
	{
		if (showFit)
		{
			translate ([clen,n*(tape_width+(slackness+thickness)*2+4)+tape_width,10])  rotate ([90,180,0]) spring (tape_width, slackness);
		}
		else
		{
			if (part_count == 1)
			{
				translate ([0,-8,thickness/2]) spring (tape_width, slackness);
			}
			else
			{
				translate ([clen+5,8*(n+1),thickness/2]) spring (tape_width, slackness);
			}
		}		
	}
}


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


module channel (tapeW=8, slack=0.2)
{
	// Make some slack around the tape
	tapeW = tapeW + slack*2;
	
	difference ()
	{
		union ()
		{
			cube ([clen, (thickness*2)+tapeW, cheight]);
			translate ([0,0,cheight]) cube ([3, (tapeW+thickness+thickness), 1]);
			translate ([clen-10,-4,0]) cube ([10, (tapeW+thickness+thickness), cheight-1]);
			
		translate ([0,-4,0]) cube ([6, 4, thickness]);
		}
		translate ([0,thickness,cheight-1])  cube ([clen, tapeW, 1]);
		translate ([0,thickness+1,cheight-2])  cube ([psize+4, 1, 1]);
		
		translate ([0,thickness+2.5,thickness])  cube ([clen, tapeW-3.5, cheight-2]);
		translate ([clen-10,-4,cheight-1]) cube ([10, (tapeW+thickness+thickness), cheight-1]);
		
		translate ([clen-20,thickness,cheight-1])  rotate ([0,5,0]) cube ([30, tapeW, 3]);
		translate ([-3,thickness,cheight-3])  rotate ([0,-15,0]) cube ([10, tapeW, 2]);

		
		translate ([clen-7,-1,-1]) cylinder (d=2,h=cheight+1);
		translate ([clen-3,-1,-1]) cylinder (d=2,h=cheight+1);
		
		translate ([3,-2,-0.1]) cylinder (d=2,h=thickness+1);
	}
}

module rcube (X,Y,Z,R)
{
	hull ()
	{
		translate ([R,R,0,]) cylinder (r=R,h=Z);
		translate ([X-R,R,0]) cylinder (r=R,h=Z);
		translate ([R,Y-R,0]) cylinder (r=R,h=Z);
		translate ([X-R,Y-R,0]) cylinder (r=R,h=Z);
	}	
}

module spring (tapeW=8, slack=0.2)
{
	rotate ([-90,0,0]) translate ([0,-(tapeW+thickness+thickness+2.15),0])difference ()
	{
		mclen = clen - (12 + psize); // 10mm for block + 2 for end cover
		union ()
		{
			cube ([10, (tapeW+thickness+thickness+3-slackness), 3]);
			translate ([10-springThickness,3+thickness*2+slackness*2,springThickness])rotate ([-90,-6,0]) rcube (mclen, springThickness,tapeW-slack*3,springThickness/2);


		}
		translate ([7,3,-0.1]) cylinder (d=2.5,h=springThickness+2);
		translate ([3,3,-0.1]) cylinder (d=2.5,h=springThickness+2);
	}
}


//==================================================================
