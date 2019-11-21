/*************************************************
  Adjustable Ball & Socket Joint

 Author: Lee J Brumfield

*************************************************/


// Which one would you like to see?
part = "fourth"; // [first:Base Only,second:Nut Only,third:Stem Only, fourth:All]

// Ball diameter
Ball_Socket_size_in_mm= 8;// [5:1:12]
// Hex Stem if you want to put a wrench on it
Hex_Stem="no";// [yes,no]
// Length is approximate. Adjust the number to get the length you want
Length_Multiplier=3  ;// [1:1:10]
Hole_in_Top="yes";// [yes,no]
// Hole diameter
Hole_in_Top_size_in_mm=4;// [1:1:10]
Threads="yes";// [yes,no]
Width_of_Base= 40;// [20:1:200]
Thickness_of_Base= 6;// [1:1:20]
Holes_in_Base="yes";// [yes,no]
// Hole diameter
Hole_in_Base_size_in_mm=4; // [1:1:10]
// Minimum 4mm base thickness     
Notch_in_Base= "yes";// [yes,no]

/* [Hidden] */
//Nothing to change below here
NB=Notch_in_Base;
SS=Ball_Socket_size_in_mm;
WB=Width_of_Base;
HS=(WB/2)-Hole_in_Base_size_in_mm;
hs=Hole_in_Base_size_in_mm/2;
rs=Hole_in_Base_size_in_mm+.5;
HT=Hole_in_Top_size_in_mm/2;
RS=Hole_in_Top_size_in_mm+.5;
BS=Ball_Socket_size_in_mm;
TB=Thickness_of_Base-2;
LM=Length_Multiplier;

print_part();

module print_part() {
	if (part == "first") {
		Base();
	} else if (part == "second") {
		Nut();
	} else if (part == "third") {
		Stem();
   } else if (part == "fourth") {
		All();
	} 
}
module All() 
{
Stem ();
Nut();
Base ();
}

$fn=200;
module Stem() 
{
color ("red")
{
rotate([180,0,0])
difference()
{
union()
{
if (Threads == "yes")
{
intersection()
{
translate([0,0,SS/2+(SS*2)/10])
linear_extrude(height=SS,center=true,convexity=10,twist=-720)
translate([(SS*2)/10,0,0])
circle(r=SS+SS/3); 
translate([0,0,(SS*2)/10+SS/2])
cylinder(r=SS+(SS*2)/6,h=SS,center=true); 
}
translate([0,0,(SS*2)/10+SS/2])
cylinder(r=SS+(SS*2)/10,h=SS,center=true); 
}
translate([0,0,SS+(SS*2)/10])
sphere(r=SS+(SS*2)/10,center=true);
if (Hex_Stem == "yes")
translate([0,0,-(SS*LM)/4-5])
cylinder(r=(SS+(SS*2)/10)/2,h=(SS*LM)/2+5,$fn=6,center=true);
else
translate([0,0,-(SS*LM)/4-5])
cylinder(r=(SS+(SS*2)/10)/2,h=(SS*LM)/2+5,center=true);
translate([0,0,(-SS-(SS*LM+(SS*2)/10)/2)])
sphere(r=SS,center=true);
hull()
{
if (Hex_Stem == "yes")
translate([0,0,-SS/2-(SS+(SS*2)/10)/2+(SS+(SS*2)/10)/2])
cylinder(r=(SS+(SS*2)/10)/2,h=.1,$fn=6,center=true);
else
translate([0,0,-SS/2-(SS+(SS*2)/10)/2+(SS+(SS*2)/10)/2])
cylinder(r=(SS+(SS*2)/10)/2, h=.1,center=true);
translate([0,0,SS+(SS*2)/10])
cylinder(r=SS+(SS*2)/10,h=.1,center=true);
}
}
translate([0,0,SS+(SS*2)/10])
sphere(r=SS,center=true);
translate([0,0,(SS+(SS*2)/10)+(SS+(SS*2)/10)/3+21])
cube([80,80,40],center=true);
translate([0,0,(SS+(SS*2)/10)-(SS+(SS*2)/10)/3+21])
rotate([0,90,90])
minkowski()
{
cube([40,SS/15,80],center=true);
cylinder(r=SS/15,h=10,center=true);
}
translate([0,0,(SS+(SS*2)/10)-(SS+(SS*2)/10)/3+21])
rotate([0,90,45])
minkowski()
{
cube([40,SS/15,80],center=true);
cylinder(r=SS/15,h=10,center=true);
}
translate([0,0,(SS+(SS*2)/10)-(SS+(SS*2)/10)/3+21])
rotate([0,90,315])
minkowski()
{
cube([40,SS/15,80],center=true);
cylinder(r=SS/15,h=10,center=true);
}
translate([0,0,(SS+(SS*2)/10)-(SS+(SS*2)/10)/3+21])
rotate([0,90,0])
minkowski()
{
cube([40,SS/15,80],center=true);
cylinder(r=SS/15,h=10,center=true);
}
translate([0,0,2*SS])
sphere(r=SS,center=true);
if (Hole_in_Top == "yes")
{
cylinder(r=HT,h=SS*LM*4,center=true);
translate([0,0,(-SS-(SS*LM+(SS*2)/10)/2)-(SS)/2])
cylinder(r1=SS,r2=HT,h=SS,center=true);
}
}
}
}
/*************************************************
  Adjustable Ball & Socket Nut

 Author: Lee J Brumfield

*************************************************/


