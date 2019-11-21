// Which part would you like to see?
part = "9"; // [1:Enclosure,2:Pi Plate,3:Support,4:Cover,5:Sensor Cup,6:Sensor Cap,7:Enclosure & Support,8:Enclosure with Pi Plate & Support,9:All] 
Rod_diameter=8;//[4:.5:10]
Enclosure_wall_thickness=2.4;//[2:.1:5]
Cover_wall_thickness=2;//[2:.1:5]
// Do you want a hole for wire or a slot for a 90 degree angle micro USB (17x8mm)? 
Hole_USB="USB";//[Hole,USB]
Wire_entrance_hole_size=8;//[4:.5:16]
// Do you want a Vent in your Pi Plate?
Vent="yes";//[yes,no]
// Do you want a Sensor cup in your Pi Plate?
Sensor_cup="no";//[yes,no]
// Do you want 2 or 4 LED's in your Pi Plate?
2_or_4_LEDs="4";//[2,4]
// Do you want posts or holes to mount your Pi?
Posts_or_holes="Holes";//[Posts,Holes]
// Hivetool tophat needs 9.5mm shoulders instead of 3 for camera clearance
Hivetool_tophat="no";//[yes,no]
// Do you want a recess (18x24x3mm) for a DC/DC Converter in your Pi Plate?
D_Sun_DC_DC_Converter="no";//[yes,no]
// Do you want a holes out the bottom to power your DC/DC Converter in your Pi Plate?
Holes_out_bottom="yes";//[yes,no]
// Cover depth from the top of the Pi Plate (Minimum 27mm with Camera & plug in jumpers, 50mm for a Hivetool tophat)
Cover_depth=27;//[24:1:80]
Sensor_Cup_depth=40;//[30:1:45]
// Do you want to mount a TSL2591 Lux sensor in the cover?
TSL2591_mount="yes";//[yes,no]

/* [hidden] */

/*************************************************
          Pi Cam Enclosure
           For Beecounter
  
      Author: Lee J Brumfield

  Creative Commons -  Attribution - 
  Non-Commercial   - No Derivatives

*************************************************/

RD=Rod_diameter/2;
HS=Wire_entrance_hole_size/2;
CD=Cover_depth+7;
SD=Sensor_Cup_depth;
WT=Enclosure_wall_thickness;
CWT=Cover_wall_thickness;

print_part();

