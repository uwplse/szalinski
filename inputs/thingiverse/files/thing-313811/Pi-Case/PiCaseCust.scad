// Raspberry Pi Case Design
// TrevM 28 April 2014

use <write/Write.scad> 

/* [Global] */

// preview[view:north, tilt:bottom]

// What quality?
$fn = 40;

// What name?
Name = "Trev";

// What Size?
NSize = 12;	// [1:30]

/* [Hidden] */

Trans = 1.0;
thk = 2.5;
logoDeep = thk-1;

translate([-56-4,-85/2,0])	top();
translate([4,-85/2,0])		base();

module top()
{
	wide = 56+((thk+0.1)*2);
	long = 85+((thk+0.1)*2);
	translate([-thk-0.1, -thk-0.1,0])	{
		difference()	{															// base
			cube([wide,long,thk]);
			translate([thk,thk+1,-0.1])			cube([10,12,thk+0.2]);	// clear LEDs
			translate([thk+2,thk+51.5,-0.1])		cube([4,32,thk+0.2]);	// clear GPIO cable
			//translate([10,30,-0.1]) linear_extrude(height=logoDeep) import("logo1.dxf",scale=0.2);
			translate([10,30,-0.1]) logo(logoDeep);
			translate([30,27.5,0])	rotate([0,180,0])	write(Name,t=logoDeep,h=NSize,center=true);
		}

		translate([wide-(16+(thk*2))-23.5,-7.5+thk,0])	cube([16+(thk*2),7.6,thk]);	// USB base
		translate([wide-(16+(thk*2))-23.5,-7.5+thk,0])	cube([thk+0.5,7.5,19.4]);		// USB R 
		translate([wide-23.5-thk,-7.5+thk,0])				cube([thk,7.5,19.4]);			// USB L

		translate([wide-(18+(thk*2))-1,0,thk-0.1])		cube([18+(thk*2)+1,thk,3]);	// ethernet
		translate([wide-(18+(thk*2))-1,0,thk-0.1])		cube([3,thk,19.5-thk]);		// ethernet R
		translate([wide-thk-1.5,0,thk-0.1])				cube([4,thk,19.5-thk]);		// ethernet R

		translate([wide-thk,32.5,thk-0.1])				cube([1,16+(thk*2),10.1]);		// hdmi (thin)
		translate([wide-thk,32.5,thk-0.1])				cube([thk,16+(thk*2),7]);		// hdmi (thick)
		translate([wide-thk,32.5,thk-0.1])				cube([1,thk,19.4-thk]);		// hdmi R
		translate([wide-thk,33+15.5+thk,thk-0.1])			cube([1,thk,19.4-thk]);		// hdmi L

		translate([wide-2.5-(8.5+(thk*3)),85.2+thk,thk-0.1])		cube([8.5+(thk*4),1,13.5]);		// mini usb (thin)
		translate([wide-2.5-(8.5+(thk*3)),85.2+thk+0.2,thk-0.1])	cube([8.5+(thk*4),thk-0.2,10]);	// mini usb (thick)
		translate([wide-2.5-(8.5+(thk*3)),85.2+thk,thk-0.1])		cube([(thk*2)-0.5,1,19.4-thk]);	// mini usb L
		translate([wide-(thk*2),85.2+thk,thk-0.1])				cube([(thk*2),1,19.4-thk]);		// mini usb R

		translate([wide-16-(28+(thk*2)),85+thk+0.2,thk-0.1])		cube([28+(thk*2),thk,18]);		// card holder

		translate([wide-thk,0,thk-0.1])							cube([thk,33-0.1,18.5]);		// near L wall (thick)
		translate([wide-thk+1.1,0,thk+18.5-0.1])					cube([thk-1.1,33-0.1,3.5]);	// near L wall (thin)
		translate([wide-thk,thk,thk+15.5])		rotate([-90,0,0])	cylinder(r=1,h=33-thk-0.1);	// near L wall PCB retainer
		translate([wide-thk+1.1,0,thk+20.6-0.1])	rotate([-90,0,0])	cylinder(r=0.6,h=33-0.1);		// near L wall base retainer
		
		translate([wide-thk,48.1+(thk*2),thk-0.1])				cube([thk,35.6,18.5]);				// far L wall (thick)
		translate([wide-thk+1.1,48.1+(thk*2),thk+18.5-0.1])		cube([thk-1.1,35.6,3.5]);			// far L wall (thin)
		translate([wide-thk,48.1+(thk*2),thk+15.5])			rotate([-90,0,0])	cylinder(r=1,h=35.5-0.1);	// far L wall PCB retainer
		translate([wide-thk+1.1,48.1+(thk*2),thk+20.6-0.1])	rotate([-90,0,0])	cylinder(r=0.6,h=35.5-0.1);	// far L wall base retainer

		translate([0,0,thk-0.1])								cube([thk,14.4+thk,18.5]);			// near R wall (thick)
		translate([0,0,thk+18.5-0.1])							cube([thk-1.1,14.4+thk,3.5]);		// near R wall (thin)
		translate([thk,thk,thk+15.5])			rotate([-90,0,0])	cylinder(r=1,h=14.4);				// near R wall PCB retainer
		translate([thk-1.3,0,thk+20.6-0.1])	rotate([-90,0,0])	cylinder(r=0.6,h=14.4+thk);		// near R wall base retainer

		translate([0,26.6+thk,thk-0.1])						cube([thk,7.3,18.5]);			// centre R wall (thick)
		translate([0,26.6+thk,thk+18.5-0.1])					cube([thk-1.1,7.3,3.5]);		// centre R wall (thin)

		translate([0,44.6+thk,thk-0.1])						cube([thk,40+thk,18.5]);			// far R wall (thick)
		translate([0,44.6+thk,thk+18.5-0.1])					cube([thk-1.1,40+thk,3.5]);		// far R wall (thin)
		translate([thk,44.6+thk,thk+15.5])			rotate([-90,0,0])	cylinder(r=1,h=40+thk);		// far R wall PCB retainer
		translate([thk-1.3,44.6+thk,thk+20.6-0.1])	rotate([-90,0,0])	cylinder(r=0.6,h=40+thk);		// far R wall base retainer

		translate([0,long-thk,thk-0.1])						cube([12.6,thk,18.5]);			// back wall (thick)
		translate([0,long-thk+1,thk+18.5-0.1])				cube([12.6,thk-1,3.5]);		// back wall (thin)

		translate([0,0,thk-0.1])								cube([16.5,thk,18.6]);			// front wall (thick)
		translate([0,0,thk-0.1])								cube([16.8,thk,17]);			// front wall (thick)
		translate([0,0,thk+18.5-0.1])							cube([16.5,thk-1,3.5]);		// front wall (thin)

		translate([0,14+thk,thk-0.1])	{											// ear jack
			difference()	{
				cube([thk,13,10.1]);
				translate([-0.1,6.5,10.1])	rotate([0,90,0])	cylinder(r=4,h=thk+0.2);
			}
		}
		translate([0,33.5+thk,thk-0.1])	{												// comp vid
			difference()	{
				cube([thk,11.5,7]);
				translate([-0.1,5.75,8.5])	rotate([0,90,0])	cylinder(r=5,h=thk+0.2);
			}
		}
	}
}

