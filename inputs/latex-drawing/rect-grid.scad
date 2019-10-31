for(i = [0:3]) {
    for(j = [0:3]) {
        translate([-3 * i + 9, 0, -2 * j + 6])
            cube([2, 1, 1]);
    }
}