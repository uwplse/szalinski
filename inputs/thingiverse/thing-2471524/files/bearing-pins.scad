$fn = 50;

module bottom(){
difference(){
    union(){
        cylinder(7,4,4);
        cylinder(2,9,9);
    }
    translate([0,0,-1]) cylinder(12,2,2);
    translate([-6,-0.5,2]) cube([12,1,5]);
}
}

module topo(){
    union(){
        cylinder(10,1.8,1.8);
        cylinder(2,9,9);
    }
}

    translate([20,0,0]) bottom();
topo();