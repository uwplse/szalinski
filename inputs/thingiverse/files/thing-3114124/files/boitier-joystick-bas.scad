$fn = 100;

rotate_extrude()
    import(file = "boitier-joystick-bas-moitie.dxf",layer = "0");

module petit_picot() {
   translate([0, 0, 1.5]) cube([2, 5, 3], center = true);
}

module grand_picot() {
   translate([0, 0, 3]) cube([2, 5, 6], center = true);
}

module picots() {
    translate([12 , 12,  0]) rotate([0, 0, 45]) petit_picot();
    translate([-12 , 12,  0]) rotate([0, 0, -45]) petit_picot();
    translate([12 , -12,  0]) rotate([0, 0, -45]) petit_picot();
    translate([-12 , -12,  0]) rotate([0, 0, 45]) petit_picot();

    translate([15 , 15,  0]) rotate([0, 0, 45]) grand_picot();
    translate([-15 , 15,  0]) rotate([0, 0, -45]) grand_picot();
    translate([15 , -15,  0]) rotate([0, 0, -45]) grand_picot();
    translate([-15 , -15,  0]) rotate([0, 0, 45]) grand_picot();
}

translate([-8, 0, 2]) picots();
