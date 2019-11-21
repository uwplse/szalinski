$fn = 50 + 0;

needle_size = 3.5; // [2.0:US 0 \ GB 14, 2.1:JP 0, 2.25:US 1 GB 13, 2.4:JP 1, 2.5:2.5 mm, 2.7:JP 2, 2.75:US 2 \ GB 12, 3.0:GB 11 \ JP 3, 3.25:US 3 \ GB 10, 3.3:JP 4, 3.5:US 4, 3.6:JP 5, 3.75:US 5 \ GB 9, 3.9:JP 6, 4.0:US 6 \ GB 8, 4.2:JP 7, 4.5:US 7 \ GB 7 \ JP 8, 4.8:JP 9, 5.0:US 8 \ GB 6, 5.1:JP 10, 5.4:JP 11, 5.5:US 9 \ GB 5, 5.7:JP 12, 6.0:US 10 \ GB 4 \ JP 13, 6.3:JP 14, 6.5:US 10 ½ \ GB 3, 6.6:JP 15, 7.0:GB 2 \ JP 7 mm, 7.5:GB 1, 8.0:US 11 \ GB 0 \ JP 8mm, 9.0:US 13 \ GB 00 \ JP 9mm, 10.0:US 15 \ GB  000 \ JP 10mm, 12.0:US 17, 16.0:US 19, 19.0:US 35, 25.0:US 50]
width = 2; // [2:10]
thickness = 0.5; // [0.5, 1.0, 1.5, 2.0, 2.5, 3.0]
clearance = 0.5 + 0;
radius = (needle_size / 2 + width + clearance) / 0.9;
slot_width = 1 + 0;

linear_extrude(height = thickness) {
	difference() {
        circle(r=needle_size / 2 + width + clearance );
		scale([0.9, 1, 1]) circle(r=(needle_size / 2 + clearance) / 0.9);
	}
}
