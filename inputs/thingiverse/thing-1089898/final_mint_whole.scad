//Top
translate([0,0,6.2*2])difference() {
    union() {
        cube([20,49,3], center=true);
        cube([49,20,3], center=true);
        translate([15,-5,0])cube([10,39,3], center=true);
        translate([5,-15,0])cube([39,10,3], center=true);
        translate([-12,17,0])cube([39,15,3], center=true);
        translate([10,10,0])cylinder(h=3, r=14.5, $fs=1, center=true);
        translate([-10,-10,0])cylinder(h=3, r=14.5, $fs=1, center=true);
        translate([20,-20,0])cylinder(h=3, r=4.5, $fs=1, center=true);
        translate([0,0,2.5]){
            translate([15,-15,0])sphere(r=5, $fa=5, $fs=1);
            translate([-15,15,0])sphere(r=5, $fa=5, $fs=1); 
        }
        translate([0,0,-4.3])cube([11,11,5.7], center=true);
        difference() {
            translate([0,0,-2.6])cube([11,49,4.2], center=true);
            translate([15,-15,0])cylinder(h=13, r=13, $fs=1, center=true);
            translate([-15,15,0])cylinder(h=13, r=13, $fs=1, center=true);
        }
    }
    translate([-31,10,0])cylinder(h=13, r=6.5, $fs=1, center=true);
    translate([0,0,6.5])cube([50,50,10], center=true);
    translate([0,0,-14.7]){
        cylinder(h=13.2, r=5.2/2, $fs=1);
        cylinder(h=3.7, r=8.8/2, $fs=1);
        translate([0,0,9.2])cylinder(h=4, r=9.2/2, $fn=6);
    }
    translate([5,0,-3.5])cube([19.4,9.2,4], center=true);
    translate([0,0,-2])cylinder(h=3, r=3, $fs=1, center=true);
}

//Middle
translate([0,0,6.2])difference() {
    union() {
        cube([20,49,3], center=true);
        cube([49,20,3], center=true);
        translate([15,-5,0])cube([10,39,3], center=true);
        translate([5,-15,0])cube([39,10,3], center=true);
        translate([-12,17,0])cube([39,15,3], center=true);
        translate([10,10,0])cylinder(h=3, r=14.5, $fs=1, center=true);
        translate([-10,-10,0])cylinder(h=3, r=14.5, $fs=1, center=true);
        translate([20,-20,0])cylinder(h=3, r=4.5, $fs=1, center=true);
        intersection() {
            translate([0,0,-2.5]){
                translate([15,-15,0])sphere(r=5, $fa=5, $fs=1);
                translate([-15,15,0])sphere(r=5, $fa=5, $fs=1); 
            }
            translate([0,0,2.5]){
                translate([15,-15,0])sphere(r=5, $fa=5, $fs=1);
                translate([-15,15,0])sphere(r=5, $fa=5, $fs=1); 
            }
        }
    }
    translate([-31,10,0])cylinder(h=13, r=6.5, $fs=1, center=true);
    translate([0,0,0])cube([11,11,5.7], center=true);  
}

//bottom
difference() {
    union() {
        cube([20,49,3], center=true);
        cube([49,20,3], center=true);
        translate([15,-5,0])cube([10,39,3], center=true);
        translate([5,-15,0])cube([39,10,3], center=true);
        translate([-12,17,0])cube([39,15,3], center=true);
        translate([10,10,0])cylinder(h=3, r=14.5, $fs=1, center=true);
        translate([-10,-10,0])cylinder(h=3, r=14.5, $fs=1, center=true);
        translate([20,-20,0])cylinder(h=3, r=4.5, $fs=1, center=true);
        translate([0,0,-2.5]){
            translate([15,-15,0])sphere(r=5, $fa=5, $fs=1);
            translate([-15,15,0])sphere(r=5, $fa=5, $fs=1); 
        }
        translate([0,0,3.3])cube([11,11,3.8], center=true);  
        rotate([0,0,90])mirror([0,1,0])difference() {
            translate([0,0,2.6])cube([11,49,4.2], center=true);
            translate([15,-15,0])cylinder(h=13, r=13, $fs=1, center=true);
            translate([-15,15,0])cylinder(h=13, r=13, $fs=1, center=true);
        }
    }
    translate([-31,10,0])cylinder(h=13, r=6.5, $fs=1, center=true);
    translate([0,0,-6.5])cube([50,50,10], center=true);
    translate([0,0,-1.5]){
        cylinder(h=13.2, r=5.2/2, $fs=1);
        cylinder(h=3.7, r=8.8/2, $fs=1);
        translate([0,0,9.2])cylinder(h=4, r=9.2/2, $fn=6);
    }
}