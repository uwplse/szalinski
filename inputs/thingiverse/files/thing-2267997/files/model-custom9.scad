/* [Global] */

// Which part(s) would you like to see?
part = "all"; // [all:Complete Rocket, cone:Nose Cone, body:Body, finCan:Fin Can, payloadBody:Payload Body, payloadCoupling:Payload Coupling]

// Show a cut-away section?  (warning: this can be really slow to render)
section_view = "no";  // [yes:Yes, no:No]

/* [Motor] */

// Show rocket motor?
show_engine =  "no";  // [yes:Yes, no:No]

// What type of rocket motor (Estes range)?
engine_type = "standard";  // [mini:Mini, standard:Standard, cd:C or D Engine, e24:24mm E Engine, ef29:29mm E or F Engine]

// Clearance between motor and motor tube
motor_tolerance = 0.3;


/* [Fin Can] */

// Inner diameter of rocket finCan and body sections
inner_diameter = 22;  // [15 : 200]

// What type of fin shape?
fin_type = "sbend"; // [trapezoid:Trapezoid, smooth:Smooth, sbend:S-bend]

// Height of fin can
fin_can_height = 80;  // [50 : 200]

number_of_fins = 3;  // [0 : 6]

// Width of fins
fin_width = 40;  // [0 : 100]

// Height of fin base (the bit that touches the rocket finCan)
fin_base_height = 60;  // [0 : 200]

// Vertical offset of fin base
fin_base_offset = 5;

// height of outer vertical section at base of fin
fin_tip_height  = 20; // [0 : 200]

// Vertical offset of fin tips
fin_tip_offset = -5;  // [-200 : 200]

// Width of horizontal flat at base of fin tips (makes printing easier!)
fin_tip_flat_base = 5;

// Degrees to twist fins (to rotate rocket for improved stability)
fin_twist = 0;

// Include a launch guide on the fin can section
fin_can_guide = "yes"; // [yes:Yes, no:No]

// Include print support when fins are below the base of the rocket tube
fin_can_print_support = "yes";  // [yes:Yes, no:No]


/* [Body] */

body_height = 35; // [10 : 200]

// Include a launch guide on the body section
body_guide = "no"; // [yes:Yes, no:No]


/* [Payload] */

payload = "yes";  // [yes:Yes, no:No]

payload_height = 20; // [10 : 200]

payload_inner_diameter = 30;  // [15: 200]

payload_coupling_height = 35; // [5 : 200]

payload_coupling_type = "smooth"; // [flat:Flat, smooth:Smooth, radiused:Radiused]

// Include a solid bulkhead at the base of the payload coupling?
payload_bulkhead = "no";  // [yes:Yes, no:No]

// Include a shockcord fixing at the base of the payload coupling?
payload_shockcord_fixing = "yes";  // [yes:Yes, no:No]

// Include a launch guide on the payload section
payload_guide = "yes"; // [yes:Yes, no:No]


/* [Nose Cone] */

cone_type = "haack";  // [flat:Flat, curved:Curved, bulb:Bulb, haack:Haack]

cone_height = 70; // [10 : 200]

cone_bulb_diameter = 20;  // [1 : 100]

// Controls how blunt vs pointy the bullet cone is, small is pointy
cone_bluntness = 50; // [1 : 100]

// Haack constant - 0.3333 for LV cones, 0 for LD cones
cone_haack_constant = 0.3333;

// Include a shockcord fixing at the base of the nose cone?
shock_cord_fixing = "yes";  // [yes:Yes, no:No]


/* [Guides] */

guide_type = "rod";  // [rail:Rail, rod:Rod]

// Show the guide position/fitting?
show_guide = "no";  // [yes:Yes, no:No]

guide_rod_diameter = 5.0;

// Height of the guide tubes (for Rods)
guide_tube_height = 18;

// Width of gap in guide rail - allow for fitting tolerance (mm)
guide_rail_opening = 3;

