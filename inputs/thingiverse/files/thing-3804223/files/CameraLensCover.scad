/* [Global] */
// Which part would you like to see?
part = "3"; // [1:Cover Only,2:Laser mount Only,3:Both]
With_Lens_or_Laser="yes";// [yes,no]
Four_lasers="yes";// [yes,no]
Camera_round="no";// [yes,no]
//If round default 79
Camera_diameter=79;// [10:.5:120]
//If rectangular
//Default 79
Camera_width=79;// [10:.5:120]
//Default 75.9
Camera_height=75.9;// [10:.5:120]
//Default 20
Corner_radius=20;// [1:.5:20]
Cover_Depth=20;// [5:.5:30]
Cover_Wall_Thickness=3;// [2:.5:5]
//If with Lens default 50
Lens_diameter=50;// [20:.5:100]
//If with laser
Laser_diameter=13.5;// [1:.5:20]
Laser_Height=50;// [10:.5:80]
Laser_angle=45;// [0:.5:45]


/*[hidden]*/

/*************************************************
    Multifuction Camera Lens Cover
  
      Author: Lee J Brumfield

  Creative Commons -  Attribution - 
  Non-Commercial   - No Derivatives

*************************************************/
CR=Corner_radius;
LR=Lens_diameter/2;
CD=Camera_diameter/2;
CW=Camera_width-2*CR;
CH=Camera_height-2*CR;
WT=Cover_Wall_Thickness;
CVD=Cover_Depth+WT;
LA=Laser_angle;
LD=Laser_diameter/2;
LLH=Laser_Height;
LRA=Laser_rotation_angle;

print_part();

module print_part() 
{
if (part == "1")
{
Cover();
} 
else if (part == "2") 
{
Laser();
} 
else if (part == "3") 
{
Both();
}
 
module Both() 
{
Cover();
Laser();	
}

$fn=200;

module Cover() 
{
color ("coral")
{
difference()
{
union()
{
if (Camera_round == "yes")
translate([0,0,0])
cylinder(r=CD+WT,h=CVD);
else
translate([0,0,0])
minkowski()
{
cube([CW,CH,.01],center=true);
cylinder(r=CR+WT,h=CVD);
}
}
if (Camera_round == "yes")
translate([0,0,WT])
cylinder(r=CD,h=CVD);
else
translate([0,0,WT])
minkowski()
{
cube([CW,CH,.01],center=true);
cylinder(r=CR,h=CVD);
}
if (With_Lens_or_Laser == "yes")
{
if (Four_lasers=="yes")
{
translate([0,0,-.01])
rotate([0,0,0])
cylinder(h=WT-1,r=LR+.2);
translate([0,0,-.01])
rotate([0,0,0])
cylinder(h=WT+.1,r=LR-4);
translate([0,0,(WT-1)/2-.01])
minkowski()
{
cube([(LR*2)+10.4,LR/3+.4,.01],center=true);
cylinder(r=1.2,h=WT-1,center=true);
}
}
else
{
translate([0,0,1])
rotate([0,0,0])
cylinder(h=WT,r=LR+.2);
translate([0,0,-.01])
rotate([0,0,0])
cylinder(h=WT+.1,r=LR-4);
translate([0,0,(WT-1)/2+1])
minkowski()
{
cube([(LR*2)+10.4,LR/3+.4,.01],center=true);
cylinder(r=1.2,h=WT-1,center=true);
}
}
}
}
}
}
}

module Laser() 
{
color ("green")
{
if (With_Lens_or_Laser == "yes")
{
difference()
{
union()
{
if (Four_lasers=="yes")
{
translate([0,0,(WT-1)/2-.1])
minkowski()
{
cube([(LR*2)+10,LR/3,.01],center=true);
cylinder(r=1,h=WT-1,center=true);
}
for (i=[0:4])
rotate([0,0,90*i])
hull()
{
translate([0,0,-WT/2])
rotate([LA,180,45])
cylinder(h=LLH,r=LD+3);
translate([0,0,-WT+1])
rotate([0,0,0])
cylinder(h=.1,r=LR-4.2);
}
}
else
{
translate([0,0,(WT-1)/2+1])
minkowski()
{
cube([(LR*2)+10,LR/3,.01],center=true);
cylinder(r=1,h=WT-1,center=true);
}
translate([0,0,1.1])
rotate([0,180,0])
cylinder(h=WT+.1,r=LR-4.2);
hull()
{
translate([0,0,-WT/2])
rotate([LA,180,0])
cylinder(h=LLH,r=LD+3);
translate([0,0,-WT+1])
rotate([0,0,0])
cylinder(h=.1,r=LR-4.2);
}
}
}
if (Four_lasers=="yes")
{
for (i=[0:4])
rotate([0,0,90*i])
translate([0,0,-WT/2])
rotate([LA,180,45])
cylinder(h=LLH+.1,r=LD);
translate([0,0,WT*3])
rotate([0,180,0])
cylinder(h=WT*3,r=LR-4.2);
translate([-.5,0-.5,WT])
rotate([0,0,0])
scale(.25)
import("Brand3.stl",convexity=3);
}
else
{
translate([0,0,-WT/2])
rotate([LA,180,0])
cylinder(h=LLH+.1,r=LD);
translate([0,0,WT*3])
rotate([0,180,0])
cylinder(h=WT*2,r=LR);
translate([-.5,0-.5,WT])
rotate([0,0,0])
scale(.25)
import("Brand3.stl",convexity=3);
}
}
difference()
{
union()
{
if (Four_lasers=="yes")
{
translate([0,0,WT-1.1])
rotate([0,180,0])
cylinder(h=WT-1,r=LR);
translate([0,0,WT])
rotate([0,180,0])
cylinder(h=WT*2,r=LR-4.2);
}
else
translate([0,0,WT])
rotate([0,180,0])
cylinder(h=WT-1,r=LR);
}
translate([-.5,0-.5,WT])
rotate([0,0,0])
scale(.25)
import("Brand3.stl",convexity=3);
}
}
}
}