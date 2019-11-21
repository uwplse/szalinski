// in mm
divider_length = 3;
divider_width = 2;
count = 16;
wall = 2;
base = 2;
lid = 3;

/******************************** end configurable constants ********************************/
lid_clearance = 0.2;
clearance = 0.6;

// 3DS cart dimensions
thick = 3.8 + clearance;
height = 35 + clearance;
top = 35 + clearance;
tab_height = 6.5 + clearance;
width = 33 + clearance;

compartment_origin = [wall, wall, base];
compartment = [count * thick + (count + 1) * divider_width,
               top,
               height];

lid_shell = [wall + compartment[0],
             2 * wall + top,
             lid];

module cart() {
    cube ([width - clearance, height - clearance, thick - clearance]);
    translate ([width - clearance, height - tab_height, 0])
        cube ([top - width - clearance, tab_height - clearance, thick - clearance]);
}

module shell() {
    difference() {
        cube (compartment + [2 * wall, 2 * wall, base]);
        translate(compartment_origin) {
            cube (compartment);
        }
    }
}

module divider() {
    difference() {
        cube([divider_width, top, height - tab_height]);
        translate([0, divider_length, 0])
            cube([divider_width, width - 2 * divider_length, height - tab_height]);
    }
}

module slot() {
    difference() {
        cube([thick, top, height - tab_height]);
        cube([thick, width, height - tab_height]);
    }
}
module dividers() {
    translate(compartment_origin) {
        for (off = [0 : count]) {
            translate([off * (thick + divider_width), 0, 0]) {
                divider();
                if (count != off) { // draw one more divider than slots
                    translate ([divider_width, 0, 0]) slot();
                }
            }
        }
    }
}

module slide() {
    translate([0, 0, base + height]) {
        difference() {
            cube (lid_shell);
            translate ([0, wall / 2, 0]) lid();
        }
    }
    // Back edge
    translate([lid_shell[0], 0, base + height])
        cube([wall, lid_shell[1], lid]);
}

module lid(clearance = 0) {
    rotate([0,90,0])
    linear_extrude(height = lid_shell[0])
    polygon(points = 
        [[0, 0],
         [0, compartment[1] + wall - clearance],
         [-lid, compartment[1] + wall / 2 - clearance],
         [-lid, wall / 2 ]]);
}

//translate([0, 50, 0]) cart();
shell();
dividers();


translate ([compartment[0] + 25, 0, 0])
lid(lid_clearance);

slide();




