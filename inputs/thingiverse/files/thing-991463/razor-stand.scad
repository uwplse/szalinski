
/* [Global] */

part = "both"; // [side:Side By Side,both:Both,top:Top,bottom:Bottom]

/* [Base] */

//Base Diameter
base_d = 65;
//Base height
base_h = 4;
//Stand diameter
stand_d = 10;
//Stand height
stand_h = 100;
//Connector nub diameter
conn_d = 5;

/* [Top] */

//Width of holder bar
bar_w = 10;
//Length of brush holder to center
bar_l_brush = 15;
//Length of razor holder to center
bar_l_razor = 10;
//Height of holder bar
bar_h = 3;

//Brush diameter (should be a a few mm than actual)
brush_d = 27;
//Razor diameter (should be a a few mm than actual)
razor_d = 17;

//Width of holder arms
holder_w = 6;

/* [Hidden] */
holder_h = bar_h;
bar_l = bar_l_brush + bar_l_razor;
conn_h = holder_h;

// http://forum.openscad.org/Creating-pie-pizza-slice-shape-need-a-dynamic-length-array-td3148.html
module pie_slice(d, angle) {
    $fn=64;
    R = d / 2 * sqrt(2) + 1;
    a0 = (0 * angle) / 4;
    a1 = (1 * angle) / 4;
    a2 = (2 * angle) / 4;
    a3 = (3 * angle) / 4;
    a4 = (4 * angle) / 4;
    intersection() {
        circle(d=d);
        polygon([
            [0,0],
            [R * cos(a0), R * sin(a0)],
            [R * cos(a1), R * sin(a1)],
            [R * cos(a2), R * sin(a2)],
            [R * cos(a3), R * sin(a3)],
            [R * cos(a4), R * sin(a4)],
            [0,0]
        ]);
    }
}

module holder(width, h, d, angle) {
    $fn=64;
    nub_w = width / 3;
    rotate([0, 0, 90-angle/2])

    union() {
        linear_extrude(h)
        difference() {
            circle(d=d + width);
            circle(d = d);
            pie_slice(d + width, angle);
        }
        translate([d/2 + width/4, 0]) cylinder(5, d=nub_w);
        rotate([0, 0, angle]) translate([d/2 + width/4, 0]) cylinder(5, d=nub_w);
        
    }
}

module bottom() {
    union() {
        cylinder(base_h, d=base_d);
        cylinder(stand_h, d=stand_d);
        cylinder(stand_h + conn_h, d=conn_d);
    }
}

module top() {
    union() {
        difference() {
            translate([-bar_w/2, -bar_l_razor, 0]) cube([bar_w, bar_l, bar_h]);
            translate([0, 0, -1]) cylinder(bar_h + 2, d=5 + .1);
        }
        translate([0, +bar_l_brush + brush_d/2, 0]) 
            holder(holder_w, holder_h, brush_d, 110);
        translate([0, -bar_l_razor - razor_d/2, 0]) 
            rotate([0, 0, 180]) holder(holder_w, holder_h, razor_d, 110);
    }
}

if (part == "bottom") {
    bottom();
} else if (part == "top") {
    top();
} else if (part == "both") {
    translate([0, 0, stand_h]) top();
    bottom();
} else { //if (part == "side") {
    translate([base_d / 2  + max(brush_d, razor_d) / 2 + 10, 0, 0]) top();
    bottom();
}