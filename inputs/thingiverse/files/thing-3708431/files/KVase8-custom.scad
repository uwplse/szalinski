// height
height=1;//[0.1:0.01:2]
// shape
r3=25;//[1:1:27]

// base
cr1=30;//[17:0.1:70]
ch1=4;//[1:0.1:20]
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


translate([0,0,ch1/2])
color([(col/2+0.5)*cc,col2/2+cc,col3/2+cc]) 
difference() {
cylinder(r=cr1,h=ch1,center=true);
            cylinder(r=hole,h=20,center=true);   
}
 
scale([1,1,height]) {
difference() {
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
     translate([0,0,-5]) 
      cylinder(r=30,h=10,center=true); 
      
  }
  }