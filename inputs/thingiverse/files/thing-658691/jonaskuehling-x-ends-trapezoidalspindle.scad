use <jonaskuehling-default.scad>
include <lm8uu-holder-slim_double-vertical.scad>

// PARAMETERS
rod_dia = 8;
rod_dist = 50;		// center to center
zrod_leadscrew_dist = 30;
clearance = 0.2;		// default clearance
wall = 3;			// default wall thickness
wall_thin = 3;
xend_body_length = 40;

m3_screw_dia = 3;
m3_screw_head_dia = 5.5;
m3_screw_head_height = 3;
m3_nut_wrench_size = 5.5;
m3_nut_height = 2.4;

m8_screw_dia = 8;
m8_washer_dia = 16;
m8_washer_height = 1.5;

idler_dia = 25;		// when using pure 608 bearing without belt guide: 22mm

belt_rod_dist = 7.5;		// in y direction
belt_elevation = 6.5;		// in z direction, space between rod top and belt bottom;
						// = distance between upper side of rods and upper platform of x-carriage (with belt clamps)
belt_height = 2.6;		// belt thickness..

xmotor_y_offset = 45;
idler_y_offset = rod_dist/2+rod_dia/2+belt_rod_dist - 2*m8_washer_height;

// belt range = rod_dist/2+rod_dia/2+belt_rod_dist - nema17 shaft socket = 36.5 - 43 = 6.5mm

leadscrew_dia = 8;
leadscrew_nut_wrench_size = 17+0.2;		// plus some extra clearance
leadscrew_nut_height = 15;
anti_backlash_spring_space = 20;

nema17_width = 43;
nema17_hole_dist = 31;
nema17_center_dia = 25;

layer_height = 0.25;

xend_body_x_offset = 3;
motor_mount_x_offset = -2;


// CALCULATIONS
xend_body_height = rod_dia+2*clearance+2*wall;
xend_body_width = rod_dist+rod_dia+2*wall;
leadscrew_nuttrap_height = 2*leadscrew_nut_height+wall+anti_backlash_spring_space;
bearing_support_height = leadscrew_nuttrap_height;
idler_elevation = xend_body_height/2+rod_dia/2+belt_elevation+belt_height+idler_dia/2;


// RENDER
// "idler=false" for motor-x-end, "idler=true" for idler-x-end

assembly(idler=false);

// -------------------------------------------------

module rod_mount(){
	difference(){
		// block for rods
		translate([0,(rod_dist/2+rod_dia/2+wall)/2,0])
			cube([xend_body_length,rod_dist/2+xend_body_height/2,xend_body_height],center=true);
	
		// round corners horizontal
		translate([xend_body_length/2,rod_dist/2+xend_body_height/2,xend_body_height/2])
			rotate([180,90,0])
				roundcorner(xend_body_height/2,xend_body_length);
		translate([xend_body_length/2,rod_dist/2+xend_body_height/2,-xend_body_height/2])
			rotate([0,0,180]) 
				roundcorner_tear(xend_body_height/2,xend_body_length);
	
		// rod hole
		translate([0,rod_dist/2,0]) teardropcentering(rod_dia/2+clearance,xend_body_length+2);
	
		// rod clamp
		translate([0,body_width/2+1,0])
		difference(){
			translate([0,(rod_dist/2+rod_dia/2+wall+1)/2,-(rod_dia/2+wall+1)/2])
				cube([xend_body_length-20,rod_dist/2+rod_dia/2+wall+1,rod_dia/2+wall+1],center=true);
			translate([0,(rod_dist/2+rod_dia/2+wall+1)/2,-(rod_dia/2+wall+1)/2-2])
				cube([xend_body_length-20-2,rod_dist/2+rod_dia/2+wall+1+2,rod_dia/2+wall+1],center=true);
		}
		translate([0,rod_dist/2,-0.1]) teardropcentering_half(rod_dia/2+clearance+1,xend_body_length-20-2-4,bottom=1);
		

		// clamp screw + nut trap + screw-head-trap
		translate([0,rod_dist/2-rod_dia/2-m3_screw_dia/2-2*clearance-1,0])
			polyhole(m3_screw_dia+2*clearance,xend_body_height+2);
		translate([0,rod_dist/2-rod_dia/2-m3_screw_dia/2-2*clearance-1,xend_body_height/2-m3_nut_height/2+0.5])
			nut_trap(m3_nut_wrench_size,m3_nut_height+1);
	}