module base()
{
	translate([-thk-0.1, -thk-0.1,0])	{
		cube([56+((thk+0.1)*2),85+((thk+0.1)*2),thk]);						// base
		translate([43.6+thk,5.1+thk,thk-0.1])		cylinder(r=3.5,h=3.5);
		translate([18.1+thk,60.1+thk,thk-0.1])	cylinder(r=3.5,h=3.5);

		translate([16,85.5+thk,0])	{										// card holder base
			difference()	{
				cube([27.5+(thk*2),17,thk+1]);
				translate([(27.5/2)+thk,17+3,-0.1])	cylinder(r=10,h=thk+2);
			}
		}	
		translate([16,85.5+thk,thk+0.9])			cube([thk+1.5,17,3.1]);		// card holder R side
		translate([17.5+25+thk,85.5+thk,thk+0.9])	cube([thk+1,17,3.1]);			// card holder L side

		translate([23.5,-7.5+thk,0])					cube([16+(thk*2),7.6,thk]);		// USB base
		translate([23.5,-7.5+thk,thk-0.1])			cube([16+(thk*2),thk,thk+2.6]);	// USB front
		translate([23.5,-7.5+thk,thk-0.1])			cube([thk,7,thk+2.6]);				// USB L side
		translate([23.5+16+thk,-7.5+thk,thk-0.1])		cube([thk,7,thk+2.6]);				// USB R side

		difference()	{
			union()	{
				translate([thk-1,thk-1,thk-0.1])		cube([56+2,2,3.5]);				// front lip
				translate([thk-1,0,thk-0.1])			cube([2,85+2,3.5]);				// left lip
				translate([56+2,thk-1,thk-0.1])		cube([2,85+2,3.5]);				// right lip
				translate([thk-1,85.5+1,thk-0.1])		cube([15.1,2,3.5]);				// back L lip
				translate([18+27+thk,85.5+1,thk-0.1])	cube([12.5,2,3.5]);				// back L lip

				translate([thk+0.1,0,thk-0.1])		cube([18+(thk*2),thk,thk+2.6]);	// ethernet
				translate([thk-1,33,thk-0.1])			cube([1,15+(thk*2),thk+2.6]);		// hdmi
				translate([2.5,85+thk,thk-0.1])		cube([8.5+(thk*2),1,thk+2.6]);	// mini usb
			}
			translate([thk-1,-0.1,thk+1.5])	rotate([-90,0,0])	cylinder(r=0.7,h=85+(thk*2));
			translate([56+(thk*2)-1,-0.1,thk+1.5])	rotate([-90,0,0])	cylinder(r=0.7,h=85+(thk*2));
		}
		translate([0,33,thk-0.1])				cube([thk,15+(thk*2),2.6]);		// hdmi
		translate([56.5+thk,14.5+thk,thk-0.1])	{								// ear jack
			difference()	{
				cube([thk-0.3,12,1.4+10.5]);
				translate([-0.1,6,1.4+10.5])	rotate([0,90,0])	cylinder(r=4,h=thk+0.2);
			}
		}
		translate([56.5+thk,34+thk,thk-0.1])	{									// comp vid
			difference()	{
				cube([thk-0.3,10.5,1+8.1+3.5]);
				translate([-0.1,5.25,1.9+8.1+3.5])	rotate([0,90,0])	cylinder(r=5,h=thk+0.2);
			}
		}
	}
}

