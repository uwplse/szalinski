bodyHeight=40;
bodyWidth=37.5;
stickHeight=100;
stickWidth=20;
stickLocker=24;
grabHeight=40;
grabWidth=20;
grabOffset=4;

module body(){
    offset = 2;
    difference(){
        cylinder(h=bodyHeight,d=bodyWidth);
        cylinder(h=stickHeight,d=stickWidth+offset);
        sphere(d=stickLocker+offset);
        translate([0,0,bodyHeight]) sphere(d=stickLocker+offset);
    }
}

module stick(){
    cylinder(h=stickHeight,d=stickWidth);
    halfSphere(stickLocker,1);
    translate([0,0,bodyHeight]) halfSphere(stickLocker,-1);
}

module grab(){
    difference(){
        union(){
            cylinder(h=grabHeight,d=grabWidth);
            halfSphere(stickLocker,1);
            translate([0,0,bodyHeight]) halfSphere(stickLocker,-1);
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
stick();