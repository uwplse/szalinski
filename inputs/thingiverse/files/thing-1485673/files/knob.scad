/* Knob
Jack Ha 2016
*/

// C = Cylinder, F = Flower
SHAPE = "C";  

// ** Cylinder options OUTER RADIUS
CYLINDER_R_OUTER = 26;
// 'amount of taper'
ROUNDING_R = 1.5;
C_FN = 4;

C_CUT_NUM = 4;  // often the same as C_FN
C_CUT_R = 10; //radius
C_CUT_OFFSET = 15;  
C_CUT_FN = 5; // vertices
C_CUT_SCALE = 1;  // normally 1, scale the cylinder being cut from base, try it out :-)
C_CUT_ANGLE = 36;
// precalculation, do not change
C_ANGLE = 360 / C_CUT_NUM;
C_ANGLE_OFFSET = 0.5 * C_ANGLE;  // 0 or 0.5*C_ANGLE 

// ** Flower options
F_NUM_LEAFS = 3;  // 5, 7, 3
F_LEAF_OFFSET = 22.5;  // 20, 20, 20
F_LEAF_R_INNER = 5;  // 2.5, 2, 5
F_LEAF_R_OUTER = 1.5;  // 6, 5, 2
// precalculation, do not change
F_ANGLE = 360 / F_NUM_LEAFS;


// AXLE options

// HEIGHT=13 for 20mm pots/rotary encoders, 10 for 15mm; or through hole, then choose something you like^^
H = 8.5;

// D for D shape or N for normal
AXLE_TYPE = "N";  

// depth of hole, optionally leave 1 mm on top (H-1) or through hole (H+1)
AXLE_D = H - 1;  
// for D axle hole, there is an extra round part
AXLE_D2 = 2.5;  
// for 6mm axle
AXLE_R = 3.05;

// for 6mm D shaped axle
AXLE_D_R = 3.2;

module pin_d(r, d) {
	translate([0,0,-0.1])
	difference() {
		cylinder(r=r, h=0.1+d, $fn=30);
		translate([1.6,-50,-1])
		cube([100,100,100]);
	}
}

module pin(r, d) {
	translate([0,0,-0.1])
    cylinder(r=r, h=0.1+d, $fn=30);
}


M = [ [ 1, 0, 0, 0 ],
       [ 0, 1, 0.3, 0 ],  // The "0.7" is the skew value; pushed along the y axis
       [ 0, 0, 1, 0 ],
       [ 0, 0, 0, 1 ] ] ;

module base_cylinder() {
    difference() {
	minkowski() {
        //multmatrix(M) {
        //    union() {
		//sphere(r=ROUNDING_R, $fn=12);
		cylinder(r1=ROUNDING_R, r2=0, h=ROUNDING_R, $fn=C_FN);
		cylinder(r=CYLINDER_R_OUTER-ROUNDING_R, h=H-ROUNDING_R, $fn=C_FN);
        //    }
        //}
	}
    for (i=[0:C_CUT_NUM-1]) {
            rotate([0,0,C_ANGLE_OFFSET+C_ANGLE*i])
            translate([C_CUT_OFFSET,0,-0.1])
            rotate([0,0,C_CUT_ANGLE])            
            scale([C_CUT_SCALE,1,1])
        
            //multmatrix(M) {
            //union() {
                cylinder(r=C_CUT_R, h=H+0.2, $fn=C_CUT_FN); }
            //}
        //}
    }
}

module flower() {
    for (i=[0:F_NUM_LEAFS-1]) {
        rotate([0,0,F_ANGLE*i])
        hull() {
            cylinder(r=F_LEAF_R_INNER, h=H);

            translate([F_LEAF_OFFSET,0,0])
            cylinder(r=F_LEAF_R_OUTER, h=H);
        }
    }
}


rotate([180,0,0])
difference() {
    if (SHAPE == "C") {
        base_cylinder();
    } else if (SHAPE == "F") {
        flower();
    }
    if (AXLE_TYPE == "D") {
        pin_d(AXLE_D_R, AXLE_D);
        pin(AXLE_D_R+0.2, AXLE_D2);
    } else {
        pin(AXLE_R, AXLE_D);
    }
}