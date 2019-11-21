// This script supports a workflow where"
// - a measurement is made of the two critical maesurements for an individual,
// - then this mold can be made, printed, and used to construct the cannula by injecting silicone.
// (must be a platinum cure silicone)


// Additional tools required:
// - Inkscape to draw the outline (attached as SVG but extracted using exporter and embedded as a shape below
// - Inkscape to Openscad exporter to get shape out: http://www.thingiverse.com/thing:1065500
//

// E.g.
// Input parameters
left_nare_OD = 3.19;
right_nare_OD = 1.36;
septum_dist = 5.26;
show_Xsection = false; // true
injection_port_dia = 4; // injection port size (sprue)

/* [Fixed] */
nare_thickness = 0.5;     // Thickness of Nare tubes (both the same for now)
nasal_prong_length = 8;   // Length of Nasal Prong into Nose
cannula_length = 32;      // Length of Cannula (up until tube endings)
cannula_thickness = 1.0;  // Thickness of the Cannula core tube
end_tube_OD = 6;          // OD of tubing to connect to Cannula
end_tube_thickness = 1.0; // Thickness of interface tubes at end of Cannula
tube_blend_length = 10;   // The length of the transition from cannula_shape to tubing
end_tube_length = 6;      // Length of the tube part at the ends
tube_X_offset = 0;        // X position of the tube wrt to the cannula shape
tube_Y_offset = -2;       // Y position

// mold params
mold_end_tube_buffer = 4;  // used to make the tubes longer so we can have sprues and keys. cut them off when extracted

// Specific params relevant to a given Cannula shape
Cannula_height = 16;        // Height of profile of Cannula core tube
Nare_X_offset = -3.5;       // Adjustment specific to a shape to get Nares penetrating the Cannula in correct position

/* [Hidden] */
$fn = 64;    // how many samples around circles and cylinders get.
Delta = 0.1; // used to ensure primitive overlaps to get properly closed stl files.

// The Cannula shape (taken from Inkscape profile. Extracted using dnewman's Inkscape to Openscad converter)
Cannula_shape = [[-55.609194,210.386231],[-60.266152,208.843238],[-65.788622,206.451648],[-72.025839,203.246181],
				 [-78.827037,199.261559],[-86.041451,194.532500],[-93.518316,189.093726],[-101.106866,182.979956],
				 [-108.656336,176.225911],[-112.369302,172.619636],[-116.015961,168.866311],[-119.577467,164.970278],
				 [-123.034975,160.935876],[-126.369639,156.767445],[-129.562613,152.469326],[-132.595052,148.045858],
				 [-135.448109,143.501381],[-138.102940,138.840236],[-140.540699,134.066762],[-142.742540,129.185300],
				 [-144.689617,124.200189],[-146.363084,119.115770],[-147.744097,113.936382],[-148.813808,108.666366],
				 [-149.553374,103.310061],[-150.623685,90.805389],[-151.562567,75.219075],[-152.371212,57.054651],
				 [-153.050809,36.815650],[-153.602549,15.005605],[-154.027623,-7.871951],[-154.502536,-54.815466],
				 [-154.485073,-99.986633],[-153.984760,-139.357189],[-153.556511,-155.608406],[-153.011122,-168.898872],
				 [-152.349782,-178.725054],[-151.976004,-182.181684],[-151.573684,-184.583419],[-150.516181,-187.692796],
				 [-149.070005,-191.029063],[-146.901729,-195.063756],[-145.520907,-197.228334],[-143.928486,-199.429905],
				 [-142.114108,-201.622597],[-140.067414,-203.760540],[-137.778047,-205.797862],[-135.235648,-207.688691],
				 [-132.429860,-209.387157],[-129.350324,-210.847389],[-125.781002,-212.079746],[-121.582801,-213.130097],
				 [-116.860782,-214.005842],[-111.720003,-214.714379],[-106.265525,-215.263107],[-100.602407,-215.659423],
				 [-89.070491,-216.024419],[-77.964734,-215.868554],[-68.125613,-215.251018],[-63.943691,-214.787620],
				 [-60.393607,-214.231000],[-57.580421,-213.588557],[-55.609194,-212.867689],[-52.491307,-211.045790],
				 [-49.104212,-208.470118],[-45.306389,-204.930025],[-40.956316,-200.214861],[-35.912472,-194.113978],
				 [-30.033334,-186.416725],[-23.177382,-176.912455],[-15.203094,-165.390519],[-1.313750,-144.602913],
				 [21.061796,-110.332481],[34.432884,-89.496085],[48.726710,-66.914839],[63.543668,-43.130694],
				 [78.484155,-18.685602],[93.148566,5.878483],[107.137296,30.019610],[120.050741,53.195828],[125.979356,64.252735],
				 [131.489297,74.865183],[136.530615,84.965427],[141.053359,94.485724],[145.007578,103.358329],
				 [148.343322,111.515499],[151.010641,118.889489],[152.959583,125.412555],[154.140198,131.016954],
				 [154.426774,133.453483],[154.502536,135.634941],[154.212368,143.506596],[153.588707,150.739461],
				 [152.621114,157.373589],[151.299151,163.449031],[149.612378,169.005839],[147.550357,174.084066],
				 [145.102649,178.723763],[142.258814,182.964983],[139.008413,186.847776],[135.341009,190.412196],
				 [131.246161,193.698293],[126.713430,196.746121],[121.732379,199.595731],[116.292567,202.287174],
				 [110.383556,204.860504],[103.994906,207.355771],[100.488273,208.540047],[96.618184,209.625210],
				 [92.411428,210.614142],[87.894798,211.509724],[78.039075,213.032367],[67.265343,214.216192],
				 [55.787927,215.084256],[43.821156,215.659612],[31.579356,215.965315],[19.276854,216.024419],
				 [7.127977,215.859978],[-4.652948,215.495048],[-15.851594,214.952683],[-26.253634,214.255936],
				 [-35.644741,213.427863],[-43.810588,212.491519],[-50.536848,211.469956],[-55.609194,210.386231],
				 [-55.609194,210.386231]];

