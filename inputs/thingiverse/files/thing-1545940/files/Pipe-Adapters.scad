/* 'Threaded pipe adapter'  *
  * This script generates threaded pipe adapters using the library script: polyScrewThead.scad (modified/updated version polyScrewThread_r1.scad)
 *http://www.thingiverse.com/thing:8796, CC Public Domain
 */
type= "adapter";//[adapter,nut,bolt,rod,washer]

/* [Bolt and Rod Options] */
//Head type - Hex, Socket Cap, Button Socket Cap or Countersunk Socket Cap (ignored for Rod)
head_type              			        = "hex";//[hex,socket,button,countersunk]
//Drive type - Socket, Phillips, Slot (ignored for Hex head type and Rod)
drive_type              			= "socket";//[socket,phillips,slot]
//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
head_diameter    				= 12;	
//Height of the head (ignored for Rod)
head_height  					= 5;	
//Diameter of drive type (ignored for Hex head and Rod)
drive_diameter					= 5;	
//Width of slot aperture for phillips or slot drive types
slot_width					= 1;
//Depth of slot aperture for slot drive type
slot_depth 					= 2;
//Surface texture (socket head only)
texture                                      	= "exclude";//[include,exclude]
//Outer diameter of the thread
thread_outer_diameter             		= 27;		
//Thread step or Pitch (2mm works well for most applications ref.)
thread_step    					= 2.2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees 				= 45;	
//Length of the threaded section
thread_length  					= 12.5;	
//Countersink in both ends
countersink  					= 2;	
//Length of the non-threaded section
non_thread_length				= 0;	
inner_spacer =9;
//Diameter for the non-threaded section (-1: Same as inner diameter of the thread, 0: Same as outer diameter of the thread, value: The given value)
non_thread_diameter				= (thread_outer_diameter-(inner_spacer*2))/2+(inner_spacer*2);	

/* [Nut Options] */
nut_type= "normal";
//Distance between flats for the hex nut
nut_diameter = 21.8;	
//Height of the nut
nut_height = 12.5;	
//Outer diameter of the bolt thread to match (usually set about 1mm larger than bolt diameter to allow easy fit - adjust to personal preferences) 
nut_thread_outer_diameter     	                = 21.67;		
//Thread step or Pitch
nut_thread_step    				= 1;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
nut_step_shape_degrees 			        = 30;	

/* [Extended Options] */

//Number of facets for hex head type or nut. Default is 6 for standard hex head and nut
facets                                          = 30;
//Number of facets for hole in socket head. Default is 6 for standard hex socket
socket_facets                                   = 30;
//Depth of hole in socket head. Default is 3.5
socket_depth                                   = 3.5;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution    					= 0.5;	
nut_resolution    				= resolution;
spacer_height =5;

if (type=="adapter")
{
	 difference()
    {
		union()
		{
	translate([0,0,thread_length+spacer_height])	hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
	translate([0,0,thread_length])spacer(spacer_height);
	hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,0,non_thread_length,non_thread_diameter);
		}
		cylinder(h=(spacer_height+thread_length+nut_height)*2, r=inner_spacer,center=true);
	}
}
module spacer(spacer_height)
{
	//cylinder(r = 5.5 / 2 / cos(180 / 6) + 0.05, $fn=6)
	cylinder(h=spacer_height, r=nut_diameter/2+5, $fn=6);
}

/* Library included below to allow customizer functionality    
 *    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 * http://www.thingiverse.com/thing:8796
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
			assign( pt = [	[0,                  0,                  i*st-st            ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,0,i*st],
                        [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                        [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                        [0,                  0,                  i*st+st            ]	])
        {
            polyhedron(points=pt,
              		  faces=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4], //changed triangles to faces (to be deprecated)
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
