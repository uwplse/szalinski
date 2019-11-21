pumpTubeDiameter = 29.8 + .2;
accessoryScrewDiameter = 7.5 + .4;
accessoryScrewHeight = 6;
gap = 3; // at least 2
outside = 2;

numAccessories = 3;


module cutout() {
    circle(d = pumpTubeDiameter, $fn = 200);

    // circumference of outer ring
    c = PI * (pumpTubeDiameter + accessoryScrewDiameter + gap * 2);
    accessoryWidth = gap + accessoryScrewDiameter;
    deg = 360 / (c / accessoryWidth);

    rotate(-(((numAccessories / 2) - .5) * deg), [0, 0, 1]) {
        for (i = [0:numAccessories - 1]) {
            rotate(i * deg, [0, 0, 1]) {
                translate([(pumpTubeDiameter + accessoryScrewDiameter) / 2 + gap, 0]) {
                    circle(d = accessoryScrewDiameter, $fn = 100);
                }
            }
        }
    }
}

linear_extrude(height = 10) {
    difference() {
        offset(r = outside) {
            hull() {
                cutout();
            }
        }

        cutout();

        polygon(points = [[0, 0], [-100, -180], [-100, 180]]);
    }
}
