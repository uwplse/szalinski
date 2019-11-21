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
 module cover(){
     union(){
cube([l+20,200,5]);
     translate([l/2+10,105,5])
     difference(){
cube([l,190,4],center=true);
         cube([l-10,180,4],center=true);
     }
 }   
 }
 cover();