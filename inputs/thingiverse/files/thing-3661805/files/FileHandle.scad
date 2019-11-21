/*
 * FileHandle
 * (c) 2019 Phil Dubach
 * This work is licensed under the Creative Commons Attribution-NonCommercial
 * 4.0 International License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-nc/4.0/.
 */
HANDLE_D = 30;
HANDLE_L = 120;
NECK_D = 22;
NECK_L = 25;
TANG_W = 3;
TANG_MIN = 3.0;
TANG_MAX = 7.7;
TANG_L = 40;
RADIUS = 6;

module tang() {
    rotate([90,0,0]) translate([0,0,-TANG_W/2]) linear_extrude(height=TANG_W) {
        polygon([[TANG_MAX/2, 0], [TANG_MIN/2, TANG_L], [-TANG_MIN/2, TANG_L], [-TANG_MAX/2, 0]]);
    }
}

module handle() {
    s=(HANDLE_D - NECK_D) / 2;
    translate([0,0,RADIUS]) minkowski() {
        union() {
            cylinder(d1=HANDLE_D-2*RADIUS, d2=HANDLE_D-2*RADIUS-2*s, h=s, $fn=6);
            translate([0,0,s]) cylinder(d=NECK_D-2*RADIUS, h=NECK_L, $fn=6);
            translate([0,0,NECK_L+s]) cylinder(d2=HANDLE_D-2*RADIUS, d1=HANDLE_D-2*RADIUS-2*s, h=s, $fn=6);
            translate([0,0,NECK_L+2*s]) cylinder(d=HANDLE_D-2*RADIUS, h=HANDLE_L-2*RADIUS-NECK_L-2*s, $fn=6);
        }
        sphere(r=RADIUS, $fn=32);
    }
}

difference() {
    handle();
    tang();
}
