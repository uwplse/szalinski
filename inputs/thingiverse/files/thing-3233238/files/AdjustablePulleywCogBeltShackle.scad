/* [Global] */
// Which part would you like to see?
part = "both"; // [first:Pulley Only,second:Shackle Only,both:Pulley & Shackle]
/* [Cog settings] */
// Pulley diameter is calculated by the number of cogs and their width
Cogs="yes";// [yes,no]
Cog_width=2;// [1:.1:8]
Cog_Depth=2;// [1:.1:8]
Space_between_cogs=2;// [1:.1:8]
Number_of_cogs= 100    ;// [40:2:200]
/* [Pulley settings] */
Belt_width_top=20;// [1:.1:30]
Belt_width_bottom=18;// [1:.1:30]
Belt_depth=5;// [1:1:20]
Bearing="yes";// [yes,no]
Bearing_height=5   ;// [1:1:20]
Bearing_diameter=30;// [2:.1:120]
// Shaft diameter in pulley or hole size for bearing clearance
Shaft_diameter=24  ;// [2:.1:120]
// Edge of belt to outside of pulley
Edge_Thickness=2 ;// [2:1:10]
Spoke_Thickness=4;// [2:1:20]
// 12 if yes 8 if no
Twelve_spokes="yes";// [yes,no]
/* [Shackle settings] */
//Distance from the edge of pulley
Shackle_distance_from_pulley=2;// [1:1:30]
//Distance from the top of pulley
Shackle_distance_above_belt=44;// [1:1:50]
Shackle_mount_hole_size=10;// [2:1:25]
// Hole diameter in shackle
Shackle_shaft_hole_size=8;// [2:.1:25]
Shackle_width=25;// [2:1:120]
Shackle_mount_thickness=6;// [2:1:20]
Shackle_thickness=4;// [2:1:20]
/* [Keyway settings] */
Keyway="no";// [yes,no]
Key_height=2;// [.2:.1:10]
Key_width=2;// [.2:.1:10]
/* [Hidden] */
SMT=Shackle_mount_thickness;
SSS=Shackle_shaft_hole_size/2;
SHT=Shackle_thickness;
SHW=Shackle_width;
SHS=Shackle_mount_hole_size/2;
SDR=Shackle_distance_above_belt;
SDFP=Shackle_distance_from_pulley;
BD=Bearing_diameter/2;
BH=Bearing_height;
KH=Key_height;
KW=Key_width;
TS=Twelve_spokes;
SD=Shaft_diameter/2;
ST=Spoke_Thickness;
HTB=(Edge_Thickness*2)+Belt_width_top;
ET=Edge_Thickness;
BWT=Belt_width_top;
BWB=Belt_width_bottom;
PBD=Belt_depth;
CW=Cog_width;
CD=Cog_Depth;
SBC=Space_between_cogs;
NC=Number_of_cogs;
TOC=(NC*CW+(NC-1)*SBC)/PI/2;
PD=TOC+PBD-CD;
RA=360/NC;

/*************************************************
 Adjustable Cogged Belt Pulley w/Shackle

 Author: Lee J Brumfield

*************************************************/

print_part();

module print_part() 
{
if (part == "first")
{
Pulley();
} 
else if (part == "second") 
{
Shackle();
} 
else if (part == "both") 
{
both();
} 
}

module both() 
{
Pulley();
Shackle();	
}

$fn=200;

module Pulley() 
{
color ("silver")
{
difference()
{
cylinder(h=HTB,r=PD,center=true);
translate([0,0,-BWT/2])
rotate_extrude()
translate([PD+.05,0,0])
polygon(points=[[0,0],[-PBD,BWT/2-BWB/2],[-PBD,BWT/2-BWB/2+BWB],[0,BWT]]);
cylinder(h=HTB+.1,r=PD-PBD-ET*3,center=true);
}
if (Cogs == "yes")
{
difference()
{
for (i=[0:NC/2])
rotate([0,0,RA*i])
cube ([TOC*2,CW,HTB],center=true);
cylinder(h=HTB+.1,r=PD-PBD-ET*3,center=true);
}
}
difference()
{
union()
{
if (Bearing == "yes")
cylinder(h=HTB,r=BD+8,center=true);
else
cylinder(h=HTB,r=SD+8,center=true);
if (TS == "yes")
{
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,30])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,60])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,90])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,120])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,150])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
}
else
{
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,90])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,45])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
rotate([0,0,135])
cube ([PD*2-PBD*2-ET*6+.1,ST,HTB],center=true);
}
}
cylinder(h=HTB+.1,r=SD,center=true);
if (Bearing == "yes")
{
translate([0,0,HTB/2-BH/2])
cylinder(h=BH+.1,r=BD,center=true);
translate([0,0,-HTB/2+BH/2])
cylinder(h=BH+.1,r=BD,center=true);
}
if (Keyway == "yes")
translate([SD,0,0])
cube ([KH*2,KW,HTB+.1],center=true);
}
}
}

module Shackle()
{
color ("green")
{
difference()
{
union()
{
translate([(PD+SDR)/2,0,HTB/2+SDFP+SHT/2])
cube ([PD+SDR,SHW,SHT],center=true);
translate([0,0,HTB/2+SDFP+SHT/2])
cylinder(h=SHT,r=SHW/2,center=true);
translate([(PD+SDR)/2,0,-HTB/2-SDFP-SHT/2])
cube ([PD+SDR,SHW,SHT],center=true);
translate([0,0,-HTB/2-SDFP-SHT/2])
cylinder(h=SHT,r=SHW/2,center=true);
translate([PD+SDR+SMT/2,0,0])
cube ([SMT+.1,SHW,SHT*2+HTB+SDFP*2],center=true);
}
translate([PD+SDR+SMT/2,0,0])
rotate([0,90,0])
cylinder(h=SMT+.2,r=SHS,center=true);
cylinder(h=SHT*2+SDFP*2+HTB+.2,r=SSS,center=true);
if (SHW>24&&(SHT*2+HTB+SDFP*2)>54)
translate([PD+SDR+SMT,0,(SHT*2+HTB+SDFP*2)/3.5])
rotate([90,90,90])
scale(.2)
import("Brand3.stl",convexity=3);
}
}
}