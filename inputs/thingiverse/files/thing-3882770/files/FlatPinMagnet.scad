// Parametric model inspired by https://www.thingiverse.com/thing:3871356
$fn = 50;
magnetDiam = 10;
magnetHeight = 10;
margin = 0;

FlatPinMagnet(magnetDiam = magnetDiam, magnetHeight = magnetHeight, margin = margin);

module smooth(rounding) {
    offset(rounding) { offset(-rounding) { offset(-rounding) { offset(rounding) {
        children(0);
    }}}}
}

module FlatPinMagnet (magnetDiam, magnetHeight, totalHeight, margin) {
    totalHeight = max (magnetHeight + 2, 8);
    security=2;
    stepV = totalHeight / 10;
    stepH = magnetDiam / 10;
    rotate([0,180,0]) {
        rotate_extrude(angle = 360, convexity = 6) {
            difference () {
                smooth(0.4) {
                    polygon([[1,magnetHeight],[-magnetDiam/2-margin,magnetHeight],[-magnetDiam/2-margin,0],[-magnetDiam/2-security,0],[-magnetDiam/2-security,totalHeight-4*stepV],[-magnetDiam/2-security-1.5*stepH,totalHeight-2*stepV],[-magnetDiam/2-security,totalHeight-1*stepV],[-magnetDiam/2-security+1*stepH,totalHeight],[1,totalHeight]]);
                }
                // Cutting half for rotate_extrude 
                square([magnetDiam, totalHeight+1]);
            }
        }
    }
}
