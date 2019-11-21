// -*-  coding: utf-8 -*-
//
// Coin spinner
// A slightly modified Money Spinner
//
// Copyright 2017 -- 2018 ospalh (Roland Sieker) <ospalh@gmail.com>
// Licensed CC-BY-SA https://creativecommons.org/licenses/by-sa/4.0/


// Original header below
/*
    Filename: moneySpinner02
    Dated: 2017-01-15T08:21:52+10:00
    Version: 0.6
    Author: Geoff Buttsworth
    Twitter: @gbutts9

    This version is designed to work with the Thingiverse Customizer.
    Ref: http://customizer.makerbot.com/docs

    Uploaded to Customizer 2016-12-08T21:16:25+10:00

    Change Log:
    	0.2 - Initial upload to Customizer
    	0.3 - Activated 'Flush' parameter
    	0.4 - Added Qatari 50 dirham (QA 0.5QAR) Ref: https://www.catawiki.com/catalog/coins/countries/qatar/432219-qatar-50-dirhams-1973-year-1393
    	0.5 - Added US 5c, deleted CR2032 at coin 8
    	0.6 - Added option to delete knurled finish
*/

/*
    The knurled library is incorporated in toto here as Customizer is limited to one SCAD file.

	 * knurledFinishLib_v2.scad
	 *
	 * Written by aubenc @ Thingiverse
	 *
	 * This script is licensed under the Public Domain license.
	 *
	 * http://www.thingiverse.com/thing:31122
	 *
	 * Derived from knurledFinishLib.scad (also Public Domain license) available at
	 *
	 * http://www.thingiverse.com/thing:9095
	 *
*/

/* [Spinner_Parameters] */

// Measure your coin or look it up on Wikipedia or elsewhere
coin_diameter = 22.2;  // [10:0.1:30]

// Measure or look it up. Both sizes in mm.
coin_thickness = 2.1; // [0.2:0.1:7]

Number_of_Spokes=3;//[2,3,4,5,6,7]
spokeNumber=Number_of_Spokes;

// Smooth deletes knurled edge but adds 1 mm to rim for strength
Edge_finish=1;//[0:Smooth,1:Knurled]
finish=Edge_finish;

//Flush for easier printing
Flush_or_Raised_Hub=1;//[0:Hub,1:Flush]
flush=Flush_or_Raised_Hub;		//Flush is easier to print, the hub is height of bearing and may print with support

