/* Thingiverse Customizer Settings */

Print_Part = "shell_half"; // [eye_front:Ball Front, eye_back:Ball Back, iris:Iris, plug:Ball Plug, carrier:Electronics Carrier, baffle:Light Baffle, clip:Bearing Clip, bearing:Bearing Ring, shell_half:Shell Half, join:Shell Join, platter:Platter ]
Resolution = "low"; // [low:Low Resolution, high:High Resolution]

/* [Hidden] */

// for animations
animation = ""; // "assemble.1";


// 
cut_front_back = 0.01; 
cut_top_bottom = 0.06;
// shell_inset = 0.032;
// 
shell_inset = 0.022; // very thin shells (double layer)
// shell_inset = 0.04; // thin walls (triple layer) 

square_core_inset = 0.032; // thin walls (triple layer) 
ball_inset = 0.032; // thin walls (triple layer) 


overall_size = 80;
stretch = [1,1.3,1];


ball_size = 0.73;
eyecore_size = 0.5;
ball_resolution = (Resolution=="high") ? 90 : 30;
bearing_resolution = (Resolution=="high") ? 120 : 60; // super-smooth bearing race

back_part =  "top"; //"bottom";
front_part = "bottom"; // "top";
eye_part = false; // [front, back }
iris_part = false;
plug_part = false;
vjoin_part = "hollow"; // top, bottom, insert

// $vpr = [70, 0, sin($t * 180 - 90) * 90 +60 ];


