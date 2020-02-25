difference() {
    cube([57, 30, 30]);
    for(i = [0:8]) {
        translate([9 * i , 5, 3]) {
            cube([4.5, 25, 25]);
        }
        translate([9 * i + 4.5 , 5, 1.5]) {
            cube([4.5, 25, 27]);
        }
    }


}
