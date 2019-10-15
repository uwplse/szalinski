
a=44;
b=12;
c=30.5;
d=20;
w=2;
$fn=50;

/*
hull()
intersection() {
translate([-a/4,-a/2,0])
cube([a/2,a,b]);
foo(a,b,a,0.0001,-1);
}
*/
foo(a,b,c,w,w/2);

module foo(a,b,c,w,d) {
translate([-a,0,0])
difference() {
cube([a,a,b]);
    translate([a/2,a/2,-1])
    cylinder(h=b+2,d=c);
}
translate([-w,0,0])
translate([a,a/2,0])
difference() {
cylinder(h=b/2,d=2*a);
    translate([0,0,d]) 
    cylinder(h=b,d=2*a-2*w);
}
}
/*
difference() {
cube([a/2,a,b]);
  translate([a/4,a/2,-1])
    cylinder(h=b+2,d=a/3);
translate([6*a/18,0,-1])
cube([a/8+1,a,b+2]);
}
hull() {
  translate([a/2-a/12,5*a/16,0])
    cylinder(h=b,d=a/6);
translate([3*a/8,0,0])
cube([a/8,a/8,b]);
}*/