// Thickness of guide rail edges - allor for fitting tolerance (mm)
guide_rail_thickness = 2;


/* [Other] */

// Generate as one solid part?
one_big_solid = "no";  // [yes:Yes, no:No]

// WWall thickness of the rocket shell/fins in mm - adjust to ensure model is sliced correctly - aim for 2 perimeters in your slicer
perimeter_width = 1.2;

// Curve precision (number of facets)
curve_precision = 36;  // [6 : 64]

coupling_height = 10;  // [5 : 50]

coupling_tolerance = 0.3;


/* [Hidden] */

perim = perimeter_width;
layers = 0.3;
2perim = perim * 2;
4perim = 4*perim;
eta = 0.001;

$fn = curve_precision;

payload_coupling_min_height  = (payload_inner_diameter - inner_diameter) / 2;
payload_coupling_height2 = payload_coupling_height < payload_coupling_min_height ? payload_coupling_min_height : payload_coupling_height;

// guide tube
guide_tube_offset = ((payload == "yes" ? max(payload_inner_diameter, inner_diameter) : inner_diameter) / 2) + perim + guide_rod_diameter/2;

// angle around z to guide rail - to avoid hitting the fins
guide_rail_angle = (360 / number_of_fins) / 2;

// offset to outer face of rail
guide_rail_offset = ((payload == "yes" ? max(payload_inner_diameter, inner_diameter) : inner_diameter) / 2) + 2*perim;

// Engine parameters  (diameter, length)
engine_mini = [13, 44];
engine_standard = [18, 70];
engine_cd = [24, 70];
engine_e24 = [24, 95];
engine_ef29 = [29, 114];

engine_type_val = engine_type == "mini" ? engine_mini :
				 	(engine_type == "standard" ? engine_standard :
			     		(engine_type == "cd" ? engine_cd :
			     			(engine_type == "e24" ? engine_e24 : engine_ef29)
			     		)
				 	);

fin_can_height2 = fin_can_height < engine_type_val[1] + 4*perim ? engine_type_val[1] + 4*perim : fin_can_height;


// Core Modules

module engine(e_type) {
	ed = e_type[0];
	el = e_type[1];

	// outer
	color([0.8,0.7,0.6])
		linear_extrude(el)
		donut(ed/2, ed/2-1.5, $fn=24);

	// core
	color([0.6,0.6,0.6])
		translate([0,0,1])
		linear_extrude(el-2)
		donut(ed/2-1.5, ed/8, $fn=16);

}


module coupling(id, h, notched=false) {

	id2 = id - coupling_tolerance;
	h2 = coupling_tolerance + perim;

	notches = 6;

	// tube
	linear_extrude(height = h+ 2*layers)
		difference() {
			donut(id2/2, id2/2 - perim);

			// notches
			if (notched)
				for (i=[0:notches-1])
				rotate([0,0,i*(360/notches) + 180/notches])
				translate([0,-perim,0])
				square([id2, 2perim]);
		}

	// nubbins
	if (notched)
		linear_extrude(height = h/3)
		difference() {
			donut(id2/2 + coupling_tolerance, id2/2 - perim);

			// notches
			for (i=[0:notches-1])
				rotate([0,0,i*(360/notches) + 180/notches])
				translate([0,-perim,0])
				square([id2, 2perim]);

			// avoid nubbins on teeth at ends of shockcord fixing, as they can't flex
			square([id2 + 2, id2 * sin(360/notches)/2 + perim], center=true);
		}


	// taper
	translate([0,0, h - h2])
		render()
		difference() {
			cylinder(r1=id2/2, r2=id/2 + perim, h=h2);

			translate([0,0,-1])
				cylinder(r=id2/2 - perim, h=h2 + 2);
		}
}

module upperCoupling(id, h) {
	id2 = id - coupling_tolerance;
	h2 = coupling_tolerance + perim;

	// tube
	linear_extrude(height = h+ 2*layers)
		donut(id2/2, id2/2 - perim);

