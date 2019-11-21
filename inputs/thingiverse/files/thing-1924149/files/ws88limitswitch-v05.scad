////////////////////////////////////////////////////////////////////////////////
//
// ws88limitswitch v05.scad
//
// Limit switch holder for Workshop 88 mill limit switches on DRO's
//
// By D. Scott Williamson 2016
// Designed to work on Replicator 2 (designed to work around slicer defects)
//
////////////////////////////////////////////////////////////////////////////////
//
// Version history:
//	 V5 code clean up and documentation
//	 V4 more refinements
//	 v3 clearance .3 added screw reinforcements
//	 v2 clearance .6 too big
//	 v1 clearance .2 too small
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
// Variables
//
////////////////////////////////////////////////////////////////////////////////

debug=true;		// set to false to render only the clip for printing

// 3D printer settings
nozzled=0.4;	// nozzle diameter
shells=6;			// Number of shells

// switch dimensions
	// body
	sww=6.5;
	swl=12.83;
	swh=5.72;
	// holes
	swhd=2.12;
	swh0x=2.2+swhd/2;
	swh1x=swl-(2.12+swhd/2);
	swhy=.48+swhd/2;
	swhz=.48;
	// leg
	swlw=1;
	swll=3.6;
	swlh=.42;
	// 3 leg offsets 
	swl0x=2-swlw;
	swl1x=7.03-swlw;
	swl2x=12.08-swlw;
	swly=-swll;
	swlz=3.17-swlh;
	// arm
	swat=.3;
	swaw=3.55;
	swal=12.43;
	swaa=atan(2.76/12);
	swax=1;
	sway=sww;
	swaz=(swh-swaw)/2;

// rod dimensions
	rodw=15.9;
	rodl=200;
	rodh=4;
// screw dimensions (M3)
	scd=3.3;	// diameter for 4-40 to pass through easily 3;	// 2.88 measured, but 3-3.2 all good for tapping with 6 shells
	scl=10;
	schd=5;
	schl=3;
	schhd=2.22;

// nut dimensions
	nutsd0=4.7;
	nutsd=nutsd0*cos(30);
	nutsh=1.56;

	nutmd0=6.3;
	nutmd=nutmd0/cos(30);
	nutmh=2.4;

	nutld0=6.3;
	nutld=nutld0/cos(30);
	nutlh=3.84;
	nutlhd=8;			// 4-40 lock nut capture hole diameter

	nut440hd=2.24;

// clip dimensions
	ct=nozzled*6;			// clip wall thickness
	clr=.3;						// clearance
	cpind=swhd-clr*2;	

	cliph=swh+clr*1+ct*1;

	// clip rod hole negative dimensions
	crodnw=rodw+clr*2;
	crodnh=rodh+clr;
	// clip rod hole outer negative dimensions with clearance
	crodow=crodnw+ct*2;
	crodoh=crodnh+ct*2;
	// clip switch negative dimensions
	cswnl=swl+clr*2;
	cswnw=sww+clr*2;
	cswnh=swh+clr*2;
	// clip switch outer negative dimensions with clearance
	cswol=cswnl+ct*2;
	cswoh=cswnh+ct*2;

	// clearance for the switch wire pins
	pinclr=1.5;
	pinhw=swl2x+swlw-swl0x+pinclr*2;
	pinhh=swlh+pinclr*2;

	// pin cone dimensions
	pcclr=clr;
	pcd0=swhd;
	pcd1=pcd0*0.75;
	pch=swh/4;

$fn=64;					// default number of facets on cylinders

////////////////////////////////////////////////////////////////////////////////
// 
// Modules
// 
////////////////////////////////////////////////////////////////////////////////

// The clip itself
module clip()
{
	/* 
	// needed if not using screw to hold switch
	// pins for switch holes
	translate([(rodw-swl)/2,-sww/2,rodh+swh+clr-pch])
	{
		translate([swh0x,swhy,0])
			cylinder(d0=pcd0,d1=pcd1,h=pch);
		translate([swh1x,swhy,0])
			cylinder(d0=pcd0,d1=pcd1,h=pch);
	}
	*/
	