if(animation == "assemble.1") {
	component_opacity = 1; // mix($t, 0.30,0.40, 0,1);
	
	carrier_opacity = mix($t, 0.10,0.20, 0,1);
	bearing_opacity = mix($t, 0.15,0.25, 0,1);	
	plug_opacity = mix($t, 0.20,0.30, 0,1);
	
	eye_back_opacity = mix($t, 0.45,0.55, 0,1);

	join2_opacity = mix($t, 0.60,0.70, 0,1);
	join1_opacity = mix($t, 0.70,0.80, 0,1);

	baffle_opacity = mix($t, 0.65,0.75, 0,1);
	iris_opacity = mix($t, 0.70,0.80, 0,1);
	eye_front_opacity = mix($t, 0.80,0.90, 0,1);
	
	case_1_opacity = mix($t, 0.40,0.50, 0,1);
	case_2_opacity = mix($t, 0.70,0.80, 0,1);
	case_3_opacity = mix($t, 0.85,0.95, 0,1);
	
	spin_index = mix($t, 0.80,0.95, 0,360);
	
	tail_spin = [0, sin(spin_index+90)*45 -45, 0];

	
	if(component_opacity) components(opacity=component_opacity);
	if(baffle_opacity) select_baffle(opacity=baffle_opacity);
	if(carrier_opacity) select_carrier(opacity=carrier_opacity);
	
	if(bearing_opacity) select_clip(opacity=bearing_opacity, center=true);
	if(plug_opacity) rotate(tail_spin) select_plug(opacity=plug_opacity);
	if(iris_opacity) select_iris(opacity=iris_opacity);
		
	if(eye_back_opacity) rotate(tail_spin) select_eye_part(name="back",color="orange",opacity=eye_back_opacity);
	if(eye_front_opacity) select_eye_part(name="front",color="orange",opacity=eye_front_opacity);
		
	if(join1_opacity) select_vjoin_part(name="front",color="orange",opacity=join1_opacity);
	if(join2_opacity) rotate(tail_spin) select_vjoin_part(name="back",color="orange",opacity=join2_opacity);

	
	if(case_1_opacity) rotate(tail_spin) select_shell_part(back_part="bottom",color="yellow",opacity=case_1_opacity);
	if(case_2_opacity) select_shell_part(front_part="bottom",color="yellow",opacity=case_2_opacity);
	if(case_2_opacity) rotate(tail_spin) select_shell_part(back_part="top",color="yellow",opacity=case_2_opacity);
	if(case_3_opacity) select_shell_part(front_part="top",color="yellow",opacity=case_3_opacity);
		
} else if(animation == "assemble.2") {

	neopixel_opacity = mix($t, 0.05,0.30, 0,1);
	neopixel_y       = mix($t, 0.05,0.30, -20,0);
	neopixel_r       = mix($t, 0.20,0.30, 0,-90);
	

	esp_opacity      = mix($t, 0.35,0.45, 0,1);
	esp_y            = mix($t, 0.35,0.60, -30,0);
	esp_r            = mix($t, 0.40,0.45, 0,-90);

	regulator_opacity= mix($t, 0.35,0.45, 0,1);
	regulator_y      = mix($t, 0.35,0.60, -30,0);
	regulator_r      = mix($t, 0.40,0.45, 0,-90);

	servo_opacity    = mix($t, 0.65,0.85, 0,1);
	servo_y          = mix($t, 0.65,0.85, -10,0);
			
	carrier_opacity = 1; // mix($t, 0.40,0.60, 0,1);
	carrier_y       = 0; // mix($t, 0.40,0.60, 20,0);

	
	translate([0,carrier_y,0]) select_carrier(opacity=carrier_opacity);
	
	
	if(neopixel_opacity) translate([0,14.5+neopixel_y,0]) rotate([neopixel_r,0,0]) component_neopixel(opacity=neopixel_opacity);
	if(esp_opacity) translate([16,-4+esp_y,0]) rotate([esp_r,0,90]) component_esp8266(opacity=esp_opacity);
	if(regulator_opacity) translate([-16,0+regulator_y,0]) rotate([regulator_r,0,-90]) component_regulator1(opacity=regulator_opacity);
	// vertical tail servo
	if(servo_opacity) translate([0,-19+servo_y,0]) rotate([90,180,0]) component_servo_generic9g(opacity=servo_opacity);

		
	
		
} else if(animation == "assemble.3") {
	baffle_opacity    = mix($t, 0.05,0.15, 0,1);
	baffle_y          = mix($t, 0.05,0.20, 20,0);
	
	iris_opacity      = mix($t, 0.10,0.20, 0,1);
	iris_y            = mix($t, 0.10,0.25, 20,0);
	iris_r            = mix($t, 0.90,0.95, 0.5,0.5);
	iris_g            = mix($t, 0.90,0.95, 0.5,0.7);
	iris_b            = mix($t, 0.90,0.95, 0.5,0.9);
	
	clip_opacity      = mix($t, 0.30,0.40, 0,1);
	bearing_opacity   = mix($t, 0.40,0.50, 0,1);

	plug_opacity      = mix($t, 0.50,0.60, 0,1);
	
	eye_back_opacity  = mix($t, 0.55,0.65, 0,1);
	eye_back_y        = mix($t, 0.70,0.90 , -40,-1);

	eye_front_opacity = mix($t, 0.60,0.70, 0,1);
	eye_front_y       = mix($t, 0.60,0.70, 5,0);

	eye_front_half_y       = mix($t, 0.70,0.90, 40,0);

	
	// carrier & components
	select_carrier(opacity=1);
	components(opacity=1);

	if(plug_opacity) translate([0,eye_back_y,0]) select_plug(opacity=plug_opacity,color=[0.2,0.2,0.2]);
	if(baffle_opacity) translate([0,baffle_y,0]) select_baffle(opacity=baffle_opacity,color=[iris_r,iris_g,iris_b]);
	if(iris_opacity) translate([0,iris_y,0]) select_iris(opacity=iris_opacity);
		
	if(eye_back_opacity) translate([0,eye_back_y,0]) select_eye_part(name="back",color=[0.2,0.2,0.2],opacity=eye_back_opacity);
	translate([0,eye_front_half_y,0])  {
		rotate([0,$t*360,0]) translate([0,3.5,0]) select_clip(opacity=clip_opacity, center=false);
		tolerance = 0.002;
		translate([0,0,0]) rotate([90,0,0]) color("gold",bearing_opacity) render() scale(overall_size) bearing_ring(od1=bearing_outer - tolerance, od2=bearing_outer-0.02- tolerance);
		if(eye_front_opacity) translate([0,eye_front_y,0]) select_eye_part(name="front",color=[0.2,0.2,0.2],opacity=eye_front_opacity);
	}
	
} else if(animation == "assemble.4") {

	back_lower_op = 1; 
	join1_op = mix($t, 0.05,0.15, 0,1);
	join1_z  = mix($t, 0.05,0.20, 20,0);
	back_upper_op = mix($t, 0.10,0.20, 0,1);
	back_upper_z = mix($t, 0.10,0.25, 20,0);

	ball_op = mix($t, 0.30,0.50, 0,1);
	ball_y  = mix($t, 0.30,0.60, 20,0);

	front_op = mix($t, 0.60,0.70, 0,1);
	front_y  = mix($t, 0.60,0.80, 20,0);


	spin_index = mix($t, 0.80,0.95, 0,180);
	
	tail_spin = [0, sin(spin_index+90)*45/2 -45/2, 0];
	rotate(tail_spin) {
		if(back_lower_op) translate([0,0,0]) { 
			select_shell_part(back_part="bottom",color="silver",opacity=back_lower_op);
		}
		if(join1_op) translate([0,0,join1_z]) { 
			select_vjoin_part(name="back",color=[0.2,0.2,0.2],opacity=join1_op);
		}
		if(back_upper_op) translate([0,0,back_upper_z])  { 
			select_shell_part(back_part="top",color="silver",opacity=back_upper_op);
		}
	}
	if(ball_op) translate([0,ball_y,0]) { 
		rotate(tail_spin) {
			select_plug(opacity=ball_op);
			select_eye_part(name="back",color=[0.2,0.2,0.2],opacity=ball_op);
		}
		components(opacity=ball_op);
		select_baffle(opacity=ball_op,color=[0.6,0.7,0.96]);
		select_carrier(opacity=ball_op);
		select_clip(opacity=ball_op, center=true);
		select_iris(opacity=ball_op);
		select_eye_part(name="front",color=[0.2,0.2,0.2],opacity=ball_op);
	}
	if(front_op) translate([0,front_y,0]) { 
		select_vjoin_part(name="front",color=[0.2,0.2,0.2],opacity=front_op);
		select_shell_part(front_part=true,color="silver",opacity=front_op);
	}
	
		/*	
	if(eye_back_opacity) rotate(tail_spin) select_eye_part(name="back",color="orange",opacity=eye_back_opacity);
	if(eye_front_opacity) 
		
	if(join1_opacity) 
	if(join2_opacity) rotate(tail_spin) 

	
	if(case_1_opacity) rotate(tail_spin) 
	if(case_2_opacity) 
	if(case_2_opacity) rotate(tail_spin) select_shell_part(back_part="top",color="yellow",opacity=case_2_opacity);
	if(case_3_opacity) select_shell_part(front_part="top",color="yellow",opacity=case_3_opacity);
			*/
/*
} else if(Print_Part == "bearing") {

	*/	
} else if(Print_Part == "platter") {
	
	translate([-95,22,overall_size * cut_top_bottom/2]) rotate([0,180,180]) select_vjoin_part(name="hollow",color="orange",opacity=1);
	
	translate([0,0,-0.25]) rotate([90,0,180]) select_shell_part(front_part="top",back_part=false,color="yellow",opacity=1);
	
	translate([0,-10,0]) rotate([90,0,0]) select_eye_part(name="front",color="orange",opacity=1);
	translate([-40,-60,0]) rotate([-90,0,0]) select_eye_part(name="back",color="orange",opacity=1);
	
	translate([50,-15,-21.5]) rotate([90,0,0]) select_iris();
	translate([90,-15,-20.3]) rotate([-90,0,0]) select_plug();
	translate([90,-60,+15.8]) rotate([-90,0,0]) select_carrier();
	
	translate([40,-60,-15.7]) rotate([90,0,0]) select_baffle();
	translate([40,-60,0]) rotate([-90,0,0]) select_clip(opacity=1, center=false);
	
	
} else if(Print_Part == "shell_half") {
	rotate([90,0,180])select_shell_part(front_part="top",back_part=false,color="yellow",opacity=1);
} else if(Print_Part == "eye_front") {
	rotate([90,0,0]) select_eye_part(name="front");
} else if(Print_Part == "eye_back") {
	rotate([-90,0,0]) select_eye_part(name="back");
} else if(Print_Part == "join") {
	select_vjoin_part(name="hollow",color="orange",opacity=1);
} else if(Print_Part == "iris") {
	rotate([90,0,0]) select_iris();
} else if(Print_Part == "plug") {
	rotate([-90,0,0]) select_plug();
} else if(Print_Part == "carrier") {
	rotate([-90,0,0]) select_carrier();
} else if(Print_Part == "baffle") {
	rotate([90,0,0]) select_baffle();
} else if(Print_Part == "clip") {
	rotate([-90,0,0]) select_clip(opacity=1, center=false);
} else if(Print_Part == "bearing") {
	tolerance = 0.002;
	render() scale(overall_size) bearing_ring(od1=bearing_outer - tolerance, od2=bearing_outer-0.02- tolerance);
} else {
	// design development
	if(true) {
		components();

		//select_clip(center=true);
		//select_iris(name=iris_part, opacity=1);
		//select_plug(name=plug_part, opacity=0.8);

		//select_baffle(name=eye_part,color="grey",opacity=1);
		// select_carrier(name=eye_part,color="blue",opacity=1);

		//select_eye_part(name="back",color="orange",opacity=0.8);
		//select_eye_part(name="front",color="orange",opacity=1);
		
		//select_vjoin_part(name=vjoin_part,color="orange",opacity=1);
		intersection() {
			// select_shell_part(front_part="bottom",back_part="bottom",opacity=1);
			scale(overall_size) ghost_shell_1();
			translate([0,0,0]) cube([20,200,200],center=true);
		}
		// select_shell_part(front_part="bottom",back_part="bottom",opacity=0.5);
		// scale(overall_size) spike_slots(d=0.02);
	}
	if(false) render() difference() {
		union() {
			select_clip(center=true);
			select_eye_part(name="back",color="orange");
			select_eye_part(name="front",color="orange");
		}
		translate([0,0,0]) cube([200,200,10],center=true);
	}
}