	// taper
	translate([0,0, -h2])
		render()
		difference() {
			cylinder(r=id2/2 + perim, h=h2);

			translate([0,0,-eta])
				cylinder(r1=id/2, r2=id2/2 - perim, h=h2 + 2*eta);
		}
}


module guideTube() {
	// generates a guide tube with sloping underside to allow for support-free printing
	// Local co-ordinate frame is at bottom, centre of guide tube.
	// Slope is down towards x-

	ir = guide_rod_diameter/2;
	or = ir + perim;
	h = guide_tube_height;

	or2 = or + eta;
	h1 = 2 * or2;  // height of top of bevel

	//guide_tube_height
	render()
	difference()
	{
		linear_extrude(h)
			donut(or, ir);

		// taper top and bottom
		for (i=[0:1])
			translate([0,0,i*(h+perim)])
			mirror([0,0,i])
			polyhedron(
				points = [
					// top - clockwise from x- y-
					[or2, -or2, h1],     //0
					[or2, or2, h1],      //1

					// bottom - clockwise (when viewed from above) from x- y-
					[-or2, -or2, -eta],  //2
					[-or2, or2, -eta],   //3
					[or2, or2, -eta],    //4
					[or2, -or2, -eta]    //5
				],
				faces = [
					// bottom
					[2,5,4,3],
					//x- the slope
					[2,3,1,0],
					//x+
					[0,1,4,5],
					//y-
					[0,5,2],
					//y+
					[1,3,4]
				]
			);
	}

}


module guideButton() {
	z = 1.5 * guide_rail_opening;
	rotate([0,0,guide_rail_angle])
		translate([guide_rail_offset, 0, 0]) {

			// inner skid - stops rail rubbing against rocket casing
			translate([-2*perim, 0, z])
				scale([1,1,1.5])
				rotate([0,90,0])
				cylinder(r=guide_rail_opening, h=2*perim);

			// pin
			translate([-2*perim, 0, z])
				rotate([0,90,0])
				cylinder(r=guide_rail_opening/2, h=guide_rail_thickness + 4*perim);

			// outer skid - rides in rail
			translate([guide_rail_thickness, 0, z])
				scale([1,1,1.5])
				rotate([0,90,0])
				cylinder(r=guide_rail_opening, h=2*perim);

		}
}


module fin() {
	fins = number_of_fins;
	finW = fin_width;
	finHTotal = fin_base_height;
	finHBase = fin_tip_height;

	smooth_control_points = [
		[finW, fin_tip_offset],
		[finW, finHBase + fin_tip_offset],
		[0, finHTotal],
		[0, finHTotal]
	];

	sbend_control_points = [
		[finW, fin_tip_offset],
		[finW, fin_tip_offset],
		[finW, finHBase + fin_tip_offset],
		[0, finHTotal-finHBase],
		[0, finHTotal]
	];

	bez_steps = curve_precision;



