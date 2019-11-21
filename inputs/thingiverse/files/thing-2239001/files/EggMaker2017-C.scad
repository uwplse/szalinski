//Easter Egg Maker 2017 from Richard Swika
/* [Egg Symmetry] */
//2014-2017 Richard Swika -  Creative Commons - Attribution - Non-Commercial license.
//Initial Release 4/9/2017
//Rev A: 4/10/2017 
//  - Added Wallpaper Groups 9 of 17
// - Added ability to print decoration and egg separately for dual extrusion
//  - Fixed a few bugs; add/subtract were reversed; spacing edit box was missing from customizer
//
//Rev B: 4/12/2017
// - Added "twist" to rotate lattice over length of egg
// - Changed defaults to show effects of "twist"
//Rev C: 4/14/2017
// - Added example scripts
// - Changed design view to show two instances of the egg at right angles

/* [Decoration] */

//Add or subtract decoration from egg (use feature depth to control amount)?
operation="subtract"; //[subtract,add,decoration_only,egg_only]

//Choose a feature to repeat?
feature="hexagon"; //[sphere,star,dot,triangle,square,diamond,pentagon,hexagon,octagon]

//Set the relative size of the feature
size_of_feature=50; //[1:250]

//Number of horizontal loops; impacts pattern and render time (for larger values, use offline)
ucount=6; //[3:16]

//Number of vertical loops; impacts pattern and reander time (for larger values, use offline)
vcount=8; //[3:16]

//Set the relative depth of the feature
feature_depth=20; //

//Set the feature start angle (values like 0, 15, 30 and 45 work best)
start_angle=0; //

//How much feature rotation over the length of the egg (0 for none)?
feature_rotation=0; //

//Vary feature size (yes give a better appearance)?
proportional="yes"; //[yes,no]

/* [placement (wallpaper group) 9 of 17] */
//Select a wallpaper group to control symmetry; NOTE: requires a non-symmetrical feature to work, so use X and Y offset to see the effect (google wallpaper group for more information)
group="p1"; //[p1,p2,pm,pg,cm,pmm,pmg,pgg,p4]

//Set some X offset to control the effect of the wallpaper group on symmetrical features (%).
Xoffset=0; //[0:100]

//Set some Y offset to control the effect of the wallpaper group on symmetrical features (%).
Yoffset=0; //[0:100]

//Set some X scaling to control the effect of the wallpaper group on symmetrical features (%)
Xscaling=100; //[10:100]

//Set some Y scaling to control the effect of the wallpaper group on symmetrical features (%)
Yscaling=100; //[10:100]

//Amount to rotate lattice over length of egg for a spiral like effect
twist=90; //[0:360]

/* [Size and Shape] */
//Length of the egg (mm)?.
egg_length=60; //[30:200]

//What shape egg? (use 7 for a hen egg; 0 for a sphere; 100 for a blimp)
egg_shape=7; //[0:100]

//What percentage of the interior should be hollow (0 for totally solid)
interior=85; //[0:95]

//Do you want the inside to be smooth or decorated? (hollow bisected eggs only)
inside="smooth"; //[smooth,decorated]

/* [Printing] */
//Do you want it bisected? (IMPORTANT: YES for printing, NO during preview.)
bisect="no"; //[yes,no]

//Do you want to add a joiner to hold the egg together? (hollow bisected eggs only)
joiner="attached"; //[attached,detached,none]

//Set the spacing between parts on the build plate in mm
spacing=2; //[2:10]

/* [Hidden] */
// preview[view:top, tilt:top]
tiny=0.001;

//set true to turn off the demo egg so you can use the modules instead
moduleMode=false; //[false,true];

//when false the egg will have quads where possible instead of all trigons
//this can lead to problems with non-plannar surfaces when using csg
//so only use it true if when not using a base
allTrigon=true; //[false,true]

function ud(ui) = ui*360/ucount;
function vd(vi) = vi*180/vcount;

//egg equation adapted from http://www16.ocn.ne.jp/~akiko-y/Egg
//(y^2 + z^2)^2=4z^3 + (4-4c)zy^2
// c=0.7 produces an almost perfect hen egg outline+
// c=0 produces a perfect sphere
// c>1 produces an elongated egg shape
//z ranges from 0 to 1
function egg_outline(c,z)= z >=1 ? 0 : (sqrt(4-4*c-8*z+sqrt(64*c*z+pow(4-4*c,2)))*sqrt(4*z)/sqrt(2))/4;
//map the egg's surface from uv to xyz with these functions
function x(ui,r) = r * sin(ud(ui));
function y(ui,r) = r * cos(ud(ui));
function z(vi,r) = r * cos(vd(vi));	
function n(vi,r) = r * sin(vd(vi));	
function zi(vi) = (1+cos(vd(vi)))/2;	
//polar to rectanglar
function P2R(p)=[p[0]*cos(p[1]),p[0]*sin(p[1])];

