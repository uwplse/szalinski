// Corner Guards
// -------------

// Corner width to proteced
width = 15;

/* [Hidden] */
offset = width / 3;
radius = width - offset;

translate([offset, offset, offset])
difference() {
    sphere(r=radius, $fn=50);
    translate([-offset, -offset, -offset]) cube([width, width, width]);
}