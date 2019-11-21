//Customisable Box mobile projector from Saurabh Karanke
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
module mobholder(){
union(){
    difference(){
cube([l,width+15,t]);
translate([11,11,18])
cube([l1,w1,2]);
translate([9,9,t1])
cube([l2,w2,tl]);
}
translate([-5,width-5,0])
cube([5,5,20]);
translate([l,width-5,0])
cube([5,5,20]);
 }
 }
 mobholder();