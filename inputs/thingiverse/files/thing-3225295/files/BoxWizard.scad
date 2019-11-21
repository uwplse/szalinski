/* 
*  Copyright (c)..: 2018 janpetersen.com
*
*  Creation Date..:11/18/2018
*  Discription....: Box Wizard - OpenScad application to build fully parametric boxes
*
*  Rev 1: Developed Model
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  If used commercially attribution is required (janpetersen.com)
*
*
*   Thingiverse Customizer documentation:
*   http://customizer.makerbot.com/docs
*
*
*/

/* ----- customizer view ----- */
//preview[view:north, tilt:top]

/* ----- parameters ----- */

/* [Hidden] */
$fn=30; // recomended value for smooth circle is 60
debug = false;

// Standard screw dimensions arrays
//    [ screwDiameter (d), headDiameter (d1), headHeight (k) ]

CounterSunkScrewsMetric=[ 
// DIN963 slotted countersunk (flathead) head
        [0, 0, 0],            // "none"
        [1, 1.9, 0.6],      // "M1"
        [1.6, 3, 0.96],    // "M1.6"
        [2, 3.8, 1.2],      // "M2"
        [2.5, 4.7, 1.5],   // "M2.5"
        [3, 5.6, 1.65],    // "M3"
        [3.5, 6.5, 1.93], //"M3.5"
        [4, 7.5, 2.2],      // "M4"
        [5, 9.2, 2.5],      // "M5"
        [6, 11, 3],          // "M6"
        [8, 14.5, 4],       // "M8"
        [10, 18, 5],        // "M10"
        [12, 22, 6],        // "M12"
        [16, 29, 8]         // "M16"
  ];
  CounterSunkScrewsStandard=[
        [0, 0, 0],                        // "none"
        [0.021, 0.038, 0.019],   // "0000"
        [0.034, 0.059, 0.029],   // "000"
        [0.047, 0.082, 0.037],   // "00"
        [0.06, 0.096, 0.043],     // "0"
        [0.073, 0.118, 0.053],   // "1"
        [0.086, 0.140, 0.062],   // "2"
        [0.099, 0.161, 0.070],   // "3"
        [0.112, 0.183, 0.079],   //"4"
        [0.125, 0.205, 0.088],   // "5"
        [0.138, 0.226, 0.096],   // "6"
        [0.164, 0.270, 0.113],   // "8"
        [0.190, 0.313, 0.130],   // "10"
        [0.216, 0.357, 0.148],   // "12"
        [0.250, 0.414, 0.170],   // "1/4"
        [0.3125, 0.518, 0.211], // "5/16"
        [0.375, 0.622, 0.253],   // "3/8"
        [0.4375, 0.625, 0.265], // "7/16"
        [0.500, 0.750, 0.297],   // "1/2"
        [0.5625, 0.812, 0.336], // "9/16"
        [0.625, 0.875, 0.375],   // "5/8"
        [0.750, 1.000, 0.441]    // "3/4"
    ];

/* [Global] */

/* [Box] */
// internal width of box
width=50;   
// internal length of box
length=120; 
// internal height of box
height=60;  
// wall thickness in mm
wallThickness=3; 

/* [Fillets] */
// radius of inside fillet on box opening, set to 0 for no fillet
insideFillet=2; 


/* [Mounting Screws] */
Metric_Counter_Sunk=0; // [0:none, 1:M1, 2:M1.6, 3:M2, 4:M2.5, 5:M3, 6:M3.5, 7:M4, 8:M5, 9:M6, 10:M8, 11:M10, 12:M12, 13:M16]
Standard_Counter_Sunk=11; // [0:none, 1:0000, 2:000, 3:00, 4:0, 5:1, 6:2, 7:3, 8:4, 9:5, 10:6, 11:8, 12:10, 13:12, 14:1/4, 15:5/16, 16:3.8, 17:7/16, 18:1/2, 19:9/16, 20:5/8, 21:3/4]

/* [Stacking Slots] */
Add_Stacking_Slots="both"; // [none, side, end, both]
Slot_Width=5; 
Slot_Height=2; 
Slot_Chamfer=3; 
Slot_Length=45; 
// tolerance to allow for tight fit when mating the boxes
Slot_Clearance=0.2; 


/* ----- execute ----- */

mainModule();


/* ----- functions ----- */    
function inch_to_mm(inch) = inch / 0.039370;


/* ----- modules ----- */
module mainModule() {

    // if a mounting screw is selected, set the screw variables
    d = Metric_Counter_Sunk > 0 ? CounterSunkScrewsMetric[Metric_Counter_Sunk][0] : inch_to_mm( CounterSunkScrewsStandard[Standard_Counter_Sunk][0]);
    d1 = Metric_Counter_Sunk > 0 ? CounterSunkScrewsMetric[Metric_Counter_Sunk][1] : inch_to_mm( CounterSunkScrewsStandard[Standard_Counter_Sunk][1]);
    k = Metric_Counter_Sunk > 0 ? CounterSunkScrewsMetric[Metric_Counter_Sunk][2] : inch_to_mm( CounterSunkScrewsStandard[Standard_Counter_Sunk][2]);
    l = wallThickness;
    if ( debug ) {
        echo("Screw Diameter: " , d);
        echo("Screw Head Diameter: ", d1);
        echo("Screw Head Hight: ", k);
        echo("Screw Length: ", l);        
    }

