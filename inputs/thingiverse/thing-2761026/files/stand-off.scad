$fn=64;

height = 10;

m=3;
w=5;
space=0.4;

difference() {
    depth = height/2-space/2;
    hex(w,height);
    translate([0,0,space/2]) cylinder(depth,m/2,m/2);
    translate([0,0,-depth-space/2]) cylinder(depth,m/2,m/2);
};


module hex(w,h) {
    hull() {
        cube([w/sqrt(3),w,h],center=true);
        rotate([0,0,120]) cube([w/1.7,w,h],center=true);
    }
};

