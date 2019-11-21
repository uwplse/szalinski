/**
 * Tire (Lego or so!)
 * 
 * @Author  Wilfried Loche
 * @Created May 30th, 2017
 */

/* [Tire] */
// Width of the tire
tireWidth = 10;
// Inner diameter of the tire
tireInnerDiameter = 67;
// Median diameter of the tire
tireMedianDiameter = 73;
// Outer diameter of the tire
tireOuterDiameter = 78;

/* [Crampon] */
// Straight side of 1 crampon
cramponSide = 4;
// How many rows of crampons?
cramponNumberPerSide = 2;
// How many crampons around the tire?
cramponNumberPerRow = 24;

/* [Debug mode] */
// Debug mode?
DEBUG = false; // [0:false, 1:true]

/* [Automatic: derived from customization] */
// Width of a crampon
cramponWidth  = tireWidth/cramponNumberPerSide;
// Height of a crampon
cramponHeight = (tireOuterDiameter-tireMedianDiameter)/2;

module unitTest() {
    color("red")   cylinder(h=5, d=tireInnerDiameter);
    color("green") cylinder(h=3, d=tireMedianDiameter);
    color("Wheat") cylinder(h=1, d=tireOuterDiameter);
    color("blue")  outOfTire();
}

module chevron() {
    polygon(points=
        [
            [0,0],
            [cramponSide,0],
            [cramponSide+cramponWidth/sqrt(2),cramponWidth/2],
            [cramponSide,cramponWidth],
            [0,cramponWidth],
            [cramponWidth/sqrt(2),cramponWidth/2]
        ]
    );
}

module chevronOne() {
    //cramponHeight*2 to insure crampons and outer rim touch!
    translate([tireMedianDiameter/2-cramponHeight/2, -cramponWidth/sqrt(2), 0])
    rotate([90, 0, 90])
    linear_extrude(height = cramponHeight*2) chevron();
}


module chevronRowOne() {
    for (i = [0:cramponNumberPerRow-1]) {
        rotate([0, 0, i*360/cramponNumberPerRow]) chevronOne();
    }
}

module chevrons() {
    for (i = [0:tireWidth/cramponWidth-1]) {
        translate([0, 0, i*cramponWidth]) chevronRowOne();
    }
}

module rim() {
    rotate_extrude(convexity = 10, $fn = 180)
    translate([tireInnerDiameter/2, 0, 0])
    square(size = [(tireMedianDiameter-tireInnerDiameter)/2, tireWidth]);
}

module outOfTire() {
    // offset 10 to insure it overlapses the tire width
    translate([0, 0, -5])
    rotate_extrude(convexity = 10, $fn = 180)
    translate([tireOuterDiameter/2, 0, 0])
    square(size = [(tireMedianDiameter-tireInnerDiameter)/2, tireWidth+10]);
}


if (DEBUG) {
    unitTest();
} else {
    difference() {
        union() {
            chevrons();
            rim();
        };
        outOfTire();
    }
}
