Height=40;// [5:1:100]
Wall_thickness=4;// [2:1:10]
Outside_diameter=100;// [10:10.5:300]
Inside_diameter= 65;// [2:.5:300]
Lip_on_outside="yes";// [yes,no]
Lip_on_inside="yes";// [yes,no]
// 8 if yes 4 if no
Eight_fins="yes";// [yes,no]
/* [Hidden] */
EF=Eight_fins;
LO=Lip_on_outside;
LI=Lip_on_inside;
HT=Height;
WT=Wall_thickness;
OD=Outside_diameter/2;
ID=Inside_diameter/2;

/*************************************************
 Adjustable Bushing

 Author: Lee J Brumfield

*************************************************/


$fn=200;

color ("orange")
{
difference()
{
union()
{
cylinder(h=HT,r=OD,center=true);
cylinder(h=HT,r=ID+WT,center=true);
if (LO == "yes")
{
translate([0,0,HT/2-WT/4])
cylinder(h=WT/2,r=OD+WT,center=true);
translate([0,0,HT/2-WT/2-WT/4])
cylinder(h=WT/2,r1=OD,r2=OD+WT,center=true);
}
}
if (OD-ID>17)
translate([ID+(OD-ID+WT)/2-3,0,-HT/2])
rotate([0,180,90])
scale(.2)
import("Brand3.stl",convexity=10);
translate([0,0,WT/2])
cylinder(h=HT-WT+.1,r=ID,center=true);
translate([0,0,WT/2])
cylinder(h=HT-WT+.1,r=OD-WT,center=true);
if (LI == "yes")
cylinder(h=HT+1,r=ID-WT,center=true);
else
cylinder(h=HT+1,r=ID,center=true);
}
difference()
{
union()
{
cylinder(h=HT,r=ID+WT,center=true);
cube ([OD*2-(WT/2),WT,HT],center=true);
rotate([0,0,90])
cube ([OD*2-(WT/2),WT,HT],center=true);
if (EF == "yes")
{
rotate([0,0,45])
cube ([OD*2-(WT/2),WT,HT],center=true);
rotate([0,0,135])
cube ([OD*2-(WT/2),WT,HT],center=true);
}
if (LI == "yes")
translate([0,0,HT/2-WT/2])
cylinder(h=WT,r=ID-WT,center=true);
}
if (OD-ID>17)
translate([ID+(OD-ID+WT)/2-3,0,-HT/2])
rotate([0,180,90])
scale(.2)
import("Brand3.stl",convexity=3);
cylinder(h=HT+1,r=ID,center=true);
}
}