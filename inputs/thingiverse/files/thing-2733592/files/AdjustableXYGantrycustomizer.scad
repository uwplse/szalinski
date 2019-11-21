// 46mm or 49mm bearing block?
Block_size="second"; //[first:46mm,second:49mm]
// Leave it at 0 or read the header in this file before changing...(view source)
Skew_correction_angle=0;// [-2.5:.01:2.5]
//in mm. Default is 5. Use 4 for bearing shoulder Mod (read detail page)
Pulley_Screw_Diameter=5;//[4,5]
//in mm. This perspective is from being mounted on the left Y axis rail. The other side is reversed. If you use 2 different distances you need to make 2 different versions. Any value between 14 & 35. Default is 19                                       
Motor_pulley_distance_from_center_of_20x20= 19;//[14:.5:35]
// in mm. Center of 20x20 to center of pulley. Default is 19
Corner_pulley_distance_from_center_of_20x20= 19;//[14:.5:35]
//in mm. Any value between 30 to 50. Default is 40
Distance_between_pulley_centers= 40;//[30:.5:50]
/*hidden*/
// preview[view:north, tilt:bottom]

/*************************************************
*  TronXY X5S X Y Gantry mount w/Adjustable skew 
*           angle and pulley holes

*           Author: Lee J Brumfield





*    Y                   
*    ^ 
*    |
*    |  B-------C
*    |  |       |
*    |  |       |   
*    |  |       |    
*    |  A-------D     
*    +-------------->X 
*     XY SKEW  
*
* 
* 1. Measure 400mm up the Y axis 
* (A to B) and mark the inside
* of the frame. Measure 400mm 
* across the Y axis (A to D) 
* and mark the inside of the frame. 
* 
* 2. Measure the distance between 
* the 2 marks (B to D). If it 
* measures 565.685424949 {400*(sqrt2)
*  then stop right there. It's perfect,
*  your skew correction angle is 0. 
* 
* 3. If it's smaller, subtract that 
* number from 565.685424949. Then 
* take that number and add it to 
* 565.685424949. That value will 
* be A to C
* 
* If it's larger, subtract 565.685424949
* from it. Then take that number and
* subtract it from 565.685424949. 
* That value will be A to C.
* 
* Enter those values into this Gskew 
* program and get your skew angle. 
* Then enter the INVERSE of that 
* angle into the skew_correction_angle
* to fix it.
*              Example 
*  If your skew angle is .97 enter -.97
* 
*     Gskew is bundled in here.
* 
* http://pilotpage.monosock.org/fileadmin/files/Gsuite_v1.4.rar
* 
* Now when you print this it needs to 
* be printed on a skew corrected machine 
* or with skew corrected gcode. Read the 
* PDF with Gskew and check this out.
* 
* https://www.thingiverse.com/thing:2792552
* 
* 
*************************************************/


SK=Skew_correction_angle;
MPD=Motor_pulley_distance_from_center_of_20x20;
CPD=Corner_pulley_distance_from_center_of_20x20;
D=Distance_between_pulley_centers/2;
PSR=Pulley_Screw_Diameter/2;
PSR1=Pulley_Screw_Diameter;

$fn=200;

