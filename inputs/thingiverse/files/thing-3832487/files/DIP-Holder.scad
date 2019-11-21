
// How many pins do you have in your IC?
DIP_pin_number = 8; // [4, 6, 8, 14, 16, 18, 20]
// Check the last pin in rows. For shorter ICs sometimes it's just a half pin compare to the others. Choose full pin if it's looks like the others.
Ending_pins = "half_pin"; // [half_pin,full_pin]
Number_of_rows = 2; // [1:10]
ICs_in_a_row = 5; // [1:10]
// Width of walls and bottom plate
Wall_width = 1; // [0.6:0.2:2]
// Build up full height base block, or save some filament
Do_full_height = false;

module hidden_vars() {}
// Dip size
// http://ww1.microchip.com/downloads/en/PackagingSpec/00049w.pdf
pins_in_row = DIP_pin_number / 2;
p = 2.54; // Pitch
d = (pins_in_row + (Ending_pins == "half_pin" ? -.15 : .65)) * p; // Overall length
// e1 = 6.73; // Ceramic Pkg. Width
e1 = 4;
eb = 9.15; // Overall Row Spacing
a = 4.57; // Top to Seating Plane
a1 = 0.77; // Standoff
a2 = a - a1; // Resin block height
l = 4.13; // Tip to Seating Plane
dip_offset = 0.05; // Extra space around DIP package in each dimension for keep it loosy
dip_width = eb + 2 * dip_offset; // Overall width
dip_length = d + 2 * dip_offset; // Overall length
dip_height = a + l + 2 * dip_offset; // Overall height

// The DIP package itself
module dip() {
    cube([
        (eb - e1) / 2 + dip_offset,
        d + 2 * dip_offset,
        l + dip_offset
    ]); // Leg row 1
    translate([0, 0, l + dip_offset]) cube([
        eb + 2 * dip_offset,
        d + 2 * dip_offset,
        a + dip_offset
    ]); // Resin block
    translate([(eb - e1) / 2 + e1 + dip_offset, 0, 0]) cube([
        (eb - e1) / 2 + dip_offset,
        d + 2 * dip_offset,
        l + dip_offset
    ]); // Leg row 2
}

// Array of ICs
module dip_matrix() {
    for (x = [1:Number_of_rows]) {
        for (y = [1:ICs_in_a_row]) {
            translate([
                (x - 1) * (dip_width + Wall_width) + Wall_width,
                (y - 1) * (dip_length + Wall_width) + Wall_width,
                Wall_width
            ]) dip();
        }
    }
}

// Base block
module block() {
    cube([
        Number_of_rows * (dip_width + Wall_width) + Wall_width,
        ICs_in_a_row * (dip_length + Wall_width) + Wall_width,
        Do_full_height ? dip_height + Wall_width : l + a / 2 + Wall_width
    ]);
}

// Space for helping get off the IC
module screw_holes() {
    for (x = [1:Number_of_rows]) {
        translate([
                (x - 1) * (dip_width + Wall_width) + Wall_width + (eb - e1 + dip_offset) / 2 + e1 / 8,
                0,
                Wall_width + l + a * 1 / 3 + dip_offset
            ]) cube([
                e1 * 3 / 4  + dip_offset,
                ICs_in_a_row * (dip_length + Wall_width) + Wall_width,
                a * 2 / 3 + dip_offset
            ]);
    }
}

// The design itself
difference() {
    block();
    dip_matrix();
    screw_holes();
}
