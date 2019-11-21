$fa = 1;
h = 7;
r1 = 39;
r2 = 11;
separation = 27.5;
r3 = 26;
borderWidth = 1;

union() {

difference() {
    cylinder(h=h, r=r1);
    cylinder(h=h, r=r2);
    
    translate([separation, 0, 0])
    cylinder(h=h, r=r2);
    
    translate([(-1 * separation), 0, 0])
    cylinder(h=h, r=r2);
    
    translate([0, separation, 0])
    cylinder(h=h, r=r2);
    
    translate([0, (-1 * separation), 0])
    cylinder(h=h, r=r2);
    
    translate([26, -26, 0])
    cylinder(h=h, r=14);
    
    translate([26, 26, 0])
    cylinder(h=h, r=14);
    
    translate([-26, -26, 0])
    cylinder(h=h, r=14);
    
    translate([-26, 26, 0])
    cylinder(h=h, r=14);
    
}

difference() {

    cylinder(h=h, r=r3);
    cylinder(h=h, r=(r3-borderWidth));
    
    translate([separation, 0, 0])
    cylinder(h=h, r=r2);
    
    translate([-separation, 0, 0])
    cylinder(h=h, r=r2);
    
    translate([0, separation, 0])
    cylinder(h=h, r=r2);
    
    translate([0, -separation, 0])
    cylinder(h=h, r=r2);
    
    
}

}