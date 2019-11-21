include <utils/build_plate.scad>

/* [dimensions] */
// Volume in ml
volume = 500; // [10:2000]
// Radius in mm, when changing it it may be necessary to adjust the tick labels or distances
radius = 35; // [5:75]
// Shell Thickness in mm
thickness = 1.5; // [0.5:0.1:5]
// Font size in mm
font_size = 4; // [2:0.1:10]
// Scale Thickness in mm
scale_thickness = 1.25; // [0.5:0.05:3]
// Maximum angle for the tick representing the biggest number
scale_maxangle = 45; // [10:90]

/* [measurement units] */
// Names of used units, separated by comma
units = "ml,floz(gb),floz(us)";
// Conversion factor for the smallest increment of volume
conversion_factor = [1, 3.5516328125, 4.92892159375];
// relation between the volume represented by a tick and the next one
tick_relations = [[5, 2, 5, 2],[1, 8, 5],[1, 3, 2, 4, 2]];
// which of the ticks represent the unit, counting from 0, -1 if it is the base conversion factor
tick_representing_unit = [-1, 1, 2];
// the first tick that gets labeled, counting from 0
tick_labels_start_at = [2, 1, 2];

/* [display] */
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 100; //[100:400]
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);

$fn = 100 * 1;
circle_area = pow(radius - thickness, 2) * PI;
height = volume * 1000 / circle_area;
splitunits=split(units);

difference() {
    cylinder(r = radius, h = height + font_size * 1.5 + scale_thickness * 1.5);
    translate([0, 0, thickness]) cylinder(r = radius - thickness, h = height + font_size * 1.5 + scale_thickness * 1.5);
}

for (u = [0: len(splitunits) - 1]) {
    ticks = tick_relations[u];
    unit_divisor = multipy_elements(ticks, tick_representing_unit[u]);
    rotate(360 * u / len(splitunits)) {
        for (i = [1: volume / (conversion_factor[u] * ticks[0])]) {
            tick_volume = i * conversion_factor[u] * ticks[0];
            biggest_modulo = get_biggest_modulo(i, ticks, 1);
            tick_pos_z = tick_volume * 1000 / circle_area;
            translate([0, 0, tick_pos_z + thickness]) tick(len(ticks), biggest_modulo + 1);
            if (biggest_modulo >= tick_labels_start_at[u]) {
                translate([0, 0, tick_pos_z + thickness - font_size / 2]) textOnCylinder(str(round(i * ticks[0] * 1000 / unit_divisor) / 1000));
            }
        }
        translate([0, 0, height + scale_thickness + font_size / 2]) rotate(-scale_maxangle / 2 - font_size / radius * 30 * len(splitunits[u])) textOnCylinder(splitunits[u]);
    }
}

module tick(max_mod, biggest_modulo) {
    intersection() {
        difference() {
            union() {
                translate([0, 0, -scale_thickness / 2]) cylinder(r1 = radius, r2 = radius + scale_thickness, h = scale_thickness / 2);
                cylinder(r1 = radius + scale_thickness, r2 = radius, h = scale_thickness / 2);
            }
            cylinder(r = radius - thickness / 2, h = scale_thickness + 0.1, center = true);
        }
        x = sin(scale_maxangle * biggest_modulo / max_mod) * radius + scale_thickness;
        y = cos(scale_maxangle * biggest_modulo / max_mod) * radius + scale_thickness;
        linear_extrude(scale_thickness + 0.1, center = true) polygon(points = [
            [0, 0],
            [0, radius + scale_thickness],
            [x / 2, (radius + scale_thickness + y) / 2] * 2,
            [x, y]
        ]);
    }
}

module textOnCylinder(t) {
    for (l = [0: len(t) - 1]) {
        rotate([0, 0, font_size / radius * l * 60])
        translate([0, radius - scale_thickness / 2, 0])
        rotate([90, 0, 180])
        linear_extrude(scale_thickness) text(t[l], size = font_size);
    }
}

function get_biggest_modulo(number, vector, startindex) = number % vector[startindex] == 0 ? (startindex >= (len(vector) - 1) ? startindex : get_biggest_modulo(number / vector[startindex], vector, startindex + 1)) : startindex - 1;

function multipy_elements(vector, endindex) = endindex < 0 ? 1 : vector[endindex] * multipy_elements(vector, endindex - 1);

function split(string) =
    let (positions = concat([-1], search(",", string, 0)[0], [len(string)]))
    [for (i = [0: len(positions) - 2])
        [for (j = [positions[i] + 1: positions[i + 1] - 1])
            string[j]
        ]
    ];