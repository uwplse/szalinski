/* Glass Plate Grabber and Support
 * By DrLex, 2016/12
 * Released under Creative Commons - Attribution - Share Alike license */

// preview[view:south east, tilt:top]

plateThickness = 3; //[1:0.1:10]
tolerance = 0.15; //[0:0.05:1]
bottomClampDepth = 15; //[5:25]
topClampDepth = 10; //[0:25]
footHeight = 15; //[0:1:40]
width = 60; //60; //[5:100]
hole = "yes"; //[yes,no]

/* [Hidden] */
halfTotalThickness = (plateThickness + tolerance)/2;
holeRadius = min(11, (footHeight+halfTotalThickness-1)/2);

difference() {
    linear_extrude(height=width) polygon(points=[
        [0, halfTotalThickness],
        [0, -halfTotalThickness],
        [-bottomClampDepth, -halfTotalThickness],
        [-bottomClampDepth-5, -halfTotalThickness-3],
        [-5, -halfTotalThickness-3],
        [-2, -footHeight-halfTotalThickness-3],
        [27, -footHeight-halfTotalThickness-3],
        [30, -halfTotalThickness-3],
        [30, 0],
        [27, halfTotalThickness+3],
        [-topClampDepth-5, halfTotalThickness+3],
        [-topClampDepth, halfTotalThickness]
    ]);
    
    if(hole == "yes") {
        translate([13.5, -footHeight/2, -1]) cylinder(h=width+2, r=holeRadius);
    }
}