module select_iris(name="",color=[0.1,0.1,0.1],opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		ghost_iris();
	}
}

module select_plug(name="",color=[0.2,0.2,0.2],opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		ghost_rear_plug();
	}
}

module select_baffle(name="",color="grey",opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		ghost_iris_baffle();
	}
}

module select_carrier(name="",color="gold",opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		ghost_components_carrier();
	}
}

module select_clip(name="",color="orange",center=false,opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		translate(center ? [0,0.05,0] : [0,0,0]) rotate([90,0,0]) bearing_clip();
	}
}


module select_vjoin_part(name="",color="orange",opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		if(name=="hollow") {
			ghost_hollow_join();
		} else if(name == "top") {
			difference() {
				ghost_hollow_join();
				translate([0,0,-1]) cube([2,2,2],center=true);
			}
		} else if(name == "bottom") {
			difference() {
				ghost_hollow_join();
				translate([0,0,1]) cube([2,2,2],center=true);
			}
		} else if(name == "front") {
			difference() {
				ghost_vertical_join_parts();
				translate([0,-1,0]) cube([2,2,2],center=true);
			}
		} else if(name == "back") {
			difference() {
				ghost_vertical_join_parts();
				translate([0,1,0]) cube([2,2,2],center=true);
			}
		} else if(name == "insert") {
			ghost_join_insert();
		} else {
			ghost_vertical_join_parts();
		}
	}
}

module select_eye_part(name="",color="orange",opacity=1) {
	color(color,opacity) render() scale(overall_size)  {
		difference() {
			ghost_eye();
			if(name == "front") {
				translate([0,-1,0]) cube([2,2,2],center=true);
			}
			if(name == "back") {
				translate([0,1,0]) cube([2,2,2],center=true);
				translate([0,0,0]) rotate([90,0,0]) bearing_ring_seat(od1=bearing_outer, od2=bearing_outer-0.02 );
			}
		}
		if(name == "front") {
			translate([0,0,0]) rotate([-90,0,0]) bearing_ring();
			ghost_eye_lockpins();
		} else if(name == "back") {
			// add the flange
			translate([0,0,0]) rotate([90,0,0]) bearing_flange(id=bearing_outer);
			
		}
	}
}

module select_shell_part(front_part="",back_part="",color="orange",opacity=1) {
	color(color,opacity) render() scale(overall_size) {
		if(front_part) {
			difference() {
				ghost_shell_1(opacity=1);
				translate([0,-1,0]) cube([2,2,2],center=true);
				if(front_part == "top") {
					translate([0,0,-1]) cube([2,2,2],center=true);
				}
				if(front_part == "bottom") {
					translate([0,0,1]) cube([2,2,2],center=true);
				}
			}
		}
		if(back_part) {
			difference() {
				ghost_shell_1(opacity=1);
				translate([0,1,0]) cube([2,2,2],center=true);
				if(back_part == "top") {
					translate([0,0,-1]) cube([2,2,2],center=true);
				}
				if(back_part == "bottom") {
					translate([0,0,1]) cube([2,2,2],center=true);
				}
			}
		}
	}
}


