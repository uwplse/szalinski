//Customisable Box mobile projector from Saurabh Karanke
//Enter mobile dimensions 
//Enter mobile length
length=150;
//Enter mobile width
width=73.5;
//Enter mobile thickness
thickness=9.5;
daimeter=72;//[50:72]
l=length+20;l1=length-2;l2=length+2;
w=width+20;w1=width+9;w2=width+11;
t=20;//[20:20]
tl=thickness+2;
t1=18-tl;
module box(){
    difference(){
cube([l+20,200,w+5]);
    translate([9.5,10,5])
cube([l+1,190,w]);
    translate([4.5,10,width])
cube([6,190,6]);
    translate([l+10.5,10,width])
cube([6,190,6]);
        translate([l/2+10,0,width/2+15])
        rotate([-90,0,0])
cylinder(10,daimeter/2,daimeter/2);
 }
 }
 box();