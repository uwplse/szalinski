// Build Volume 250 x 210 x 210 mm

//200 x 273, 2 slack, 3 rim

$fn=120;

width=210;
length=200;
base_thickness=3;
support_radius=15.9;

difference() {

    // adds
    union() {
        translate([30,25,0]) cylinder(h=209,r=support_radius);
        translate([65,25,0]) cylinder(h=209,r=support_radius);
        translate([30,60,0]) cylinder(h=209,r=support_radius);
        translate([65,60,0]) cylinder(h=209,r=support_radius);
    }

    // subtracts
    union() {
    }


}