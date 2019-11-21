// customisable caribiner Glyn Cowles Dec 2018
// diam of top ring
d1=15; 
// diam of bottom ring
d2=40; 
// distance between centres
dis=35;
// thickness
th=4; 
// height
ht=5; 
// gap size
gap=.15;
// resolution
$fn=60; 

color("gray") linear_extrude(ht) main();

//------------------------------------------------------------
module main() {
    difference() {
    struct(d1,d2,dis);
    struct(d1-th*2,d2-th*2,dis);
    translate([dis*.7,-d2/2,0]) rotate([0,0,-45]) square([gap,th*3]);
        
}
}
//------------------------------------------------------------
module struct(n1,n2,x) {
    hull() {
        circle(d=n1);
        translate([dis,0]) circle(d=n2);
    }
}