stand_base_size = [30,120,30];

module stand_base_shape(inset = 0.0) {
	// tilted
}

module stand_base() {
	
}

stand_base();


bearing_flange = 0.75;
bearing_outer = 0.70;
bearing_inner = bearing_outer - 0.08;
bearing_clip_engage = bearing_inner + 0.03;
bearing_clip_outer = bearing_inner - 0.01;
bearing_clip_inner = bearing_clip_outer - 0.04;


module bearing_clip(id=bearing_clip_inner, od=bearing_clip_outer, oh=0.1, clip_d=bearing_clip_engage-0.005, clip_h1=0.01, clip_h2=0.02, clip_width=0.2) {
	difference() {
		// main race
		cylinder(d=od, h=oh, $fn=bearing_resolution);
		// inner space
		translate([0,0,-0.5]) cylinder(d=id, h=1+oh, $fn=bearing_resolution);
	}
	intersection() {
		// clips
		union() {
			// long rectangles in x and y of the clip width
			cube([2,clip_width,1],center=true);
			cube([clip_width,2,1],center=true);
		}
		difference() {
			union() {
				// top edge
				translate([0,0,oh - clip_h1])   cylinder(d=clip_d, h=clip_h1, $fn=bearing_resolution);
				translate([0,0,oh - clip_h1 - clip_h2]) cylinder(d1=od, d2=clip_d, h=clip_h2, $fn=bearing_resolution);
				// bottom
				translate([0,0,0 + clip_h1])    cylinder(d1=clip_d, d2=od, h=clip_h2, $fn=bearing_resolution);
				translate([0,0,0 ])            cylinder(d=clip_d, h=clip_h1, $fn=bearing_resolution);
			}
			// inner race
			translate([0,0,-0.5]) cylinder(d=id, h=1+oh, $fn=bearing_resolution);
		}
	}
}

module bearing_ring(id=bearing_inner, od1=bearing_outer, od2=bearing_outer, oh=0.05, clip_d=bearing_clip_engage, clip_h1=0.01, clip_h2=0.02, flange_d=bearing_flange, flange_h=0.005) {
	difference() {
		union() {
			// main race - use ball resolution since that's what we interface to.
			cylinder(d1=od1, d2=od2, h=oh, $fn=ball_resolution);
			// seat flange
			cylinder(d=flange_d, h=flange_h, $fn=ball_resolution);
		}
		// inner space
		translate([0,0,-0.5]) cylinder(d=id, h=1+oh, $fn=bearing_resolution);
		// top edge
		translate([0,0,oh - clip_h1])   cylinder(d=clip_d, h=clip_h1+1, $fn=bearing_resolution);
		translate([0,0,oh - clip_h1 - clip_h2]) cylinder(d2=clip_d, d1=id, h=clip_h2, $fn=bearing_resolution);
	}	
}

module bearing_ring_seat(tolerance = 0.002, id=bearing_inner, od1=bearing_outer, od2=bearing_outer, oh=0.05, clip_d=bearing_clip_engage, clip_h1=0.01, clip_h2=0.02, flange_d=bearing_flange, flange_h=0.005) {
	difference() {
		union() {
			// main race - use ball resolution since that's what we interface to.
			cylinder(d1=od1+ tolerance, d2=od2+ tolerance, h=oh, $fn=ball_resolution);
			// seat flange
			translate([0,0,-tolerance]) cylinder(d=flange_d, h=flange_h, $fn=ball_resolution);
		}
	}	
}

module bearing_flange(id=bearing_inner, flange_d=bearing_flange, flange_h=0.005,tolerance = 0.0) {
	difference() {
		// seat flange
		translate([0,0,-tolerance]) cylinder(d=flange_d, h=flange_h, $fn=ball_resolution);
		// inner space
		translate([0,0,-0.5]) cylinder(d=id, h=1+flange_h, $fn=bearing_resolution);
	}
	
}


module tetrahedron_base(ends_size=0.1,inset=0 ) {
	rotations = [ [0,0,60,0], [0,0,-60,60], [120,0,0,30], [-120,0,0,-30] ];
	hull() {
		for(index = [0:3] ) {
			rot = rotations[index];
			rotate([ rot[0], rot[1], rot[2] ]) {
				translate([0,-1 + ends_size*sqrt(2)/2 + inset, 0] ) 
					rotate([-90,0,0]) linear_extrude(height=0.1,scale=1) rotate(rot[3]) circle(d=ends_size,$fn=3);
			}
		}
	}
}

module tetrahedron_cuts(cuts=[0.5, 0.5, 0.5, 0.5]) {
	rotations = [ [0,0,60,0], [0,0,-60,60], [120,0,0,30], [-120,0,0,-30] ];
	for(index = [0:3] ) {
		rot = rotations[index];
		rotate([ rot[0], rot[1], rot[2] ]) {
			translate([0,-1-cuts[index],0]) cube([2,1,2],center=true);
		}
	}
}

module chamfered_box(cuts=[0.1, 0.1, 0.1, 0.1]) {
	positions = [ [0.5,0.5], [0.5,-0.5], [-0.5,-0.5], [-0.5,0.5] ];
	hull() for(index = [0:3] ) {
		cut = cuts[index] ;
		pos = positions[index];
		px = pos[0] - pos[0]*cut* sqrt(2)/2;
		py = pos[1] - pos[1]*cut* sqrt(2)/2;
		translate([px,py,0]) rotate([0,0,45]) cube([cut,cut,1],center=true);
	}
}

