//Bracket Height (Must be greater than 50)
h=100;
//Shelf Depth
d=160;
//Bracket Width (Must be greater than 15)
w=40;
//Lip Height
l=15;
//Resolution
$fn = 20;

//Matthew Olson
//MSE4777 Fall '18
//This bracket design was made to practice using the Customize it feature of thingiverse.  No structural anaylsis has been completed to ensure the bracket will hold any predetermined amount of weight.  Print at your own risk



translate([0,0,100])

cube([d,w,10]);
if(d>=60){
difference(){
translate([8,0,50])
rotate([0,-45,0])

cube([74,w,10]);
      translate([-1,10,10])
rotate([0,90,0])
cylinder(h=100,r=5);
    translate([-1,.5*w,80])
rotate([0,90,0])
cylinder(h=100,r=5);
}}

if(d>=80){
difference(){
translate([8,0,30])
rotate([0,-40,0])

cube([112,w,10]);
      translate([-1,10,10])
rotate([0,90,0])
cylinder(h=100,r=5);
    translate([-1,.5*w,80])
rotate([0,90,0])
cylinder(h=100,r=5);
}  }

    
difference(){
    translate([0,0,100-h])
cube([10,w,h]);
    translate([-1,.5*w,10])
rotate([0,90,0])
cylinder(h=30,r=3);
    translate([-1,.5*w,80])
rotate([0,90,0])
cylinder(h=30,r=3);
    
}
    translate([d,0,100])
cube([5,w,l]);

if(d>=155){

   difference(){ 
    translate([8,0,20])
rotate([0,-30,0])

cube([160,w,10]);
     translate([-1,.5*w,80])
rotate([0,90,0])
cylinder(h=150,r=5);   
   }}
    