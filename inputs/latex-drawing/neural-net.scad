translate([2, 0, 0])
    cube([10, 1, 1]);


for(i = [0:2]) {
    for (j = [0:i+1]) {
        translate([5 * i, 0, 2])
            cube([4, 1, 2]);
    }
}

for(i = [0:2]) {
    for (j = [0:i+1]) {
        translate([5 * i, 0, 10])
            cube([4, 1, 1]);
    }
}

for (i = [0:2]) {
    translate([5 * i + 2, 0, 4])
        cylinder(r = 0.1, $fn = 50, h = 6);
}


translate([7, 0, 1])
    rotate([0, 0, 0])
        scale([])
            cylinder(r = 0.1, $fn = 50, h = 1);


translate([7, 0, 1])
    rotate([0, 75, 0])
        scale([1, 1, 5])
            cylinder(r = 0.1, $fn = 50, h = 1);


translate([7, 0, 1])
    rotate([0, -75, 0])
        scale([1, 1, 5])
            cylinder(r = 0.1, $fn = 50, h = 1);


translate([5, 0, 4])
    rotate([0, -20, 0])
        cylinder(r = 0.1, $fn = 50, h = 6.5);



translate([10, 0, 4])
    rotate([0, -20, 0])
        cylinder(r = 0.1, $fn = 50, h = 6.5);
        

translate([10, 0, 4])
    rotate([0, -45, 0])
        cylinder(r = 0.1, $fn = 50, h = 9);
        
        
        