echo(version=version());

// Nerf quickload for 6 shot magazine.

difference() {
    color("red")
    translate([0, 7.5, 0])
        linear_extrude(height = 86)
            square([76, 15], center = true);
	translate([0, 7.5, 2])
        linear_extrude(height = 86)
            square([74, 12.7], center = true);
    translate([0, 0, 2])
        linear_extrude(height = 86)
            square([49, 3], center = true);
    translate([0, 0, 0])
        rotate ([0,0,90]) cylinder (h = 5, r=13.7, center = true, $fn=100);

}            