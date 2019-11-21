// Which part would you like to see?
part = "3"; // [1:Handle Only,2:Base Only,3:Both]
Nail_hole_size=2.7;// [1:.1:5]
Bong_mode="yes";// [yes,no]

/* [Hidden] */
/**************************************
     Eyelet punch / awl / bong

      Author: Lee J Brumfield

**************************************/
HS=Nail_hole_size/2;
HB=Nail_hole_size+5.3;
HSP=(Nail_hole_size+23.3)/2;
HD=Nail_hole_size+1.4;
BD=Nail_hole_size+1.3;

print_part();

module print_part() 
{
if (part == "1")
{
handle();
} 
else if (part == "2")
{
base();
} 
else if (part == "3") 
{
both();
} 
}

module both() 
{
handle();
base();	
}

$fn=200;

module handle()
{
translate([0,0,-10])
{
color ("green")
{
difference()
{
union()
{
if (Bong_mode == "yes")
{
translate([12,0,0])
rotate([0,45,0])
cylinder(r=HD,h=20.1,center=true);
translate([0,0,-HSP*1.25+2])
rotate([0,0,0])
cylinder(r=HSP/1.25,h=4.1,center=true);
sphere(HSP*1.25);
}
else
translate([0,0,10])
cylinder(r=HB,h=10,center=true);
sphere(HSP);
}
if (Bong_mode == "yes")
{
sphere(HSP*1.25-2);
translate([12,0,0])
rotate([0,45,0])
cylinder(r=HS*2,h=22.1,center=true);
translate([0,10,0])
rotate([0,90,90])
cylinder(r=HS,h=22.1,center=true);
translate([0,0,-HSP*1.25])
rotate([0,180,270])
scale(.15)
import("Brand3.stl",convexity=3);
}
translate([0,0,10])
cylinder(r=HD,h=20.1,center=true);
}
}
}
}
module base()
{
translate([0,0,10])
{
color ("blue")
{
difference()
{
if (Bong_mode == "yes")
translate([0,0,14])
cylinder(r=BD,h=40,center=true);
else
translate([0,0,0])
cylinder(r=BD,h=30,center=true);
if (Bong_mode == "yes")
translate([0,0,14])
cylinder(r=HS*1.5,h=40.1,center=true);
else
translate([0,0,5])
cylinder(r=HS,h=20.1,center=true);
}
}
}
}
