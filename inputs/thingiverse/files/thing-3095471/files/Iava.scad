//:) :) :) :) :) :) :) :) :)
//:) :) :) :) :) :) :) :) :)
//:) :) SNAXXUS CODE   :) :)
//:) :) :) :) :) :) :) ;) :)
//:) :) :) :) :) :) :) :) :)



//Toggle on/off InnerHoop for making independent stl files
InnerHoopExists=1;//[0:false,1:true]
//Toggle on/off OuterHoop for making independent stl files
OuterHoopExists=1;//[0:false,1:true]
//Circle Resolution
$fn=60;

//The diameter in millimeters of the filterhoop
HoopDia=60;
//The verticle thickness of the hoops
HoopHight = 5;
//The Horizontal thickness of the hoops
HoopThickness = 4;

//The height of the innerloop's handles above the outer loop
InnerHandleHeight=0.5;
//The diameter of the handle circles
HandleDia=30;
//The Thickness of the handle material
HandleThickness=2;
//How many handles you want around the hoop
Handles=4;
//How many arms you want around the hoop
Arms=3;
//The length of the support arms
ArmLength=28;
//The thickness of the material of the arms horizontally
ArmThickness=5;
//The thickness of a gap between the inner and outer hoops
FilterThickness=0.3;

translate([0,0,-HoopDia+HoopHight]){  
difference(){
union(){
if(InnerHoopExists){
difference(){
union(){  
cylinder(h=HoopDia+InnerHandleHeight,d1=0, d2=HoopDia+InnerHandleHeight);
//Handles
for(i=[0:Handles]){  
rotate([0,0,45+i*360/Handles]){  
translate([HoopDia/2,0,HoopDia+InnerHandleHeight-0.001]){
cylinder(h=HandleThickness,d=HandleDia);
}}
rotate([0,0,65+i*360/Handles]){  
translate([HoopDia/2,0,HoopDia+InnerHandleHeight-0.001]){
cylinder(h=HandleThickness,d=HandleDia);
}}}
}
translate([0,0,2*HoopThickness]){
cylinder(h=HoopDia+InnerHandleHeight,d1=0, d2=HoopDia+InnerHandleHeight);
}}
}


if(OuterHoopExists){
translate([0,0,-2*HoopThickness-2*FilterThickness]){
color("blue"){
difference(){
union(){
cylinder(h=HoopDia+2*HoopThickness+2*FilterThickness,d1=0, d2=HoopDia+2*HoopThickness+2*FilterThickness);

//OuterHandles
for(i=[0:Handles]){  
rotate([0,0,25+i*360/Handles]){ 
translate([HoopDia/2,0,2*HoopThickness+2*FilterThickness+HoopDia-HandleThickness]){
cylinder(h=HandleThickness,d=HandleDia);
}}
rotate([0,0,80+i*360/Handles]){  
translate([HoopDia/2,0,2*HoopThickness+2*FilterThickness+HoopDia-HandleThickness]){
cylinder(h=HandleThickness,d=HandleDia);
}}}

//Arm
for(j=[0:Arms]){
rotate([0,0,j*360/Arms]){
difference(){
union(){  
translate([HoopDia/2+ArmLength/2-HoopHight,0,2*HoopThickness+2*FilterThickness+HoopDia-HoopHight/2]){
cube([ArmLength+HoopHight,ArmThickness,HoopHight],center=true);
translate([(ArmLength+HoopHight)/2,0,-HoopHight/2]){
rotate([90,0,0]){
cylinder(h=ArmThickness,r=HoopHight, center=true);
}}}}
translate([HoopDia/2+ArmLength/2-HoopHight,0,2*HoopThickness+2*FilterThickness+HoopDia-1.5*HoopHight]){
cube([ArmLength+HoopHight,2*ArmThickness,HoopHight],center=true);
}}}
}}
translate([0,0,2*HoopThickness]){
cylinder(h=HoopDia+2*HoopThickness+2*FilterThickness,d1=0, d2=HoopDia+2*HoopThickness+2*FilterThickness);
}
}}}}}

cylinder(h=2*(HoopDia-HoopHight),d=HoopDia+2*HoopThickness,center=true);
}}

//:) :) :) :) :) :) :) :) :)
//:) :) :) :) :) :) :) :) :)
//:) :) SNAXXUS CODE   :) :)
//:) :) :) :) :) :) :) ;) :)
//:) :) :) :) :) :) :) :) :)