color ("orange")
{
if (Block_size == "first")
{
difference() 
{
union()
{
translate([0,2,0])
cube ([70,76,4.5],center=true);
translate([0,13.75,-3.25])
cube ([70,52.5,2.1],center=true);
translate([0,-25,-15.75])
cube ([70,4,36],center=true);
translate([-16,-30.5,-15.75])
cube ([4,11,36],center=true);
translate([16,-30.5,-15.75])
cube ([4,11,36],center=true);
translate([-12.5,26,-11.])
rotate([0,0,SK])
cube ([5,28,26.5],center=true);
translate([12.5,26,-11.])
rotate([0,0,SK])
cube ([5,28,26.5],center=true);
translate([0,26,-6.5])
rotate([0,0,SK])
cube ([6,28,6],center=true);
translate([-21,13.5,-13.25])
cube ([20,3,22],center=true);
translate([21,13.5,-13.25])
cube ([20,3,22],center=true);
translate([-21,38,-13.25])
cube ([20,4,22],center=true);
translate([21,38,-13.25])
cube ([20,4,22],center=true);
translate([-29,-18,-3.25])
cube ([12,12,2.1],center=true);
translate([29,-18,-3.25])
cube ([12,12,2.1],center=true);
translate([-26,-30,-3.25])
cube ([18,12,2.1],center=true);
translate([26,-30,-3.25])
cube ([18,12,2.1],center=true);
translate([-25,-21,-16.75])
cube ([4,5,34],center=true);
translate([25,-21,-16.75])
cube ([4,5,34],center=true);
translate([-22,26,-6])
cube ([18,26,4.5],center=true);
}translate([0,26,-7.3])
rotate([0,0,SK])
cube ([8,12,6],center=true);
translate([0,26,-1])
cylinder(h=45,r=2,center=true);
translate([-12.5,26,-14.4])
rotate([0,90,SK])
cylinder(h=8,r=2,center=true);
translate([12.5,26,-14.4])
rotate([0,90,SK])
cylinder(h=8,r=2,center=true);
translate([0,26,1])
cylinder(h=2.55,r=3.5,center=true);
translate([10,-25,-25.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([10,-25,-5.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([-10,-25,-25.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([-10,-25,-5.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([-D,MPD,-4])
cylinder(h=12,r=PSR,center=true);
translate([D, CPD,-1])
cylinder(h=8,r=PSR,center=true);
translate([-D,MPD,-18.25])
cylinder(h=20,r=PSR1,center=true);
translate([D, CPD,-14.3])
cylinder(h=20,r=PSR1,center=true);
translate([-D,MPD,0])
cylinder(h=4.6,r=PSR1,$fn=6,center=true);
translate([-35,-36,-1])
rotate([0,0,45])
cube([2,2,10],center=true);
translate([35,-36,-1])
rotate([0,0,45])
cube([2,2,10],center=true);
translate([-35,40,-1])
rotate([0,0,45])
cube([2,2,6.6],center=true);
translate([35,40,-1])
rotate([0,0,45])
cube([2,2,6.6],center=true);
translate([-49.8,-25,-17.4])
rotate([0,73,0])
cube ([70,20,36],center=true);
translate([49.8,-25,-17.4])
rotate([0,-73,0])
cube ([70,20,36],center=true);
translate([-16,-37,-20])
rotate([17,0,0])
cube ([4.1,11,36],center=true);
translate([16,-37,-20])
rotate([17,0,0])
cube ([4.1,11,36],center=true);
translate([30,14,-24])
rotate([0,-52,0])
cube ([32,4.1,22],center=true);
translate([-30,28,-24])
rotate([0,52,0])
cube ([32,40,22],center=true);
translate([30,38,-24])
rotate([0,-52,0])
cube ([32,4.1,22],center=true);
translate([27,-18,-32])
rotate([-45,0,0])
cube ([8,5,9],center=true);
translate([-27,-18,-32])
rotate([-45,0,0])
cube ([8,5,9],center=true);
mirror()
{
scale(.2)
translate([47.5,-150,9.5])
rotate([0,180,0])
import("brand.stl", convexity=3);
}
}
}
if (Block_size =="second")
{
difference() 
{
union()
{
translate([0,2, 0])
cube ([70,76,4.5],center=true);
translate([0,13.75,-3.25])
cube ([70,52.5,2.1],center=true);
translate([0,-25,-15.75])
cube ([70,4,36],center=true);
translate([-16,-30.5,-15.75])
cube ([4,11,36],center=true);
translate([16,-30.5,-15.75])
cube ([4,11,36],center=true);
translate([-12.5,26,-11.])
rotate([0,0,SK])
cube ([5,28,26.5],center=true);
translate([12.5,26,-11.])
rotate([0,0,SK])
cube ([5,28,26.5],center=true);
translate([0,26,-6.5])
rotate([0,0,SK])
cube ([6,28,6],center=true);
translate([-21,13.5,-13.25])
cube ([20,3,22],center=true);
translate([21,13.5,-13.25])
cube ([20,3,22],center=true);
translate([-21,38,-13.25])
cube ([20,4,22],center=true);
translate([21,38,-13.25])
cube ([20,4,22],center=true);
translate([-30,-18,-3.25])
cube ([10,12,2.1],center=true);
translate([30,-18,-3.25])
cube ([10,12,2.1],center=true);
translate([-26,-30,-3.25])
cube ([18,12,2.1],center=true);
translate([26,-30,-3.25])
cube ([18,12,2.1],center=true);
translate([-27,-21,-13.25])
cube ([4,5,20],center=true);
translate([27,-21,-13.25])
cube ([4,5,20],center=true);
translate([-22,26,-6])
cube ([18,26,4.5],center=true);
}translate([0,26,-7.3])
rotate([0,0,SK])
cube ([8,12,6],center=true);
translate([0,26,-1])
cylinder(h=45,r=2,center=true);
translate([-12.5,26,-14.4])
rotate([0,90,SK])
cylinder(h=8,r=2,center=true);
translate([12.5,26,-14.4])
rotate([0,90,SK])
cylinder(h=8,r=2,center=true);
translate([0,26,1])
cylinder(h=2.55,r=3.5,center=true);
translate([10,-25,-25.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([10,-25,-5.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([-10,-25,-25.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([-10,-25,-5.75])
rotate([90,0,0])
cylinder(h=5,r=1.5,center=true);
translate([-D,MPD,-4])
cylinder(h=12,r=PSR,center=true);
translate([D, CPD,-1])
cylinder(h=8,r=PSR,center=true);
translate([-D,MPD,-18.25])
cylinder(h=20,r=PSR1,center=true);
translate([D, CPD,-14.3])
cylinder(h=20,r=PSR1,center=true);
translate([-D,MPD,0])
cylinder(h=4.6,r=PSR1,$fn=6,center=true);
translate([-35,-36,-1])
rotate([0,0,45])
cube([2,2,10],center=true);
translate([35,-36,-1])
rotate([0,0,45])
cube([2,2,10],center=true);
translate([-35,40,-1])
rotate([0,0,45])
cube([2,2,6.6],center=true);
translate([35,40,-1])
rotate([0,0,45])
cube([2,2,6.6],center=true);
translate([-49.8,-25,-17.4])
rotate([0,73,0])
cube ([70,4.1,36],center=true);
translate([49.8,-25,-17.4])
rotate([0,-73,0])
cube ([70,4.1,36],center=true);
translate([-16,-37,-20])
rotate([17,0,0])
cube ([4.1,11,36],center=true);
translate([16,-37,-20])
rotate([17,0,0])
cube ([4.1,11,36],center=true);
translate([30,14,-24])
rotate([0,-52,0])
cube ([32,4.1,22],center=true);
translate([-30,28,-24])
rotate([0,52,0])
cube ([32,40,22],center=true);
translate([30,38,-24])
rotate([0,-52,0])
cube ([32,4.1,22],center=true);
translate([27,-18,-22])
rotate([-45,0,0])
cube ([4.1,5,9],center=true);
translate([-27,-18,-22])
rotate([-45,0,0])
cube ([4.1,5,9],center=true);
mirror()
{
scale(.2)
translate([0,-90,9.5])
rotate([0,180,0])
import("Brand3.stl",convexity=3);
}
}
}
}