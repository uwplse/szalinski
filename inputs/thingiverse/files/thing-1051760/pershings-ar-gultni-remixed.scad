$fn = 100;

// 606 ZZ
rod_diameter = 6;
bearing_diameter = 17;
bearing_weight = 6;

// 628 ZZ
//rod_diameter = 8;
//bearing_diameter = 24;
//bearing_weight = 8;

difference (){
	union(){
		#import ("pershings_ar_gultni.stl");		
		translate ([0, 0, 0]) sphere (d = (31));
		cylinder (30, d = 14);
	}
	
	cylinder(bearing_weight, d = bearing_diameter);
	translate ([0, 0, -bearing_diameter]) cube ([bearing_diameter *2, bearing_diameter *2, bearing_diameter *2], true);
	translate ([0, 0, bearing_weight + 0.3]) cylinder (30, d = rod_diameter + 1);
}


