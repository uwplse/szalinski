scale=100; // [90:170]

vs=scale/100.0;

module roundedcube(xdim,ydim,zdim,rdim) {
    intersection() {
        hull() {
            translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim,$fn=20);
            translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim,$fn=20);
            translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim,$fn=20);
            translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim,$fn=20);
        }
        hull() {
            translate([0,ydim,0]) rotate(90, [1,0,0]) {
                translate([rdim,rdim,0]) cylinder(h=ydim,r=rdim,$fn=20);
                translate([xdim-rdim,rdim,0]) cylinder(h=ydim,r=rdim,$fn=20);
                translate([rdim,zdim-rdim,0]) cylinder(h=ydim,r=rdim,$fn=20);
                translate([xdim-rdim,zdim-rdim,0]) cylinder(h=ydim,r=rdim,$fn=20);
            }
        }
        hull() {
            translate([0,0,zdim]) rotate(90, [0,1,0]) {
                translate([rdim,rdim,0]) cylinder(h=xdim,r=rdim,$fn=20);
                translate([zdim-rdim,rdim,0]) cylinder(h=xdim,r=rdim,$fn=20);
                translate([rdim,ydim-rdim,0]) cylinder(h=xdim,r=rdim,$fn=20);
                translate([zdim-rdim,ydim-rdim,0]) cylinder(h=xdim,r=rdim,$fn=20);
            }
        }
    }
}

difference() {
    translate([0, 1, 0]) {
        scale([vs,vs,vs]) {
            translate([-2.15, 0, -2.15]) {
                difference() {
                    roundedcube(4.3, 30, 4.3, 0.5);
                    translate([(4.3-2.56)/2, (30-1.5-4), -2]) {
                        cube([2.56, 4, 8]);
                    }
                }
            }
        }
    }
    rotate(-90, [1,0,0]) { 
        cylinder(h=24, r=1.5, $fs=0.4);
    }
    translate([0, 1, 0]) {
        scale([vs,vs,vs]) {
            translate([(-2.56)/2, (30-2-1.5), -0.15]) {
                rotate(45, [1,0,0]) cube([2.56, 8, 8]);
            }
            translate([(-2.56)/2, (30-2-1.5), +0.15]) {
                rotate(45+180, [1,0,0]) cube([2.56, 8, 8]);
            }
        }
    }
}
