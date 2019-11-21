//Customizable t-nut v1 by Eric Monkman
//January 2014

// Several modules from aubenc's threaded fastener library (polyScrewThread_r1.scad at http://www.thingiverse.com/thing:8796) are used to generate the threaded hole.
// CC Public Domain

//CUSTOMIZER VARIABLES

// Total length of t-nut.
l = 0.625;

// Total height of t-nut.
h = 0.5;

// Total width of t-nut.
w = 0.5;

// Height of the narrow part of t-nut.
hm = 0.25;

// Width of the narrow part of t-nut.
wm = 0.25;

// Major diameter of thread.
thread_d = 0.19;

// Pitch of thread in threads-per-inch
thread_p = 32;

// Set a tolerance value to account for finite thickness of plastic strands
tolerance = 0.008;

//CUSTOMIZER VARIABLES END

// Rescale the t-nut so that output is in mm for 3D printing
scale([25.4,25.4,25.4]) tnut(h-tolerance,w-tolerance,l-tolerance,hm,wm-tolerance,thread_d+tolerance,thread_p);


module tnut(h,w,l,hm,wm,thread_d,thread_p)
{
////////////////////////////
// All input in inches, pitch in threads-per-inch (sorry rest of the world...).
// h, w, l: the total height, width and length of the t-nut.
// hm and wm: the dimensions  of the narrow part of the t-nut.
// thread_d, thread_p: the major diameter and pitch of the threaded hole.
////////////////////////////
$fn = 20;

	difference(){
		// Draw basic t-nut shape
		translate([-h/2,-w/2,-l/2]) cube([h,w,l]);
		translate([-h/2,wm/2,-l/2]) cube([hm+0.001,((w-wm)/2)+0.001,l+0.001]);
		translate([-h/2,-w/2,-l/2]) cube([hm+0.001,((w-wm)/2)+0.001,l+0.001]);

		//Chamfer the hole
		translate([-h/2*1.001,0,0]) rotate([0,90,0]) cylinder(h=thread_d*1.2/2,r1=thread_d*1.2/2,r2=0);

		//Thread the hole using aubenc's Library.
		translate([-h/2*1.001,0,0]) rotate([0,90,0]) screw_thread(thread_d,1/thread_p,60,h*1.1,PI/100,1);

	}
}



///////////////////////////////
// Start of aubenc's library //
///////////////////////////////
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
  if(ir >= 0.01)
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
              		  triangles=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4],
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

