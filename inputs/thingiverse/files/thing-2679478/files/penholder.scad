pens = 6;
penDiameter = 13;
magnetDiameter = 10;
magnetHeight = 2;

module penHolder (number) {
    translate([number * 16.5, 0, 0]) {        
        difference() {
            if (pens > 1) cylinder(20, 10, 10, 0);
            else {
                translate([-10, -10, 0]) {
                    cube([20, 20, 20], 0);
                }
            }
            translate([0,0, -3])
            cylinder(24, penDiameter/2, penDiameter/2, 0);
        }
    }
}

module complete (number) {
    translate([number * 16.5 + 6, 5, 0]) {
        cube([4, 2, 20], 0);
    }
}


module magnet (number) {
    simplyfiedPens = pens - 1;
    holePosition = number ? ((((simplyfiedPens * 16.5) / magnet) + 6.5) * number) : 0;
    finalHolePosition = number == magnet - 1 ? (simplyfiedPens * 16.5) - 16.5 : holePosition;
    
    translate([finalHolePosition + (pens > 1 ? 8.5 : 16.5), 7, 10]) {
        rotate([-90, 0, 0]) {
            cylinder(magnetHeight+1.5, magnetDiameter/2, magnetDiameter/2, 0);
        }
    }
}

magnets = [1,1,2,2,2,2,3,3,3,4,4];
magnet = magnets[pens > 10 ? 10 : pens];

difference() {
    union() {
        for (i=[0:pens-1]) penHolder(i);
        if (pens > 1) for (i=[0:pens-2]) complete(i);
        translate([0, 7, 0])
        cube([(pens-1)*16.5, magnetHeight + 1, 20], 0);
    }
    
    for (i=[0:magnet-1]) magnet(i);
}