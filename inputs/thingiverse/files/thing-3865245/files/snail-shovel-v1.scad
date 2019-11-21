length=100;
width=50;
height=30;
angle=45;
thickness=2;
slotWidth=2;
nrStabilizerBottom=2;
nrStabilizerBack=1;

module box(){
difference(){
cube([length,width,height]);
translate([thickness,thickness,thickness]){
cube([length,width-2*thickness,height-2*thickness]);}
translate([length,0,0]){
rotate(-angle,[0,1,0]){
cube([length,width,1000]);}}}}



//bottom stabilizers
for (x=[1:nrStabilizerBottom]){
translate([10-2.5+(length-20)/(1+nrStabilizerBottom)*x,0,0]){
cube([5,width,thickness]);}}

//back stabilizers
for (x=[1:nrStabilizerBack]){
translate([0,0,height/(nrStabilizerBack+1)*x-2.5]){
cube([thickness,width,5]);}}

difference(){
box();
    
//bottom slots
for (i=[1:(width-2*thickness)/(slotWidth*2)]){
translate([0,i*slotWidth*2,thickness]){
cube([thickness,slotWidth,height-2*thickness]);}}
//back slots
translate([10,0,-1]){
for (i=[1:(width-2*thickness)/(slotWidth*2)]){
translate([0,i*slotWidth*2,0]){    
cube([length-20,slotWidth,thickness+2]);}
}}}


