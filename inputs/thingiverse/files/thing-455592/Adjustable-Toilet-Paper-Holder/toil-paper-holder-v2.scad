lg_dia = 25; 	// large cylinder diameter
lg_len = 80; 	// large cylinder length
lg_d = 1.8;		// large cylinder thickness

cap_dia = 15.5;
cap_len = 7;
cap_d = 1.2;

total_len = 160; // total length

sp_len = 68;	// spring length

/*
 * This generates the height of the interlocking piece.
 * It is designed to achieve 90% compression of the spring
 */
lock_h = (lg_len - ((sp_len) * .9))/2;

sm_dia = 21.5;	// small cylinder diameter
sm_len = total_len - lg_len + lock_h;	// small cylinder length
sm_d = 1.5;		// small cylinder thickness

key_sz = 3; // Thickness of the interlocking piece

/*
 * Hollow tube
 */
module tube(len,dia,thick) {
	difference() {
		cylinder(len,d=dia,dia/2);
		translate([0,0,-5]) {
			cylinder(len+10,d=(dia-thick),(dia-thick)/2);
		};
	};
};

/*
 * Endcap where tube attaches to holder
 */
module endcap(base_thick=2, base_dia, dia, height) {
	cylinder(base_thick, d=base_dia, base_dia/2);
	tube(cap_len+base_thick,cap_dia,cap_d);
}

/*
 * Simple interlocking piece
 */
module tube_lock(height,outer_dia,inner_dia,key_size) {
	difference() {
		tube(height,outer_dia,(outer_dia-inner_dia)*.8);
		translate([-key_size/2,-(outer_dia+10)/2,-5]) {
			cube([key_size,outer_dia+10,height+10]);
		};
	}
}

/*
 * Simple key
 */
module tube_key(height,outer_dia,inner_dia,key_size) {
	/* set to 90% thickness of difference between outer and inner tube */
	tube(height,inner_dia,outer_dia-inner_dia);
	translate([-(key_size*.8)/2,-(outer_dia-.2)/2,0]) {
		cube([key_size*.8,outer_dia-.2,height]);
	}
}

module big_tube() {
	union() {
		tube(lg_len, lg_dia, lg_d);
		tube_lock(lock_h,lg_dia-lg_d,sm_dia,key_sz);
		translate([0,0,lg_len-2]) {
			endcap(2, lg_dia, cap_dia, cap_len);
		}
	}
}

module small_tube() {
	union() {
		tube_key(lock_h,lg_dia-lg_d,sm_dia,key_sz);
		translate([0,0,lock_h]) {
			tube(sm_len, sm_dia, sm_d);
			translate([0,0,sm_len-2]) {
				endcap(2, sm_dia, cap_dia, cap_len);
			}
		}
	}
}		

translate([0,-(lg_dia/2+sm_dia/2+25)/2,0]) {
	big_tube();
	translate([0,50,0]) {
		small_tube();
	}
}