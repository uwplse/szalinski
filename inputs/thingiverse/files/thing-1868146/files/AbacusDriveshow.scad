part=0;//[0,1,2,3]
$fn=50;
//inner race
inrace= 30;
//outer race
outrace= 40;
//inner cycles
icyc=6;
//outer cycles
ocyc=8;
//no rollers
rollers=7;
//roller size
roller=10;
//roller taper
cone=0.1;

step=360/($fn*3);
if (part==1||part==0){
 color("Red")for (i=[0:90/rollers*2:90])
{rotate([0,0,i+90])
 translate([outrace+10+roller*1.5,0,00]){
  rotate_extrude(angle = 360, convexity = 2) hull(){
offset(0.5,$fn=3)offset(-0.5)hull(){
square([roller,0.01]);
translate([roller*cone,-10,0])square([0.01,20] );
}
translate([0,-9,0])square([0.01,16] );
}}
}}


if (part==2||part==0){
 color("LightGreen")difference(){
orace(outrace,20);


for(i=[0:step:360])
{
hull(){
rotate([0,0,(i)])translate([outrace,0,0])
scale([1.1+ (sin((i) *ocyc))  ,1,1.1+ (sin((i) *ocyc))  ])scale([1,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);

rotate([0,0,(i+step)])translate([outrace,0,0])
scale([1.1+ (sin((i+step) *ocyc))  ,1,1.1+ (sin((i+step) *ocyc))  ])scale([1,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);
 }
}
 for (i=[0:360/ocyc:360]){
rotate([0,0,i+(360/ocyc)*0.75])translate([outrace +5,0,0])cylinder(21,2,2,center=true);}

}}

if (part==3||part==0){
 color("LightBlue") difference(){
 irace(inrace,20);
for(i=[0:step:360])
{
hull(){

rotate([0,0,(i)])translate([inrace,0,0])
scale([1+ (sin((i)*icyc)) ,1,1.1+ (sin((i) *icyc))  ])scale([1.5,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);


rotate([0,0,(i+step)])translate([inrace,0,0])
scale([1+ (sin((i+step)*icyc)) ,1,1.1+ (sin((i+step) *icyc))  ])scale([1.5,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);




}
}
 for (i=[0:360/icyc:360]){
rotate([0,0,i+(360/icyc)*0.75])translate([inrace -5,0,0])cylinder(21,2,2,center=true);}
}}

module orace (ri,ro)
{
 
 rotate_extrude(angle = 360, convexity = 2)
 offset(0.5,$fn=5)offset(-0.5 )translate([ri , -ro*0.5 ])square([ro*0.5 ,ro*0.50] );
}
module irace (ri,ro)
{
 
 rotate_extrude(angle = 360, convexity = 2)
 offset(0.5,$fn=5)offset(-0.5 )translate([ri -ro*0.5, -ro*0.5 ])square([ro*0.5 ,ro*0.5] );
}