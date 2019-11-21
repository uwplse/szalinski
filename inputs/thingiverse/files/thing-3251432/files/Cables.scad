$fn = 30;

module shape(x,y,z) {
    R=6;
    minkowski() {
        cube([x-R,y-R,z], center=true);
        cylinder(d=R);
    }
}

module piece(X,Y,Z,W, CUT=0){
    translate([0,0,Z/2])
    difference() {
        shape(X,Y,Z);
        shape(X-W,Y-W,Z+1);
        
        translate([X/2, 0, 0])
            rotate([40,0,0])
                cube([W+5, CUT, Z*5], center=true);
    }
}

dx=25;
dy=50;

thic = 2.4;

translate([dx*0, dy*0, 0]) piece(15, 50, 10, thic, 10);
translate([dx*1, dy*0, 0]) piece(15, 40, 10, thic);
translate([dx*2, dy*0, 0]) piece(10, 40, 10, thic, 10);

translate([dx*0, dy*1, 0]) piece(12, 20, 10, thic, 5);
translate([dx*1, dy*1, 0]) piece(15, 25, 10, thic, 5);
translate([dx*2, dy*1, 0]) piece(15, 30, 10, thic);

translate([dx*0, dy*2, 0]) piece(12, 45, 10, thic);
translate([dx*1, dy*2, 0]) piece(12, 40, 10, thic, 8);
translate([dx*2, dy*2, 0]) piece(12, 30, 10, thic);
