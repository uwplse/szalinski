// This work is licensed under the Creative Commons Attribution-ShareAlike 4.0
// International License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/4.0/

$fn = 64;

width = 55;
height = 42;
heightRadius = 60;
bracketThickness = 20;
powerStripOpeningWidth = 30;
clipOpeningWidth = 31;


module powerStripCrossSection(thickness) {
	intersection() {
		translate([width / 2 - heightRadius, 0, 0])
			cylinder(r=heightRadius, h=thickness, center=true);
		translate([heightRadius - width / 2, 0, 0])
			cylinder(r=heightRadius, h=thickness, center=true);
		cube([width, height, thickness], center=true);
	}
}

difference() {
    totalWidth = width + clipOpeningWidth+3;
	cube([62, totalWidth, bracketThickness]);	
    translate([31 - powerStripOpeningWidth/2, totalWidth-6, -1])
		cube([powerStripOpeningWidth, 7, bracketThickness+2]);
	translate([-1, 5, -1])
		cube([56, clipOpeningWidth, bracketThickness + 2]);
    translate([31, totalWidth-5-height/2, bracketThickness/2])
        powerStripCrossSection(bracketThickness+2);
}
