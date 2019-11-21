/* 'Nut Job' nut, bolt, washer and threaded rod factory by Mike Thompson 1/12/2013, Thingiverse: mike_linus
 *
 * Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.
 * Further information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB
 *
 * v2 8/12/2013 - added socket head types
 * v3 2/11/2014 - adjusted wing nut algorithm for better behaviour with unusual nut sizes and added ISO262 metric references
 * v4 31/12/2014 - added optional texture to socket heads, added ability to change the number of facets for a hex head
 * and adjusted wingnut base level on certain nut sizes
 * v5 11/1/2015 - added phillips and slot drive types and improved texture handling 
 * v6 21/2/2015 - added wing ratio to wingnuts 
 * v7 6/3/2016 - added extended options to control number of facets on nuts, square sockets (or any number of facets) and socket depth control
 * v8 1/1/2017 - modified library code to remove dependence on deprecated 'assign' statement
 * 
 * This script generates nuts, bolts, washers and threaded rod using the library 
 * script: polyScrewThead.scad (modified/updated version polyScrewThread_r1.scad)
 * http://www.thingiverse.com/thing:8796, CC Public Domain
 *
 * Defaults are for a 8mm diameter bolts, rod, matching nuts and wing nuts that work well together
 * without cleanup or modification. Some default parameters such as the nut outer diameter are deliberately
 * altered to produce a snug fit that can still be hand tightened. This may need to be altered
 * depending on individual printer variances, slicing tools, filament etc. Suggest printing a matching
 * bolt and nut and adjusting as necessary.  Note: slow print speeds, low temperatures and solid
 * fill are recommended for best results.
 */

/* [Component Type] */

type						    = "bolt";//[nut,bolt,rod,washer]

/* [Bolt and Rod Options] */

//Head type - Hex, Socket Cap, Button Socket Cap or Countersunk Socket Cap (ignored for Rod)
head_type              			= "hex";//[hex,socket,button,countersunk]
//Drive type - Socket, Phillips, Slot (ignored for Hex head type and Rod)
drive_type              		= "socket";//[socket,phillips,slot]
//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
head_diameter    				= 12;	
//Height of the head (ignored for Rod)
head_height  					= 5;	
//Diameter of drive type (ignored for Hex head and Rod)
drive_diameter					= 5;	
//Width of slot aperture for phillips or slot drive types
slot_width					    = 1;
//Depth of slot aperture for slot drive type
slot_depth 					    = 2;
//Surface texture (socket head only)
texture                         = "exclude";//[include,exclude]
//Outer diameter of the thread
thread_outer_diameter           = 8;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step    					= 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees 				= 45;	
//Length of the threaded section
thread_length  					= 25;	
//Countersink in both ends
countersink  					= 2;	
//Length of the non-threaded section
non_thread_length				= 0;	
//Diameter for the non-threaded section (-1: Same as inner diameter of the thread, 0: Same as outer diameter of the thread, value: The given value)
non_thread_diameter				= 0;	

/* [Nut Options] */

//Type: Normal or WingNut
nut_type	                    = "normal";//[normal,wingnut]
//Distance between flats for the hex nut
nut_diameter    				= 12;	
//Height of the nut
nut_height	  				    = 6;	
//Outer diameter of the bolt thread to match (usually set about 1mm larger than bolt diameter to allow easy fit - adjust to personal preferences) 
nut_thread_outer_diameter     	= 9;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
nut_thread_step    				= 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
nut_step_shape_degrees 			= 45;	
//Wing radius ratio.  The proportional radius of the wing on the wing nut compared to the nut height value (default = 1)
wing_ratio                      = 1;
wing_radius=wing_ratio * nut_height;

/* [Washer Options] */

//Inner Diameter (suggest making diameter slightly larger than bolt diameter)
inner_diameter					= 8;
//Outer Diameter
outer_diameter					= 14;
//Thickness
thickness					    = 2;

/* [Extended Options] */

//Number of facets for hex head type or nut. Default is 6 for standard hex head and nut
facets                          = 6;
//Number of facets for hole in socket head. Default is 6 for standard hex socket
socket_facets                   = 6;
//Depth of hole in socket head. Default is 3.5
socket_depth                    = 3.5;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution    					= 0.5;	
nut_resolution    				= resolution;

//Hex Bolt
if (type=="bolt" && head_type=="hex")
{
	hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,head_height,non_thread_length,non_thread_diameter);
}

//Rod
if (type=="rod")
{
	hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,0,non_thread_length,non_thread_diameter);
}

//Hex Nut (normally slightly larger outer diameter to fit on bolt correctly)
if (type=="nut" && nut_type=="normal")
{
	hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
}

//Wing Nut variation of hex nut. Cylinders added to each side of nut for easy turning - ideal for quick release applications
if (type=="nut" && nut_type=="wingnut")
{
	rotate([0,0,30])hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution); //nut	
	translate([(nut_diameter/2)+wing_radius-1,1.5,wing_radius/2+1])rotate([90,0,0])wing(); //attach wing
	mirror(1,0,0)translate([(nut_diameter/2)+wing_radius-1,1.5,wing_radius/2+1])rotate([90,0,0])wing(); //attach wing
}