module ghost_shell_base_shape( ball=ball_size, eye_core=0.5, inset=0, cut_fb=0, cut_tb=0) {
	ti = inset / 2;
	difference() {
		// stretched tetrahedrons
		scale(stretch) union() {
			difference() {
				tetrahedron_base(ends_size=0.025,inset=inset);
				tetrahedron_cuts(cuts=[0.38-ti, 0.38-ti, 0.33-ti, 0.33-ti]);
			}
			rotate([0,0,180]) difference() {
				tetrahedron_base(ends_size=0.025,inset=inset);
				tetrahedron_cuts(cuts=[0.38-ti, 0.38-ti, 0.33-ti, 0.33-ti]);
			}
		}
		// eye square core
		scale(stretch) rotate([0,45,0]) scale([eye_core,2,eye_core]) rotate([90,0,0]) 
			chamfered_box(cuts=[0.05, 0.05, 0.05, 0.05]);
		// eye ball space
		if(ball >0) {
			ghost_eyeball(d=ball);
		}
		// vertical cut to seperate front & back
		if(cut_fb >0) {
			cube([2,cut_fb,2],center=true);
		}
		// horizonal cut to seperate top & bottom
		if(cut_tb >0) {
			cube([2,2,cut_tb],center=true);
		}
	}
}

module ghost_shell_outer() {
	ghost_shell_base_shape( 
		ball=ball_size, 
		eye_core=eyecore_size, 
		inset=0, 
		cut_fb=cut_front_back, 
		cut_tb=cut_top_bottom
	);
}

module ghost_shell_inner(inset=shell_inset) {
	ghost_shell_base_shape( 
		ball=ball_size + ball_inset/2 , 
		eye_core=eyecore_size  + square_core_inset, 
		inset=inset, 
		cut_fb=cut_front_back + square_core_inset, 
		cut_tb=cut_top_bottom + square_core_inset
	);
}

module ghost_shell_base(ball=ball_size, eye_core=0.5, inset=shell_inset, cut_fb=cut_front_back, cut_tb=cut_top_bottom ) {
	difference() {
		ghost_shell_outer();
		if(inset>0) {
			ghost_shell_inner();
		}
	}
}


module detail_slots(d=0.02,h=0.12) {
	for(mx=[0,1]) mirror([mx,0,0])  
		for(my=[0,1]) mirror([0,my,0])  
			for(mz=[0,1]) mirror([0,0,mz]) 
				hull() {
					translate([0.28,0.32,-0.28]) rotate([45,-45,0]) cylinder(d=d,h=h,center=true,$fn=12);
					translate([0.36,0.20,-0.36]) rotate([45,-45,0]) cylinder(d=d,h=h,center=true,$fn=12);
				}
}

module detail_slot_supports(d=0.08) {
	for(mx=[0,1]) mirror([mx,0,0])  
		for(my=[0,1]) mirror([0,my,0])  
			for(mz=[0,1]) mirror([0,0,mz]) 
				hull() {
					translate([0.28,0.32,-0.28]) rotate([45,-45,0]) translate([0,0,0.03]) sphere(d=d,$fn=24);
					translate([0.36,0.20,-0.36]) rotate([45,-45,0]) translate([0,0,0.03]) sphere(d=d,$fn=24);
				}
}

module spike_slots(d=0.06,h=0.1) {
	for(my=[0,1]) mirror([0,my,0])  
		for(mz=[0,1]) mirror([0,0,mz]) {
			/* hull() {
					translate([-0.05,0.41,-0.71]) sphere(d=d,$fn=12);
					translate([0.05,0.41,-0.71]) sphere(d=d,$fn=12);
			} */
			for(mx=[0,1]) mirror([mx,0,0])
				hull() {
						translate([-0.105,0.50,-0.67]) sphere(d=d,$fn=12);
						translate([-0.058,0.57,-0.64]) sphere(d=d,$fn=12);
				}
			}
}


module ghost_shell_1(inset=shell_inset) {
	difference() {
		union() {
			difference() {
				// start with the base
				ghost_shell_base(ball=ball_size, inset=inset);
				// hexagonal ports on joiner surface
				for(m1=[[0,0],[1,0]]) mirror(m1) for(m2=[[0,0],[0,1]]) mirror(m2)
						translate([0.45,0.34,0]) scale([0.6,1.6,1]) rotate([0,0,30]) cylinder(h=cut_top_bottom+shell_inset*2, d=0.25, center=true, $fn=6);
			}
			// reinforce parts of the shell
			intersection() {
				union() {
					// reinforce parts that have slots cut out
					detail_slot_supports();
					spike_slots(d=0.04);
					// add a partition down the centerline
					difference() {
						cube([0.010,2,2],center=true);
						// hexagonal ports on joiner surface
						//for(m1=[[0,0,0],[0,1,0]]) mirror(m1) for(m2=[[0,0,0],[0,0,1]]) mirror(m2)
						//		rotate([0,90,0]) translate([0.45,0.34,0]) scale([0.6,1.6,1]) rotate([0,0,30]) cylinder(h=cut_top_bottom+shell_inset*2, d=0.25, center=true, $fn=6);
					}
					// and smaller angled partitions
					rotate([90,0,0]) for(m1=[[0,0,0],[0,1,0]]) mirror(m1) for(m2=[[0,0,0],[0,0,1]]) mirror(m2)
						rotate([0,0,45]) hull() {
							translate([0.5,0,0.5]) cube([0.2,0.010,0.2],center=true);
							translate([-0.5,0,-0.5]) cube([0.2,0.010,0.2],center=true);
						}
					
				}
				ghost_shell_inner();
			}
		}
		// cut detail slots
		detail_slots();
		spike_slots(d=0.02);
	}
}

