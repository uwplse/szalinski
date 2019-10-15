radius=5;         // [0.5:0.1:10]
width=40;         // [10:100]
InnerHeight=16;   // [1:0.1:20]

/* [Hidden] */
$fn = 64;

difference() {
  hull() {
    translate([width,           0,       radius]) sphere(r=radius);   // vorne rechs
    translate([    0,           0,       radius]) sphere(r=radius);   // vorne links
    translate([width, InnerHeight,       radius]) sphere(r=radius);   // hinten rechts
    translate([    0, InnerHeight,       radius]) sphere(r=radius);   // hinten links
    translate([    0,           0, width+radius]) sphere(r=radius);   // vorne oben
    translate([    0, InnerHeight, width+radius]) sphere(r=radius);   // hinten oben
  }
  translate([0, 0, radius]) cube([width+radius, InnerHeight, width+radius]);
}
