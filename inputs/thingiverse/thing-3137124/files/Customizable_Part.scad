//Customizable Bowl

// Outer Diameter
d = 50;

// Base Diameter
b = 25;

// Thickness
t = 5;

// Smoothness
n = 25;

$fn = n;

// Main Body
difference(){
difference(){
    union(){
        translate([0,0,d/2])
            sphere(d = d,center = false);
        cylinder(h = d/2, r1 = b/2, r2 = b/2, center = false);

} // Union End - Main Body

translate([0,0,d/2])
    sphere(d=(d-2*t),center=false);
} // Difference End - Inner Shell

translate([0,0,d])
    cube([d,d,d],center = true);
} // Difference End - Lid