$fn=50;

// front

union() {
     translate([10, 0, 5]) {
          cube([7, 2, 5]);
     }
     translate([0, 0, 0]) {
          cube([8, 2, 5]);
     }
     translate([5, 0, 0]) {
          cube([7, 2, 10]);
     }
     translate([5, 2, 5]) {
          rotate(a=90,  v=[1, 0, 0]) {
               cylinder(h=2, r=5);
          }
     }
     translate([12, 2, 5]) {
          rotate(a=90,  v=[1, 0, 0]) {
               cylinder(h=2, r=5);
          }
     }
}

// cable hook

union() {
     translate([1.5, 8, 1.5]) {
          rotate(a=90,  v=[1, 0, 0]) {
               cylinder(h=8, r=1.5);
          }
     }
     translate([0, 2, 0]) {
          cube([3, 7, 1.5]);
     }
}

// back

union() {
     translate([10, 8, 5]) {
          cube([7, 2, 5]);
     }
     translate([0, 8, 0]) {
          cube([8, 2, 5]);
     }
     translate([5, 8, 0]) {
          cube([7, 2, 10]);
     }
     translate([5, 10, 5]) {
          rotate(a=90,  v=[1, 0, 0]) {
               cylinder(h=2, r=5);
          }
     }
     translate([12, 10, 5]) {
          rotate(a=90,  v=[1, 0, 0]) {
               cylinder(h=2, r=5);
          }
     }
}

// shelf hook

translate([7, -4, 0]) {
     cube([10,3,10]);
}

union() {
     translate([9, -1, 8]) {
          cube([2, 1, 2]);
     }
     translate([7, -1, 8]) {
          cube([2, 1, 2]);
     }
     translate([7, -1, 6]) {
          cube([2, 1, 2]);
     }
     translate([9, -0, 8]) {
          rotate(a=90,  v=[1, 0, 0]) {
               cylinder(h=1, r=2);
          }
     }
}

// handle

translate([-4,  10,  -1]) {
     minkowski() {
          translate([6,  -11,  1]) {
               cube([2, 8, 8]);
          }
          translate([6,  -11,  1]) {
               sphere(1);
          }
     }
}

// lock

difference() {

     union() {
          difference() {
               translate([0, 3, 0]) {
                    cube([2, 4, 10]);
               }
               rotate(a=25,  v=[0, 1, 0]) {
                    translate([-5, 3, 6]) {
                         cube([2, 4, 4]);
                    }
               }
          }
          rotate(a=25,  v=[0, 1, 0]) {
               translate([-3, 3, 4]) {
                    cube([2, 4, 2.5]);
               }
          }
     }

     translate([-1, 2.5, 7]) {
          cube([5, 5, 5]);
     }

}
