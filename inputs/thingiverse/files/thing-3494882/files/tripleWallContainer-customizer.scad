/*
 * tripleWallContainer.scad    by meshconnoisseur
 *
 * Last update 2019-03-15 using OpenSCAD 2015.03-2
 *
 * Creates a screw-top container with two levels of threads.
 *
 * Uses Poor Man's OpenSCAD Screw Library and Knurled Finish Library by aubenc:
 * http://www.thingiverse.com/thing:8796
 * http://www.thingiverse.com/thing:31122
 *
 * CC Public Domain
 */
 

/* [Hidden] */
PI = 3.14159265;

// resolution settings, smaller is finer
$fa = 6;          // minimum angular circle detail (def. 6)
screw_res = PI/2; // smaller is finer but slower (def. PI/2)

/* [Sizing] */
// internal storage region height
core_height = 35; // [10:100]
// internal storage region diameter
core_diameter = 25; // [10:100]
screw_height = core_height; // height of screw. shouldn't be more than core_height.

// horizontal tolerance of diameter, mm (usually about double line width)
horizontal_tolerance = 0.80; // [0.18:0.02:1.62]

/* [Top and Bottom] */
// distance between core and outside
base_height = 2; // [0.8:0.1:5.0]    
body_texture = "knurled";// [cylinder, knurled]

lid_height = 8; // [1:15]
lid_texture = "knurled"; // [cylinder, knurled]

knurl_depth = 1.5; // [0.5:0.1:3.0]

/* [Threads] */
thread_reinforcement = 0; // [0:0.1:5]
thread_width = 2.5+thread_reinforcement;  
itr = 3*1;           // inner thread reinforcement thickness
// height of thread pattern
thread_height = 4; // [3:0.5:6]
// angle of thread pattern (higher is more vertical)
thread_angle = 55; // [35:5:75]


/* [Extra] */
cross_section = false; // [true, false]

if(cross_section){
    difference(){    
        doubleWallBoth();
        translate([-100,0,-20])
        cube([200,200,200]);
    }
}
else{
    doubleWallBoth();
}















//      Convenience function for printing together

module doubleWallBoth(){
    displace = core_diameter/2+thread_width*2+horizontal_tolerance*1+knurl_depth+1+itr;
    translate([displace,0,base_height])
    doubleWallContainer();
    translate([-displace,0,core_height+lid_height])
    rotate([180,0,0])
    doubleWallLid();
}



//       Container itself

module doubleWallContainer(){
    difference(){
        union(){
            difference(){
                body();
                outerScrew();
            }
            innerScrew();
        }
        core();
    }
}

module core(){
    translate([0,0,core_height/2])
    cylinder(d=core_diameter, h=core_height, center=true);
}

module body(){
    if(body_texture=="cylinder"){
        union(){
            translate([0,0,core_height/2])
            cylinder(d=core_diameter+thread_width*4+horizontal_tolerance*2+itr,
                h=core_height, center=true);
            
            translate([0,0,-base_height/2])
            cylinder(d=core_diameter+thread_width*4+horizontal_tolerance*2+itr,
                h=base_height, center=true);
        }
    }
    if(body_texture=="knurled"){
        translate([0,0,-base_height])
        knurl(k_cyl_hg=core_height+base_height,
            k_cyl_od=core_diameter+thread_width*4+horizontal_tolerance*2+knurl_depth/2+itr,
            e_smooth=0.5,s_smooth=50,knurl_dp=knurl_depth);
        
    }
     
}

module innerScrew(){
    translate([0,0,core_height-screw_height])
    screw_thread(core_diameter+thread_width+itr,thread_height,thread_angle,screw_height,screw_res,0);
}

module outerScrew(){
    translate([0,0,core_height-screw_height])
    screw_thread(core_diameter+thread_width*3+horizontal_tolerance*2+itr,thread_height,thread_angle,screw_height,screw_res,0);
    
}


//        Lid for container

module doubleWallLid(){
    union(){
        lidTop();
        difference(){
            lidOuter();
            lidInner();
        }
    }
}

