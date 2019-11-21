/* [Global] */
// Which part would you like to see?
part = "4"; // [1:Ent,2:Recp,3:Cap,4:All]

Distance_of_holes_from_end=18;// [5:1:20]
Length_of_entrance=44;// [20:1:70]


/* [hidden] */

/*************************************************
          TBH SHB Trap
  
      Author: Lee J Brumfield

  Creative Commons -  Attribution - 
  Non-Commercial   - No Derivatives

*************************************************/


LE=Length_of_entrance;
HD=Distance_of_holes_from_end-LE/2;

print_part();

module print_part() 
{
if (part == "1")
{
Ent();
} 
else if (part == "2") 
{
Recp();
} 
else if (part == "3") 
{
Cap();
}
else if (part == "4") 
{
All();
}
 
module All() 
{
Ent();
Recp();	
Cap();
}

$fn=200;

module Ent() 
{
color ("blue")
{
translate([0,0,10])
rotate([0,0,0])
{
difference()
{
union()
{
translate([0,-1.75,0])
minkowski()
{
cube ([80,3.5,LE/2],center=true);
cylinder(h=LE/2,r=1,center=true);
}
translate([0,2.5,-LE/2])
minkowski()
{
cube ([85.5,12,.5],center=true);
cylinder(h=.5,r=1,center=true);
}
}
translate([0,-1.75,0])
minkowski()
{
cube ([77,.5,LE/2],center=true);
cylinder(h=LE/2+2,r=1,center=true);
}
translate([0,0,-HD])
{
translate([20,0,0])
rotate([90,0,0])
cylinder(h=10,r=2,center=true);
translate([-20,0,0])
rotate([90,0,0])
cylinder(h=10,r=2,center=true);
translate([20,-2.01,0])
rotate([90,0,0])
cylinder(h=5,r1=2,r2=5,center=true);
translate([-20,-2.01,0])
rotate([90,0,0])
cylinder(h=5,r1=2,r2=5,center=true);
}
}
difference()
{
union()
{
translate([0,0,-HD])
{
translate([20,-1.75,0])
rotate([90,0,0])
cylinder(h=3,r=6,center=true);
translate([-20,-1.75,0])
rotate([90,0,0])
cylinder(h=3,r=6,center=true);
}
}
translate([0,0,-HD])
{
translate([20,-2.01,0])
rotate([90,0,0])
cylinder(h=5,r1=2,r2=5,center=true);
translate([-20,-2.01,0])
rotate([90,0,0])
cylinder(h=5,r1=2,r2=5,center=true);
translate([20,0,0])
rotate([90,0,0])
cylinder(h=10,r=2,center=true);
translate([-20,0,0])
rotate([90,0,0])
cylinder(h=10,r=2,center=true);
}
}
}
}
}

module Recp() 
{
color ("green")
{
translate([0,0,10])
rotate([0,0,0])
{
difference()
{
union()
{
translate([0,5.5,-LE/2-8])
rotate([0,90,90])
minkowski()
{
cube ([18,90,10],center=true);
cylinder(h=10,r=1,center=true);
}
}
translate([0,7,-LE/2-9])
rotate([90,0,0])
minkowski()
{
cube ([86,11.5,10],center=true);
cylinder(h=10,r=1,center=true);
}
translate([0,-2,-.1])
minkowski()
{
cube ([80,5.5,20],center=true);
cylinder(h=24,r=1.2,center=true);
}
translate([0,3,-LE/2])
minkowski()
{
cube ([86,13,.5],center=true);
cylinder(h=.9,r=1.2,center=true);
}
translate([0,-1.5,-LE/2+12])
minkowski()
{
cube ([77,1,20],center=true);
cylinder(h=26,r=1,center=true);
}
}
}
}
}
}

module Cap() 
{
color ("orange")
{
translate([0,0,10])
rotate([0,0,0])
{
difference()
{
union()
{
translate([0,16.1,-LE/2-9])
rotate([0,90,90])
minkowski()
{
cube ([20,90,.5],center=true);
cylinder(h=.5,r=1,center=true);
}
translate([0,14,-LE/2-9])
rotate([90,0,0])
minkowski()
{
cube ([86,11.5,2],center=true);
cylinder(h=3,r=.8,center=true);
}
}
translate([0,13,-LE/2-9])
rotate([90,0,0])
minkowski()
{
cube ([83,8.5,2],center=true);
cylinder(h=3.01,r=.8,center=true);
}
}
}
}
}