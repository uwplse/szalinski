$fn=60;

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

module hole() {
    translate([0,0,8]) rotate([90,90,0]) cylinder(r1=5, r2=0, h=12, center=true);
    translate([0,0,8]) rotate([90,90,0]) cylinder(r1=0, r2=5, h=12, center=true);
}

module vert_hole() {
    cylinder(r=1.5, h=50, center=true);
}

module lighter() {
    
    
    for (y = [-18: 6: 18]) {
        translate([0, y, 0] )vert_hole();
        translate([-6, y, 0]) vert_hole();
        translate([-12, y, 0]) vert_hole();
        if (abs(y) < 18) translate([6, y, 0]) vert_hole();
    }
    
    translate([-12, 24, 0]) vert_hole();
    translate([-12, -24, 0]) vert_hole();
    
    translate([-24, -18, 0]) vert_hole();
    translate([-24, 18, 0]) vert_hole();
    
    translate([-30, -18, 0]) vert_hole();
    translate([-30, 18, 0]) vert_hole();
}

module grip() {
    difference() {
        hull() {
            translate([-17, 2, 0]) rotate([90,90,0]) rounded_cylinder(r=10, h=4, n=1.5);
            translate([13, 2, 0]) rotate([90,90,0]) rounded_cylinder(r=10, h=4, n=1.5);
            translate([-17, 2, 5]) rotate([90,90,0]) rounded_cylinder(r=10, h=4, n=1.5);
            translate([13, 2, 5]) rotate([90,90,0]) rounded_cylinder(r=10, h=4, n=1.5);
        }
        
        translate([-2,0,0]) hole();
        translate([-17,0,0]) hole();
        translate([13,0,0]) hole();
    }
   
    hull() {
        translate([-23,0,0]) sphere (r=4);
        translate([19,0,0]) sphere (r=4);
    }
    
    hull() {
        translate([-25,-5,0]) cylinder (r=2.5, h=2, center=true);
        translate([-25,5,0]) cylinder (r=2.5, h=2, center=true);
        translate([15,-5,0]) cylinder (r=2.5, h=2, center=true);
        translate([15,5,0]) cylinder (r=2.5, h=2, center=true);
    }
}

difference() {
    union() {
        hull() {
            translate([-22,-29.5,0]) cylinder (r=5, h=2, center=true);
            translate([-22,29.5,0]) cylinder (r=5, h=2, center=true);
            translate([22,-10,0]) cylinder (r=5, h=2, center=true);
            translate([22,10,0]) cylinder (r=5, h=2, center=true);
        }

        translate([-39,-27,0]) grip();
        translate([-39,27,0]) grip();
        
        hull() {
            translate([-25,-10, 0]) cylinder (r=.5, h=2, center=true);
            translate([-25,-20, 0]) cylinder (r=.5, h=2, center=true);
            translate([-40,-20, 0]) cylinder (r=.5, h=2, center=true);
        }
        hull() {
            translate([-25,10, 0]) cylinder (r=.5, h=2, center=true);
            translate([-25,20, 0]) cylinder (r=.5, h=2, center=true);
            translate([-40,20, 0]) cylinder (r=.5, h=2, center=true);
        }        
    }

    
    hull() {
        translate([15, -10, 0]) cylinder(r=2, h=4, center=true);
        translate([15, 10, 0]) cylinder(r=2, h=4, center=true);
    }
    
    translate([-34,0,0]) hull() {
        translate([15, -10, 0]) cylinder(r=2, h=4, center=true);
        translate([15, 10, 0]) cylinder(r=2, h=4, center=true);
    }
    
    lighter();
    translate([0,0,-11]) cube([200,80,20], center=true);
}