module ghost_vertical_join_profile(ball=0, inset=0.0, cut_fb=cut_front_back) {
	faces = [ [-41,0.32], [30,0.86], [90,0.46], [180,-0.35], [270,0.0] ];
	// just one corner
	difference() {
		scale(stretch) square([1,1]);
		// now start slicing off faces
		scale(stretch) for( i = [0:4] ) {
			f = faces[i];
			rotate([0,0,f[0]])  translate([1+f[1]-inset,0,0]) square([2,2],center=true);
		}
		// eyeball space
		if(ball>0) circle(d=ball, $fn=ball_resolution, center=true);
		// vertical cut to seperate front & back
		square([2,cut_fb],center=true);
	}
}

module ghost_vertical_join(height=0.06, ball=0, inset=0.0) {
	translate([0,0,-height/2]) {
		linear_extrude(height=height) ghost_vertical_join_profile(ball=ball, inset=inset);
	}
}


// hollow out the vertical join
module ghost_hollow_join(height=cut_top_bottom, ball=ball_size, inset=shell_inset + 0.01, join_inset=0.03) {
	difference() {
		ghost_vertical_join(height=0.06, ball=ball, inset=0.0);
		ghost_vertical_join(height=0.06 + inset, ball=ball, inset=join_inset );
	}
}


module ghost_vertical_join_parts() {
	// mirrors
	for( s = [ [0,0], [1,0], [0,1], [1,1] ]) mirror([s[0],0,0]) mirror([0,s[1],0]) {
		ghost_hollow_join();
	}
}

module ghost_eye_lockpins(
	inset = 0, // contract
	ball=ball_size, // how big is the eyeball
	nub_pos=[0,0.24,-0.40], // where is the prototype nub positioned
	nub_size=[0.16,0.4,0.25] // big is the prototype nub
) {
	box_size = nub_size - [inset,inset,inset];
	scale(ball) intersection() {
		// rotated copies of the lock pins
		for(i=[0,90,180,270]) rotate([0,i,0])
			translate(nub_pos) difference() {
				cube(box_size,center=true);
				translate([0,-box_size[2],0]) rotate([45,0,0]) 
					cube(box_size + [1,1,0], center=true);				
			}
		// limited to the eye sphere
		ghost_eyeball(d=1);
		
	}
}


module ghost_iris_baffle(ball=ball_size,e=0.002) {
	scale(ball) difference() {
		union() {
			// registration lip
			intersection() {
				// flat circular face
				translate([0,0.32,0]) rotate([90,0,0]) cylinder(d=0.65,h=0.1,center=true,$fn=ball_resolution);
				// hollow eye sphere
				ghost_eyeball(d=0.95);
			}
		}
		// center circle
		translate([0,0.5,0]) rotate([90,0,0]) cylinder(d=0.07,h=0.5,$fn=ball_resolution);
		// stepped light baffle
		for(i=[0:4]) {
			translate([0,0.47 + i*0.01,0]) rotate([90,0,0]) cylinder(d=0.10 + 0.10*i,h=0.2,$fn=ball_resolution);
		}
		// register against the lock pins
		ghost_eye_lockpins(ball=1.0, inset=-0.02);
	}
}

// color("red",0.1) rotate([90,0,0]) cylinder(d=46,h=100,$fn=40,center=true);

module ghost_components_carrier(ball=ball_size,e=0.002) {
	scale(ball) difference() {
		// registration lip
		intersection() {
			union() {
				// outer ring
				difference() {
					translate([0,0.26,0]) rotate([90,0,0]) cylinder(d=0.75,h=0.02,center=true,$fn=ball_resolution);
					translate([0,0.20,0]) rotate([90,0,0]) cylinder(d=0.6,h=1,center=true,$fn=ball_resolution);
				}
				// flat bands to registration pins
				translate([0,0.26,0]) cube([0.30, 0.02, 0.68],center=true);
				translate([0,0.26,0]) cube([0.68, 0.02, 0.26],center=true);
				intersection() {
					union() {
						// lower locking post
						translate([0,0.05,-0.30]) cube([0.3, 0.44, 0.3],center=true); 
						// middle locking posts
						translate([+0.35,0.06,0.0]) cube([0.1, 0.42, 0.25],center=true); 
						translate([-0.35,0.06,0.0]) cube([0.1, 0.42, 0.25],center=true); 
						// upper locking block
						translate([0,0.21,0.35]) cube([0.26, 0.12, 0.1],center=true); 
					}
					// cored profile
					rotate([90,0,0]) cylinder(d=0.71,h=1,center=true,$fn=ball_resolution);
				}
				// thicker outer ring
				difference() {
					translate([0,0.20,0]) rotate([90,0,0]) cylinder(d=0.71,h=0.1,center=true,$fn=ball_resolution);
					translate([0,0.20,0]) rotate([90,0,0]) cylinder(d=0.66,h=1,center=true,$fn=ball_resolution);
					// translate([0,0,1]) cube([2, 2, 2],center=true); 
				}
			}
			// hollow eye sphere
			ghost_eyeball(d=0.95);
		}
		// center square
		translate([0,0.5,0]) rotate([90,45,0]) cylinder(d=0.14,h=0.5,$fn=4);
		// register against the lock pins
		ghost_eye_lockpins(ball=1.0, inset=-0.01);
		// remove servo space
		translate([0,-0.06,-0.20]) cube([0.22, 0.4, 0.18],center=true);
	}
}

module ghost_eyeball(d=1) {
	// main eye sphere
	rotate([90,0,0]) sphere(d=d,$fn=ball_resolution);
}