module Nut() 
{
color ("blue")
{
translate([SS*5,0,0])
{
difference()
{
union()
{
translate([0,0,SS+(SS*2)/10-SS/2-(SS*2)/10])
cylinder(r=SS+(SS*2)/10+4, h=SS+(SS*2)/5, $fn=12,center=true);
}
intersection()
{
translate([0,0,SS+(SS*2)/10-SS/2])
linear_extrude(height = SS+.01,center=true,convexity=10,twist=-720)
translate([(SS*2)/10,0,0])
scale(1.1)
circle(r = SS+SS/3); 
translate([0,0,SS+(SS*2)/10-SS/2])
scale(1.1)
cylinder(r=SS+(SS*2)/6,h=SS,center=true); 
}
cylinder(r=SS,h=2*SS,center=true); 
translate([0,0,(SS*2)/10])
sphere(r=SS+(SS*2)/10,center=true);
}
}
}
}
/*************************************************
  Adjustable Ball & Socket Joint Base

      Author: Lee J Brumfield

*************************************************/

/* Adjust socket size. Default is 5   
                                
   Adjust Width of base. Default is 40

   Adjust Thickness of base. Default is 2

   Notch in Base for wire raceway

*/


module Base() 
{
color ("orange")
{


translate([-WB-SS,0,0])
{
difference()
{
union()
{
hull()
{
translate([0,0,2])
cylinder(r=SS/2,h=.1,center=true);
minkowski()
{
  cube([WB-4,WB-4,.5],center=true);
  cylinder(r=2,h=.5,center=true);
}
}
translate([0,0,2+BS/2])
cylinder(r=SS/2,h=BS,center=true);
translate([0,0,SS+(SS*2)/10+2])
sphere(r=SS,center=true);
translate([0,0,-TB/2-.499])
minkowski()
{
  cube([WB-4,WB-4,TB/2],center=true);
  cylinder(r=2,h=TB/2,center=true);
}
if (Hole_in_Top == "yes")
translate([0,0,-3])
minkowski()
{
  cube([WB-4,WB-4,3],center=true);
  cylinder(r=2,h=2,center=true);
}
}
if (Holes_in_Base == "yes")
{
translate([HS,HS,-TB/2-.499])
cylinder(h=TB+10,r=hs,center=true);
translate([HS,-HS,-TB/2-.499])
cylinder(h=TB+10,r=hs,center=true);
translate([-HS,HS,-TB/2-.499])
cylinder(h=TB+10,r=hs,center=true);
translate([-HS,-HS,-TB/2-.499])
cylinder(h=TB+10,r=hs,center=true);
translate([HS,HS,3.1])
cylinder(h=5,r=rs,center=true);
translate([-HS,HS,3.1])
cylinder(h=5,r=rs,center=true);
translate([-HS,-HS,3.1])
cylinder(h=5,r=rs,center=true);
translate([HS,-HS,3.1])
cylinder(h=5,r=rs,center=true);
}
if (Hole_in_Top == "yes")
{
cylinder(r=HT,h=SS*5,center=true);
translate([0,0,-Thickness_of_Base/4-3.55])
cylinder(h=Thickness_of_Base/2,r=rS,center=true);
translate([0,0,2*SS+((SS*2)/10+2)-SS/3])
cylinder(r1=HT,r2=SS,h=SS,center=true);
}
if (NB == "yes")
translate([0,WB/4+.01,-Thickness_of_Base/4-3.55])
cube([TB*1.5,WB/2,Thickness_of_Base/2],center=true);
}
}
}
}