/*
	Yet another design of LM8UU replacement
*/

// Outer diameter correction (mm). Positive values increase diameter.
bushingODCorrection = 0.0; // [-0.5:0.05:0.5]

// Inner diameter correction (mm).  Positive values increase diameter.
bushingIDCorrection = 0.0; // [-0.5:0.05:0.5]

// Bushing length (mm).
bushingLength = 24; // [5:1:50]

// Layer height (mm).
layerHeight = 0.2; // [0.05:0.01:1.0]

// Each subsequent layer is twisted on (degrees)
layerTwistAngle = 30; // [15, 30, 60]

// Sometimes it produces weird objects, so you can try different implementations to get desired.
implementation = 0; // [0:Fast, 1:Simple]

make();

module make() {
	
	bushingOD = 15 + bushingODCorrection;
	bushingID = 8 + bushingIDCorrection;

	if (implementation == 0) {
		bushing_fast(bushingOD, bushingID, bushingLength, layerHeight, layerTwistAngle);
	} else {
		bushing_simple(bushingOD, bushingID, bushingLength, layerHeight, layerTwistAngle);
	}
	//render() layer(15,8,0.2,0);

	// set of three with different angles
//	bushing_fast(bushingOD, bushingID, bushingLength, layerHeight, 60);
//	translate([20,0,0])  bushing_fast(bushingOD, bushingID, bushingLength, layerHeight, 15);
//	translate([0,20,0])  bushing_fast(bushingOD, bushingID, bushingLength, layerHeight, 30);
}

module bushing_fast(od = 15, id = 8, len = 24, lh = 0.2, lta = 30) {
	steps = floor(len / lh);
	steps_per_block = 120 / lta;
	blocks = floor(steps / steps_per_block);
	last_block_steps = steps % steps_per_block;
	echo(steps, steps_per_block, blocks, last_block_steps);
	union() {
//		render()
		for(b = [0: blocks-1]) {
//			render()
				translate([0, 0, b * steps_per_block * lh]) 
					block(od, id, lh, lta, steps_per_block);
		}
		if(last_block_steps > 0) {
//			render()
				translate([0, 0, (steps - last_block_steps) * lh])
					block(od, id, lh, lta, last_block_steps);
		}
	}
}

module block(od, id, lh, lta, steps) {
		for(i = [0: steps-1]) {
				li = lta * i ;
				translate([0, 0, i * lh])
					render() 
						layer(od, id, lh, li);
		}
	
}

module bushing_simple(od = 15, id = 8, len = 24, lh = 0.2, lta = 30) {
	union()
		for (i = [0: len/lh-1]) {
			li = lta * i %120;
			translate([0, 0, i * lh])
				render() layer(od, id, lh, li);
		}
}


module layer(od = 15, id = 8, lh = 0.2, twa=0) {
	difference()  {
			cylinder(d = od, h = lh, $fn = 48);
			rotate(a = twa, v = [0,0,1])
				//cylinder(r = id/2 /sin(30), h = lh, $fn = 3);
				// sin(30) = 1/2 so...
				cylinder(r = id, h = lh*2, $fn = 3);
	}
}

