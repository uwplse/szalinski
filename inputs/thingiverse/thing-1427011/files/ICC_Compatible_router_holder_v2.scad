// Trying to build icc device v2
// All measurements are in mm

// Wall Thickness
WallThickness = 2;

// Base dimensions
TopWidth = 163;   // [163:168]
TopDepth = 76.2;  // [35:77] 
TopHeight = 25.4;  //  [0:100]  

// Support
SupportWidth = 25.4;
SupportDepth = TopDepth;
SupportHeight = 2;

// Using mirroring we need half of this
HalfWidth = (TopWidth-SupportWidth)/2;

// Ragardless of Width & Depth the holes must always be
// 12mm apart (on centre) with a hole size of 6mm
// 153mm apart (on centre)

// Support Holes
SupportHoleRadius = 3;
SupportX = 153;
SupportY = 12;

// Studs
StudX = 20;
StudY = 20;
StudNeckHeight=3;  // [1:10]
StudNeckRadius=1.5; // [0.5:15]
StudCapHeight=3;  // [0.5:10]
StudCapRadius=2.5;  // [0.5:15]

// Modules

module Support() {
    
    union() {
        
        difference() {
            
            // Support
            translate([HalfWidth, 0, 0])
            cube([SupportWidth,SupportDepth,SupportHeight]);
               
            // Holes
            x_offset=(SupportX/2)+SupportHoleRadius;
            y_first=SupportY+SupportHoleRadius;

            for (a=[y_first:SupportY:SupportDepth]) {
                
                if( a < SupportDepth-(SupportHoleRadius*2) ) {
                    echo(a);
                    translate([x_offset, a, +1])
                    cylinder(h=SupportHeight+2, r=SupportHoleRadius, center=true);
                }
                
            }
            
        }
        
    }  
    
}


module Top() {

    translate([0, 0, TopHeight])
    cube([HalfWidth, TopDepth, WallThickness]);

}

module Side() {
    
    // Overlap the top by wall thickness
    translate([HalfWidth-WallThickness, 0, 0])
    cube([WallThickness, TopDepth, TopHeight]);
}

module Stud () {
        
    // Neck
    translate( [StudX, StudY, TopHeight+WallThickness+(StudCapHeight/2)] )
    cylinder(h=StudNeckHeight, r=StudNeckRadius, center=true);
    
    // Cap
    translate( [StudX, StudY, TopHeight+WallThickness+StudNeckHeight+(StudCapHeight/2)] )
    cylinder(h=StudCapHeight, r=StudCapRadius, center=true);
}


// Main

union() {
    Top();
    Side();
    Support();
    Stud();
}
mirror([1,0,0])
union() {
    Top();
    Side();
    Support();
    Stud();
}



/* END */