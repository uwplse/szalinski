$fn = 100;

difference() {
    rotate_extrude()
        import(file = "boitier-joystick-haut-moitie.dxf",layer = "0");

    translate([-8, 0, 20])
        cube(size=19, center=true);
};

module picot() {
   cylinder(h = 4, r=1, center = true);
}

module picots() {
    translate([12 , 12,  0]) picot();
    translate([-12 , 12,  0]) picot();
    translate([12 , -12,  0]) picot();
    translate([-12 , -12,  0]) picot();
}

translate([-8, 0, 14]) picots();