	// screw hole print support
	translate([0,rod_dist/2-rod_dia/2-m3_screw_dia/2-2*clearance-1,layer_height/2+(xend_body_height/2-layer_height*round((xend_body_height/2)/layer_height))])
		polyhole(m3_screw_dia+2*clearance,layer_height);
}



module bearing_holder(){
	// linear bearing holder
	translate([-zrod_leadscrew_dist/2,0,0])
		rotate([0,0,90])
			lm8uu_holder_slim_double_vertical();
}

module bearing_holder_spacer(){
	render()
	translate([-body_width/2-zrod_leadscrew_dist/2,0,body_length/2])
		cube([body_width,body_width+3,body_length+2], center = true);
	difference(){
		translate([-zrod_leadscrew_dist/2,0,-1])
			cylinder(r=body_width/2+1.5, h=body_length+2);
		translate([body_width/2-zrod_leadscrew_dist/2+body_width/2-0.5,0,body_length/2])
			cube([body_width,body_width+3,body_length+2], center = true);
	}
}



module leadscrew_nuttrap(){
	translate([zrod_leadscrew_dist/2,0,0])
		rotate([0,0,30]){
			translate([0,0,leadscrew_nuttrap_height/2])
				difference(){
					nut_trap(leadscrew_nut_wrench_size+2*wall,leadscrew_nuttrap_height);
					nut_trap(leadscrew_nut_wrench_size,leadscrew_nuttrap_height+2);
				}
			translate([0,0,wall/2+leadscrew_nut_height])
				difference(){
					nut_trap(leadscrew_nut_wrench_size+2*wall,wall);
					rotate([0,0,-30]) cube([leadscrew_dia+1,leadscrew_nut_wrench_size*2,wall+2],center=true);
				}
		}
}

module leadscrew_nuttrap_spacer(){
	translate([zrod_leadscrew_dist/2,0,leadscrew_nuttrap_height/2])
	rotate([0,0,30])
		nut_trap(leadscrew_nut_wrench_size+2*wall,leadscrew_nuttrap_height+2);
}



nema17_hole1 = [nema17_hole_dist/2,nema17_hole_dist/2];
nema17_hole2 = [nema17_hole_dist/2,-nema17_hole_dist/2];
nema17_hole3 = [-nema17_hole_dist/2,nema17_hole_dist/2];
nema17_hole4 = [-nema17_hole_dist/2,-nema17_hole_dist/2];

