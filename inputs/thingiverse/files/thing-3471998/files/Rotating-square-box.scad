boxHeight = 120;
boxSize = 120;
thickness = 6; // [4:20]
rotation = 15; // [15:45]

difference() {
    linear_extrude(height=boxHeight, center=true, twist=rotation, slices=boxHeight)
    square(boxSize, center=true);

    translate([0, 0, thickness])
    linear_extrude(height=boxHeight, center=true, twist=rotation, slices=boxHeight)
    square(boxSize-(2*thickness), center=true);
}