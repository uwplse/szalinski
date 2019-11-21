// Show parts
part = 0; // [0:All opened, 1:Base, 2:Lid, 3:Closed]

// Inner diameter
inner_diameter = 25;

// Base height
height = 13;

// Lid height
lid_height=3;

/* [Hidden]  */

// Wall thickness
wt = 2;

$fn=60;
thread_length = 6;
resolution=2;
countersink=1;
thread_step=3;
step_shape_degrees=60;
facets = 6;

outer_diameter = inner_diameter + thread_step + 1.3;
thread_outer_diameter = inner_diameter + thread_step;


print_part();

module print_part() {
    if (part == 0) {
        base();
        translate([outer_diameter+35, 0, 0]) lid();
    }
    else if (part == 1) {
        base();
    }
    else if (part == 2) {
        lid();
    }
    else if (part == 3) {
        base();
        translate([0, 0, height+lid_height+0.1]) rotate([180, 0, 0])  lid();
    }
    else {
        base();
        translate([outer_diameter+5, 0, 0]) lid();
    }
}

module lid() {
    ns = 24;
    translate([0, 0, thread_length-1+lid_height]) rotate([180, 0, 0])
    difference() {
        union() {
            translate([0, 0, thread_length-1]) { cylinder(d=outer_diameter, h=lid_height);
            for (i = [0 : ns]) {
                rotate([0, 0, i*360/ns]) translate([0, outer_diameter/2-0.5, 0]) cylinder(d=2, h=lid_height, $fn=60);
            }
            }
            hex_screw(thread_outer_diameter-0.3, thread_step, step_shape_degrees, thread_length-1, resolution, countersink, 0, 0, 0, 0);
        }
     translate([0, 0, -0.1]) cylinder(d=thread_outer_diameter-thread_step-0.5, h=thread_length);
    }
}

module base() {
    
    difference() {
        cylinder (d=outer_diameter, h=height);
        translate([0, 0, wt]) cylinder (d=inner_diameter, h=height-thread_length);
        translate([0, 0, height-thread_length]) cylinder (d=inner_diameter+thread_step, h=height-thread_length);
    }
    translate([0, 0, height-thread_length]) hex_nut(outer_diameter,thread_length,thread_step,step_shape_degrees,thread_outer_diameter,resolution);
}

module base2() {
    difference() {
        cylinder (d=outer_diameter, h = height);
        translate([0, 0, wt]) cylinder (d=outer_diameter-2*wt, h = height-thread_length-wt);
        translate([0, 0, height-thread_length-0.01]) cylinder (d=outer_diameter-2*wt, h = height);
            
    }
    translate([0, 0, height-thread_length]) hex_nut(outer_diameter-2*wt,thread_length,thread_step,step_shape_degrees,thread_outer_diameter,resolution);
}


/* Library included below to allow customizer functionality    
 *   
 * polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * Modified by mike_mattala @ Thingiverse 1/1/2017 to remove deprecated assign
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
    ttn=round(lt/st+1);
    zt=st/sn;

    intersection()
    {
        if (cs >= -1)
        {
           thread_shape(cs,lt,or,ir,sn,st);
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
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);

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

module hex_screw_0(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd)
{
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);

    union()
    {
        hex_head_0(hg,df);

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
  if(ir >= 0.2)
  {
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
        {
			pt = [[0,0,i*st-st],
                 [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                 [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
				 [0,0,i*st],
                 [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                 [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                 [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                 [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                 [0,0,i*st+st]];
               
            polyhedron(points=pt,faces=[[1,0,3],[1,3,6],[6,3,8],[1,6,4], //changed triangles to faces (to be deprecated)
										[0,1,2],[1,4,2],[2,4,5],[5,4,6],[5,6,7],[7,6,8],
										[7,8,3],[0,2,3],[3,2,7],[7,2,5]	]);
        }
    }
  }
  else
  {
    echo("Step Degrees too agresive, the thread will not be made!!");
    echo("Try to increase de value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}

module hex_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r=rd0, $fn=facets, center=false);

		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x1,y2],[x0,y2] ]);
	}
}

module hex_head_0(hg,df)
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