//-----------------------------------
// helper functions to determine the X,Y dimensions of profiles
function min_x(shape_points) = min([ for (x = shape_points) min(x[0])]);
function max_x(shape_points) = max([ for (x = shape_points) max(x[0])]);
function min_y(shape_points) = min([ for (x = shape_points) min(x[1])]);
function max_y(shape_points) = max([ for (x = shape_points) max(x[1])]);

// Calculate the proper scale for an arbitrary curve,
//  so that its profile height = Cannula_height.
cannula_scale = Cannula_height / (max_y(Cannula_shape) - min_y(Cannula_shape));





// To make a mold, need to factor so that:
// - internal cores are sep object to outer shell.
// - can make a shell with voids for pumping in silicone
// The core needs to be split so it can be extracted from molded part.

//------------------------------
//Factored for a mold

// Outer body of the Cannula section
module outer_body (length) {
	linear_extrude(height=length,center=true,convexity=6)
	scale([cannula_scale, -cannula_scale, 1])
		polygon(Cannula_shape);
}

// Inner body of the Cannula section
module inner_body (length) {
	linear_extrude(height=length+Delta*2,center=true,convexity=6)
	offset(r=-cannula_thickness) {
		scale([cannula_scale, -cannula_scale, 1])
			polygon(Cannula_shape);
	}
}

// Outer body of the tube and mating extensions to the Cannula section
module outer_tube (mold=false) {
	// if mold then add length
	tube_len = (mold) ? end_tube_length + mold_end_tube_buffer : end_tube_length;
	hull() {
		// Cannula shape
		linear_extrude(height=Delta*2,convexity=6)
			scale([cannula_scale, -cannula_scale, 1])
				polygon(Cannula_shape);
		// to Tube shape
		translate([tube_X_offset,tube_Y_offset,-tube_blend_length])
			cylinder(h=Delta*2,d=end_tube_OD, center=true);
	}
	// tube end
	translate([tube_X_offset,tube_Y_offset,-tube_blend_length-end_tube_length/2])
		cylinder(h=tube_len,d=end_tube_OD, center=true);
}

// Inner body of the tube and mating extensions to the Cannula section
module inner_tube (mold=false) {
	// if mold then add length
	tube_len = mold ? end_tube_length + mold_end_tube_buffer : end_tube_length;
	translate([0,0,Delta])
	hull() {
		// Cannula shape
		linear_extrude(height=Delta,convexity=6)
			offset(r=-cannula_thickness) {
				scale([cannula_scale, -cannula_scale, 1])
					polygon(Cannula_shape);
			}
		// to Tube shape
		translate([tube_X_offset,tube_Y_offset,-tube_blend_length-Delta*2])
			cylinder(h=Delta,d=end_tube_OD-end_tube_thickness*2, center=true);
	}
	// hole
	translate([tube_X_offset,tube_Y_offset,-tube_blend_length - end_tube_length/2])
		cylinder(h=tube_len,d=end_tube_OD-end_tube_thickness*2, center=true);
}

// Same module used for inner and outer Nares for Nostril tubes
module nare(dia, length) {
	cylinder(h=length, d=dia, center=true);
}

// Assemble Outer components to final shape
module Cannula_outer (length, mold=false) {
	// mold option adds to tube length
	// Outer 
	outer_body(length);
	// End tubes
	translate([0,0,-cannula_length/2])
		outer_tube(mold);
	translate([0,0,cannula_length/2])
	mirror([0,0,1])
		outer_tube(mold);
	// Nares
	translate([Nare_X_offset,Cannula_height/2-Delta,0])
	rotate([90,0,0]) {
		// Outer diameters
		translate([0,-septum_dist/2,-nasal_prong_length/2])
			nare(left_nare_OD, nasal_prong_length+Delta*2);
		translate([0,septum_dist/2,-nasal_prong_length/2])
			nare(right_nare_OD, nasal_prong_length+Delta*2);
	}
}

