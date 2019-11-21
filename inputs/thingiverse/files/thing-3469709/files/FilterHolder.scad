// Which part would you like to see?
part = "6"; // [1:Vent Only,2:Base Only,3:Filter Ring Only,4:Vent & Base Only,5:Base & Filter Ring Only,6:All]
Height=30;// [5:1:100]
Inside_diameter=100;// [40:1:300]
Wall_thickness=3;// [2:1:8]
Top_Overhang=5;// [0:1:20]
Vent_width=8;// [2:.5:10]
Space_between_Vents=7;// [2:.5:10]
//Twistlock Base
Twistlock="yes";// [yes,no]
Holes_in_base="yes";// [yes,no]
Countersink_holes="yes";// [yes,no]
Hole_size=4;// [2:.25:10]
//Depth of filter media
Filter_ring_depth=6;// [5:1:20]
//Thickness of the grill
Filter_ring_thickness=1;// [1:.5:5]
Shroud="yes";// [yes,no]
//Twist Grip Top (only works with shroud)
TwistGrip="no";// [yes,no]

/* [Hidden] */
// preview[view:south, tilt:top diagonal]
HS=Hole_size/2;
HT=Height;
WT=Wall_thickness;
OD=Inside_diameter/2+WT;
OH=Top_Overhang;
HTB=Height-2*WT;
VW=Vent_width;
SBV=Space_between_Vents;
NC=(2*OD*PI)/(VW+SBV);
RA=360/NC;
FRD=Filter_ring_depth;
FRT=Filter_ring_thickness;

/*************************************************
 Air filter holder

 Author: Lee J Brumfield

*************************************************/

print_part();

module print_part() 
{
if (part == "1")
{
Vent();
} 
else if (part == "2") 
{
Base();
} 
else if (part == "3") 
{
FilterRing();
}
else if (part == "4")
{
VentBase();
}
else if (part == "5")
{
BaseRing();
}
else if (part == "6")
{
All();
}  
}

module VentBase()
{
Vent();
Base();
}

module BaseRing()
{
Base();
FilterRing();
}
module All() 
{
Vent();
Base();
FilterRing();	
}

$fn=200;

module Vent() 
{
color ("silver")
{
translate([0,0,0])
rotate([0,0,19])
{
difference()
{
union()
{
cylinder(h=HT,r=OD,center=true);
translate([0,0,-HT/2-WT/2])
cylinder(h=WT+.1,r=OD+OH,center=true);
if (Twistlock == "yes")
{
translate([0,0,HT/2-WT*.4-.05])
rotate([0,0,22.5])
minkowski()
{
cube([WT,2*OD+WT*1.5,.1],center=true);
cylinder(r=WT*.8,h=WT*.8,center=true);
}
translate([0,0,HT/2-WT*.4-.05])
rotate([0,0,112.5])
minkowski()
{
cube([WT,2*OD+WT*1.5,.1],center=true);
cylinder(r=WT*.8,h=WT*.8,center=true);
}
}
}
translate([0,0,WT/2])
cylinder(h=HT+WT,r=OD-WT,center=true);
if (OD>=35)
{
translate([.8,-.8,-HT/2-WT-.7])
rotate([0,180,0])
scale(.5)
import("Brand3.stl",convexity=3, center=true);
}
translate([0,0,-WT])
{
for (i=[0:NC/2])
rotate([0,0,RA*i])
cube ([2*OD+.1,VW,HTB],center=true);
}
}
if (Shroud == "yes")
{
difference()
{
union()
{
if (TwistGrip == "yes")
{
translate([0,0,-WT])
cylinder(h=HT-WT*2,r=OD+WT*6,$fn=8,center=true);
translate([0,0,-HT/2-WT/2])
cylinder(h=WT+.1,r=OD+WT*6+OH,$fn=8,center=true);
}
else
{
translate([0,0,-WT])
cylinder(h=HT-WT*2,r=OD+WT*6,center=true);
translate([0,0,-HT/2-WT/2])
cylinder(h=WT+.1,r=OD+WT*6+OH,center=true);
}
}
if (TwistGrip == "yes")
{
translate([0,0,WT])
cylinder(h=HT+WT*2,r=OD+WT*6-WT,$fn=8,center=true);
}
else
{
translate([0,0,-WT])
cylinder(h=HT-WT*2+.01,r=OD+WT*6-WT,center=true);
}
if (OD>=35)
{
translate([.8,-.8,-HT/2-WT-.7])
rotate([0,180,0])
scale(.5)
import("Brand3.stl",convexity=3, center=true);
}
}
}
}
}
}

