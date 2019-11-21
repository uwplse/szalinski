// clamp customizable akaJes 2016 (c)

//include <polyScrewThread.h>
//include <knurledFinishLib.h>
/*[clamp]*/
//
clamp_length=60;
clamp_height=36;
clamp_width=40;
clamp_thickness=10;
/*[bolt&press]*/
knob_length=25;
knob_diameter=20;
screw_diameter=14;
press_diameter=20;
/*[visibility]*/
show_bolt=0; //[0:No,1:Yes]
show_press=0; //[0:No,1:Yes]
show_clamp=1; //[0:No,1:Yes]
//don't print assembled!!! :)
show_assembled=0; //[0:No,1:Yes]
positions=12;

/*[hidden]*/
screw_length=clamp_length*0.70-8;
rounding=2;
length=clamp_length-rounding*2;
height=clamp_height-rounding*2;
width=clamp_width-rounding*2;
thickness=clamp_thickness-rounding*2;
hole_shift=width-15;
radius=1.7;//corners;
diameter_ball=8;
shrink_adjust=1.04;


if (show_assembled)rotate([0,0,180]){
  base();
  translate([-knob_length-radius*thickness-rounding-10,hole_shift,clamp_height/2]){
    rotate([0,90,0])bolt();
    translate([knob_length+screw_length+5+8,0,0])rotate([0,-90,0])press();
  }
}else{
  if(show_clamp)
    base();
  if(show_press)
    translate([30,width+20,0])press();
  if(show_bolt)
    translate([0,width+20,0])bolt();
}

module corner(tr){
  intersection(){
    difference(){
      cylinder(r=tr,h=height,$fn=64);
      translate([0,0,-.1])
        cylinder(r=thickness*(radius-1),h=height+.2,$fn=32);
    }
    translate([-tr,-tr,0])cube([tr,tr,height]); 
  }
}

module rod_mount() {
    difference() {
        union() { 
            cylinder( d=33*shrink_adjust, h=46*shrink_adjust );
        }
        union() {
            cylinder( d=23*shrink_adjust, h=46*shrink_adjust );
            translate([0,0,36*shrink_adjust]) cylinder( d=26*shrink_adjust, h=10*shrink_adjust );
        }
    }
    
    for( i = [ 0: 360/positions: 360 ] )
    rotate( [0,0,i+15 ] ) translate([11.5*shrink_adjust,-1.25,36]) cube( [ 2.5, 2.5, 10] );

    translate([10*shrink_adjust,-1.5,19.5]) cube( [ 2, 3, 5.5] );
}


module base(){
  difference() {
  union() {
      translate([0,0,rounding])
        difference(){
        minkowski(){
          assign(tr=thickness*radius,ti=thickness*(radius-1))union(){
            corner(tr);
            translate([-tr,0,0])cube([thickness,width,height]);
            translate([0,-tr,0])cube([length-ti*2,thickness,height]);
            translate([length-ti*2,0,0])rotate([0,0,90])corner(tr);
            translate([length-ti,0,0])cube([thickness,width,height]);
          }
          sphere(r=rounding,$fn=16);
        }
        translate([0,hole_shift,height/2])rotate([0,-90,0])screw_thread(screw_diameter+0.6,4,55,20,PI/2,2);
    }
  
    translate( [length-15,width-10,2] ) cube([15,10,30]);
  }
  translate( [(clamp_length-clamp_thickness)/2,0, clamp_height/2]) rotate([90,0,0]) cylinder( d=30, h=clamp_thickness*2 );
  }
  translate( [(clamp_length-clamp_thickness)/2,0, clamp_height/2]) rotate([90,0,0]) rod_mount();
}

module bolt(){
    knurled_cyl(knob_length, knob_diameter, 2.5, 2.5, 1, 2, 10);
    translate([0,0,knob_length])screw_thread(screw_diameter,4,55,screw_length,PI/2,2);
    translate([0,0,knob_length+screw_length])cylinder(h=6,d=6,$fn=30);
    translate([0,0,knob_length+screw_length+5])sphere(d=diameter_ball,$fn=32);
}
module rounded(h=5,d=20,r=2){
  translate([0,0,r])
    minkowski(){
      cylinder(d=d-r*2,h=h-r*2);
      sphere(r=r);
    }
}
module press(){
    assign($fn=32)
    difference(){
      union(){
        rounded(h=5,d=press_diameter,r=1);
        rounded(h=10,d=14,r=1);
        difference() {
            translate([0,15,5]) rotate([90,0,0]) cylinder(d=22,h=30);
            translate([-11,16,5]) rotate([90,0,0]) cube([22,22,32]);
        }
        }
      translate([0,0,10-2])sphere(d=diameter_ball+.6);
      for (i=[0,120,240])
        translate([0,0,6.5])rotate([90,0,90+i])hull(){
          cylinder(d=3,h=10);
          translate([0,5,0])cylinder(d=3,h=10);
        }
    }
}






/*
 * knurledFinishLib.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:9095
 *
 * Usage:
 *
 *    knurled_cyl( Knurled cylinder height,
 *                 Knurled cylinder outer diameter,
 *                 Knurl polyhedron width,
 *                 Knurl polyhedron height,
 *                 Knurl polyhedron depth,
 *                 Cylinder ends smoothed height,
 *                 Knurled surface smoothing amount );
 */
module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
{
    cord=(cod+cdp+cdp*smt/100)/2;
    cird=cord-cdp;
    cfn=round(2*cird*PI/cwd);
    clf=360/cfn;
    crn=ceil(chg/csh);

    intersection()
    {
        shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

        translate([0,0,-(crn*csh-chg)/2])
          knurled_finish(cord, cird, clf, csh, cfn, crn);
    }
}

module shape(hsh, ird, ord, fn4, hg)
{
        union()
        {
            cylinder(h=hsh, r1=ird, r2=ord, $fn=fn4, center=false);

            translate([0,0,hsh-0.002])
              cylinder(h=hg-2*hsh+0.004, r=ord, $fn=fn4, center=false);

            translate([0,0,hg-hsh])
              cylinder(h=hsh, r1=ord, r2=ird, $fn=fn4, center=false);
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

module hex_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r=rd0, $fn=6, center=false);

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




