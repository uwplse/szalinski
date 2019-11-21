 
  phonewidth = 82;
  phonedepth = 14;
  hight = 28;
  thickness = 1.5;
  basethickness = 1;
  chargercut = 14;
  sides = 100;
  
difference(){

union(){
 difference(){   
     
 difference(){
 cube ([phonewidth+thickness, phonedepth+thickness, hight], center = true);     
 cube ([phonewidth, phonedepth, hight+1], center = true);   
 }
 
 
 
 translate([0,0,phonewidth/2-hight/2+1])
 rotate ([90,0,0]) 
 linear_extrude (1000) 
 circle (r= phonewidth/2-thickness,$fn=sides);
 }
 
 translate([0,0,-hight/2-basethickness/2])
 cube ([phonewidth+thickness, phonedepth+thickness, basethickness], center = true);
 }
 
 
 translate([0,-phonedepth/5 - thickness,-hight/2+0.5])
 cube([chargercut,phonedepth+thickness,hight*2], center=true);
 }
 
