$fn=100+0;
//Width of entire assembly
w=20;
// Length of lip (part with slot)
l3=17;
// Length of vertical
l2=40;
// Length of deck (part with sensor hole)
l1=23;
// Thickness of lip
t3=1.75;
// Thickness of vertical
t2=3;
// Thickness of deck
t1=3;
// radius of sensor hole
r1=7.25;
// radius of slot
r2=1.5;
// slot length (to center of arc)
sx=8;
// slot distance from edge
sy=5;
// sensor distance from edge (y)
dy=10;
// sensor distance from edge (x)
dx=12.5;

rotate([270,0,0])
union() {
difference() {
    // Lip
    cube([l3,w,t3]);
    translate([sx,w-sy,-1]) cylinder(r=r2,h=t3+2);  // round part of slot
    translate([0,w-sy-r2,-1]) cube([sx,r2*2,t3+2]);  // slot
}
// Vertical
translate([l3,0,0])
  cube([t2,w,l2]);

// Deck
translate([l3+t2,0,l2-(t1)])
  difference() {
     cube([l1,w,t1]);
      translate([dx,dy,-1]) cylinder(r=r1,h=t1+2);  // sensor hole
  }
}