//knurledFinishLib_v2
	/*
	 * Usage:
	 *
	 *	 Drop this script somewhere where OpenSCAD can find it (your current project's
	 *	 working directory/folder or your OpenSCAD libraries directory/folder).
	 *
	 *	 Add the line:
	 *
	 *		use <knurledFinishLib_v2.scad>
	 *
	 *	 in your OpenSCAD script and call either...
	 *
	 *    knurled_cyl( Knurled cylinder height,
	 *                 Knurled cylinder outer diameter,
	 *                 Knurl polyhedron width,
	 *                 Knurl polyhedron height,
	 *                 Knurl polyhedron depth,
	 *                 Cylinder ends smoothed height,
	 *                 Knurled surface smoothing amount );
	 *
	 *  ...or...
	 *
	 *    knurl();
	 *
	 *	If you use knurled_cyl() module, you need to specify the values for all and
	 *
	 *  Call the module ' help(); ' for a little bit more of detail
	 *  and/or take a look to the PDF available at http://www.thingiverse.com/thing:9095
	 *  for a in depth descrition of the knurl properties.
	 */


	module knurl(	k_cyl_hg	= 12,
						k_cyl_od	= 25,
						knurl_wd =  3,
						knurl_hg =  4,
						knurl_dp =  1.5,
						e_smooth =  2,
						s_smooth =  0)
	{
	    knurled_cyl(k_cyl_hg, k_cyl_od,
	                knurl_wd, knurl_hg, knurl_dp,
	                e_smooth, s_smooth);
	}

	module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
	{
	    cord=(cod+cdp+cdp*smt/100)/2;
	    cird=cord-cdp;
	    cfn=round(2*cird*PI/cwd);
	    clf=360/cfn;
	    crn=ceil(chg/csh);


		 if( fsh < 0 )
	    {
	        union()
	        {
	            shape(fsh, cird+cdp*smt/100, cord, cfn*4, chg);

	            translate([0,0,-(crn*csh-chg)/2])
	              knurled_finish(cord, cird, clf, csh, cfn, crn);
	        }
	    }
	    else if ( fsh == 0 )
	    {
	        intersection()
	        {
	            cylinder(h=chg, r=cord-cdp*smt/100, $fn=2*cfn, center=false);

	            translate([0,0,-(crn*csh-chg)/2])
	              knurled_finish(cord, cird, clf, csh, cfn, crn);
	        }
	    }
	    else
	    {
	        intersection()
	        {
	            shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

	            translate([0,0,-(crn*csh-chg)/2])
	              knurled_finish(cord, cird, clf, csh, cfn, crn);
	        }
	    }
	}

	module shape(hsh, ird, ord, fn4, hg)
	{
		x0= 0;	x1 = hsh > 0 ? ird : ord;		x2 = hsh > 0 ? ord : ird;
		y0=-0.1;	y1=0;	y2=abs(hsh);	y3=hg-abs(hsh);	y4=hg;	y5=hg+0.1;

		if ( hsh >= 0 )
		{
			rotate_extrude(convexity=10, $fn=fn4)
			polygon(points=[	[x0,y1],[x1,y1],[x2,y2],[x2,y3],[x1,y4],[x0,y4]	],
						paths=[	[0,1,2,3,4,5]	]);
		}
		else
		{
			rotate_extrude(convexity=10, $fn=fn4)
			polygon(points=[	[x0,y0],[x1,y0],[x1,y1],[x2,y2],
									[x2,y3],[x1,y4],[x1,y5],[x0,y5]	],
						paths=[	[0,1,2,3,4,5,6,7]	]);
		}
	}

	module knurled_finish(ord, ird, lf, sh, fn, rn)
	{
	    for(j=[0:rn-1])
	    {
            h0=sh*j;
            h1=sh*(j+1/2);
            h2=sh*(j+1);

            for(i=[0:fn-1])
	        {
                lf0=lf*i;
                lf1=lf*(i+1/2);
                lf2=lf*(i+1);

	            polyhedron(
	                points=[
	                     [ 0,0,h0],
	                     [ ord*cos(lf0), ord*sin(lf0), h0],
	                     [ ird*cos(lf1), ird*sin(lf1), h0],
	                     [ ord*cos(lf2), ord*sin(lf2), h0],

	                     [ ird*cos(lf0), ird*sin(lf0), h1],
	                     [ ord*cos(lf1), ord*sin(lf1), h1],
	                     [ ird*cos(lf2), ird*sin(lf2), h1],

	                     [ 0,0,h2],
	                     [ ord*cos(lf0), ord*sin(lf0), h2],
	                     [ ird*cos(lf1), ird*sin(lf1), h2],
	                     [ ord*cos(lf2), ord*sin(lf2), h2]
	                    ],
	                faces=[
	                     [0,1,2],[2,3,0],
	                     [1,0,4],[4,0,7],[7,8,4],
	                     [8,7,9],[10,9,7],
	                     [10,7,6],[6,7,0],[3,6,0],
	                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
	                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
	                    ],
	                convexity=5);
	         }
	    }
	}


//Default values
	$fa=0.8;
	$fs=0.8;

//Variables:

	brg_d=22.0;
	brg_z=7.0;

    rim=5;	//Nominal thickness for hub, adjustable as below for smooth finish

	//If smooth rim: add 1mm for extra strength to coin holders only
	rim_x=finish==0 ? rim+1 : rim;

    // Number of coins is now calculated
    stack = floor(brg_z/coin_thickness);

    echo("Use ", stack, " coins per spoke.");

	holder_d=coin_diameter+rim_x;
	holder_z=coin_thickness*stack;

	spoke_x=coin_diameter/2;
	spoke_y=coin_diameter/3;
	spoke_z=holder_z;


	//If flush: hub will be height of coin stack otherwise height of bearing
	hub_z=flush==1 ? coin_thickness*stack : brg_z;


//SpinnerModules

	module dollarHolder() {
		translate([0,coin_diameter/2+spoke_y,0])
		difference() {
			translate([0,0,-coin_thickness*stack/2])
			if(finish == 1)
				knurl(k_cyl_hg=holder_z,k_cyl_od=holder_d);
			else
				cylinder(d=holder_d,h=holder_z,center=false);
			cylinder(d=coin_diameter,h=holder_z+4,center=true);
		}
	}

	module hub() {
			cylinder(h=hub_z,d=brg_d+rim,center=true);
	}

	module spoke() {
		translate([0,spoke_y/2,0])
			cube([spoke_x,spoke_y,spoke_z], center=true);
	}

	module brgVoid() {
		cylinder(h=brg_z+2,d=brg_d,center=true);
	}

	module holderSpoke() {
		translate([0,brg_d/2,0])
		union() {
			dollarHolder();
			spoke();
		}
	}

//Rotate
	rA = 360/spokeNumber;	//rotational angle
	fA = round(360-rA);		//final angle

	module spinner() {
		for (i = [0:rA:fA]) {
			rotate([0,0,i])
				holderSpoke();
		}
	}

//Finalise
	module plus() {
		hub();
		spinner();
	}

	module minus() {
		brgVoid();
	}

	//Render
	difference() {
		plus();
		minus();
	}
