// Y coordinate of first vertex A, X coordinate is fixed to 0
ay = 30; // [1:100]

// X coordinate of second vertex B
bx = 10; // [1:100]
// Y coordinate of second vertex B
by = -20; // [-100:-1]

// X coordinate of third vertex C
cx = -10; // [-100:-1]
// Y coordinate of third vertex C
cy = -60; // [-100:-1]

// Additional padding
padding = 5; // [0:100]

// Cut out for original triangle used to generate the curve
cut_out = "half"; // [none, half, through]

/* [Hidden] */
ax = 0;
va = [0, ay];
vb = [bx, by];
vc = [cx, cy];


color( "Gray", 1.0 ) difference() {
     linear_extrude(10) ccw(va, vb, vc, padding);
     if (cut_out == "half") {
        translate([0,0,5]) linear_extrude(6) polygon([va, vb, vc]);
     } else if (cut_out == "through") {
        translate([0,0,-1]) linear_extrude(12) polygon([va, vb, vc]);
     }
}


module ccw(va, vb, vc, padding) {
    
    $fn=200;
    
    ab = distance(va, vb);
    bc = distance(vb, vc);
    ca = distance(vc, va);

    sum_of_long_sides = ab + bc + ca - min(ab, bc, ca);

    vab = vb - va;
    vac = vc - va;
    vba = va - vb;
    vbc = vc - vb;
    vca = va - vc;
    vcb = vb - vc;

    angle_vab = atan2(vab[1], vab[0]);
    angle_vac = atan2(vac[1], vac[0]);
    angle_vba = atan2(vba[1], vba[0]);
    angle_vbc = atan2(vbc[1], vbc[0]);
    angle_vca = atan2(vca[1], vca[0]);
    angle_vcb = atan2(vcb[1], vcb[0]);

    translate(va) sector(sum_of_long_sides + padding - bc,      angle_vab, angle_vac);
    translate(vc) sector(sum_of_long_sides + padding - bc - ca, angle_vac, angle_vbc);
    translate(vb) sector(sum_of_long_sides + padding - ca,      angle_vbc, angle_vba);
    translate(va) sector(sum_of_long_sides + padding - ca - ab,      angle_vba, angle_vca);
    translate(vc) sector(sum_of_long_sides + padding - ab,      angle_vca, angle_vcb);
    translate(vb) sector(sum_of_long_sides + padding - bc - ab, angle_vcb, angle_vab);
}

function distance(p1, p2) = sqrt( pow((p1[0]-p2[0]),2) + pow((p1[1]-p2[1]),2) );

module sector(r, a1, a2) {
    difference(){
        circle(r);
        rotate([0,0,a1]) translate([-r, 0]) square([r*2, r*2]);
        rotate([0,0,a2]) translate([-r, -r*2]) square([r*2, r*2]);
    }
}