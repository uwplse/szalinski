$fn=32 * 4;

platformHeight = 15.5; //clearance between y carriage and belt. Default 15.5mm fits for my Prusa i3. 

module beltClamp(){
    module frame(){
        hull(){
            translate([7,8,0]) rotate([0,0,30]) cylinder(10,8,8,$fn=6);
            translate([31,8,0]) rotate([0,0,30]) cylinder(10,8,8,$fn=6);
        }
    }
    module beltLoop(){
        difference(){
            hull(){
                translate([6.5,1,0]) cylinder(h = 12, r1 = 1, r2 = 1);
                translate([13.5,5.5,0]) cylinder(h = 12, r1 = 5.5, r2 = 5.5);
            }
            hull(){
                translate([9,2.5,0]) cylinder(h = 12, r1 = 1, r2 = 1);
                translate([13.5,5.5,0]) cylinder(h = 12, r1 = 4, r2 = 4);
            }
        }
        cube([8,2,12]);
    }
    module beltOpening(){
        beltLoop();
        translate([38,0,0]) mirror(1,0,0) beltLoop();
        translate([17.5,2.5,0]) cube([3,8,12]);
        translate([19,7,0]) rotate([0,0,45]) cube([4,4,12]);
    }
    difference(){
        frame();
        translate([0,6.5,3]) beltOpening();
        }
}
module platform(){
    translate([8.5,0,-0]) cube([33,platformHeight,10]);
    difference(){
        translate([0,0,0]) cube([50,4,10]);
        translate([4.5,0,6]) rotate([-90,0,0]) cylinder(h=30, r=1.7, $fn=10);
        translate([45.5,0,6]) rotate([-90,0,0]) cylinder(h=30, r=1.7, $fn=10);
    }
}
translate([6,platformHeight-6.5,0]) beltClamp();
platform();
