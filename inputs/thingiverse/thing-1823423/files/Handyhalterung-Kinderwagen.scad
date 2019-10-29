d=35;
h=27;
what=0; // 0 = both, 1 = left, 2 = right, 3 = both printable

if(what != 2) { 
    clamp_flex(1);
    mount_plate();
} 

if(what != 1) {
    translate([what==3 ? 10 : 0, what==3 ? 5 : 0, 0])
    rotate([0,0,what==3 ? -60 : 0])
    mirror([0,0,1]) mirror([1,0,0]) clamp_flex(0);
}

module hook() {
    cylinder(r=3, h=6, center=true, $fn=40);
    translate([0,0,4]) cylinder(r=6, h=2, center=true, $fn=50);
}

module clamp_flex(support = 0) {
    // joint
    translate([0,d/2+3,0]) difference() {
        union() {
            hull() {
                cylinder(r=8/2, h=h, $fn=40, center=true);
                translate([-7,-2.5,0]) cylinder(r=4/2, h=h, $fn=40, center=true);
            }
            if(support) {
                translate([-8/2,2,0]) cube([8, 12, h], center=true);
            } 
        }
        translate([0,0,-h/4-h/8]) cylinder(r=8/2+1, h=h/4+0.5, $fn=40, center=true);
        translate([0,0,h/8]) cylinder(r=8/2+1, h=h/4+0.5, $fn=40, center=true);
        cylinder(r=2.5, h=100, center=true, $fn=20);
    }
    // The clamp itself
    difference() {
        cylinder(r=d/2+4, h=h, center=true, $fn=50);
        cylinder(r=d/2, h=h+10, center=true, $fn=50);
        translate([0, -d*1.45, 0]) cube([2*d, 2*d, 2*d], center=true);
        translate([-5, -d, 0]) cube([10, 2*d, 2*d], center=true);
        translate([-5, -50, -50]) cube([100,100,100]);
    }
    // end
    translate([-d/4*1.35, -d/4*1.45-2, 0]) cylinder(r=3, h=h, center=true, $fn=40);    
    rotate([0,0,210]) translate([d/2+6, 0, 0]) rotate([0,90,0]) hook();
}

module mount_plate() {
    translate([0,d/2+14,0]) rotate([-90,90,0]) {
        mount_grid();
        translate([0,0,-4]) cube([27,40,2], center=true);
    }
}

module mount_grid() {
    translate([-10.5, -15, 0]) mount_grid_module();
    translate([10.5, -15, 0]) mirror([180,0,0]) mount_grid_module();
    translate([-10.5, 15, 0]) mount_grid_module();
    translate([10.5, 15, 0]) mirror([180,0,0]) mount_grid_module();
}

module mount_grid_module() {    
    translate([-1.5, -3, 0]) cube([5, 6, 2]);
    translate([-1.5, -3, -3]) cube([2.5, 6, 3]);
}