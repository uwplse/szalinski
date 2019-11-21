$fn=100;
/* RING */
radius = 14.5;
width = 2.5;
height = 7;
twist = 30;
/* TAB */
ext = 30;
tab_l = 13.5;
tab_w = 13.5;
slit = 0.7;
tab_hole = 8;

/* CALCULATIONS */
sector_angle = asin((tab_w)/radius/2);
angles = [sector_angle, 360-sector_angle];
tab_sector_angle = asin((tab_w-width)/radius/2);
tab_angles = [tab_sector_angle, 360-tab_sector_angle];

/* 
 * sector and arc code taken from:
 * https://openhome.cc/eGossip/OpenSCAD/SectorArc.html
 */
module sector(radius, angles, fn = 100) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 100) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 


module tab(l, h, ext) {
    r = radius+width/2;
    hull() {
        translate([r*cos(tab_angles[0]+ext), r*sin(tab_angles[0]+ext), 0])cylinder(d=width, h=h);
        translate([r*cos(tab_angles[1]), r*sin(tab_angles[1]), 0])cylinder(d=width, h=h);
        translate([r*cos(tab_angles[0])+l, r*sin(tab_angles[0]), 0])cylinder(d=width, h=h);
        translate([r*cos(tab_angles[1])+l, r*sin(tab_angles[1]), 0])cylinder(d=width, h=h);
    }
}

difference() {
    union() {
        linear_extrude(height, twist=twist) arc(radius, [angles[0]+twist/2, angles[1]+twist/2], width);
        translate([0,0,(height-slit)/2])rotate([180,0,0])tab(tab_l,(height-slit)/2,ext);
        translate([0,0,(height+slit)/2])tab(tab_l,(height-slit)/2,ext);
    }
    cylinder(r=radius, h=height);
    translate([radius+tab_l/2, 0, 0])cylinder(d=tab_hole , h=height);
}