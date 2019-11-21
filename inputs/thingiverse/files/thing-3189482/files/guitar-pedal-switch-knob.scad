/* [Basic structure] */
// the diameter of the inner switch cavity
SWITCH_CAVITY_DIAMETER = 10;
// the depth of the inner switch cavity
SWITCH_CAVITY_DEPTH = 5;
// the outer button diameter
BUTTON_DIAMETER = 29;
// [true|false] if the top surface should be slightly rounded. You might consider to print it upside down if set to true.
ROUND_SURFACE = true;
// level of roundness
ROUNDNESS = 4;
// level of detail
$fn = 50;

/* [Screws] */
// the diameter of the screwholes 2.5 fits M3
SCREWHOLE_DIAMETER = 2.5;
// the total number of screws. 0 for no screws.
NUMBER_OF_CREWS = 3;

/* [Optional parameters] */
// adds additional height to the button
ADDITIONAL_HEIGHT = 0;

module switch_knob(inner, outer, cavity, additional_height, screw_hole, number_screws, round_surface, roundness) {
    $scr_n = number_screws ? number_screws : 0;
    $scr_r = screw_hole ? screw_hole / 2 : 0;
    $ad_h = additional_height ? additional_height : 0;
    $ceil_thickness = 2;
    $inset = 2;
    $r_outer = outer / 2;
    $r_inner = inner / 2;
    $rnd = roundness ? roundness : 4;
    $height = cavity + $ceil_thickness + $inset;
    difference() {  
        // Main structure
        union() {
            translate([0, 0, -1 * $ad_h])
                cylinder(
                    h = $height + $ad_h,
                    r1 = $r_outer,
                    r2 = $r_outer,
                    center = false
            ); 
            if (round_surface) {
                translate([0, 0, -1 * $ad_h])
                    resize([0, 0, $rnd]) 
                        sphere($r_outer);
            }
        }
        // Inset
        translate( [0, 0, $height - $inset] ) 
            cylinder(
                h = $inset + 0.1,
                r1 = $r_inner + ($r_outer - $r_inner) * 0.3 ,
                r2 = $r_outer - 2,
                center = false
            );
        // Cavity
        translate( [0, 0, $ceil_thickness] )
            cylinder(h = cavity + $inset, r1 = $r_inner, r2 = $r_inner, center = false);
        // Debur
        translate( [0, 0, $height - $inset - 0.7] )
            cylinder(h = 0.8, r1 = $r_inner - 0.7, r2 = $r_inner + 0.7, center = false);
        // Screwholes
        for (s = [1:$scr_n]) {
            rotate([0, 90, 366 / $scr_n * s])
                translate([-1 * $ceil_thickness - cavity / 2, 0, 0])
                    cylinder($r_outer, $scr_r, $scr_r);
        }
    }
}

switch_knob(SWITCH_CAVITY_DIAMETER, BUTTON_DIAMETER, SWITCH_CAVITY_DEPTH, ADDITIONAL_HEIGHT, SCREWHOLE_DIAMETER, NUMBER_OF_CREWS, ROUND_SURFACE, ROUNDNESS);