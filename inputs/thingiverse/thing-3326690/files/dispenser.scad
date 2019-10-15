bodyHeight=40;
bodyWidth=50;
grabHeight=40;
grabWidth=40;
grabLocker=44;
grabOffset=4;

module body(){
    offset = 2;
    difference(){
        cylinder(h=bodyHeight,d=bodyWidth);
        cylinder(h=grabHeight,d=grabWidth+offset);
        sphere(d=grabLocker+offset);
        translate([0,0,bodyHeight]) sphere(d=grabLocker+offset);
    }
}

module grab(){
    difference(){
        union(){
            cylinder(h=grabHeight,d=grabWidth);
            halfSphere(grabLocker,1);
            translate([0,0,bodyHeight]) halfSphere(grabLocker,-1);
        }
        translate([0,0,grabOffset]) cylinder(h=grabHeight,d=grabWidth-grabOffset);
    }
}

module halfSphere(d, dir){
    difference(){
        sphere(d=d);
        translate([0,0,(d/2)*-dir]) cube(d,center=true);
    }
}

body();
grab();