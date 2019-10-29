
// Depth of the stand, in mm. 
StandDepth = 25;

// Total height of the stand
StandHeight = 100;

// Width of the base of the stand
BaseWidth = 200;

// Width of the slot in the stand. Must be smaller than the width of the base.
SlotWidth = 102;

// Height of the connecting bridge between the two vertical supports. 
BaseHeight = 7.5;

// Size of the edges on the top and side.
MinEdgeWidth = 2.5;

// Number of ridges in the support.
NrRidges = 4;

/* [Hidden] */
 ridgeWidth = StandDepth / (2 * NrRidges - 1);
 
module ridgeDuplicator() {
    for (y = [-StandDepth/2 + ridgeWidth : 2*ridgeWidth : StandDepth/2])
            translate([0,y, 0])
                children(0);
}

module slot() {
    translate([-SlotWidth/2, 0 , BaseHeight]) 
        union() {
             translate([ 0, -StandDepth/2 - .5 , 0]) cube([SlotWidth, StandDepth + 1, StandHeight - BaseHeight + .5]); 
              ridgeDuplicator() 
                 translate([0,0,-MinEdgeWidth])
                    cube([SlotWidth, ridgeWidth, MinEdgeWidth + 1]);
        }
}

module base() {
    supportWidth = (BaseWidth - SlotWidth)/2 - MinEdgeWidth;
    supportHeight = StandHeight - MinEdgeWidth;
    supportXOffset = SlotWidth / 2 +supportWidth + MinEdgeWidth;
    supportZOffset = supportHeight + MinEdgeWidth;
    
    module cutOut() {
        ridgeDuplicator()
             scale([supportWidth, ridgeWidth, supportHeight])rotate(a=90, v=[-1,0,0] ) cylinder( $fn=50);
    }
    
    difference() {
        hull() {
            cube([BaseWidth, StandDepth, .1], center=true);
            translate([0,0, MinEdgeWidth]) cube([BaseWidth, StandDepth, .1], center=true);
            translate([0,0,StandHeight]) cube([SlotWidth + 2*MinEdgeWidth, StandDepth, .1], center=true);
        }
        translate([supportXOffset, 0, supportZOffset]) cutOut();
        translate([-supportXOffset, 0, supportZOffset]) cutOut();
    }
}

difference() {
    base();
    slot();   
}
