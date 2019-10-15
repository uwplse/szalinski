module PerfX(x,yb,ye,zb,ze,gap){
for (yg=[yb:gap:ye])
 for (zg=[zb:gap:ze]){
  translate([x,yg,zg])
  rotate(a=[0,90,0])cylinder(r=2.5,h=4,$fn=100);      
}}
module PerfY(xb,xe,y,zb,ze,gap){
for (xg=[xb:gap:xe])
 for (zg=[zb:gap:ze]){
  translate([xg,y,zg])
  rotate(a=[90,90,0])cylinder(r=3,h=4,$fn=100);      
}}
sizeX=97.5;//width
sizeY=41.5; //height
sizeZ=45; //depth
difference(){//Bottom face
translate([0,0,0])cube ([sizeX,sizeY,2]); /*base thickness*/
/*translate([90,30,0])
  rotate(a=[0,0,90])cylinder(r=8,h=4,$fn=100); */
translate([65-15,sizeY-5,0])
    rotate(a=[0,0,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
translate([103.5-15,sizeY-5,0])
    rotate(a=[0,0,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
translate([65-15,sizeY-22,0])
    rotate(a=[0,0,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
translate([103.5-15,sizeY-22,0])
    rotate(a=[0,0,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
}
difference() { //back face
translate([0,sizeY-2,0])cube([sizeX,2,sizeZ-9.5]);
translate([23.5-15,sizeY-3,34-6.5])
    rotate(a=[0,90,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
translate([65-15,sizeY-3,34-6.5])
    rotate(a=[0,90,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
translate([103.5-15,sizeY-3,34-6.5])
    rotate(a=[0,90,90])cylinder(r=1.6,h=4,$fn=100);//hole for the screw
translate([93.5,sizeY-3,14.5+6.5-6.5])
    rotate(a=[0,90,90])cylinder(r=6.5 ,h=4,$fn=100);//hole for the loom
}
difference(){ //front face
translate([0,0,0])cube([sizeX,2,sizeZ]);
translate([7.5,-1,7])cube([29,4,22.5]);//switch hole
translate([sizeX-2,0,sizeZ-9.5])cube([2,2,9.5]); //lip
/*translate([51,-1,6])cube([27,4,19]);//power socket hole*/   
}

difference(){ //right face
translate([sizeX-2,0,0])cube([2,sizeY-1,sizeZ]);
translate([sizeX-2,0,sizeZ-9.5])cube([2,sizeY,9.5]); //lip
/*translate([sizeX-1,10,10])cube([4,22,8]); //12V connector hole*/
translate([sizeX-3,sizeY-14,6.5])
    rotate(a=[90,90,90])cylinder(r=4.5,h=4,$fn=100);//hole for the power cable
PerfX(sizeX-3,6,sizeY-22,6,35,10); //ventilation  
} 
/*difference(){
translate([sizeX,17,sizeZ])cube([2,16,15]); //ухо 
translate([sizeX-1,25,sizeZ+7])
  rotate(a=[0,90,0])cylinder(r=1,h=4,$fn=100);//Hole in the ear
}*/
difference () { //left face
translate([0,0,0])cube([2,sizeY,sizeZ]);
translate([40,sizeY-20,sizeZ-9.5])cube([2,20,9.5]); //clearance
PerfX(-1,6,sizeY-22,6,45,10); //ventilation
translate([-1,sizeY-8,14.5])cube([4,6,12]); //motor cable hole
translate([0,sizeY-9.5,sizeZ-9.5])cube([2,9.5,9.5]); //lip
/*translate([-1,9,35])
    rotate(a=[0,90,0])cylinder(r=6.5,h=4,$fn=100);//hole for the motor cable-removed to keep power and signal separate*/
}
difference () { //separator
translate([40,0,0])cube([2,sizeY,sizeZ]); //separator wall
translate([40,sizeY-20,sizeZ-9.5])cube([2,20,9.5]); //separator for terminals
translate([39,sizeY-14,6.5])
    rotate(a=[90,90,90])cylinder(r=4.5,h=4,$fn=100);//hole for the power cable
translate([39,sizeY-8,14.5])cube([4,6,12]); //motor cable hole
    }