
Diameter_of_mount_pipe = 18.5;// [15:.5:35]
Diameter_of_angle_pipe=34.5;// [25:.5:40]





/* [hidden] */

/*************************************
           TSL2591 & BME680
             Sensor Mount 

         Author: Lee J Brumfield



*************************************/

// No changes below here

D2=Diameter_of_angle_pipe/2;
D1=Diameter_of_mount_pipe/2;

$fn=200;
difference()
{
union()
{
translate([0,0,-60])
rotate([0,0,0])
cylinder(h = 60, r1 = D1+3,r2=D2+5);
hull()
{
translate([-10,0,-15])
rotate([0,225,0])
cylinder(h = 35, r = D2+3);
translate([0,0,-2])
rotate([0,0,0])
cylinder(h = 3, r = D2+4);
}
cylinder(r=28,h=5,center=true);
}
translate([10,0,.5])
minkowski()
{
cube ([15,18,2.1], center=true);
cylinder(r=1.25,h=2,center=true);
}
translate([4,0,-4])
minkowski()
{
cube ([3,18,3], center=true);
cylinder(r=1.25,h=17,center=true);
}
translate([-10,0,-15])
rotate([0,225,0])
cylinder(h = 35.1, r = D2);
translate([-0,5,8])
rotate([0,225,0])
cylinder(h = 40, r = 1.7);
translate([-0,5,8])
rotate([0,225,0])
cylinder(h = 15,,r = 3.5);
translate([-6,0,-17])
rotate([0,225,0])
minkowski()
{
cube ([12,18,12], center=true);
cylinder(r=1.25,h=20,center=true);
}
translate([0,0,-60])
rotate([0,0,0])
cylinder(h = 70, r = D1, center = true);
translate([0,0,-38])
rotate([0,0,0])
cylinder(h = 60, r = D1-2, center = true);
translate([-11,-10,2.5])
scale(.22)
rotate([0,0,90])
import("Brand3.stl",convexity=3);
}