translate([4, 0, 10])
    sphere($fn = 30);

for (i = [0:2]) {
    translate([-3 * i + 7, 0, 5])
        sphere($fn = 30);
     translate([-3 * i + 7, 0, 1])
        sphere($fn = 30);    
}

for (i = [0:2]) {
    translate([-3 * i + 7, 0, 5])
        sphere($fn = 30);
     translate([-3 * i + 7, 0, 1])
        sphere($fn = 30);    
}

for(i = [0:2]) {
    translate([-3 * i + 7, 0, 2])
        cylinder(r = 0.1, $fn = 50, h = 2);
}

translate([1, 0, 5])
    rotate([0, 30, 0])
        scale([1, 1, 5])
            cylinder(r = 0.1, $fn = 50, h = 1);


translate([4, 0, 6])
    rotate([0, 0, 0])
        scale([1, 1, 5])
            cylinder(r = 0.1, $fn = 50, h = 1);



translate([7, 0, 5])
    rotate([0, -30, 0])
        scale([1, 1, 5])
            cylinder(r = 0.1, $fn = 50, h = 1);
