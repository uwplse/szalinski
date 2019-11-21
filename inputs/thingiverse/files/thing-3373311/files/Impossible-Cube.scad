size=100;
round_ratio=0.1;
$fn=100;

module roundcube() {
    translate([-size/2,-size/2,-size/2]) minkowski() {
        cube(size);
        sphere(size*round_ratio/3);    
    }
}

module drill_pattern() {
    difference() {
        cylinder(size/3,size/2-size*round_ratio,size/2-size*round_ratio,center=true);
        cylinder(2*size/3,2*size*round_ratio,2*size*round_ratio,center=true);
    }
}

module drill() {
    translate([0,0,size/2+size*round_ratio]) scale([1,1,2]) drill_pattern();
}

difference() {
    roundcube();
    drill();
    rotate(90,[1,0,0]) drill();
    rotate(180,[1,0,0]) drill();
    rotate(270,[1,0,0]) drill();
    rotate(90,[0,1,0]) drill();
    rotate(90,[0,-1,0]) drill();
}

