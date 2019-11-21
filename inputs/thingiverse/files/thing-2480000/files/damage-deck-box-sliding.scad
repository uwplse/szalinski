module panel(x,y,z)
{
    translate([x,y,z]) rotate([90,0,0]) {
    difference() {
        cube([30,30,1]);
        translate([0,14.5,0]) cube([30,1,1]);
        translate([14.5,0,0]) cube([1,30,1]);
        translate([15,15,0]) cylinder(h=1,r=3);
    }
    translate([15,15,0]) cylinder(h=1,r=2.5);
    }
}

l=84;
w=48;
h=30;
t=2;
difference() 
{
    union() {
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
        panel(9.5,0,2);
        panel(48.5,0,2);
        panel(9.5,53,2);
        panel(48.5,53,2);
    }
    translate([t+10,t+1,t]) cube([l-10,w-2,h]);
    translate([0,t/2,h+t]) {
        difference() {
            cube([l,w+t,t+1]);
            rotate([45,0,0]) cube([l,2*t,2*t]);
            translate([0,w+t,0]) rotate([45,0,0]) cube([l,2*t,2*t]);
        }
    }
    translate([10,w/2,t]) cylinder(r=8,h=h);
}

/*translate([0,t,50]) {
    difference() {
    cube([l,w,t]);
    rotate([45,0,0]) cube([l,2*t,2*t]);
    translate([0,w,0]) rotate([45,0,0]) cube([l,2*t,2*t]);
    }
}*/