//----------------------------------------------------------------------
// General settings: size of the fan
//----------------------------------------------------------------------

/* [General Settings] */

// width of the fan guard square (x, y).
$fan_guard_width = 40;

// height of the fan guard square (z).
$fan_guard_height = 2;

// width of the border surround, multiples of the nozzle width
$fan_guard_border = 0.8;

//----------------------------------------------------------------------
// Optional settings: step and hole offsets and diameter
//----------------------------------------------------------------------

/* [Optional Settings] */

// height of the additional step
$fan_guard_step = 2;

// offset of the corner screw holes
$hole_offset = 4;

// diameter of the screw holes
$hole_diameter = 3.4;

/* [Hidden] */

$r1 = ($fan_guard_width / 3.33);
$r2 = ($fan_guard_width / 5);

$fn = 60;

difference() {
    union() {

        // outside square shape
        shell();

        // increased z height if using a step
        step();

        // inner circle (ring)
        difference() {
            cylinder(h = $fan_guard_height, r = ($fan_guard_width / 4), center=true );
            cylinder(h = $fan_guard_height + 0.1, r = ($fan_guard_width / 5.5), center=true );
        }

        // create the biohazard shape by removing the small circles from the larger ones
        difference() {
            large_circles();
            small_circles();
        }
    }

    // punch a hole in the middle
    cylinder(h = $fan_guard_height + .1, r = ($fan_guard_width / 18), center=true );
}

module step() {
    // increase the height of the fan by the step amount
    $z1 = (($fan_guard_border / 2) + ($fan_guard_step / 2));
    difference() {
        translate([0, 0, $z1]) cube( [$fan_guard_width, $fan_guard_width, $fan_guard_step], center=true );
        translate([0, 0, $z1]) cube( [$fan_guard_width - (2 * $fan_guard_border), $fan_guard_width - (2 * $fan_guard_border), $fan_guard_step], center=true );
    }
}

module shell() {
    // outside shape with corner holes and a large center hole
    translate([0, 0])
    difference() {

        cube( [$fan_guard_width, $fan_guard_width, $fan_guard_height], center=true );

        cylinder( h = $fan_guard_height, r = (($fan_guard_width / 2) - $fan_guard_border), center=true );
        
        $x1 = ($fan_guard_width / 2) - $hole_offset;
        $y1 = ($fan_guard_width / 2) - $hole_offset;
        translate([$x1, $y1]) cylinder( h = $fan_guard_height + .1, r = ($hole_diameter / 2), center=true );
        translate([$x1 * -1, $y1]) cylinder( h = $fan_guard_height + .1, r = ($hole_diameter / 2), center=true );
        translate([$x1, $y1 * -1]) cylinder( h = $fan_guard_height + .1, r = ($hole_diameter / 2), center=true );
        translate([$x1 * -1, $y1 * -1]) cylinder( h = $fan_guard_height + .1, r = ($hole_diameter / 2), center=true );

    }
}

module large_circles() {
    // 3 circles offset by 120 degrees to make the biohazard outline
    rotate([0, 0, 0]) large_circle();
    rotate([0, 0, 120]) large_circle();
    rotate([0, 0, 240]) large_circle();
}

module large_circle() {
    // large circle of radius r1
    translate([0, $r2])
    cylinder($fan_guard_height, r = $r1, center=true );
}

module small_circles() {
    // 3 smaller holes to make the biohazard cutouts
    rotate([0, 0, 0]) small_circle();
    rotate([0, 0, 120]) small_circle();
    rotate([0, 0, 240]) small_circle();
}

module small_circle() {
    // circle of radius r2
    translate([0, $r2])
    translate([0, ($r2 / 2)]) cylinder(($fan_guard_height + 0.1), r = $r2, center=true );
}
