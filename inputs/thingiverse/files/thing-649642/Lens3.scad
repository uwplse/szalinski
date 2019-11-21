/* [Lens Parameters] */
lensDiameter=100;
//in mm
focalLength=200;
//in mm 
thicknessAddend = 5;
//in mm
// Adjust upward for finer quality.
$fn=80;

/* [Hidden] */

lensRadius = lensDiameter/2;
sphereRadius = focalLength/2;
lensBottom = sqrt((sphereRadius*sphereRadius) - (lensRadius*lensRadius))-thicknessAddend;

translate([0,0,-lensBottom])
intersection(){
//sphere(5);
sphere(r=sphereRadius);
translate([0,0,lensBottom]) cylinder(h = focalLength, r1 = lensRadius, r2 = lensRadius);
}
