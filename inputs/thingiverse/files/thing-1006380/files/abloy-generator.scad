// preview[view:north, tilt:bottom]

/* [Global] */

key = [1,2,3,4,5,0,1];

/* [Body] */

body_length = 29.5;
body_diameter = 2.9;

/* [Handle] */
handle = 1; // [1:Yes, 0:No]

/* [Cut] */
cut_spacing = 0.5;
cut_angle_step = 18;

/* [Quality] */

$fn = 100;

/* [Hidden] */

preview_tab = "";

module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("Chocolate") children();
  } else {
    color("NavajoWhite") children();
  }
}

module body(l = body_length, d = body_diameter) {
    difference() {
        rotate([0,90,0]) cylinder(l, d, d);
        translate([-0.25,-3,-0.05]) cube([body_length+0.5,6,6]);
    }
}

module cut(cuts, spacing = 0.5) {
    for(a = [0:len(cuts)-1]) {
        translate([3 + a*2,0,0])
        rotate([90+cuts[a]*cut_angle_step,0,0])
        translate([0,0,-0.01])
        difference() {
            cube([2 + spacing,3,3]);
//            translate([(2+spacing)/2,0,0]) cube([.5,3,3]); // support
        }
    }
}

module handle() {
    highlight("Handle") 
    hull() {
        translate([body_length,0,-0.06]) difference() {
            rotate([0,90,0]) cylinder(1,2.9-0.025,2.9-0.025);
            translate([-3,-3,0]) cube([6,6,6]);
        }
        translate([body_length+6,5.5,-2.56]) cylinder(2.5);
        translate([body_length+6,-5.5,-2.56]) cylinder(2.5);
        translate([body_length+9,2.5,-2.06]) cylinder(2);
        translate([body_length+9,-2.5,-2.06]) cylinder(2);
    }
}

module main() {
    translate([0,0,-0.01])
    difference() {
        highlight("Body") body();
        highlight("Cut") cut(key, cut_spacing);
    }
}

translate([29.5/2,0]) rotate([180,0,180]) {
    main();
    if(handle) handle();
}
