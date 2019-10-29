// Written by xoque (mwifall@gmail.com)
/**************************************
Organizer for ESCAPE items - dice, meeples, character 
tokens, ghost, chalice, gems, and quest tokens
**************************************/

Thickness=1.6;  // Thickness of normal walls
ThicknessW=2.4; // Thickness of walls that the cover snaps into
Edge=2; // The edge of the dice storage
// Dice dimensions
DiceWidth=16.5;
// Meeple dimensions
MLength=20;
MWidth=11; 
MHeight=24;
MCutoff=9; // cutoff above meeples
// Ghost dimensions
GLength=24;
// Player token dimensions
PLength=40.6; //41
PWidth=7.6;
PThickness=1.2;  // Walls around player tokens
// Chalice dimensions
CDiameter=20;

// Quest marker dimensions
QDiameter=24;
QThickness=2.4;

// Gem token dimensions
GemLength=35;
GemWidth=18;

TLength=84.8;
//TotalLength=TLength+MWidth+2*Thickness+CDiameter;
TotalLength=9*Thickness+7*MWidth+CDiameter;
TWidth=4*ThicknessW+Thickness+2*DiceWidth+GLength+PWidth;
THeight=51.2;

// meeple hole = 20 x 11 x 21h (meeple is 30h)
// oval = 50 x 40 x 2.14

difference(){
    union() {
        cube([TWidth,TLength,THeight]);
        translate([2*DiceWidth+2*ThicknessW,-Thickness-MWidth,0]) {
            cube([GLength+2*ThicknessW+Thickness+PWidth,TotalLength,THeight]); }
    }
    translate([ThicknessW,ThicknessW,Thickness]) {
        cube([DiceWidth,TLength-2*ThicknessW,THeight]); }
    translate([ThicknessW+Edge,0,Thickness]) {
        cube([DiceWidth-2*Edge,TLength,THeight]); }
    translate([DiceWidth+2*ThicknessW,ThicknessW,Thickness]) {
        cube([DiceWidth,TLength-2*ThicknessW,THeight]); }
    translate([DiceWidth+2*ThicknessW+Edge,0,Thickness]) {
        cube([DiceWidth-2*Edge,TLength,THeight]); }

//Meeple cutouts
    translate([2*DiceWidth+3*ThicknessW,Thickness,THeight-MHeight-MCutoff]) {
        cube([MLength,MWidth,MHeight]); }
    translate([2*DiceWidth+3*ThicknessW,2*Thickness+MWidth,THeight-MHeight-MCutoff]) {
        cube([MLength,MWidth,MHeight]); }
    translate([2*DiceWidth+3*ThicknessW,3*Thickness+2*MWidth,THeight-MHeight-MCutoff]) {
        cube([MLength,MWidth,MHeight]); }
    translate([2*DiceWidth+3*ThicknessW,4*Thickness+3*MWidth,THeight-MHeight-MCutoff]) {
        cube([MLength,MWidth,MHeight]); }
    translate([2*DiceWidth+3*ThicknessW,5*Thickness+4*MWidth,THeight-MHeight-MCutoff]) {
        cube([MLength,MWidth,MHeight]); }
    translate([2*DiceWidth+3*ThicknessW,6*Thickness+5*MWidth,THeight-MHeight-MCutoff]) {
        cube([MLength,MWidth,MHeight]); }

// Ghost cutouts
    translate([2*DiceWidth+3*ThicknessW,-MWidth,THeight-MHeight-MCutoff]) {
        cube([GLength,MWidth,MHeight]); }

// Player adventurer token cutouts
    translate([2*DiceWidth+3*ThicknessW+Thickness+GLength,-MWidth,PThickness]) {
        cube([PWidth,PLength,THeight]); }
    translate([2*DiceWidth+3*ThicknessW+Thickness+GLength,-MWidth+Thickness+PLength,PThickness]) {
        cube([PWidth,PLength,THeight]); }

// Gem token cutout
    translate([2*DiceWidth+3*ThicknessW+Thickness+GLength,-MWidth+2*Thickness+2*PLength,THeight-GemLength-Thickness]) {
        cube([PWidth,GemWidth,THeight]); }

// Quest token cutout
    translate([2*DiceWidth+3*ThicknessW+MLength+Thickness,Thickness,THeight-QDiameter]) {
        cube([QThickness,QDiameter,QDiameter]); }
    translate([2*DiceWidth+3*ThicknessW+MLength+Thickness,QDiameter+2*Thickness,THeight-QDiameter]) {
        cube([QThickness,QDiameter,QDiameter]); }
    translate([2*DiceWidth+3*ThicknessW+MLength+Thickness,2*QDiameter+3*Thickness,THeight-QDiameter]) {
        cube([QThickness,QDiameter,QDiameter]); }

// Chalice cutout
    translate([2*DiceWidth+3*ThicknessW,7*Thickness+6*MWidth,THeight-MHeight-MCutoff]) {
        cube([CDiameter,CDiameter,MHeight]); }

// Cutoff the top of the meeple area
    translate([2*DiceWidth+3*ThicknessW,-Thickness-MWidth,THeight-MCutoff]) {
        cube([GLength+ThicknessW+Thickness+PWidth,TotalLength,MCutoff]); }
    translate([2*DiceWidth+2*ThicknessW,-Thickness-MWidth,THeight-MCutoff]) {
        cube([GLength+ThicknessW+Thickness+PWidth,MWidth+Thickness,MCutoff]); }
    translate([2*DiceWidth+2*ThicknessW,TLength,THeight-MCutoff]) {
        cube([GLength+ThicknessW+Thickness+PWidth,CDiameter,MCutoff]); }

// Snap fit holes
    translate([ThicknessW-ThicknessW*1.4,TLength/5*2,THeight-ThicknessW*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = ThicknessW, h = TLength/5);
    translate([ThicknessW-ThicknessW*1.4,TLength/5*4,THeight-ThicknessW*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = ThicknessW, h = TLength/5);

    translate([TWidth-ThicknessW+ThicknessW*1.4,TLength/5*2,THeight-MCutoff-ThicknessW*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = ThicknessW, h = TLength/5);
    translate([TWidth-ThicknessW+ThicknessW*1.4,TLength/5*4,THeight-MCutoff-ThicknessW*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = ThicknessW, h = TLength/5);

}
