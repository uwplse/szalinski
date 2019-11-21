CornerRadius = 3.0;
JointSideLength = 10.0;
JointWallThickness = 1.5;
JointDepth = 6.0;
JointTolerance = 0.5;

ScaffoldBottomLength = 110.0;
ScaffoldTopLength = 90.0;
ScaffoldHeight = 40.0;
ScaffoldBraceThickness = 3.0;

ScaffoldCenterLeg = true;
ScaffoldSideLeg = true;

//me no like typings
cr = CornerRadius;
jsl = JointSideLength;
jwt = JointWallThickness;
jd = JointDepth;
jt = JointTolerance;

//short names plz
sbl = ScaffoldBottomLength;
stl = ScaffoldTopLength;
sh = ScaffoldHeight;
sbt = ScaffoldBraceThickness;

scl = ScaffoldCenterLeg;
ssl = ScaffoldSideLeg;

OuterSideLength = JointSideLength + 2 * JointWallThickness;
osl = OuterSideLength;

$fn = 30;

module rsquare2d(xy, r=cr) {
	hull() {
		translate([r, r])
		circle(r);
		translate([xy[0]-r, r])
		circle(r);
		translate([r, xy[1]-r])
		circle(r);
		translate([xy[0]-r, xy[1]-r])
		circle(r);
	}
}

module rsquare(xyz, r=cr) {
	linear_extrude(height = xyz[2], convexity = 2, slices = 2) {
		rsquare2d([xyz[0], xyz[1]], r);
	}
}

module joint_socket() {
	difference() {
		rsquare([osl,osl,jd], cr);
		translate([jwt - 0.25 * jt, jwt - 0.25 * jt, -jt])
		rsquare([jsl + 0.5 * jt, jsl + 0.5 * jt, jd + 2 * jt], 
				cr - jt);
	}
}

module joint_plug() {
	translate([jwt + 0.25 * jt, jwt + 0.25 * jt, 0])
	rsquare([jsl - 0.5 * jt, jsl - 0.5 * jt, jd], 
			cr - jt);
}

module joint_socket_profile(h = 0) {
	if(h == 0) {
		rsquare2d([osl,osl], cr);
	} else {
		linear_extrude(height = h, convexity = 2, slices = 2)
		rsquare2d([osl,osl], cr);
	}
}

module joint_plug_profile(h = 0) {
	translate([jwt + 0.25 * jt, jwt + 0.25 * jt])
	rsquare2d([jsl - 0.5 * jt, jsl - 0.5 * jt], cr - jt);
	if(h == 0) {
		translate([jwt + 0.25 * jt, jwt + 0.25 * jt])
		rsquare2d([jsl - 0.5 * jt, jsl - 0.5 * jt], cr - jt);
	} else {
		linear_extrude(height = h, convexity = 2, slices = 2)
		translate([jwt + 0.25 * jt, jwt + 0.25 * jt])
		rsquare2d([jsl - 0.5 * jt, jsl - 0.5 * jt], cr - jt);
	}
}

module scaffold_leg() {
	assign(stco = (sbl - stl) / 2.0) {
		joint_socket();
		hull() {
			translate([0, 0, jd])
			joint_socket_profile(0.01);
			translate([stco, stco, sh])
			joint_socket_profile(0.01);
		}
		translate([stco, stco, sh])
		joint_plug();
	}
}

module scaffold_leg_center() {
	assign(off = (sbl - osl) / 2) {
		translate([off, off, 0])
		joint_socket();
		hull() {
			translate([off, off, jd])
			joint_socket_profile(0.01);
			translate([off, off, sh])
			joint_socket_profile(0.01);
		}
		translate([off, off, sh])
		joint_plug();
	}
}

module scaffold_leg_side() {
	translate([(sbl-osl)/2, 0, 0])
	assign(stco = (sbl - stl) / 2.0) {
		joint_socket();
		hull() {
			translate([0, 0, jd])
			joint_socket_profile(0.01);
			translate([0, stco, sh])
			joint_socket_profile(0.01);
		}
		translate([0, stco, sh])
		joint_plug();
	}
}

module scaffold_leg_group() {
	scaffold_leg();
	if(ssl)
	scaffold_leg_side();
}

module scaffold_brace_diag(ratio) {
	translate([0,0,sh * ratio]) {
		assign(stco = 0.5 * (sbl - stl) * ratio) {
			hull() {
				translate([stco, stco, 0])
				joint_socket_profile(sbt);
				translate([sbl - stco, sbl - stco, 0])
				rotate([0,0,180])
				joint_socket_profile(sbt);
			}
		}
	}
}
module scaffold_brace_aligned(ratio, center = false) {
	translate([0,0,sh * ratio]) {
		assign(stco = 0.5 * (sbl - stl) * ratio, 
				stcc = 0.5 * (sbl - osl)) {
			if(center) {
				hull() {
					translate([stco, stcc, 0])
					joint_socket_profile(sbt);
					translate([sbl - stco, stcc, 0])
					rotate([0,0,90])
					joint_socket_profile(sbt);
				}
			} else {
				hull() {
					translate([stco, stco, 0])
					joint_socket_profile(sbt);
					translate([sbl - stco, stco, 0])
					rotate([0,0,90])
					joint_socket_profile(sbt);
				}
			}
		}
	}
}

module scaffold() {
	translate([-sbl/2, -sbl/2, 0])
	union() {
		translate([0,0,0])
		rotate([0,0,0])
		scaffold_leg_group();
		translate([sbl,0,0])
		rotate([0,0,90])
		scaffold_leg_group();
		translate([sbl,sbl,0])
		rotate([0,0,180])
		scaffold_leg_group();
		translate([0,sbl,0])
		rotate([0,0,270])
		scaffold_leg_group();
		
		if(scl)
		scaffold_leg_center();
		
		translate([0, 0, 0])
		rotate([0,0,0])
		scaffold_brace_diag(1.0/3.0);
		translate([sbl, 0, 0])
		rotate([0,0,90])
		scaffold_brace_diag(2.0/3.0);
		
		translate([0, 0, 0])
		rotate([0,0,0])
		scaffold_brace_aligned(4.0/9.0);
		translate([sbl, sbl, 0])
		rotate([0,0,180])
		scaffold_brace_aligned(4.0/9.0);
		if(ssl)
		translate([0, 0, 0])
		rotate([0,0,0])
		scaffold_brace_aligned(4.0/9.0, true);

		translate([sbl, 0, 0])
		rotate([0,0,90])
		scaffold_brace_aligned(5.0/9.0);
		translate([0, sbl, 0])
		rotate([0,0,270])
		scaffold_brace_aligned(5.0/9.0);
		if(ssl)
		translate([sbl, 0, 0])
		rotate([0,0,90])
		scaffold_brace_aligned(5.0/9.0, true);
	}
}



//joint_socket();
//joint_plug();
scaffold();