outer = 75;
snap = 74;
snaplevel = (4-2)/2 + 2;
snapheight = 4-2;
inner  = 64;
diag = 15;
height = 12;
$fn=100;

difference() {
hull(2);
    cutout();
}

module hull(w) {
    cylinder(h = height+w, d1 = outer+w, d2 = inner+w);
translate([0,0,height+1])
minkowski() {
cylinder(h=0.01, d1 = inner+w);
    sphere(d=2*w);
}
translate([0,0,snaplevel])
minkowski() {
cylinder(h=0.01, d1 = snap-2);
    sphere(d=4);
}
    
}

module cutout() {
cylinder(h = height, d1 = outer, d2 = inner);
//cylinder(h = 7, d1 = outer, d2 = 68);
translate([0,0,snaplevel])
minkowski() {
cylinder(h=0.01, d1 = snap-2);
    sphere(d=2);
}
}