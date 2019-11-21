$fa = 0.2; // default minimum facet angle is now 0.5
$fs = 0.2; // default minimum facet size is now 0.5 
//$fn = 50;

roundness = 1.5;
height = 75;
radius = 9.5;
cutout = 5;

module torus(r, t, c = 10) {
    rotate_extrude(convexity = c)
    translate([r, 0, 0])
    circle(r = t);
}

module pack(r, t, h) {
    hull() {
        translate([-r, 0, 0]) torus(r, t);
        translate([r, 0, 0]) torus(r, t);
        translate([-r, 0, h]) torus(r, t);
        translate([r, 0, h]) torus(r, t);
    }
}
difference() {
    pack(radius, roundness, height);
    pack(radius, 0.1, height);
    translate([0,0,-height/2]) cube([height,height,height], center=true);
    cube([height,cutout,cutout], center=true);
    cube([cutout,height,cutout], center=true);
}

translate([height,0,0]) difference() {
    pack(radius, roundness, height);
    pack(radius, 0.1, height);
    translate([0,0,height]) cube([height,height,2*height], center=true);
}