// add 'connector rings' at octahedral points
module eye_docking_rings() {
	for(m=[ [0,0,0], [0,1,0] ] ) mirror(m) {
			for(r=[ [60,0,0], [-60,0,0], [0,0,60], [0,0,-60], ] ) rotate(r) {
				// make a torus
				translate([0,-0.484,0]) rotate([90,0,0]) rotate_extrude($fn=24) translate([0.1,0,0]) circle(d=0.04, $fn=12);
				// and a smaller one
				translate([0,-0.49,0]) rotate([90,0,0]) rotate_extrude($fn=24) translate([0.05,0,0]) circle(d=0.03, $fn=12);
			}
		}
}

module ghost_eye(ball=ball_size) {
	scale(ball) union() {
		difference() {
			// main eye sphere
			ghost_eyeball(d=1);
			// hollow out sphere 
			ghost_eyeball(d=0.95);
			// circular eye hole
			translate([0,0.90,0]) rotate([90,0,0]) cylinder(d=0.5,height=0.2,center=true,$fn=ball_resolution);
			// front circular flat
			translate([0,0.92,0]) rotate([90,0,0]) cylinder(d=1,height=0.2,center=true,$fn=ball_resolution);
			// back port
			translate([0,-0.5,0]) rotate([90,0,0]) cylinder(d=0.5,height=0.5,$fn=ball_resolution,center=true);
			// back circular flat
			translate([0,-0.92,0]) rotate([90,0,0]) cylinder(d=1,height=0.2,center=true,$fn=ball_resolution);
		}
	}
	// add 'connector rings' at octahedral points
	difference() {
		scale(ball) eye_docking_rings();
		// remove intersections with the outer shell
		ghost_shell_outer();
	}
}


module ghost_iris(ball=ball_size,e=0.002) {
	scale(ball) difference() {
		union() {
			// registration lip
			intersection() {
				// flat circular face
				translate([0,0.42,0]) rotate([90,0,0]) cylinder(d=0.6,h=0.1,center=true,$fn=ball_resolution);
				// main eye sphere
				ghost_eyeball(d=0.95);
			}
			// eye insert ring
			translate([0,0.43,0]) rotate([90,0,0]) cylinder(d=0.5-e,h=0.05,$fn=ball_resolution);
		}
		// flat face indent
		translate([0,0.45,0]) rotate([90,0,0]) cylinder(d=0.45,h=0.1,center=true,$fn=ball_resolution);
		// eye chevrons
		difference() {
			// eye square core
			translate([0,0.5,0]) rotate([0,45,0]) scale([0.25,1,0.25]) rotate([90,0,0]) chamfered_box(cuts=[0.2, 0.2, 0.2, 0.2]);
			// vertical line
			cube([0.04,1,1],center=true);
			// eye square core
			translate([0,0.5,0]) rotate([0,45,0]) scale([0.12,1,0.12]) rotate([90,0,0]) chamfered_box(cuts=[0.2, 0.2, 0.2, 0.2]);
		}
		// center circle
		translate([0,0.5,0]) rotate([90,0,0]) cylinder(d=0.07,h=0.5,$fn=ball_resolution);
		// register against the lock pins
		ghost_eye_lockpins(ball=1.0, inset=-0.01);
	}
}


module ghost_rear_plug(ball=ball_size,e=0.004) {
	scale(ball) difference() {
		union() {
			// registration lip
			intersection() {
				// flat circular face
				translate([0,-0.40,0]) rotate([90,0,0]) cylinder(d=0.58,h=0.1,center=true,$fn=ball_resolution);
				// main eye sphere
				ghost_eyeball(d=0.95);
			}
			// fitted plug
			intersection() {
				translate([0,-0.38,0]) rotate([90,0,0]) cylinder(d1=0.5,d2=0.5-e,h=0.14,$fn=ball_resolution);
				// oversized eye sphere
				ghost_eyeball(d=0.99);
			}
		}
		// screw head indent
		hull() {
			translate([+0.13,-0.5,0]) rotate([90,0,0]) cylinder(d1=0.08,d2=0.12,h=0.15,center=true,$fn=ball_resolution);
			translate([-0.13,-0.5,0]) rotate([90,0,0]) cylinder(d1=0.08,d2=0.12,h=0.15,center=true,$fn=ball_resolution);
		}
		// servo screw center hole
		translate([0,-0.22,0]) rotate([90,0,0]) cylinder(d1=0.08,d2=0.08,h=0.2,$fn=ball_resolution);
	}
}


/*
	Electronics components 
*/

module components() {
	translate([0,14.5,0]) rotate([-90,0,0]) component_neopixel();
	translate([16,-4,0]) rotate([-90,0,90]) component_esp8266();
	translate([-16,0,0]) rotate([-90,0,-90]) component_regulator1();
	// vertical tail servo
	translate([0,-19,0]) rotate([90,180,0]) component_servo_generic9g();
	// horizontal tail servo
	//translate([0,-20,0]) rotate([90,90,0]) component_servo_generic9g();
	// body servo
	//translate([0,0,-33tail]) rotate([180,0,0]) component_servo_generic9g();

	// battery in base
	// translate([0,0,-100]) rotate([0,90,90]) component_battery();

}

module component_battery() {
    color("blue") cylinder(d=19,h=65,center=true); // battery round
}


module component_esp8266(opacity=1) {
    color([0.2,0.4,0.2],opacity) translate([0,0,-1])    cube([25,17,0.5],center=true);
    color("grey",opacity) translate([4,0,0])    cube([15,11,2],center=true);
}


module component_regulator1(opacity=1) {
    color([0.2,0.4,0.2],opacity) translate([0,0,-1])    cube([25,12,0.5],center=true);
    color("grey",opacity) translate([4,0,0])    cube([5,8,2],center=true);
}


module component_neopixel(opacity=1) {
    color([0.2,0.4,0.2],opacity) translate([0,0,0])    cube([15,10,0.5],center=true);
    color("white",opacity) translate([0,0,0.5])    cube([5,5,1],center=true);
}

