// Crown
// author: Benedict Endemann
// https://www.thingiverse.com/thing:3037001

////////// Thingiverse Customizer //////////
upper_diameter = 125; // [25:1:250]
lower_diameter = 110; // [25:1:250]
height = 50; // [25:0.5:100]
arch_height = 32.5; // [25:0.5:100]
number_of_spikes = 9; // [3:1:15]
spike_ball_diameter = 7; // [0.1:0.1:20]
wall_thickness = 2.4; // [0.1:0.1:20]
set_fn_value = 90; // [15:1:360]
$fn = set_fn_value;
////////// Thingiverse Customizer //////////


crown(
    upper_diameter = upper_diameter,
    lower_diameter = lower_diameter,
    wall_thickness = wall_thickness,
    height         = height,
    arch_height    = arch_height,
    spike_number   = number_of_spikes,
    ball_diameter  = spike_ball_diameter
);

module crown(
    upper_diameter,
    lower_diameter,
    wall_thickness,
    height,
    arch_height,
    spike_number,
    ball_diameter
) {

    upper_diameter  = upper_diameter != undef ?
                        abs(upper_diameter) :
                        lower_diameter != undef ?
                            lower_diameter :
                            100;
    lower_diameter  = lower_diameter != undef ?
                        abs(lower_diameter) :
                        upper_diameter / 10 * 8;
    wall_thickness  = wall_thickness != undef ?
                        abs(wall_thickness) :
                        upper_diameter / 10;
    height          = height != undef ?
                        abs(height) :
                        upper_diameter / 3 * 2;
    arch_height     = arch_height != undef ?
                        max(min(arch_height, height), 0) :
                        height / 2;
    spike_number    = spike_number != undef ?
                        max(spike_number, 3) :
                        5;
    ball_diameter   = ball_diameter != undef ?
                        abs(ball_diameter) :
                        0;

    difference() {

        // base cylinder
        cylinder(
            d1 = lower_diameter,
            d2 = upper_diameter,
            h  = height
        );

        // make hollow cylinder
        cylinder(
            d1 = lower_diameter * 2 - upper_diameter - wall_thickness * 2,
            d2 = upper_diameter - wall_thickness * 2,
            h  = height * 2,
            center = true
        );

        // shape spikes
        for (i = [0 : spike_number]) {

            rotate([
                0,
                270,
                360 / spike_number * i
            ])
                translate([
                    height,
                    0,
                    0
                ])
                    resize([
                        (height - arch_height) * 2,
                        0,
                        0
                    ])
                        cylinder(
                            d = (upper_diameter - wall_thickness * 2) * sin(360 / spike_number / 2),
                            h = upper_diameter
                        );
        }
    }

    // add spike balls
    for (i = [0 : spike_number]) {

        rotate([
            0,
            0,
            360 / spike_number * (i + 1 / 2 * (spike_number + 1) % 2)
        ])
            translate([
                (upper_diameter - wall_thickness) / 2,
                0,
                height
            ])
               sphere(
                    d   = ball_diameter,
                    $fn = $fn / 3
                );
    }
}