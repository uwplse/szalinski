// Parametric model inspired by https://www.thingiverse.com/thing:2912160/files

$fn = 150;
magnetDiam = 10;
magnetHeight = 3;
margin = 0;
totalHeight = 17;

PushPinMagnet(magnetDiam = magnetDiam, magnetHeight = magnetHeight, margin = margin, totalHeight = totalHeight);

module smooth(rounding) {
    offset(rounding) { offset(-rounding) { offset(-rounding) { offset(rounding) {
        children(0);
    }}}}
}
module PushPinMagnet (magnetDiam, magnetHeight, totalHeight, margin) {
    security=2;
    // Extra size of circle around the magnet, we make sure to have at least
    // a space of 'security' between the corner of the magnet and the round part.
    border = sqrt(magnetDiam*magnetDiam/4 + magnetHeight*magnetHeight) + security - magnetDiam/2;

    rotate([0,180,0]) {
        rotate_extrude(angle = 360, convexity = 6) {
            difference () {
                smooth(0.3) {
                    union () {
                        // handle
                        translate ([0,totalHeight,0]) {
                            difference() {
                                circle(magnetDiam/2);
                                translate([0,magnetDiam/2]) { square([magnetDiam+1,magnetDiam], center = true); }
                            }
                        }
                        // Link
                        polygon([[-magnetDiam/2,magnetHeight],[magnetDiam/2,magnetHeight],[magnetDiam/5,totalHeight],[-magnetDiam/5,totalHeight]]);
                        // Socket
                        difference () {
                            circle(magnetDiam/2+border+margin);
                            translate([0,-magnetDiam/2]) { square([magnetDiam+2*border+2*margin+1,magnetDiam], center=true); }
                            // Room for the magnet
                            square([magnetDiam+2*margin,magnetHeight*2], center=true);
                        }
                    }
                }
                // Cutting half for rotate_extrude 
                square([magnetDiam+border, totalHeight+1]);
            }
        }
    }
}
