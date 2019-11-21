/* [PULLEY] */

NUMBER_OF_WHEELS = 2; //[1:1:4]

/* [EXPORT] */

part = "all"; // [wheel:Only one wheel,spindle:Wheel spindle only,case:Case only,all:Complete model]

/* [Hidden] */
$fn = 100;
print_part();

module print_part() {
	if (part == "wheel") {
		wheel();
	} else if (part == "spindle") {
		spindle();
	} else if (part == "case") {
		rotate([0, -90, 0]){
            for (I =[1:NUMBER_OF_WHEELS]){
                translate([0,0,24 * (I - 1)]){
                    case();
                };
            };
        };
    } else {
        rotate([0, -90, 0]){
            for (I =[1:NUMBER_OF_WHEELS]){
                translate([0,0,24 * (I - 1)]){
                    case();
                    wheel();
                    spindle();
                };
            }
        };
	}
}

module wheel() {
    translate([0, 0, -5]){
        difference()  {
            difference()  {
                union () {
                    difference()  {
                        cylinder(h=10, r=20, center=false);
                        rotate_extrude(convexity = 20, $fn = 100){
                            translate([22, 5, 0]){
                                circle(r = 4.5, $fn = 100);
                            }
                        };
                    };
                    translate([0, 0, 10]){
                        cylinder(h=4, r=7, center=false);
                    };
                };
                union()  {
                    translate([0, 0, -4]){
                        cylinder(h=9, r=7, center=false);
                    }
                    translate([0, 0, 5]){
                        cylinder(h=9, r=5, center=false);
                    }
                }
            }
            translate([0, 0, 5]){
                cylinder(h=3, r1=7, r2=5, center=false);
            };
        };
    }
}

module spindle() {
    translate([0, 0, -5]){
        difference()  {
            union()  {
                translate([0, 0, -4]){
                    cylinder(h=9, r=7, center=false);
                }
                translate([0, 0, 5]){
                    cylinder(h=9, r=5, center=false);
                }
            };
            translate([0, 0, -4]){
                cylinder(h=18, r=2.05, center=false);
            };
        }
    }
}

module case(){
    difference(){
        difference(){
            difference(){
                difference(){
                    cylinder(h=30, r=32, center=true);
                    union(){
                        translate([30, 0, 0]){
                            cube([32,80,34],center=true);
                        };
                        translate([-30, 0, 0]){
                            cube([32,80,34],center=true);
                        };
                    };
                };
                union(){
                    cube([50,50,14],center=true);
                    cylinder(h=14, r=25, center=true);
                };
            };
            union(){
                cylinder(h=30, r=2, center=true); //osa
                cylinder(h=18.2, r=7.1, center=true);
                translate([0,2,0]){
                    cube([14.2,5,18.2],center=true);
                };
                translate([0,4,0]){
                cylinder(h=18.2, r=7.1, center=true);
                    translate([20,0,0]){
                        cube([40,14.2,18.2],center=true);
                    };
                };
            };
        };

        union(){
            translate([-2, 0, -5]){
                rotate([90, 0, 0]){
                    cylinder(h=100, r=2, center=true);
                };
            };
            translate([2, 0, -5]){
                rotate([90, 0, 0]){
                    cylinder(h=100, r=2, center=true);
                };
            };
            translate([0, 0, -5]){
                cube([4,100,4],center=true);
            };
            translate([-2, 0, 5]){
                rotate([90, 0, 0]){
                    cylinder(h=100, r=2, center=true);
                };
            };
            translate([2, 0, 5]){
                rotate([90, 0, 0]){
                    cylinder(h=100, r=2, center=true);
                };
            };
            translate([0, 0, 5]){
                cube([4,100,4],center=true);
            };
            translate([0, -25, 0]){
                cylinder(h=10, r=2, center=true);
            };
            translate([0, 25, 0]){
                cylinder(h=10, r=2, center=true);
            };
        };
    };
}