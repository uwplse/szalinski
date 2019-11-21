start_height  =  10;
end_height    =  20;
start_angle   = 180;
end_angle     = 270;
thickness     =   5;
axis_diameter =   3;

top_suface          =  1; // [0:Bearing, 1:Flat]
bearing_diameter    = 11;
bearing_displacement = 0;

demo_mode  = 1; // [0:Disable, 1:Enable]
demo_angle = 180; // [0:360]

// Uncomment the following line to animate in openscad
// demo_angle = ($t < 0.5 ? 2*$t : 2-2*$t) * (end_angle-start_angle) + start_angle;

module z_lift_translate(r0, r1, a0, a1, angle) {
	assign (
		r = (angle<=a0) ? r0 : (angle>=a1) ? r1 : r0+(r1-r0)*(angle-a0)/(a1-a0)
	) translate([r, 0, 0]) child();
}

module z_lift_core(r0, r1, a0, a1, h, rax) {
	difference() {
		cylinder(r=r1*2, h=h, $fn=360);
		for (i=[0:3:360]) assign (
			r = (i<=a0) ? r0 : (i>=a1) ? r1 : r0+(r1-r0)*(i-a0)/(a1-a0)
		) {
			rotate([0, 0, i]) translate([r, 0, -1]) child();
		}
		cylinder(r=rax, h=3*h, center=true, $fn=10);
	}
}

module z_lift_flattop(r0, r1, a0, a1, h, rax) {
	z_lift_core(r0, r1, a0, a1, h, rax) 
		translate([0,-2*r1,0]) cube([2*r1, 4*r1, h+2]);
}

module z_lift_bearing(r0, r1, a0, a1, h, rax, br, bdisp=0) {
	z_lift_core(r0, r1, a0, a1, h, rax) union() {
		translate([br, bdisp, 0]) cylinder(r=br, h=h+2);
		translate([br, bdisp-br, 0]) cube(size=[5*r1, 2*br, h+2]);
	}
}

if (top_suface) {
	if (!demo_mode) {
		z_lift_flattop(
			r0 = start_height,
			r1 = end_height,
			a0 = start_angle,
			a1 = end_angle,
			h  = thickness,
			rax = axis_diameter/2
		);
	} else {
		rotate([0,0,-demo_angle]) z_lift_flattop(
			r0 = start_height,
			r1 = end_height,
			a0 = start_angle,
			a1 = end_angle,
			h  = thickness,
			rax = axis_diameter/2
		);
		z_lift_translate(
			r0 = start_height,
			r1 = end_height,
			a0 = start_angle,
			a1 = end_angle,
			angle = demo_angle
		) color([0.5,0.5,0.5]) translate([0, -end_height, 0]) cube([axis_diameter, 2*end_height, thickness]);
	}
} else {
	if (!demo_mode) {
		z_lift_bearing(
			r0 = start_height,
			r1 = end_height,
			a0 = start_angle,
			a1 = end_angle,
			h  = thickness,
			rax = axis_diameter/2,
			br = bearing_diameter/2,
			bdisp = bearing_displacement
		);
	} else {
		rotate([0,0,-demo_angle]) z_lift_bearing(
			r0 = start_height,
			r1 = end_height,
			a0 = start_angle,
			a1 = end_angle,
			h  = thickness,
			rax = axis_diameter/2,
			br = bearing_diameter/2,
			bdisp = bearing_displacement
		);

		z_lift_translate(
			r0 = start_height,
			r1 = end_height,
			a0 = start_angle,
			a1 = end_angle,
			angle = demo_angle
		) color([0.5,0.5,0.5]) translate([bearing_diameter/2, bearing_displacement, 0])
			cylinder(r=bearing_diameter/2, h=thickness);
	}
}