	if (fin_type == "trapezoid") {
		linear_extrude(perim)
			polygon(points=[
				[0,fin_base_offset],
				[0,finHTotal + fin_base_offset],
				[finW,finHBase + fin_tip_offset],
				[finW, fin_tip_offset],
				[finW-fin_tip_flat_base, fin_tip_offset]
			]);
	} else if (fin_type == "smooth") {
		linear_extrude(perim)
		union() {
			for (i=[0:bez_steps-2])
				assign(
					u1 = i/(bez_steps-1),
					u2 = (i+1)/(bez_steps-1)
				)
				assign(
					p1 = PtOnBez2DP(smooth_control_points, i/(bez_steps-1)),
					p2 = PtOnBez2DP(smooth_control_points, (i+1)/(bez_steps-1))
				)
				{
					polygon([[0, u1 * finHTotal + fin_base_offset], [p1[0], p1[1]], [p2[0], p2[1]], [0, u2 * finHTotal + fin_base_offset]], 4);
				}

			// add a little bit to account for a fin_tip_flat_base
			if (fin_tip_flat_base > 0) {
				polygon(points=[
					[0,fin_base_offset],
					[finW, fin_tip_offset],
					[finW-fin_tip_flat_base, fin_tip_offset]
				]);
			}
		}

	} else if (fin_type == "sbend") {
		linear_extrude(perim)
		union() {
			for (i=[0:bez_steps-2])
				assign(
					u1 = i/(bez_steps-1),
					u2 = (i+1)/(bez_steps-1)
				)
				assign(
					p1 = PtOnBez2DP(sbend_control_points, i/(bez_steps-1)),
					p2 = PtOnBez2DP(sbend_control_points, (i+1)/(bez_steps-1))
				)
				{
					polygon([[0, u1 * finHTotal + fin_base_offset], [p1[0], p1[1]], [p2[0], p2[1]], [0, u2 * finHTotal + fin_base_offset]], 4);
				}

			// add a little bit to account for a fin_tip_flat_base
			if (fin_tip_flat_base > 0) {
				polygon(points=[
					[0,fin_base_offset],
					[finW, fin_tip_offset],
					[finW-fin_tip_flat_base, fin_tip_offset]
				]);
			}
		}

	}
}


module finCan(e_type) {
	id = inner_diameter;
	fins = number_of_fins;
	finW = fin_width;
	finHTotal = fin_base_height;
	finHBase = fin_tip_height;

	ed = e_type[0];
	el = e_type[1];

	edt = (ed + motor_tolerance);

	h = fin_can_height2;

	numSupports = round((PI*id) / 6);

	color("white")
	union() {
		// outer casing
		linear_extrude(height = h)
			donut(id/2 + perim, id/2);

		// motor mount tube
		linear_extrude(height = el + 10)
			donut( edt/2 + 2perim, edt/2);

		// motor mount to casing ribs
		for(i=[0:fins-1])
			rotate([0,0,i*360/fins])
			translate([edt/2,0,0])
			rotate([90,0,0])
			linear_extrude(perim)
			square([(id - edt)/2,el + 4*perim]);


		// motor top retainer
		translate([0,0,el])
			render()
			difference() {
				cylinder(r=edt/2 + perim, h=4perim);

				translate([0,0,-eta])
					cylinder(r1=edt/2 + perim, r2=edt/2 - 3*perim, h=4perim + 2*eta);
			}

		// motor bottom retainer
		// TO DO - doesn't seem critical, esp if tape is used for tight fit

		// fins
		for(i=[0:fins-1])
			rotate([0,0,i*360/fins])
			translate([id/2,0,0])
			rotate([fin_twist,0,0])
			rotate([90,0,0]) {
				fin();
			}

		if (fin_can_guide == "yes") {
			if (guide_type == "rod" && fin_twist == 0) {
				// guide tube
				translate([guide_tube_offset,
						   guide_rod_diameter/2,
		   				   fin_tip_offset * (guide_tube_offset - inner_diameter/2)/fin_width + fin_tip_offset * 0.1])
					rotate([0,0,90])
					guideTube();
			} else if (guide_type == "rail" ){
				if (payload != "yes" || payload_inner_diameter <= inner_diameter )
					guideButton();
			}
		}

		if (one_big_solid == "no") {
			// coupling
			translate([0,0, h - eta])
				upperCoupling(id, coupling_height);

			// shock cord tether
			translate([0,0, el + 10 + 5/2 - eta])
				cube([id + perim, 2, 5], center=true);
		}

		// print support
		if (fin_can_print_support == "yes" && fin_tip_offset < 0) {
			// radial supports, perim thick
			for (i=[0:numSupports-1])
				rotate([0,0, i * 360/numSupports])
				translate([edt/2-1, -perim/2, fin_tip_offset])
				cube([id/2 + perim - edt/2 + 2, perim, abs(fin_tip_offset)]);

			// a little ring to join them all together
			translate([0,0,fin_tip_offset])
				linear_extrude(0.6)
				donut(id/2, edt/2);
		}

	}
}


