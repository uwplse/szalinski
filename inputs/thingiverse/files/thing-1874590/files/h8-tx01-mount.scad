
// Eachine TX01 mount


module tx01_mount() {

    difference() {
        union() {
            color("blue") h8_bottom_plate();
            color("red") translate ([-10.5,-6.5,-1.5]) rotate ([-20,0,0]) tx01_box();
        }
        // xtal cutout
        translate ([-4,-3,0]) rotate([90,0,0])
            cylinder(r=2, h=8, center=true, $fn=64);
        // cap cutout
        translate ([3,2,-0.2]) cube([3,5,1.5]);
        // bottom cutoff
        translate ([-18,-22,-36]) cube(36);
    }
}

module tx01_box() {
    difference() {
        cube([21,10,13]);
        //inner
        translate ([1,1,-0.5]) cube([19,8,14]);
        
        translate ([6,-0.5,9]) cube([9,2,5]);
        translate ([-0.5,3,11]) cube ([2,8.5,3]);
        translate ([12,8.5,10]) cube ([8,2,4]);
    }
}


module h8_bottom_plate() {
    difference() {
        union() {
            // arc left
            difference() {
                translate([42,0,0.5])
                    difference() {
                        cylinder(r=33, h=1, center=true);
                        cylinder(r=29, h=2, center=true);
                    }
                //holes
                translate([15.5,15.5,-0.75]) cylinder(r=0.75, h=2,$fn=32);
                translate([15.5,-15.5,-0.75]) cylinder(r=0.75, h=2,$fn=32); 
            }
            // arc right
            difference() {
                translate([-42,0,0.5])
                    difference() {
                        cylinder(r=33, h=1, center=true);
                        cylinder(r=29, h=2, center=true);
                    }
                //holes
                translate([-15.5,15.5,-0.75]) cylinder(r=0.75, h=2,$fn=32);
                translate([-15.5,-15.5,-0.75]) cylinder(r=0.75, h=2,$fn=32); 
            }
        }
        difference() {            
            cylinder(r=76, h=3, center=true);
            cylinder(r=24.5, h=4, center=true);
        }
    }
    
    // rear beam
    //translate([0,8.5,.5]) cube([25,1,1], center=true);
}

tx01_mount();
//rotate ([0,0,45]) translate([0,0,-3]) import("h8framefinal.stl");