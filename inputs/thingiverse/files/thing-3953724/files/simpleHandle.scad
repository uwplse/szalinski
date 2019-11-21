height = 75;
outsideDiameter = 25;
holeDepth = 35;
holeDiameter = 8.5;
filletRadius = 5;
difference() {
    translate ([0, 0, filletRadius]){ minkowski() {
        cylinder(height, outsideDiameter/2-filletRadius, outsideDiameter/2-filletRadius, $fn=100);
        sphere(filletRadius);
    }}

    cylinder(holeDepth, holeDiameter/2, holeDiameter/2);
}