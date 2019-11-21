// height of the container's interior space
h_int = 50; // [20:150]

// max knurled grip stripe height
max_h_knurled=15; // [0:150]

// additional ring for lid protection
first_ring = 1; // [1:Yes,0:No]

// additional ring for lid protection
second_ring = 1; // [1:Yes,0:No]

/* [Hidden] */


PI = 3.14;

t=0.75;


d_out_a = 24.4;
d_out_b = 27.4;

d_int = d_out_a - 2*t; //21.9;

d_out_c = 24;
d_out_d = 28;
d_out_e = 30;

translate([0,0,h_int+1.5]) rotate([0,180,0]) difference(){
union(){
    intersection(){
        translate([0,0,0.5]) screw_thread(d_out_b+2.5,2.5,15,7,PI/2,2);
        translate([0,0,-1]) cylinder(d=d_out_b, h = 10+2, $fn=128);
    }

    translate([0,0,0]) cylinder(d=d_out_a, h = h_int+1.5, $fn=128);

    if (second_ring == 1) {

    translate([0,0,15]){
        translate([0,0,0]) cylinder(d=d_out_e, h = 1, $fn=128);
        translate([0,0,1]) cylinder(d1=d_out_e,d2=d_out_a, h = 1.5, $fn=128);
    }
}

if (first_ring == 1) {
    translate([0,0,10]){
        translate([0,0,0]) cylinder(d=d_out_d, h = 1, $fn=128);
        translate([0,0,1]) cylinder(d1=d_out_d,d2=d_out_a, h = 1.0, $fn=128);
    }
}
    
    translate([0,0,0]) cylinder(d=d_out_c+1, h = 1, $fn=128);
    translate([0,0,1]) cylinder(d2=d_out_a,d1=d_out_c+1, h = .5, $fn=128);
    
    if (max_h_knurled > 0) {
    translate([0,0,max(h_int+1.5-max_h_knurled,17)]) knurled_cyl(min(max_h_knurled,h_int+1.5-17),
                 d_out_a+2,
                 3,
                 4,
                 1,
                 2,
                 0 );
        
    }
    
    translate([0,0,max(h_int+1.5-max_h_knurled,17)-1]) cylinder(d1=d_out_a, d2=d_out_a+1,h=1,$fn=100);

}



union(){
translate([0,0,-1]) cylinder(d=d_int, h = h_int-1+1, $fn=128);
translate([0,0,h_int-1]) cylinder(d2=d_int-2,d1=d_int, h = 1, $fn=128);
}
}



/*
 *    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain

 * adapted for newer versions of OpenScad by amosienko

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
        for(j=[0:sn-1]) {
			 pt = [	[0,                  0,                  i*st-st            ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,0,i*st],
                        [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                        [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                        [0,                  0,                  i*st+st            ]	];
        
            polyhedron(points=pt,
              		  faces=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4],
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

 * adapted for newer versions of OpenScad by amosienko

*/

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
    {h0=sh*j; h1=sh*(j+1/2); h2=sh*(j+1);
    
        for(i=[0:fn-1])
        {lf0=lf*i; lf1=lf*(i+1/2); lf2=lf*(i+1);
        
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


