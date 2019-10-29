/* [Image] */
// Height
h=160;
// Width
w=106.5;
// Thickness
t=3;

/* [Hidden] */
e14 = 14;
e14_outer = 20;

translate([0,0,20]) corner();
outer();
inner();

module inner() {
    difference() {
        union() {
            cylinder(h=2*t, r=e14_outer, $fn=50, center=true);
            cube([w, 3*t, 2*t], center=true);
            cube([3*t, w, 2*t], center=true);
        }
        cylinder(h=100, r=e14+0.5, $fn=50, center=true);
    }
};

module outer() {
    difference() {
        union() {
            translate([-(w/2 + t-1), 0, 0]) cube([2*t,w+4*t-2,2*t], center=true);
            translate([+(w/2 + t-1), 0, 0]) cube([2*t,w+4*t-2,2*t], center=true);
            translate([0, -(w/2 + t-1), 0]) cube([w-2,2*t,2*t], center=true);
            translate([0, +(w/2 + t-1), 0]) cube([w-2,2*t,2*t], center=true);
        }
        translate([-(w/2 + t-1.1), -(w/2 + t-1.1), 10])  cube([t+0.2, t+0.2, t+20], center=true);
        translate([+(w/2 + t-1.1), -(w/2 + t-1.1), 10])  cube([t+0.2, t+0.2, t+20], center=true);
        translate([-(w/2 + t-1.1), +(w/2 + t-1.1), 10])  cube([t+0.2, t+0.2, t+20], center=true);
        translate([+(w/2 + t-1.1), +(w/2 + t-1.1), 10])  cube([t+0.2, t+0.2, t+20], center=true);
    }
}

module corner() {
    difference() {
        cube([h, 2*t, 2*t], center=true);
        translate([0, t+0.5, 0]) cube([2*h, t+0.1, t+0.1], center=true);
        translate([0, 0, t+0.5]) cube([2*h, t+0.1, t+0.1], center=true);
    }
    translate([-h/2-t/2,0,0]) cube([t,t,t], center=true);
    translate([+h/2+t/2,0,0]) cube([t,t,t], center=true);
}