	difference()
	{
		union()
		{
			// box on rod
			translate([-ct-clr,-ct*2-clr*2,-ct-clr])
				cube([crodow,cliph,crodoh]);
		
			// box on switch
			translate([-ct-clr+(crodow-cswol)/2,-ct*2-clr*2,-ct-clr+rodh])
				cube([cswol,cliph,cswoh]);

			// screw holes reinforcements
			translate([0,sww/2-cliph/2,0])
			{
				/*
				// for side screws
				translate([-7,0,rodh/2])
					rotate([0,90,0])
						cylinder(d=scd+ct*2,h=14+rodw);
				*/
				
				translate([rodw/2,-.5,rodh+swh+clr-2])
					cylinder(d=nutlhd+ct*2,h=nutlh+clr+ct+2,$fn=6);
			}		
		}

		// back with holes for legs
		union()
		{
			// negative rod
			translate([-clr,-10,-clr])
				cube([crodnw,20,crodnh]);
			
			// negative switch
			translate([(rodw-cswnl)/2,-cswnw/2,-clr+rodh])
				cube([cswnl,cswnw*2,cswnh]);

			// clearance for the pins
			translate([(rodw-swl)/2,-sww/2,rodh])
			{
				translate([swl0x,swly,swlz])
					translate([-pinclr,clr-swll,-pinclr])
						cube([pinhw,swll*2,pinhh]);
			}
			
			// screw hole(s)
			translate([0,sww/2-cliph/2,0])
			{
				/*
				// Side screws
				translate([-10,0,rodh/2])
					rotate([0,90,0])
						cylinder(d=scd,h=20+rodw);
				*/
				translate([rodw/2,-.5,0])
				{
					// screw hole
					cylinder(d=scd,h=30);
				
					// nut capture
					translate([0,0,rodh+swh+clr-2])
						cylinder(d=nutlhd,h=nutlh+clr+2,$fn=6);
				}
			}		

			// remove front and back from clip with big cubes
			translate([-15+rodw/2,0,-15+rodh+sww/2])
			{
				translate([0,swh/2+clr/2,0])
					cube([30,2,30]);

				translate([0,-swh/2-ct-2-clr/2,0])
					cube([30,2,30]);
			}
		}
	}
}

// DRO rod model
module rod()
{
	color([0.6,0.6,0.65])
	{
			cube([rodw,rodl,rodh]);
	}
}

// Socket head screw model
module screw()
{
	color([0.3,0.3,0.2])
	{
		cylinder(d=scd,h=scl);
		
		translate([0,0,scl])
			difference()
			{
				cylinder(d=schd,h=schl);
				translate([0,0,0.1])
				cylinder(d=schhd,h=schl,$fn=6);
			}
	}
}

// Switch model
module switch()
{
	// body
	color([0.2,0.2,0.2])
	{
		difference()
		{
			// body
			cube([swl,sww,swh]);
			// 2 holes
			translate([swh0x,swhy,-1])
				cylinder(d=swhd,h=sww+2);
			translate([swh1x,swhy,-1])
				cylinder(d=swhd,h=sww+2);
		}
	}
	// legs
	color([0.6,0.6,0.2])
	{
			translate([swl0x,swly,swlz])
				cube([swlw,swll,swlh]);
			translate([swl1x,swly,swlz])
				cube([swlw,swll,swlh]);
			translate([swl2x,swly,swlz])
				cube([swlw,swll,swlh]);
	}
	// arm
	color([0.6,0.6,0.6])
	{
			translate([swax,sway,swaz])
				rotate([0,0,swaa])
					cube([swal,swat,swaw]);
	}
}

// Nut model
module nut(od,ih,id)
{
	color([.9,.9,.99])
	difference()
	{
		cylinder(d=od,h=ih,$fn=6);
		translate([0,0,-1])
			cylinder(d=id,h=ih+2);
	}
}

// Test print to measure round hole diameter for screw
module testholes(thickness)
{
	spacing=5;
	count=10;
	delta=0.1;
	diameter=2.5;
	
	color([0.4,0.2,0.4])
	{
		difference()
		{
			translate([-spacing/2,-spacing*.5,0])
			cube([spacing*(count+1.5),spacing,thickness]);

			for(t=[0:count-1])
			{
					translate([t*(spacing+0.5),0,-thickness])
						cylinder(d=diameter+delta*t, h=thickness*3, $fn=128);
					echo("holed=",diameter+delta*t);
			}
		}      
	}
}

// Test print to measure hex hole fit to real nuts
module testnutholes(thickness)
{
	spacing=10;
	count=11;
	diameter=nutsd;
	delta=(nutld+0.5-diameter)/count;
	diameter=6;
	delta=(8-diameter)/(count-1);
	
	color([0.2,0.4,0.4])
	{
		difference()
		{
			translate([-spacing/2,-spacing*.5,0])
			cube([spacing*(count+1),spacing,thickness]);

			for(t=[0:count-1])
			{
					translate([t*(spacing+0.5),0,-thickness])
						cylinder(d=diameter+delta*t, h=thickness*3, $fn=6);
					echo("nutholed=",diameter+delta*t);
			}
		}      
	}
}

// Final rendering.

if (!debug) 
{
	// just the clip lying for 3D printing
	rotate([90,0,0])
		clip();
}
else
{
	// Small medium and large nuts
	translate([-30,0,0])
		nut(nutsd,nutsh,nut440hd);
	translate([-20,0,0])
		nut(nutmd,nutmh,nut440hd);
	translate([-10,0,0])
		nut(nutld,nutlh,nut440hd);
	
	// Test pattern for screw holes
	translate([0,-20,0])
		testholes(1);
	
	// Test piece for captured nut holes
	translate([0,-30,0])
		testnutholes(1);

	// A clip
	color([1,.5,0])
		translate([30,15,0])
			rotate([90,0,0])
			clip();

	// the DRO rod
	rod();
	translate([0,20,0])
	{
		// screw 
		translate([0,sww/2-cliph/2,10])
		{
			translate([rodw/2,-.5,0])
			screw();
		}

		// The switch
		translate([(rodw-swl)/2,-sww/2,rodh])
			switch();

		// Translucent switch clip on DRO
		color([1,.5,0,.5])
			clip();
	}
}
