/* [Cup holder] */

// Holder height
cupHeight = 60;  // [25:70]
// Lower diameter
cupLowerDiameter = 72; // [60:0.5:80]
// Upper diameter
cupUpperDiameter = 77; // [60:0.5:80]

/* [USB slot] */

// USB connector rest
usbSlot = 1;  // [1:Present, 0:Absent]
// Hole width
usbWidth = 12.25; // [8:0.25:20]
// Hole depth
usbDepth = 6.5; // [5:0.25:9]
// Hole height
usbHeight = 25; // [10:50]

module slot() {
    rotate([-10, 0, 0]) translate([-41, -7.5, 0]) cube([82, 15, 155]);
}

module cup() {
    cylinder(cupHeight, cupLowerDiameter/2, cupUpperDiameter/2, $fn=300);
}

module test() {
    difference() {
        cup();
        translate([0, 0, 2]) scale([0.95, 0.95, 1]) cup();
    }
}

module holder() {
    union() {
        difference() {
            cup();
            scale([1.1, 1, 1]) translate([0, 0, 6]) slot();
            hull() {
                rotate([-17.5, 0, 0]) translate([-50, -37.5, -0.75]) cube([100, 15, 75]);
                translate([-50, -60, 6]) cube([100, 15, 75]);
            }
            hull() {
                translate([-50, 22.5, 6]) cube([100, 15, 75]);
                translate([-50, 60, 6]) cube([100, 15, 75]);
            }
        }
        if (usbSlot) {
            rotate([-17.5, 0, 0]) difference() {
                translate([-((usbWidth/2)+2), -(26+usbDepth), -4-(usbDepth/12)]) cube([usbWidth+4, usbDepth+4, usbHeight]);
                translate([-(usbWidth/2), -(24+usbDepth), -4-(usbDepth/12)]) cube([usbWidth, usbDepth, usbHeight+1]);
            }
        }
    }
}

//test();
holder();