module body() {
	h = body_height;
	id = inner_diameter;

	color("grey")
	union() {
		// body tube
		linear_extrude(height = h+eta)
			donut( id/2 + perim, id/2);

		if (
			(payload != "yes" || payload_inner_diameter <= inner_diameter ) &&
			h >= guide_tube_height &&
			body_guide == "yes"
		) {
			if (guide_type == "rod") {
				translate([guide_tube_offset,
						   guide_rod_diameter/2,
		   				   0])
				guideTube();
			} else {
				guideButton();
			}
		}
	}
}


module noseCone() {
	id = payload == "yes" ? payload_inner_diameter : inner_diameter;
	id2 = id - coupling_tolerance;

	or = id/2 + perim;

	br = cone_bulb_diameter/2;

	$fn = $fn * 2;

	// bezier control points for curved cone
	// outer surface
	curved_control_points = [[or, 0], [or, cone_height/3], [or * cone_bluntness/100,  cone_height], [0, cone_height]];

	// for inner surface
	curved_control_points_inner = [[or-perim, 0], [or-perim, cone_height/3], [or * cone_bluntness/100-perim,  cone_height-perim], [0, cone_height-perim]];


	// bezier control points for bulb cone - 2 curves!
	// outer surface
	// lower curve
	bulb_control_points = [
		[or, 0], [or, cone_height/4], [br,  cone_height/4], [br, cone_height/2]
	];
	// upper curve
	bulb_control_points2 = [
		[br, cone_height/2], [br, cone_height/2], [br,  cone_height], [0, cone_height]
	];

	// for inner surface
	// lower curve
	bulb_control_points_inner = [
		[or-perim, 0], [or-perim, cone_height/4], [br-perim,  cone_height/4], [br-perim, cone_height/2]
	];

	// upper curve
	bulb_control_points_inner2 = [
		[br-perim, cone_height/2], [br-perim, cone_height/2], [br-perim,  cone_height-perim], [0, cone_height-perim]
	];

	haackC = cone_haack_constant;


	// how many steps to use for interpolating bezier curves
	bez_steps = curve_precision;