    difference() {
        union() {
            cube( size=[
                    ( length+2*wallThickness ),
                    ( width+2*wallThickness ),
                    ( height+wallThickness ) 
                 ], center=true );
            if ( ( Add_Stacking_Slots == "both" || Add_Stacking_Slots == "side" ) && ( Slot_Width * 4 < length )) {
                translate( [ -length / 3, width / 2 + wallThickness, - ( height + wallThickness ) / 2 ] )
                    slot();
                translate( [ length / 3, width / 2 + wallThickness, - ( height + wallThickness ) / 2 ] )
                    slot();
            }
            if ( ( Add_Stacking_Slots == "both" || Add_Stacking_Slots == "end" ) && ( Slot_Width * 4 < width ) ) {
                translate( [ -length / 2 - wallThickness, width / 3, - ( height + wallThickness ) / 2 ] )
                    rotate( [ 0, 0, 90 ] )
                        slot();
                translate( [ -length / 2 - wallThickness, -width / 3, - ( height + wallThickness ) / 2 ] )
                    rotate( [ 0, 0, 90 ] )
                        slot();
            }
        }
        translate([0, 0, wallThickness/2 + 0.01 ])
            cube( size=[ length, width, height + 0.02 ], center=true );
        if ( d > 0 ) {
            translate( [ -length/3, 0, - height  / 2  + 0.01 ] )
                screwHole(d, d1, k, l + 0.02);
            translate( [ length/3, 0, - height  / 2  + 0.01 ] )
                screwHole(d, d1, k, l + 0.02);
        }
        if ( insideFillet > 0 )
            translate( [ 0, 0, (height  + wallThickness - insideFillet ) / 2] )
                insideFillet();

        if ( ( Add_Stacking_Slots == "both" || Add_Stacking_Slots == "side" ) && ( Slot_Width * 4 < length ) ) {
            translate( [ -length / 3, - width / 2 - wallThickness, - (height + wallThickness + Slot_Clearance ) / 2 ] )
                groove();
            translate( [ length / 3, - width / 2 - wallThickness, - (height + wallThickness + Slot_Clearance ) / 2 ] )
                groove();
        }
        if ( ( Add_Stacking_Slots == "both" || Add_Stacking_Slots == "end" ) && ( Slot_Width * 4 < width ) ) {
            translate( [ length / 2 + wallThickness, width / 3, - ( height + wallThickness + Slot_Clearance ) / 2 ] )
                rotate( [ 0, 0, 90 ] )
                    groove();
            translate( [ length / 2 + wallThickness, -width / 3, - ( height + wallThickness + Slot_Clearance ) / 2 ] )
                rotate( [ 0, 0, 90 ] )
                    groove();
        }

    }
}

module screwHole(d, d1, k, l) {
    // d = screw diameter
    // d1 = head diameter
    // k = head height
    // l = screw length

    chamferHeight = min( k, l );
    if ( debug ) {
        echo("Adjusted screw chamfer height: ", chamferHeight);
    }
    union() {
        cylinder( d=d, h=l + 0.02, center=true );
        if ( d1> d ) {
            translate( [ 0, 0, ( l - chamferHeight ) / 2 ] )
                cylinder( d1=d, d2=d1, h= chamferHeight, center=true );
        }
    }
}

module insideFillet() {
    difference() {
        cube(size=[ length + insideFillet * 2, width + insideFillet * 2, insideFillet ], center=true);
        translate( [ 0, width / 2 + insideFillet , -insideFillet / 2] )
            rotate( [ 0, 90, 0 ] )
                cylinder( r=insideFillet, h=length + insideFillet * 2 + 0.01, center=true );
        translate( [ 0, - width / 2 - insideFillet , -insideFillet / 2 ] )
            rotate( [ 0, 90, 0 ] )
                cylinder( r=insideFillet, h=length + insideFillet * 2 + 0.01, center=true );
        translate( [  length / 2 + insideFillet , 0, -insideFillet / 2 ] )
            rotate( [ 90, 0, 0 ] )
                cylinder( r=insideFillet, h=width + insideFillet * 2 + 0.01, center=true );
        translate( [  -length / 2 - insideFillet , 0, -insideFillet / 2 ] )
            rotate( [ 90, 0, 0 ] )
                cylinder( r=insideFillet, h=width + insideFillet * 2 + 0.01, center=true );
    }
}

module slot() {
    h = min( wallThickness - 1, Slot_Height );
    d1 = max( 1, Slot_Width - Slot_Chamfer );
    p = [
        [ Slot_Width / 2, h ],
        [ -Slot_Width / 2, h ],
        [ -d1 / 2, 0 ],
        [ d1 / 2, 0 ]
    ];
    if ( debug ) {
        echo( p );
    }
    linear_extrude( height=Slot_Length )
        polygon( points=p );
}

module groove() {
    h = min( wallThickness - 1, Slot_Height );
    d1 = max( 1, Slot_Width - Slot_Chamfer );
    p = [
        [ Slot_Width / 2, h ],
        [ -Slot_Width / 2, h ],
        [ -d1 / 2, 0 ],
        [ d1 / 2, 0 ]
    ];
    if ( debug ) {
        echo( p );
    }
    linear_extrude( height=Slot_Length + Slot_Clearance * 2)
        offset(delta=Slot_Clearance) polygon( points=p );
}
