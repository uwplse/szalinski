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

color("gold")
{

// Top of head

translate([-22,0,4])
scale([5,2,3])
sphere(6,$fn=45);

// Top of head

translate([-27,00,2.5])
scale([2.5,1.25,2])
sphere(10,$fn=45);

// Back of body

translate([-2,0,4.35])
rotate([0,10,0])
scale([7.5,1.7,2.5])
sphere(6,$fn=45);
translate([10,0,0])
scale([5,.8,1.2])
sphere(10,$fn=45);

// Caudal fin

translate([31,0,0])
scale([4,.4,.3])
sphere(10,$fn=45);

// Lateral line head

translate([-28,0,-1])
scale([3,1.25,2])
sphere(10,$fn=45);

// Belly

translate([-21,0,-1.5])
rotate([0,-8,0])
scale([4.5,1.2,2])
sphere(10,$fn=100);
}

color("darkgreen")
{

// Dorsal Fins

rotate([0,-15,0])
translate([-8,0,19])
scale([2,.2,1.1])
sphere(12,$fn=100);

// Adipose Fin

rotate([0,-30,0])
translate([30,0,-9])
scale([1,.2,.5])
sphere(10,$fn=100);

// Anal fin

rotate([0,10,0])
translate([12,0,-5])
scale([1.5,.2,1.1])
sphere(10,$fn=100);

// Pectoral fins

translate([-30,8,-10])
rotate([0,R,SB2])
scale([W,L1,H])
sphere(10,$fn=100);
translate([-30,-8,-10])
rotate([0,R,SB1])
scale([W,L1,H])
sphere(10,$fn=100);

// Pelvic fins

translate([-6,7,-13.5])
rotate([345,345,345])
scale([.75,1,.2])
sphere(10,$fn=100);
translate([-6,-7,-13.5])
rotate([15,345,15])
scale([.75,1,.2])
sphere(10,$fn=100);
}

color("lime")
{

// Tail

hull()
{
translate([75,0,4])
scale([1.5,.15,2.2])
sphere(12,$fn=100);
translate([30,0,-2])
scale([1.5,.3,2])
sphere(3,$fn=100);
}
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
translate([-30,14,7])
scale([1.2,.5,1])
sphere(8,$fn=100);
rotate([350,0,352])
translate([-30,-14,7])
scale([1.2,.5,1])
sphere(8,$fn=100);
}

color("black")
{

// Eyes pupil

translate([-32,10.7,10.5])
rotate([10,0,8])
scale([1.3,.5,1])
sphere(4,$fn=100);
translate([-32,-10.7,10.5])
rotate([350,0,352])
scale([1.3,.5,1])
sphere(4,$fn=100);
}
}

// Wire raceway for hook

translate([-44.6,0,-2])
rotate([0,290,0])
cylinder(h=100,r=WH,$fn=100,center=true);

// Wire raceway for hook

translate([-30,0,-2])
rotate([0,-81,0])
cylinder(h=130,r=WH,$fn=100,center=true);

color("lime")
{

// Cutout back of tail

translate([85,0,4])
scale([1,.5,2])
sphere(12,$fn=100);
}