	color("white")
	union() {
		if (cone_type == "curved") {
			rotate_extrude()
			//linear_extrude(1)
			union() {
				// for each vertical segment
				for (i=[0:bez_steps-2])
					assign(
						u1 = i/(bez_steps-1),
						u2 = (i+1)/(bez_steps-1)
					)
					assign(
						p1 = PtOnBez2DP(curved_control_points_inner, u1),
						p2 = PtOnBez2DP(curved_control_points, u1),
						p3 = PtOnBez2DP(curved_control_points, u2),
						p4 = PtOnBez2DP(curved_control_points_inner, u2)
					)
					{
						polygon([[p1[0], p1[1]], [p2[0], p2[1]], [p3[0], p3[1]], [p4[0], p4[1]]], 4);
					}
			}

		} else if (cone_type == "bulb") {
			rotate_extrude()
			//linear_extrude(1)
			union() {
				// for each vertical segment
				for (i=[0:bez_steps-2]) {
					// lower curve
					assign(
						u1 = i/(bez_steps-1),
						u2 = (i+1)/(bez_steps-1)
					)
					assign(
						p1 = PtOnBez2DP(bulb_control_points_inner, u1),
						p2 = PtOnBez2DP(bulb_control_points, u1),
						p3 = PtOnBez2DP(bulb_control_points, u2),
						p4 = PtOnBez2DP(bulb_control_points_inner, u2)
					)
					{
						polygon([[p1[0], p1[1]], [p2[0], p2[1]], [p3[0], p3[1]], [p4[0], p4[1]]], 4);
					}

					// upper curve
					assign(
						u1 = i/(bez_steps-1),
						u2 = (i+1)/(bez_steps-1)
					)
					assign(
						p1 = PtOnBez2DP(bulb_control_points_inner2, u1),
						p2 = PtOnBez2DP(bulb_control_points2, u1),
						p3 = PtOnBez2DP(bulb_control_points2, u2),
						p4 = PtOnBez2DP(bulb_control_points_inner2, u2)
					)
					{
						polygon([[p1[0], p1[1]], [p2[0], p2[1]], [p3[0], p3[1]], [p4[0], p4[1]]], 4);
					}
				}

			}

		} else if (cone_type == "haack") {
			// See:
			// http://en.wikipedia.org/wiki/Nose_cone_design

			rotate_extrude()
			//linear_extrude(1)
			union() {
				// for each vertical segment
				for (i=[0:bez_steps-2])
					assign(
						// x refers to Haack coordinate frame, equiv to y axis
						x1 = i/(bez_steps-1),
						x2 = (i+1)/(bez_steps-1)
					)
					assign(
						theta1 = acos(1 - (2 * (1-x1) )),
						theta2 = acos(1 - (2 * (1-x2) ))
					)
					assign(
						// y1 refers to Haack coordinate frame, equiv to x axis
						y1 = or * sqrt((PI*theta1/180 - (sin(2*theta1)/2) + haackC * pow(sin(theta1),3)) / PI),
						y2 = or * sqrt((PI*theta2/180 - (sin(2*theta2)/2) + haackC * pow(sin(theta2),3)) / PI)
					)
					{
						polygon([
							[max(y1-perim,0), x1 * cone_height - perim],
							[y1, x1 * cone_height],
							[y2, x2 * cone_height],
							[max(y2-perim,0), x2 * cone_height - perim]
						], 4);
					}
			}

		} else {
			// cone
			render()
				difference() {
					cylinder(r1=id/2 + perim, r2=2perim, h=cone_height);

					translate([0,0,-eta])
						cylinder(r1=id/2, r2=perim, h=cone_height);
				}

			// tip
			translate([0,0, cone_height - eta])
				cylinder(r1=2perim, r2=perim, h=2perim, $fn=16);
		}

		if (one_big_solid == "no") {
			// coupling
			translate([0,0, -coupling_height + eta])
				coupling(id, coupling_height, true);

			// shock cord fixing
			if (shock_cord_fixing == "yes") {
				translate([0,0, -coupling_height + eta])
					linear_extrude(coupling_height / 2)
					intersection() {
						circle(id2/2);

						square([id2, 2perim], center=true);
					}
			}
		}
	}
}


module payload_body() {
	h = payload_height;
	id = payload_inner_diameter;

	color("grey")
	union() {
		// body
		linear_extrude(height = h+eta)
			donut( id/2 + perim, id/2);

		if (
			payload_inner_diameter > inner_diameter &&
			h >= guide_tube_height &&
			payload_guide == "yes"
		) {
			if (guide_type == "rod") {
				// guide tube
				translate([
					guide_tube_offset,
					guide_rod_diameter/2,
						0
				])
				guideTube();
			} else {
				guideButton();
			}
		}
	}
}


module payload_coupling() {
	id = inner_diameter;
	id2 = id - coupling_tolerance;

	idt = payload_inner_diameter;
	idt2 = idt - coupling_tolerance;

	h = payload_coupling_height2;

	// outer surface
	smooth_control_points = [[id/2+perim, 0], [id/2+perim, h/3], [idt/2 + perim, 2*h/3], [idt/2+perim, h + (one_big_solid == "yes" ? eta : -perim)]];

	// outer surface
	radiused_control_points = [[id/2+perim, 0], [id/2+perim, 0], [idt/2 + perim, h/2], [idt/2+perim, h + (one_big_solid == "yes" ? eta : -perim)]];

	bez_steps = curve_precision;

	color("white")
	union() {

