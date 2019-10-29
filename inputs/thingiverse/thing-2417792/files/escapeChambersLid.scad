// Written by xoque (mwifall@gmail.com)
/**************************************
Lid for my custom Escape holder for chamber tiles
**************************************/

ChamberWidth=100;
ChamberHeight=75;
CurseLength=65;
CurseWidth=50;
CurseHeight=50;
TreasureWidth=30.1;
TreasureHeight=40;

lid(ChamberWidth,ChamberWidth,1.5,2.4,5);

module lid(LidWidth,LidLength, tol, Thickness, Edge)
{
    LidWidth=LidWidth+tol;
    LidLength=LidLength+tol;
    
    difference(){
        union(){
            //bottom structure
            cube([LidWidth+4*Thickness,LidLength+4*Thickness,Thickness]);
            
            //bottom and top walls
            translate([0,0,Thickness]) cube([LidWidth+Thickness*4,Thickness-.2,2*Thickness]);
            translate([0,LidLength+3*Thickness+.2,Thickness]) cube([LidWidth+Thickness*4,Thickness-.2,2*Thickness]);
            
            //side walls
            translate([0,0,Thickness]) cube([Thickness,LidLength+Thickness*4,2*Thickness]);
            translate([LidWidth+Thickness*3,0,Thickness]) cube([Thickness,LidLength+Thickness*4,2*Thickness]);

            //cylinders on side walls
            translate([LidWidth+4*Thickness-Thickness*0.7,Thickness+LidLength/5,4.5*Thickness-Thickness*1.7]) rotate([270,0,0]) cylinder($fn = 50, r = Thickness, h = 3*LidLength/5);
            translate([Thickness*0.7,Thickness+LidLength/5,4.5*Thickness-Thickness*1.7]) rotate([270,0,0]) cylinder($fn = 50, r = Thickness, h = 3*LidLength/5);
            }
    //Subtraction
    //hole in middle
    translate([0.2*LidWidth+2*Thickness, 0.2*LidLength+2*Thickness, 0]) cube([0.6*LidWidth, 0.6*LidLength, Thickness]);
    
    //Removing cutouts in top and bottom (non cylinder edges)
    translate([2*Edge+2*Thickness,0,Thickness]) cube([LidWidth-4*Edge,Thickness,2*Thickness]);
    translate([2*Edge+2*Thickness,LidLength+3*Thickness,Thickness]) cube([LidWidth-4*Edge,Thickness,3*Thickness]);

    //Removing cutouts in between cylinders
    translate([0,Thickness+2*LidLength/5-.2,Thickness]) cube([2*Thickness,LidLength/5+.4,3*Thickness]);
    translate([LidWidth+Thickness*2,Thickness+2*LidLength/5-.2,Thickness]) cube([2*Thickness,LidLength/5+.4,3*Thickness]);

    //Removing outside edges of cylinders
    translate([-Thickness,0,Thickness]) cube([Thickness,LidLength+Thickness*4,4*Thickness]);
    translate([LidWidth+Thickness*4,0,Thickness]) cube([Thickness,LidLength+Thickness*4,4*Thickness]);
}
}