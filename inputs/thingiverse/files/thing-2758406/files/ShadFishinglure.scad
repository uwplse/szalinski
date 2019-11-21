/*************************************************
 Fishing Lure W/ adjustable diving capability

 Author: Lee J Brumfield

*************************************************/


Pectoral_Fin_height=3;//[2,3,4,5]
Pectoral_Fin_width=9;//[7:12]
Pectoral_Fin_length=10;//[3:10]
Pectoral_Fin_attack_angle_degrees=30;//[10:90]
Pectoral_Fin_sweep_back_degrees=30;//[10:60]
Wire_Hole=3;//[1,2,3,4,5]


/* [Hidden] */
WH=(Wire_Hole/2);
R=(360-Pectoral_Fin_attack_angle_degrees);
H=(Pectoral_Fin_height/10);
W=(Pectoral_Fin_width/10);
L1=(Pectoral_Fin_length/5);
SB1=(Pectoral_Fin_sweep_back_degrees);
SB2=(360-Pectoral_Fin_sweep_back_degrees);

difference()
{
union()
{

color("silver")
{

// Back of body

translate([-12,0,4.35])
rotate([0,10,0])
scale([7.5,1.7,2.5])
sphere(7,$fn=45);
translate([10,0,0])
scale([5,.8,1.2])
sphere(10,$fn=45);
translate([14,0,0])
scale([5,.7,1.2])
sphere(10,$fn=45);
translate([-12,0,-11])
rotate([0,342,0])
scale([6.7,1.7,2.5])
sphere(7,$fn=45);

// Head

translate([-61,5.,1])
rotate([2,4,8])
scale([3.5,1,3])
sphere(6,$fn=45);
translate([-61,-5,1])
rotate([358,356,352])
scale([3.5,1,3])
sphere(6,$fn=45);
translate([-69,4.3,2])
rotate([3,16,16])
scale([3,1,2.4])
sphere(6,$fn=45);
translate([-69,-4.3,2])
rotate([357,16,344])
scale([3,1,2.4])
sphere(6,$fn=45);
translate([-75,0,12])
rotate([0,330,0])
scale([2.1,1,.8])
sphere(6,$fn=45);
translate([-42,0,15])
rotate([0,1,0])
scale([2.5,.9,1])
sphere(10,$fn=45);

// Gill plates

translate([-57,5.5,1])
rotate([2,15,20])
scale([3.5,1,3])
sphere(6,$fn=45);
translate([-57,-5.5,1])
rotate([355,15,340])
scale([3.5,1,3])
sphere(6,$fn=45);

// Belly

translate([-33,0,0])
scale([3,1.15,2])
sphere(12,$fn=45);
translate([-58,0,-13])
rotate([0,35,0])
scale([3,.8,1.3])
sphere(10,$fn=45);
translate([-48,0,11])
rotate([0,351,0])
scale([3.5,.9,1.3])
sphere(10,$fn=45);
}

color("gray")
{

// Dorsal Fins

translate([-22,0,19])
rotate([0,300,0])
scale([2,.2,1.1])
sphere(12,$fn=100);

// Anal fin

translate([13,0,-19])
rotate([0,337,0])
scale([2.2,.2,.7])
sphere(10,$fn=100);

// Pectoral fins

translate([-44,10,-17])
rotate([0,R,SB2])
scale([W,L1,H])
sphere(10,$fn=100);
translate([-44,-10,-17])
rotate([0,R,SB1])
scale([W,L1,H])
sphere(10,$fn=100);

// Pelvic fins

translate([-26,4,-29])
rotate([315,315,0])
scale([.75,1,.2])
sphere(10,$fn=100);
translate([-26,-4,-29])
rotate([45,315,0])
scale([.75,1,.2])
sphere(10,$fn=100);
}

color("seagreen")
{

// Mouth

translate([-50,0,-7])
scale([2,1,.3])
sphere(9,$fn=100);
rotate([0,-4,0])
translate([-43,0,-5])
scale([2.5,1,.3])
sphere(10,$fn=100);
}

color("white")
{

// Eyes

rotate([10,0,8])
translate([-68,17,2])
scale([1.2,.5,1])
sphere(8,$fn=100);
rotate([350,0,352])
translate([-68,-17,2])
scale([1.2,.5,1])
sphere(8,$fn=100);
}

color("black")
{

// Eyes pupil

translate([-72,9,5.3])
rotate([10,0,8])
scale([1.3,.5,1])
sphere(4,$fn=100);
translate([-72,-9,5.3])
rotate([350,0,352])
scale([1.3,.5,1])
sphere(4,$fn=100);
}
}

color("silver")
{

// Flatten the head

translate([-70,0,-20])
rotate([0,35,0])
cube([60,20,10],center=true);

// Cutout back of tail

translate([63,-4,-2])
rotate([0,0,315])
cube([10,10,30],center=true);
translate([63,4,-2])
rotate([0,0,45])
cube([10,10,30],center=true);
}

color("gray")
{

// Cutout Dorsal Fins


translate([-4,0,32])
rotate([0,30,0])
scale([1,.4,1.5])
sphere(8,$fn=100);

// Cutout Anal fin

translate([33,0,-16.7])
rotate([0,340,0])
cube([6,5,10],center=true);
}

color("brown")
{

// Wire raceway for hook

translate([-30,0,-16])
rotate([0,265.5,0])
cylinder(h=126,r=WH,$fn=100,center=true);

 // Wire raceway for hook

translate([-76,0,-17])
rotate([0,281,0])
cylinder(h=140,r=WH,$fn=100,center=true);

// Brand

translate([-68.1,4.5,-15])
rotate([325,180,90])
scale(.1,.1,1)
import("brand.stl",center=true,convexity=3);
}
}
difference()
{

color("gray")
{

// Tail

hull()
{
translate([85,0,0])
scale([1.5,.15,2])
sphere(13,$fn=100);
translate([60,0,0])
scale([1.5,.3,2])
sphere(3,$fn=100);
}
}

color("gray")
{

// Cutout back of tail

translate([144,0,0])
scale([6,.5,3])
sphere(12,$fn=100);
}
}