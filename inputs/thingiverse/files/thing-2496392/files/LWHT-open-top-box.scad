L = 103;
W = 96;
H = 26.5;
T = 1.5;
difference() {
    cube([W,L,H],true);
    translate([0,0,(T)]) cube([(W-2*T),(L-2*T),(H)],true);
}

