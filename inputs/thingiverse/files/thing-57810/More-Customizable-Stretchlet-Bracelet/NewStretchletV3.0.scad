// stretchy bracelet from emmett
// updated by Bob Hamlet
// v1.1 3-7-13 User input lockdown. Solid option.
// V1.2 3-8-13 Solid bug fix.
// V2.0 3-16-13 Added hollow and knurled options, more tweaking for vert and horiz bands.
// V3.0 3-19-13 Added clasp, fixed hollow knurled option, thicker bracelets, optimized for customizer

//////////////////////////////User Input Section///////////////////////////

/* [Global] */

//Select bracelet Type
Type=1;//[1:Banded-Horizontal(1),2:Banded-Vertical(2),3:Corded(3),4:Smooth(4),5:Knurled(5)]

/* [Size] */

//Input your wrist or ankle circumference loosely in mm (1" = 25.4mm)
Circumference=200;//[100:300]

//How wide should the bracelet be? (13mm = approx 1/2")
Width=13;//[3:130]
//user friendly input (used throughout)
w=Width*1;//program friendly variable (used throughout)

//How thick should the bracelet be? (1/8"-1")
Thickness=8;//[3:25]
//h=Thickness*1;

/* [Options] */

//Choose if you want to have a non stretchy bracelet.  (You will probably need to increase the circumference above.)
Stretchy_vs_Solid=1;//[0:Solid(0),1:Stretchy(1)]

//How many stretchy bends should your bracelet have? (More makes a smoother inner circle, and makes it more flexible.)
Bends=25;//[10:50]

//Set the desired output.  Puck for a "hockey puck", Hollow for easier slicing setup.
Hollow_vs_Hockey_Puck=1;//[0:Hollow(0),1:Puck(1)]

//Do you want a bracelet that clasps around your wrist, or stretches over your hand?
Clasp=0;//[0:Stretch Over(0),1:Clasp Around(1)(Only works for hollow bracelet)]
m=Bends+Clasp;

//Input your extruder nozzle diameter.  (In tenths, so 4 = 0.4)  This also controls the path thickness for hollow bracelets, so you can make one that is 2 or more shells!
Nozzle=4;//[1:20]
t=Nozzle*0.1;

/* [Banded] */

//How many bands would be a lovely accent on your banded bracelet?
Bands=3;//[2,3,4,5]

/* [Corded] */

//How many angled cords will you need to make the perfect corded bracelet?
Cords=25;//[15:40]
n=Cords*1;

Cord_Direction=-1;//[1:CCW(1),-1:CW(-1)]
dir=Cord_Direction*1;

/* [Knurled] */

//Input the smoothness percentage for your knurled bracelet.
Knurl_Smoothness=40;//[0:100]

//How many knurled diamonds across the width of the bracelet?
Knurl_Width=4;//[2:15]

//Squish the knurls vertically or horizontally.
Knurl_Skew=1;//[.5:1/2,.75:3/4,1:Square,1.5:1.5x,2:2x]
ks=Knurl_Skew*1;

/* [Lettering] */

//Future option will allow you to have raised letters, or dual extrusion letters with input here.
Lettering="Sample";

// preview[view:east, tilt:top diagonal]

/////////////////////////////////Program Variables////////////////////////////

pi=3.14159*1; // Pi defined
h=Thickness*Stretchy_vs_Solid+t;//This sets the thickness of stretchy parts to zero for a solid bracelet.
ri=(Circumference/m)*(Clasp+m)/(2*pi); //inside radius
ro=ri+h; //outside radius
r1=pi*ro/n; //outside radius cord segment width
r2=(pi*ro/m-t)/Bands; //outside radius vert band radius
rr=r1-2*t; //cord overlap by 2*nozzle width
kw=w/Knurl_Width;//knurl width
dkn=2*(ro-(0.25*kw));//knurled diameter
knscale=(dkn-2*t)/dkn;//hollow knurled diameter scale
kl=dkn/round(dkn/kw/ks);//knurl length
kd=.5*kw;//knurl depth
mult=m*Bands; //number of vertical bands
hsc=w/(Bands*3); //scale of horizontal bands
a=2*pi*ri/m-t;//slice of inside circumference minus tolerance

/////////////////////////////////Main call and modules////////////////////////

if (Hollow_vs_Hockey_Puck==1){
solid(); // use to make a solid stl and print outsides by slicer settings
}
if (Hollow_vs_Hockey_Puck==0){
hollow(); // use to make a hollow shape to print normally
}

module solid(){
difference(){
		if (Type==1)
     {
		hbanded(ro,w);// horizontal bands
     }
		if (Type==2)
     {
		vbanded(ro,r2,w);// vertical bands
		}
		if (Type==3)
     {
		corded(r1,w);// original angled cording
		}
		if (Type==4)
		{
		cylinder(r=ro,h=w,$fn=m);// flat
		}
		if (Type==5)
		{
		knurled_cyl(w,dkn,kl,kw,kd,kd,Knurl_Smoothness);
		}
		cuts();
}
}

