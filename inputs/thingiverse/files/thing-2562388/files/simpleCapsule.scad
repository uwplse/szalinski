/*
 Customizable simple capsule script
 https://www.thingiverse.com/thing:2562388
 CC Public Domain

 simpleCapsule.scad by Johann517 @ Thingiverse
 https://www.thingiverse.com/johann517/about
*/

// Select part and change settings. Then click CREATE THING for part#1 and part#2
Part=1;// [1: Part#1, 2: Part#2]
// 3D Printer tolerance for screw connection in [mm], 1 mm is a good start
Tolerance=1; // [0.0:0.1:2.0]  
// Length of both parts joined together in [mm]
Length=90;   // [20:200]
// outside diameter of capsule in [mm]
Diameter=30; // [10:100] 
// Wall strength in [mm]
Wallsize=1;  // [0.7:0.1:2]
// Number of faces [Number]
Faces=50;    // [6:50]

/* [Hidden] */

// customizer to internal
show=Part;
o=Length;    // length together in [mm]
d=Diameter;  // diameter in [mm]
s=Wallsize;  // wall thickness in [mm]
g=Tolerance; // printer tolerance in [mm]
n=Faces;     // faces - resolution

// internals
j=d/4; // auto
w=7;   // screw height
h=o-d-1-j/2; 
cut=0; // show inside

$fn=50;

difference(){
union(){
// top
if (show==1||show==0)
difference(){
 union(){
 hull(){
  cylinder(d=d,h=w);
  difference() {
   translate([0,0,h/2])
    sphere(d=d,$fn=n);
   translate([0,0,h/2-d])
    cube([d,d,2*d],center=true);
  }
  translate([0,0,h/2+d/2])
   rotate([90,0,0])
    cylinder(d=j*2,h=j,center=true);
  }  
 }
 translate([0,0,-0.1])
  screw_thread(d-s-g,w/2,55,w,PI/2,2);
 hull(){
  difference(){
   translate([0,0,h/2-1.5])
    sphere(d=d-2*s,$fn=n);
   translate([0,0,-d/2+w])   
    cube([d,d,d],center=true);
  }
  translate([0,0,w-.1])
   cylinder(d=d-2*s-g,h=.1);
 }
 translate([0,0,h/2+d/2+j/4])
  rotate([90,0,0])
   cylinder(d=j/1.6,h=d,center=true);
 translate([0,0,-0.5])
  cylinder(d1=d-s,d2=d-3*s,h=1);
 translate([0,0,-d])
  cube([d,d,2*d],center=true); 
}

// bottom
if (show==2||show==0)
translate([0,0,(w-1)/2*show])
rotate([90*show,0,270])
difference(){
 union(){
  hull(){
   translate([0,0,-1])
    cylinder(d=d,h=1);    
   difference(){    
    translate([0,0,-h/2])  
     sphere(d=d,$fn=n);
    translate([0,0,d/2])
     cube([d,d,d],center=true);
   }
  }
  cylinder(d1=d,d2=d-s-g,h=.5);  
  translate([0,0,-1])
   screw_thread(d-s-2*g,w/2,55,w,PI/2,2);
 }
 hull(){
  difference() {   
   translate([0,0,-h/2+s])    
    sphere(d=d-2*s,$fn=n);
   translate([0,0,d/2-2])
    cube([d,d,d],center=true);      
  }
  translate([0,0,-2.5])
   cylinder(d=d-w/2-2*s-2*g,h=1.5);
 }
 translate([0,0,-2])
  cylinder(d=d-w/2-2*s-2*g,h=w+2);
}
}
if(cut==1)
translate([0,-o,-o])
 cube([2*o,2*o,2*o]);
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
 */
module screw_thread(od,st,lf0,lt,rs,cs)
{
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=2*floor(pf/rs);
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
}