module lidTop(){
    if(lid_texture=="cylinder"){
        translate([0,0,core_height+lid_height/2])
        cylinder(d=core_diameter+thread_width*4+horizontal_tolerance*2+itr,
            h=lid_height, center=true);
    }
    if(lid_texture=="knurled"){
        translate([0,0,core_height])
        knurl(k_cyl_hg=lid_height,
            k_cyl_od=core_diameter+thread_width*4+horizontal_tolerance*2+knurl_depth/2+itr,
            e_smooth=0.5,s_smooth=50,knurl_dp=knurl_depth);
    }
}

module lidOuter(){
    translate([0,0,core_height-screw_height])
    screw_thread(core_diameter+thread_width*3+horizontal_tolerance+itr,thread_height,thread_angle,screw_height,screw_res,0);
}

module lidInner(){
    translate([0,0,core_height-screw_height])
    screw_thread(core_diameter+thread_width+horizontal_tolerance+itr,thread_height,thread_angle,screw_height,screw_res,0);
}













/*
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


/*
 *    polyScrewThread.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */

module screw_thread(od,st,lf0,lt,rs,cs)
{
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=floor(pf/rs);
    lfxy=360/sn;
    ttn=round(lt/st)+1;
    zt=st/sn;

    intersection()
    {
        if (cs >= -1)
        {
           # thread_shape(cs,lt,or,ir,sn,st);
        }

        full_thread(ttn,st,sn,zt,lfxy,or,ir);
    }
}

module hex_nut(df,hg,sth,clf,cod,crs)
{

    difference()
    {
        hex_head(hg,df);

        hex_countersink_ends(sth/2,cod,clf,crs,hg);

        screw_thread(cod,sth,clf,hg,crs,-2);
    }
}

module hex_screw(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd)
{
    ntr=od/2-(st/2+0.1)*cos(lf0)/sin(lf0);

    union()
    {
        hex_head(hg,df);

        translate([0,0,hg])
        if ( ntl == 0 )
        {
            cylinder(h=0.01, r=ntr, center=true);
        }
        else
        {
            if ( ntd == -1 )
            {
                cylinder(h=ntl+0.01, r=ntr, $fn=floor(od*PI/rs), center=false);
            }
            else if ( ntd == 0 )
            {
                union()
                {
                    cylinder(h=ntl-st/2,
                             r=od/2, $fn=floor(od*PI/rs), center=false);

                    translate([0,0,ntl-st/2])
                    cylinder(h=st/2,
                             r1=od/2, r2=ntr, 
                             $fn=floor(od*PI/rs), center=false);
                }
            }
            else
            {
                cylinder(h=ntl, r=ntd/2, $fn=ntd*PI/rs, center=false);
            }
        }

        translate([0,0,ntl+hg]) screw_thread(od,st,lf0,lt,rs,cs);
    }
}

module thread_shape(cs,lt,or,ir,sn,st)
{
    if ( cs == 0 )
    {
        cylinder(h=lt, r=or, $fn=sn, center=false);
    }
    else
    {
        union()
        {
            translate([0,0,st/2])
              cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

            if ( cs == -1 || cs == 2 )
            {
                cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }

            translate([0,0,lt-st/2])
            if ( cs == 1 || cs == 2 )
            {
                  cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
        }
    }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir)
{
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
        {
            polyhedron(
                  points=[
                          [0,                  0,                  i*st-st            ],
                          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
                          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                          [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                          [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                          [0,                  0,                  i*st+st            ],
                          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ]
                         ],
               triangles=[
                          [0,1,2],
                          [5,6,3],[5,3,0],[0,3,1],
                          [3,4,1],[1,4,2],
                          [3,6,4],[4,6,7],
                          [0,2,4],[0,4,5],[5,4,7],
                          [5,7,6]
                         ],
               convexity=5);
        }
    }
}

module hex_head(hg,df)
{
    cylinder(h=hg, r=df/2/sin(60), $fn=6, center=false);
}

module hex_countersink_ends(chg,cod,clf,crs,hg)
{
    translate([0,0,-0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2, 
             r2=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             $fn=floor(cod*PI/crs), center=false);

    translate([0,0,hg-chg+0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             r2=cod/2, 
             $fn=floor(cod*PI/crs), center=false);
}

