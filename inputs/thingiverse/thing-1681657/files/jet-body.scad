$fn=120;

difference(){
    union(){
        cylinder(h=150,d=20);
        difference(){
            translate([0,0,150]) sphere(d=20);
            translate([0,0,130]) cylinder(h=20,d=20);
        }
    }

    union(){
        translate([0,0,-1]) cylinder(h=151,d=17);
        translate([0,0,150]) sphere(d=17);
    }
}