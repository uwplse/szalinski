// Written by xoque (mwifall@gmail.com)
/**************************************
Lid for my custom Escape holder for character meeples,
adventurer tokens, dice, chalice, ghost, gems, and quest tokens
**************************************/

Edge=5;
tol=1.5;
tol2=0.4;
Thickness=2.4;
ThicknessS=1.6;

// Dice dimensions
DiceWidth=16.5;
// Meeple dimensions
MWidth=11; 
MCutoff=9; // cutoff above meeples

// Ghost dimensions
GLength=24;
// Player token dimensions
PWidth=7.6;

// Chalice dimensions
CDiameter=20;

TLength=84.8+tol;
//TotalLength=TLength+MWidth+2*Thickness+CDiameter;
TotalLength=9*ThicknessS+7*MWidth+CDiameter+tol;
TWidth=4*Thickness+ThicknessS+2*DiceWidth+GLength+PWidth+tol;

    difference(){
        union(){
            //bottom structure
            translate([0,0,0]) {
                cube([2*DiceWidth+2*Thickness+tol2,TLength+2*Thickness,3*Thickness]); }
            translate([2*DiceWidth+2*Thickness+tol2,-Thickness-MWidth,-MCutoff]) {
                cube([GLength+4*Thickness+ThicknessS+PWidth+tol2,TotalLength+2*Thickness,3*Thickness+MCutoff]); }
            }

    //Subtraction
    //making walls
    translate([Thickness,Thickness,-MCutoff]) {
        cube([2*DiceWidth+2*ThicknessS+2*Thickness+tol2,TLength,2*Thickness+MCutoff]); }
    translate([2*DiceWidth+3*Thickness+tol2,-MWidth,-MCutoff]) {
        cube([GLength+ThicknessS+PWidth+2*Thickness+tol2,TotalLength,2*Thickness+MCutoff]); }
    }


    difference() {
        union() {
    //Snaps
            translate([Thickness*0.7,Thickness+TLength/5*2-tol,-1.5*Thickness+Thickness*1.7]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TLength/5-2*tol);
            translate([Thickness*0.7,Thickness+TLength/5*4-tol,-1.5*Thickness+Thickness*1.7]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TLength/5-2*tol);

    //Snaps            
            translate([2*DiceWidth+2*Thickness+GLength+4*Thickness+ThicknessS+PWidth+2*tol2-Thickness*0.7,Thickness+TLength/5*2-tol,-MCutoff-1.5*Thickness+Thickness*1.7]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TLength/5-2*tol);
            translate([2*DiceWidth+2*Thickness+GLength+4*Thickness+ThicknessS+PWidth+2*tol2-Thickness*0.7,Thickness+TLength/5*4-tol,-MCutoff-1.5*Thickness+Thickness*1.7]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TLength/5-2*tol);    
        }
    
    //Cutting off sides of cylinders
    translate([-Thickness,0,-Thickness]) cube([Thickness, 4*Thickness+TLength, 4*Thickness]);
    translate([2*DiceWidth+2*Thickness+GLength+4*Thickness+ThicknessS+PWidth+2*tol2,-Thickness-MWidth,-MCutoff-Thickness]) cube([Thickness, TotalLength+4*Thickness, 4*Thickness+MCutoff]);
    
    }
