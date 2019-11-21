// Bar clamp
// Glyn Cowles April 2019

// Diameter of hole for bolt 
boltDiam=3; 
// Width of slot for nut
nutWidth=5.4;
// Height of slot for nut
nutHeight=2.3;
// Height of clamp
ht=5; 
// Diameter of outer circle
diam=13;
// Diameter of bar
barDiam=8;
// Length of nut holder
holdY=12;
// Resolution
$fn=50; 
//--------------------------------------------------------------

rodClamp();

//--------------------------------------------------------------
module rodClamp() {
    difference() {
        union() {
            cylinder(d=diam,h=ht);
            translate([-diam/2,0,0]) cube([diam,holdY,ht]);
        }
            cylinder(d=barDiam,h=ht);
            translate([-nutWidth/2,holdY/2,0]) cube([nutWidth,nutHeight,ht]);
            #translate([0,0,ht/2]) rotate([-90,0,0]) cylinder(d=boltDiam,h=holdY);
    }
}
