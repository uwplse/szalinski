// Written by xoque (mwifall@gmail.com)
/**************************************
Custom Escape organizer for chamber, curse, and treasure tiles
I used this specifically for the leftover ones I had, which
includes Module 3 (Illusion), Module 4 (Special),
Module 5 (Quest chambers), Module 6 (Characters),
Queenie 1 (The Pit), Queenie 2 (Doomed), and
Queenie 4 (The Fountain) but not all the curses from these

Heights are easily adjustable to fit other modules.
**************************************/
Edge=5;
tol=1.5;

ChamberWidth=100+tol;
ChamberHeight=38+tol;
CurseLength=65+tol;
CurseWidth=50+tol;
CurseHeight=36+tol;
TreasureWidth=30.1+tol;
TreasureHeight=13+tol;

Thickness=2.4;
Adjoiner=Thickness*5;

difference(){
    union() {
        cube([ChamberWidth+2*Thickness,ChamberWidth+2*Thickness,ChamberHeight+Thickness]);
        translate([ChamberWidth+Thickness,0,0])
            cube([Adjoiner,ChamberWidth+2*Thickness,2*Thickness]);
        translate([Adjoiner+ChamberWidth+Thickness,0,0])
            cube([TreasureWidth+2*Thickness,TreasureWidth+2*Thickness,TreasureHeight+Thickness]);
        translate([Adjoiner+ChamberWidth+Thickness,TreasureWidth+Thickness,0])
            cube([CurseWidth+2*Thickness,CurseLength+2*Thickness,CurseHeight+Thickness]);
    }
    //holes for chamber cards
    translate([Thickness,Thickness,Thickness]) {
        cube([ChamberWidth,ChamberWidth,ChamberHeight]); }
    translate([Thickness+Edge,0,Thickness]) {
        cube([ChamberWidth-2*Edge,ChamberWidth+2*Thickness,ChamberHeight]); }
    //Snap fit holes
    translate([Thickness-Thickness*1.4,ChamberWidth/5*2,ChamberHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = ChamberWidth/5);
    translate([Thickness-Thickness*1.4,ChamberWidth/5*4,ChamberHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = ChamberWidth/5);
    translate([ChamberWidth+Thickness+Thickness*1.4,ChamberWidth/5*2,ChamberHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = ChamberWidth/5);
    translate([ChamberWidth+Thickness+Thickness*1.4,ChamberWidth/5*4,ChamberHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = ChamberWidth/5);

    //holes for treasure cards
    translate([Adjoiner+ChamberWidth+2*Thickness,Thickness,Thickness]) {
        cube([TreasureWidth,TreasureWidth,TreasureHeight]); }
    translate([Adjoiner+ChamberWidth+2*Thickness+Edge,0,Thickness]) {
        cube([TreasureWidth-2*Edge,TreasureWidth+2*Thickness,CurseHeight]); }
    //Snap fit holes
    translate([Adjoiner+ChamberWidth+2*Thickness-Thickness*1.4,TreasureWidth/5*2,TreasureHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TreasureWidth/5);
    translate([Adjoiner+ChamberWidth+2*Thickness-Thickness*1.4,TreasureWidth/5*4,TreasureHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TreasureWidth/5);
    translate([Adjoiner+TreasureWidth+ChamberWidth+2*Thickness+Thickness*1.4,TreasureWidth/5*2,TreasureHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TreasureWidth/5);
    translate([Adjoiner+TreasureWidth+ChamberWidth+2*Thickness+Thickness*1.4,TreasureWidth/5*4,TreasureHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = TreasureWidth/5);


    //holes for curse cards
    translate([Adjoiner+ChamberWidth+2*Thickness,TreasureWidth+2*Thickness,Thickness]) {
        cube([CurseWidth,CurseLength,CurseHeight]); }
    translate([Adjoiner+ChamberWidth+2*Thickness+Edge,TreasureWidth+2*Thickness,Thickness]) {
        cube([CurseWidth-2*Edge,CurseLength+Thickness,CurseHeight]); }
    //Snap fit holes
    translate([Adjoiner+ChamberWidth+2*Thickness-Thickness*1.4,TreasureWidth+2*Thickness+CurseLength/5*2,CurseHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = CurseLength/5);
    translate([Adjoiner+ChamberWidth+2*Thickness-Thickness*1.4,TreasureWidth+2*Thickness+CurseLength/5*4,CurseHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = CurseLength/5);
    translate([Adjoiner+CurseWidth+ChamberWidth+2*Thickness+Thickness*1.4,TreasureWidth+2*Thickness+CurseLength/5*2,CurseHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = CurseLength/5);
    translate([Adjoiner+CurseWidth+ChamberWidth+2*Thickness+Thickness*1.4,TreasureWidth+2*Thickness+CurseLength/5*4,CurseHeight+Thickness-Thickness*1.5]) rotate([90,0,0]) cylinder($fn = 50, r = Thickness, h = CurseLength/5);
}
