//z axis coupler
// Glyn Cowles Dec 2017
$fn=75;
lScrewD=8.35; //lead screw diam
sScrewD=5.3; // stepper diam
oDiam=20; // outer diam
ht=25; // overall height 
nWd=5.6; // nut width
nHt=2.6; // nut height
sDiam=3.1; // holding screw diam
sDist=6; // distance to screws
add=5; // extra height on nut space to clear top/bottom


//test();
main();
//-----------------------------------------------------------
module test() { // to test fit of shafts and nut
    x=12; // diam
    z=4; // height
difference() {
    union() {
        translate([0,0,0]) tube(sScrewD,x,z);
        translate([4.5,-5,0]) cube([6,10,z]);
        translate([15,0,0]) tube(lScrewD,x,z);
        }
    translate([6.5,-2.5,0])  cube([nHt,nWd,nWd]);
    }
}
//-----------------------------------------------------------
module main() {
difference() {
    union() {
        translate([0,0,0]) tube(sScrewD,oDiam,ht/2);
        translate([0,0,ht/2]) tube(lScrewD,oDiam,ht/2);
        }
    translate([.3,0,sDist]) rotate([0,90,0]) cylinder(d=sDiam,h=oDiam/2);
    translate([.3,0,ht-sDist]) rotate([0,90,0]) cylinder(d=sDiam,h=oDiam/2);
    translate([oDiam/4,-nWd/2,sDist-nWd/2-add])  cube([nHt,nWd,nWd+add]);
    translate([oDiam/4,-nWd/2,ht-sDist-nWd/2]) cube([nHt,nWd,nWd+add]);
    }
}
//-----------------------------------------------------------
module tube(di,do,h) {

difference() {
cylinder(h=h,d=do);
cylinder(h=h,d=di);
}
}

