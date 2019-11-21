// Pipe Cap
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Pipe] */
inner_diameter_mm = 74;
pipe_thickness_mm = 5;
cap_thickness_mm = 3;

/* [Hold] */
hold_thickness_mm = 3;
hold_depth_mm = 8;
hold_cutout_width_mm = 5;
hold_cutout_count = 8;

/* [Hidden]*/
$fn = 200;

module cutouts() {
    union () {
        for (rot = [0:360/hold_cutout_count:360]) {
            rotate([0, 0, rot])
                square([hold_cutout_width_mm, inner_diameter_mm+pipe_thickness_mm]);
        }
    }
}

module hold() {
    offset = hold_depth_mm - hold_thickness_mm;
    difference () {
        union () {
            translate([0, 0, offset])
                #cylinder(
                    h=hold_depth_mm - offset,
                    d1=inner_diameter_mm,
                    d2=inner_diameter_mm - hold_thickness_mm*2
                );
            linear_extrude(offset)
                circle(d=inner_diameter_mm);
        }
        linear_extrude(hold_depth_mm)
            circle(d=inner_diameter_mm - hold_thickness_mm*2);
        linear_extrude(hold_depth_mm)
            cutouts();
    }
}

union () {
    // lid
    linear_extrude(cap_thickness_mm)
        circle(d=inner_diameter_mm + pipe_thickness_mm*2);
    // inner
    translate([0, 0, cap_thickness_mm])
        hold();
}
