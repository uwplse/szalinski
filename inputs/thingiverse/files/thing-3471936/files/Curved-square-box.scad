boxSize=100;
thickness=4;

difference() {
    // Outer box
    linear_extrude(height=boxSize, center=false, convexity=30, twist=15, slices=200)
    square(boxSize);
    // Inner box
    translate([0, 0, thickness])
    linear_extrude(height=boxSize, center=false, convexity=30, twist=15, slices=200)
    translate([thickness, thickness, 0])
    square(boxSize-2*thickness);
}