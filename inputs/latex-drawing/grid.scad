for(i = [0:2]) {
    for(j = [0:2]) {
        translate([-3 * j + 7, 0, -3 * i + 7])
            sphere($fn = 50);
    }
}

for(i = [0:2]) {
    for(j = [1:2]) {
        translate([-3 * j + 8, 0, -3 * i + 7])
            rotate([0, 90, 0])
                cylinder(h = 2, $fn = 50, r = 0.1);
    }
}

for(i = [1:2]) {
    for(j = [0:2]) {
        translate([-3 * j + 7, 0, -3 * i + 8])
            cylinder(h = 2, $fn = 50, r = 0.1);
    }
}