module print_part() 
{
if (part == "1")
{
Enc();
} 
else if (part == "2") 
{
PiPlate();
} 
else if (part == "3") 
{
Support();
}
else if (part == "4") 
{
Cover();
}
else if (part == "5") 
{
SensorCup();
}
else if (part == "6") 
{
SensorCap();
}
else if (part == "7") 
{
Some();
}
else if (part == "8") 
{
Most();
}
else if (part == "9") 
{
All();
}

module Some()
{
Enc();	
Support();
Rods();
SensorCup();
}

module Most()
{
Enc();
PiPlate();	
Support();
Rods();
SensorCup();
SensorCap();
}

module All() 
{
Enc();
PiPlate();	
Support();
Cover();
Rods();
SensorCup();
SensorCap();
}

$fn=200;

module Enc() 
{
color ("blue")
{
translate([0,0,0])
rotate([0,0,0])
{
difference()
{
union()
{
hull()
{
translate([90,-28,,-66])
cylinder(h=10,r=RD+WT,center=true);
translate([88-2*RD-4,-28,,-65])
cube ([1,RD*6,12],center=true);
}
hull()
{
translate([90,28,,-66])
cylinder(h=10,r=RD+WT,center=true);
translate([88-2*RD-4,28,,-65])
cube ([1,RD*6,12],center=true);
}
translate([0,0,83])
minkowski()
{
cube ([14,71,10],center=true);
cylinder(h=2,r=4,center=true);
}
hull()
{
translate([0,0,-70])
minkowski()
{
cube ([154,154,1],center=true);
cylinder(h=1,r=4+WT,center=true);
}
translate([0,0,85])
minkowski()
{
cube ([6,63,.1],center=true);
cylinder(h=.1,r=4+WT,center=true);
}
}
}
translate([90,-28,8.5])
cylinder(h=155,r=RD+.2,center=true);
translate([90,28,8.5])
cylinder(h=155,r=RD+.2,center=true);
translate([45,0,89])
minkowski()
{
cube ([100,67,2],center=true);
cylinder(h=2,r=4.2,center=true);
}
hull()
{
translate([0,0,-70])
minkowski()
{
cube ([154,154,1],center=true);
cylinder(h=1.1,r=4,center=true);
}
translate([0,0,85])
minkowski()
{
cube ([6,63,1],center=true);
cylinder(h=1.1,r=4,center=true);
}
}
translate([0,0,85])
minkowski()
{
cube ([4,59,4],center=true);
cylinder(h=1.1,r=4,center=true);
}
}
difference()
{
union()
{
translate([0,0,-70])
minkowski()
{
cube ([180,180,1],center=true);
cylinder(h=1,r=4,center=true);
}
translate([8.5,-28,89])
cylinder(h=4.01,r=2.3,center=true);
translate([8.5,28,89])
cylinder(h=4.01,r=2.3,center=true);
}
translate([88,88,-70])
cylinder(h=2.1,r=2,center=true);
translate([-88,88,-70])
cylinder(h=2.1,r=2,center=true);
translate([88,-88,-70])
cylinder(h=2.1,r=2,center=true);
translate([-88,-88,-70])
cylinder(h=2.1,r=2,center=true);
translate([0,0,-70])
minkowski()
{
cube ([154,154,1],center=true);
cylinder(h=1.1,r=4,center=true);
}
}
}
}
}

module PiPlate() 
{
color ("green")
{
translate([0,0,0])
rotate([0,0,0])
{
difference()
{
union()
{
translate([45,0,89])
minkowski()
{
cube ([100,67,2],center=true);
cylinder(h=2,r=4,center=true);
}
if (Hivetool_tophat=="yes")
{
translate([13,33,95.7])
cylinder(h=9.5,r1=4,r2=3,center=true);
translate([13,-16,95.7])
cylinder(h=9.5,r1=4,r2=3,center=true);
translate([71,33,95.7])
cylinder(h=9.5,r1=4,r2=3,center=true);
translate([71,-16,95.7])
cylinder(h=9.5,r1=4,r2=3,center=true);
}
else
{
translate([13,33,92.45])
cylinder(h=3,r=3,center=true);
translate([13,-16,92.45])
cylinder(h=3,r=3,center=true);
translate([71,33,92.45])
cylinder(h=3,r=3,center=true);
translate([71,-16,92.45])
cylinder(h=3,r=3,center=true);
}
if (Posts_or_holes=="Posts")
{
translate([13,33,94])
cylinder(h=4,r=1.3,center=true);
translate([13,-16,94])
cylinder(h=4,r=1.3,center=true);
translate([71,33,94])
cylinder(h=4,r=1.3,center=true);
translate([71,-16,94])
cylinder(h=4,r=1.3,center=true);
}
translate([0,0,91.25])
cylinder(h=2,r=9,center=true);
}
if (Posts_or_holes=="Holes")
{
translate([13,33,96])
cylinder(h=12,r=1.3,center=true);
translate([13,-16,96])
cylinder(h=12,r=1.3,center=true);
translate([71,33,96])
cylinder(h=12,r=1.3,center=true);
translate([71,-16,96])
cylinder(h=12,r=1.3,center=true);
}
if (Hivetool_tophat=="yes")
translate([30,-24,90])
cylinder(h=10,r=9.5,center=true);
if (Hole_USB=="Hole"&&Hivetool_tophat=="no")
translate([97-HS-22,-38+HS+3,90])
cylinder(h=10,r=HS,center=true);
if (Hole_USB=="USB")
translate([68,-28,89])
cube ([17,8,4.1],center=true);
if (D_Sun_DC_DC_Converter=="yes"&&Hivetool_tophat=="no")
{
translate([35,-26,89.46])
minkowski()
{
cube ([22,16,2.1],center=true);
cylinder(h=1,r=1,center=true);
}
hull()
{
translate([12,-26,90.71])
cylinder(h=.6,r=.5,center=true);
translate([21,-26,90.71])
cylinder(h=.6,r=.5,center=true);
}
hull()
{
translate([19,-28,90.71])
cylinder(h=.6,r=.5,center=true);
translate([21,-26,90.71])
cylinder(h=.6,r=.5,center=true);
}
hull()
{
translate([19,-24,90.71])
cylinder(h=.6,r=.5,center=true);
translate([21,-26,90.71])
cylinder(h=.6,r=.5,center=true);
}
hull()
{
translate([49,-19.4,90.71])
cylinder(h=.6,r=.5,center=true);
translate([53,-19.4,90.71])
cylinder(h=.6,r=.5,center=true);
}
hull()
{
translate([49,-32.6,90.71])
cylinder(h=.6,r=.5,center=true);
translate([53,-32.6,90.71])
cylinder(h=.6,r=.5,center=true);
}
hull()
{
translate([51,-30.6,90.71])
cylinder(h=.6,r=.5,center=true);
translate([51,-34.6,90.71])
cylinder(h=.6,r=.5,center=true);
}
}
if (Holes_out_bottom=="yes"&&D_Sun_DC_DC_Converter=="yes"&&Hivetool_tophat=="no")
{
translate([25.229,-19.4,89])
cylinder(h=4.1,r=1,center=true);
translate([25.229,-32.6,89])
cylinder(h=4.1,r=1,center=true);
}
translate([0,0,90])
cylinder(h=8,r=5,center=true);
translate([0,0,92.75])
cylinder(h=10,r=7.2,center=true);
translate([0,-28,89])
cylinder(h=5,r=2.55,center=true);
translate([0,28,89])
cylinder(h=5,r=2.55,center=true);
translate([0,-28,91])
cylinder(h=5,r=4.55,center=true);
translate([0,28,91])
cylinder(h=5,r=4.55,center=true);
if (2_or_4_LEDs=="4")
{
translate([0,-15,89])
cylinder(h=5,r=2.55,center=true);
translate([0,15,89])
cylinder(h=5,r=2.55,center=true);
translate([0,-15,91])
cylinder(h=5,r=4.55,center=true);
translate([0,15,91])
cylinder(h=5,r=4.55,center=true);
}
translate([8.5,-28,89])
cylinder(h=5,r=2.5,center=true);
translate([8.5,28,89])
cylinder(h=5,r=2.5,center=true);
translate([90,-28,89])
cylinder(h=4.01,r=2.5,center=true);
translate([90,28,89])
cylinder(h=4.01,r=2.5,center=true);
if (Sensor_cup=="yes")
{
translate([60,3,89])
cylinder(h=5,r=15.2,center=true);
translate([60,3,90])
cylinder(h=2.2,r=18.2,center=true);
}
if (Vent=="yes"&&Sensor_cup=="no")
translate([44,8.5,89])
cylinder(h=5,r=21,center=true);
if (Vent=="yes"&&Sensor_cup=="yes")
translate([26,8.5,89])
cylinder(h=5,r=14,center=true);
}
if (Vent=="yes"&&Sensor_cup=="no")
{
difference()
{
translate([44,8.5,89])
cylinder(h=4,r=21.1,center=true);
translate([63.5,-24.5,89])
{
for (i=[0:7])
translate([-i*7.8,0,0])
{
translate([3.9,0,0])
for (i=[0:12]) 
{
translate([0,i*4.7,0])
cylinder(h=5+.1,r=2,$fn=6,center=true);
}
}
for (i=[0:7])
translate([-i*7.8,0,0])
{
translate([0,2.4,0])
for (i=[0:12]) 
{
translate([0,i*4.7,0])
cylinder(h=5.1,r=2,$fn=6,center=true);
}
}
}
}
}
if (Vent=="yes"&&Sensor_cup=="yes")
difference()
{
translate([26,8.5,89])
cylinder(h=4,r=14.1,center=true);
translate([63.5,-24.5,89])
{
for (i=[0:7])
translate([-i*7.8,0,0])
{
translate([3.9,0,0])
for (i=[0:12]) 
{
translate([0,i*4.7,0])
cylinder(h=5+.1,r=2,$fn=6,center=true);
}
}
for (i=[0:7])
translate([-i*7.8,0,0])
{
translate([0,2.4,0])
for (i=[0:12]) 
{
translate([0,i*4.7,0])
cylinder(h=5.1,r=2,$fn=6,center=true);
}
}
}
}
}
}
}

module Support() 
{
color ("orange")
{
translate([0,0,0])
rotate([0,0,0])
{
difference()
{
translate([90,0,85])
minkowski()
{
cube ([14,71,6],center=true);
cylinder(h=2,r=4,center=true);
}
translate([45,0,89])
minkowski()
{
cube ([100,67,2],center=true);
cylinder(h=1.9,r=4.2,center=true);
}
translate([90,-28,8.5])
cylinder(h=155,r=RD+.2,center=true);
translate([90,28,8.5])
cylinder(h=155,r=RD+.2,center=true);
}
translate([90,-28,89])
cylinder(h=4.01,r=2.3,center=true);
translate([90,28,89])
cylinder(h=4.01,r=2.3,center=true);
}
}
}
}

