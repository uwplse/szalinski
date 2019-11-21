/* Air Vent - Adjustable by Thomas Heiser
 *
 * 2019-10-05 (https://www.thingiverse.com/thing:3896874)
 * 
 * Thingiverse: thomasheiser
 * 
 * V1.2
 *
 * Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)
 * Further information is available here - https://creativecommons.org/licenses/by-nc-sa/3.0/
*/

/* [General] */

type = "socket";//[socket,top]

//Diameter for the plate (Top & Socket)
plate_diameter		    		= 160;

// Height for the plate (Top & Socket)
plate_height				    = 1.8;	

/* [Top] */

//Length of the threaded section
thread_length  					= 30;	


//Outer diameter of the thread
thread_outer_diameter           = 8;

/* [Socket] */

//Diameter for the pipe
pipe_diameter				    = 114;

//Height for the pipe
pipe_height 				    = 40;

// With of teh pipe border
pipe_border				        = 1;

//Height of the nut
nut_height	  				    = 20;	

//Outer diameter of the bolt thread to match (usually set about 1mm larger than bolt diameter to allow easy fit - adjust to personal preferences) 
nut_thread_outer_diameter     	= 9;

//Distance between flats for the hex nut
nut_diameter    				= 12;	

// Height for the struts
strut_height                   = 5;

// Width for the struts
strut_width                     = 5;

// Ring diameter of the struts
strut_ring_diameter             = 20;


/* [Hidden] */

strut_length = ((pipe_diameter/2)-pipe_border)-(nut_diameter/2)-((strut_ring_diameter-nut_diameter)/2/2);
strut_pos = (nut_diameter/2)+((strut_ring_diameter-nut_diameter)/2/2);

if(type=="socket")
{
    // struts
    translate([-(strut_width/2),strut_pos,0])cube([strut_width,strut_length,strut_height],false);
    translate([-(strut_width/2),-(strut_pos+strut_length),0])cube([strut_width,strut_length,strut_height],false);
    translate([strut_pos,-(strut_width/2),0])cube([strut_length,strut_width,strut_height],false);
    translate([-(strut_pos+strut_length),-(strut_width/2),0])cube([strut_length,strut_width,strut_height],false);

    // ring around the nut
    difference() {
         cylinder( $fn = 100, strut_height, strut_ring_diameter/2, strut_ring_diameter/2,false);
         cylinder( $fn = 100, strut_height, nut_diameter/2, nut_diameter/2,false);
            
    }   

    // Pipe
    difference() {
        union()
        {
            cylinder($fn = 100, plate_height, plate_diameter/2, plate_diameter/2,false);
            cylinder($fn = 100, pipe_height, pipe_diameter/2, pipe_diameter/2,false);
            
        }
        cylinder( $fn = 100, 100, pipe_diameter/2-pipe_border, pipe_diameter/2-pipe_border,false);
    }
 
}



/*
 * Library included below:
 *
 * 'Nut Job' nut, bolt, washer and threaded rod factory by Mike Thompson 1/12/2013, Thingiverse: mike_linus
 */


//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
head_diameter    				= 12;	
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step    					= 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees 				= 45;	
//Countersink in both ends
countersink  					= 2;	



//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
nut_thread_step    				= 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
nut_step_shape_degrees 			= 45;	


//Number of facets for hex head type or nut. Default is 6 for standard hex head and nut
facets                          = 100;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution    					= 0.5;	
nut_resolution    				= resolution;

//Top
if (type=="top")
{
	hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,0,plate_height,plate_diameter);
}

//Hex Nut (normally slightly larger outer diameter to fit on bolt correctly)
if (type=="socket")
{
	hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
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
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
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