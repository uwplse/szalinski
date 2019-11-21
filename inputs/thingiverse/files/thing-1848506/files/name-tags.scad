name = "Valerie";

nameTag(name);

module nameTag(modText) {
    translate([0, 0, 2.5]) 
        difference() {
            cube([75, 25, 5], center = true);
            translate([32.5, 7.5, 0]) 
                resize(newsize=[65, 15, 10]) 
                    rotate([0,0,180]) 
                        linear_extrude(height = 5) 
                            text(modText, 10, "URW Gothic L");
        }

    translate([-2.5, 12.5, 13]) rotate([0, 90, 0]) difference() {
        cylinder(r = 13, h = 5);
        translate([0,0,-.5]) cylinder(r = 8, h = 6);
        translate([-15, -20, -0.5]) cube([30, 20, 6]);
    }
}