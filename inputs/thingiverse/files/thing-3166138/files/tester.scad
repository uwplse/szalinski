include <measurements.scad>;

width = 4;
height = 3;
spacing = 19; /* olkb.com spacing*/
switch_width = k_lp_main_wdth;
thickness = k_lp_upper_body_hgt;
box_height = 10;

standoff_h = box_height + thickness;
standoff_d = spacing - switch_width - 2;

margin = 0.01;

module standoffs(scale = 1){
    for (y = [1:width - 1]) {
                            for (x = [1:height - 1]) { 
                                    translate([x * spacing,y * spacing,0])
                                union() {
                                        cylinder(h=standoff_h + 2 * margin, d = standoff_d * scale);
                                        cylinder(h=standoff_h - thickness, d = standoff_d * 2);
                                    }
                                };
    }
}

module switch_grid() {
    for (w = [0:width - 1]) {
            for(h = [0:height - 1]) {
                    translate([h * spacing,w * spacing,0]) cutout();
            }
    }
}

module switch_plate() {
    difference() {
        translate([spacing/2,spacing/2,thickness]) 
        difference() {
                translate([- spacing / 2, - spacing / 2,-thickness]) cube([height * spacing, width * spacing,  thickness]);
            translate([0,0,margin]) /* speeds up things*/ switch_grid();
        }
     translate([0,0,-standoff_h + thickness - margin]) standoffs(1.02);
    }
}

module switch_box() {
    x = height * spacing;
    y = width * spacing;
    z = box_height;
    rim = spacing - switch_width;
    translate([0,0,-z])
    union() {
        difference() {
            cube([x,y,z]);
            translate([rim/2,rim/2,rim/2]) cube([x-rim, y-rim, z]);
        }
        standoffs();
    }
}

switch_plate();
switch_box();

for (w = [0:width - 1]) {
        for(h = [0:height - 1]) {
                translate([(h + 1/2) * spacing,(w  + 1/2) * spacing, thickness]) switch();
        }
}