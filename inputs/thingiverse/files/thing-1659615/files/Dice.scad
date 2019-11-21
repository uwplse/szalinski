fn = 100;
fontType = "Arial";
letter_height = 5;
letter_size = 40;
cube_size = 60;
roundness = 1.55;
/* [trueorfalse] */
generate_body = "true";
generate_numbers = "true";
generate_baseNums = "false";
/* [numOne] */
gen_One = "true";
gen_OneBase = "true";
numOne = "1";
numOneX = -15;
numOneY = -20;
/* [numTwo] */
gen_Two = "true";
gen_TwoBase = "true";
numTwo = "2";
numTwoX = -15;
numTwoY = 20;
/* [numThree] */
gen_Three = "true";
gen_ThreeBase = "true";
numThree = "3";
numThreeX = 15;
numThreeY = 27;
/* [numFour] */
gen_Four = "true";
gen_FourBase = "true";
numFour = "4";
numFourX = -15;
numFourY = -27;
/* [numFive] */
gen_Five = "true";
gen_FiveBase = "true";
numFive = "5";
numFiveX = -27;
numFiveY = 15;
/* [numSix] */
gen_Six = "true";
gen_SixBase = "true";
numSix = "6";
numSixX = 27;
numSixY = -15;
/* [Hidden] */


o = cube_size / 2 - letter_height / 2;
doDual();
doBody();    

module doDual() {
if (generate_numbers == "true") {
translate([0,0,0]) dual();
}
}
module doBody() {
if(generate_body == "true") {
    if(generate_baseNums == "true") {
difference() {
intersection() {
color("gray") cube(cube_size, center = true);
    
    color("red") sphere(cube_size/roundness,$fn = fn, center=true);
}
//Top
if(gen_OneBase == "true") {
translate([numOneX,numOneY,o], center=true) linear_extrude(height = letter_height) {
text(numOne, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_TwoBase == "true") {
translate([numTwoX,numTwoY,-o], center=true)
rotate([180,0,0])linear_extrude(height = letter_height) {
text(numTwo, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_ThreeBase == "true") {
translate([numThreeX,numThreeY,-o+5], center=true)
rotate([90,0,180])linear_extrude(height = letter_height) {
text(numThree, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_FourBase == "true") {
translate([numFourX,numFourY,-o+5], center=true)
rotate([90,0,360])linear_extrude(height = letter_height) {
text(numFour, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_FiveBase == "true") {
translate([numFiveX,numFiveY,-o+5], center=true)
rotate([90,0,270])linear_extrude(height = letter_height) {
text(numFive, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_SixBase == "true") {
translate([numSixX,numSixY,-o+5], center=true)
rotate([90,0,90])linear_extrude(height = letter_height) {
text(numSix, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
}
}
else {
 intersection() {
color("gray") cube(cube_size, center = true);
    
    color("red") sphere(cube_size/roundness,$fn = fn, center=true);
}   
}
}
}
////////////////////////
module dual() {
if(gen_One == "true"){
translate([numOneX,numOneY,o], center=true) linear_extrude(height = letter_height) {
text(numOne, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_Two == "true"){
translate([numTwoX,numTwoY,-o], center=true)
rotate([180,0,0])linear_extrude(height = letter_height) {
text(numTwo, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_Three == "true"){
translate([numThreeX,numThreeY,-o+5], center=true)
rotate([90,0,180])linear_extrude(height = letter_height) {
text(numThree, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_Four == "true"){
translate([numFourX,numFourY,-o+5], center=true)
rotate([90,0,360])linear_extrude(height = letter_height) {
text(numFour, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_Five == "true"){
translate([numFiveX,numFiveY,-o+5], center=true)
rotate([90,0,270])linear_extrude(height = letter_height) {
text(numFive, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
//
if(gen_Six == "true"){
translate([numSixX,numSixY,-o+5], center=true)
rotate([90,0,90])linear_extrude(height = letter_height) {
text(numSix, size = letter_size, font = fontType, hallign = "center", vallign = "center", $fn = 16);
}
}
}