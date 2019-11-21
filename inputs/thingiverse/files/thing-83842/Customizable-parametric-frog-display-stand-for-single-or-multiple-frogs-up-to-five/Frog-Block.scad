/*parameters*/
//pedestal height
pedestal=1; //[1,2,3,4,5]
//text base height
box=1; //[0,1,2,3,4,5]
//text height
textHeight=2; //[1,2,3,4,5]

/*duplicates*/
//number of frogs
frogs=1; //[1,2,3,4,5]
//frog 1 layer thickness
frog1="0.3 mm"; 
//frog 2 layer thickness
frog2="0.15 mm"; 
//frog 3 layer thickness
frog3="0.05 mm"; 
//frog 4 layer thickness
frog4="0.1 mm"; 
//frog 5 layer thickness
frog5="0.05 mm"; 

include <write/Write.scad>

union(){

translate([0,0,-1])
cube([60,60,2],center=true);
translate([55,0,0])
scale([1,1,pedestal])
import("Frog Feet.stl");
translate([-25,-28.5,0])
	cube([50,11,box]);
translate([0,-23,box])
write(frog1,t=textHeight,h=10,center=true);

if(frogs>1){
translate([60,0,0]){
translate([0,0,-1])
cube([60,60,2],center=true);
translate([55,0,0])
scale([1,1,pedestal])
import("Frog Feet.stl");
translate([-25,-28.5,0])
	cube([50,11,box]);
translate([0,-23,box])
write(frog2,t=textHeight,h=10,center=true);
}
}

if(frogs>2){
translate([120,0,0]){
translate([0,0,-1])
cube([60,60,2],center=true);
translate([55,0,0])
scale([1,1,pedestal])
import("Frog Feet.stl");
translate([-25,-28.5,0])
	cube([50,11,box]);
translate([0,-23,box])
write(frog3,t=textHeight,h=10,center=true);
}
}

if(frogs>3){
translate([180,0,0]){
translate([0,0,-1])
cube([60,60,2],center=true);
translate([55,0,0])
scale([1,1,pedestal])
import("Frog Feet.stl");
translate([-25,-28.5,0])
	cube([50,11,box]);
translate([0,-23,box])
write(frog4,t=textHeight,h=10,center=true);
}
}

if(frogs>4){
translate([240,0,0]){
translate([0,0,-1])
cube([60,60,2],center=true);
translate([55,0,0])
scale([1,1,pedestal])
import("Frog Feet.stl");
translate([-25,-28.5,0])
	cube([50,11,box]);
translate([0,-23,box])
write(frog5,t=textHeight,h=10,center=true);
}
}

}