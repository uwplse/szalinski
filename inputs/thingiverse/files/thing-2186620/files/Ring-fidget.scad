echo("Copyright 2017 Nevit Dilmen");
$fn=100;
//Variables
number_of_rings = 5;
cross_section = 6; // Torus cross section radius, mm
space = 0.8; //empty space between shapes, mm
start=cross_section+1; // start torus radius, should be larger than step
end = cross_section*number_of_rings; // end torus radius

//Inner most torus
rotate_extrude ()
translate ([start,0,0])
circle (cross_section);

//Outer circles
for (i=[start:cross_section:end]) {
echo (i);
color (c=rands(0,1,3), alpha=0.8) // Random color
difference () {
rotate_extrude ()
translate ([i+cross_section,0,0])
circle (cross_section);

rotate_extrude ()
translate ([i,0,0])
circle (cross_section+space);
}
}