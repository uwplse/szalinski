// Baseplate for Brushless DC Fan 12V/0.12A
// Dimensions:
// H x W x D = 40 x 40 x 20.5mm(NoTypo!)
// Hole raster 31.5 x 31.5mm
// 
// For mounting on a flat surface using brackets on either side
// Two brackets must be printed
//
// Version 0.1

$fn=50;

W=40; //Width (equals height)
Wbp=W+24; //Base Plate Width
Drotor=37; // Fan in- outlet diameter 37mm
grid=31.5; // Mounting hole grid
depth=20.0; // Fan depth with correction

Hbr=8; //Bracket height
Tbr=2; //Bracket thickness
Hfp=2*Tbr; //Face plate height
Dbp=depth+2*Tbr; //
clearance=0.4; //Clearance per side. Typically equals nozzle diameter. 
hole=4.0; // Mounting holes
slot=hole+clearance; //Please do not Modify. This represents half the slot width

//Baseplate with holes & cutouts
difference(){
cube ([Wbp,Dbp,Hfp]);
//Mounting holes
translate(v=[(Wbp/2)-(W/2)-((Wbp-W)/4),(Dbp/2)-(Dbp/4),0])
    { cylinder(h=Hfp, d=hole); }
translate(v=[(Wbp/2)-(W/2)-((Wbp-W)/4),(Dbp/2)+(Dbp/4),0])
    { cylinder(h=Hfp, d=hole); }
translate(v=[(Wbp/2)+(W/2)+((Wbp-W)/4),(Dbp/2)-(Dbp/4),0])
    { cylinder(h=Hfp, d=hole); }
translate(v=[(Wbp/2)+(W/2)+((Wbp-W)/4),(Dbp/2)+(Dbp/4),0])
    { cylinder(h=Hfp, d=hole); }
//Slots    
translate(v=[(Wbp/2)-(grid/2)-slot,0,0]){cube ([slot*2,Tbr,Hfp]);}
translate(v=[(Wbp/2)-slot,0,0]){cube ([slot*2,Tbr,Hfp]);}
translate(v=[(Wbp/2)+(grid/2)-slot,0,0]){cube ([slot*2,Tbr,Hfp]);}

translate(v=[(Wbp/2)-(grid/2)-slot,(Dbp-Tbr),0]){cube([slot*2,Tbr,Hfp]);}
translate(v=[(Wbp/2)-slot,(Dbp-Tbr),0]){cube ([slot*2,Tbr,Hfp]);}
translate(v=[(Wbp/2)+(grid/2)-slot,(Dbp-Tbr),0]){cube([slot*2,Tbr,Hfp]);}
}

