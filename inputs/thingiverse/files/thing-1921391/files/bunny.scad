$fa = .4;
$fs = .04;

EYE_RADIUS = .1;
EAR_HEIGHT = 3;
FATNESS = 1;

module symY(dy) {
    for(dir = [-1, 1]) {
        translate([0, dir * dy, 0])
        children();
    }
}

module bunny() {
    // main body
    module body() {
        hull() {
            // main body
            rotate([0, -20, 0])
            scale([1.4, 1, 1])
            sphere(r = FATNESS);
    
            // neck
            translate([1.2, 0, -.22])
            rotate([0, -20, 0])
            scale([1.4, 1, 1])
            sphere(r = .8);
        }

        // tail
        translate([-1.2, 0, -.1])
        rotate([0, 20, 0])
        sphere(r = .3);
    }

    module head() {
        // skull
        rotate([0, 15, 0])
        difference() {
            hull() {
                sphere(r = .6);

                translate([.5, 0, 0])
                sphere(r = .3);
            }

            // eyes
            symY(.55) {
                translate([.2, 0, .2])
                sphere(r = EYE_RADIUS);
            }
        }
    }
    
    module ears(height) {
        rotate([0, -10, 0])
        translate([-.1, 0, 0])
        for (dir = [-1, 1]) {
            rotate([-10 * dir, 0, 0])
            scale([1, 1, height])
            translate([-.1, .2 * dir, .3])
            difference() {
                sphere(r = .4);

                union() {
                    translate([0, .3 * dir, 0])
                    sphere(r = .45);

                    translate([0, .5 * dir, 0])
                    cube([1, 1, 1], center=true);
                }
            }
        }
    }

    module backFeet() {
        module foot() {
            rotate([0, -30, 0])
            scale([2, 1, 1.5])
            sphere(r = .5);

            scale([2.5, 1, 1])
            translate([.1, 0, -.82])
            sphere(r = .3);
        }

        symY(.5) {
            translate([0, 0, -.5])
            foot();
        }
    }

    module frontFeet() {
        module foot() {
            *rotate([0, 70, 0])
            scale([2, 1, 1])
            sphere(r = .3);

            translate([.3, 0, -.53])
            scale([2, 1, 1])
            sphere(r = .2);
        }

        symY(.3) {
            translate([1.3, 0, -.74])
            foot();
        }
    }

    difference() {
        union() {
            body();

            translate([1.8, 0, .9])
            scale([1.2, 1.2, 1.2]) {
                head();
                ears(EAR_HEIGHT);
            }

            translate([0, 0, .4]) {
                backFeet();
                frontFeet();
            }
        }

        translate([0, 0, -3.5])
        cube([10,10,5], center=true);
    }
}

scale([10, 10, 10])
bunny();
