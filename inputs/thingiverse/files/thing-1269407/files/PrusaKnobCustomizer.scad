/*[Resolution]*/
$fn=360;

/*[General settings]*/

// Height of the outer shell
height = 8;
// Height of the inner shell (in case you want your button inset or to protrude through an LCD case)
innerheight = 8;
// Thickness of the bar that slots into the stock button (the slot on the stock button is 1mm wide)
barthickness = .6;
// Width of the bar that slots into the stock button - you can make it connect to either side of the inner shell by increasing this value, but I found it easier to fit on the stock button when I left a gap
barwidth = 4;
// Height of the bar that slots into the stock button (in case you want to sink it in or make it protrude for any reason)
barheight = 8;
// Diameter of the space given for the stock button (the stock button is 6mm wide - you may want to provide extra space depending on your calibrations - I used 7 for mine)
innerspace = 7;
// Thickness of the inner shell (the piece that connects to the stock button)
innerthickness = 2;
// Diameter of the outer shell
outersize = 20;
// Thickness of the outer shell
outerthickness = 2;
// Overlap between pieces to ensure the connect
overlap = .2;

/*[Nub-specific settings]*/

// Preferred nub style
nubstyle = 2; //[1:Flat,2:Rough,3:Rounded,4:Pirate's Helm]
// Width of the nubs (unused for "round" style nubs)
nubwidth = 1.6;
// Depth (how for the nubs stick out)
nubdepth = .4;
// Vertical height of the nubs
nubheight = 8;
// Degrees between nubs
nubspacing = 10;

// Translate and rotate so the model is facing upward, sitting at the origin (for printing without supports)
translate([0,0,height])
rotate([0,180,0])
{
	// Render cylinders
	union() {
		// Outer shell
		difference() {
			cylinder(h=height, d=outersize, center=false);
			translate([0,0,-1])
				cylinder(h=height-outerthickness, d=outersize-outerthickness, center=false);
		}
		// Inner shell
		translate([0,0,height-innerheight-outerthickness+overlap])
		difference() {
			cylinder(h=innerheight - overlap, d=innerspace+innerthickness, center=false);
			translate([0,0,-1])
				cylinder(h=innerheight, d=innerspace, center=false);
		}
		// Center bar
		translate([-(barwidth)/2,-barthickness/2,height-barheight-outerthickness+overlap])
			cube([barwidth, barthickness, barheight], center=false);
	}

	// Render nubs
	for(angle=[0:nubspacing:min(360, floor(360/nubspacing) * nubspacing)])
	{
		rotate(angle)
		{
			translate([outersize/2-overlap,0,0])
			{
				if (nubstyle==1)
				{
					cube([nubdepth+overlap,nubwidth,nubheight], center=false);
				}
				if (nubstyle==2)
				{
					linear_extrude(height=nubheight)
						polygon(points=[[0,0],[0,nubwidth],[nubdepth+overlap,nubwidth/2]]);
				}
				if (nubstyle==3)
				{
					translate([overlap,0,0])
						cylinder(h=nubheight, r=nubdepth, center=false);
				}
				if (nubstyle==4)
				{
					translate([0,0,nubheight])
						rotate([0,90,0])
							cylinder(h=nubdepth+overlap, r=nubwidth, center=false);
				}
			}
		}	
	}
}