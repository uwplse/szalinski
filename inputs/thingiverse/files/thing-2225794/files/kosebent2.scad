Width=15;
Length=20;
HoleDiameter=3.2;
Thickness=5;

$fn=100;

a=Width;
b=Length;
r=HoleDiameter/2;
d=Thickness;


color([.4,.5,.7,1])
intersection () {
difference () {
    cube(size=[b,b,a]);

    translate([2*d,2*d,-a/2]) 
    minkowski() {
        cube(size=[2*b,2*b,a]);
        cylinder(r=d,h=a); 
    }

union() {
    translate ([b-a/2,2*d,a/2]) rotate([90,0,0]) cylinder(r=r,h=3*d);
    translate ([-d,b-a/2,a/2]) rotate([0,90,0]) cylinder(r=r,h=3*d);
    translate([b-a/2,0,a/2]) rotate([-90,0,0]) translate([0,0,d-r]) cylinder(r1=r,r2=2*r,h=r+.3);
    translate([0,b-a/2,a/2]) rotate([0,90,0]) translate([0,0,d-r]) cylinder(r1=r,r2=2*r,h=r+.3);
}
}
/*
    union() {
    translate([0,-1,a/2]) rotate([-90,0,0]) cylinder(r=a/2,h=b+2);
    translate([-1,0,a/2]) rotate([0,90,0]) cylinder(r=a/2,h=b+2);
//    translate([0,0,a/2]) sphere(a/2+d);
    }
*/
}

