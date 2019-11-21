// Mobius strip

//Radius of strip
Radius = 30;
//Width of Strip
Width = 15;
//Thickness of strip
Thickness=1;
//Half twists 0 is a collar, 1 is the mobius strip, 2 = fulll twist
Halftwist=1; 
//Start Angle - important if Halftwist = 0
Start=90;
//Step size in degrees
Step = 5;

module mobius_strip(radius,width,thickness,step=1, halftwist=3,start=90) {
  for (i = [0:step:360])
    hull() {
       rotate([0,0,i])
          translate([radius,0,0])
             rotate([0,start+i * halftwist * 0.5, 0]) 
               cube([width,Delta,thickness], center=true);
       rotate([0,0,i+step])
          translate([radius,0,0])
             rotate([0,start+(i+step)* halftwist * 0.5 , 0]) 
               cube([width,Delta,thickness], center=true);
       }
}

Delta= 0.1;

mobius_strip(Radius, Width, Thickness, Step, Halftwist,Start);