module logo()
{
	//off=-50;
	//off=0;
	//translate([off,0,0])	linear_extrude(height=logoDeep) import("logo1.dxf",scale=0.2);
	
	translate([13.5,42.5,0])	leaf(logoDeep);
	translate([27,42.5,0])		mirror([1,0,0])	leaf(logoDeep);
	difference()
	{
		RaspOut(logoDeep);
		RaspIn(logoDeep+0.2);
	}
}

module leaf(hi)
{
	difference()
	{
		leafOut(hi);
		translate([-0.8,-0.4,-0.1])	leafIn(hi+0.2);
	}
}

module leafOut(hi)
{
	rotate([0,0,-34])	hull()	// bottom half
	{
		rotate([0,0,3])		squash(15.5,5,4,hi);
		translate([1.8,0,0])	cylinder(r=5.5,h=hi);
		translate([-1,-0.5,0])	cylinder(r=5.4,h=hi);
	}
}

module leafIn(hi)
{
	rotate([0,0,-35])	hull()	// bottom half
	{
		squash(11,1.5,6,hi);
		translate([2.2,-1.8,0])	cylinder(r=1.8,h=hi);
		translate([-1,-2.2,0])		cylinder(r=1.6,h=hi);
	}
	translate([1,1,0])	rotate([0,0,156])	//hull()	// bottom half
	{
		squash(12,1,6,hi);
		//translate([2.2,-1.8,0])	cylinder(r=1.8,h=hi);
		//translate([-1,-2.2,0])		cylinder(r=1.6,h=hi);
	}
}

module RaspOut(hi)
{
	hull()
	{
		translate([20.5,12.5,0])	cylinder(r=5,h=hi);	// bottom lobe
		translate([20.9,34.5,0])	cylinder(r=5,h=hi);	// top lobe
		translate([11,24.9,0])		cylinder(r=6,h=hi);	// left lobe
		translate([30,24.9,0])		cylinder(r=6,h=hi);	// right lobe
		translate([14,18,0])		cylinder(r=6.5,h=hi);	// bl lobe
		translate([27,18,0])		cylinder(r=6.5,h=hi);	// br lobe
	}
	translate([14.2,30.6,0])		cylinder(r=6.5,h=hi);	// tl lobe
	translate([27,30.6,0])			cylinder(r=6.5,h=hi);	// tr lobe
}

module RaspIn(hi)
{
	translate([0,0,-0.1])
	{
		// 3 centre shapes
		translate([20.75,18.75,0])	linear_extrude(height=hi) scale([1.1,1,1])	circle(4.25);
		translate([25.8,26.75,0])	rotate([0,0,-66])	linear_extrude(height=hi) scale([1.15,1,1])	circle(4.25);
		translate([15.4,26.75,0])	rotate([0,0,66])	linear_extrude(height=hi) scale([1.15,1,1])	circle(4.25);
		translate([20.7,11.5,0])	squash(9,3.5,5,hi);							// bottom shape
		translate([20.5,33.7,0])	rotate([0,0,180])	squash(9,3.7,6,hi);		// top shape
		translate([12.2,17,0])		rotate([0,0,-53])	squash(9.1,4.5,6.2,hi);	// bl shape
		translate([29,17,0])		rotate([0,0,53])	squash(9.1,4.5,6.2,hi);	// br shape
		translate([8.6,25,0])		rotate([0,0,-98])	squash(8,2,5,hi);			// l shape
		translate([32.3,25,0])		rotate([0,0,98])	squash(8,2,5,hi);			// r shape
		translate([12.6,33,0])		rotate([0,0,-142])	squash(8,2,5,hi);			// tl shape
		translate([28.5,33,0])		rotate([0,0,142])	squash(8,2,5,hi);			// tr shape
	}
}

module squash(w,t,b,hi)
{
	// top arf	
	resize(newsize=[w,t,hi])	cylinder(r=4,h=hi);
	// bottom arf
	difference()
	{
		resize(newsize=[w,b,hi]) 		cylinder(r=4,h=hi);
		translate([-(w+1)/2,0,-0.1])	cube([w+1,b,0.2+hi]);
	}
}

