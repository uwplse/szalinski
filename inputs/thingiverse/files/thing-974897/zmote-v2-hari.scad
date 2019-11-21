// Diameter at the bottom
ldia = 60; // [30:90]
// Maximum height
ht = 25; // [15:50]
// Defines the slope of the code 
cone_ht = 50; // [25:150]
// Angle of slope for top cut
back_slope = 15; // [0:45]
// Skin thickness
thickness = 2;  // [1:10]
// Platform on which the code rests
platform_ht = 2;  // [0:10]


module led_hole(slope, disp) {
    //rotate([0,0,-45]) 
    translate([0,disp, 0]) scale([1, slope, 1]) cylinder(d=5, h=2*ht);
}

module solid_shell(d, h) {
    difference () {
        cylinder(r1 = d/2, r2 = 0, h = h);
        translate([-d, -d, 0])
            rotate([back_slope,0,0])
                cube([2*d, 2*d, 4*d]);
        translate([-d/2, -d-d/2+15, 0])
            cube([d,d,4*d]);        
    }
}

module top_shell() {
    difference () {
        solid_shell(ldia, cone_ht);
        solid_shell(ldia-thickness, cone_ht-thickness);
        for (angle = [-90,-20,0,20,90])
            rotate([0,0,angle]) 
                led_hole(ldia/2/cone_ht, 3/8*ldia);
        led_hole(cos(back_slope), 0);
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

union () {
    platform();
    translate([0,0, platform_ht]) top_shell();
}
