res = 200;

difference(){
    union(){
        // Outer ring
        cylinder(h = 1.5, d = 19, $fn = res);
        // Pins
        cylinder(h = 6.3, d = 12.9, $fn = res);
    }
    // Center hole
    cylinder(h = 6.3, d = 9.7, $fn = res);
    // Side 1
    translate([0, 0, 1.5]){
        linear_extrude(height = 6.3 - 1.5){
            polygon(points = [[0, 0], [9, 10], [9, -10]]);
        }
    }
    // Side 2
    translate([0, 0, 1.5]){
        linear_extrude(height = 6.3 - 1.5){
            polygon(points = [[0, 0], [-9, 10], [-9, -10]]);
        }
    }
}