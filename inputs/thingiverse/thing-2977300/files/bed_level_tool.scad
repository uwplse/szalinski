BX=220; //Bed X dimension in mm
BY=220; //Bed Y dimension in mm
LH=.4; //Initial layer height
SQ=20; //Size of square pads
OFF=30; //Offset from edges in mm
module Target(){
    cube([SQ,SQ,LH],center=true);
}
MFact = OFF+SQ/2;
MX = BX-MFact;
MY = BY-MFact;
translate([MFact,MFact,0])Target();
translate([MX,MFact,0])Target();
translate([MFact,MY,0])Target();
translate([MX,MY,0])Target();
translate([BX/2,BY/2,0])Target();