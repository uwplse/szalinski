/* [Main Dimensions] */

// Outside Length (mm)
Length = 191; // Length of queen excluder
// Outside Width (mm)
Width = 191; // Width of queen excluder
// Thickness (mm)
Thickness = 1.0; // Thickness of queen excluder
// Edge (mm)
Edge = 3; // Width of solid edges
// Hole width (mm)
hole = 4.1;

/* [Hidden] */
// better not change these
dist = hole + 1.2; 
dist2 = 24;

module spaak(Lengtht)
{
    cube([.8,Lengtht,Thickness],center=true);
    cube([1.2,Lengtht,Thickness-.6],center=true);
}


steps = floor((Length-2*Edge) / dist);

difference()
{
    cube([Length,Width,Thickness]);
    translate([(Length-steps*dist)/2,Edge,0])
        cube([steps*dist,Width-2*Edge,Thickness]);
}


translate([(Length-steps*dist)/2,Width/2,Thickness/2])
for(i=[0:steps])
{
    translate([i*dist,0,0])
        spaak(Width);
}

steps2 = floor((Width-2*Edge) / dist2);
dist3 = (Width-2*Edge) / steps2;

for(i=[0:steps2])
{
    translate([Length/2,i*dist3+Edge,Thickness/2])
        rotate(90,[0,0,1])
            spaak(Length-Edge);
}
