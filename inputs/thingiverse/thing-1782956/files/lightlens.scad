//Parametric Light Lens for a recessed overhead light

// Large diameter
d=135; 
// lip width
l=5;
//height
h=1;

$fn=50;

union(){
cylinder(r=d/2, h=h/2, center=true);
translate([0,0,h/2])cylinder(r=(d-l)/2, h=h, center=true);
}

