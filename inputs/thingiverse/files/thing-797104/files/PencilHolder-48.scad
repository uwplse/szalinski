// Laurie Gellatly
// Holder for 48 (or you choose) pencils
// v1.1 2018/07/29 Allow for much larger pencil diameters

// to be held?
number_of_pencils = 48;	// [8:48]
// of pencils?
slope_angle = 35;	// [20:40]	
// (8.1 default, but you can try other values at your own risk)
pencil_diameter = 8.1;   // 
// Set to None before printing
number_test_pencils = 0; // [0:None - ready for STL,4:Some filled]

/* [Hidden] */
pencil_rad = pencil_diameter/2;
slope_in = 5-slope_angle;

base_rad = pencil_diameter + (number_of_pencils * (((48-number_of_pencils)/20)+1.5*pencil_diameter))/(2*3.141);

difference(){
	cylinder(r1=base_rad+4, r2 = base_rad - 3, h=1.5+2*pencil_diameter,$fn = 360);
	translate([0,0,-.1]) cylinder(r2=base_rad -(2+ 2*pencil_diameter), r1 = base_rad - 2*(pencil_diameter-1), h=2*pencil_diameter+1.5+.2,$fn = 3*number_of_pencils);
	for(ang=[0:360/number_of_pencils:360]){
		rotate([0,0,ang]) translate ([base_rad - pencil_rad, 0,pencil_diameter/2]) rotate([slope_angle,slope_in,0]) cylinder(r=pencil_rad, h=4*pencil_diameter, $fn = 90);
	}
}
if(number_test_pencils != 0){
	%color("red") for(ang=[0:360/number_of_pencils:(number_test_pencils-1)*360/number_of_pencils]){
		rotate([0,0,ang]) translate ([base_rad - pencil_rad, 0,4.5]) rotate([slope_angle,slope_in,0]) cylinder(r=pencil_rad, h=20*pencil_diameter, $fn = 8);
	}
}