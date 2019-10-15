//Customizable Bowl

// Outer Diameter
d = 110;

// Base Diameter
b = 30;

// Thickness
t = 1;

// Smoothness
n = 100;

$fn = n;

difference(){
difference(){
    union(){
        translate([0,0,d/2])
            sphere(d = d,center = false);
        cylinder(h = d/2, r1 = b/2.5, r2 = b/2.5, center = false);
}

translate([0,0,d/2])
    sphere(d=(d-2*t),center=false);
}

translate([0,0,d-45])
    cube([d,d,d],center = true);
}