		if (one_big_solid == "no") {
			// bottom tube
			translate([0,0, -coupling_height + eta])
				coupling(id, coupling_height, !(payload_bulkhead == "yes"));

			// upper tube
			translate([0,0, h - perim])
				upperCoupling(idt, coupling_height + perim);

			// collar to ensure manifold surface
			translate([0,0, h - 2*perim])
				linear_extrude(height = 2*perim)
				donut(idt/2 + perim, idt2/2-eta);

			if (payload_shockcord_fixing == "yes") {
				translate([0,0, -coupling_height + eta])
					linear_extrude(coupling_height / 2)
					intersection() {
						circle(id2/2);

						square([id, 2perim], center=true);
					}
			}


			// bulkhead
			if (payload_bulkhead == "yes") {
				translate([0,0,-coupling_height + eta])
					linear_extrude(perim) {
						difference() {
							circle(r=id2/2);

							if (payload_shockcord_fixing == "yes") {
								hull() {
									translate([0,perim,0])
										circle(r=3);
									translate([0,-perim,0])
										circle(r=3);
								}
							}
						}
					}

			}

		}

		// taper
		if (payload_coupling_type == "flat")  {
			translate([0,0,0])
				render()
				difference() {
					cylinder(r1=id/2 + perim, r2=idt/2 + perim, h=h + (one_big_solid == "yes" ? eta : -perim));

					translate([0,0,-eta])
						cylinder(r1=id/2 - perim, r2=idt/2 - perim, h=h + 100);
				}
		} else if (payload_coupling_type == "smooth") {
			rotate_extrude() {
				// for each vertical segment
				for (i=[0:bez_steps-2])
					assign(
						u1 = i/(bez_steps-1),
						u2 = (i+1)/(bez_steps-1)
					)
					assign(
						p1 = PtOnBez2DP(smooth_control_points, u1),
						p2 = PtOnBez2DP(smooth_control_points, u2)
					) {
						polygon([[p1[0]-perim, p1[1]], [p1[0], p1[1]], [p2[0], p2[1]], [p2[0]-perim, p2[1]]], 4);
					}
			}
		} else {
			rotate_extrude() {
				// for each vertical segment
				for (i=[0:bez_steps-2])
					assign(
						u1 = i/(bez_steps-1),
						u2 = (i+1)/(bez_steps-1)
					)
					assign(
						p1 = PtOnBez2DP(radiused_control_points, u1),
						p2 = PtOnBez2DP(radiused_control_points, u2)
					)
					{
						polygon([[p1[0]-perim, p1[1]], [p1[0], p1[1]], [p2[0], p2[1]], [p2[0]-perim, p2[1]]], 4);
					}
			}
		}

	}
}


module rocket(e_type) {
	ph = payload_height + payload_coupling_height2;

	if (one_big_solid == "yes") {
		union() {
			finCan(e_type);

			translate([0,0, fin_can_height2])
				body();

			if (payload == "yes") {
				translate([0,0, fin_can_height2 + body_height ])
					payload_coupling();

				translate([0,0, fin_can_height2 + body_height + payload_coupling_height2 ])
					payload_body();
			}

			translate([0,0, fin_can_height2 + body_height + (payload == "yes" ? ph : 0)])
				noseCone();
		}

	} else {
		if (part == "all" || part == "") {
			finCan(e_type);

			translate([0,0, fin_can_height2])
				body();

			if (payload == "yes") {
				translate([0,0, fin_can_height2 + body_height + perim])
					payload_coupling();

				translate([0,0, fin_can_height2 + body_height + payload_coupling_height2 + perim])
					payload_body();
			}

			translate([0,0, fin_can_height2 + body_height + 2perim + (payload == "yes" ? ph : 0)])
				noseCone();
		}

		if (part == "finCan") finCan(e_type);
		if (part == "cone") noseCone();
		if (part == "body") body();
		if (part == "payloadCoupling") payload_coupling();
		if (part == "payloadBody") payload_body();
	}
}


// Entry Point

if (show_engine == "yes") engine(engine_type_val);

