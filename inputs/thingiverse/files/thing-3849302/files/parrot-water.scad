// parrot water
/*parameters*/

$fn= 4*25;
//height
hgt=23;
//width
wdt=110;
//length
lngt=100;
// Wall thickness (mm)
tic=2.5;
//fillet
fi=5;
//cap diameter
cap=32;
//cap height
chgt=17;

h_2=hgt+7;

module shape () {
   
    square([wdt,lngt],true);
 translate ([wdt/2,0,0]){
        circle(d=lngt,true);}
        }
module fillet()
{
   
    offset(r=fi)
    offset(r=-fi)
    children();
}
union (){
difference (){
    linear_extrude (height=hgt){
    fillet()
    shape();}
translate([0,0,tic]){
linear_extrude (height=hgt+10){
    fillet()
    offset (delta=-tic)
    shape();
}}}

translate ([((wdt/2)+(lngt/2)-(cap/2)-(1.5*tic)),0,0]){
difference () {
    union (){
        difference () {
            cylinder (h=h_2, r=(cap/2)+tic);
            translate(0,0,hgt-5){
                cylinder (h=5, r=(34/2));}
            cylinder (h=hgt*2, r=(cap/2));
            translate([0,0,h_2-1]){
                cylinder (h=2,r=((cap+2)/2));}}
         difference(){
            translate ([0,0,-chgt]){
                translate ([0,0,hgt]){
                    cylinder(h=3,r=(cap/2)+tic);}}
                    cylinder (h=hgt*2, r=(cap/2)-3);}
      }
    rotate ([0,-90,0]){
        cylinder (h=hgt, r=(7.56));}
   
}}
}

