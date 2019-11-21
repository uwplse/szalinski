//
//  Door for retractable landing wheel (in wing)
//
//  Design by Egil Kvaleberg, 31 January 2015
//

// door extra overlap around leg and wheels
margin = 1.5;

// main door wall thickness
wall = 1.2;

// diameter of strut leg
leg_dia = 9.2;
// distance from top of leg to wheel centre
leg_len = 86.0;

// diameter of wheel
wheel_dia = 55.0;

// extra tab above top of leg, 0 if none
leg_extra = 5.0;
// width of extra tab, also decides width of clips
leg_extra_width = 11.4;
// wall thickness of extra tab
leg_extra_wall = 2.5;

// wall thickness of clips that fastens door to leg
cwall = 2.5;

// relative size of leg clip flex section, from 0.0 to 0.5
clip_size = 0.25;

// distance from surface of door to center of leg
surface_to_c = 7.9;

// length of wheel spring action
sprung_len = 17.8;

// diameter of wheel axle, 0 if it does not protrude through door
axle_dia = 3.5;

d = 1*0.01;

module clip(is_top) {
	rotate ([90, 0, 0]) difference () {
		union () {
			translate([-leg_extra_width/2, 0, -cwall/2]) cube([leg_extra_width, surface_to_c + clip_size*leg_dia, cwall]);
			intersection () { // extra rim
				union () {
					translate([0, surface_to_c, cwall/2]) cylinder(r1=leg_dia/2+wall, r2=leg_dia/2+wall/2, h=wall);
					if (!is_top) translate([0, surface_to_c, -cwall/2-wall]) cylinder(r2=leg_dia/2+wall, r1=leg_dia/2+wall/2, h=wall);
				}
				translate([-leg_extra_width/2, 0, -cwall/2-wall-d]) cube([leg_extra_width, surface_to_c + clip_size*leg_dia, cwall+2*wall+2*d]);
			}
		}
		translate([0, surface_to_c, -cwall/2-wall-d]) cylinder(r=leg_dia/2, h=cwall+2*wall+2*d, $fn=40);
	}
}

module cover() {
	difference () { 
		union () {
			translate([-leg_dia/2 - margin, 0, 0]) cube([2*margin+leg_dia, leg_len, wall]);
			translate([-leg_extra_width/2, leg_len, 0]) cube([leg_extra_width, leg_extra, leg_extra_wall]);

			// 2 strengthening bars
			translate([leg_dia/2 - wall, -wheel_dia/2 + sprung_len, 0]) cube([wall, leg_len + wheel_dia/2-sprung_len, surface_to_c-leg_dia/2]);
			translate([-leg_dia/2, -wheel_dia/2 + sprung_len, 0]) cube([wall, leg_len + wheel_dia/2-sprung_len, surface_to_c-leg_dia/2]);
			intersection () {
				cylinder(r=wheel_dia/2 + margin, h=wall, $fn=40);
				translate([-wheel_dia/2 - margin -d, sprung_len-wheel_dia/2, -d]) cube([2*margin+wheel_dia+2*d, 2*margin+wheel_dia, wall+2*d]);
			}
		}
		hull () {
			translate ([0,0,-d]) cylinder(r=axle_dia/2, h=wall+2*d, $fn=20);
			translate ([0,sprung_len,-d]) cylinder(r=axle_dia/2, h=wall+2*d, $fn=20);
		}
	}
}

cover();
translate ([0, leg_len-cwall/2, 0]) clip(true);
translate ([0, wheel_dia/2+cwall/2, 0]) clip(false);
translate ([0, (leg_len+wheel_dia/2)/2, 0]) clip(false);



