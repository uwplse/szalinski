sphere($fn = 50);

translate([2, 0, -3]) sphere($fn = 50);

translate([-2, 0, -3]) sphere($fn = 50);

translate([4, 0, -6]) sphere($fn = 50);

translate([0, 0, -6]) sphere($fn = 50);

translate([6, 0, -9]) sphere($fn = 50);

translate([2, 0, -9]) sphere($fn = 50);


translate([1.5, 0, -3])
    rotate([0, -30, 0])
        cylinder($fn = 50, r = 0.1, h = 3);

translate([3.5, 0, -6])
    rotate([0, -30, 0])
        cylinder($fn = 50, r = 0.1, h = 3);
        
translate([5.5, 0, -9])
    rotate([0, -30, 0])
        cylinder($fn = 50, r = 0.1, h = 3);
        
translate([-2, 0, -3])
    rotate([0, 30, 0])
        cylinder($fn = 50, r = 0.1, h = 3);
        
translate([0, 0, -6])
    rotate([0, 30, 0])
        cylinder($fn = 50, r = 0.1, h = 3);

translate([2, 0, -9])
    rotate([0, 30, 0])
        cylinder($fn = 50, r = 0.1, h = 3);