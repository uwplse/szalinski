$fn=200;


coin1 = 10;   // coin1 radius
coin2 = 11;   // coin2 radius
coin3 = 13;   // coin3 radius
coin4 = 14;   // coin4 radius
// small --->  big   or reverse, mm

difference () {
cylinder(r=75,h=150);
translate ([0,0,-1])
cylinder(r=70,h=152);
}
module sliding () {

translate([0,0,105])
linear_extrude (height = 40, twist = 360)
    translate ([48,0,0])
         circle(27);
}



  module coin() {
 translate ([37.5,37.5,0])
cylinder(r=coin1+1,h=150); 
translate ([-37.5,37.5,0])
cylinder(r=coin2+1,h=150);  
translate ([-37.5,-37.5,0])
cylinder(r=coin3+1,h=150);  
translate ([37.5,-37.5,0])
cylinder(r=coin4+1,h=150); 
}

difference () {
 sliding ();
    coin();
}
//sliding

translate([54,0,105]) 
        cylinder(r=21,h=40);

cylinder(r=32,h=150);

//cylinder in the middle of the can 

translate ([180,0,-150])
difference () {
translate ([0,0,150])
cylinder(r=75,h=2);
translate ([37.5,37.5,0])
cylinder(r=16,h=153);  
} 
// top can base

translate ([-350,0,0]) {
 translate ([170,0,0])
cylinder(r=75,h=4);

difference () {
  translate ([170,0,0])
  cylinder(r=69,h=100);
     translate ([170+37+12,37+9,4])
     cylinder(r=8,h=100);
     translate ([170-48,47,4])
     cylinder(r=9,h=100);
    translate ([170-50.5,-50,4])
     cylinder(r=12,h=100);
     translate ([170+50,-50,4])
     cylinder(r=12,h=100);
  
    
 translate ([170,0,0]) {   
translate ([37.5,37.5,0])
cylinder(r=coin1+1,h=150); 
translate ([-37.5,37.5,0])
cylinder(r=coin2+1,h=150); 
translate ([-37.5,-37.5,0])
cylinder(r=coin3+1,h=150);  
translate ([37.5,-37.5,0])
cylinder(r=coin4+1,h=150); 

cylinder(r=33,h=150);

}
}
}
