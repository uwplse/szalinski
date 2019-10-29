// Fan bracket for Small Brushless DC Fan
// Dimensions:
// H x W x D = 40 x 40 x 20.2mm
// Hole raster 31.5 x 31.5mm
// 
// For mounting on a flat surface using brackets on either side
// Two brackets must be printed
//
// Version 0.1

$fn=50;

W=40; // Width (equals height)
Drotor=37; // Fan in- outlet diameter 37mm
hole=4.2; // Mounting holes
grid=31.5; // Mounting hole grid
depth=20.5; // Fan depth

Hbr=8; //Bracket height
Tbr=2; //Bracket thickness
Hbp=2*Tbr; //Base plate height

//Shape to match fan dimensions
difference(){
cube ([W,Hbr,Tbr]);
translate(v=[(W/2)-(grid/2),(W/2)-(grid/2),0]){ cylinder(h=Tbr, d=hole); }
translate(v=[(W/2)+(grid/2),(W/2)-(grid/2),0]){ cylinder(h=Tbr, d=hole); }
translate(v=[(W/2), W/2,0]){ cylinder(h=Tbr, d=Drotor); }
}

//Slots to snap into base plate
translate(v=[(W/2)-(grid/2)-hole,-Hbp,0]){cube ([hole*2,Hbp,Tbr]);}
translate(v=[(W/2)-hole,-Hbp,0]){cube ([hole*2,Hbp,Tbr]);}
translate(v=[(W/2)+(grid/2)-hole,-Hbp,0]){cube ([hole*2,Hbp,Tbr]);}