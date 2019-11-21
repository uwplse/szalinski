// Printable, customizable o-ring
Inner_Diameter = 33.71;
Outer_Diameter = 35.71;
Type="O-ring"; //[Gasket,O-ring]
// lower for a rounder ring
$fa=4;
/* [O-ring] */
// maxium overhang degrees. Useful for printing without supports. 90 for circular profile. 0 for vertical sides. 
Max_Overhang = 45; 
// lower for a rounder profile
$fs=0.4; //[0.1:0.1:5]
/* [Gasket] */
Thickness = 0.61;

R = (Outer_Diameter + Inner_Diameter)/4;

r = abs(Outer_Diameter - Inner_Diameter)/4;

module printable_circle(r, overhang=45) {
    n = [r * cos(overhang), r * (1 - sin(overhang))];
    m = [n.x - n.y * tan(overhang), 0];
    circle(r);
    translate([0, -r]) polygon([-m, m, n, [-n.x, n.y]]);
}

if (Type == "O-ring") {
    rotate_extrude(angle=360)
        translate([R, 0]) 
        printable_circle(r, Max_Overhang);
} else {
    // gasket
    rotate_extrude(angle=360)
        translate([R, 0]) 
        square([2*r, Thickness], center=true);
}
    