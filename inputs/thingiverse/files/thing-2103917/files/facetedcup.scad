OD = 80;
BaseFacets = 8;
CupHeight = 100;
BaseThickness = 4;

module outerShape() {
    linear_extrude(height=CupHeight, twist=180)
    circle(d=OD, $fn=BaseFacets);
}

module innerShape() {
    color("purple")
    translate([0, 0, BaseThickness])
    minkowski() {
        cylinder(d=OD*.8, h = CupHeight);
        sphere(r=2, $fn = 36);
    }
}

module cupShape() {
    difference() {
        outerShape();
        
        innerShape();
    }
}


//innerShape();
//outerShape();
cupShape();
