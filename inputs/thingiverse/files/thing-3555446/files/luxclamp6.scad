// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 4;    // Don't generate larger angles than 4 degrees

// Parameters
bracketWidth = 110;
barAngleZ = 13.3;
mountHeight = 25;
bracketRadius = 15;
clampWidthI = 10.6;
clampWidthO = 24;

// resulting Variables
bwH = bracketWidth / 2;
bR = bracketRadius;
bR2 = bracketRadius * 2;

// Main geometry
rotate([180,90,0])
    difference() {
    union() {
        translate([mountHeight+1, 5.5, 0])
        lower();
        translate([0,0, -(bwH-0.5)])
        rotate([90,0,0])
        mount();

        mirror([0,1,0]) 
        translate([0,0, (bwH-0.5)])
        rotate([-90,0,0])
        mount();
    }
    union() {
        translate([0,0, -(bwH-0.5)])
        rotate([90,0,0])
        syntace();
        mirror([0,1,0]) 
        translate([0,0, (bwH-0.5)])
        rotate([-90,0,0])
        syntace();
  }
}

module lower() {
    difference() {
        union() {
            translate([1, 2.5, 0]) rotate([0,0,-30]) clamp();
            translate([12, -5.26, 0]) bar();
            mirror([0,0,1]) translate([12, -5.26, 0]) bar();
        }
        translate([24, -8, 0]) color("Red") cube([20,40,120], center=true);
        rotate([0,90,0])
        translate([0, -5.5, 13.2])
        linear_extrude(height = 2) text("LuxClamp v0.6", size=5, halign ="center", valign="center");
   }
}

module clamp() {
    difference() {
        union() {
            color("Blue") cylinder(h=clampWidthO, r=8, center=true);
            translate([5, 0, 0]) color("Blue") cylinder(h=clampWidthO, r=8, center=true);
            translate([2.5, 4, 0]) color("Blue") cube([5,8,clampWidthO], center=true);
            translate([8, -4, 0]) color("Blue") cube([16,8,clampWidthO], center=true);          
        }
        color("Red") cylinder(h=clampWidthI, r=8.5, center=true);
        color("Red") cube([14,18,clampWidthI], center=true);
        color("Lime") cylinder(h=30, r=2.9, center=true);
        translate([0, 0, 11.8]) color("Lime") cylinder(h=8, r=6, center=true);
        translate([0, 0, -11.8]) color("Lime") cylinder(h=8, r=6, $fn=6, center=true);
    }
}

module bar() {
    color("Fuchsia") 
    union() {
        linear_extrude(height = bwH - bR + 0.5) {
            resize([6,18])circle(d=18);
        }
        
        translate([-bR, 0, bwH+0.5]) 
        rotate([0,-90,0])
        linear_extrude(height = mountHeight-bR+8, twist = -barAngleZ*1.28) {
            resize([6,18])circle(d=18);
        }
        
       
        color("Fuchsia")
        intersection() {
            translate([-bR, 0, bwH - bR + 0.5])
            rotate([90,0,0])
            rotate_extrude(convexity = 10)
            translate([bracketRadius, 0, 0])
            resize([6,18]) circle(d=18);
            
            translate([-bR, -10, bwH - bR + 0.5]) cube([bR2, 20, bR2]);
        }
    }
}

module mount() {
    rotate([barAngleZ,0,0]) {
        color("Gold")
        intersection() {
            translate([0, -13, 0]) 
            union() {
                rotate_extrude(convexity = 10)
                translate([15, 0, 0])
                resize([6,18]) circle(d=18);

                cylinder(h=18, r=15, center=true);
            }
            union() {
                translate([5, 5, 0]) cube([10,20,18], center=true);
                rotate([90,0,0]) translate([0, 0, 0]) cylinder(h=20, d=18, center=true);
           }
        }
    }
}

module syntace() {
    rotate([barAngleZ,0,0]) {
    color("Lime") 
    translate([0, -13, 0])
    cylinder(h=100, r=11.9, center=true);
    color("Lime") 
    rotate([90,0,0]) translate([0, 0, 1.5]) {
        cylinder(h=3, d=10, center=true);
        cylinder(h=20, d=5, center=true);
        translate([0, 0, -9]) 
        cylinder(h=10, r=5, center=true);
    }
}
}