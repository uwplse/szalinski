 
bottomThick = 4.5;
height=135;
thick=5;
holeDiameter=10;

module bottomplate(bottomThick) {
    translate([54,0,0]) {
        rotate([90,0,180]) {
            difference() {
                cube([54,50,bottomThick]);
                translate([5,3,-1]) {
                    cylinder(r=4/2, h=bottomThick+2, $fn=50);
                }
                translate([27.5,3,-1]) {
                    cylinder(r=4/2, h=bottomThick+2, $fn=50);
                }
                translate([50,3,-1]) {
                    cylinder(r=4/2, h=bottomThick+2, $fn=50);
                }
                translate([27.5,47.5,-1]) {
                    cylinder(r=4/2, h=bottomThick+2, $fn=50);
                }
                translate([50,47.5,-1]) {
                    cylinder(r=4/2, h=bottomThick+2, $fn=50);
                }
            }
        }
    }
}

rotate([0,0,45]) {
    difference() {
        bottomplate(bottomThick=bottomThick);
        translate([31,-1,-1]) {
            cube([56,bottomThick+2,52]);
        }
    }
    translate([12.9-(thick-5)/2,0,0]) {
        difference() {
            cube([thick, height+bottomThick,50]);
            translate([-1,height+bottomThick-5,50/2]) {
                rotate([0,90,0]) {
                    cylinder(r=(holeDiameter/2), h=thick+2, $fn=50);
                }
            }
            translate([-1,height+bottomThick-5,50/2-holeDiameter/2]) {
                cube([thick+2, holeDiameter, holeDiameter]);
            }
        }
    }
}
