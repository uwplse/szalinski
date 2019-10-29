// http://www.thingiverse.com/thing:1445822

base_thickness = 2.0;
base_diameter = 75.0;

post_idiameter = 31.0;
post_height = 20.0;
post_thickness = 2.0;

dome_diameter = 100;
dome_height = 13;

$fn = 50;

module base() {
   cylinder(d=base_diameter, h=base_thickness);
}

module post() {
    cylinder(d=post_idiameter+post_thickness*2, h=post_height+base_thickness);
}

module dome() {
    difference() {
        translate([0,0,-dome_diameter/2+dome_height]) sphere(d=dome_diameter);
        translate([-dome_diameter/2,-dome_diameter/2,-dome_diameter]) cube([dome_diameter,dome_diameter,dome_diameter]);
    }
}

module body() {

    union() {
        base();
        dome();
        post();
    }
}

// cutout the post hole
difference() {
    body();
    translate([0,0,base_thickness]) cylinder(d=post_idiameter, h=post_height*2);

}