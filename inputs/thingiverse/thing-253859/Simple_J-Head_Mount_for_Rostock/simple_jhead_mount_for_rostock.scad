////////////////////////////////////////////////////////////////////////////////
// Simple J-Head Mount for Rostock (Customizable) - Version 0.2

// The height of the groove mount plate (the lower one).
plate_height = 4.5;
// The height of the holding plate (the upper one).
upper_height = 8;
// The width of the mount.
plate_width = 20;
// Generate cutouts between the pneumatic fitting hole and the bolt holes?
generate_cutouts = "Yes"; // [Yes,No]
// The width of the material on either side of the cutouts.
support_width = 4.5;
// The diameter of the Rostock platform. For a standard Rostock this is 60.
platform_diameter = 60;
// The bolt circle diameter of the Rostock platform. For a standard Rostock this is 50.
platform_bcd = 50;
// The diameter of the groove on the J-Head body. For a J-Head MK VI this is 12.
jhead_groove_diameter = 12.0;
// The diameter of the J-Head body. For a J-Head MK VI this is 16.
jhead_body_diameter = 16.0;
// The length of the J-Head body that is above the groove mount plate.
jhead_upper_height = 6.0;
// The bolt recess depth. If this value is too small then it will overridden to zero.
desired_bolt_recess_depth = 4.25;
// The hole size for the pneumatic fitting. This should be smaller than the outer thread size so that it can be tapped.
pneumatic_fitting_drill_diameter = 4.3;
// The length of threads on the pneumatic fitting.
pneumatic_fitting_thread_length = 5;
// Should supports be generated? 
generate_support = "Yes"; // [Yes,No]
// The layer height. This is used for generating the support.
layer_height = 0.20;
// The layer thickness/width. This is used for generating the support.
layer_width = 0.35;
// The distance between the two parts.
spacing = 5;
// What objects should be generated?
generate = "Both"; // [Both,Holding Plate,Groove Plate]
// Configuration of the groove mount plate and holding plate. Can be either single or double.
configuration = "Single"; // [Single,Double]
// The distance between the two J-Head bodies when mounted.
jhead_spacing = 2;

jhead_centers = (configuration=="Double")?[[-(jhead_body_diameter/2)-(jhead_spacing/2),0,0],[+(jhead_body_diameter/2)+(jhead_spacing/2),0,0]]:[[0,0,0]];


// Other Settings and stuff that arn't shown in customizer.
m4_clearance_diameter = 4.4*1;
m4_washer_diameter = 9.25*1;
wall_thickness_for_pneumatic_fitting = 2*1;
jhead_slot_width = jhead_groove_diameter-0.1;
bolt_recess_depth = (desired_bolt_recess_depth>=upper_height)?0:desired_bolt_recess_depth;
extra = 0.1*1;


////////////////////////////////////////////////////////////////////////////////
// spiral_support

module spiral_support(inner_diameter, outer_diameter, height, rotation=720,segments=50) {
	diff = (outer_diameter-inner_diameter)/2;
	for(i=[1:segments]) {
		hull() {
			rotate([0,0,(i-1)*(rotation/segments)]) translate([(inner_diameter/2)+((i-1)*(diff/segments)),0,0]) cylinder(r=layer_width/2,h=height);
			rotate([0,0,i*(rotation/segments)]) translate([(inner_diameter/2)+(i*(diff/segments)),0,0]) cylinder(r=layer_width/2,h=height);
		}
	}
}


////////////////////////////////////////////////////////////////////////////////
// jhead_mount_groove_plate

module jhead_mount_groove_plate() {
	translate([0,0,plate_height/2]) difference() {
		intersection() {
			cylinder(r=platform_diameter/2,h=plate_height,$fn=50,center=true);
			cube([platform_diameter,plate_width,plate_height],center=true);
		}
		translate([-platform_bcd/2,0,0]) cylinder(r=m4_clearance_diameter/2,h=plate_height+(2*extra),center=true,$fn=12);
		translate([platform_bcd/2,0,0]) cylinder(r=m4_clearance_diameter/2,h=plate_height+(2*extra),center=true,$fn=12);
		if(configuration=="Double") {
			translate([-(jhead_body_diameter/2)-(jhead_spacing/2),0,0]) cylinder(r=(jhead_groove_diameter/2),h=plate_height+(2*extra),center=true);
			translate([-(jhead_body_diameter/2)-(jhead_spacing/2),(plate_width/4)+(extra/2),0]) cube([jhead_slot_width,(plate_width/2)+extra,plate_height+(2*extra)],center=true);
			translate([+(jhead_body_diameter/2)+(jhead_spacing/2),0,0]) cylinder(r=(jhead_groove_diameter/2),h=plate_height+(2*extra),center=true);
			translate([(jhead_body_diameter/2)+(jhead_spacing/2),-(plate_width/4)-(extra/2),0]) cube([jhead_slot_width,(plate_width/2)+extra,plate_height+(2*extra)],center=true);
		} else if(configuration=="Single") {
			cylinder(r=(jhead_groove_diameter/2),h=plate_height+(2*extra),center=true);
			translate([0,(plate_width/4)+(extra/2),0]) cube([jhead_slot_width,(plate_width/2)+extra,plate_height+(2*extra)],center=true);
		}
	}
}


