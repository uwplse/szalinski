//EXTENSION TUBES
$fn = 66;
tube_len = 10; // [4:100]

//-----------------------------------------------------------------------------
// Standard: c-mount male
// @param: inner_d = 23mm (for 0.3mm resolution printer)
// @paramL outer_d = 24.7mm
//
//-----------------------------------------------------------------------------
module cmount_male(len) {
	inner_d = 23;
	outer_d = 24.7;
	f_inner_d = 25.4;
	f_outer_d = 28.6;
	translate ([0, 0, len / 2 ]) {
		difference () {
			union () {
				cylinder(r = outer_d / 2, h = len, center = true);
			}
			cylinder(r = inner_d / 2, h = len + 1, center = true);
		}

		difference () {
			translate([0, 0, -(len / 2) - 1]) cylinder(r = f_outer_d / 2, h = 2, center = true);
			translate([0, 0, -(len / 2) - 1]) cylinder(r1 = f_inner_d / 2, r2 = inner_d / 2, h = 2, center = true);
		}	
	}
}

//-----------------------------------------------------------------------------
// Standard: c-mount female
// @param: inner_d = 26mm(for 0.3mm resolution printer) //CHANGINE
// @paramL outer_d = 29.2mm 
//
//-----------------------------------------------------------------------------
module cmount_female(len) {
	inner_d = 25.6;
	outer_d = 29.2;
	translate ([0, 0, (len / 2)]) {
		difference () {
			cylinder(r = outer_d / 2, h = len, center = true);
			cylinder(r = inner_d / 2, h = len + 1, center = true);
		}	
	}

}

module extension_tube (len = 10) {
	translate([0, 0, len]) cmount_male(4);
	translate([0, 0, 0]) cmount_female(len);
}

extension_tube(tube_len);