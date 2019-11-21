//Customizable Options

Render_Quality = 100; //[5:100]

Electronics_Area = 0; //[0:No, 1:Yes]

Model_View = 0; //[0:Everything, 1:Printable, 2:Body, 3:Arms, 4:Backing, 5:Locking Pin]

//End of Customizable Options

$fn = Render_Quality+0;
//#translate([0,5,37.5]) cube([50,50,75], center = true);
//translate it all up to that the bottom is at the origin
rotate([0,0,180]) {
    translate([0,0,12]) {
        //bottom
        if (Model_View < 3) {
            difference(){
                sphere(r=25);
                //make bottom flat
                translate([0,0,-20]) cube([50,50,16],center = true);
                if (Electronics_Area == 1) {
                    //back hole
                    translate([-10,0,40]) cube([30,20,100], center = true);
                    difference() {
                        sphere(r=19);
                        translate([0,0,-18.01]) cube([50,50,16],center = true);
                    }
                }
            }
        
            //body
            difference(){
                translate([0,0,30]) sphere(r=19);
                //arm holes
                rotate([45,0,0]) translate([0,15,36]) cube([5.2,5.2,26], center = true);
                rotate([-45,0,0]) translate([0,-15,36]) cube([5.2,5.2,26], center = true);
                if (Electronics_Area == 1) {
                    //back hole and lock hole
                    hull() {
                        translate([-10,0,20]) cube([30,20,18], center = true);
                        translate([-10,0,48]) cube([30,15.5,2], center = true);
                    }
                    rotate([90,0,0]) translate([-10,33,0]) cylinder(h=100,r=2.5,center = true);
                    rotate([0,90,0]) translate([-39,0,0]) cylinder(h=100, r=2.5, center = true);
                    rotate([0,90,0]) translate([-33,0,0]) cylinder(h=100, r=2.5, center = true);
                    rotate([0,90,0]) translate([-27,0,0]) cylinder(h=100, r=2.5, center = true);
                }
            }
            if (Electronics_Area == 0) {
                //buttons for body
                rotate([0,30,0]) scale([0.5,1,1]) translate([7,0,30]) sphere(r=2.5, center = true);
                scale([0.5,1,1]) translate([38,0,32]) sphere(r=2.5, center = true);
                rotate([0,-30,0]) scale([0.5,1,1]) translate([68,0,26]) sphere(r=2.5, center = true);
            }
            
            //head
            if (Electronics_Area == 1) {
                difference() {
                    translate([0,0,54]) sphere(r=13);
                    //back hole
                    rotate([0,50,0]) translate([-42,0,27]) cube([29,16,13],center = true);
                    //eye holes
                    rotate([0,90,0]) translate([-59,-3.5,0]) cylinder(r=2.5,h=100,center = true);
                    rotate([0,90,0]) translate([-59,3.5,0]) cylinder(r=2.5,h=100,center = true);
                    translate([-6,3.5,54]) cube([14,5,10], center = true);
                    translate([-6,-3.5,54]) cube([14,5,10], center = true);
                }
            } else {
                translate([0,0,54]) sphere(r=13);
                rotate([0,-15,20]) scale([0.5,1,1]) translate([54,0,53]) sphere(r=1.8, center=true);
                rotate([0,-15,-20]) scale([0.5,1,1]) translate([54,0,53]) sphere(r=1.8, center=true);
            }
            //smile
            rotate([0,10,10]) translate([3.1,0,50.5]) scale([0.5,1,1]) sphere(r=1.5);
            rotate([0,10,-10]) translate([3.1,0,50.5]) scale([0.5,1,1]) sphere(r=1.5);
            rotate([0,10,27.5]) translate([3.2,0,51]) scale([0.5,1,1]) sphere(r=1.5);
            rotate([0,10,-27.5]) translate([3.2,0,51]) scale([0.5,1,1]) sphere(r=1.5);
            rotate([0,10,40]) translate([3.3,0,53]) scale([0.5,1,1]) sphere(r=1.5);
            rotate([0,10,-40]) translate([3.3,0,53]) scale([0.5,1,1]) sphere(r=1.5);
            //nose
            rotate([0,90,0]) translate([-54,0,10.5]) cylinder(h=8,r1=2.5,r2=0.1);
            //hat
            translate([0,0,64]) cylinder(h=2,r=10);
            translate([0,0,65]) cylinder(h=2,r=7);
            translate([0,0,66]) cylinder(h=10,r=6);
            difference() {
                rotate([90,0,0]) translate([0,76,0]) cylinder(h=5,r=3.5,center=true);
                rotate([90,0,0]) translate([0,76,0]) cylinder(h=10,r=2,center=true);
            }
        }
        
        
        if (Electronics_Area == 1 && (Model_View == 1 || Model_View == 4)) {
            //back
            translate([-18,22.2,-2.5]){//moves back to a place to be printed
                //bottom
                difference() {
                    intersection() {
                        sphere(r=25);
                        translate([-22,0,40.5]) cube([30,18,100], center = true);
                    }
                    translate([-10,0,7]) cube([40,6,11], center = true);
                }
                //body
                intersection() {
                    difference() {
                        translate([0,0,30]) sphere(r=19);
                        rotate([90,0,0]) translate([-11,33,0]) cylinder(h=100,r=2.5, center = true);
                    }
                    hull() {
                        translate([-22,0,23]) cube([30,18,16], center = true);
                        translate([-22,0,48]) cube([30,15,2], center = true);
                    }
                }
                //head
                intersection() {
                    translate([0,0,54]) sphere(r=13);
                    rotate([0,50,0]) translate([-52,0,25]) cube([29,15.5,13], center = true);
                    translate([-22,0,40]) cube([30,15,100], center = true);
                }
            }
        } else if (Model_View == 0 && Electronics_Area == 1) {
            //back
            translate([0,0,0]){//moves back to a place to be printed
                //bottom
                difference() {
                    intersection() {
                        sphere(r=25);
                        translate([-22,0,40.5]) cube([30,18,100], center = true);
                    }
                    translate([-10,0,7]) cube([40,6,11], center = true);
                }
                //body
                intersection() {
                    difference() {
                        translate([0,0,30]) sphere(r=19);
                        rotate([90,0,0]) translate([-11,33,0]) cylinder(h=100,r=2.5, center = true);
                    }
                    //translate([-20,0,40]) cube([30,15.5,100], center = true);
                    hull() {
                        translate([-22,0,23]) cube([30,18,16], center = true);
                        translate([-22,0,48]) cube([30,15,2], center = true);
                    }
                }
                //head
                intersection() {
                    translate([0,0,54]) sphere(r=13);
                    rotate([0,50,0]) translate([-52,0,25]) cube([29,15.5,13], center = true);
                    translate([-22,0,40]) cube([30,15,100], center = true);
                }
            }
        }
    }


    if (Model_View == 1 || Model_View == 3) {
        //arms
        translate([0,30,2]) cube([20,4,4], center = true);
        translate([0,40,2]) cube([20,4,4], center = true);
        //fingers
        rotate([0,0,45]) translate([21.5,37,2]) cube([3,5,4], center = true);
        rotate([0,0,-45]) translate([-34,20,2]) cube([3,5,4], center = true);
        rotate([0,0,45]) translate([15,30,2]) cube([3,5,4], center = true);
        rotate([0,0,-45]) translate([-27,13,2]) cube([3,5,4], center = true);
        translate([0,27,2]) cube([3,3,4], center = true);
        translate([0,43,2]) cube([3,3,4], center = true);
    } else if (Model_View == 0) {
        translate([-2,-43,34]) {
            rotate([90,45,90]) {
                //arms
                translate([0,30,2]) cube([20,4,4], center = true);
                //fingers
                rotate([0,0,45]) translate([15,30,2]) cube([3,5,4], center = true);
                rotate([0,0,-45]) translate([-27,13,2]) cube([3,5,4], center = true);
                translate([0,27,2]) cube([3,3,4], center = true);
            }
        }
        translate([2,43,34]) {
            rotate([90,45,-90]) {
                //arms
                translate([0,30,2]) cube([20,4,4], center = true);
                //fingers
                rotate([0,0,45]) translate([15,30,2]) cube([3,5,4], center = true);
                rotate([0,0,-45]) translate([-27,13,2]) cube([3,5,4], center = true);
                translate([0,27,2]) cube([3,3,4], center = true);
            }
        }
    }


    if (Electronics_Area == 1 && (Model_View == 1 || Model_View == 5)) {
        //lock for backing
        translate([-30,0,1]) cylinder(h=2,r1=3.5,r2=2, center = true);
        translate([-30,0,16]) cylinder(h=32,r=2, center = true);
    } else if (Model_View == 0 && Electronics_Area == 1) {
        rotate([90,0,0]) translate([-10,45,0]) cylinder(h=32,r=2,center = true);
        rotate([90,0,0]) translate([-10,45,-17]) cylinder(h=2,r1=3.5,r2=2, center = true);
        
    }
}