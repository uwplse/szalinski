use <utils/build_plate.scad>
/* [Phone & lens dimensions] */

phoneWidth = 65.3;
phoneDepth = 13.7;

lensDiameter = 6.5;
lensDepth = 3;
// Distance from the right hand edge of the phone to the centre of the lens
lensOffset = 32.65;

/* [holder dimensions] */
armThick = 2;
armWidth = 10;
//Percentage of the camera width
clipLength = 10; //[0:50]

/* [Build plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* [Hidden] */
// All done. Customizer doesn't need to see all this
$fn = 20;

lensR = lensDiameter/2;

lensTranslate = [phoneWidth/2-lensOffset,(armWidth/2-(lensR+armThick)),0];
translate([0,0,armWidth/2])rotate([-90,0,0]){
difference(){
arm();
translate(lensTranslate)
lensHole();
}
translate(lensTranslate)
lens();
}
module lens(){
lipDepth = lensR/10;
holderH = lensDepth+2;
translate([0,0,-holderH+armThick])
difference(){
cylinder(r=lensR+armThick, h = holderH);
translate([0,0,1])cylinder(r=lensR, h = holderH);
cylinder(r=lensR-lipDepth, h = holderH*4, center = true);
//}
}
}
module lensHole(){
cylinder(r=lensR+armThick, h = lensDepth*8, center = true);
}

module arm(){
translate([0,-armWidth/2,0]){
translate([-phoneWidth/2,0,0])cube([phoneWidth,armWidth, armThick]);
sideClasp();
mirror([1,0,0]){
sideClasp();
}
}
}
module sideClasp(){
claspLength = phoneWidth * clipLength/100;
translate([phoneWidth/2,0,0])cube([armThick, armWidth, phoneDepth+2*armThick]);
translate([-claspLength+phoneWidth/2,0,phoneDepth+armThick])cube([claspLength, armWidth, armThick]);
}