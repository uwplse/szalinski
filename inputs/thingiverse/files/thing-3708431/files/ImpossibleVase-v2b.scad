// height
height=1.2;//[0.4:0.01:2]
// shape
r3=9;//[1:1:27]
//vase mode
solid=true;//[true:false]
// base
cr1=30;//[17:0.1:70]
ch1=6;//[1:0.1:20]
hole=0;//[0:0.1:70]
// main colour
col=1;//[0.1:0.01:1]
col2=1;//[0.1:0.01:1]
col3=1;//[0.1:0.01:1]
// base colour
cc=0.45;//[0:0.01:0.47]
/* tuning */
//param 1
r1=9;//[1:1:18]
//param 2
r2=45;//[1:1:45]

union() {
difference() {
    if (solid==true) {
    vase_solid();
    }
    else {
        vase();
    }
    cut();
}
base();
top();
}

module base() {
translate([0,0,ch1/2])
color([(col/2+0.5)*cc,col2/2+cc,col3/2+cc]) 
difference() {
cylinder(r=cr1,h=ch1,center=true);
            cylinder(r=hole,h=20,center=true);   
}
}

module top() {
scale([1,1,height]) {
    color([(col/2+0.5)*cc,col2/2+cc,col3/2+cc]) 
    hull(){
for (x=[0.2:0.2:r1])
    rotate(x*45) {
for (a =[r3:r3])  {
translate([a,sin(a*15)*35+a+2,a*7+2-a+(20-r1)/2])          
rotate([45,45,45])
              cube([(20-r1)/2,(20-r1)/2,(20-r1)/2]);
      }
}
}
}
}

module vase() {
scale([1,1,height]) {

for (x=[0.2:0.2:r1])
    rotate(x*r2) {
for (a =[1:r3]) 
   for (b =[1:1])  
          for (c =[1:1]) {
              e=rands(0.5,1,1)[0];
                f=rands(0.5,1,1)[0];  
                    g=rands(0.5,1,1)[0];
translate([a,sin(a*15)*35+a,a*7-a]) color([a/r3*col*e,a/r3*col2*f/2+0.5,a/r3*col3/2+0.5]) 
              
rotate([45,45,45])
              cube([20-r1,20-r1,20-r1]);
          }
      }

   }
   }
   
  module vase_solid() {
scale([1,1,height]) {

for (x=[0.2:0.2:r1])
    rotate(x*r2) {
for (a =[1:r3]) 
   for (b =[1:1])  
          for (c =[1:1]) {
              e=rands(0.5,1,1)[0];
                f=rands(0.5,1,1)[0];  
                    g=rands(0.5,1,1)[0];
              color([a/r3*col*e,a/r3*col2*f/2+0.5,a/r3*col3/2+0.5]) hull() {
translate([a,sin(a*15)*35+a,a*7-a]) color([a/r3*col*e,a/r3*col2*f/2+0.5,a/r3*col3/2+0.5]) 
              
rotate([45,45,45])
              cube([20-r1,20-r1,20-r1]);
          translate([0,0,a*7-a])                
                  cube([20-r1,20-r1,18-r1]);  
              } 
          }
      }

   }
   } 
   
   module cut() {
      translate([0,0,-5]) 
      cylinder(r=30,h=10,center=true); 
   }
 