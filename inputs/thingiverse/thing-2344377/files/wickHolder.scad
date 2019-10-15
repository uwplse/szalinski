outdiameter = 75;
thickness = 3;
rimthickness = 6;

wickDiam = 2;
middleWidth = 8;
wickOpenningLength = 4;

$fn=50;


difference() {
    union() {
        difference() {
            cylinder(d=outdiameter + thickness,h=rimthickness);

            translate([0, 0, thickness]) cylinder(d=outdiameter,h=(rimthickness - thickness));

            cylinder(d=outdiameter - rimthickness,h=thickness);
        }

        difference() {
            translate([-middleWidth /2, -(outdiameter - rimthickness) / 2, 0]) cube([middleWidth, outdiameter - rimthickness, thickness]);

            cylinder(d=wickDiam,h=thickness);

            translate([-wickDiam / 2, 0, 0]) {
                cube([wickDiam, wickOpenningLength, thickness]);
            }
            
            translate([0, wickOpenningLength, 0]) cylinder(d=wickDiam +2,h=thickness);
        }
    }

    translate([outdiameter / 6, -(outdiameter + rimthickness) / 2, 0])  cube([outdiameter + rimthickness, outdiameter + rimthickness, rimthickness]);
    translate([-(outdiameter / 6 + outdiameter + rimthickness), -(outdiameter + rimthickness) / 2, 0])  cube([outdiameter + rimthickness, outdiameter + rimthickness, rimthickness]);
}

