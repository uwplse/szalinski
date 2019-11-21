
enclosure_inner_length = 60;
enclosure_inner_width = 40;
enclosure_inner_depth = 30;

enclosure_thickness = 2;

cover_thickness = 3;

part = "enclosure"; // [enclosure:Enclosure, cover:Cover, both:Enclosure and Cover]

print_part();

module print_part() {
	if (part == "enclosure") {
		box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
	} else if (part == "cover") {
		lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);
	} else {
		both();
	}
}

module both() {

box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);

}

module screws(in_x, in_y, in_z, shell) {

	sx = in_x/2 - 4;
	sy = in_y/2 - 4;
	sh = shell + in_z - 12;
	nh = shell + in_z - 4;

translate([0,0,0]) {
	translate([sx , sy, sh]) cylinder(r=1.5, h = 15, $fn=32);
	translate([sx , -sy, sh ]) cylinder(r=1.5, h = 15, $fn=32);
	translate([-sx , sy, sh ]) cylinder(r=1.5, h = 15, $fn=32);
	translate([-sx , -sy, sh ]) cylinder(r=1.5, h = 15, $fn=32);


	translate([-sx , -sy, nh ]) rotate([0,0,-45]) 
		translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
	translate([sx , -sy, nh ]) rotate([0,0,45]) 
		translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
	translate([sx , sy, nh ]) rotate([0,0,90+45]) 
		translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
	translate([-sx , sy, nh ]) rotate([0,0,-90-45]) 
		translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
}
}

module bottom(in_x, in_y, in_z, shell) {

	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
	}
}

module sides(in_x, in_y, in_z, shell) {
translate([0,0,shell])
difference() {

	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
	}

	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
	}
}

intersection() {
	translate([-in_x/2, -in_y/2, shell]) cube([in_x, in_y, in_z+2]);

	union() {
	translate([-in_x/2 , -in_y/2,shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
	translate([-in_x/2 , -in_y/2,shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);

	translate([in_x/2 , -in_y/2, shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
	translate([in_x/2 , -in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);

	translate([in_x/2 , in_y/2,  shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
	translate([in_x/2 , in_y/2,  shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);

	translate([-in_x/2 , in_y/2, shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
	translate([-in_x/2 , in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);
	}

}
}

module lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness) {

	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);

	translate([0,0,shell+in_z])

difference() {

	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
	}

	
	translate([0, 0, -1]) linear_extrude(height = top_thickness + 2) polygon(points = [
		[cxm+5, cym],
		[cxm, cym+5],
		[cxm, cyp-5],
		[cxm+5, cyp],
		[cxp-5, cyp],
		[cxp, cyp-5],
		[cxp, cym+5],
		[cxp-5, cym]]);
}
}

module lid2(in_x, in_y, in_z, shell, top_lip, top_thickness) {

	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);	

difference() {
	translate([0, 0, in_z+shell]) linear_extrude(height = top_thickness ) polygon(points = [
		[cxm+5, cym],
		[cxm, cym+5],
		[cxm, cyp-5],
		[cxm+5, cyp],
		[cxp-5, cyp],
		[cxp, cyp-5],
		[cxp, cym+5],
		[cxp-5, cym]]);
		

		screws(in_x, in_y, in_z, shell);

	
}
}

module box2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
	bottom(in_x, in_y, in_z, shell);
	difference() {
		sides(in_x, in_y, in_z, shell);
		screws(in_x, in_y, in_z, shell);
	}
	lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness);
}



