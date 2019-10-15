/*
    Filename: moneySpinner02
    Dated: 2017-06-05T18:56:57+10:00
    Version: 0.9
    Author: Geoff Buttsworth
    Twitter: @gbutts9

    This version is designed to work with the Thingiverse Customizer.
    Ref: http://customizer.makerbot.com/docs

    Uploaded to Customizer 2017-06-06T08:49:39+10:00

    Change Log: 
    	0.2 - Initial upload to Customizer
    	0.3 - Activated 'Flush' parameter
    	0.4 - Added Qatari 50 dirham (QA 0.5QAR) Ref: https://www.catawiki.com/catalog/coins/countries/qatar/432219-qatar-50-dirhams-1973-year-1393
    	0.5 - Added US 5c, deleted CR2032 at coin 8
    	0.6 - Added option to delete knurled finish
    	0.7 - Added US 1c, deleted 50 dirham
    	0.8 - Added optional orbits
    	0.8.1 - Repaired intended US nickel height to 3
    	0.8.2 - Added 1 as an option for 'number of spokes' for an out of balance spinner
    	0.9 - Larger 6902 bearing option

    Refs:
    	UK:	http://www.royalmint.com/discover/uk-coins/coin-design-and-specifications
    	US: https://www.usmint.gov/learn/coin-and-medal-programs/coin-specifications
    	AU: https://en.wikipedia.org/wiki/Coins_of_the_Australian_dollar
    	EU: https://en.wikipedia.org/wiki/Euro_coins	
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
//Which coin do you want to use?
coin_list=7;//[1:AU $2,2:AU 5c,3:US 10c,4:UK £1,5:UK 5p,6:EU €1,7:US 1c,8:US 5c]
coin=coin_list;

//How many spokes should the spinner have?
Number_of_Spokes=5;//[1,2,3,4,5,6,7]
spokeNumber=Number_of_Spokes;

//Choose Knurled if you are tough enough, otherwise Smooth 
Edge_finish=0;//[0:Smooth,1:Knurled]
finish=Edge_finish;		//Smooth deletes knurled edge but adds 1mm to rim for strength

//Flush for easier printing 
Flush_or_Raised_Hub=1;//[0:Hub,1:Flush]
flush=Flush_or_Raised_Hub;		//Flush is easier to print, the hub is height of bearing and may print with support

//What about orbits to finish it off?
Orbits_or_No_Orbits=1;//[0:None,1:Orbits]
orbit=Orbits_or_No_Orbits;		//Orbits link between the coins. They add some strength but are really for show

//608 or 6902 bearings?
608_or_6902=0;//[0:608,1:6902]
brg=608_or_6902;


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

	    echo("knurled cylinder max diameter: ", 2*cord);
	    echo("knurled cylinder min diameter: ", 2*cird);

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
	    assign(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
	    {
	        for(i=[0:fn-1])
	        assign(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
	        {
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
	                triangles=[
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

	module knurl_help()
	{
		echo();
		echo("    Knurled Surface Library  v2  ");
	   echo("");
		echo("      Modules:    ");
		echo("");
		echo("        knurled_cyl(parameters... );    -    Requires a value for each an every expected parameter (see bellow)    ");
		echo("");
		echo("        knurl();    -    Call to the previous module with a set of default parameters,    ");
		echo("                                  values may be changed by adding 'parameter_name=value'        i.e.     knurl(s_smooth=40);    ");
		echo("");
		echo("      Parameters, all of them in mm but the last one.    ");
		echo("");
		echo("        k_cyl_hg       -   [ 12   ]  ,,  Height for the knurled cylinder    ");
		echo("        k_cyl_od      -   [ 25   ]  ,,  Cylinder's Outer Diameter before applying the knurled surfacefinishing.    ");
		echo("        knurl_wd     -   [   3   ]  ,,  Knurl's Width.    ");
		echo("        knurl_hg      -   [   4   ]  ,,  Knurl's Height.    ");
		echo("        knurl_dp     -   [  1.5 ]  ,,  Knurl's Depth.    ");
		echo("        e_smooth   -    [  2   ]  ,,  Bevel's Height at the bottom and the top of the cylinder    ");
		echo("        s_smooth   -    [  0   ]  ,,  Knurl's Surface Smoothing :  File donwn the top of the knurl this value, i.e. 40 will snooth it a 40%.    ");
		echo("");
	}

//Allocate coin data

	coinName=coin==2 ? "AU $2" : 
		(coin==2 ? "AU 5c" : 
			(coin==3 ? "US 10c" :
				(coin==4 ? "UK £1" :
					(coin==5 ? "UK 5p" :
						(coin==6 ? "EU €1" :
							(coin==7 ? "US 1c" : "US 5c")
						)	
					)	
				)
			)
		);

	coin_d=coin==1 ? 20.5 : 
		(coin==2 ? 19.4 : 
			(coin==3 ? 17.90 :	
				(coin==4 ? 22.5 :
					(coin==5 ? 18.0 :
						(coin==6 ? 23.3 :
							(coin==7 ? 19.05 : 21.3)
						)
					)	
				)
			)
		);

	coin_z=coin==1 ? 2.8 : 
		(coin==2 ? 1.3 : 
			(coin==3 ? 1.35 :
				(coin==4 ? 3.15 :
					(coin==5 ? 1.8 :
						(coin==6 ? 2.35 :
							(coin==7 ? 1.50 : 1.95)
						)
					)	
				)
			)
		);

	stack=coin==2 ? 3 : 
		(coin==3 ? 3 : 
			(coin==5 ? 3 :
				(coin==7 ? 3 :
					(coin==8 ? 3 : 2)
				)
			)	
		);

//Default values
	$fa=0.8;
	$fs=0.8;

//Variables:

	rim=5;	//Nominal thickness for hub, adjustable as below for smooth finish

	//If smooth rim: add 1mm for extra strength to coin holders only
	rim_x=finish==0 ? rim+1 : rim;	

	holder_d=coin_d+rim_x;
	holder_z=coin_z*stack;

	brg_d=22.0;	//608
	brg_z=7.0;	//both

	brg_d2=28;	//6902

	spoke_x=coin_d/2;
	spoke_y=coin_d/3;
	spoke_z=holder_z;

	//void_r=(brg_d+rim_x+spoke_y+coin_d)/2;

	void_r=(brg_d/2+coin_d/2+spoke_y);

	orbit_d=50;

	//If flush: hub will be height of coin stack otherwise height of bearing
	hub_z=flush==1 ? coin_z*stack : brg_z;	

	//Bearing size
	brgfinal=brg==1 ? brg_d2 : brg_d;

//SpinnerModules

	module dollarHolder() {
		translate([0,coin_d/2+spoke_y,0])
			translate([0,0,-coin_z*stack/2])
			if(finish == 1) 
				knurl(k_cyl_hg=holder_z,k_cyl_od=holder_d); 
			else
				cylinder(d=holder_d,h=holder_z,center=false);
	}

	module hub() {
			cylinder(h=hub_z,d=brgfinal+rim,center=true);
	}

	module spoke() {
		translate([0,spoke_y/2,0])
			cube([spoke_x,spoke_y,spoke_z], center=true);
	}

	module brgVoid() {
		cylinder(h=brg_z+2,d=brgfinal,center=true);
	}

	module holderVoid() {
		for (i = [0:rA:fA]) {
			rotate([0,0,i])
				cylinder(d=coin_d,h=holder_z+4,center=true);
		}
	}	

	module holderSpoke() {
		translate([0,brg_d/2,0])
		union() {
			dollarHolder();
			spoke();
		}
	}

	module orbits() {
		difference() {
			cylinder(h=holder_z,d=orbit_d,center=true);
			cylinder(h=holder_z+1,d=orbit_d-rim,center=true);
		}	
		difference() {
			cylinder(h=holder_z,d=orbit_d+20,center=true);
			cylinder(h=holder_z+1,d=orbit_d+20-rim,center=true);
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

	module holderVoid() {
		for (i = [0:rA:fA]) {
			rotate([0,0,i])
		translate([0,void_r,0])
				cylinder(d=coin_d,h=holder_z+4,center=true);
		}
	}	

//Finalise
	module plus() {
		hub();
		spinner();
		if(orbit == 1) 
			orbits();
	}

	module minus() {
		brgVoid();
		holderVoid();
	}

	//Render
	difference() {
		plus();
		minus();
	}