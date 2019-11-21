/* [Global] */

apple_diameter = 80; // [50:120]

width_of_wooden_stick = 13; // [8:24]

// Note: The mounting lug will be half-height
full_height_of_wooden_stick = 29; // [16:48]

/* [Hidden] */

a=[1,6,12,16,18,20];
b=[0,0,0,0,2,3];
d = width_of_wooden_stick; // width of the wooden stick
h = full_height_of_wooden_stick; // full height of the stick (the mounting lug is half-height)
$fn=90;

rotate([0,0,-9]) difference() {
    sphere(r=apple_diameter/2+2.4);
    sphere(r=apple_diameter/2);
    translate([-100,-100,-200]) cube(200);
    for(i=[0:5]) {
        for(j=[b[i]:a[i]-1]) {
            rotate([0,15*i,360*(j-(i/2-floor(i/2)))/a[i]]) cylinder(r=3.5,h=100,$fn=24);
        };
    };
    rotate([0,0,9]) translate([30,13/2,7]) rotate([0,90,0]) cylinder(r=2,h=100);
};


translate([apple_diameter/2-40,0,0]) difference() {
    union() {
        translate([0,1,0]) cube([44,d-1,(h-1)/2]);
        translate([0,1,(h-1)/2]) cube([75,d-1+2.4,2.4]);
        translate([0,d,0]) cube([75,2.4,(h-1)/2]);
    };
    translate([30,d/2,7]) rotate([0,90,0]) cylinder(r=2,h=50);
    translate([62,d/2,0]) cylinder(r=2,h=50);
    translate([54,0,(h-1)/2-4.5]) rotate([-90,0,0]) cylinder(r=2,h=50);
    translate([70,0,4.5]) rotate([-90,0,0]) cylinder(r=2,h=50);
    sphere(r=41);
};