module Cover() 
{
color ("red")
{
translate([0,0,0])
rotate([0,0,0])
{
difference()
{
union()
{
translate([45,0,85+CD/2])
minkowski()
{
cube ([100,67,CD/2],center=true);
cylinder(h=CD/2,r=CWT+4.2,center=true);
}
translate([90,0,85+CD/2])
minkowski()
{
cube ([14,71,CD/2],center=true);
cylinder(h=CD/2,r=CWT+4.2,center=true);
}
translate([0,0,85+CD/2])
minkowski()
{
cube ([14,71,CD/2],center=true);
cylinder(h=CD/2,r=CWT+4.2,center=true);
}
}
if (TSL2591_mount=="yes")
translate([45,0,83.5+CD])
minkowski()
{
cube ([15,18,1.1], center=true);
cylinder(r=1.25,h=2,center=true);
}
translate([45,0,82+CD/2])
minkowski()
{
cube ([100,67,CD/2],center=true);
cylinder(h=CD/2,r=4.2,center=true);
}
translate([90,0,86])
minkowski()
{
cube ([14,71,4],center=true);
cylinder(h=1.99,r=4.2,center=true);
}
translate([0,0,86])
minkowski()
{
cube ([14,71,4],center=true);
cylinder(h=2,r=4.2,center=true);
}
translate([17.5,0,87])
cube ([5,80,4.1],center=true);
translate([70,0,87])
cube ([5,80,4.1],center=true);
}
if (TSL2591_mount=="yes")
{
difference()
{
hull()
{
translate([45,0,81.5+CD])
minkowski()
{
cube ([19,22,2], center=true);
cylinder(r=1.25,h=2,center=true);
}
translate([45,0,82+CD])
minkowski()
{
cube ([23,26,1], center=true);
cylinder(r=1.25,h=1,center=true);
}
}
translate([50,0,82+CD])
minkowski()
{
cube ([1,18,4.1], center=true);
cylinder(r=1.25,h=2,center=true);
}
translate([45,0,83+CD])
minkowski()
{
cube ([15,18,2.1], center=true);
cylinder(r=1.25,h=2,center=true);
}
}
translate([77,0,82.5+CD])
rotate([0,180,270])
scale([.4,.4,.5])
import("Brand3.stl", convexity=3, center=true);
}
else
translate([45,0,82.5+CD])
rotate([0,180,270])
scale([.5,.5,.5])
import("Brand3.stl", convexity=3, center=true);
}
}
}