module motor_mount(){
	difference(){
		union(){
			translate([-nema17_hole_dist/2+motor_mount_x_offset,xmotor_y_offset,
						nema17_hole_dist/2+xend_body_height+m3_screw_dia/2+clearance])
				difference(){
					union(){
						rotate([90,0,0])
							linear_extrude(height=10){
								barbell(nema17_hole3,nema17_hole4,
										(nema17_width-nema17_hole_dist)/2,(nema17_width-nema17_hole_dist)/2,
										20,60);
								barbell(nema17_hole4,nema17_hole2,
										(nema17_width-nema17_hole_dist)/2,(nema17_width-nema17_hole_dist)/2,
										20,60);
							}
		
						// nema17 mount bottom support
						translate([0,-10-(xmotor_y_offset-10-rod_dist/2)/2,
									-xend_body_height/2-nema17_hole_dist/2-m3_screw_dia/2-clearance])
							cube([nema17_width,xmotor_y_offset-10-rod_dist/2,xend_body_height],center=true);
						translate([0,-5,-(xend_body_height+m3_screw_dia/2+clearance)/2-nema17_hole_dist/2])
							difference(){
								cube([nema17_width,10,(xend_body_height+m3_screw_dia/2+clearance)],center=true);

								// round corner bottom x direction
								translate([nema17_width/2,5,-(xend_body_height+m3_screw_dia/2+clearance)/2])
									rotate([0,0,180]) 
										roundcorner_tear(xend_body_height/2,nema17_width);
							}
					}
		
					// nema17 screw holes
					for(k=[1,-1]) for(l=[1,-1])
						translate([k*nema17_hole_dist/2,-5,l*nema17_hole_dist/2])
							rotate([0,0,90]) teardrop(m3_screw_dia/2+clearance,12);
		
					// xend body cut off 1
					translate([0,-(xmotor_y_offset-rod_dist/2)-0.1,-(xend_body_height/2+m3_screw_dia/2+clearance)-nema17_hole_dist/2])
						rotate([180,0,0])
							teardropcentering(xend_body_height/2,nema17_width+2);

					// round corner bottom y direction
					translate([-nema17_width/2,5,-nema17_hole_dist/2-m3_screw_dia/2-clearance-xend_body_height])
						rotate([0,0,-90]) 
							roundcorner_tear(xend_body_height/2,nema17_width);
				}
		
			// nema17 mount top support
			translate([0,0,nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance])
				linear_extrude(height=5)
					polygon(points=[[-xend_body_length/2+xend_body_x_offset,body_width/2+1.5],[-xend_body_length/2+xend_body_x_offset+10,body_width/2+1.5],
										[-nema17_hole_dist+motor_mount_x_offset+5,xmotor_y_offset],
										[-nema17_hole_dist+motor_mount_x_offset-5,xmotor_y_offset]]);

			translate([-nema17_hole_dist+motor_mount_x_offset,-5+xmotor_y_offset,nema17_hole_dist+xend_body_height+m3_screw_dia/2+clearance+(5+m3_screw_head_dia/2+clearance)/2])
				cube([10,10,5+m3_screw_head_dia/2+clearance],center=true);

			difference(){
				union(){
					translate([-body_width/2-zrod_leadscrew_dist/2,0,(nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance+5)/2])
						cube([body_width,body_width+3+2*wall,nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance+5], center=true);
					translate([-zrod_leadscrew_dist/2,0,0])
						cylinder(r=body_width/2+1.5+wall, h=nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance+5);
				}
				translate([-(body_width+1)/2-zrod_leadscrew_dist/2,0,body_length/2])
					cube([body_width+1,body_width+3,body_length+2], center = true);
				translate([-zrod_leadscrew_dist/2,0,-1])
					cylinder(r=body_width/2+1.5, h=body_length+2);
				translate([-body_width-xend_body_length/2+xend_body_x_offset,0,body_length/2])
					cube([2*body_width,body_width+3+2*wall+2,body_length+2], center = true);
				translate([xend_body_x_offset,-xend_body_width/4-wall/2,body_length/2])
					cube([xend_body_length+2,xend_body_width/2,body_length+2], center = true);
			}
		}

		// xend body cut off 2
		translate([-xend_body_length+xend_body_x_offset,rod_dist/2-0.1,xend_body_height])
			cube([xend_body_length,xend_body_height,xend_body_height],center=true);

		// rod clamp freedom
		translate([xend_body_x_offset,0,0])
		difference(){
			cube([xend_body_length-20,xend_body_width+2,xend_body_height],center=true);
			cube([xend_body_length-20-2,xend_body_width,xend_body_height-4],center=true);
		}

		// belt freedom
		translate([(nema17_width-nema17_hole_dist)/2+motor_mount_x_offset,xmotor_y_offset,
					nema17_hole_dist/2+xend_body_height+m3_screw_dia/2+clearance])
			cube([nema17_width,50,22],center=true);
	}
}


module idler_mount(){
	translate([xend_body_x_offset*2,0,0])
	mirror([1,0,0])
	difference(){
		union(){
			translate([0,-idler_y_offset+2.5,0])
				rotate([90,0,0]){
					translate([xend_body_x_offset,idler_elevation,0])
						cylinder(r=m8_washer_dia/2, h=5,center=true);
					translate([0,idler_elevation-xend_body_length/2])
						linear_extrude(height=5,center=true) polygon(points=[[-xend_body_length/2+xend_body_x_offset,m8_washer_dia/2/sin(45)],
															[-xend_body_length/2+xend_body_x_offset,0],
															[-xend_body_length/2+xend_body_x_offset+m8_washer_dia/2/sin(45),0],
															[xend_body_length/2+xend_body_x_offset,xend_body_length-m8_washer_dia/2/sin(45)],
															[xend_body_length/2+xend_body_x_offset,xend_body_length],
															[xend_body_length/2+xend_body_x_offset-m8_washer_dia/2/sin(45),xend_body_length]]);
				}

			// idler mount support top
			difference(){
				translate([xend_body_length/2+xend_body_x_offset-(m8_washer_dia/2/sin(45))/2,-idler_y_offset/2,xend_body_height/2+xend_body_length])
					cube([m8_washer_dia/2/sin(45),idler_y_offset,m8_washer_dia/2/sin(45)],center=true);
				translate([xend_body_x_offset*2,0,0])
					mirror([1,0,0]){
						translate([-(body_width+1)/2-zrod_leadscrew_dist/2,0,body_length/2])
							cube([body_width+1,body_width+3,body_length+2], center = true);
						translate([-zrod_leadscrew_dist/2,0,-1])
							cylinder(r=body_width/2+1.5, h=body_length+2);
					}
			}

			// idler mount support bottom
			translate([-xend_body_length/2+xend_body_x_offset,-idler_y_offset,0])
				cube([m8_washer_dia/2/sin(45),idler_y_offset,idler_elevation-xend_body_length/2+m8_washer_dia/2/sin(45)]);
		}

		// rod clamp freedom
		translate([xend_body_x_offset,0,0])
		difference(){
			cube([xend_body_length-20,xend_body_width+2,xend_body_height],center=true);
			cube([xend_body_length-20-2,xend_body_width,xend_body_height-4],center=true);
		}

		// xend body cut off
		translate([xend_body_x_offset,-rod_dist/2+0.1,xend_body_height/2])
			rotate([180,0,0])
				teardropcentering(xend_body_height/2,xend_body_length+2);

		// round corner bottom x direction
		translate([-xend_body_length/2+xend_body_x_offset,-idler_y_offset,0])
			roundcorner_tear(xend_body_height/2,xend_body_length);

		// idler bolt hole
		translate([xend_body_x_offset,-idler_y_offset+2.5,idler_elevation])
		rotate([0,0,90])
			teardrop(m8_screw_dia/2+clearance,7);

	}

