module panel(x,y,z)
{
    d=0.5;
    s=8;
    translate([x,y,z]) rotate([90,0,0]) {
    difference() {
        cube([2*s,2*s,0.6]);
        translate([0,s-d/2,0]) cube([2*s,1,1]);
        translate([s-d/2,0,0]) cube([1,2*s,1]);
        translate([s,s,0]) cylinder(h=1,r=3,$fn=20);
    }
    translate([s,s,0]) cylinder(h=0.5,r=2.5,$fn=20);
    }
}

l=32;
w=16;
h=16;
t=2;
hull() {
    translate([1,1,1]) sphere(r=1);
    translate([1,1,h+t+1]) sphere(r=1);
    translate([l+t,1,h+t+1]) sphere(r=1);
    translate([l+t,1,1]) sphere(r=1);
    translate([1,w+t+1,1]) sphere(r=1);
    translate([1,w+t+1,h+t+1]) sphere(r=1);
    translate([l+t,w+t+1,h+t+1]) sphere(r=1);
    translate([l+t,w+t+1,1]) sphere(r=1);
}
panel(1.5,0,2);
panel(18,0,2);
panel(1.5,20.5,2);
panel(18,20.5,2);

translate([-0.5,2,2]) rotate([0,0,90]) panel(0,0,0);
translate([35,2,2]) rotate([0,0,90]) panel(0,0,0);
translate([1.5,2,20]) cube([16,16,0.5]);
translate([18,2,20]) cube([16,16,0.5]);
