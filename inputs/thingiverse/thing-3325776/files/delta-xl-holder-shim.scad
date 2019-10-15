phone_thickness = 9;  // Pixel 2 measured 8.4 with screen protector
phone_width = 80; // Pixel 2 measured 70mm

module Thing(slot_w, od) {
    slot_w2 = slot_w/2;
    difference() {
        union() {
            hull() { // body
                rotate([0,180,0]) translate([45.35-od/2, 3, 0]) rotate([-90,0,0]) cylinder(d=od, h=4, $fn=50);
                rotate([0,  0,0]) translate([45.35-od/2, 3, 0]) rotate([-90,0,0]) cylinder(d=od, h=4, $fn=50);
            }
        hull() { // body rounded top
                rotate([0,180,0]) translate([45.35-od/2, 7, 0]) sphere(r=od/2, $fn=50);
                rotate([0,  0,0]) translate([45.35-od/2, 7, 0]) sphere(r=od/2, $fn=50);
            }
            hull() { // protrusion slot
                rotate([0,180,0]) translate([slot_w2-7.9/2, 0, 0]) rotate([-90,0,0]) cylinder(d=7.9, h=16, $fn=50);
                rotate([0,  0,0]) translate([slot_w2-7.9/2, 0, 0]) rotate([-90,0,0]) cylinder(d=7.9, h=16, $fn=50);
            }
        }
        // delete bottom parts of body rounded top
        translate([0,-47,0]) cube([100,100,100], center=true);

        phz = phone_thickness + 5; // +5 for rubber bumpers
        phw = phone_width/2;
        hull() { // pixel2
            rotate([0,180,0]) translate([phw-phz/2, 2-phz/2, +2]) rotate([-90,0,0]) cylinder(d=phz, h=10, $fn=50);
            rotate([0,  0,0]) translate([phw-phz/2, 2-phz/2, -2]) rotate([-90,0,0]) cylinder(d=phz, h=10, $fn=50);
        }
        hull() { // pixel2 round top
                rotate([0,180,0]) translate([phw-phz/2, 12-phz/2, +2]) sphere(r=phz/2, $fn=50);
                rotate([0,  0,0]) translate([phw-phz/2, 12-phz/2, -2]) sphere(r=phz/2, $fn=50);
        }
    }
}



// top
difference() {
    Thing(68.5, 12.8); // top sized different
    // more port openingss go here
}
// bottom
translate([0,0,20]) difference() {
    Thing(70.5, 12.7); // only different because parts come out of printer different???
    hull() {  // charge port opening
        translate([+5,15,0]) cylinder(d=10, h=50, center=true);
        translate([-5,15,0]) cylinder(d=10, h=50, center=true);
    }
}