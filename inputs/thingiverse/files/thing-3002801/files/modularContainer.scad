/* [Settings] */

clearence = 0.2;

corner = false;
wall = false;

length = 1;
width = 1;
height = 20;

/* [Hidden] */

c = clearence;
size = [length, width, height]; //size

left_disabled = corner || wall;
right_disabled = corner;

module connector (h) {
    translate([2.5+c/2, 0, 0]) {
        cube([11-c, 2-c, h]);
        translate([2, 2-c, 0]) {
            cube([7-c, 2+c, h]);
        }
    }
}

module connectors (h, count) {
    for (i = [0:28:(count-1)*28]) {
        translate([i, -3.99999, 0]) {
            connector(h);
        }
    }
}

module insert (h) {
    translate([16.5-c/2, 0, 0]) {
        cube([7+c, 2-c, h]);
        translate([-2, 2-c, 0]) {
            cube([11+c, 2+c, h]);
        }
    }
}

module inserts (h, count) {
    for (i = [0:28:(count-1)*28]) {
        translate([i, -0.00001, 0]) {
            insert(h);
        }
    }
}
union () {
    difference () {
        cube([size[0]*28, size[1]*28, size[2]]);
        for (i = [0:3]) {
            if (i==0 && !left_disabled) {
                inserts(size[2], size[0]);
            } else if (i==1) {
                rotate([0, 0, 90]) {
                    translate([0, -size[0]*28, 0]) {
                        inserts(size[2], size[1]);
                    }
                }
            } else if (i==2) {
               rotate([0, 0, 180]) {
                   translate([-size[0]*28, -size[1]*28, 0]) {
                       inserts(size[2], size[0]);
                   }
               }
            } else if (i==3 && !right_disabled) {
                rotate([0, 0, 270]) {
                    translate([-size[1]*28, 0, 0]) {
                        inserts(size[2], size[1]);
                    }
                }
            }
        }
    }
    for (i = [0:3]) {
        if (i==0 && !left_disabled) {
            connectors(size[2], size[0]);
        } else if (i==1) {
            rotate([0, 0, 90]) {
                translate([0, -size[0]*28, 0]) {
                    connectors(size[2], size[1]);
                }
            }
        } else if (i==2) {
           rotate([0, 0, 180]) {
               translate([-size[0]*28, -size[1]*28, 0]) {
                   connectors(size[2], size[0]);
               }
           }
        } else if (i==3 && !right_disabled) {
            rotate([0, 0, 270]) {
                translate([-size[1]*28, 0, 0]) {
                    connectors(size[2], size[1]);
                }
            }
        }
    }
}