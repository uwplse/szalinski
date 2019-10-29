$fn=50;
r_cap=62/2;
d=2;

difference() {
hull() {
rotate([-10,0,0]) {
    translate([0,0,-d-0.1])
cylinder(r=r_cap+d, h=d*2);
}
translate([0,0,-sin(10)*(r_cap+d)-d])
cylinder(r=r_cap+d, h=d);
}

rotate([-10,0,0]) {
    cylinder(r=r_cap, h=d);
}
}
