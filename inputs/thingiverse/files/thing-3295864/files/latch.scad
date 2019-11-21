ba=10;
bb=10;
bw=23;
bl = ba + bb;
bh=12;

al = 20;
aw = 7;
ah = 4.5;
ail = 8;
aiw = 2;

az = 1.5;

module a() {
    translate([al/2, aw/2, ah/2])
        difference() {
            cube([al, aw, ah], center = true);
            cube([ail, aiw, ah + 0.1], center = true);
        }
}

module b() {
    translate([0, bw, 0])
        rotate([90, 0, 0])
            linear_extrude(height = bw)
                polygon([ [0, 0], [ba, 0], [bl, bh], [0, bh] ]);
}

translate([0, 0, bh - ah - az]) a();
translate([0, bw - aw, az]) a();
translate([al, 0, 0]) b();
