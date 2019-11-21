// To make eccentric head and knurled knob to fit on longworth chuck
// Glyn Cowles Dec 2017

// width across points of hex bolt
wBolt=12; 
// bolt diameter (for hole)
dBolt=6.5;
// bolt head height
hBolt=4; 
// total height
totHt=7; 
// outer diameter of O ring
oRingDiam=27; 
// thickness of O ring
oRingThickness=3.4; 
// resolution
$fn=50;
//-----------------------------------------------------------------

oRing(oRingDiam,oRingThickness,1); // outer Diam of O ring, thickness of ring, offset from centre
translate([25,0,0]) knob(20,hBolt,wBolt,12);
//-----------------------------------------------------------------
module oRing(oRingD,oRingT,off) {
oDiam=oRingD-oRingT/2;
difference() {
    cylinder(d=oDiam-oRingT,h=totHt,$fn=90);
    translate([off,0,totHt-hBolt]) cylinder(d=wBolt,h=hBolt,$fn=6);
    translate([off,0,0]) cylinder(d=dBolt,h=totHt,$fn=50);
    translate([0,0,totHt/2]) torus(oRingT,oRingD);
}
}
//-----------------------------------------------------------------
module torus(d1,dTh)
{
x=dTh/2 - d1/2 ;    
rotate_extrude(convexity = 10) 
translate([x, 0, 0])
circle(d = d1); 
}
//-----------------------------------------------------------------
module knob(totd,height,nutd,knurls) { // diameter,height,nut diam,no knurls

difference() {
    cylinder(h=height,r=totd/2,$fn=25);
    cylinder(h=height,r=nutd/2,$fn=6);
    for (r=[0:360/knurls:360]) {
        rotate([0,0,r]) translate([totd/1.8,0,0]) cylinder(h=height,r=(totd/5)/2,$fn=15);
    }
}
}
//-----------------------------------------------------------------
