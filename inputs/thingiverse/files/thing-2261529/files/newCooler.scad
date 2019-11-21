// Diameter of the hole. I made it slightly larger for easy fit.
hole = 18.5;

// The offset from center of hotend to center of sensor.
// Keep in mind that you need to fit the fan to it.
yOffset = 60.5;


//Don't change this
yPosition = yOffset + 32.5;

difference(){
    union(){
        import("cooler.stl", convexity = 10);
        translate([5, 60, 11])
            difference(){
                union(){
                    translate([0, 0, 5])
                        cube([30, yPosition - 60, 7]);
                    difference(){
                        translate([0, 5.5, 12.2])
                            rotate([-45, 0, 0])
                                cube([30, 30, 17]);
                        translate([0, 0, -30])
                            cube([30, 40, 40]);
                    }
                }
                translate([0, 0, 7])
                    rotate([45, 0, 0])
                        cube([30, 40, 40]);
            }
        translate([20, yPosition, 16])
            cylinder(h = 7, d = 30, $fn = 80);
    }
    translate([-5, 65.8, 10])
        rotate([0, 90, 0])
            cylinder(h = 50, d = 20, $fn = 80);
    
    translate([20, yPosition, 11])
        cylinder(h = 15, d = hole, $fn = 80);
    translate([20, yPosition, 23])
        cylinder(h = 3, d = hole + 10, $fn = 80);
    translate([20, yPosition, 26])
        cylinder(h = 8, d1 = hole + 10, d2 = hole, $fn = 80);
    
    
}