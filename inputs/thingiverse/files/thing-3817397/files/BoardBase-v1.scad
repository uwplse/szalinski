$fn=100;

boardWith = 49; // PC Board Width
boardLength = 28; // PC Board Length

wallThickness = 3; // Wall thickness of the base
baseHigh = 8; // The Base Hight

ThT = true; // Through Hole Tracks; False for Serface Mount Components

difference(){
    Base(boardWith,boardLength,baseHigh, wallThickness, 2);
    if (ThT == true){
        TrackCounterSink(w=boardWith,
            l=boardLength,
            h=baseHigh, 
            depth=5, 
            relief=4);
    }
}


module SideClip(w,l,h){
    
}

module TrackCounterSink(w,l,h,depth, relief){
    
    sinkWidth = w-(2*relief);
    sinklength = l-(2*relief);
    echo(h-depth);
    translate([relief,relief,h-depth])
        cube([sinkWidth,sinklength,h+2]);
}

module Base(w,l,h,t,depth){
    difference(){
        
        minkowski(){
            cube([w,l,h]);
            cylinder(r=t,h=1);
        }

        translate([0,0,h-depth])
            cube([w,l,h]);        
    }
}
