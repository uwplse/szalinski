down = 3 + 0; //down tube mount
difference () { 
	cube(size = [47,14,10]);
	translate ([0, 7, 0]) cube(size = [40,7,10]);
	}
translate ([47, 0, 0]) cube (size = [15, 7, 10]); 
difference() { 
	hull () { 
		difference() { 
			translate ([-27, down, 0]) cylinder (h = 10, d = 54, center = false);
			translate ([-54, -27 + down, 0]) cube(size = [54,27,10]);
			}
		translate ([-1, down, 0]) cube (size = [1, 14, 10]);
		}
	translate ([-27, down, 0]) cylinder (h = 10, d = 42, center = false);
	}
translate ([-6, 0, 0]) cube (size = [6, down, 10]);
translate ([-12, - 3 + down, 0]) cube (size = [6, 3, 10]);
translate ([-12, - 3 + down, 0]) cube (size = [3, 6, 10]);
translate ([-54, - 3 + down, 0]) cube (size = [12, 3, 10]);
translate ([-45, - 3 + down, 0]) cube (size = [3, 6, 10]);

