$fn=20;     // =20 for preview, =200 for rendering/printing
id=57.5;    // Inner Diameter (at least 56.75)
ed=67.8;    // Exterior Diameter (>= id)


//cylinder(h = 30, d =70, center = true);
//translate([0, 0, -10.8]) color([1,0,0]) cylinder(h = 23.1, d = 4.5, center = true); // fill the hole!!
shift=(id-28.3)/2;
difference() {
    group() {
        difference() {
            cylinder(h = 1.5, d = ed, center = true);
            rotate (0) translate([14.875, 0,0]) cylinder(h = 1.5, d = 25, center = true);
            rotate (120) translate([14.875, 0, 0]) cylinder(h = 1.5, d = 25, center = true);
            rotate (240) translate([14.875, 0, 0]) cylinder(h = 1.5, d = 25, center = true);
        }

    rotate(0) translate([shift, 0, -10.8]) {
    difference() {
        color([1,0,0]) cylinder(h = 21.6, d = 28, center = true);
        translate([0, 0, 0]) {
            color([0,1,0]) cylinder(h = 21.6, d = 25, center = true);
        }
        translate([0, 0, 1.5]) {
            color([0,0,1]) cylinder(h = 40, d = 15, center = true);
        }
    }
    color([1,1,1]) translate([0, 0, -13.8]) {
        difference() {
            cylinder(h=6, r1=7.5, r2=14, center=true);
            cylinder(h=6, r1=6, r2=12.5, center=true);
        }
    }
    }

    rotate(120) translate([shift, 0, -10.8]) {
    difference() {
        color([1,0,0]) cylinder(h = 21.6, d = 28, center = true);
        translate([0, 0, 0]) {
            color([0,1,0]) cylinder(h = 21.6, d = 25, center = true);
        }
        translate([0, 0, 1.5]) {
            color([0,0,1]) cylinder(h = 40, d = 15, center = true);
        }
    }
    color([1,1,1]) translate([0, 0, -13.8]) {
        difference() {
            cylinder(h=6, r1=7.5, r2=14, center=true);
            cylinder(h=6, r1=6, r2=12.5, center=true);
        }
    }
    }

    rotate(240) translate([shift, 0, -10.8]) {
    difference() {
        color([1,0,0]) cylinder(h = 21.6, d = 28, center = true);
        translate([0, 0, 0]) {
            color([0,1,0]) cylinder(h = 21.6, d = 25, center = true);
        }
        translate([0, 0, 1.5]) {
            color([0,0,1]) cylinder(h = 40, d = 15, center = true);
        }
    }
    color([1,1,1]) translate([0, 0, -13.8]) {
        difference() {
            cylinder(h=6, r1=7.5, r2=14, center=true);
            cylinder(h=6, r1=6, r2=12.5, center=true);
        }
    }
    }
    }
    rotate (0)   translate([shift+0.275, 0, -10.8])  cylinder(h = 21.6, d = 25, center = true);
    rotate (120) translate([shift+0.275, 0, -10.8]) cylinder(h = 21.6, d = 25, center = true);
    rotate (240) translate([shift+0.275, 0, -10.8]) cylinder(h = 21.6, d = 25, center = true);
}