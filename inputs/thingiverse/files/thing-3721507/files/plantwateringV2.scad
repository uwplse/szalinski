//Plantroot Watering by henryP V2
durchmesser=26;// [15:50]
loch=2;// [1:4]
hoehe=75;// [30:150]
deckel=1;// [1,0]
/* [Hidden] */
$fn=50;
if (deckel==2){
}
if (deckel==1){
    translate([2*durchmesser+15,0,0])
deckel ();  
}
translate([0,0,hoehe+durchmesser+.5]){
rotate([0,180,0]){
difference(){
union(){
korpus(durchmesser/2);
translate([0,0,hoehe+durchmesser])
cylinder(h=.5,r1=durchmesser+5,r2=durchmesser+5);  
}
translate([0,0,2.5])
korpus(durchmesser/2-1);
cut(loch/2);
}}}
module korpus(radius){ 
translate([0,0,0])
cylinder(h=radius,r1=radius/10,r2=radius);
translate([0,0,radius])
cylinder(h=hoehe-radius,r1=radius,r2=radius);
translate([0,0,hoehe])
cylinder(h=radius,r1=radius,r2=radius*2);
translate([0,0,hoehe+radius])
cylinder(h=radius,r1=radius*2,r2=radius*2);
}
module cut(loch){
    for (i=[0:360/10:360]){
    rotate([0,0,i])
    translate([-durchmesser,0,durchmesser/2])
cube([durchmesser*2,loch,durchmesser]);
}}
module deckel(){
    difference(){
        union(){
    translate([0,0,0])
cylinder(h=1.5,r1=durchmesser+5,r2=durchmesser+5);  
translate([0,0,0])
cylinder(h=4.5,r1=durchmesser-1,r2=durchmesser-1);   
        }
 translate([0,0,0])
cylinder(h=5,r1=5,r2=5);     
 translate([0,0,2])
cylinder(h=5,r1=durchmesser-5,r2=durchmesser-5);            
    }}