////////////////////////////////////////////////////////////////////////////////
// jhead_mount_holding_plate

module jhead_mount_holding_plate() {
	translate([0,0,upper_height/2]) {
		difference() {
			union() {
				hull() {
					for(i=jhead_centers) {
						translate([i[0],i[1],-(upper_height/2)+jhead_upper_height]) cylinder(r=(pneumatic_fitting_drill_diameter/2)+wall_thickness_for_pneumatic_fitting,h=pneumatic_fitting_thread_length);
						translate([i[0],i[1],-(upper_height/2)]) cylinder(r=(plate_width/2),h=max(upper_height,jhead_upper_height));
					}
				}
				intersection() {
					cylinder(r=platform_diameter/2,h=upper_height,center=true,$fn=50);
					cube([platform_diameter,plate_width,upper_height],center=true);
				}
			}
			translate([-platform_bcd/2,0,0]) cylinder(r=m4_clearance_diameter/2,h=upper_height+(2*extra),center=true,$fn=12);
			translate([platform_bcd/2,0,0]) cylinder(r=m4_clearance_diameter/2,h=upper_height+(2*extra),center=true,$fn=12);

	for(i=jhead_centers) {
			translate([i[0],i[1],-(upper_height/2)-extra]) cylinder(r=jhead_body_diameter/2,h=jhead_upper_height+(extra));
			translate([i[0],i[1],-(upper_height/2)+(jhead_upper_height)-extra]) cylinder(r=pneumatic_fitting_drill_diameter/2,h=max(pneumatic_fitting_thread_length+(2*extra),upper_height-jhead_upper_height+(2*extra)),$fn=16);
}
			if((generate_cutouts=="Yes")&&(configuration!="Double")) {
				difference() {
					intersection() {
						cube([platform_diameter,plate_width-(2*support_width),upper_height+(2*extra)],center=true);
						cylinder(r=(platform_diameter/2)-support_width,h=upper_height+(2*extra),center=true);
					}
					translate([platform_bcd/2,0,0]) cylinder(r=(m4_clearance_diameter/2)+support_width,h=upper_height+(2*extra),center=true);
					translate([-platform_bcd/2,0,0]) cylinder(r=(m4_clearance_diameter/2)+support_width,h=upper_height+(2*extra),center=true);
					for(i=jhead_centers) {
					translate([i[0],i[1],0]) cylinder(r=(plate_width/2),h=upper_height+(2*extra),center=true);
}
				}
			}
			translate([platform_bcd/2,0,(upper_height/2)-bolt_recess_depth]) cylinder(r=(m4_washer_diameter/2),h=bolt_recess_depth+extra);
			translate([-platform_bcd/2,0,(upper_height/2)-bolt_recess_depth]) cylinder(r=(m4_washer_diameter/2),h=bolt_recess_depth+extra);
			translate([platform_bcd/2,-(m4_washer_diameter/2),(upper_height/2)-bolt_recess_depth]) cube([((platform_diameter-platform_bcd)/2)+extra,m4_washer_diameter,bolt_recess_depth+extra]);
			translate([-(platform_bcd/2)-((platform_diameter-platform_bcd)/2)-extra,-(m4_washer_diameter/2),(upper_height/2)-bolt_recess_depth]) cube([((platform_diameter-platform_bcd)/2)+extra,m4_washer_diameter,bolt_recess_depth+extra]);
		}
		if(generate_support=="Yes") {
			for(i=jhead_centers) {
				translate([i[0],i[1],-upper_height/2]) spiral_support(outer_diameter=jhead_body_diameter-2,inner_diameter=1,height=jhead_upper_height,rotation=720);
				translate([i[0],i[1],-(upper_height/2)+jhead_upper_height]) cylinder(r=jhead_body_diameter/2,h=layer_height);
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
// Main

if(generate=="Both") {
	translate([0,(plate_width/2)+(spacing/2),0]) 
		jhead_mount_groove_plate();
	translate([0,-(plate_width/2)-(spacing/2),0])
		jhead_mount_holding_plate();
} else if(generate=="Groove Plate") {
	jhead_mount_groove_plate();
} else if(generate=="Holding Plate") {
	jhead_mount_holding_plate();
}