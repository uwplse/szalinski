Outside_Diamter = 21.0;//[10.0:100.0]
Face_Width = 7;//[1:20]
Pitch = 2.0; //[2.0:6.0]
Core_Diameter = 6.0; //[1.0:7.0]
Shaft_Lenght = 7;//[1:15]
Shaft_Thickness= 5;//[1:15]
Grub_Screw_Radius = 1.3; //[0.5:2.0]
Grub_Screw_Number = 1;//[0,1,2,3,4]

$fn= 200;
d1=((Pitch*360)/(2*(22/7)*Outside_Diamter/2));
n = (360/d1);
d2= 360/Grub_Screw_Number;
module tooth (){
   
    $fn= 4;
    rotate([0,0,45])
    cylinder ( r = Pitch/2.9, h = Face_Width);
 translate([Pitch/1.9,0,0])
    rotate([0,0,90])
   cylinder ( r = Pitch/2, h = Face_Width);
      
        }
    
    module Gear (){
cylinder (r=Outside_Diamter/2, h = Face_Width+2); 
translate([0,0,Face_Width+2])cylinder (r=Shaft_Thickness+Core_Diameter/2, h =Shaft_Lenght); 
translate([0,0,0])cylinder (r=Outside_Diamter/2+1.5, h = 1);}
    module core(){
translate([0,0,-1])cylinder (r=Core_Diameter/2, h = Face_Width+1000);}    
    module gearteeth(){ 
for (i = [3:1:2+n]){
    $fn=4;
    rotate([0,0,i*d1])    
    translate ([Outside_Diamter/2-Pitch/2.15,0,1])
    tooth();}}
module grubscrew(){
  for (i = [1:1:Grub_Screw_Number]){
    rotate([0,90,i*d2])
  translate([-(Face_Width+2+Grub_Screw_Radius+3),0,0])cylinder (r=Grub_Screw_Radius, h = Shaft_Thickness+5+Core_Diameter/2);       
    }}
 difference () {
   Gear(); 
   grubscrew();
  gearteeth();
   core();}
   
 