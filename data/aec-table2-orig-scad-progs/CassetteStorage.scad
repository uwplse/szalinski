difference() {
    translate([-57, -3, 3]) {
        scale([117, 75, 175]) {
            cube();
        }
    }
    for (i=[0:9]) {
        translate([-51, -5, 16 * i + 6]) {
            scale([105, 60 , 13])
                cube();
        }
    }
 }