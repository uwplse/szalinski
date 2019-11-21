
objectHeight = 40;
objectH = 29;
objectBaseR = 20;
holeR = 8.75;
thick = 3;
roundR = 2;

r1 = sqrt(objectH*objectH + objectBaseR * objectBaseR);
scale1 = (r1-thick*2)/r1;

module obj1(r) {
    difference() {
        translate([0,0,objectH]) {
            difference() {
                sphere(r=r, $fn=200);
                translate([-r-1, -r-1, 0]) {
                    cube([r*2+2, r*2+2, r+1]);
                }
            }
        }
        translate([-r-1, -r-1, -r-1]) {
            cube([r*2+2, r*2+2, r+1]);
        }
    }
}

module donut(r1,r2) {
    rotate_extrude(convexity=10, $fn=100) {
        translate([r1,0,0]) {
            circle(r=r2, $fn=100);
        }
    }
}
difference() {
    union() {
        difference() {
            hull() {
                obj1(r1);
                translate([0,0,objectHeight-roundR]) {
                    donut(r1-roundR,roundR);
                }
            }
                
            translate([0,0,(1.0-scale1)*objectH/2]) {
                scale([scale1,scale1,scale1]) {
                    hull() {
                        obj1(r1);
                        translate([0,0,objectHeight-roundR]) {
                            donut(r1-roundR,roundR);
                        }
                    }
                }
            }
        }
        for (i = [0:90:359]) {
            translate([(holeR+1)*sin(i),(holeR+1)*cos(i),0]) {
                cylinder(r1=1, h=objectHeight, $fn=20);
            }
        }
        for (i = [45:90:359]) {
            translate([((holeR+objectBaseR)/2+1)*sin(i),((holeR+objectBaseR)/2+1)*cos(i),0]) {
                cylinder(r1=1, h=objectHeight, $fn=20);
            }
        }
    }
    translate([0,0,objectH/2]) {
        cylinder(r=holeR, h=50, $fn=100);
    }
}

