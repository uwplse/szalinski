$fn=120;

module battery() {
    color("blue") {
        translate([-9,0,9]) rotate([90,0,0]) cylinder(r=18/2, h=65, center=true);
        translate([-9,0,-9]) rotate([90,0,0]) cylinder(r=18/2, h=65, center=true);
        translate([9,0,-9]) rotate([90,0,0]) cylinder(r=18/2, h=65, center=true);
        translate([9,0,9]) rotate([90,0,0]) cylinder(r=18/2, h=65, center=true);
    }
}

module hole() {
    hull() {
        translate([0, -10, 0]) cylinder(r=2.5, h=50, center=true);
        translate([0, 10, 0]) cylinder(r=2.5, h=50, center=true);
    }
}


difference() {
    union() {
        difference() {
            rotate([90,0,0]) {
                difference() {
                    cylinder(r=42, h=102, center=true);
                    cylinder(r=42-2, h=103, center=true);
                }
            }

            translate([0,0,-50+11]) cube([100,250,100], center=true);
            translate([-50,0,50]) cube([100,250,100], center=true);
        }

        intersection() { 
            union() {
                translate([32,0,10.5]) cube([18,102,1], center=true);
                for (a=[-50 : 10 : 20]) {
                    color("red") translate([30,a,23]) cube([14,1.5,25], center=true);
                }
            }
            rotate([90,0,0]) cylinder(r=42, h=102, center=true);
        }
        
        intersection() { 
            color("grey") translate([40,0,30]) cube([17,33,40], center=true);
            rotate([90,0,0]) cylinder(r=42, h=102, center=true);
        }

    }


    translate([37,0,0]) cube([8, 30, 100], center=true);
    
    hull() {
        translate([9,0,9 + 18]) rotate([90,0,0]) cylinder(r=22/2, h=67, center=true);
        translate([9-20,0,9 + 18]) rotate([90,0,0]) cylinder(r=22/2, h=67, center=true);
    }
    
    translate([10,0,37]) rotate([0,90,0]) hole();
    
    hull() {
        translate([30,44,19]) rotate([0,90,0]) cylinder(r=8, h=50, center=true);
        translate([30,44,0]) rotate([0,90,0]) cylinder(r=8, h=50, center=true);
        translate([30,55,19]) rotate([0,90,0]) cylinder(r=8, h=50, center=true);
    }
    
}

intersection() { 
    color("green") translate([30,52-18,25]) cube([35,2,30], center=true);
    rotate([90,0,0]) cylinder(r=42, h=102, center=true);
}

intersection() { 
    color("blue") translate([20,-50,25]) cube([40,2,30], center=true);
    rotate([90,0,0]) cylinder(r=42, h=102, center=true);
}

intersection() {
    translate([0,50,0]) {
        rotate([90,0,0]) {
            cylinder(r=42, h=2, center=true);
        }
    }
    translate([0,49,27]) cube([32,10,30]);
}


//translate([0,0,18]) battery();