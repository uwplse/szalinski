//Radius = 10.55/2;
Radius = 12.2/2; // Radius of pulley
GuardSize = 3; // Extra radius of guard disk
Outer = Radius+GuardSize;
Height = 6.9; // Height between guards
Guard = 1.3; // Width (Z) of guard disk
Hole = 5; // Diameter of axle hole
Spacing = 2; // Distance between parts

Circ=2*Radius*PI;
N=Circ/Spacing;
Arc=360*(Circ/N)/Circ;

// By nophead
module polyhole( d, h )
{
n = max( round( 2 * d ), 3 );
rotate( [0, 0, 180] ) cylinder( h = h, r = ( d / 2 ) / cos( 180 / n ), $fn = n );
}

difference() {
    union() {
        cylinder(r=Outer, h=Guard); // guard
        translate([0, 0, Guard]) {
            cylinder(r=Radius, h=Height);
        }
    }
    polyhole(d=Hole, h=Height+Guard);
}

translate([Outer*2+Spacing, 0, 0]) difference() {
    cylinder(r=Outer, h=Guard); // guard
    polyhole(d=Hole, h=Height);
}
