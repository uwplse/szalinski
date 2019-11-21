/*
 * levelKnobs.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:106381
 *
 * Easy knobs for a captured nut, some assembly required.
 *
 * Includes the code from the Knurled Surface Library v2 available at
 *
 * http://www.thingiverse.com/thing:32122
 * 
 */

/* ********* Parameters ********************************************************* */

// to cut into the knurled surface
Number_of_Slots = 6;

// 
Knob_Height = 8;

// 
knurl_Diameter = 16;

// Solid bottom surface
Bottom_Thickness = 1.5;

// 
Bolt_Diameter = 3.25;

// Nut's across flats distance
Across_Flats = 5.6;

// Height for the captive nut
Nut_Thickness = 2.5;

// Including tolerance
Spring_Outer_Diameter = 9.5;

// (this value smaller than the Spring diameter)
Washer_Tolerance = 0.25;

// 
Washer_Thickness = 0.8;

// Faceting for cylindrical shapes
Resolution = 0.5;


/* ********* Reassigned ********************************************************* */

gno = Number_of_Slots;
khg = Knob_Height;
kad = knurl_Diameter;
btk = Bottom_Thickness;
bod = Bolt_Diameter;
nff = Across_Flats;
ntk = Nut_Thickness;
sod = Spring_Outer_Diameter;
wtl = Washer_Tolerance;
wtk = Washer_Thickness;
res = Resolution;


/* ********* Computed *********************************************************** */

kmd = kad+1.5+1.5*40/100;
kar = kmd/2;	
glf = gno > 0 ? 360/gno/4 : 0;
grd = gno > 0 ? kar*tan(glf) : 0;
brd = bod/2;
nrd = nff/2/cos(30);
srd = sod/2;
wod = sod-wtl;
wrd = wod/2;


/* ********* Functions ********************************************************** */

function fn4r(r) = fn4d(2*r);
function fn4d(d) = 4*round(d*PI/4/res);


/* ********* Modules ************************************************************ */

knob_n_washer();

//knurl_help();


/* ********* Code ** ************************************************************ */

module knob_n_washer()
{
	translate([0,(kmd+wod)/2-kmd/2+1,0]) top_knob();
	translate([0,-((kmd+wod)/2-wod/2)-1,0]) washer();
}

module washer()
{
	difference()
	{
		cylinder(h=wtk, r=wrd, $fn=fn4r(wrd), center=false);

		translate([0,0,-0.1])
		cylinder(h=wtk+0.2, r=brd, $fn=fn4d(bod), center=false);
	}
}

module top_knob()
{
	difference()
	{
		knob_body();

		union()
		{
			translate([0,0,-0.1])
			cylinder(h=khg+0.2, r=brd, $fn=fn4d(bod), center=false);

			translate([0,0,btk])
			cylinder(h=khg, r=nrd, $fn=6, center=false);

			translate([0,0,btk+ntk])
			cylinder(h=khg, r=srd, $fn=fn4d(sod), center=false);
		}
	}
}

module knob_body()
{
	difference()
	{
		knurl(k_cyl_hg=khg, k_cyl_od=kad, s_smooth=40);

		if( gno > 1 )
		{
			for(i=[0:gno-1])
			{
				rotate([0,0,4*i*glf]) translate([kar,0,-0.1])
				cylinder(h=khg+0.2, r=grd, $fn=fn4r(grd), center=false);
			}
		}
	}
}


/* ********* Knurled Surface Library v2 ***************************************** */

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

