/*
Deltaprintr Spool Holder OpenSCAD Model
Copyright (C) 2015 Marcio Teixeira

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/* [Global] */

// Select what part to print.
part = "all"; // [part1, part2, part3, all]

/* [Spool size] */
spool_hole_diameter_mm    = 38;
spool_height_mm           = 80;
// Desired gap between spool holder and spool hole
spool_clearance_mm        = 2;

/* [Print Parameters] */
// Gap between tight fitting parts
fit_tolerance_mm          = 0.1;

/* [Deltaprintr Measurments] */
// Inner diameter of plus-shaped cutout
mount_inner_diameter_mm   = 14;
// Outer diameter of plus-shaped cutout
mount_outer_diameter_mm   = 24;
// Thickness of laser-cut wood used in the deltaprintr
wood_thickness_mm         = 6.5;

/* [Cosmetic] */
base_overhang_mm          = 30;
lower_notch_depth_mm      = 55;
lip_mm                    = 5;

/* [hidden] */
part_separation           = 10;

/* You should not need to edit anything past this point */
spindle_width_mm          = spool_hole_diameter_mm - spool_clearance_mm*2;
total_spindle_height      = spindle_width_mm/2 + spool_height_mm + lip_mm + wood_thickness_mm + fit_tolerance_mm + lip_mm;
upper_notch_depth_mm      = total_spindle_height - lower_notch_depth_mm;
base_diameter_mm          = spindle_width_mm + base_overhang_mm;


module spindle() {
	square(size = [spindle_width_mm, spool_height_mm], center = true);
	translate([0, spool_height_mm/2, 0])
		circle(d = spindle_width_mm);
	translate([0, -spool_height_mm/2 - lip_mm/2, 0])
		square(size = [spindle_width_mm + lip_mm*2, lip_mm], center = true);
	translate([0, -spool_height_mm/2 - lip_mm - wood_thickness_mm/2 - fit_tolerance_mm, 0])
		square(size = [mount_inner_diameter_mm - fit_tolerance_mm*2, wood_thickness_mm + fit_tolerance_mm*2], center = true);
	translate([0, -spool_height_mm/2 - lip_mm - wood_thickness_mm - lip_mm/2 - fit_tolerance_mm*2, 0])
		square(size = [mount_outer_diameter_mm, lip_mm], center = true);
}

module part1() {
    linear_extrude(height = wood_thickness_mm)
    difference() {
        spindle();
        translate([0, -spool_height_mm/2 - lip_mm - wood_thickness_mm - lip_mm - fit_tolerance_mm*2 + lower_notch_depth_mm/2, 0])
            square(size = [wood_thickness_mm + fit_tolerance_mm*2, lower_notch_depth_mm], center = true);
    }
}


module part2() {
    linear_extrude(height = wood_thickness_mm)
    difference() {
        spindle();
        translate([0, spool_height_mm/2 + spindle_width_mm/2 - upper_notch_depth_mm/2, 0])
            square(size = [wood_thickness_mm + fit_tolerance_mm*2, upper_notch_depth_mm], center=true);
    }
}

module part3() {
	linear_extrude(height = wood_thickness_mm)
	difference() {
		circle(d = base_diameter_mm);
		square(size = [spindle_width_mm + fit_tolerance_mm*2, wood_thickness_mm + fit_tolerance_mm*2], center=true);
		square(size = [wood_thickness_mm + fit_tolerance_mm*2, spindle_width_mm + fit_tolerance_mm*2], center=true);
	}
}

if( part == "part1" ) {
    part1();
}
else if( part == "part2" ) {
    part2();
}
else if( part == "part3" ) {
    part3();
}
else if( part == "all" ) {
    part1();
    translate( [-spindle_width_mm - lip_mm*2 - part_separation, 0, 0])
        part2();
	translate( [spindle_width_mm/2 + lip_mm + part_separation + base_diameter_mm/2, 0, 0])
        part3();
}