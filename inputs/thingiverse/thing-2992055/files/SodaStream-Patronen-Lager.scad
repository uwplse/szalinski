// -----------------------------------------------------
// SodaStream-Patronen-Lager
//  ....damit eine leere, auf Austausch wartende Patrone
//      dann nicht doch irgendwann mal runterrollt und
//      die Fliesen zerdeppert.
//
//  Detlev Ahlgrimm, 07.2018
// -----------------------------------------------------

co2cylinder_diameter=60;  // [10:200]
diameter_backlash=2;      // [0:5]
width=45;                 // [10:200]
length=100;               // [10:200]
height=10;                // [5:50]
wall_strength=3;          // [1:10]
bottom_thickness=2;       // [1:10]
r=4;                      // [1:10]

$fn=50;

difference() {
  hull() {
    translate([       r, -width/2+r, 0]) cylinder(r=r, h=height);
    translate([length-r, -width/2+r, 0]) cylinder(r=r, h=height);
    translate([       r,  width/2-r, 0]) cylinder(r=r, h=height);
    translate([length-r,  width/2-r, 0]) cylinder(r=r, h=height);
  }
  translate([-1, 0, (co2cylinder_diameter+diameter_backlash)/2+bottom_thickness]) rotate([0, 90, 0]) cylinder(d=co2cylinder_diameter+diameter_backlash, h=length+2);

  for(x=[wall_strength, (length+wall_strength)/2]) {
    translate([x, -(width-2*wall_strength)/2, -1]) cube([(length-3*wall_strength)/2, width-2*wall_strength, height+2]);
  }
}
