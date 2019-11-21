 
/* [Shape] */
Diameter=3; 
Diameter2=5; 
Height=0.3; 
Thickness=0.4; 
Unit=1;// [0:mm, 1:inch]

/* [Flamethrower] */
Flamethrower=0;// [0:No, 1:Yes]
FlameSmallDiameter=0.4; 
FlameLargeDiameter=2.4; 
FlamethrowerWidth=8; 

/* [add Rod] */
rod=1;// [0:No, 1:Yes]
rodHeight=2;
 
/* [Hidden] */
d2=Unit==0?Diameter2:(Diameter2*25.4);  
d1=Unit==0?Diameter:(Diameter*25.4);  
t=Unit==0?Diameter:(Thickness*25.4);  
h=Unit==0?Height:(Height*25.4);  
sd=Unit==0?FlameSmallDiameter:(FlameSmallDiameter*25.4);  
ld=Unit==0?FlameLargeDiameter:(FlameLargeDiameter*25.4);  
rh=(Unit==0?rodHeight:(rodHeight*25.4))+t;  
fw=(Unit==0?FlamethrowerWidth:(FlamethrowerWidth*25.4))-ld/2;   
useRod = rod != 0; 
 
 off=-90;
$fn=150; 

     difference() {
        cylinder(d=d1 ,h=h);
        translate([0,0,-1]) 
        cylinder(d=d1- t*2,h=h+2);
    }
     difference() {
        cylinder(d=d2,h=h);
        translate([0,0,-1]) 
        cylinder(d=d2- t*2,h=h+2);
    } 
    rotate([0,0,0])
    translate([d1/2-t,-t/2,0])
    cube([d2/2-d1/2,t,h]);
    rotate([0,0,180])
    translate([d1/2-t,-t/2,0])
    cube([d2/2-d1/2,t,h]);
    
    translate([0,-d1,0])
color("red")
    difference() {
    flamethrower(sd,ld ,fw,0,0);
    flamethrower(1,ld - t*2,fw,23,t);
    } 
    if(rod==1)
    {
color("green")
    rotate([0,0,off])
    translate([d2/2-t,-t/2,0])
    cube([t,t,rh]);
    rotate([0,0,off+120])
    translate([d2/2-t,-t/2,0])
    cube([t,t,rh]);
    rotate([0,0,off-120])
    translate([d2/2-t,-t/2,0])
    cube([t,t,rh]);
        
    }
    module flamethrower(df,df2,width,off,off2)
    {
        hull()
        {
        translate([0,off2,-off/2]) 
        cylinder(d=df,h=h+off);
        translate([0,width,0]) 
        cylinder(d=df2,h=h+off);
        }
    }