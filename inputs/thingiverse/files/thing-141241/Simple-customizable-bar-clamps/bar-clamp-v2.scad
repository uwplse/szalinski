


//customizable something or other
// by PuZZleDucK...




//what to do... no imports doh!

//customizable clamp:
//    Bar diamiter
//    Clamp width
//    bolt size
//    camp length

  //barDiameter is the size of the bar you want to clamp to.
barDiameter = 50;//[2:400]

  //clampWidth is the thicknes of the clamp itself. Thicher clamps will be stronger and heavier.
clampWidth = 5;//[2:50]

  //clampLength is how long the clamp will be. Longer clamps will have greater friction, but require more space.
clampLength = 25;//[2:100]

  //boltSize is the size of the bolt holes on the side tabs. e.g. select 6 if you want to use m6 bolts.
boltSize = 6;//[3,4,6,8,10]


boltRadius = boltSize/2;
tabSize = boltRadius + 10;

//         /--------\
//        / /-------\\
//   ----/ //-------\\\------     x 2
//   --o--//         \\---o--
//   -----/           \------
//




//main components
//   side tabs... width of bolt-size + 10mm either side
//   rounded clamp... inner radius = diam/2, outer = diam/2 + clamp-width


splitWidth = ((barDiameter/2+clampWidth*2+tabSize)*2+10);


//main union
translate([0,0,clampWidth]) rotate([0,90,0]) union() {


//tabs
translate([0,barDiameter/2,0]) difference() {
    cube([clampWidth, tabSize+clampWidth, clampLength]);
    rotate([0,90,0]) translate([-clampLength/2,tabSize/2+clampWidth,0]) cylinder(clampWidth+1,boltRadius,boltRadius);
}//diff-union
translate([0,-(barDiameter/2+tabSize+clampWidth),0]) difference() {
    cube([clampWidth, tabSize+clampWidth, clampLength]);
    rotate([0,90,0]) translate([-clampLength/2,tabSize/2,0]) cylinder(clampWidth+1,boltRadius,boltRadius);
}//diff-union
/* //only one at a time
translate([0,-splitWidth+barDiameter/2,0]) difference() {
    cube([clampWidth, tabSize+clampWidth, clampLength]);
    rotate([0,90,0]) translate([-clampLength/2,tabSize/2+clampWidth,0]) cylinder(clampWidth+1,8,8);
}//diff-union
translate([0,-(barDiameter/2+tabSize+splitWidth+clampWidth),0]) difference() {
    cube([clampWidth, tabSize+clampWidth, clampLength]);
    rotate([0,90,0]) translate([-clampLength/2,tabSize/2,0]) cylinder(clampWidth+1,8,8);
}//diff-union
*/

//clamps
translate([clampWidth,0,0]) hollowTubeHalf(clampLength,barDiameter/2,barDiameter/2,clampWidth);
/* //only one
translate([0,-splitWidth,0]) hollowTubeHalf(clampLength,barDiameter/2,barDiameter/2,clampWidth);

*/

}//main union





//hollow halfs:
module hollowTubeHalf(length, r1, r2, width){
  difference() {
    difference(){
      cylinder(length, r1+width, r2+width);
      cylinder(length+10, r1, r2);
    }//diff
    translate([0,-r1*15,0]) cube([r1*20,r1*30,length]);
  }//diff-union
}

