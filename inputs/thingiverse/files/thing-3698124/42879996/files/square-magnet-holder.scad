magnet = 3.4;  // 0.2 tolerance so it can slide in
layer = 0.2;
taper = 2;
dia = 10;
h = 10;

$fn = 60;
difference() {
    cylinder(h=h, d1=dia, d2=dia+taper);
    translate([-magnet/2,-magnet/2,layer]) cube([magnet,magnet,h]);
}