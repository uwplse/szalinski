wall_w=2;

drawer_h=30;
drawer_d=200;

peg_d=20;
peg_base_d=60;
peg_gap=2;

$fn=100;

// h=height of hourglass
// d1=diameter of base and top
// d2=diameter of middle
module hourglass(h,d1,d2) {
    x=1;
    union() {
        cylinder(d1=d1, d2=d2, h=h/2+x);
        translate([0,0,h/2-x])
        cylinder(d1=d2, d2=d1, h=h/2+x);
    }
}

//color("green")
difference() {
    union() {
        // drawer base
        difference() {
            cylinder(d=drawer_d, h=drawer_h);
            translate([0,0,wall_w])
            cylinder(d=drawer_d-wall_w*2, h=drawer_h);
        }

        // peg sleeve
        translate([0,-peg_d/2-wall_w,0])
        cylinder(d=peg_d+peg_gap+wall_w*2, h=drawer_h);

        // drawer flat wall
        translate([0,0,drawer_h/2])
        cube([drawer_d,wall_w*1.75,drawer_h], center=true);
    }

    // cut hole for peg
    color("blue")
    translate([0,-peg_d/2-wall_w,-.01])
    hourglass(h=drawer_h*1.01,d1=peg_d+peg_gap,d2=peg_d/2+peg_gap);

    // cut off half
    color("red")
    translate([0,drawer_d,drawer_h*.75])
    cube([drawer_d*2,drawer_d*2,drawer_h*2], center=true);
}

// peg
color("green")
translate([0,-peg_d/2-wall_w,0])
hourglass(h=drawer_h,d1=peg_d,d2=peg_d/2);
