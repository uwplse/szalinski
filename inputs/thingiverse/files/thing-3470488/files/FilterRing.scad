Outside_diameter=80;// [40:.5:300]
//Depth of filter media
Filter_ring_depth=10;// [5:1:60]
Filter_ring_thickness=1.5;// [1:.5:5]
Lip_on_outside="yes";// [yes,no]


/* [Hidden] */
LO=Lip_on_outside;
OD=Outside_diameter/2;
FRD=Filter_ring_depth;
FRT=Filter_ring_thickness;
/*************************************************
  Filter holder

 Author: Lee J Brumfield

*************************************************/
$fn=200;

color ("green")
{
difference()
{
union()
{
translate([0,0,0])
cylinder(h=FRD+FRT,r=OD,center=true);
if (LO == "yes")
{
translate([0,0,(FRD+FRT)/2-FRT/4])
cylinder(h=FRT/2,r=OD+FRT,center=true);
translate([0,0,(FRD+FRT)/2-FRT/2-FRT/4])
cylinder(h=FRT/2,r1=OD,r2=OD+FRT,center=true);
}
}
translate([0,0,0])
cylinder(h=FRD+FRT+.1,r=OD-FRT,center=true);
}
difference()
{
translate([0,0,-(FRD+FRT)/2+FRT/2])
cylinder(h=FRT,r=OD/1.3,center=true);
translate([0,0,-(FRD+FRT)/2+FRT/2])
cylinder(h=FRT+.1,r=OD/1.3-FRT,center=true);
}
difference()
{
translate([0,0,-(FRD+FRT)/2+FRT/2])
cylinder(h=FRT,r=OD/2,center=true);
translate([0,0,-(FRD+FRT)/2+FRT/2])
cylinder(h=FRT+.1,r=OD/2-FRT,center=true);
}
difference()
{
union()
{
translate([0,0,-(FRD+FRT)/2+FRT/2])
rotate([0,0,0])
cube([FRT,OD*2-FRT/2,FRT],center=true);
translate([0,0,-(FRD+FRT)/2+FRT/2])
rotate([0,0,45])
cube([FRT,OD*2-FRT/2,FRT],center=true);
translate([0,0,-(FRD+FRT)/2+FRT/2])
rotate([0,0,90])
cube([FRT,OD*2-FRT/2,FRT],center=true);
translate([0,0,-(FRD+FRT)/2+FRT/2])
rotate([0,0,135])
cube([FRT,OD*2-FRT/2,FRT],center=true);
translate([0,0,-(FRD+FRT)/2+FRT/2])
cylinder(h=FRT,r=OD/5,center=true);
}
translate([0,0,-(FRD+FRT)/2+FRT/2])
cylinder(h=FRT+10,r=OD/5-FRT,center=true);
}
}

