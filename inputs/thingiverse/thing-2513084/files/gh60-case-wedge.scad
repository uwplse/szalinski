width = 256;
keyboardAngle = 10;

union() {
    translate([-(width / 2) - 10,70,0]) {
        intersection() {
            translate([10,0,0]) {
                rotate([0,90,0]) {
                    difference() {
                        cylinder(width, r=120, $fn=50);
                        translate([0,0,-10])
                            cylinder(280,r=55, $fn=50);
                    }
                }
            }
            
            rotate([0,0,270]) {
                cube(320, 0);
            }
            rotate([0,90 - keyboardAngle,270]) {
                cube(340,0);
            }

            translate([-20,-(90 - keyboardAngle),0]) {
                for (i = [0:640]) {
                    translate([30+(0.5 * i),(8*sin(13.5*(0.5 *i)/2.8)),0])
                    rotate([0,-10,0])scale([1,20,40])
                        cube(0.5, r=1);
                }
            }
        }
    }

    for (i = [-125, 125]) {
        translate([i,0,14.5]) {
            rotate([0,(180-keyboardAngle),270])
                cylinder(4,r=1.35, $fn=32);
        }
    }
};