module wing()
{
	difference()
	{
		cylinder(r=wing_radius,h=3,$fn=64); //cylinder
		union()
		{
			translate([-wing_radius,-wing_radius-1,-0.5])cube([wing_radius*2,wing_radius/2,wing_radius*2]); //remove overhang so flush with base of nut		
			rotate([0,0,90])translate([-wing_radius,wing_radius-1,-0.5])cube([wing_radius*2,wing_radius/2,wing_radius*2]); //remove overhangs so flush with side of nut		
		}
	}
}

//Washer
if (type=="washer")
{
	difference()
	{
		cylinder(r=outer_diameter/2,h=thickness,$fn=100);
		translate([0,0,-0.1])cylinder(r=inner_diameter/2,h=thickness+0.2,$fn=100);
	}
}

//Socket Head Bolt
if (type=="bolt" && head_type!="hex")
{
	socket_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,head_height,non_thread_length,non_thread_diameter);
}

module phillips_base()
{
	linear_extrude(slot_width)polygon(points=[[0,0],[(drive_diameter-slot_width)/2,9/5*(drive_diameter-slot_width)/2],[(drive_diameter+slot_width)/2,9/5*(drive_diameter-slot_width)/2],[drive_diameter,0]]);
	translate([(drive_diameter-slot_width)/2,0,(drive_diameter+slot_width)/2])rotate([0,90,0])linear_extrude(slot_width)polygon(points=[[0,0],[(drive_diameter-slot_width)/2,9/5*(drive_diameter-slot_width)/2],[(drive_diameter+slot_width)/2,9/5*(drive_diameter-slot_width)/2],[drive_diameter,0]]);
}

module phillips_fillet()
{
	union()
	{
		translate([-(drive_diameter-slot_width)/2-(slot_width/2),slot_width/2,0])rotate([90,0,0])phillips_base();
		translate([0,0,9/5*(drive_diameter-slot_width)/2])union()
		{
			inner_curve();
			rotate([0,0,90])inner_curve();
			rotate([0,0,180])inner_curve();
			rotate([0,0,270])inner_curve();
		}
	}
}

module inner_curve()
{
	translate([slot_width/2,-slot_width/2,0])rotate([0,90,0])linear_fillet(9/5*(drive_diameter-slot_width)/2,drive_diameter/10);
}

//basic 2d profile used for fillet shape
module profile(radius)
{
  difference()
  {
    square(radius);
    circle(r=radius);
  }
}

//linear fillet for use along straight edges
module linear_fillet(length,profile_radius)
{
	translate([0,-profile_radius,profile_radius])rotate([0,90,0])linear_extrude(height=length,convexity=10)profile(profile_radius);
}

module phillips_drive()
{
	intersection()
	{
		phillips_fillet();
		cylinder(9/5*(drive_diameter-slot_width)/2,drive_diameter/2+(slot_width/2),slot_width/2);
	}
}

module socket_screw(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd)
{
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);
	$fn=60;

	difference()
	{
    		union()
    		{
        		if (head_type=="socket")
				{
					socket_head(hg,df);
				}
			
        		if (head_type=="button")
				{
					button_head(hg,df);				
				}

        		if (head_type=="countersunk")
				{
					countersunk_head(hg,df);				
				}

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
                    		cylinder(h=ntl-st/2,r=od/2, $fn=floor(od*PI/rs), center=false);
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
		//create opening for specific drive type
		if (drive_type=="socket")
		{
			cylinder(r=drive_diameter/2,h=socket_depth,$fn=socket_facets); //socket
			#translate([0,0,socket_depth])cylinder(r1=drive_diameter/2,r2=0,h=drive_diameter/3,$fn=socket_facets); //socket tapers at base to allow printing without bridging and improve socket grip
		}
		else
		{
			if (drive_type=="phillips")
			{
				translate([0,0,-0.001])phillips_drive();
			}
			else //slot
			{
				translate([-(drive_diameter)/2,slot_width/2,-0.001])rotate([90,0,0])cube([drive_diameter,slot_depth,slot_width]);
			}	
		}
	}
}

module socket_head(hg,df)
{
	texture_points=2*PI*(head_diameter/2);
	texture_offset=head_diameter/18;
	texture_radius=head_diameter/24;

	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   	cylinder(h=hg, r=rd0, $fn=60, center=false);
		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}

	if (texture=="include") //add texture to socket head. Adjust texture density and size using texture variables above 
	{
		for (i= [1:texture_points])
		{
			translate([cos(360/texture_points*i)*(head_diameter/2+texture_offset), sin(360/texture_points*i)*(head_diameter/2+texture_offset), 1 ])
			rotate([0,0,360/texture_points*i])cylinder(r=texture_radius,h=head_height*0.6,$fn=3);
		}
	}

}

module button_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   	cylinder(h=hg, r1=drive_diameter/2 + 1, r2=rd0, $fn=60, center=false);
		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}

module countersunk_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r1=rd0, r2=thread_outer_diameter/2-0.5, $fn=60, center=false);

		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
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