module Base() 
{
color ("green")
{
difference()
{
translate([0,0,HT/2-WT])
cylinder(h=WT*2-.1,r=OD+WT*3,center=true);
translate([0,0,HT/2-WT])
cylinder(h=WT*2+.1, r=OD+WT*.3,center=true);
if (Holes_in_base == "yes")
{
translate([OD+WT*1.5,0,HT/2-WT])
rotate([0,0,0])
cylinder(h = WT*2, r=HS,  center = true);
translate([-OD-WT*1.5,0,HT/2-WT])
rotate([0,0,0])
cylinder(h = WT*2, r=HS,  center = true);
translate([0,OD+WT*1.5,HT/2-WT])
rotate([0,0,0])
cylinder(h = WT*2, r=HS,  center = true);
translate([0,-OD-WT*1.5,HT/2-WT])
rotate([0,0,0])
cylinder(h = WT*2, r=HS,  center = true);
if (Countersink_holes == "yes")
{
translate([OD+WT*1.5,0,HT/2-WT*2+HS/2])
rotate([0,0,0])
cylinder(h = HS, r1=HS*2, r2=HS, center = true);
translate([-OD-WT*1.5,0,HT/2-WT*2+HS/2])
rotate([0,0,0])
cylinder(h = HS, r1=HS*2, r2=HS, center = true);
translate([0,OD+WT*1.5,HT/2-WT*2+HS/2])
rotate([0,0,0])
cylinder(h = HS, r1=HS*2, r2=HS, center = true);
translate([0,-OD-WT*1.5,HT/2-WT*2+HS/2])
rotate([0,0,0])
cylinder(h = HS, r1=HS*2, r2=HS, center = true);
}
}
if (Twistlock == "yes")
{
translate([0,0,HT/2-WT])
rotate([0,0,22.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=2*WT+.1,center=true);
}
translate([0,0,HT/2-WT])
rotate([0,0,112.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=2*WT+.1,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,25])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,115])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,27.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,117.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,30])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,120])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,32.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,122.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,35])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,125])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,37.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,127.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,40])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,130])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,42.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
translate([0,0,HT/2-WT/2])
rotate([0,0,132.5])
minkowski()
{
cube([WT,2*OD+WT*1.5+1,.1],center=true);
cylinder(r=WT,h=WT,center=true);
}
}
}
}
}



module FilterRing()
{
color ("coral")
{
difference()
{
translate([0,0,HT/2+1+(FRD+FRT)/2])
cylinder(h=FRD+FRT,r=OD+WT*3,center=true);
translate([0,0,HT/2+1+(FRD+FRT)/2])
cylinder(h=FRD+FRT+.1, r=OD-WT,center=true);
if (Holes_in_base == "yes")
{
translate([OD+WT*1.5,0,HT/2+1+(FRD+FRT)/2])
rotate([0,0,0])
cylinder(h = FRD+FRT+.1, r=HS,  center = true);
translate([-OD-WT*1.5,0,HT/2+1+(FRD+FRT)/2])
rotate([0,0,0])
cylinder(h = FRD+FRT+.1, r=HS,  center = true);
translate([0,OD+WT*1.5,HT/2+1+(FRD+FRT)/2])
rotate([0,0,0])
cylinder(h = FRD+FRT+.1, r=HS,  center = true);
translate([0,-OD-WT*1.5,HT/2+1+(FRD+FRT)/2])
rotate([0,0,0])
cylinder(h = FRD+FRT+.1, r=HS,  center = true);
}
}
difference()
{
translate([0,0,HT/2+1+FRD+FRT/2])
cylinder(h=FRT,r=OD/1.3,center=true);
translate([0,0,HT/2+1+(FRD+FRT)/2])
cylinder(h=FRD+FRT+.1,r=OD/1.3-FRT,center=true);
}
difference()
{
translate([0,0,HT/2+1+FRD+FRT/2])
cylinder(h=FRT,r=OD/2,center=true);
translate([0,0,HT/2+1+(FRD+FRT)/2])
cylinder(h=FRD+FRT+.1,r=OD/2-FRT,center=true);
}
difference()
{
union()
{
translate([0,0,HT/2+1+FRD+FRT/2])
rotate([0,0,0])
cube([FRT,OD*2+WT,FRT],center=true);
translate([0,0,HT/2+1+FRD+FRT/2])
rotate([0,0,45])
cube([FRT,OD*2+WT,FRT],center=true);
translate([0,0,HT/2+1+FRD+FRT/2])
rotate([0,0,90])
cube([FRT,OD*2+WT,FRT],center=true);
translate([0,0,HT/2+1+FRD+FRT/2])
rotate([0,0,135])
cube([FRT,OD*2+WT,FRT],center=true);
translate([0,0,HT/2+1+FRD+FRT/2])
cylinder(h=FRT,r=OD/5,center=true);
}
translate([0,0,HT/2+1+(FRD+FRT)/2])
cylinder(h=FRD+FRT+.1,r=OD/5-FRT,center=true);
}
}
}
