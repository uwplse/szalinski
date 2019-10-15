//Please use the Customizer to interact with this (if necessary, show it by clearing the checkbox in front of View | Hide Customizer), and close this Editor window.

/* [Overview] */
//Part
PARTNO = "0"; // [0:All, 1:Front, 2:Back, 3:Left Side, 4:Right Side, 5:Top, 6:Bottom,7:Dividers]

//Endmill Diameter
diameter=3.175;

//Part Spacing
partspacing=4;

/* [Size] */

//Thickness
thickness = 5;

//Width
width = 70;

//Height
height = 20;

//Length
length = 40;

conversionfactor = 1*1;

cwidth = width*conversionfactor;
clength = length*conversionfactor;
cheight = height*conversionfactor;
cthickness = thickness*conversionfactor;
cbottomlidthickness=thickness*conversionfactor;
cpartspacing=partspacing*conversionfactor*5;

cdiameter = diameter*conversionfactor;

cinteriorwidth = cwidth-cthickness*2;
cinteriorlength = clength-cthickness*2;

cinteriorheight=cheight-cbottomlidthickness*2-cthickness;

//Front
module Front() {difference() {
translate([0, 0, cthickness/2]) {    cube(size = [cwidth,cthickness,cheight-cthickness], center = false);}
translate([-cthickness*0.1,cthickness/2,cthickness*0.05])cube(size = [cthickness*1.1,cthickness/2*1.1,cheight], center = false);
translate([cwidth-cthickness,cthickness/2,cthickness*0.05])cube(size = [cthickness*1.1,cthickness/2*1.1,cheight], center = false);
}}

//Back
module Back() {translate([0, clength-cthickness+cpartspacing, cthickness/2]) {
    difference() {
    cube(size = [cwidth,cthickness,cheight-cthickness], center = false);
translate([-cthickness*0.1,-cthickness*0.1,-cthickness*0.05])cube(size = [cthickness*1.1,cthickness/2*1.1,cheight], center = false);
translate([cwidth-cthickness,-cthickness*0.1,-cthickness*0.05])cube(size = [cthickness*1.1,cthickness/2*1.1,cheight], center = false);
    }}}

//LeftSide
module LeftSide() {translate([cthickness-cpartspacing, cthickness/2, cthickness/2]) {
    rotate([0, 0, 90]) {
difference() {
    cube(size = [clength-cthickness,cthickness,cheight-cthickness], center = false);}}}}

//RightSide
module RightSide() {translate([cwidth+cpartspacing, cthickness/2, cthickness/2]) {
    rotate([0, 0, 90]) {
difference() {
    cube(size = [clength-cthickness,cthickness,cheight-cthickness], center = false);}}}}

//Top
module Top() {translate([cthickness-cbottomlidthickness, cthickness-cbottomlidthickness, cheight+cpartspacing-cthickness]) {difference() {
    cube(size = [cwidth-cthickness*2+cbottomlidthickness*2,clength-cthickness*2+cbottomlidthickness*2,cbottomlidthickness], center = false);
translate([-cthickness*0.1,-cthickness*0.1,-cthickness*0.05])cube(size = [cwidth*1.2,cthickness*1.1,cthickness*1.1/2], center = false);
translate([-cthickness*0.1,clength-cthickness,-cthickness*0.05])cube(size = [cwidth*1.2,cthickness*1.1,cthickness*1.1/2], center = false);
translate([-cthickness*0.1,-cthickness*0.1,-cthickness*0.05])cube(size = [cthickness*1.1,clength*1.2,cthickness*1.1/2], center = false);
translate([cwidth-cthickness,-cthickness*0.1,-cthickness*0.05])cube(size = [cthickness*1.1,clength*1.2,cthickness*1.1/2], center = false);
};
};
}

//Bottom
module Bottom() {translate([cthickness-cbottomlidthickness, cthickness-cbottomlidthickness, -cpartspacing]) {difference() {
    cube(size = [cwidth-cthickness*2+cbottomlidthickness*2,clength-cthickness*2+cbottomlidthickness*2,cbottomlidthickness], center = false);
translate([-cthickness*0.1,-cthickness*0.1,cthickness/2])cube(size = [cwidth*1.2,cthickness*1.1,cthickness*1.1/2], center = false);
translate([-cthickness*0.1,clength-cthickness,cthickness/2])cube(size = [cwidth*1.2,cthickness*1.1,cthickness*1.1/2], center = false);
translate([-cthickness*0.1,-cthickness*0.1,cthickness/2])cube(size = [cthickness*1.1,clength*1.2,cthickness*1.1/2], center = false);
translate([cwidth-cthickness,-cthickness*0.1,cthickness/2])cube(size = [cthickness*1.1,clength*1.2,cthickness*1.1/2], center = false);
};
};
};


// [0:All, 1:Front, 2:Back, 3:Left Side, 4:Right Side, 5:Top, 6:Bottom

 if (PARTNO == "1") Front();
 if (PARTNO == "2") Back();
 if (PARTNO == "3") LeftSide();
 if (PARTNO == "4") RightSide();
 if (PARTNO == "5") Top();
 if (PARTNO == "6") Bottom();
       
  // optionally use 0 for whole object
 if (PARTNO == "0") {
   Front();
   Back();
   LeftSide();
   RightSide();
   Top();
   Bottom();
 }