/* [Parameters] */
//Reflective index of used material, n. Pick between 1.0 and 1.7.
reflectiveIndex = 1.4;

//Needed focal length. Take negative for diverging lens.
focalLength = 200;

//Lens diameter.
aperture = 60;//[10.0:100.0]

//Minimal distance between optical surfaces.
thickness = 3;//[0.0:10.0]

//Pick if biconvex or biconcave lens needed.
isBicurved = 1; //[0:1]

/* [Hidden] */
$fn = 300;

curvature = abs((reflectiveIndex-1)*focalLength*(isBicurved+1));
segmentHeight = curvature-sqrt(curvature*curvature - 0.25*aperture*aperture);

thickness2 = thickness/(1+isBicurved);
/*helping variable, which allows to mirror generated part*/

module convex(){
translate([0,0,thickness2]){
union()
{
difference()
{
    translate([0,0,-curvature+segmentHeight]){sphere(curvature);}
    translate([0,0,-2*curvature]) {cylinder(r=curvature,h=2*curvature,center=false);}
}
    translate([0,0,-thickness2]) {cylinder(r=0.5*aperture,h=thickness2,center=false);}
}
}
}
module concave(){
translate([0,0,thickness2]){
difference()
{
    translate([0,0,-thickness2]) {cylinder(r=0.5*aperture,h=curvature+thickness2,center=false);}
    translate([0,0,curvature]){sphere(curvature);}
}
}
}

module 2convex(){
union(){
convex();
mirror ([0,0,1]){convex();}
}
}
module 2concave(){
union(){
concave();
mirror ([0,0,1]){concave();}
}
}
if (focalLength>0 && isBicurved==0) {color([0,1,1]) convex();}
if (focalLength>0 && isBicurved==1) {color([0,1,1]) 2convex();}
if (focalLength<0 && isBicurved==0) {color([0,1,1]) concave();}
if (focalLength<0 && isBicurved==1) {color([0,1,1]) 2concave();}
    