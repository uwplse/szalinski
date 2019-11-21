// Parametric cap.
// Author: Fabrice Fleurot

Th = 2;   // Thickness
Hi = 15;   // Internal height.
Di = 31.7;   // Internal Diameter.
W = 1;  // Width of ribs.
VentHoleRadius = 0; // 0.5  // Use it if no ribs (W=0) and/or gap too small: you'll need a way for air to escape.

gap = 0.1;   // Gap between cap and eyepiece, reduce if loose, increase if tight.
RoundedEdges = true;




// Other variables, don't touch:
Ri = Di/2;  // Internal radius.
e = .2;  // Epsilon for subtraction.


// Cylindrical part.
translate([0,0,Th])
difference()
{
    cylinder(r = Ri+gap+W+Th, h = Hi);  // Outer
    translate([0,0,-e]) cylinder(r = Ri+gap+W, h=Hi+2*e);
}

// Cylinder end.
Re = RoundedEdges? Ri+W+gap : Ri+W+gap+Th;
difference()
{
    cylinder(r = Re, h = Th);
    translate([0,0,-e]) cylinder(r=VentHoleRadius, h=Th+2*e);
}

// Rounded edge if needed.
if(RoundedEdges)
{
    translate([0,0,Th])
    difference()
    {
        rotate_extrude(convexity=10)
            translate([Ri+gap+W,0,0])
                circle(r=Th, $fn=20);
        cylinder(r = Ri+gap+W+e, h = Th+e);
    }
}


// Ribs
if(W>0)
{
    for(i=[0:3])
    {
        rotate([0,0,90*i])
            translate([Ri+gap,-W/2,Th])
                cube([W+e, W, Hi]);
    }
}
