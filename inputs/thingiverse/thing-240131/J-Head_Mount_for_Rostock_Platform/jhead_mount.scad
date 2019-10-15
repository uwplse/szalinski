$fs=0.5*1;
j_head_dia = 15.875*1;
j_head_upper_h = 4.76*1;
j_head_groove_dia = 12*1;
j_head_groove_h = 4.64*1;
insert_height=j_head_groove_h+j_head_upper_h;
dual_offset = 10*1;
extra = 0.1*1;
ns=1*1;

M3_clearance_radius = (3/2)+0.4;//(3.3/2);
M3_nut_radius = (6.01/2)+0.4;
M3_nut_trap_depth = 2.2*1;
M4_clearance_radius = (4/2)+0.4;//2.2;
holes = [
	[-13.15,7.2],
	[-13.15,-7.2],
	[12.75,7.2],
	[12.75,-7.2]
];

// Customizer Settings

// The configuration of the heads. Can be single or double.
Insert_Configuration = "Double"; //[Single,Double]

// The configuration of the plate. "All" will result in a plate that can be used with either the single or double insert. "Single" and "Double" will result in a plate specific to the insert.
Plate_Configuration = "All"; //[All,Single,Double]

// The tap drill diameter of the pneumatic fitting threads. Some common values: 1/8" NPT = 8.611 mm, 1/4" NPT = 11.113 mm, 1/8" BSP = 8.6, 1/4" BSP = 11.5.
Pneumatic_Fitting_Thread_Diameter = 8.6;

// The length of the threaded part of the pneumatic fitting.
Pneumatic_Fitting_Thread_Height = 7.0;

fitting_wall_th = 2*1; 
plate_chamfer = 1*1;

// The thickness of the plate.
Plate_Height = 3;

// The diameter of the plate. This should match the outer diameter of the Rostock platform; for the standard Rostock this should be 60.
Plate_Diameter = 60;

// The diameter of the insert. This should be just less than the inner diameter of the Rostock platform; for the standard Rostock the inner diameter is 40.
Insert_Diameter = 39;

// The bolt circle diameter for the 4 mm bolts ono the plate. This should match the bolt circle diameter of the Rostock Platform; for the standard Rostock this should be 50.
Plate_Bolt_Circle_Diameter = 50;

// What objects would you like to generate?
Resulting_Objects = "Insert";//[Both,Plate,Insert]



max_height=max(Plate_Height,Pneumatic_Fitting_Thread_Height,insert_height);

// Display
if(Resulting_Objects=="Both") {
translate([(Plate_Diameter/2)+2.5,0,0])	jhead_mount_plate();
translate([-(Insert_Diameter/2)-2.5,0,0]) jhead_mount_insert();
} else if(Resulting_Objects=="Plate") {
	jhead_mount_plate();
} else if(Resulting_Objects=="Insert") {
	jhead_mount_insert();
} else {
	echo("This shouldn't happen.");
}

module jhead_mount_plate() {
  difference() {
		// Base plate.
		union() {
		hull() {
			cylinder(r=(Plate_Diameter/2),h=Plate_Height-plate_chamfer);
			translate([0,0,Plate_Height-plate_chamfer]) cylinder(r=(Plate_Diameter/2)-plate_chamfer,h=plate_chamfer);
		}
	hull() {
		if(Plate_Configuration!="Double") {
		translate([0,0,0]) cylinder(r=(Pneumatic_Fitting_Thread_Diameter/2)+fitting_wall_th,h=Pneumatic_Fitting_Thread_Height);
		}
	if(Plate_Configuration!="Single") {
		translate([0,-dual_offset,0]) cylinder(r=(Pneumatic_Fitting_Thread_Diameter/2)+fitting_wall_th,h=Pneumatic_Fitting_Thread_Height);
		translate([0,dual_offset,0]) cylinder(r=(Pneumatic_Fitting_Thread_Diameter/2)+fitting_wall_th,h=Pneumatic_Fitting_Thread_Height);
		}
	}	
}

		// 6 x 4mm holes for mounting to platform.
		for(i=[0:60:360]) {
			rotate([0,0,i]) translate([(Plate_Bolt_Circle_Diameter/2),0,-extra]) cylinder(r=M4_clearance_radius,h=max_height+(2*extra));
		}

		// 3 x 5mm holes for pneumatic fitting(s).
		if(Plate_Configuration!="Double") {
		translate([0,0,-extra]) cylinder(r=(Pneumatic_Fitting_Thread_Diameter/2),h=max_height+(2*extra));
}
	if(Plate_Configuration!="Single") {
		translate([0,-dual_offset,-extra]) cylinder(r=(Pneumatic_Fitting_Thread_Diameter/2),h=max_height+(2*extra));
		translate([0,dual_offset,-extra]) cylinder(r=(Pneumatic_Fitting_Thread_Diameter/2),h=max_height+(2*extra));
}

		// 3mm holes for mounting J_insert.
		for (i=holes) {
			translate([i[0],i[1],-extra]) cylinder(h=max_height+(2*extra),r=M3_clearance_radius,center=true);
		}
  }

}

module jhead_mount_insert() {
	difference() {
		// Base insert.
		cylinder(h=insert_height,r=(Insert_Diameter/2));

		// 3mm holes for mounting to J_Ring.
		for (i=holes) {
			// 3mm hole through insert.
			

			// M3 nut on top of insert.
			hull() {
				translate([i[0],i[1],insert_height-M3_nut_trap_depth-(ns/2)]) cylinder(h=ns,r=M3_clearance_radius,center=true);
				translate([i[0],i[1],insert_height-(M3_nut_trap_depth/2)]) cylinder(h=M3_nut_trap_depth+extra,r=M3_nut_radius,center=true,$fn=6);
			}

			// M3 nut of bottom of insert.
			hull() {
				translate([i[0],i[1],M3_nut_trap_depth+(ns/2)]) cylinder(h=ns,r=M3_clearance_radius,center=true);
				translate([i[0],i[1],(M3_nut_trap_depth/2)-extra]) cylinder(h=M3_nut_trap_depth+extra,r=M3_nut_radius,center=true,$fn=6);
			}
			translate([i[0],i[1],-extra]) cylinder(h=max_height+(2*extra),r=M3_clearance_radius);
		}

		// Hole for J-Head.
		if(Insert_Configuration=="Double") {
			translate([0,-dual_offset,-0.1]) rotate([0,0,270]) jhead_hole();
			translate([0,dual_offset,-0.1]) rotate([0,0,90]) jhead_hole();
		} else {
			translate([0,0,-0.1]) rotate([0,0,270]) jhead_hole();
		}
	}
}

module jhead_hole() {
	translate([0,0,-extra]) cylinder(h=max_height+(2*extra),r=j_head_groove_dia/2,center=true);
	translate([0,0,j_head_groove_h]) cylinder(h=5,r=j_head_dia/2);
	translate([(Insert_Diameter/2)/2,0,-extra]) cube([(Insert_Diameter/2),j_head_groove_dia-0.2,max_height+(2*extra)],center=true);
	translate([(Insert_Diameter/2)/2,0,(5/2)+j_head_groove_h]) cube([(Insert_Diameter/2),j_head_dia-0.2,5],center=true);
}
