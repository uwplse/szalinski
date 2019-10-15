// simple parametric bridge test
//Longest span
x= 100;
// Number of spans
n=6;
// Height of towers
ht=6;
// Diameter of towers
d1=5;
// Thickness of bridge
th=.6;
// Base yes/no [0/1]
base=1;

for (i=[1:n]) {
    translate([0,i*(d1+3),0]) bridge(i*x/n);
    }

if (base){
    hull() {
    translate([0,d1+3,0]) cylinder(d=d1,h=th);
    translate([0,n*(d1+3),0]) cylinder(d=d1,h=th);
    }

    hull() {
    translate([x/n,d1+3,0]) cylinder(d=d1,h=th);
    translate([x,n*(d1+3),0]) cylinder(d=d1,h=th);
    }
}

module bridge(l) {
    cylinder(d=d1,h=ht);
    translate([l,0,0]) cylinder(d=d1,h=ht);
    hull() {
    translate([0,0,ht]) cylinder(d=d1,h=th);
    translate([l,0,ht]) cylinder(d=d1,h=th);
    }
}