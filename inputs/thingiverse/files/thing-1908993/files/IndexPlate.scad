// 
// Index Plate 
// (c) 2016 Buffcleb
//

Plate_Diameter = 127;                   // Diameter of plate  in mm
Plate_Thickness = 6.4;                  // Thickness of the plate in mm

Index_Hole_Diameter = 3.7;              // Diameter of plate holes in mm
Index_Offset = 6;                       // Distance from outside of plate for the first ring in mm
Index_Row_Offset = 5;                   // distance between rows of rings in mm


Mount_Center_Diameter = 29;             // Diameter of mounting hole in mm
Mount_Ring_Diameter=44.5;               // Diameter of the ring used for mounting bolts in mm
Mount_Ring_Screw_Inner_Diameter=6.6;    // Diameter of mounting bolts in mm
Mount_Ring_Screw_Outer_Diameter=14.25;  // Diameter of head of the mounting bolt in mm - user for counter sinking
Mount_Ring_Screw_Counter_Sync=2.7;      // Distance from plate bottom for the counter sink in mm
Mount_Ring_Screw_Count=3;               // Number of screws used for mount in mm

intervals = [33,31,29,27,23,21];        // divisions of each ring, These must be listed largest to smallest
//intervals = [8,6,5,4,3]; 

$fn=30;

// Module that creates a ring 
// RingD - Diameter of the ring
// Divisions - the number of holes in the ring
module ring(RingD,Divisions){
    for (i=[0:Divisions]){
        rotate([0,0,360/Divisions*i]) translate([RingD,0,-.5]) cylinder(h=Plate_Thickness+1,d=Index_Hole_Diameter,$fn=20);
    }
}

// Main iteration of list
difference(){

    cylinder(h=Plate_Thickness,d=Plate_Diameter,$fn=120);
    for (j=[0:(len(intervals)-1)]){
        ring(Plate_Diameter/2-Index_Offset-(j*Index_Row_Offset), intervals[j]);
    }

     cylinder(h=Plate_Thickness+1,d=Mount_Center_Diameter);
    for (Mi=[0:Mount_Ring_Screw_Count]){
        rotate([0,0,360/Mount_Ring_Screw_Count*Mi]) translate([Mount_Ring_Diameter/2,0,-.5]) cylinder(h=Plate_Thickness+1,d=Mount_Ring_Screw_Inner_Diameter,$fn=20) ;
    }
    
    for (Mi=[0:Mount_Ring_Screw_Count]){
        rotate([0,0,360/Mount_Ring_Screw_Count*Mi]) translate([Mount_Ring_Diameter/2,0,Mount_Ring_Screw_Counter_Sync+.1]) cylinder( h = Plate_Thickness-Mount_Ring_Screw_Counter_Sync, r2 = Mount_Ring_Screw_Outer_Diameter/2, r1 =Mount_Ring_Screw_Inner_Diameter/2 );
    }
    
    
}
