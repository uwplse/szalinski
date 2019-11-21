// Gutter Downspout "T" Junction
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Downspout] */
// width of downspout opening
downspout_w = 85;
// height of downspout opening
downspout_h = 62.2;
// downspout corner radius
downspout_r = 15.25;

/* [Adapter] */
// depth of downspout inserts
insert_d = 90.2;
// size to reduce downspout insert
insert_allowance = 10;
// depth of outer insert
outer_d = 63.5;
// thickness of adapter
thickness = 3;

/* [Attachment] */
// diameter of screw holes
screw_d = 4;
// distance to offset screw holes from edges
screw_offset = 19.0;

/* [Hidden] */
downspout_vec = [downspout_w, downspout_h];
screw_l = downspout_h + thickness; 
total_height = insert_d + outer_d + downspout_w/2;

module roundrect(vect, r, $fn=20) {
    sq = len(vect) > 1
        ? [for (i = [0:1:len(vect)-1]) vect[i] - r * 2]
        : vect - r * 2;
    minkowski() {
        square(sq);
        translate([r, r])
            circle(r=r);
    }
}

function inch_to_mm(inches) = inches * 25.4;
function increase(vec, amt) = [for (i = vec) i + amt];

module adapt_allowance(vec) {
    hull() {
        translate([insert_allowance/2, insert_allowance/2, 0])
            linear_extrude(1) roundrect(increase(vec, -insert_allowance), downspout_r);
        translate([0, 0, insert_allowance]) linear_extrude(1) roundrect(vec, downspout_r);
    }
}

module inner(vec) {
    union() {
        difference() {
            union() {
                linear_extrude(total_height)
                    roundrect(vec, downspout_r);
                translate([downspout_r, 0, insert_d])
                    rotate([0, 45, 0])
                        linear_extrude(downspout_w + outer_d)
                            roundrect(vec, downspout_r);
            }
            linear_extrude(screw_offset*2)
                roundrect(vec, downspout_r);
        }
        linear_extrude(screw_offset*2-insert_allowance)
            translate([insert_allowance/2, insert_allowance/2, 0])
            roundrect(increase(vec, -insert_allowance), downspout_r);
        translate([0, 0, screw_offset*2-insert_allowance])
            adapt_allowance(vec);
    }
}

module screw_through() {
    rotate([-90, 0, 0])
        linear_extrude(screw_l) circle(d=screw_d, center=true);
}

module screws() {
    x = (downspout_w + thickness) / 2;
    translate([x, 0, screw_offset])
        screw_through();
    translate([x, 0, total_height - screw_offset])
        screw_through();
    translate([downspout_r, 0, insert_d])
        rotate([0, 45, 0])
            translate([x, 0, downspout_w + outer_d - screw_offset])
                screw_through();
}

difference() {
    inner(increase(downspout_vec, thickness));
    translate([thickness/2, thickness/2]) inner(downspout_vec);
    screws();
}
