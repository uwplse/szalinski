// Candle Jar Lid (Round)
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Jar] */
diameter_mm = 81;
wall_thickness_mm  = 2;
tolerance_mm = 0.4;

/* [Lid] */
overhang_mm = 0;
thickness_mm = 3;
inset_ring_thickness_mm = 3;
inset_ring_height_mm = 3;

/* [Hidden] */
$fn = 200;
inner = diameter_mm - wall_thickness_mm * 2 - tolerance_mm;

union () {
    // lid
    linear_extrude(thickness_mm)
        circle(d=diameter_mm + overhang_mm/2);
    // inner ring
    translate([0, 0, thickness_mm])
        linear_extrude(inset_ring_height_mm)
            difference() {
                circle(d=inner);
                circle(d=inner-inset_ring_thickness_mm*2);
            }
}
