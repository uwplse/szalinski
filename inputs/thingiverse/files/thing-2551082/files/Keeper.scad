// Dimension in the direction across the strap in mm. Should be slightly larger (say 1mm) longer than the strap width
inner_width = 20; // [8:0.5:30]

// Dimension in the direction of the strap thinkness in mm. Should be about twice the strap thickness to allow the excess strap to tuck in.
inner_height = 4.5; // [1:0.5:10]

// Dimension in the direction along the strap in mm.
depth = 10; // [1:0.5:25]

// Thickness of the keeper in mm.
thickness = 1; //[0.5:0.1:5]

// Squared or rounded edges?
edge_type = "square"; // [square, rounded]

module rectangular_section(w, h, t) {
    difference() {
        square([w + t*2, h + t*2], center = true);
        square([w, h], center = true);
    }
}

module rounded_profile(w, h) {
    union() {
        square([w - h, h], center = true);
        translate([-(w/2 - h/2), 0, 0]) {
            circle(d=h, $fn=100);
        }
        translate([w/2 - h/2, 0, 0]) {
            circle(d=h, $fn=100);
        }
    }
}

module rounded_section(w, h, t) {
    difference() {
        rounded_profile(w + t*2, h + t*2);
        rounded_profile(w, h);
    }
}

module section(w, h, t) {
    if (edge_type == "square") {
        rectangular_section(w, h, t);
    } else {
        rounded_section(w, h, t);
    }
}

linear_extrude(height = depth) {
    section(inner_width, inner_height, thickness);
}