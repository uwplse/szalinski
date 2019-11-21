$fn = 150;

inner = 9;
outer = 74;
wall = 2;
deep = 20;

module luk() {
    wsp = 0.6;
    translate([0,outer*wsp/2])
    difference() {
        cylinder(deep, d=outer*wsp);
        translate([0,0,-0.1])
        cylinder(deep+0.2, d=outer*wsp-2*wall);
        translate([-2*outer, -outer, -0.1])
        cube([2*outer, 2*outer, deep+0.2]);
    }
}

module podstawa() {
    luk();
    rotate([0,0,120]) luk();
    rotate([0,0,240]) luk();
    cylinder(deep, d=inner+2*wall);
}

module blokada(kat) {
    rotate([0,0,kat])
    translate([outer/2,0,0])
    cylinder(3, d=10);
}

module srodek() {
    difference() {
        podstawa();
        translate([0,0,-0.1])
        cylinder(deep+0.2, d=inner);
    }    
}

intersection() {
    srodek();
    cylinder(deep, d=outer);    
}
blokada(60);
blokada(180);
blokada(300);