wheelWidth = 18;
wheelHoleSize = 4;
wheelOuter = 47;

screwOffsetFromEdge = wheelWidth / 3;

$fn = 30;


module fullWheel() {
    difference() {
        union() {
            translate([0,0,3]) {
                minkowski() {
                    cylinder(d=wheelOuter-6, h=wheelWidth-6 );
                    sphere(r=3);
                }
            }
        }
        union() {
            cylinder(d=wheelHoleSize, h=wheelWidth );
            
            // Add a M3 hole all the way through either side of the middle.
            
            rotate([90,0,0]) {
                // Screw head hollow out.
                translate([(wheelOuter/2 -screwOffsetFromEdge), wheelWidth/2, 3]) {
                    #cylinder(d=8, h= 25 );
                }
                
                // Through holes.
                translate([-(wheelOuter/2 -screwOffsetFromEdge), wheelWidth/2, -wheelOuter/2]) {
                    #cylinder(d=3, h=wheelOuter +10 );
                }
                
                translate([(wheelOuter/2 -screwOffsetFromEdge), wheelWidth/2, -wheelOuter/2]) {
                    #cylinder(d=3, h=wheelOuter +10 );
                }
            }
            translate([-(wheelOuter +10), 0, 0]) {
            }
        }
    }
}

difference() {
    union() {
        fullWheel();
    }
    union() {
        // Chop off half the wheel 
        translate([-(wheelOuter/2), 0, 0]) {
            cube([wheelOuter, wheelOuter, wheelWidth]);
        }
    }
}