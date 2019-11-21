/*  Universal rubberfoot
    Default parameters fit my ATX Case and allow airflow to the PSU from below
    (c)copyright by Gerald Wodni 2017
*/
/* [Parameters] */
// Outer perimeter
OuterDiameter = 30;
// Screw access hole
InnerDiameter = 11.5;
// Height for screw to grab
InnerHeight = 1;
// Screw diameter
DrillDiameter = 4;
// Total height
Height = 30;
// Smoothing Radius
EdgeRadius = 3;

/* Lock maximum EdgeRadius */
MaxEdgeRadius = (OuterDiameter - InnerDiameter)/4;
UsedEdgeRadius = min(MaxEdgeRadius,EdgeRadius);

/* [Expert Settings] */
// Overlapping-Extension
Epsilon = 0.1;
// Overlapping-Offset
EpsilonOffset = -0.05;
// Smoothness of curves
$fn=64;

/* base cylinder with hole and screw mount */
module base(dOut, dIn, dDrill, h, hIn) {
    difference() {
        cylinder(d=dOut, h=h);
        translate([0,0,hIn])
        cylinder(d=dIn, h=h-hIn+Epsilon);
        translate([0,0,EpsilonOffset])
        cylinder(d=dDrill, h=hIn+Epsilon);
    }
}

/* simple donut */
module donut(dCenter, dRing) {
    rotate_extrude()
    translate([dCenter/2,0,0])
    circle(d=dRing);
}

/* two donuts with cylinder in between */
// dOut = total outer diameter
// dIn = total inner diameter
// d = rounded diameter
module flatDonut(dOut, dIn, d) {
    union() {
        // outer donut
        donut(dOut-d, d);
    
        // inner donut
        donut(dIn+d, d);
        
        // interconnect
        translate([0,0,-d/2])
        difference() {
            cylinder(h=d, d = dOut-d);
            translate([0,0,EpsilonOffset])
            cylinder(h=d+Epsilon, d = dIn+d);
        }
    }
}

/* upper half of flat donut,
   but we are using the full donut anyway to avoid manifolds*/
module halfFlatDonut(dOut, dIn, r) {
    d=r*2;
    difference() {
        flatDonut(dOut, dIn, d);
        translate([0,0,-d/2-Epsilon])
        cylinder(d=dOut+Epsilon,h=d/2+Epsilon);
    }
}

/* complete object: base+halfFlatDonut */
module foot(){
    union() {
        base(OuterDiameter, InnerDiameter, DrillDiameter, Height-UsedEdgeRadius+0.01, InnerHeight);
        translate([0,0,Height-UsedEdgeRadius])
        flatDonut(OuterDiameter, InnerDiameter, UsedEdgeRadius*2);
    }
}

foot();