// Size of the fan, in mm
fansize = 40;
// Offset of the screws from the edge of the fan
screwoffset = 4;
// Size of the screw holes
screwsize = 3;

// Modules imported from mlib.scad
module mroundcube(d, r = 1, center = false)
{
    trn = center ? [-d[0]/2, -d[1]/2, -d[2]/2] : [0,0,0];
    translate(trn) union() {
        for(i=[r,d[0]-r])
            for(j=[r,d[1]-r])
                translate([i, j, 0]) cylinder(r=r, h=d[2], $fn=32);
        translate([r, 0, 0]) cube([d[0] - 2 * r, d[1], d[2]]);
        translate([0, r, 0]) cube([d[0], d[1] - 2 * r, d[2]]);
    }
}

$fs = 0.5;
$fa = 4;

difference() {
    mroundcube([fansize, fansize, 2], screwoffset);
    screws=[screwoffset, fansize-screwoffset];
    for(x=screws) for(y=screws) {
        translate([x, y, -1]) cylinder(r=screwsize/2+0.1, h=10);
    }
    translate([fansize/2, fansize/2, -1]) cylinder(r=fansize/2-2, h=10);
}

translate([fansize/2, fansize/2, 0]) cylinder(r=fansize/8, h=1.5);

for(i=[0, 60, 120]) {
    translate([fansize/2, fansize/2, .75]) rotate([0, 0, i]) cube([fansize / 20, fansize-2, 1.5], center=true);
}