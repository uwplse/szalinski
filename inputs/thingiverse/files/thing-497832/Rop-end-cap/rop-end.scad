$fn = 1*50;

//Diameter of rop end cap
rop_diam = 15.3;
//Hight of rop end cap
rop_hight = 16.24;
//Hole for rope
rop_hole_diam = 4;//[2:6]
//Thikness of rop end cap
rop_thikness = 1.5;

difference() { 
	hull () { 
		translate ([0, 0, rop_hight]) sphere (d = rop_diam-rop_diam/5);
		cylinder (h = rop_hight, d1 = rop_diam, d2 = rop_diam-rop_diam/5);
	}
	hull () { 
		translate ([0, 0, rop_hight]) sphere (d = rop_diam-rop_thikness*2-rop_diam/5);
		cylinder (h = rop_hight, d1 = rop_diam-rop_thikness*2, d2 = rop_diam-rop_thikness*2-rop_diam/5);
	}
	translate ([0, 0, rop_hight+(rop_diam-rop_diam/5)/2-rop_thikness-1]) cylinder (h = rop_thikness+2, d = rop_hole_diam );
}