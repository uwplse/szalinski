difference() { 
cube ([53,14,15]);
	translate ([0, 0, 8]) cube (size = [15, 14, 7]);
	translate ([0, 0, 8]) cube (size = [15, 14, 7]);
	translate ([38, 0, 8]) cube (size = [15, 14, 7]);
	translate ([21, 0, 0 ]) cube (size = [11, 14, 7]);
	translate ([7, 7, 0]) cylinder (h = 8, d = 4, $fn = 20);
	translate ([7, 7, 8]) cylinder (h = 4, r1 = 2, r2 = 6, center = true, $fn = 20);
	translate ([46, 7, 0]) cylinder (h = 8, d = 4, $fn = 20);
	translate ([46, 7, 8]) cylinder (h = 4, r1 = 2, r2 = 6, center = true, $fn = 20);
}