// Don't make these use steel rods or whatever.................... this is just for show

module Rods() 
{
color ("silver")
{
translate([0,0,0])
rotate([0,0,0])
{
translate([90,-28,8.5])
cylinder(h=155,r=RD,center=true);
translate([90,28,8.5])
cylinder(h=155,r=RD,center=true);
}
}
}

module SensorCup() 
{
color ("purple")
{
if (Sensor_cup=="yes")
{
translate([0,0,0])
rotate([0,0,0])
{
difference()
{
union()
{
translate([60,3,90-SD/2])
cylinder(h=SD,r=15,center=true);
translate([60,3,90])
cylinder(h=2,r=18,center=true);
}
translate([60,3,90])
cylinder(h=3,r=4,center=true);
translate([60,3,89-SD/2])
cylinder(h=SD,r=13.5,center=true);
for (i=[0:4])
translate([60,3,-5])
rotate([0,0,i*45])
{
translate([0,0,94-SD/4-SD/8])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2-SD/8])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/4])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2-SD/4])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
}
for (i=[0:4])
translate([60,3,-2])
rotate([0,0,i*45+22.5])
{
translate([0,0,94-SD/4-SD/8])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2-SD/8])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/4])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2-SD/4])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
translate([0,0,94-SD/2])
rotate([0,90,0])
cylinder(h=32,r=2,$fn=6,center=true);
}
}
}
}
}
}

module SensorCap() 
{
color ("purple")
{
if (Sensor_cup=="yes")
{
translate([0,0,0])
rotate([0,0,0])
{
difference()
{
union()
{
translate([60,3,92-SD])
cylinder(h=9,r=16.5,center=true);
}
translate([60,3,89-SD/2])
cylinder(h=SD,r=15,center=true);
translate([60,3,94-SD])
cylinder(h=13,r=13.5,center=true);
}
difference()
{
union()
{
translate([60,3,88-SD])
cylinder(h=1.5,r=13.5,center=true);
}
translate([77.5,-18,89-SD])
{
for (i=[0:4])
translate([-i*7.8,0,0])
{
translate([3.9,0,0])
for (i=[0:7]) 
{
translate([0,i*4.7,0])
cylinder(h=5+.1,r=2,$fn=6,center=true);
}
}
for (i=[0:4])
translate([-i*7.8,0,0])
{
translate([0,2.4,0])
for (i=[0:7]) 
{
translate([0,i*4.7,0])
cylinder(h=5.1,r=2,$fn=6,center=true);
}
}
}
}
}
}
}
}