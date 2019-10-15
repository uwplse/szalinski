$fn=75;
WasherDiameter=10;
HoleDiameter=5;
BottomThickness=3;
TopThickness=3;
TopDiameter=8;
DOffset=2;

module Washer($od=WasherDiameter, $id=HoleDiameter, $thickness1=BottomThickness) {
    difference() {
        cylinder(r = $od*2, h = $thickness1, center = true);
        cylinder(r = $id*2, h = $thickness1+1, center = true);
    }
}

module DLock($dod=TopDiameter, $dist=DOffset, $id=HoleDiameter, $od=WasherDiameter, $thickness2=TopThickness) {
    difference() {
        Washer($dod, $id, $thickness2);
        
    
    translate([-$dod*2, $id*2+$dist, -$thickness2/2]) {
        cube([$dod*4,($od-$id)*2,$thickness2+1]);
    }
}
}

module DWasher($od=WasherDiameter, $id=HoleDiameter, $thickness1=BottomThickness, $thickness2=TopThickness, $dist=DOffset) {
    union() {
        Washer();
        translate([0,0,$thickness1]) {
            DLock();
        }
    }
}

DWasher();