/* MakeBlock L-Bracket by Sam Kass 2016 */

// # holes in x direction on one side of L
xholes=4;

// # holes in y direction on other side of L
yholes=3;

// # holes in z direction (wide)
zholes=3;

// part thickness (MakeBlock=3)
thickness=3;

// radius of holes (MakeBlock threaded=2, MakeBlock loose=2.4)
hole_radius=2.4;

// # sides for holes (0 = circle, printers often prefer 6 or 8)
hole_sides=8;

// radius of part corners (MakeBlock=2)
corner_radius=2;

// distance from the center of one hole to center of next (MakeBlock=8)
pitch=8;

/* [Hidden] */
$fn=50;
open=[];

d=0.01;
cr = corner_radius < 0.001 ? 0.001 : corner_radius;

module template(nholes) {
    hull() {
        translate([0, -(pitch/2), 0])
            cube([2*cr,2*cr,thickness]);
        
        translate([0, (zholes-1)*pitch+(pitch/2-2*cr), 0])
            cube([2*cr,2*cr,thickness]);

        translate([(nholes)*pitch+(pitch/2-cr), -(pitch/2-cr), 0])
            hex(cr*2,0.1,thickness);
//            cylinder(h=thickness, r=cr);

        translate([(nholes)*pitch+(pitch/2-cr), (zholes-1)*pitch+(pitch/2-cr), 0])
            hex(cr*2,0.1,thickness);
//            cylinder(h=thickness, r=cr);
    }
}

// Get vertex distance for desired side-to-side width (apothem).
function poly_r_for_d(d,sides) = d/cos(180/sides);

// angle to polygon vertex.  Add sides/4 and 180/sides to make flat on top.
function vert_ang(s,sides) = (s + sides/4)*360/sides+180/sides;

module poly(wid,rad,height,sides){
    hull(){
        for (s = [0:sides]) {
            rotate([0,0,vert_ang(s,sides)])
                translate([poly_r_for_d(wid/2,sides)-rad,0,0])cylinder(r=rad,h=height);
        }
    }
}

// Unroll for loop for hex so it's not so slow in common case
module hex(wid,rad,height){
    hull(){
        rotate([0,0,vert_ang(0,6)])
            translate([poly_r_for_d(wid/2,6)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(1,6)])
            translate([poly_r_for_d(wid/2,6)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(2,6)])
            translate([poly_r_for_d(wid/2,6)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(3,6)])
            translate([poly_r_for_d(wid/2,6)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(4,6)])
            translate([poly_r_for_d(wid/2,6)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(5,6)])
            translate([poly_r_for_d(wid/2,6)-rad,0,0])cylinder(r=rad,h=height);
    }
}

// Unroll for loop for oct so it's not so slow in common case
module oct(wid,rad,height){
    hull(){
        rotate([0,0,vert_ang(0,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(1,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(2,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(3,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(4,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(5,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(6,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
        rotate([0,0,vert_ang(7,8)])
            translate([poly_r_for_d(wid/2,8)-rad,0,0])cylinder(r=rad,h=height);
    }
}

module hole() {
    if (hole_sides == 0) {
        cylinder(h=thickness+2*d, r=hole_radius);
    }
    else if (hole_sides == 6) {
        hex(hole_radius*2,0.1,thickness+2*d);
    }
    else if (hole_sides == 8) {
        oct(hole_radius*2,0.1,thickness+2*d);
    }
    else {
        poly(hole_radius*2,0.1,thickness+2*d, hole_sides);
    }
}

module holes(nholes) {
    for (y = [0:zholes-1]) {
        for (x = [1:nholes]) {
            translate([x*pitch,y*pitch,-d])
            hole();
        }
    }
    
}

rotate([90,0,0])
translate([-0, pitch/2, 0])
union() {
    translate([-thickness,0,0])
    difference() {
        template(xholes);
        holes(xholes);
    }

    rotate([0,-90,0])
    difference() {
        template(yholes);
        holes(yholes);
    }
}
