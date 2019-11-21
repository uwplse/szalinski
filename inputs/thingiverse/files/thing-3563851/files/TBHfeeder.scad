Distance_across_bottom=106;// [85:1:200]
Jar_lid_diameter=73;// [50:1:85]
/* [Hidden] */
DB=Distance_across_bottom/2;
JD=Jar_lid_diameter/2;
/***************************************
 Top Bar Hive internal jar feeder

 Author: Lee J Brumfield

****************************************/
$fn=200;

color ("blue")
{
translate([0,0,0])
{
difference()
{
union()
{
translate([-7.5,0,0])
cube([105,DB*2+64,35],center=true);
}
translate([0,-DB-33.2,0])
rotate([30,0,0])
cube([178,40,84],center=true);
translate([0,DB+33.2,0])
rotate([330,0,0])
cube([178,40,84],center=true);
hull()
{
translate([-9.1,0,-11])
cube([104,DB*2-4,1],center=true);
translate([-9.1,0,1])
cube([104,DB*2+9,1],center=true);
}
translate([-16.5,0,4.5])
cube([120,100,1.6],center=true);
translate([0,0,11])
cylinder(h=13.1,r=JD,center=true);
translate([0,0,10])
cylinder(h=20.1,r=JD-2.5,center=true);
translate([45.3,0,0])
rotate([90,0,90])
scale(.3)
import("Brand3.stl",convexity=3);
}
}
}