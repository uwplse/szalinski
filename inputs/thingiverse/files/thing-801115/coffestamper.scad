// [Stamper]
// Diameter of stamper (Bottom).
diameter = 56; // [5:100]
// Nob diameter
nob_diameter = 30; // [16:50]
// Height of stamper
height = 60;

$fn=100;

module stamper(dia=56,ndia=30,height=60) {
    hull() {
        cylinder(r=dia/2,h=5);
        translate([0,0,height-(ndia/2)-5]) cylinder(r=8,h=3);
    }
    translate([0,0,height-(ndia/2)]) sphere(r=ndia/2);
}

stamper(diameter,nob_diameter,height);
