// battery-organizer.scad
// library for parametric battery tray, organizer, holder, container, box, storage
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: April 2019



// Battery Type (diameter in mm)
Battery_Type = 19; //[9:AAAA, 11:AAA, 15:AA, 18:A, 19:18650, 22:B, 27:C, 35:D]

// How many batteries deep (1 or more)
Battery_Count_Row = 1;

// How many batteries wide (1 or more)
Battery_Count_Column = 2;

/* [Hidden] */

$fn=30;
TZT_D=Battery_Type;
TZT_R=Battery_Count_Row;
TZT_C=Battery_Count_Column;

//-----------------------

TZT_Tray ([TZT_D,TZT_R,TZT_C]);

//-----------------------

module TZT_Cell (TZT) {
    cylinder (25,TZT/2,TZT/2,true);
}

module TZT_Tray (TZT) {
    difference () {
        hull ()
            for (x=[0:TZT[1]-1])
            for (y=[0:TZT[2]-1])
            translate ([(TZT[0]+1)*(x),(TZT[0]+1)*(y),0])
            TZT_Cell (TZT[0]+2);
        for (x=[0:TZT[1]-1])
            for (y=[0:TZT[2]-1])
            translate ([(TZT[0]+1)*(x),(TZT[0]+1)*(y),2])
            TZT_Cell (TZT[0]);    
    }
}
