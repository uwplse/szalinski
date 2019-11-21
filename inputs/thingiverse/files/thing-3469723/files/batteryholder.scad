Battery_width=53;// [20:.5:150]
Battery_length=71;// [20:1:150]
Battery_height=5;// [3:1:15]
//Distance to center of charging pads from end of battery
First_wire_distance_from_end=9;// [2:.5:50]
Second_wire_distance_from_end=18;// [2:.5:50]
Wire_hole_size=2;// [1:1:3]
Pad_width=2;// [1:.5:3]
/* [Hidden] */
BW=Battery_width;
BL=Battery_length;
BH=Battery_height;
WH=Wire_hole_size/2;
FW=First_wire_distance_from_end;
SW=Second_wire_distance_from_end;
PW=Pad_width;

/*************************************************
 Battery holder

 Author: Lee J Brumfield

*************************************************/

$fn=200;

color ("coral")
{
translate([0,0,0])
rotate([0,180,180])
{
difference()
{
union()
{
translate([2,0,0])
cube([BL+10,BW+6,BH+3],center=true);
translate([(BL+7.5)/2,0,-(BH+3)/2-2+.1])
minkowski()
{
cube([2.5,BW+3,4],center=true);
rotate([90,9,0])
cylinder(h=3,r=2,center=true);
}
}
translate([0,0,-1.51])
cube([BL+1,BW+.5,BH+.2],center=true);
translate([-BL/2+1.5,0,-(BH+3)/2])
rotate([0,45,0])
cube([5,BW+.5,5],center=true);
translate([BL/2+.5-WH/2,BW/2-FW+.25,1.5])
rotate([0,0,0])
cylinder(h=BH+.1,r=WH,center=true);
translate([BL/2+.5-WH/2,BW/2-SW+.25,1.5])
rotate([0,0,0])
cylinder(h=BH+.1,r=WH,center=true);
translate([(BL+1)/2+7,BW/2-FW+.25,0])
rotate([0,0,0])
cylinder(h=BH+3.1,r=WH,center=true);
translate([(BL+1)/2+7,BW/2-SW+.25,0])
rotate([0,0,0])
cylinder(h=BH+3.1,r=WH,center=true);
hull()
{
translate([(BL+7.5)/2,BW/2-FW+.25,(BH+3)/2])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
translate([(BL+7.5)/2,BW/2-FW+.25,(BH+3)/2-WH])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
}
hull()
{
translate([(BL+7.5)/2,BW/2-SW+.25,(BH+3)/2])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
translate([(BL+7.5)/2,BW/2-SW+.25,(BH+3)/2-WH])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
}
translate([(BL+7.5)/2,BW/2-FW+.25,-(BH+3)/2])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
translate([(BL+7.5)/2,BW/2-SW+.25,-(BH+3)/2])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
translate([-(BL+1)/2-3,0,0])
rotate([0,0,0])
cylinder(h=BH+4,r=BW/5,center=true);
translate([0,0,(BH+3)/2])
rotate([0,0,-90])
scale(.2)
import("Brand3.stl",convexity=3);
cylinder(h=HT+1,r=ID,center=true);
}
difference()
{
union()
{
hull()
{
translate([BL/2+.5+WH,BW/2-FW+.25,-1.51])
cube([WH*2,WH*2.1,BH-WH*2],center=true);
translate([BL/2+.5+WH/2,BW/2-FW+.25,-1.51])
rotate([90,0,0])
cylinder(h=PW,r=WH,center=true);
}
hull()
{
translate([BL/2+.5+WH,BW/2-SW+.25,-1.51])
cube([WH*2,WH*2.1,BH-WH*2],center=true);
translate([BL/2+.5+WH/2,BW/2-SW+.25,-1.51])
rotate([90,0,0])
cylinder(h=PW,r=WH,center=true);
}
}
translate([BL/2+.5+WH/2,BW/2-FW+.25,-(BH+3)/2])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
translate([BL/2+.5+WH/2,BW/2-SW+.25,-(BH+3)/2])
rotate([0,90,0])
cylinder(h=6.51,r=WH,center=true);
}
}
}