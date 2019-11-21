// Prusa MK2.5/MK3 Filament Cover to Filament Tube Coupler
// v1.2, 20/6/2018 - Render/print upside down
// v1.1, 18/6/2018 - Added customiser
// by inks007
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (CC BY-NC-SA 4.0)

//rotate([180,0,0]) translate([0,-17,-53]) import("PrusaMK3_filament-sensor-cover.stl",convexity=2);

// Filament tube push fit depth
coupler_ln = 10;
// Filament tube OD (dilate if required)
tube_od = 6.4;
tube_or = tube_od/2;
// Coupler OD
coupler_od = max(11.8,tube_od+5);
coupler_or = coupler_od/2;

/* [Hidden] */
$fn = 90;

rotate([180,0,0]) difference() {
	union() {
		cylinder(r=coupler_or,h=8.5+coupler_ln-1.99);
		translate([0,0,6.5+coupler_ln]) cylinder(r1=coupler_or,r2=coupler_or-2,h=2);
	}
	// Tube cutout
	translate([0,0,7.5]) cylinder(r=tube_or,h=coupler_ln+2);
	// Filament cover attachment
	translate([0,0,-1]) cylinder(r=8.4/2,h=9.5);
	// Screw cutout
	translate([-1,7.5,-1]) cylinder(r=3,h=3);
}