/* models a generic servo with the spline 'base' at 0,0,0 and facing upwards, 
   so the useable spline protrudes into positive Z space, and the body remain below the origin */
module component_servo_generic(
	body_size = [10,20,10], // [xsize, ysize, zsize]
	spline_size =[5,3], // [height, radius]
	spline_offset =[5.5,5], // [x,y] offset of the spline on the body face
	spline_support = [3,10], // [height, radius] size of the spline support post
	flange_size = [10,30,2], // [xsize, ysize, zsize] // size of the mounting flage
	flange_offset = [0,-5,-2], // [x, y, z] // offset of the flange from the body
	mounting_holes = [ [0,13,3], [0,-13,3] ], // [x, y, radius] mounting holes
	angle=0,
	opacity=1,
) {
	curve_resolution = 30;
	// servo spline, rendered as a bunch of triangular teeth
    color("silver",opacity) {
        for(i=[0:6]) rotate([0,0,i*20]) cylinder(h=spline_size[0],d=spline_size[1],$fn=3);
	}
	color("gray",opacity) {
		// main servo body
		translate([0-spline_offset[0],0-spline_offset[1],0-body_size[2]-spline_support[0]]) 
			cube(body_size);
		// support flange with holes
		difference() {
			translate(flange_offset + [0-spline_offset[0],0-spline_offset[1],0-spline_support[0]]) 
				cube(flange_size);
		}
		// spline support
		translate([0,0,0-spline_support[0]]) 
			cylinder(h=spline_support[0],d=spline_support[1],$fn=curve_resolution);
	}
}

module component_servohorn_generic(angle=0) {	
    // servo horn
    color("white") translate([10,0,4]) rotate([angle,0,0]) {
        difference() {
            union() {
                difference() {
                    translate([1,0,0]) rotate([0,90,0]) cylinder(h=2,d=4,center=true,$fn=30);
                    translate([0,0,0]) rotate([0,90,0]) cylinder(h=2,d=2.5,center=true,$fn=30);
                }
                translate([1.5,-2.5,0]) cube([1,8,2],center=true);
                translate([1.5,-6.5,0]) rotate([0,90,0]) cylinder(h=1,d=2,center=true,$fn=30);
            }
            // holes
            translate([1,0,0]) rotate([0,90,0]) cylinder(h=4,d=0.8,center=true,$fn=30);
            translate([1,-5,0]) rotate([0,90,0]) cylinder(h=4,d=0.5,center=true,$fn=30);
            translate([1,-6,0]) rotate([0,90,0]) cylinder(h=4,d=0.5,center=true,$fn=30);
        }
    }
}

module component_servo_generic9g(angle=0,opacity=1) {
	component_servo_generic(
		body_size      = [12,22,21], // [xsize, ysize, zsize]
		spline_size    =[5,5], // [height, radius]
		spline_offset  =[6,6], // [x,y] offset of the spline on the body face
		spline_support = [6,12], // [height, radius] size of the spline support post
		flange_size    = [12,33,2], // [xsize, ysize, zsize] // size of the mounting flage
		flange_offset  = [0,-6,-3], // [x, y, z] // offset of the flange from the body
		mounting_holes = [ [0,8.5,2], [0,-8.5,2] ], // [x, y, radius] mounting holes
		angle          = angle,
		opacity        = opacity
	);
}

module component_servo_hk5330(angle=0) {
    // servo body
    color("silver") {
        translate([0,0,0]) cube([15,6,13],center=true);
        translate([8,0,4]) rotate([0,90,0]) cylinder(h=2,d=3.5,center=true,$fn=30);
        difference() {
            translate([8,0,4]) rotate([0,90,0]) cylinder(h=5,d=3,center=true,$fn=30);
            translate([10,0,4]) rotate([0,90,0]) cylinder(h=6,d=1,center=true,$fn=30);
        }
        translate([-8,0,-4]) rotate([0,90,0]) cylinder(h=5,d=5,center=true,$fn=30);
        translate([-8,0,-4]) cube([5,2,6],center=true);
    }
    // servo horn
    color("white") translate([10,0,4]) rotate([angle,0,0]) {
        difference() {
            union() {
                difference() {
                    translate([1,0,0]) rotate([0,90,0]) cylinder(h=2,d=4,center=true,$fn=30);
                    translate([0,0,0]) rotate([0,90,0]) cylinder(h=2,d=2.5,center=true,$fn=30);
                }
                translate([1.5,-2.5,0]) cube([1,8,2],center=true);
                translate([1.5,-6.5,0]) rotate([0,90,0]) cylinder(h=1,d=2,center=true,$fn=30);
            }
            // holes
            translate([1,0,0]) rotate([0,90,0]) cylinder(h=4,d=0.8,center=true,$fn=30);
            translate([1,-5,0]) rotate([0,90,0]) cylinder(h=4,d=0.5,center=true,$fn=30);
            translate([1,-6,0]) rotate([0,90,0]) cylinder(h=4,d=0.5,center=true,$fn=30);
        }
    }
}



/* utility functions */

function mix_linear(v,i1,i2,o1,o2) =
    ( v < i1)
    ? o1
    : (v>i2)
        ? o2
        : (v-i1)/(i2-i1) * (o2-o1) + o1;

function mix(v,i1,i2,o1,o2) =
    ( i1<i2 ) 
    ? mix_linear(v,i1,i2,o1,o2) 
    : mix_linear(v,i2,i1,o2,o1);

function clamp_linear(v,c1,c2) =
    ( v < c1)
    ? c1
    : (v>c2)
        ? c2
        : v;

function clamp(v,c1,c2) =
    ( i1<i2 ) 
    ? clamp_linear(v,c1,c2) 
    : clamp_linear(v,c2,c1);