	mirror([0,1,0])
	difference(){
		union(){
			translate([-body_width/2-zrod_leadscrew_dist/2,0,(xend_body_length/2+idler_elevation)/2])
				cube([body_width,body_width+3+2*wall,xend_body_length/2+idler_elevation], center=true);
			translate([-zrod_leadscrew_dist/2,0,0])
				cylinder(r=body_width/2+1.5+wall, h=xend_body_length/2+idler_elevation);
		}
		translate([-(body_width+1)/2-zrod_leadscrew_dist/2,0,body_length/2])
			cube([body_width+1,body_width+3,body_length+2], center = true);
		translate([-zrod_leadscrew_dist/2,0,-1])
			cylinder(r=body_width/2+1.5, h=body_length+2);
		translate([-body_width-xend_body_length/2+xend_body_x_offset,0,body_length/2])
			cube([2*body_width,body_width+3+2*wall+2,body_length+2], center = true);
		translate([xend_body_x_offset,-xend_body_width/4-wall/2,body_length/2])
			cube([xend_body_length+2,xend_body_width/2,body_length+2], center = true);
	}
}



module assembly(idler=false){

	difference(){
		union(){
			translate([xend_body_x_offset,0,xend_body_height/2])
				for(i=[0,1]) mirror([0,i,0]) rod_mount();
	

	
			if(idler==false){
				motor_mount();

				// bearing holder support
				translate([(body_width/2+1.5+wall/2)/2-zrod_leadscrew_dist/2,0,(nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance+5)/2])
					cube([body_width/2+1.5+wall/2,wall,nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance+5],center=true);
			}
			else{
				idler_mount();

				// bearing holder support
				translate([(body_width/2+1.5+wall/2)/2-zrod_leadscrew_dist/2,0,(xend_body_length/2+idler_elevation)/2])
					cube([body_width/2+1.5+wall/2,wall,xend_body_length/2+idler_elevation],center=true);
			}
		}
		bearing_holder_spacer();
		leadscrew_nuttrap_spacer();

		if(idler==false){
			// nema17 screw head/ screw driver clearance
			translate([-nema17_hole_dist/2-2,0,nema17_hole_dist/2+m3_screw_dia/2+clearance+xend_body_height]){
				translate([nema17_hole_dist/2,0,-nema17_hole_dist/2])
					rotate([0,0,90]) teardrop(4,2*(xmotor_y_offset-6));		// extra screw driver shaft clearance 8mm
				translate([nema17_hole_dist/2,0,-nema17_hole_dist/2])
					rotate([0,45,0])
						translate([-2,0,4])
							cube([4,body_width+3+2*wall+2,8],center=true);
				translate([-nema17_hole_dist/2,0,nema17_hole_dist/2]){
					rotate([0,0,90]) teardrop(m3_screw_head_dia/2+clearance,2*(xmotor_y_offset-6));
					rotate([0,0,90]) teardrop(m3_screw_dia/2+clearance,2*(xmotor_y_offset+1));
				}
				translate([-nema17_hole_dist/2,0,-nema17_hole_dist/2])
					rotate([0,0,90]) teardrop(m3_screw_head_dia/2+clearance,2*(xmotor_y_offset-6));
			}
		}
	}
	bearing_holder();
	leadscrew_nuttrap();
}