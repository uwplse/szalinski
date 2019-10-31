for(i = [0:2]) {
    translate([3 * i + 1, 0, 3 * i + 1])
        sphere($fn = 30, r = 0.5);
}

translate([7, 0, 1])
    sphere($fn = 30, r = 0.5);

translate([1, 0, 7])
    sphere($fn = 30, r = 0.5);


translate([5.5, 0, 5.5])
    cube(center = true);


translate([2.5, 0, 2.5])
    cube(center = true);


translate([5.5, 0, 2.5])
    cube(center = true);


translate([2.5, 0, 5.5])
    cube(center = true);