//first deriviative of egg equation used to calculate surface normal
function egg_slope(c,z)= -((4*z+c-1)*sqrt(c*(4*z+c-2)+1)+c*(2-6*z)-pow(c,2)-1) / (pow(2,3/2)*sqrt(z)*sqrt(c*(4*z+c-2)+1)*sqrt(sqrt(c*(4*z+c-2)+1)-2*z-c+1));
function egg_surface_angle(c,z)=atan(egg_slope(c,z));

center = 0.5; //set to 1 to center at small end; 0 to center on fat end

//to avoid degenerate geometry at the poles we can not use quads 
//so we will generate phantom points as if we were using quads, but use tris instead 
//just to simplify indexing, but will only link faces to a single point at each pole
//but we will use the phantom points to calculate average displacement at each pole
//lets make an egg
points = [ for (vi=[0:vcount]) 
    for (ui = [0 : ucount-1]) 
        let (r=egg_outline(egg_shape/10,1-zi(vi)),ut=ui+ucount*twist*vi/(vcount*360)) 
                    [x(ut,r), y(ut,r),(zi(vi))-center]];
faces =  (allTrigon)     
 ? [ for (vi=[0:vcount-1]) for (ui = [0:ucount-1])  for (p=[0:1])
    (vi==0)&&(p==0) ? [vi*ucount,ui+(vi+1)*ucount,(ui+1) % ucount+(vi+1)*ucount]
    : (vi==vcount-1)&&(p==0) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,(vi+1)*ucount]
    : (p==0) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,ui+(vi+1)*ucount]
    :[(ui+1) % ucount+vi*ucount,ui+(vi+1)*ucount,(ui+1)%ucount+(vi+1)*ucount]] 
: [ for (vi=[0:vcount-1]) for (ui = [0:ucount-1])  
    (vi==0) ? [vi*ucount,ui+(vi+1)*ucount,(ui+1) % ucount+(vi+1)*ucount]
    : (vi==vcount-1) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,(vi+1)*ucount]
    : [(ui+1) % ucount+vi*ucount,ui+vi*ucount,ui+(vi+1)*ucount,(ui+1)%ucount+(vi+1)*ucount]] ;
//echo(faces=faces);

$fn=6;
//an adjustable Egg
module Egg(egg_length=egg_length,egg_shape=egg_shape){
     scale (egg_length) rotate([0,0,0]) polyhedron(points=points,faces=faces);
}    
module star2D(r1=100,r2=35,twist=0){
		d=360/10; 
		 points=[P2R([r1,d*0+twist]),P2R([r2,d*1]),
							P2R([r1,d*2+twist]),P2R([r2,d*3]),
							P2R([r1,d*4+twist]),P2R([r2,d*5]),
							P2R([r1,d*6+twist]),P2R([r2,d*7]),
							P2R([r1,d*8+twist]),P2R([r2,d*9])];
		color("yellow",0.5)  rotate(90) polygon(points=points,convexity=4);
}
module pip (size_of_feature=20,feature_depth=5) {
    scale(0.5*size_of_feature*[1,1,feature_depth/10]) {
        translate([.7,.7,0]) cube(0.75,center=true);
        rotate([90,0,-45]) cylinder(r=.3,h=2,center=true);
        translate([-.7,-.7,0]) sphere(0.5);
    }
}
 
module shape(){
  scale(egg_length/50) //make proportional to size of egg  
  if (feature=="star"){linear_extrude(height=feature_depth/10,twist=0,center=true,convexity=10) star2D(r1=size_of_feature/20,r2=size_of_feature/40);}
  else if (feature=="dot"){cylinder(d=size_of_feature/5,h=feature_depth/10,$fn=16);}
  else if (feature=="sphere"){sphere(d=size_of_feature/10,h=feature_depth/10,$fn=6);}
  else if (feature=="triangle"){cylinder(d=size_of_feature/10,h=feature_depth/10,$fn=3);}
  else if (feature=="square"){cube([size_of_feature/10,size_of_feature/10,feature_depth/10],center=true);}
  else if (feature=="diamond"){rotate([45,45,0]) cube([size_of_feature/10,size_of_feature/10,feature_depth/10],center=true);}
  else if (feature=="pentagon"){cylinder(d=size_of_feature/10,h=feature_depth/10,$fn=5);}
  else if (feature=="hexagon"){cylinder(d=size_of_feature/10,h=feature_depth/10,$fn=6);}
  else if (feature=="octagon"){cylinder(d=size_of_feature/10,h=feature_depth/10,$fn=8);}
  else if (feature=="pip"){pip(size_of_feature/10,feature_depth);}
}      

//Makes a solid object into hollow shell of its former self
//the size of the inside is factor * size of outside 
module hollow_shell(factor=interior/100){   
	if ((factor<=0) ) children();
	else union(){
      render() 
	  difference()  {
		translate([0,0,0.01])
		children();
        if (inside=="smooth") {scale (factor) Egg();}
        else {scale(factor) children();}
	  }
	}
}

