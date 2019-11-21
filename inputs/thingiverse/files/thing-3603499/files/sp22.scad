dh = 0.9;   //hole offset
hs = 30;    //base height
ds = 95;    //diameter system
dsp = 78.5;   //speaker outside diameter


difference(){
    union(){
 cylinder(d1= ds+8, d2 = ds,h = 8, $fn = 200); 
       
  cylinder(d= ds,h = hs, $fn = 200); 
  translate([0,0,hs])cylinder(d1=ds,d2 =1,h = 28, $fn = 100);       
        
 translate([0,(dsp/2+(ds-dsp)/4)-dh,hs+15])cube([(ds-dsp)/2+dh*2,(ds-dsp)/2+dh*2,30],center =true);
        //cylinder(d= (ds-dsp)/2+dh*2,h = 30, $fn = 100); 
 translate([0,-((dsp/2+(ds-dsp)/4)-dh),hs+15])cube([(ds-dsp)/2+dh*2,(ds-dsp)/2+dh*2,30],center =true);
 translate([(dsp/2+(ds-dsp)/4)-dh,0,hs+15])cube([(ds-dsp)/2+dh*2,(ds-dsp)/2+dh*2,30],center =true);
 translate([-((dsp/2+(ds-dsp)/4)-dh),0,hs+15])cube([(ds-dsp)/2+dh*2,(ds-dsp)/2+dh*2,30],center =true);}
 translate([0,(dsp/2+(ds-dsp)/4)-dh,-10.1])cylinder(d= 2.5,h = 45+hs, $fn = 100); 
 translate([0,-((dsp/2+(ds-dsp)/4)-dh),-10.1])cylinder(d= 2.5,h = 45+hs, $fn = 100); 
 translate([(dsp/2+(ds-dsp)/4)-dh,0,-10.1])cylinder(d= 2.5,h = 45+hs, $fn = 100); 
 translate([-((dsp/2+(ds-dsp)/4)-dh),0,-10.1])cylinder(d= 2.5,h = 45+hs, $fn = 100); 
 
    translate([0,0,-3])cylinder(d= ds-5,h = hs, $fn = 200); 
 
 //holes under the sensor
  rotate([90,0,0])translate([0,19,10])cylinder(d= 2.5,h = 100, $fn = 200); 
 rotate([90,0,0])translate([8,19,10])cylinder(d= 5.1,h = 100, $fn = 200);
 rotate([90,0,0])translate([-8,19,10])cylinder(d= 5.1,h = 100, $fn = 200);
// 
  rotate([270,0,0])translate([0,-10,10])cylinder(d= 5,h = 100, $fn = 200);

 }

