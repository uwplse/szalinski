/* [Slab] */
// Front elevation in mm
slab_front = 10;
// Back elevation in mm
slab_back = 18;
// width in mm
slab_width = 160;
// height in mm
slab_height = 80;
// Corner radius in mm
slab_roundness = 5;

/* [Hexa grid] */
// Size of an hexagon
grid_size = 8;
// width in mm
grid_width = 1.5;

/* [Border] */
// Border width in mm
border_width = 5;

/* [ergodox] */
// Ergodox wrist pad? (mirror the part in your slicer to obtain a right pad)
ergodox_type = "left"; // [left, none]
// Offset of the thumb part, in mm
ergodox_thumb_offset = 80;

/* [Hidden] */
fudge = 0.001;

module hexgrid(lines=5, rows=10, height=15, hexsize=5, width=2) {
    for (i = [0:lines]) {
        for (j = [0:rows]) {
            translate([sqrt(3)*(hexsize+width)*j+sqrt(3)/2*i*hexsize, 3/4*2*(hexsize+width)*i, -fudge]) rotate([0, 0, 90])
            cylinder(h=height, d=hexsize*2, $fn=6);
        }
    }
}

module pad_base(width, height, roundness, type="none") {
    difference() {
        union() {
            translate([roundness, 0]) square([width-2*roundness, height]);
            translate([0, roundness]) square([width, height-2*roundness]);
            translate([roundness, roundness]) circle(r=roundness);
            translate([width-roundness, roundness]) circle(r=roundness);
            translate([roundness, height-roundness]) circle(r=roundness);
            translate([width-roundness, height-roundness]) circle(r=roundness);
        };
        if (type == "left") {
            translate([ergodox_thumb_offset, height]) rotate(-25) square([width, height]);
        }
    }
}

module slab(width=160, height=80, zfront=10, zback=18, roundness=5) {
    angle = atan(abs(zback-zfront)/height);
    cube_size = 2*max(width, height);
    difference() {
        linear_extrude(max(zfront, zback)+fudge) { pad_base(width, height, roundness, ergodox_type); };
        // Inclination
        translate([-width/2, 0, min(zfront, zback)]) rotate([angle, 0, 0]) cube(cube_size);
    }
}

module wristpad() {
    grid_lines = ceil(slab_height/(3/4*2*(grid_size+grid_width)));
    // Add (grid_lines*grid_size to compensate shifting
    grid_rows = ceil((slab_width+grid_lines*grid_size)/(sqrt(3)*(grid_size+grid_width)));

    difference() {
        slab(width=slab_width, height=slab_height, zfront=slab_front, zback=slab_back, roundness=slab_roundness);
        // Inner grid
        intersection() {
            // Compensate shift on each line
            translate([-grid_lines*grid_size, 0, 0])
            hexgrid(hexsize=grid_size, width=grid_width, height=max(slab_front, slab_back), lines=grid_lines, rows=grid_rows);
            // Inner grid
            translate([0, 0, -fudge])
            linear_extrude(max(slab_front, slab_back)+2*fudge) {
                offset(r=-border_width) pad_base(slab_width, slab_height, slab_roundness, ergodox_type);
            }
        }
    }
}

wristpad();