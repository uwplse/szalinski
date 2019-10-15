// Distance holder
// for use in electronics & mechanical projects
// Example size for M3 bolts x 6 x 6 mm

$fn=128;

//Parameters:
height = 6; 
od = 6; //Outer Diameter
id = 3; //Inner Diameter

difference () {
cylinder(h=height, d=od);
cylinder(h=height, d=id);  
}