$fn=100;

// Top or bottom?
top_or_bottom = 1;  // [1:Top, 2:Bottom]

module original() {
    assert(top_or_bottom == 1 || top_or_bottom == 2);  // Requires OpenSCAD >2017.1 experimental build
    if (top_or_bottom == 1) {
        translate([0, -1.5, -62.935]) import("PEX96_-_Top_V0.3.stl", convexity=5);
    } else if (top_or_bottom == 2) {
        translate([0, -1.5, -62.935]) import("PEX96_-_Bottom_V0.5.stl", convexity=5);
    }
}

module motor_hole() {
    hull() {
        translate([-1.1, 0.6, 0]) cylinder(d=2.25, h=5);
        translate([-0.75, 0.25, 0]) cylinder(d=2.25, h=5);
    }
}

module motor_holes() {
    translate([-28.75, 34.25, -1]) rotate([0, 0, 45]) motor_hole();
    translate([-33.5, 37.15, -1]) rotate([0, 0, -45]) motor_hole();
    translate([-37.25, 34.25, -1]) rotate([0, 0, 45]) motor_hole();
    translate([-33.5, 28.75, -1]) rotate([0, 0, -45]) motor_hole();
}

module motor_fill() {
    hull() {
        translate([-1.125, 0.6, 0]) cylinder(d=2.25, h=3);
        translate([-0.75, 0.25, 0]) cylinder(d=2.25, h=3);
    }
}

module motor_fillers() {
    translate([-29.9, 30.45, 0]) scale([1.1, 1.1, 1]) motor_fill();
    translate([-30.5, 38, 0]) rotate([0, 0, 90]) scale([1.1, 1.1, 1]) motor_fill();
    translate([-35.95, 36.5, 0]) scale([1.1, 1.1, 1]) motor_fill();
    translate([-36.5, 32, 0]) rotate([0, 0, 90]) scale([1.1, 1.1, 1]) motor_fill();
}

module prop_inner() {
    translate([33.95, 33.95, -1]) cylinder(d=55, h=5);
}

module prop_outer() {
    translate([33.95, 33.95, 0]) cylinder(d=61, h=3);
}

module prop_rim() {
    difference() {
        prop_outer();
        prop_inner();
    }
}

module ribs_cleaner_frontback() {
    translate([0, 0, -0.5]) scale([1, 1, 1.5]) difference() {
        translate([14.5, -10.5, 0]) cube([35.5, 21, 3]);
        prop_rim();
        rotate([0, 0, -90]) prop_rim();
    }
}

module ribs_cleaner_leftright() {
    translate([0, 0, -0.5]) scale([1, 1, 1.5]) difference() {
        if (top_or_bottom == 2) {
            translate([-4.5, 28, 0]) cube([12, 15, 3]);
        } else {
            translate([-6, 25, 0]) cube([12, 15, 3]);
        }
        prop_rim();
        rotate([0, 0, 90]) prop_rim();
    }
}

module ribs_cleaner_arms() {
    rotate([0, 0, 45]) translate([23, -3.375, -0.5]) cube([12.5, 6.75, 4]);
}

difference() {
    if (top_or_bottom == 2) {
        // Main body (bottom)
        union() {
            original();
            // Fill old motor holes (Plus-style)
            {
                motor_fillers();
                rotate([0, 0, -90]) motor_fillers();
                rotate([0, 0, 90]) motor_fillers();
                rotate([0, 0, 180]) motor_fillers();
            }
        }
    } else {
        // Main body (top)
        original();
    }
    
    // Bottom-only changes
    if (top_or_bottom == 2) {
        // Create new motor holes (X-style)
        {
            motor_holes();
            rotate([0, 0, -90]) motor_holes();
            rotate([0, 0, 90]) motor_holes();
            rotate([0, 0, 180]) motor_holes();
        }
        // Shorten arms' ribs
        {
            ribs_cleaner_arms();
            mirror([1, 0, 0]) ribs_cleaner_arms();
            mirror([1, 1, 0]) ribs_cleaner_arms();
            mirror([0, 1, 0]) ribs_cleaner_arms();
        }
        // Create additional holes in main plate
        {
            translate([0, -16, -1]) hull() {
                translate([-6, 0, 0]) cylinder(d=3, h=5);
                translate([6, 0, 0]) cylinder(d=3, h=5);
            }
            translate([0, 16, -1]) hull() {
                translate([-6, 0, 0]) cylinder(d=3, h=5);
                translate([6, 0, 0]) cylinder(d=3, h=5);
            }
        }
    }
    
    // Remove ribs from front/back/right/left sides
    {
        ribs_cleaner_frontback();
        mirror([1, 0, 0]) ribs_cleaner_frontback();
        ribs_cleaner_leftright();
        mirror([0, 1, 0]) ribs_cleaner_leftright();
    }
    
    // Create hole in center pad
    if (top_or_bottom == 1) {
        // If top piece, drill all the way down
        translate([0, 0, -0.5]) cylinder(d=15.2, h=4);
    } else {
        // If bottom piece, leave some material on the underside
        translate([0, 0, 1]) cylinder(d=15, h=2.5);
    }
}