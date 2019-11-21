// eSun eBox to Filament Tube Coupler
// v1.1, 18/6/2018 - Added customiser
// by inks007
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (CC BY-NC-SA 4.0)

// Coupler length
coupler_ln = 15;
// Filament tube OD (dilate if required)
tube_od = 6.4;
tube_or = tube_od/2;
coupler_os = tube_or+sqrt(4.05*4.05*2);
// Filament channel diameter
channel_d = 3.1;
channel_r = channel_d/2;
// Back plate lip
back_lip = 1;

$fn=90+0;

rotate([90,0,0]) difference() {
	union() {
		// Plate bridge
		difference() {
			union() {
				rotate([-45,0,0]) linear_extrude(12,center=true) rotate([45,0,0]) hull() {
					translate([0,2.5,0]) circle(r=2.5);
					translate([0,-2.5,0]) circle(r=2.5);
				}
			}
			translate([-5,-8,-12]) cube(10);
		}
		// Back plate
		difference() {
			translate([-25,-25,-4.05]) cube([50,29+back_lip,3]);
			translate([0,4+back_lip,0]) rotate([0,90,0]) cylinder(r=2,h=52,$fn=4,center=true);
		}
		// Front plate
		translate([0,0,1.05]) linear_extrude(3) hull() {
			translate([-25,-25]) square([50,25]);
			translate([0,4]) scale([1,1.414]) circle(r=tube_or+2.5);
			translate([-23,3]) circle(r=2);
			translate([23,3]) circle(r=2);
		}
		// Coupler
		difference() {
			rotate([-45,0,0]) difference() {
				union() {
					translate([0,0,-5]) cylinder(r=tube_or+2.5,h=5+coupler_os+coupler_ln-1.99);
					translate([0,0,coupler_os+coupler_ln-2]) cylinder(r1=tube_or+2.5,r2=tube_or+0.5,h=2);
				}
				translate([0,0,coupler_os]) cylinder(r=tube_or,h=coupler_ln+1);
			}
			a = (tube_od+5+2.1)*1.5;
			translate([0,0,-a/2+2.06]) cube(a,center=true);
		}
	}
	// Filament channel
	rotate([-45,0,0]) {
		cylinder(r=channel_r,h=40,center=true);
		translate([0,0,-3]) mirror([0,0,1]) cylinder(r1=channel_r-0.3,r2=channel_r+6.5,h=12);
	}
}
