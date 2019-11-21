// Extrusion width, 15mm for OpenBeam.
EW=15;

// How sturdy do you want it?
WALL=4;

// Extra space on the inside.
tol=0.2;

// Which part to show
part = "both"; // [end, jig, both]


module PART(name) {
  if (part == "both") {
    render() children();
  } else if (part == name) {
    children();
  }
}

// nopheads polyhole
module polyhole(h, d, N = 0) {
  n = (N == 0) ? max(round(2 * d),3) : N;
  cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n, center=true);
}

module x_mirror() {
  children();
  mirror([1,0,0]) children();
}
module z_mirror() {
  children();
  mirror([0,0,1]) children();
}

module basic_shape(end) {
  difference() {
    translate([0,0,WALL/2]) cube([EW*2+WALL, EW+2*WALL, EW*2+WALL*2], center=true);
    translate([end?WALL*1.5:0,0,EW+WALL/2]) cube([EW*2+WALL*2, EW+tol*2, EW*2], center=true);
    translate([0,0,-EW-WALL/2]) cube([EW*3, EW+tol*2, EW*2], center=true);
    x_mirror() z_mirror() 
    translate([(EW+WALL)/2,0,(EW+WALL)/2+tol]) rotate([90,0,0]) polyhole(EW*2, 3);

    if (!end) translate([0,0,EW+WALL/2-1]) cube([2, EW*2, EW*2], center=true);
  }
}

PART("end") translate([0,  EW/2 + WALL*2, 0]) basic_shape(true);
PART("jig") translate([0, -EW/2 - WALL*2,0]) basic_shape(false);
