// All measurements are in mm.

// The width of the phone. Include the case if you want to dock with it on.
phone_width = 76;

// The thickness of the phone.
phone_depth = 9;

// The amount of space to leave around the phone on each side.
buffer = .5;

// How much wider than the phone to make the base.
base_width_scale = 1.25;

// The height of the base relative to the phone's width. If both scale values are the same, the base will be square.
base_height_scale = 1.25;

// The thickness of the base.
base_depth = 20;

// The calculated dimensions of the base.
base_width = phone_width * base_width_scale;
base_height = phone_width * base_height_scale;

// Angle of the phone slot. Zero is straight up.
slot_angle = 20;

// Slot height tweak.
slot_y_tweak = 4;

// Slot depth tweak.
slot_z_tweak = 5;

difference() {

    // base cube
    cube([base_width, base_height, base_depth]);

    // phone slot
    translate([
        (base_width - phone_width - (buffer * 2)) / 2,
        slot_y_tweak,
        slot_z_tweak
    ]) {
        rotate([-slot_angle, 0 , 0]) {
            cube([
                phone_width + (buffer * 2),
                phone_depth + (buffer * 2),
                100
            ]);
        }
    }

    // tray
    translate([
        (base_width - phone_width - (buffer * 2)) / 2,
        30,
        3
    ]) {
        cube([
            phone_width + (buffer * 2),
            base_height - 40,
            100
        ]);
    }

}
