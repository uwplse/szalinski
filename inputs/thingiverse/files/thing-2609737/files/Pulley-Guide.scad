/*
Created by David Taylor
http://bit.ly/Gineer

Based on some feedback I received on my 608 Idler Pulley with Stand (https://www.thingiverse.com/thing:155018) I thought it would be nice to add a Customiseable Guide for that model.

The idea is that you would pass the fillament (or what ever else) through the ring and it would then keep it centered on the pulley.
*/

//Guide Angle
GuideAngle=15;//[-15:15]
//Extend (or shorten) the Arm length
ArmLength=0;//[-5:20]
//Guide entrance diameter
GuideEntrance=1;//[1:7]
//Guide exit diameter
GuideExit=7;//[1:7]

/* [Hidden] */
fn=360;

difference()
{
    rotate([90,0,90])cylinder(h=5, r=5, center=true, $fn=fn);
    rotate([90,0,90])cylinder(h=6, r=3, center=true, $fn=fn);
}
difference()
{
    union()
    {
        translate([0,-(14+(ArmLength/2)),0])cube([5,(20+ArmLength),3], center=true);
        translate([1.5,-(25+ArmLength),0])cube([9.5,5,3], center=true);
    }
    translate([2.5,-(22.4+ArmLength),0])cutout();
}

translate([9.5,-(25+ArmLength),0])rotate([90+GuideAngle,0,0])difference()
{
    cylinder(h=6, d=8, center=true, $fn=fn);
    cylinder(h=6.1, d=GuideExit, d2=GuideEntrance, center=true, $fn=fn);
}

module cutout()
{
    translate([])difference()
    {
        cylinder(h=6, r=20, center=true, $fn=fn);
        cylinder(h=7, r=5, center=true, $fn=fn);
        translate([25,0,0])cube([50,50,7], center=true);
        translate([0,25,0])cube([50,50,7], center=true);
    }
}