color("gold")
{

// Flatten the head

translate([-60,0,5])
rotate([0,132,0])
cube([60,20,10],center=true);
}
{
color("brown")
{
// Brand
translate([-53.05,4.7,5])
rotate([228,180,90])
scale(.1,.1,1)
import("brand.stl",center=true,convexity=3);

// Ribs on tail

translate([71,1,25])
rotate([0,-29,0])
cube([64.5,.75,1],center=true);
translate([71,1.1,21])
rotate([0,-25.5,.5])
cube([56.5,.75,1],center=true);
translate([71,1.2,18])
rotate([0,-24,1])
cube([50,.75,1],center=true);
translate([71,1.3,15])
rotate([0,-22,.5])
cube([43,.75,1],center=true);
translate([72,1.4,12])
rotate([0,-20,.7])
cube([37.5,.75,1],center=true);
translate([73,1.45,9])
rotate([0,-18,1])
cube([34,.75,1],center=true);
translate([74,1.5,6])
rotate([0,-16,1])
cube([30,.75,1],center=true);
translate([78,1.6,3.5])
rotate([0,-12,.7])
cube([24,.75,1],center=true);
translate([80,1.75,0])
rotate([0,0,1])
cube([22,.75,1],center=true);
translate([78,1.6,-3.5])
rotate([0,12,.7])
cube([24,.75,1],center=true);
translate([75,1.5,-6])
rotate([0,13,1])
cube([34.5,.75,1],center=true);
translate([74,1.3,-9])
rotate([0,14,.4])
cube([37.5,.75,1],center=true);
translate([72,1.2,-12])
rotate([0,15,1])
cube([41,.75,1],center=true);
translate([71,.9,-15])
rotate([0,16,0])
cube([50,.75,1],center=true);
translate([71,.8,-18])
rotate([0,17,0])
cube([60,.75,1],center=true);
translate([71,-1,25])
rotate([0,-29,0])
cube([64.5,.75,1],center=true);
translate([71,-1.1,21])
rotate([0,-25.5,359.5])
cube([56.5,.75,1],center=true);
translate([71,-1.2,18])
rotate([0,-24,359])
cube([50,.75,1],center=true);
translate([71,-1.3,15])
rotate([0,-22,359.5])
cube([43,.75,1],center=true);
translate([72,-1.4,12])
rotate([0,-20,359.3])
cube([37.5,.75,1],center=true);
translate([73,-1.45,9])
rotate([0,-18,359])
cube([34,.75,1],center=true);
translate([74,-1.5,6])
rotate([0,-16,359])
cube([30,.75,1],center=true);
translate([78,-1.6,3.5])
rotate([0,-12,359.3])
cube([24,.75,1],center=true);
translate([80,-1.75,0])
rotate([0,0,-1])
cube([22,.75,1],center=true);
translate([78,-1.6,-3.5])
rotate([0,12,359.3])
cube([24,.75,1],center=true);
translate([75,-1.5,-6])
rotate([0,13,359])
cube([34.5,.75,1],center=true);
translate([74,-1.3,-9])
rotate([0,14,359.6])
cube([37.5,.75,1],center=true);
translate([72,-1.2,-12])
rotate([0,15,359])
cube([41,.75,1],center=true);
translate([71,-.9,-15])
rotate([0,16,0])
cube([50,.75,1],center=true);
translate([71,-.8,-18])
rotate([0,17,0])
cube([60,.75,1],center=true);

// Ribs on Dorsal fin

translate([-21,-1.2,26])
rotate([0,-45,3])
cube([10,1.5,1],center=true);
translate([-18,-1.3,26])
rotate([0,-45,4])
cube([10,1.5,1],center=true);
translate([-15,-1.45,26])
rotate([0,-45,5])
cube([11,1.5,1],center=true);
translate([-12,-1.5,26])
rotate([0,-45,6])
cube([12,1.5,1],center=true);
translate([-9,-1.55,26])
rotate([0,-45,7])
cube([13,1.5,1],center=true);
translate([-6,-1.6,26])
rotate([0,-45,8])
cube([14,1.5,1],center=true);
translate([-3,-1.6,26])
rotate([0,-45,8])
cube([15,1.5,1],center=true);
translate([0,-1.4,26])
rotate([0,-45,8])
cube([16,1.5,1],center=true);
translate([3,-1.3,26])
rotate([0,-45,8])
cube([17,1.5,1],center=true);
translate([6,-1.2,26])
rotate([0,-45,8])
cube([19,1.5,1],center=true);
translate([9,-1,26])
rotate([0,-45,8])
cube([20,1.5,1],center=true);
translate([12,-.7,26])
rotate([0,-45,8])
cube([21,1.5,1],center=true);
translate([15,-1.8,26])
rotate([0,-45,8])
cube([22,1.5,1],center=true);
translate([-21,1.2,26])
rotate([0,-45,-3])
cube([10,1.5,1],center=true);
translate([-18,1.3,26])
rotate([0,-45,-4])
cube([10,1.5,1],center=true);
translate([-15,1.45,26])
rotate([0,-45,-5])
cube([11,1.5,1],center=true);
translate([-12,1.5,26])
rotate([0,-45,-6])
cube([12,1.5,1],center=true);
translate([-9,1.55,26])
rotate([0,-45,-7])
cube([13,1.5,1],center=true);
translate([-6,1.6,26])
rotate([0,-45,-8])
cube([14,1.5,1],center=true);
translate([-3,1.6,26])
rotate([0,-45,-8])
cube([15,1.5,1],center=true);
translate([0,1.4,26])
rotate([0,-45,-8])
cube([16,1.5,1],center=true);
translate([3,1.3,26])
rotate([0,-45,-8])
cube([17,1.5,1],center=true);
translate([6,1.2,26])
rotate([0,-45,-8])
cube([19,1.5,1],center=true);
translate([9,1,26])
rotate([0,-45,-8])
cube([20,1.5,1],center=true);
translate([12,.7,26])
rotate([0,-45,-8])
cube([21,1.5,1],center=true);
translate([15,1.8,26])
rotate([0,-45,-8])
cube([22,1.5,1],center=true);

// Ribs on anal fin

translate([6,-1.1,-16])
rotate([0,60,8])
cube([2.5,1.5,1],center=true);
translate([9,-1.2,-16])
rotate([0,60,8])
cube([5,1.5,1],center=true);
translate([12,-1.2,-16])
rotate([0,60,8])
cube([7.5,1.5,1],center=true);
translate([15,-1.2,-16])
rotate([0,60,8])
cube([8,1.5,1],center=true);
translate([18,-1.2,-16])
rotate([0,60,8])
cube([8,1.5,1],center=true);
translate([21,-1.2,-16])
rotate([0,60,8])
cube([8,1.5,1],center=true);
translate([24,-1.1,-16])
rotate([0,60,8])
cube([8.6,1.5,1],center=true);
translate([6,1.1,-16])
rotate([0,60,-8])
cube([2.5,1.5,1],center=true);
translate([9,1.2,-16])
rotate([0,60,-8])
cube([5,1.5,1],center=true);
translate([12,1.2,-16])
rotate([0,60,-8])
cube([7.5,1.5,1],center=true);
translate([15,1.2,-16])
rotate([0,60,-8])
cube([8,1.5,1],center=true);
translate([18,1.2,-16])
rotate([0,60,-8])
cube([8,1.5,1],center=true);
translate([21,1.2,-16])
rotate([0,60,-8])
cube([8,1.5,1],center=true);
translate([24,1.1,-16])
rotate([0,60,-8])
cube([8.6,1.5,1],center=true);

// Ribs on Adipose Fin

translate([35,-1.4,13])
rotate([0,-22.5,6])
cube([9,1.5,1],center=true);
translate([40,-1.3,13])
rotate([0,-22.5,6])
cube([12,1.5,1],center=true);
translate([35,1.4,13])
rotate([0,-22.5,-6])
cube([9,1.5,1],center=true);
translate([40,1.3,13])
rotate([0,-22.5,-6])
cube([12,1.5,1],center=true);

// Ribs on Pelvic fins

rotate([339,345,345])
translate([-15,14,-6.75])
cube([1.5,9.8,1],center=true);
rotate([339,345,345])
translate([-12,14,-6.45])
cube([1.5,8,1],center=true);
rotate([339,345,345])
translate([-9,14,-6.3])
cube([1.5,6.2,1],center=true);
rotate([339,345,345])
translate([-6,14,-6.5])
cube([1.5,5,1],center=true);
rotate([21,345,15])
translate([-15,-14,-6.75])
cube([1.5,9.8,1],center=true);
rotate([21,345,15])
translate([-12,-14,-6.45])
cube([1.5,8,1],center=true);
rotate([21,345,15])
translate([-9,-14,-6.3])
cube([1.5,6.2,1],center=true);
rotate([21,345,15])
translate([-6,-14,-6.5])
cube([1.5,5,1],center=true);
rotate([352,345,345])
translate([-15,14,-12.2])
cube([1.5,16,1],center=true);
rotate([352,345,345])
translate([-12,14,-12.5])
cube([1.5,15,1],center=true);
rotate([352,345,345])
translate([-9,14,-12.5])
cube([1.5,14,1],center=true);
rotate([352,345,345])
translate([-6,14,-12.3])
cube([1.5,12.5,1],center=true);
rotate([8,345,15])
translate([-15,-14,-12.2])
cube([1.5,16,1],center=true);
rotate([8,345,15])
translate([-12,-14,-12.5])
cube([1.5,15,1],center=true);
rotate([8,345,15])
translate([-9,-14,-12.5])
cube([1.5,14,1],center=true);
rotate([8,345,15])
translate([-6,-14,-12.3])
cube([1.5,12.5,1],center=true);
}
}
}