module hollow(){
if (Type==1)
	{
	difference(){
		hbanded(ro,w);
		difference(){
			translate([0,0,-0.01])hbanded(ro=ro-t,w=w+0.02);
			hollowcuts();
		}
		cuts();
		}
	}
if (Type==2)
	{
	difference(){
		vbanded(ro,r2,w);
		difference(){
			translate([0,0,-0.01])vbanded(ro=ro-t,r2=(pi*(ro-t)/m-t)/Bands,w=w+0.02);
			hollowcuts();
     	}
		cuts();
		}
	}
if (Type==3)
   {
	difference(){
      corded(r1,w);
     	difference(){
          translate([0,0,-0.01])corded(r1=r1-t,w=w+0.02);
          hollowcuts();
     	}
		cuts();
		}
	}
if (Type==4)
	{
	difference(){
		cylinder(r=ro,h=w,$fn=m);
		difference(){
			translate([0,0,-0.01])cylinder(r=ro-t,h=w+0.02,$fn=m);
			hollowcuts();
		}
		cuts();
		}
	}
if (Type==5)
	{
	render()
	difference(){
		knurled_cyl(w,dkn,kl,kw,kd,kd,Knurl_Smoothness);
		difference(){
			translate([0,0,-0.01])
			scale([knscale,knscale,(w+0.02)/w])knurled_cyl(w,dkn,kl,kw,kd,kd,Knurl_Smoothness);
			hollowcuts();
		}
		cuts();
		}
	}
}

module cuts(){
	union(){
		if (Clasp==1){
		rotate([0,0,360/m])translate([0,0,-0.03])linear_extrude(height=w+0.06)
			polygon(points=[[ri,a/2],[ri,-a/2],[ri+(ro-ri)/2,-a/4],[ri+(ro-ri)/2,-a/2-t],[ro+t*h/a,-a/2-t],[ro+t*h/a,0]],paths=[[0,1,2,3,4,5]]);
		translate([0,0,-0.03])linear_extrude(height=w+0.06)
			polygon(points=[[ri+t,a/2-t],[ri+t,t-a/2],[ro+h/a,0],[ro+h/a,a+t],[ri+(ro-ri)/2,a+t],[ri+(ro-ri)/2,a/4-t]],paths=[[0,1,2,3,4,5]]);
		}
	for(i=[1:m])rotate([0,0,i*360/m])
		translate([0,0,-0.03])linear_extrude(height=w+0.06)
			polygon(points=[[ri+t,a/2-t],[ri+t,t-a/2],[ro+h/a,0]],paths=[[0,1,2]]);
	}
}

module hollowcuts(){
	union(){
		if (Clasp==1){
		rotate([0,0,360/m])translate([0,0,-0.02])linear_extrude(height=w+0.04)
			polygon(points=[[ri-t,a/2+t],[ri-t,-a/2-t],[ro+3*t*h/a,0]],paths=[[0,1,2]]);
		}
	for(i=[1:m])rotate([0,0,i*360/m])
		translate([0,0,-0.02])linear_extrude(height=w+0.04)
			polygon(points=[[ri,a/2],[ri,-a/2],[ro+3*t*h/a,0]],paths=[[0,1,2]]);
	}
}

module corded(r1,w){
//render()
union(){
		cylinder(r=ro-r1/2,h=w);
     	for(i=[1:n]){
          rotate([0,0,i*(360)/n+180])translate([0,ro-rr,0])
          scale([1.2,0.5,1])linear_extrude(height=w,twist=dir*-180,slices=10)
               translate([dir*rr,0,0])circle(r=r1,$fn=20);
     }
}}

module hbanded(ro,w){
difference(){
	union(){    
     translate([0,0,-.01])cylinder(r=ro-hsc,h=w+.02,$fn=100);
     for(i=[1:Bands]){
          translate([0,0,(i-1)*3*hsc+1.5*hsc])scale([1,1,1.65])rotate_extrude($fn=100)
               translate([ro-hsc,0,0])circle(r=hsc,$fn=50);
     }
	}
	translate([0,0,-hsc])cylinder(r=ro,h=hsc,$fn=100);
	translate([0,0,w])cylinder(r=ro,h=hsc,$fn=100);
}
}

module vbanded(ro,r2,w){
union(){
		cylinder(r=ro-r2,h=w,$fn=m*Bands);
		for(i=[1:mult])rotate([0,0,(i*360/mult)])
          translate([0,-r2,0])scale([1,1+t/3,1])linear_extrude(height=w)
          translate([ro-r2,0,0])circle(r=r2,$fn=50);
}}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