//bisect object down the middle and postion the two halfs for printing
module bisect(){
        render()
		difference(){
			rotate([0,0,0]) union(){
				translate([egg_length/3+2,0,0])children();
				translate([-egg_length/3-2,0,0]) rotate([180,0,0]) children();
			}
			translate([0,0,-1-egg_length/4])
				cube([egg_length*2.1,egg_length*1.05,2+egg_length/2],center=true);
		}
}

module SolidEasterEgg(){
    render()
    if (operation=="add") {
        union()
            {Egg();
            EggDeco();
            }
        }
    else if (operation=="egg_only") Egg();
    else if (operation=="decoration_only")  EggDeco();
    else {
        difference()
            {Egg();
            EggDeco();
            }
     }
}

module HollowEasterEgg(){
   hollow_shell() SolidEasterEgg();
}

module bisectAndJoiner(){
   render()
    translate([egg_length*egg_outline(egg_shape/10,0.5)+spacing/2,0,joiner=="attached" ? egg_length/20 : 0]) union(){
        //half of egg
       difference(){
                children();
                translate([0,0,-1-egg_length/4])
                    cube([egg_length*2.1,egg_length*1.05,2+egg_length/2],center=true);
        }
        //joiner
        if (joiner!="none") {
            translate([joiner=="detached" ? 2*egg_length*egg_outline(egg_shape/10,0.5)+spacing:0,0]) scale((interior+1)/100) intersection(){
                $fn=32;
                children();
                cylinder(r=egg_length*egg_outline(egg_shape/10,0.5)*.99,h=egg_length/10,center=true);
            }
        }
    }
    //other half of egg
     render()
	translate([-egg_length*egg_outline(egg_shape/10,0.5)-spacing/2,0,0]) difference(){
			rotate([180,0,0]) children();
			translate([0,0,-1-egg_length/4])
				cube([egg_length*2.1,egg_length*1.05,2+egg_length/2],center=true);
		}    
}

//wallpaper group coding follows
function even(i)= i % 2;
module reflectX(enable=1) {if (enable) {mirror([1,0,0]) children();} else {children();}}
module reflectY(enable=1) {if (enable) {mirror([0,1,0]) children();} else {children();}}
  
module wallpaper(group="p1",p=[0,0,0]) {
//    echo(p);
    if (group=="p1") /*translation */
        {children();}
    else if (group=="p2")  /*180 degree rotation*/
        {rotate([0,0,180*even(p.x)]) children();}
    else if (group=="pm") /*reflection*/
       {reflectX(even(p.x)) children();}
    else if (group=="pg") /*glide reflection*/
      {reflectX(even(p.y)) children();}
    else if (group=="cm") /*reflection + glide reflection*/
      {scale([(1-2*(p.x % 2))*(1-2*(p.y % 2)),1,1]) children();}
   else if (group=="pmm") /*reflection + reflection*/
      {scale([(1-2*(p.x % 2)),(1-2*(p.y % 2)),1]) children();}
   else if (group=="pmg") /*reflection + 180 degree rotation*/
      {scale([(1-2*(p.x % 2)),((1-2*(p.x % 2)))*(1-2*((p.y) % 2)),1]) children();}
   else if (group=="pgg") /*glide reflection + 180 degree rotation*/
      {rotate([0,0,180*((p.x+p.y) % 2)]) scale([1-2*(p.x % 2),1,1]) children();}
//    else if (group=="cmm") /*reflection + reflection + glide reflection*/
//      {wallpaper("cm",p) 
//          tile("pmm",[1,2,0],[1,2,0]) children();}
   else if (group=="p4") /*90 degree rotation*/
     {rotate([0,0,even(p.x)*-90+even(p.y)*90+even(p.x)*even(p.y)*180]) children();}
 }
 
module EggDeco(){
    for (p=points) {translate(p*egg_length) rotate([90+egg_surface_angle(egg_shape/10,1-p.z-center),0,atan2(-p.x,p.y)]) scale(proportional=="yes" ? 0.5 + 2*egg_outline(egg_shape/10,1-p.z-center):1)
        rotate([0,0,start_angle+feature_rotation*(1-p.z-center)]) wallpaper(group,[ucount-ucount*((atan2(p.x,-p.y)+180)/360),vcount*acos(2*p.z)/180,0]) 
        translate([egg_length*Xoffset/(100*ucount),egg_length*Yoffset/(100*vcount),0]) scale([Xscaling/100,Yscaling/100,1]) shape();}
}

//display a two views of an object at 90 degree angles to one another about the z axis
module DisplayOrtho(offsetX=egg_length){
    translate([offsetX/2,0,0]) rotate([0,90,0]) children();
    translate([-offsetX/2,0,0]) children();
}
//some ways to use the modules
//bisect() hollow_shell() Egg();
//bisect() HollowEasterEgg();
if (!moduleMode) {
    if (bisect=="yes") {bisectAndJoiner() HollowEasterEgg();}
    else {rotate([55,0,25]) DisplayOrtho() SolidEasterEgg();}
}
