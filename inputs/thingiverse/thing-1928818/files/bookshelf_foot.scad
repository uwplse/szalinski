// Height of the lip
outer_height = 7; // [3:25]
// Leveling adjustment
inner_height = 5;  // [2:20]
// Thickness of the foot
foot_thickness = 3; // [2:10]

difference() {
    union() {
        translate([-48/2,-35/2,0]) cube([48,35,outer_height+inner_height]);
        translate([-58/2,-45/2,0]) cube([58,45,foot_thickness]);
    }

    // foot cutout
    union() {
        translate([-45/2,-32/2,inner_height]) cube([45,32,outer_height + 1]);
        for (i=[-3:2:3]) {
            for (j=[-2:2:2]) {
                scale(0.9) translate([i*6,j*5.5,-10]) cylinder(r=5,h=120);
            }
        }
    }
}