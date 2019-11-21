$fn=50;
/* Base */
a=25;
d=4;
r=1.6;

base(a=a,d=d,r=r);

module base(a,d,r) {


    difference() {
        kose(a=a,d=d);
        union() {
            delik(r=r,a=a,d=d);
            pah(r=r,a=a,d=d);
        }
        color([0.4,0.5,0.8,1.0]) union() {
            w=a*0.8;
            translate([a,0,a]) rotate([90,0,0]) rotate([0,0,45]) cube(size=[w,w,3*d],center=true);
            translate([0,a,a]) rotate([0,90,0]) rotate([0,0,45]) cube(size=[w,w,3*d],center=true);
            translate([a,a,0]) rotate([0,0,0]) rotate([0,0,45])  cube(size=[w,w,3*d],center=true);
        }
    }
}
module kose(a,d) {
    color([0.4,0.5,0.8,1.0])
    difference () {
        union() {
            cube(size=[a,a,d]);
            translate([0,0,d]) cube(size=[d,a,a-d]);
            translate([d,0,d]) cube(size=[a-d,d,a-d]);
            translate([d,d,d]) cube(size=[a-d,d,d]);
            translate([d,2*d,d]) cube(size=[d,a-2*d,d]);
            translate([d,d,2*d]) cube(size=[d,d,a-2*d]);
        }

        translate([2*d,2*d,2*d]) 
        hull() {
            rotate([0,90,0]) cylinder(r=d*1.0,h=a);
            rotate([-90,0,0]) cylinder(r=d*1.0,h=a);
            rotate([0,0,0]) cylinder(r=d*1.0,h=a);
            sphere(r=d);
        }
    }
    

}

module delik(r,a,d) {color([0.4,0.5,0.8,1.0])
union() {
    translate([a/2,0,a/2]) rotate([90,0,0]) cylinder(r=r,h=a,center=true);
    translate([0,a/2,a/2]) rotate([0,90,0]) cylinder(r=r,h=a,center=true);
    translate([a/2,a/2,0]) rotate([0,0,0]) cylinder(r=r,h=a,center=true);
}
}

module pah(r,a,d) {
    color([0.4,0.5,0.8,1.0])
    union () {
        translate([a/2,d-r,a/2]) rotate([270,0,0]) cylinder(r1=r,r2=2*r,h=r+1,center=false);
        translate([d-r,a/2,a/2]) rotate([0,90,0]) cylinder(r1=r,r2=2*r,h=r+1,center=false);
        translate([a/2,a/2,d-r]) rotate([0,0,0]) cylinder(r1=r,r2=2*r,h=r+1,center=false);
    }
}