// Assemble Inner components to final shape
module Cannula_inner (length, mold=false) {
	// mold option adds to tube length
	// Inner
	inner_body(length);
	// end tubes
	translate([0,0,-cannula_length/2 - Delta*2])
		inner_tube(mold);
	translate([0,0,cannula_length/2 + Delta*2])
	mirror([0,0,1])
		inner_tube(mold);
	// Nare cores
	translate([Nare_X_offset,Cannula_height/2-Delta,0])
	rotate([90,0,0]) {
		// Inner diameters
		translate([0,-septum_dist/2,-nasal_prong_length/2])
			nare(left_nare_OD-nare_thickness*2, nasal_prong_length+cannula_thickness*2);
		translate([0,septum_dist/2,-nasal_prong_length/2])
			nare(right_nare_OD-nare_thickness*2, nasal_prong_length+cannula_thickness*2);
	}
}

// Construct final Cannula with Inner core subtracted from Outer shell.
// This is the full Cannula object.
module cannula_body (length, mold=false) {
	difference () {
		// Outer elements
		Cannula_outer(length, mold);
		// Inner elements
		Cannula_inner(length, mold);
		// Xsection cube for checking clearances
		if (show_Xsection) {
			translate([end_tube_OD + mold_end_tube_buffer,0,0]) 
			cube(size=[end_tube_OD*2 + mold_end_tube_buffer*2, end_tube_OD*2, cannula_length*2+Delta*2],center=true);	
		}
	}
}


// To make a mold:
//   - Build a mold block
//     - Subtract Sprues
//     - Subtract Cannula object
//   - Split mold block into two pieces
//   - Split inner core into components
//     - will need Nare cores and split core in half so can be pulled out of rubber positive.

module sprues() {
	// injection points (symmetrical)
	inj_point = cannula_length/2 + tube_blend_length + end_tube_length + mold_end_tube_buffer/2;
	rotate([90,0,0]) {
		translate([0,-inj_point, Cannula_height/2+end_tube_thickness])
			cylinder(h=Cannula_height, d=injection_port_dia, center=true);
		translate([0,inj_point, Cannula_height/2+end_tube_thickness])
			cylinder(h=Cannula_height, d=injection_port_dia, center=true);
	}
}

// Core mold block subracts Cannula and Sprues
module mold_block(length, block_len) {
	difference() {
		// block
		translate([-Cannula_height/2,-Cannula_height/2-nasal_prong_length-Delta, -block_len/2])
			cube(size=[Cannula_height, Cannula_height+nasal_prong_length*2, block_len]);
		// Cannula
		Cannula_outer(length, true);
		// Sprues
		sprues();
		// Xsection cube for checking clearances
		if (show_Xsection) {
			translate([end_tube_OD+Nare_X_offset/2,Cannula_height-end_tube_OD/2,0]) 
			 cube(size=[Cannula_height, Cannula_height+nasal_prong_length*2, block_len*1.4],center=true);	
		}
	}
}

// This shape is the dividing line between the two halves of the mold.
// Will be used to cut the mold block.
module mold_divider(length, block_length, block_width_adj = 0.0) {
	X_diff = Nare_X_offset - tube_X_offset;
	Y_diff = Cannula_height/2 - tube_Y_offset;
	rot = atan(X_diff / Y_diff);
	translate([0,-Cannula_height-Delta-block_width_adj/2,-block_length/2-Delta-block_width_adj/2])
		cube(size=[Cannula_height/2+Delta,Cannula_height+nasal_prong_length*2+block_width_adj, block_length+Delta*2+block_width_adj]);
	difference () {
		// angled part
		translate([tube_X_offset,tube_Y_offset,-block_length/2-Delta-block_width_adj/2])
		rotate([0,0,-rot])
			cube(size=[Cannula_height/2,Cannula_height*1.5, block_length+Delta*2+block_width_adj]);
		// nare part
		translate([Nare_X_offset-Cannula_height/2,Cannula_height/2-block_width_adj/2,-block_length/2-Delta-block_width_adj/2])
			cube(size=[Cannula_height/2,nasal_prong_length+block_width_adj,block_length+Delta*2+block_width_adj]);
	}
}

// One side of the external mold
module mold_A (length, block_len) {
	intersection() {
		mold_divider(length, block_len);
		mold_block(length, block_len);
	}
}

// The other side of the external mold
module mold_B (length, block_len) {
	difference() {
		mold_block(length, block_len); 
		mold_divider(length, block_len, 1);
	}
}


// Make a two part external mold
// and a split internal core 
module mold(length, disassemble=true) {
	block_len = cannula_length + (tube_blend_length+end_tube_length)*4;
	//mold_block(length, block_len); // for ref
	// Work out how to transform it for disassembly
	base90 = disassemble ? 90 : 0;
	base90neg = -base90*2;
	basetrans = disassemble ? Cannula_height*2 : 0;
	basetransneg = -basetrans*2;
	// Apply
	translate([0,basetrans,0])
	rotate([0,base90,0]) {
		mold_A(length, block_len);
		translate([0,basetransneg,0])
		rotate([0,base90neg,0])
			mold_B(length, block_len);
	}
	// The split core
	rotate([0,base90,0])
		Cannula_inner(length, true); //trim ends off, add Keys
}


///------------------------
//cannula_body(cannula_length);
// or 
mold(cannula_length);