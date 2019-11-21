

// Outer diameter upper cylinder
a = 30;

// wall thickness upper cylinder
b = 3;

// inner diameter upper cylinder
c = a - b * 2;

// height upper cylinder
d = 70;

// max diameter base
e = 60;

// height base
f = 20;

// precision
$fn=10;

difference() {
    cylinder(d=a, h=d);
    cylinder(d=c, h=d);
}


hull() {
    translate([0,0, -2])
    cylinder(d=a, h =2);

    translate([0, 0, -f-2])
    cylinder(d=e, h = 2);

}