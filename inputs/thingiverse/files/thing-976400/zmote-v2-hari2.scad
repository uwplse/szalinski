// Diameter at the bottom
ldia = 60; // [30:90]
// Maximum height
ht = 30; // [15:50]
// Defines the slope of the code 
cone_ht = 50; // [25:150]
// Angle of slope for top cut
back_slope = 20; // [0:45]
// Skin thickness
thickness = 3;  // [1:10]
// Platform on which the code rests
platform_ht = 2;  // [0:10]
// Render resolution
$fn = 60;
// USB hole width
u_hole_wt = 10;
// USB hole height
u_hole_ht = 5;

module led_hole(slope, disp) {
    //rotate([0,0,-45]) 
    translate([0,disp, 0]) scale([1, slope, 1]) cylinder(d=5, h=2*ht);
}
module led_hole_horiz() {
    rotate([90,0,0]) translate([0,0,-ht]) cylinder(d=5, h=ht);
}

module usb_hole() {
    translate([-u_hole_wt/2, -ldia, 0])
        cube([u_hole_wt, ldia, u_hole_ht]);
}

module solid_shell(d, h) {
    difference () {
        cylinder(r1 = d/2, r2 = 0, h = h);
        translate([-d, -d, 0])
            rotate([back_slope,0,0])
                cube([2*d, 2*d, 4*d]);
        translate([-d/2, -d-d/2+15, 0])
            cube([d,d,4*d]);  
        rotate([25,0,0]) translate([0, d/2+12, 0]) scale([1,1, 0.7]) sphere(r=20);
        rotate([25,0,90]) translate([0, d/2+12, 0]) scale([1,1, 0.7]) sphere(r=20);
        rotate([25,0,-90]) translate([0, d/2+12, 0]) scale([1,1, 0.7]) sphere(r=20);
        rotate([30,0,0]) translate([0, 0, h/2]) sphere(r=12);
    }
}

module top_shell() {
    difference () {
        solid_shell(ldia, cone_ht);
        solid_shell(ldia-thickness, cone_ht-thickness);
        /*for (angle = [-90,-20,0,20,90])
        for (angle = [-90,90])
            rotate([0,0,angle]) 
                led_hole(ldia/2/cone_ht, 3/8*ldia);*/
        rotate([0,0,83]) translate([0,0,7]) led_hole_horiz();
        rotate([0,0,97]) translate([0,0,7]) led_hole_horiz();
        rotate([0,0,-83]) translate([0,0,7]) led_hole_horiz();
        rotate([0,0,-97]) translate([0,0,7]) led_hole_horiz();
        translate([0,0,7]) led_hole_horiz();
        translate([5,0,10]) led_hole_horiz();
        translate([-5,0,10]) led_hole_horiz();
        translate([-3.3,0,0]) rotate([110,0,0]) led_hole_horiz();
        translate([3.3,0,0]) rotate([110,0,0]) led_hole_horiz();
    }
}

module solid_platform(d, h) {
    difference () {
       cylinder(r = d/2, h = h);
        translate([-d/2, -d-d/2+15, 0])
            cube([d,d,4*d]);        
    } 
}

module platform() {
    difference () {
        solid_platform(ldia, platform_ht);
        solid_platform(ldia-thickness, platform_ht);
    }
}

//rotate([-180-back_slope, 0, 0]) 
difference () {
    union () {
        platform();
        translate([0,0, platform_ht]) top_shell();
    }
    translate([5,0,0]) usb_hole();
}