if (section_view == "yes") {
	render()
	difference() {
		rocket(engine_type_val);

		translate([-250,0,-50])
			cube([500,500,500]);
	}

} else
	rocket(engine_type_val);

// Guides
if (show_guide == "yes") {
	if (guide_type == "rod") {
		color([0.7,0.7,0.7])
			translate([guide_tube_offset, guide_rod_diameter/2, -50])
			cylinder(r=guide_rod_diameter/2, h=600);

		// blast plate
		color([0.7,0.7,0.7])
			translate([guide_tube_offset, guide_rod_diameter/2, -50])
			cylinder(r=100/2, h=1);
	} else {
		// rail - basic proxy of a rail

		color([0,1,0,0.3])
			rotate([0,0,guide_rail_angle])
			translate([guide_rail_offset, -guide_rail_opening/2, -50])
			cube([guide_rail_thickness, guide_rail_opening, 600]);

		// blast plate
		color([0.7,0.7,0.7])
		rotate([0,0,guide_rail_angle])
			translate([guide_rail_offset, 0, -50])
			cylinder(r=100/2, h=1);
	}

}



// Utility Modules

module donut(or,ir) {
	difference() {
        circle(or);
    	circle(ir);
    }
}


//=======================================
//
//		Bezier Curve Routines
//
//      From the maths.scad library by William A Adams
//
//=======================================

 /*
	Bernstein Basis Functions
	These are the coefficients for bezier curves

*/

// For quadratic curve (parabola)
function Basis02(u) = pow((1-u), 2);
function Basis12(u) = 2*u*(1-u);
function Basis22(u) = u*u;

// For cubic curves, these functions give the weights per control point.
function Basis03(u) = pow((1-u), 3);
function Basis13(u) = 3*u*(pow((1-u),2));
function Basis23(u) = 3*(pow(u,2))*(1-u);
function Basis33(u) = pow(u,3);

// Derivative basis functions
function BasisDer03(u) = -3*pow((1-u), 2);
function BasisDer13(u) = 3*pow(1-u,2) - 6*(1-u)*u;
function BasisDer23(u) = 6* (1-u)*u - 3*pow(u,2);
function BasisDer33(u) = 3 * pow(u,2);


// Given an array of control points
// Return a point on the quadratic Bezier curve as specified by the
// parameter: 0<= 'u' <=1
function Bern02(cps, u) = [Basis02(u)*cps[0][0], Basis02(u)*cps[0][1], Basis02(u)*cps[0][2]];
function Bern12(cps, u) = [Basis12(u)*cps[1][0], Basis12(u)*cps[1][1], Basis12(u)*cps[1][2]];
function Bern22(cps, u) = [Basis22(u)*cps[2][0], Basis22(u)*cps[2][1], Basis22(u)*cps[2][2]];

function berp2(cps, u) = Bern02(cps,u)+Bern12(cps,u)+Bern22(cps,u);

//===========
// Cubic Beziers - described by 4 control points
//===========
// Calculate a singe point along a cubic bezier curve
// Given a set of 4 control points, and a parameter 0 <= 'u' <= 1
// These functions will return the exact point on the curve
function PtOnBez2D(p0, p1, p2, p3, u) = [
	Basis03(u)*p0[0]+Basis13(u)*p1[0]+Basis23(u)*p2[0]+Basis33(u)*p3[0],
	Basis03(u)*p0[1]+Basis13(u)*p1[1]+Basis23(u)*p2[1]+Basis33(u)*p3[1]];

// packed variant - pass points as an array of coefficients
function PtOnBez2DP(p, u) =  PtOnBez2D(p[0], p[1], p[2], p[3], u);

// 1D variant
function PtOnBez1D(p0, p1, p2, p3, u) = Basis03(u)*p0+Basis13(u)*p1+Basis23(u)*p2+Basis33(u)*p3;

// 1D packed
function PtOnBez1DP(p, u) =  PtOnBez1D(p[0], p[1], p[2], p[3], u);

